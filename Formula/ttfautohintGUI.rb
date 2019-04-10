class Ttfautohintgui < Formula
  desc "Auto-hinter for TrueType fonts (GUI version)"
  homepage "https://www.freetype.org/ttfautohint/"
  url "https://downloads.sourceforge.net/project/freetype/ttfautohint/1.8.3/ttfautohint-1.8.3.tar.gz"
  sha256 "87bb4932571ad57536a7cc20b31fd15bc68cb5429977eb43d903fa61617cf87e"

  head do
    url "https://repo.or.cz/ttfautohint.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "bison" => :build
    depends_on "libtool" => :build
    depends_on "pkg-config" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "freetype"
  depends_on "harfbuzz"
  depends_on "libpng"
  depends_on "qt"

  def install
    args = %W[
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
      --without-doc
    ]

    ENV["QMAKESPEC"] = "macx-clang"
    system "./bootstrap" if build.head?
    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/ttfautohint", "-V"
    system "#{bin}/ttfautohintGUI", "-V"
  end
end
