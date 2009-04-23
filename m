Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 23 Apr 2009 12:37:43 +0530
Message-ID: <affb55530904230007r360d4941qc5e2329ad5b5af83@mail.gmail.com>
Subject: cross compiling bluez utils
From: kewal <kewal.deshpande@gmail.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

 I encountered this bluetooth header error, I just wanted to know what
modification in make file or bluez is necessary?
well,I am compiling for imx21 and using ltib


Processing: bluez-utils
=========================
rpmbuild --dbpath /opt/imx21_ida24/ltib-imx21ads-20070609/rpmdb
--define '_unpackaged_files_terminate_build 0' --define '_target_cpu
arm' --define '__strip strip' --define '_topdir
/opt/imx21_ida24/ltib-imx21ads-20070609/rpm' --define '_prefix /usr'
--define '_tmppath /opt/imx21_ida24/ltib-imx21ads-20070609/tmp'
--define '_mandir /usr/share/man' --define '_sysconfdir /etc' --define
'_localstatedir /var' -bc --short-circuit
/opt/imx21_ida24/ltib-imx21ads-20070609/dist/lfs-5.1/bluez-utils/bluez-utils.spec
Executing(%build): /bin/sh -e
/opt/imx21_ida24/ltib-imx21ads-20070609/tmp/rpm-tmp.24552
+ umask 022
+ cd /opt/imx21_ida24/ltib-imx21ads-20070609/rpm/BUILD
+ cd bluez-utils-2.25
+ ./configure --prefix=/usr --host=arm-linux --build=i686-pc-linux-gnu
checking for a BSD-compatible install... /usr/bin/install -c
.
.
.
.

checking for style of include used by make... GNU
checking dependency style of gcc... gcc3
checking whether gcc accepts -fPIE... no
checking for a BSD-compatible install... /usr/bin/install -c
checking for bison... bison -y
checking for flex... flex
checking for yywrap in -lfl... no
checking for yywrap in -ll... no
checking lex output file root... lex.yy
checking whether yytext is a pointer... no
checking build system type... i686-pc-linux-gnu
checking host system type... arm-unknown-linux-gnu
checking for a sed that does not truncate output... /bin/sed
checking for egrep... grep -E
checking for ld used by gcc... ld
checking if the linker (ld) is GNU ld... yes
checking for ld option to reload object files... -r
checking for BSD-compatible nm...
/opt/mtwk/usr/local/gcc-3.3.2-glibc-2.3.2/arm-linux/bin/arm-linux-nm
-B
checking whether ln -s works... yes
checking how to recognise dependent libraries... pass_all
checking how to run the C preprocessor... gcc -E
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
checking the maximum length of command line arguments... 32768
checking command to parse
/opt/mtwk/usr/local/gcc-3.3.2-glibc-2.3.2/arm-linux/bin/arm-linux-nm
-B output from gcc object... ok
checking for objdir... .libs
checking for arm-linux-ar... ar
checking for arm-linux-ranlib... arm-linux-ranlib
checking for arm-linux-strip... (cached) arm-linux-strip
checking if gcc supports -fno-rtti -fno-exceptions... no
checking for gcc option to produce PIC... -fPIC
checking if gcc PIC flag -fPIC works... yes
checking if gcc static flag -static works... yes
checking if gcc supports -c -o file.o... yes
checking whether the gcc linker (ld) supports shared libraries... yes
checking whether -lc should be explicitly linked in... no
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... no
configure: creating libtool
checking bluetooth/bluetooth.h usability... no
checking bluetooth/bluetooth.h presence... no
checking for bluetooth/bluetooth.h... no
configure: error: Bluetooth header files not found
error: Bad exit status from
/opt/imx21_ida24/ltib-imx21ads-20070609/tmp/rpm-tmp.24552 (%build)


RPM build errors:
    Bad exit status from
/opt/imx21_ida24/ltib-imx21ads-20070609/tmp/rpm-tmp.24552 (%build)
Build time for bluez-utils: 8 seconds

Failed building bluez-utils


-- 
Kewal
