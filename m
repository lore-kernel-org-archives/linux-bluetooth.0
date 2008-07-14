Return-Path: <cyrus@holtmann.org>
Message-ID: <b5c34db00807140342x40baaa59w593b512ab4964d59@mail.gmail.com>
Date: Mon, 14 Jul 2008 16:12:51 +0530
From: umeshyv <umeshyv@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] bluetooth compilation version3.36 -regarding
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1882343340=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1882343340==
Content-Type: multipart/alternative;
	boundary="----=_Part_61409_21860202.1216032171750"

------=_Part_61409_21860202.1216032171750
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi to all,
I started compiling bluetooth libs and utils version 3.36 ,I followed the
earlier methods but following are the errors,please rectify me where I am
going wrong and for version 3.32 I submitted the compilation errors and I am
stuck up with it.

Compiling Bluetooth libraries

>Apply Buildroot or Toolchain Path
>./configure --host=mipsel-linux --prefix=/usr --enable-shared=no
--enable-static=yes
>make
>make install DESTDIR=/home/newbuild/blue/bluez-libs-3.36/install

Compiling Bluetooth Utils

linux:/home/newbuild/blue/bluez-utils-3.36 # export BLUEZ_CFLAGS=-I
/home/newbuild/blue/bluez-libs-3.32/install/usr/include
linux:/home/newbuild/blue/bluez-utils-3.36 # export
BLUEZ_LIBS="-L/home/newbuild/blue/bluez-libs-3.32/install/usr/lib
-lbluetooth"
linux:/home/newbuild/blue/bluez-utils-3.36 # ./configure --host=mipsel-linux
--with-bluez=/home/newbuild/blue/bluez-libs-3.36/install/usr/
CPPFLAGS="-D__KERNEL__"
After configuration
configure: WARNING: If you wanted to set the --build type, don't use --host.
    If a cross compiler is detected then cross compile mode will be used.
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for a thread-safe mkdir -p... /bin/mkdir -p
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking for mipsel-linux-strip... mipsel-linux-strip
checking whether to enable maintainer-specific portions of Makefiles... no
checking for mipsel-linux-gcc... mipsel-linux-gcc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... yes
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether mipsel-linux-gcc accepts -g... yes
checking for mipsel-linux-gcc option to accept ISO C89... none needed
checking for style of include used by make... GNU
checking dependency style of mipsel-linux-gcc... gcc3
checking whether mipsel-linux-gcc accepts -fPIE... yes
checking for a BSD-compatible install... /usr/bin/install -c
checking for bison... bison -y
checking for flex... flex
checking lex output file root... lex.yy
checking lex library... none needed
checking whether yytext is a pointer... no
checking build system type... i686-pc-linux-gnu
checking host system type... mipsel-unknown-linux-gnu
checking for a sed that does not truncate output... /usr/bin/sed
checking for grep that handles long lines and -e... /usr/bin/grep
checking for egrep... /usr/bin/grep -E
checking for ld used by mipsel-linux-gcc...
/home/newbuild/buildroot/build_mipsel/staging_dir/mipsel-linux-uclibc/bin/ld
checking if the linker
(/home/newbuild/buildroot/build_mipsel/staging_dir/mipsel-linux-uclibc/bin/ld)
is GNU ld... yes
checking for
/home/newbuild/buildroot/build_mipsel/staging_dir/mipsel-linux-uclibc/bin/ld
option to reload object files... -r
checking for BSD-compatible nm...
/home/newbuild/buildroot/build_mipsel/staging_dir/bin/mipsel-linux-nm -B
checking whether ln -s works... yes
checking how to recognize dependent libraries... pass_all
checking how to run the C preprocessor... mipsel-linux-gcc -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking dlfcn.h usability... yes
checking dlfcn.h presence... yes
checking for dlfcn.h... yes
checking the maximum length of command line arguments... 98304
checking command to parse
/home/newbuild/buildroot/build_mipsel/staging_dir/bin/mipsel-linux-nm -B
output from mipsel-linux-gcc object... ok
checking for objdir... .libs
checking for mipsel-linux-ar... mipsel-linux-ar
checking for mipsel-linux-ranlib... mipsel-linux-ranlib
checking for mipsel-linux-strip... (cached) mipsel-linux-strip
checking if mipsel-linux-gcc supports -fno-rtti -fno-exceptions... no
checking for mipsel-linux-gcc option to produce PIC... -fPIC
checking if mipsel-linux-gcc PIC flag -fPIC works... yes
checking if mipsel-linux-gcc static flag -static works... yes
checking if mipsel-linux-gcc supports -c -o file.o... yes
checking whether the mipsel-linux-gcc linker
(/home/newbuild/buildroot/build_mipsel/staging_dir/mipsel-linux-uclibc/bin/ld)
supports shared libraries... yes
checking whether -lc should be explicitly linked in... no
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... no
configure: creating libtool
checking for ppoll... yes
checking for mipsel-linux-pkg-config... no
checking for pkg-config... /usr/bin/pkg-config
configure: WARNING: In the future, Autoconf will not detect cross-tools
whose name does not start with the host triplet.  If you think this
configuration is useful to you, please write to autoconf@gnu.org.
checking pkg-config is at least version 0.9.0... yes
checking for BLUEZ... yes
checking for GLIB... no
checking for GMODULE... no
checking for dlopen in -ldl... yes
checking for DBUS... no
configure: error: D-Bus library is required

