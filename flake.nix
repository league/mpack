{
  description = "Utilities for encoding and decoding binary files in MIME";

  outputs = { self, nixpkgs, ... }:
    let
      eachSystem = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
    in {
      overlays.mpack-replacement-char = final: _prev: {
        mpack = final.stdenv.mkDerivation {
          pname = "mpack";
          version = "1.6";
          src = ./.;
          buildInputs = with final; [ autoconf automake ];
          preConfigure = "autoreconf -i -I cmulocal";
        };
      };

      packages = eachSystem (system: {
        mpack = (import nixpkgs {
          inherit system;
          overlays = [ self.overlays.mpack-replacement-char ];
        }).mpack;
      });

      apps = eachSystem (system: {
        munpack.type = "app";
        munpack.program = "${self.packages.${system}.mpack}/bin/munpack";
      });
    };
}
