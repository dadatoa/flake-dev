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
          nativeBuildInputs = with pkgs; [ glab gh fish tmux ];
          # shellHook = ''
          # fish
          # '';
        };

        # devShells.another_env = pkgs.mkShell {
          # nativeBuildInputs = with pkgs; [ curl ];
        # };
      };

    };
}