linux:/home/newbuild/blue/bluez-utils-3.32 # make

linux:/home/newbuild/blue/bluez-utils-3.36 # make
make: *** No targets specified and no makefile found.  Stop.

Waiting for valuable suggestions

Thanks & Regards
Umesh

------=_Part_61409_21860202.1216032171750
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi to all,<br>I started compiling bluetooth libs and utils version 3.36 ,I followed the earlier methods but following are the errors,please rectify me where I am going wrong and for version 3.32 I submitted the compilation errors and I am stuck up with it.<br>
<br>Compiling Bluetooth libraries<br><br>&gt;Apply Buildroot or Toolchain Path<br>&gt;./configure --host=mipsel-linux --prefix=/usr --enable-shared=no --enable-static=yes<br>&gt;make<br>&gt;make install DESTDIR=/home/newbuild/blue/bluez-libs-3.36/install<br>
<br>Compiling Bluetooth Utils<br><br>linux:/home/newbuild/blue/bluez-utils-3.36 # export BLUEZ_CFLAGS=-I /home/newbuild/blue/bluez-libs-3.32/install/usr/include<br>linux:/home/newbuild/blue/bluez-utils-3.36 # export BLUEZ_LIBS=&quot;-L/home/newbuild/blue/bluez-libs-3.32/install/usr/lib -lbluetooth&quot;<br>
linux:/home/newbuild/blue/bluez-utils-3.36 # ./configure --host=mipsel-linux --with-bluez=/home/newbuild/blue/bluez-libs-3.36/install/usr/ CPPFLAGS=&quot;-D__KERNEL__&quot;<br>After configuration <br>configure: WARNING: If you wanted to set the --build type, don&#39;t use --host.<br>
&nbsp;&nbsp;&nbsp; If a cross compiler is detected then cross compile mode will be used.<br>checking for a BSD-compatible install... /usr/bin/install -c<br>checking whether build environment is sane... yes<br>checking for a thread-safe mkdir -p... /bin/mkdir -p<br>
checking for gawk... gawk<br>checking whether make sets $(MAKE)... yes<br>checking for mipsel-linux-strip... mipsel-linux-strip<br>checking whether to enable maintainer-specific portions of Makefiles... no<br>checking for mipsel-linux-gcc... mipsel-linux-gcc<br>
checking for C compiler default output file name... a.out<br>checking whether the C compiler works... yes<br>checking whether we are cross compiling... yes<br>checking for suffix of executables...<br>checking for suffix of object files... o<br>
checking whether we are using the GNU C compiler... yes<br>checking whether mipsel-linux-gcc accepts -g... yes<br>checking for mipsel-linux-gcc option to accept ISO C89... none needed<br>checking for style of include used by make... GNU<br>
checking dependency style of mipsel-linux-gcc... gcc3<br>checking whether mipsel-linux-gcc accepts -fPIE... yes<br>checking for a BSD-compatible install... /usr/bin/install -c<br>checking for bison... bison -y<br>checking for flex... flex<br>
checking lex output file root... lex.yy<br>checking lex library... none needed<br>checking whether yytext is a pointer... no<br>checking build system type... i686-pc-linux-gnu<br>checking host system type... mipsel-unknown-linux-gnu<br>
checking for a sed that does not truncate output... /usr/bin/sed<br>checking for grep that handles long lines and -e... /usr/bin/grep<br>checking for egrep... /usr/bin/grep -E<br>checking for ld used by mipsel-linux-gcc... /home/newbuild/buildroot/build_mipsel/staging_dir/mipsel-linux-uclibc/bin/ld<br>
checking if the linker (/home/newbuild/buildroot/build_mipsel/staging_dir/mipsel-linux-uclibc/bin/ld) is GNU ld... yes<br>checking for /home/newbuild/buildroot/build_mipsel/staging_dir/mipsel-linux-uclibc/bin/ld option to reload object files... -r<br>
checking for BSD-compatible nm... /home/newbuild/buildroot/build_mipsel/staging_dir/bin/mipsel-linux-nm -B<br>checking whether ln -s works... yes<br>checking how to recognize dependent libraries... pass_all<br>checking how to run the C preprocessor... mipsel-linux-gcc -E<br>
checking for ANSI C header files... yes<br>checking for sys/types.h... yes<br>checking for sys/stat.h... yes<br>checking for stdlib.h... yes<br>checking for string.h... yes<br>checking for memory.h... yes<br>checking for strings.h... yes<br>
checking for inttypes.h... yes<br>checking for stdint.h... yes<br>checking for unistd.h... yes<br>checking dlfcn.h usability... yes<br>checking dlfcn.h presence... yes<br>checking for dlfcn.h... yes<br>checking the maximum length of command line arguments... 98304<br>
checking command to parse /home/newbuild/buildroot/build_mipsel/staging_dir/bin/mipsel-linux-nm -B output from mipsel-linux-gcc object... ok<br>checking for objdir... .libs<br>checking for mipsel-linux-ar... mipsel-linux-ar<br>
checking for mipsel-linux-ranlib... mipsel-linux-ranlib<br>checking for mipsel-linux-strip... (cached) mipsel-linux-strip<br>checking if mipsel-linux-gcc supports -fno-rtti -fno-exceptions... no<br>checking for mipsel-linux-gcc option to produce PIC... -fPIC<br>
checking if mipsel-linux-gcc PIC flag -fPIC works... yes<br>checking if mipsel-linux-gcc static flag -static works... yes<br>checking if mipsel-linux-gcc supports -c -o file.o... yes<br>checking whether the mipsel-linux-gcc linker (/home/newbuild/buildroot/build_mipsel/staging_dir/mipsel-linux-uclibc/bin/ld) supports shared libraries... yes<br>
checking whether -lc should be explicitly linked in... no<br>checking dynamic linker characteristics... GNU/Linux ld.so<br>checking how to hardcode library paths into programs... immediate<br>checking whether stripping libraries is possible... yes<br>
checking if libtool supports shared libraries... yes<br>checking whether to build shared libraries... yes<br>checking whether to build static libraries... no<br>configure: creating libtool<br>checking for ppoll... yes<br>
checking for mipsel-linux-pkg-config... no<br>checking for pkg-config... /usr/bin/pkg-config<br>configure: WARNING: In the future, Autoconf will not detect cross-tools<br>whose name does not start with the host triplet.&nbsp; If you think this<br>
configuration is useful to you, please write to <a href="mailto:autoconf@gnu.org">autoconf@gnu.org</a>.<br>checking pkg-config is at least version <a href="http://0.9.0.">0.9.0.</a>.. yes<br>checking for BLUEZ... yes<br>checking for GLIB... no<br>
checking for GMODULE... no<br>checking for dlopen in -ldl... yes<br>checking for DBUS... no<br>configure: error: D-Bus library is required<br><br>linux:/home/newbuild/blue/bluez-utils-3.32 # make<br><br>linux:/home/newbuild/blue/bluez-utils-3.36 # make<br>
make: *** No targets specified and no makefile found.&nbsp; Stop.<br><br>Waiting for valuable suggestions<br><br>Thanks &amp; Regards<br>Umesh<br>

------=_Part_61409_21860202.1216032171750--


--===============1882343340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
--===============1882343340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1882343340==--
