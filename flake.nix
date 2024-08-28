{
  description = "Description for the project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [ glab gh starship fish tmux bun ];
          shellHook = ''
          export STARSHIP_CONFIG=$PWD/.config/starship.toml
          eval "$(starship init bash)"
          
          # Start tmux session
          SESSION_NAME="$(basename $PWD)"
          # Check if the session already exists
          if tmux has-session -t $SESSION_NAME 2>/dev/null; then
            echo "Session $SESSION_NAME already exists. Attaching to it."
            tmux attach-session -t $SESSION_NAME
          else
          # Create a new session and name it
            tmux new-session -d -s $SESSION_NAME
            # Attach to the created session
            tmux attach-session -t $SESSION_NAME
          fi
          '';
        };

        # devShells.another_env = pkgs.mkShell {
          # nativeBuildInputs = with pkgs; [ curl ];
        # };
      };

    };
}
