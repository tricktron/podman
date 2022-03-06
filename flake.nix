{
  description = "podman-dev-shell";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [ "x86_64-darwin" "aarch64-darwin" "x86_64-linux" ] (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs;
            [
              go
              gopls
              gpgme
              (vscode-with-extensions.override
              {
                vscodeExtensions = with vscode-extensions;
                [
                  golang.go
                  jnoortheen.nix-ide
                  asvetliakov.vscode-neovim
                ];
              })
            ];
        };
      });
}
