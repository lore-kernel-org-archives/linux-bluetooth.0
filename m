Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 2 Jan 2007 22:36:35 +0800 (CST)
From: KS H <kspam1234@yahoo.com.hk>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1167743937.30886.70.camel@violet>
MIME-Version: 1.0
Message-ID: <810747.71088.qm@web53303.mail.yahoo.com>
Subject: [Bluez-users] =?big5?q?Re=A1G=20Re:=20=20Dbus=20lib?=
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2086073380=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============2086073380==
Content-Type: multipart/alternative; boundary="0-766490042-1167748595=:71088"
Content-Transfer-Encoding: 8bit

--0-766490042-1167748595=:71088
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8bit

Hi 

need to correct the information in pervious mail
the error "cannot find -ldbus-glib-1" is found in bluez-util-3.7
(1st log)

However there still a error " cannot find -ldbus-1" found in bluez-util3.8
(2nd log)
This is the configuration and make log:

******************************************************************
[user1@localhost bluez-utils-3.7]$ ./configure CC=arm-linux-gnu-gcc PKG_CONFIG_PATH=/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/lib/pkgconfig --host=arm-linux-gnu --prefix=$PWD/utils --exec-prefix=$PWD/utils/exec --libdir=/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/lib --includedir=/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include --with-bluez=/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/lib
configure: WARNING: If you wanted to set the --build type, don't use --host.
    If a cross compiler is detected then cross compile mode will be used.
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking for arm-linux-gnu-strip... arm-linux-gnu-strip
checking whether to enable maintainer-specific portions of Makefiles... no
checking for arm-linux-gnu-gcc... arm-linux-gnu-gcc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... yes
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether arm-linux-gnu-gcc accepts -g... yes
checking for arm-linux-gnu-gcc option to accept ANSI C... none needed
checking for style of include used by make... GNU
checking dependency style of arm-linux-gnu-gcc... gcc3
checking whether arm-linux-gnu-gcc accepts -fPIE... yes
checking for a BSD-compatible install... /usr/bin/install -c
checking for bison... bison -y
checking for flex... flex
checking for yywrap in -lfl... no
checking for yywrap in -ll... no
checking lex output file root... lex.yy
checking whether yytext is a pointer... no
checking build system type... i686-redhat-linux-gnu
checking host system type... arm-unknown-linux-gnu
checking for a sed that does not truncate output... /bin/sed
checking for egrep... grep -E
checking for ld used by arm-linux-gnu-gcc... /usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/bin/ld
checking if the linker (/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/bin/ld) is GNU ld... yes
checking for /usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/bin/ld option to reload object files... -r
checking for BSD-compatible nm... /usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/bin//arm-linux-gnu-nm -B
checking whether ln -s works... yes
checking how to recognise dependent libraries... pass_all
checking how to run the C preprocessor... arm-linux-gnu-gcc -E
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
checking command to parse /usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/bin//arm-linux-gnu-nm -B output from arm-linux-gnu-gcc object... ok
checking for objdir... .libs
checking for arm-linux-gnu-ar... arm-linux-gnu-ar
checking for arm-linux-gnu-ranlib... arm-linux-gnu-ranlib
checking for arm-linux-gnu-strip... (cached) arm-linux-gnu-strip
checking if arm-linux-gnu-gcc supports -fno-rtti -fno-exceptions... no
checking for arm-linux-gnu-gcc option to produce PIC... -fPIC
checking if arm-linux-gnu-gcc PIC flag -fPIC works... yes
checking if arm-linux-gnu-gcc static flag -static works... yes
checking if arm-linux-gnu-gcc supports -c -o file.o... yes
checking whether the arm-linux-gnu-gcc linker (/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/bin/ld) supports shared libraries... yes
checking whether -lc should be explicitly linked in... no
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... no
configure: creating libtool
checking for ppoll... no
checking for arm-linux-gnu-pkg-config... no
checking for pkg-config... /usr/bin/pkg-config
checking pkg-config is at least version 0.9.0... yes
checking for BLUEZ...yes
checking for DBUS... yes
checking for GLIB... yes
checking for OPENOBEX... no
checking for FUSE... no
checking for ALSA... yes
checking for USB... yes
checking for usb_get_busses in -lusb... no
checking for usb_interrupt_read in -lusb... no
configure: creating ./config.status
config.status: creating Makefile
config.status: creating common/Makefile
config.status: creating daemon/Makefile
config.status: creating tools/Makefile
config.status: creating rfcomm/Makefile
config.status: creating hcid/Makefile
config.status: creating sdpd/Makefile
config.status: creating dund/Makefile
config.status: creating pand/Makefile
config.status: creating hidd/Makefile
config.status: creating cups/Makefile
config.status: creating fuse/Makefile
config.status: creating alsa/Makefile
config.status: creating test/Makefile
config.status: creating scripts/Makefile
config.status: creating config.h
config.status: config.h is unchanged
config.status: executing depfiles commands
[user1@localhost bluez-utils-3.7]$ make
make  all-recursive
make[1]: Entering directory `/home/user1/test/code/bluez3.7/bluez-utils-3.7'
Making all in common
make[2]: Entering directory `/home/user1/test/code/bluez3.7/bluez-utils-3.7/common'
make[2]: Nothing to be done for `all'.
make[2]: Leaving directory `/home/user1/test/code/bluez3.7/bluez-utils-3.7/common'
Making all in daemon
make[2]: Entering directory `/home/user1/test/code/bluez3.7/bluez-utils-3.7/daemon'
/bin/sh ../libtool --tag=CC --mode=link arm-linux-gnu-gcc -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include   -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include -I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include   -Wall -O2 -D_FORTIFY_SOURCE=2   -o bluetoothd  main.o -ldbus-glib-1 -ldbus-1 -lglib-2.0   -L/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/lib -lbluetooth   ../common/libhelper.a
arm-linux-gnu-gcc -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include -I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include -Wall -O2 -D_FORTIFY_SOURCE=2 -o bluetoothd main.o  -ldbus-glib-1 -ldbus-1 -lglib-2.0 -L/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/lib /usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/lib/libbluetooth.so ../common/libhelper.a -Wl,--rpath -Wl,/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/lib -Wl,--rpath -Wl,/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/lib
/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/lib/gcc/arm-linux-gnu/3.4.4/../../../../arm-linux-gnu/bin/ld: cannot find -ldbus-glib-1
collect2: ld returned 1 exit status
make[2]: *** [bluetoothd] Error 1
make[2]: Leaving directory `/home/user1/test/code/bluez3.7/bluez-utils-3.7/daemon'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/user1/test/code/bluez3.7/bluez-utils-3.7'
make: *** [all] Error 2

**********************************************************************************************

Bluez-util-3.8 log
**********************************************************************************************
[user1@localhost bluez-utils-3.8]$ ./configure CC=arm-linux-gnu-gcc PKG_CONFIG_PATH=/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/lib/pkgconfig --host=arm-linux-gnu --prefix=$PWD/utils --exec-prefix=$PWD/utils/exec --libdir=/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/lib --includedir=/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include --with-bluez=/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/lib

configure: WARNING: If you wanted to set the --build type, don't use --host.
    If a cross compiler is detected then cross compile mode will be used.
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking for arm-linux-gnu-strip... arm-linux-gnu-strip
checking whether to enable maintainer-specific portions of Makefiles... no
checking for arm-linux-gnu-gcc... arm-linux-gnu-gcc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... yes
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether arm-linux-gnu-gcc accepts -g... yes
checking for arm-linux-gnu-gcc option to accept ANSI C... none needed
checking for style of include used by make... GNU
checking dependency style of arm-linux-gnu-gcc... gcc3
checking whether arm-linux-gnu-gcc accepts -fPIE... yes
checking for a BSD-compatible install... /usr/bin/install -c
checking for bison... bison -y
checking for flex... flex
checking for yywrap in -lfl... no
checking for yywrap in -ll... no
checking lex output file root... lex.yy
checking whether yytext is a pointer... no
checking build system type... i686-redhat-linux-gnu
checking host system type... arm-unknown-linux-gnu
checking for a sed that does not truncate output... /bin/sed
checking for egrep... grep -E
checking for ld used by arm-linux-gnu-gcc... /usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/bin/ld
checking if the linker (/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/bin/ld) is GNU ld... yes
checking for /usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/bin/ld option to reload object files... -r
checking for BSD-compatible nm... /usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/bin//arm-linux-gnu-nm -B
checking whether ln -s works... yes
checking how to recognise dependent libraries... pass_all
checking how to run the C preprocessor... arm-linux-gnu-gcc -E
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
checking command to parse /usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/bin//arm-linux-gnu-nm -B output from arm-linux-gnu-gcc object... ok
checking for objdir... .libs
checking for arm-linux-gnu-ar... arm-linux-gnu-ar
checking for arm-linux-gnu-ranlib... arm-linux-gnu-ranlib
checking for arm-linux-gnu-strip... (cached) arm-linux-gnu-strip
checking if arm-linux-gnu-gcc supports -fno-rtti -fno-exceptions... no
checking for arm-linux-gnu-gcc option to produce PIC... -fPIC
checking if arm-linux-gnu-gcc PIC flag -fPIC works... yes
checking if arm-linux-gnu-gcc static flag -static works... yes
checking if arm-linux-gnu-gcc supports -c -o file.o... yes
checking whether the arm-linux-gnu-gcc linker (/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/bin/ld) supports shared libraries... yes
checking whether -lc should be explicitly linked in... no
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... no
configure: creating libtool
checking for ppoll... no
checking for arm-linux-gnu-pkg-config... no
checking for pkg-config... /usr/bin/pkg-config
checking pkg-config is at least version 0.9.0... yes
checking for BLUEZ... yes
checking for DBUS... yes
checking for GLIB... yes
checking for OPENOBEX... no
no
checking for OPENSYNC... no
no
checking for GSTREAMER... no
no
checking for FUSE... no
no
checking for ALSA... yes
checking for USB... yes
checking for usb_get_busses in -lusb... no
checking for usb_interrupt_read in -lusb... no
checking for XML_ParserCreate_MM in -lexpat... no
checking expat.h usability... no
checking expat.h presence... no
checking for expat.h... no
configure: creating ./config.status
config.status: creating Makefile
config.status: creating common/Makefile
config.status: creating daemon/Makefile
config.status: creating network/Makefile
config.status: creating input/Makefile
config.status: creating audio/Makefile
config.status: creating sync/Makefile
config.status: creating tools/Makefile
config.status: creating rfcomm/Makefile
config.status: creating hcid/Makefile
config.status: creating sdpd/Makefile
config.status: creating dund/Makefile
config.status: creating pand/Makefile
config.status: creating hidd/Makefile
config.status: creating cups/Makefile
config.status: creating fuse/Makefile
config.status: creating alsa/Makefile
config.status: creating test/Makefile
config.status: creating scripts/Makefile
config.status: creating config.h
config.status: executing depfiles commands
[user1@localhost bluez-utils-3.8]$ make
make  all-recursive
make[1]: Entering directory `/home/user1/test/code/bluez3.8/bluez-utils-3.8'
Making all in common
make[2]: Entering directory `/home/user1/test/code/bluez3.8/bluez-utils-3.8/common'
if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I..    -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT oui.o -MD -MP -MF ".deps/oui.Tpo" -c -o oui.o oui.c; \
then mv -f ".deps/oui.Tpo" ".deps/oui.Po"; else rm -f ".deps/oui.Tpo"; exit 1; fi
if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I..    -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT list.o -MD -MP -MF ".deps/list.Tpo" -c -o list.o list.c; \
then mv -f ".deps/list.Tpo" ".deps/list.Po"; else rm -f ".deps/list.Tpo"; exit 1; fi
if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I..    -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT textfile.o -MD -MP -MF ".deps/textfile.Tpo" -c -o textfile.o textfile.c; \
then mv -f ".deps/textfile.Tpo" ".deps/textfile.Po"; else rm -f ".deps/textfile.Tpo"; exit 1; fi
if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I..    -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT helper.o -MD -MP -MF ".deps/helper.Tpo" -c -o helper.o helper.c; \
then mv -f ".deps/helper.Tpo" ".deps/helper.Po"; else rm -f ".deps/helper.Tpo"; exit 1; fi
if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I..    -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT glib-ectomy.o -MD -MP -MF ".deps/glib-ectomy.Tpo" -c -o glib-ectomy.o glib-ectomy.c; \
then mv -f ".deps/glib-ectomy.Tpo" ".deps/glib-ectomy.Po"; else rm -f ".deps/glib-ectomy.Tpo"; exit 1; fi
if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I..    -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT logging.o -MD -MP -MF ".deps/logging.Tpo" -c -o logging.o logging.c; \
then mv -f ".deps/logging.Tpo" ".deps/logging.Po"; else rm -f ".deps/logging.Tpo"; exit 1; fi
if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I..    -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT dbus.o -MD -MP -MF ".deps/dbus.Tpo" -c -o dbus.o dbus.c; \
then mv -f ".deps/dbus.Tpo" ".deps/dbus.Po"; else rm -f ".deps/dbus.Tpo"; exit 1; fi
if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I..    -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT sdp-xml.o -MD -MP -MF ".deps/sdp-xml.Tpo" -c -o sdp-xml.o sdp-xml.c; \
then mv -f ".deps/sdp-xml.Tpo" ".deps/sdp-xml.Po"; else rm -f ".deps/sdp-xml.Tpo"; exit 1; fi
if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I..    -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT sdp-dummy.o -MD -MP -MF ".deps/sdp-dummy.Tpo" -c -o sdp-dummy.o sdp-dummy.c; \
then mv -f ".deps/sdp-dummy.Tpo" ".deps/sdp-dummy.Po"; else rm -f ".deps/sdp-dummy.Tpo"; exit 1; fi
sdp-dummy.c: In function `sdp_xml_parse_record':
sdp-dummy.c:38: warning: return makes pointer from integer without a cast
rm -f libhelper.a
arm-linux-gnu-ar cru libhelper.a oui.o list.o textfile.o helper.o glib-ectomy.o logging.o dbus.o sdp-xml.o sdp-dummy.o
arm-linux-gnu-ranlib libhelper.a
if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I..    -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT test_textfile.o -MD -MP -MF ".deps/test_textfile.Tpo" -c -o test_textfile.o test_textfile.c; \
then mv -f ".deps/test_textfile.Tpo" ".deps/test_textfile.Po"; else rm -f ".deps/test_textfile.Tpo"; exit 1; fi
/bin/sh ../libtool --tag=CC --mode=link arm-linux-gnu-gcc -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2   -o test_textfile  test_textfile.o libhelper.a
mkdir .libs
arm-linux-gnu-gcc -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -o test_textfile test_textfile.o  libhelper.a
make[2]: Leaving directory `/home/user1/test/code/bluez3.8/bluez-utils-3.8/common'
Making all in hcid
make[2]: Entering directory `/home/user1/test/code/bluez3.8/bluez-utils-3.8/hcid'
make  all-am
make[3]: Entering directory `/home/user1/test/code/bluez3.8/bluez-utils-3.8/hcid'
if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common   -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include   -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT security.o -MD -MP -MF ".deps/security.Tpo" -c -o security.o security.c; \
then mv -f ".deps/security.Tpo" ".deps/security.Po"; else rm -f ".deps/security.Tpo"; exit 1; fi
if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common   -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include   -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT device.o -MD -MP -MF ".deps/device.Tpo" -c -o device.o device.c; \
then mv -f ".deps/device.Tpo" ".deps/device.Po"; else rm -f ".deps/device.Tpo"; exit 1; fi
if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common   -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include   -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT storage.o -MD -MP -MF ".deps/storage.Tpo" -c -o storage.o storage.c; \
then mv -f ".deps/storage.Tpo" ".deps/storage.Po"; else rm -f ".deps/storage.Tpo"; exit 1; fi
if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common   -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include   -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT sdp.o -MD -MP -MF ".deps/sdp.Tpo" -c -o sdp.o sdp.c; \
then mv -f ".deps/sdp.Tpo" ".deps/sdp.Po"; else rm -f ".deps/sdp.Tpo"; exit 1; fi
if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common   -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include   -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT parser.o -MD -MP -MF ".deps/parser.Tpo" -c -o parser.o parser.c; \
then mv -f ".deps/parser.Tpo" ".deps/parser.Po"; else rm -f ".deps/parser.Tpo"; exit 1; fi
if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common   -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include   -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT lexer.o -MD -MP -MF ".deps/lexer.Tpo" -c -o lexer.o lexer.c; \
then mv -f ".deps/lexer.Tpo" ".deps/lexer.Po"; else rm -f ".deps/lexer.Tpo"; exit 1; fi
lexer.c:1183: warning: 'yyunput' defined but not used
if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common   -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include   -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT kword.o -MD -MP -MF ".deps/kword.Tpo" -c -o kword.o kword.c; \
then mv -f ".deps/kword.Tpo" ".deps/kword.Po"; else rm -f ".deps/kword.Tpo"; exit 1; fi
if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common   -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include   -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT dbus-hci.o -MD -MP -MF ".deps/dbus-hci.Tpo" -c -o dbus-hci.o dbus-hci.c; \
then mv -f ".deps/dbus-hci.Tpo" ".deps/dbus-hci.Po"; else rm -f ".deps/dbus-hci.Tpo"; exit 1; fi
if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common   -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include   -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT dbus-common.o -MD -MP -MF ".deps/dbus-common.Tpo" -c -o dbus-common.o dbus-common.c; \
then mv -f ".deps/dbus-common.Tpo" ".deps/dbus-common.Po"; else rm -f ".deps/dbus-common.Tpo"; exit 1; fi
if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common   -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include   -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT dbus-error.o -MD -MP -MF ".deps/dbus-error.Tpo" -c -o dbus-error.o dbus-error.c; \
then mv -f ".deps/dbus-error.Tpo" ".deps/dbus-error.Po"; else rm -f ".deps/dbus-error.Tpo"; exit 1; fi
if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common   -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include   -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT dbus-manager.o -MD -MP -MF ".deps/dbus-manager.Tpo" -c -o dbus-manager.o dbus-manager.c; \
then mv -f ".deps/dbus-manager.Tpo" ".deps/dbus-manager.Po"; else rm -f ".deps/dbus-manager.Tpo"; exit 1; fi
if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common   -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include   -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT dbus-adapter.o -MD -MP -MF ".deps/dbus-adapter.Tpo" -c -o dbus-adapter.o dbus-adapter.c; \
then mv -f ".deps/dbus-adapter.Tpo" ".deps/dbus-adapter.Po"; else rm -f ".deps/dbus-adapter.Tpo"; exit 1; fi
if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common   -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include   -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT dbus-device.o -MD -MP -MF ".deps/dbus-device.Tpo" -c -o dbus-device.o dbus-device.c; \
then mv -f ".deps/dbus-device.Tpo" ".deps/dbus-device.Po"; else rm -f ".deps/dbus-device.Tpo"; exit 1; fi
if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common   -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include   -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT dbus-service.o -MD -MP -MF ".deps/dbus-service.Tpo" -c -o dbus-service.o dbus-service.c; \
then mv -f ".deps/dbus-service.Tpo" ".deps/dbus-service.Po"; else rm -f ".deps/dbus-service.Tpo"; exit 1; fi
if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common   -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include   -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT dbus-security.o -MD -MP -MF ".deps/dbus-security.Tpo" -c -o dbus-security.o dbus-security.c; \
then mv -f ".deps/dbus-security.Tpo" ".deps/dbus-security.Po"; else rm -f ".deps/dbus-security.Tpo"; exit 1; fi
if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common   -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include   -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT dbus-sdp.o -MD -MP -MF ".deps/dbus-sdp.Tpo" -c -o dbus-sdp.o dbus-sdp.c; \
then mv -f ".deps/dbus-sdp.Tpo" ".deps/dbus-sdp.Po"; else rm -f ".deps/dbus-sdp.Tpo"; exit 1; fi
if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common   -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include   -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT dbus-rfcomm.o -MD -MP -MF ".deps/dbus-rfcomm.Tpo" -c -o dbus-rfcomm.o dbus-rfcomm.c; \
then mv -f ".deps/dbus-rfcomm.Tpo" ".deps/dbus-rfcomm.Po"; else rm -f ".deps/dbus-rfcomm.Tpo"; exit 1; fi
if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common   -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include   -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT dbus-test.o -MD -MP -MF ".deps/dbus-test.Tpo" -c -o dbus-test.o dbus-test.c; \
then mv -f ".deps/dbus-test.Tpo" ".deps/dbus-test.Po"; else rm -f ".deps/dbus-test.Tpo"; exit 1; fi
rm -f libhciserver.a
arm-linux-gnu-ar cru libhciserver.a security.o device.o storage.o sdp.o parser.o lexer.o kword.o dbus-hci.o dbus-common.o dbus-error.o dbus-manager.o dbus-adapter.o dbus-device.o dbus-service.o dbus-security.o dbus-sdp.o dbus-rfcomm.o dbus-test.o
arm-linux-gnu-ranlib libhciserver.a
if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common   -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include   -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT passkey-agent.o -MD -MP -MF ".deps/passkey-agent.Tpo" -c -o passkey-agent.o passkey-agent.c; \
then mv -f ".deps/passkey-agent.Tpo" ".deps/passkey-agent.Po"; else rm -f ".deps/passkey-agent.Tpo"; exit 1; fi
/bin/sh ../libtool --tag=CC --mode=link arm-linux-gnu-gcc -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include   -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2   -o passkey-agent passkey-agent.o -ldbus-1
mkdir .libs
arm-linux-gnu-gcc -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -o passkey-agent passkey-agent.o  -ldbus-1
/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/lib/gcc/arm-linux-gnu/3.4.4/../../../../arm-linux-gnu/bin/ld: cannot find -ldbus-1
collect2: ld returned 1 exit status
make[3]: *** [passkey-agent] Error 1
make[3]: Leaving directory `/home/user1/test/code/bluez3.8/bluez-utils-3.8/hcid'
make[2]: *** [all] Error 2
make[2]: Leaving directory `/home/user1/test/code/bluez3.8/bluez-utils-3.8/hcid'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/user1/test/code/bluez3.8/bluez-utils-3.8'
make: *** [all] Error 2
********************************************************************************************
Thank you for helping

Regards

Marcel Holtmann <marcel@holtmann.org> 說： Hi,

> I try to make the bluez-utils-3.8 after the configuration was done.
> However I got the error "cannot find -ldbus-glib-1" during when make
> the utils tools.  I have installed dbus. however not dbus-glib. 

you actually don't need it. This is for some future stuff and it will be
disabled if configure doesn't find it. Otherwise it is a bug. Please
show us the exact error messages.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


 _______________________________________
 YM - 離線訊息
 就算你沒有上網，你的朋友仍可以留下訊息給你，當你上網時就能立即看到，任何說話都冇走失。
 http://messenger.yahoo.com.hk
--0-766490042-1167748595=:71088
Content-Type: text/html; charset=big5
Content-Transfer-Encoding: 8bit

Hi <br><br>need to correct the information in pervious mail<br>the error "cannot find -ldbus-glib-1" is found in bluez-util-3.7<br>(1st log)<br><br>However there still a error " cannot find -ldbus-1" found in bluez-util3.8<br>(2nd log)<br>This is the configuration and make log:<br><br>******************************************************************<br>[user1@localhost bluez-utils-3.7]$ ./configure CC=arm-linux-gnu-gcc PKG_CONFIG_PATH=/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/lib/pkgconfig --host=arm-linux-gnu --prefix=$PWD/utils --exec-prefix=$PWD/utils/exec --libdir=/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/lib --includedir=/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include --with-bluez=/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/lib<br>configure: WARNING: If you wanted to set the --build type, don't use
 --host.<br>&nbsp;&nbsp;&nbsp; If a cross compiler is detected then cross compile mode will be used.<br>checking for a BSD-compatible install... /usr/bin/install -c<br>checking whether build environment is sane... yes<br>checking for gawk... gawk<br>checking whether make sets $(MAKE)... yes<br>checking for arm-linux-gnu-strip... arm-linux-gnu-strip<br>checking whether to enable maintainer-specific portions of Makefiles... no<br>checking for arm-linux-gnu-gcc... arm-linux-gnu-gcc<br>checking for C compiler default output file name... a.out<br>checking whether the C compiler works... yes<br>checking whether we are cross compiling... yes<br>checking for suffix of executables...<br>checking for suffix of object files... o<br>checking whether we are using the GNU C compiler... yes<br>checking whether arm-linux-gnu-gcc accepts -g... yes<br>checking for arm-linux-gnu-gcc option to accept ANSI C... none needed<br>checking for style of include used by make... GNU<br>checking
 dependency style of arm-linux-gnu-gcc... gcc3<br>checking whether arm-linux-gnu-gcc accepts -fPIE... yes<br>checking for a BSD-compatible install... /usr/bin/install -c<br>checking for bison... bison -y<br>checking for flex... flex<br>checking for yywrap in -lfl... no<br>checking for yywrap in -ll... no<br>checking lex output file root... lex.yy<br>checking whether yytext is a pointer... no<br>checking build system type... i686-redhat-linux-gnu<br>checking host system type... arm-unknown-linux-gnu<br>checking for a sed that does not truncate output... /bin/sed<br>checking for egrep... grep -E<br>checking for ld used by arm-linux-gnu-gcc... /usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/bin/ld<br>checking if the linker (/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/bin/ld) is GNU ld... yes<br>checking for /usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/bin/ld option to reload
 object files... -r<br>checking for BSD-compatible nm... /usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/bin//arm-linux-gnu-nm -B<br>checking whether ln -s works... yes<br>checking how to recognise dependent libraries... pass_all<br>checking how to run the C preprocessor... arm-linux-gnu-gcc -E<br>checking for ANSI C header files... yes<br>checking for sys/types.h... yes<br>checking for sys/stat.h... yes<br>checking for stdlib.h... yes<br>checking for string.h... yes<br>checking for memory.h... yes<br>checking for strings.h... yes<br>checking for inttypes.h... yes<br>checking for stdint.h... yes<br>checking for unistd.h... yes<br>checking dlfcn.h usability... yes<br>checking dlfcn.h presence... yes<br>checking for dlfcn.h... yes<br>checking the maximum length of command line arguments... 32768<br>checking command to parse /usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/bin//arm-linux-gnu-nm -B output from arm-linux-gnu-gcc object...
 ok<br>checking for objdir... .libs<br>checking for arm-linux-gnu-ar... arm-linux-gnu-ar<br>checking for arm-linux-gnu-ranlib... arm-linux-gnu-ranlib<br>checking for arm-linux-gnu-strip... (cached) arm-linux-gnu-strip<br>checking if arm-linux-gnu-gcc supports -fno-rtti -fno-exceptions... no<br>checking for arm-linux-gnu-gcc option to produce PIC... -fPIC<br>checking if arm-linux-gnu-gcc PIC flag -fPIC works... yes<br>checking if arm-linux-gnu-gcc static flag -static works... yes<br>checking if arm-linux-gnu-gcc supports -c -o file.o... yes<br>checking whether the arm-linux-gnu-gcc linker (/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/bin/ld) supports shared libraries... yes<br>checking whether -lc should be explicitly linked in... no<br>checking dynamic linker characteristics... GNU/Linux ld.so<br>checking how to hardcode library paths into programs... immediate<br>checking whether stripping libraries is possible... yes<br>checking if
 libtool supports shared libraries... yes<br>checking whether to build shared libraries... yes<br>checking whether to build static libraries... no<br>configure: creating libtool<br>checking for ppoll... no<br>checking for arm-linux-gnu-pkg-config... no<br>checking for pkg-config... /usr/bin/pkg-config<br>checking pkg-config is at least version 0.9.0... yes<br>checking for BLUEZ...yes<br>checking for DBUS... yes<br>checking for GLIB... yes<br>checking for OPENOBEX... no<br>checking for FUSE... no<br>checking for ALSA... yes<br>checking for USB... yes<br>checking for usb_get_busses in -lusb... no<br>checking for usb_interrupt_read in -lusb... no<br>configure: creating ./config.status<br>config.status: creating Makefile<br>config.status: creating common/Makefile<br>config.status: creating daemon/Makefile<br>config.status: creating tools/Makefile<br>config.status: creating rfcomm/Makefile<br>config.status: creating hcid/Makefile<br>config.status: creating
 sdpd/Makefile<br>config.status: creating dund/Makefile<br>config.status: creating pand/Makefile<br>config.status: creating hidd/Makefile<br>config.status: creating cups/Makefile<br>config.status: creating fuse/Makefile<br>config.status: creating alsa/Makefile<br>config.status: creating test/Makefile<br>config.status: creating scripts/Makefile<br>config.status: creating config.h<br>config.status: config.h is unchanged<br>config.status: executing depfiles commands<br>[user1@localhost bluez-utils-3.7]$ make<br>make&nbsp; all-recursive<br>make[1]: Entering directory `/home/user1/test/code/bluez3.7/bluez-utils-3.7'<br>Making all in common<br>make[2]: Entering directory `/home/user1/test/code/bluez3.7/bluez-utils-3.7/common'<br>make[2]: Nothing to be done for `all'.<br>make[2]: Leaving directory `/home/user1/test/code/bluez3.7/bluez-utils-3.7/common'<br>Making all in daemon<br>make[2]: Entering directory `/home/user1/test/code/bluez3.7/bluez-utils-3.7/daemon'<br>/bin/sh
 ../libtool --tag=CC --mode=link arm-linux-gnu-gcc -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include&nbsp;&nbsp; -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include -I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include&nbsp;&nbsp; -Wall -O2 -D_FORTIFY_SOURCE=2&nbsp;&nbsp; -o bluetoothd&nbsp; main.o -ldbus-glib-1 -ldbus-1 -lglib-2.0&nbsp;&nbsp; -L/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/lib -lbluetooth&nbsp;&nbsp; ../common/libhelper.a<br>arm-linux-gnu-gcc -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include -I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include -Wall -O2 -D_FORTIFY_SOURCE=2 -o bluetoothd main.o&nbsp; -ldbus-glib-1 -ldbus-1 -lglib-2.0 -L/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/lib
 /usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/lib/libbluetooth.so ../common/libhelper.a -Wl,--rpath -Wl,/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/lib -Wl,--rpath -Wl,/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/lib<br>/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/lib/gcc/arm-linux-gnu/3.4.4/../../../../arm-linux-gnu/bin/ld: cannot find -ldbus-glib-1<br>collect2: ld returned 1 exit status<br>make[2]: *** [bluetoothd] Error 1<br>make[2]: Leaving directory `/home/user1/test/code/bluez3.7/bluez-utils-3.7/daemon'<br>make[1]: *** [all-recursive] Error 1<br>make[1]: Leaving directory `/home/user1/test/code/bluez3.7/bluez-utils-3.7'<br>make: *** [all] Error 2<br><br>**********************************************************************************************<br><br>Bluez-util-3.8
 log<br>**********************************************************************************************<br>[user1@localhost bluez-utils-3.8]$ ./configure CC=arm-linux-gnu-gcc PKG_CONFIG_PATH=/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/lib/pkgconfig --host=arm-linux-gnu --prefix=$PWD/utils --exec-prefix=$PWD/utils/exec --libdir=/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/lib --includedir=/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include --with-bluez=/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/lib<br><br>configure: WARNING: If you wanted to set the --build type, don't use --host.<br>&nbsp;&nbsp;&nbsp; If a cross compiler is detected then cross compile mode will be used.<br>checking for a BSD-compatible install... /usr/bin/install -c<br>checking whether build environment is sane... yes<br>checking for gawk... gawk<br>checking whether make
 sets $(MAKE)... yes<br>checking for arm-linux-gnu-strip... arm-linux-gnu-strip<br>checking whether to enable maintainer-specific portions of Makefiles... no<br>checking for arm-linux-gnu-gcc... arm-linux-gnu-gcc<br>checking for C compiler default output file name... a.out<br>checking whether the C compiler works... yes<br>checking whether we are cross compiling... yes<br>checking for suffix of executables...<br>checking for suffix of object files... o<br>checking whether we are using the GNU C compiler... yes<br>checking whether arm-linux-gnu-gcc accepts -g... yes<br>checking for arm-linux-gnu-gcc option to accept ANSI C... none needed<br>checking for style of include used by make... GNU<br>checking dependency style of arm-linux-gnu-gcc... gcc3<br>checking whether arm-linux-gnu-gcc accepts -fPIE... yes<br>checking for a BSD-compatible install... /usr/bin/install -c<br>checking for bison... bison -y<br>checking for flex... flex<br>checking for yywrap in -lfl...
 no<br>checking for yywrap in -ll... no<br>checking lex output file root... lex.yy<br>checking whether yytext is a pointer... no<br>checking build system type... i686-redhat-linux-gnu<br>checking host system type... arm-unknown-linux-gnu<br>checking for a sed that does not truncate output... /bin/sed<br>checking for egrep... grep -E<br>checking for ld used by arm-linux-gnu-gcc... /usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/bin/ld<br>checking if the linker (/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/bin/ld) is GNU ld... yes<br>checking for /usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/bin/ld option to reload object files... -r<br>checking for BSD-compatible nm... /usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/bin//arm-linux-gnu-nm -B<br>checking whether ln -s works... yes<br>checking how to recognise dependent libraries... pass_all<br>checking how to run
 the C preprocessor... arm-linux-gnu-gcc -E<br>checking for ANSI C header files... yes<br>checking for sys/types.h... yes<br>checking for sys/stat.h... yes<br>checking for stdlib.h... yes<br>checking for string.h... yes<br>checking for memory.h... yes<br>checking for strings.h... yes<br>checking for inttypes.h... yes<br>checking for stdint.h... yes<br>checking for unistd.h... yes<br>checking dlfcn.h usability... yes<br>checking dlfcn.h presence... yes<br>checking for dlfcn.h... yes<br>checking the maximum length of command line arguments... 32768<br>checking command to parse /usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/bin//arm-linux-gnu-nm -B output from arm-linux-gnu-gcc object... ok<br>checking for objdir... .libs<br>checking for arm-linux-gnu-ar... arm-linux-gnu-ar<br>checking for arm-linux-gnu-ranlib... arm-linux-gnu-ranlib<br>checking for arm-linux-gnu-strip... (cached) arm-linux-gnu-strip<br>checking if arm-linux-gnu-gcc supports -fno-rtti
 -fno-exceptions... no<br>checking for arm-linux-gnu-gcc option to produce PIC... -fPIC<br>checking if arm-linux-gnu-gcc PIC flag -fPIC works... yes<br>checking if arm-linux-gnu-gcc static flag -static works... yes<br>checking if arm-linux-gnu-gcc supports -c -o file.o... yes<br>checking whether the arm-linux-gnu-gcc linker (/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/bin/ld) supports shared libraries... yes<br>checking whether -lc should be explicitly linked in... no<br>checking dynamic linker characteristics... GNU/Linux ld.so<br>checking how to hardcode library paths into programs... immediate<br>checking whether stripping libraries is possible... yes<br>checking if libtool supports shared libraries... yes<br>checking whether to build shared libraries... yes<br>checking whether to build static libraries... no<br>configure: creating libtool<br>checking for ppoll... no<br>checking for arm-linux-gnu-pkg-config... no<br>checking for
 pkg-config... /usr/bin/pkg-config<br>checking pkg-config is at least version 0.9.0... yes<br>checking for BLUEZ... yes<br>checking for DBUS... yes<br>checking for GLIB... yes<br>checking for OPENOBEX... no<br>no<br>checking for OPENSYNC... no<br>no<br>checking for GSTREAMER... no<br>no<br>checking for FUSE... no<br>no<br>checking for ALSA... yes<br>checking for USB... yes<br>checking for usb_get_busses in -lusb... no<br>checking for usb_interrupt_read in -lusb... no<br>checking for XML_ParserCreate_MM in -lexpat... no<br>checking expat.h usability... no<br>checking expat.h presence... no<br>checking for expat.h... no<br>configure: creating ./config.status<br>config.status: creating Makefile<br>config.status: creating common/Makefile<br>config.status: creating daemon/Makefile<br>config.status: creating network/Makefile<br>config.status: creating input/Makefile<br>config.status: creating audio/Makefile<br>config.status: creating sync/Makefile<br>config.status: creating
 tools/Makefile<br>config.status: creating rfcomm/Makefile<br>config.status: creating hcid/Makefile<br>config.status: creating sdpd/Makefile<br>config.status: creating dund/Makefile<br>config.status: creating pand/Makefile<br>config.status: creating hidd/Makefile<br>config.status: creating cups/Makefile<br>config.status: creating fuse/Makefile<br>config.status: creating alsa/Makefile<br>config.status: creating test/Makefile<br>config.status: creating scripts/Makefile<br>config.status: creating config.h<br>config.status: executing depfiles commands<br>[user1@localhost bluez-utils-3.8]$ make<br>make&nbsp; all-recursive<br>make[1]: Entering directory `/home/user1/test/code/bluez3.8/bluez-utils-3.8'<br>Making all in common<br>make[2]: Entering directory `/home/user1/test/code/bluez3.8/bluez-utils-3.8/common'<br>if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I..&nbsp;&nbsp;&nbsp; -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include&nbsp;&nbsp; -DDBUS_API_SUBJECT_TO_CHANGE -Wall
 -O2 -D_FORTIFY_SOURCE=2 -MT oui.o -MD -MP -MF ".deps/oui.Tpo" -c -o oui.o oui.c; \<br>then mv -f ".deps/oui.Tpo" ".deps/oui.Po"; else rm -f ".deps/oui.Tpo"; exit 1; fi<br>if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I..&nbsp;&nbsp;&nbsp; -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include&nbsp;&nbsp; -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT list.o -MD -MP -MF ".deps/list.Tpo" -c -o list.o list.c; \<br>then mv -f ".deps/list.Tpo" ".deps/list.Po"; else rm -f ".deps/list.Tpo"; exit 1; fi<br>if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I..&nbsp;&nbsp;&nbsp; -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include&nbsp;&nbsp; -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT textfile.o -MD -MP -MF ".deps/textfile.Tpo" -c -o textfile.o textfile.c; \<br>then mv -f ".deps/textfile.Tpo" ".deps/textfile.Po"; else rm -f ".deps/textfile.Tpo"; exit 1; fi<br>if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I..&nbsp;&nbsp;&nbsp; -I/usr/include/dbus-1.0
 -I/usr/lib/dbus-1.0/include&nbsp;&nbsp; -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT helper.o -MD -MP -MF ".deps/helper.Tpo" -c -o helper.o helper.c; \<br>then mv -f ".deps/helper.Tpo" ".deps/helper.Po"; else rm -f ".deps/helper.Tpo"; exit 1; fi<br>if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I..&nbsp;&nbsp;&nbsp; -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include&nbsp;&nbsp; -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT glib-ectomy.o -MD -MP -MF ".deps/glib-ectomy.Tpo" -c -o glib-ectomy.o glib-ectomy.c; \<br>then mv -f ".deps/glib-ectomy.Tpo" ".deps/glib-ectomy.Po"; else rm -f ".deps/glib-ectomy.Tpo"; exit 1; fi<br>if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I..&nbsp;&nbsp;&nbsp; -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include&nbsp;&nbsp; -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT logging.o -MD -MP -MF ".deps/logging.Tpo" -c -o logging.o logging.c; \<br>then mv -f ".deps/logging.Tpo" ".deps/logging.Po"; else
 rm -f ".deps/logging.Tpo"; exit 1; fi<br>if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I..&nbsp;&nbsp;&nbsp; -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include&nbsp;&nbsp; -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT dbus.o -MD -MP -MF ".deps/dbus.Tpo" -c -o dbus.o dbus.c; \<br>then mv -f ".deps/dbus.Tpo" ".deps/dbus.Po"; else rm -f ".deps/dbus.Tpo"; exit 1; fi<br>if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I..&nbsp;&nbsp;&nbsp; -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include&nbsp;&nbsp; -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT sdp-xml.o -MD -MP -MF ".deps/sdp-xml.Tpo" -c -o sdp-xml.o sdp-xml.c; \<br>then mv -f ".deps/sdp-xml.Tpo" ".deps/sdp-xml.Po"; else rm -f ".deps/sdp-xml.Tpo"; exit 1; fi<br>if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I..&nbsp;&nbsp;&nbsp; -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include&nbsp;&nbsp; -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT sdp-dummy.o -MD -MP -MF
 ".deps/sdp-dummy.Tpo" -c -o sdp-dummy.o sdp-dummy.c; \<br>then mv -f ".deps/sdp-dummy.Tpo" ".deps/sdp-dummy.Po"; else rm -f ".deps/sdp-dummy.Tpo"; exit 1; fi<br>sdp-dummy.c: In function `sdp_xml_parse_record':<br>sdp-dummy.c:38: warning: return makes pointer from integer without a cast<br>rm -f libhelper.a<br>arm-linux-gnu-ar cru libhelper.a oui.o list.o textfile.o helper.o glib-ectomy.o logging.o dbus.o sdp-xml.o sdp-dummy.o<br>arm-linux-gnu-ranlib libhelper.a<br>if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I..&nbsp;&nbsp;&nbsp; -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include&nbsp;&nbsp; -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT test_textfile.o -MD -MP -MF ".deps/test_textfile.Tpo" -c -o test_textfile.o test_textfile.c; \<br>then mv -f ".deps/test_textfile.Tpo" ".deps/test_textfile.Po"; else rm -f ".deps/test_textfile.Tpo"; exit 1; fi<br>/bin/sh ../libtool --tag=CC --mode=link arm-linux-gnu-gcc -I/usr/include/dbus-1.0
 -I/usr/lib/dbus-1.0/include&nbsp;&nbsp; -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2&nbsp;&nbsp; -o test_textfile&nbsp; test_textfile.o libhelper.a<br>mkdir .libs<br>arm-linux-gnu-gcc -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -o test_textfile test_textfile.o&nbsp; libhelper.a<br>make[2]: Leaving directory `/home/user1/test/code/bluez3.8/bluez-utils-3.8/common'<br>Making all in hcid<br>make[2]: Entering directory `/home/user1/test/code/bluez3.8/bluez-utils-3.8/hcid'<br>make&nbsp; all-am<br>make[3]: Entering directory `/home/user1/test/code/bluez3.8/bluez-utils-3.8/hcid'<br>if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common&nbsp;&nbsp; -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include&nbsp;&nbsp; -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include&nbsp;&nbsp; -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT security.o -MD -MP -MF
 ".deps/security.Tpo" -c -o security.o security.c; \<br>then mv -f ".deps/security.Tpo" ".deps/security.Po"; else rm -f ".deps/security.Tpo"; exit 1; fi<br>if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common&nbsp;&nbsp; -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include&nbsp;&nbsp; -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include&nbsp;&nbsp; -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT device.o -MD -MP -MF ".deps/device.Tpo" -c -o device.o device.c; \<br>then mv -f ".deps/device.Tpo" ".deps/device.Po"; else rm -f ".deps/device.Tpo"; exit 1; fi<br>if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common&nbsp;&nbsp; -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include&nbsp;&nbsp; -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include&nbsp;&nbsp; -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT storage.o -MD -MP -MF ".deps/storage.Tpo" -c -o storage.o
 storage.c; \<br>then mv -f ".deps/storage.Tpo" ".deps/storage.Po"; else rm -f ".deps/storage.Tpo"; exit 1; fi<br>if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common&nbsp;&nbsp; -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include&nbsp;&nbsp; -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include&nbsp;&nbsp; -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT sdp.o -MD -MP -MF ".deps/sdp.Tpo" -c -o sdp.o sdp.c; \<br>then mv -f ".deps/sdp.Tpo" ".deps/sdp.Po"; else rm -f ".deps/sdp.Tpo"; exit 1; fi<br>if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common&nbsp;&nbsp; -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include&nbsp;&nbsp; -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include&nbsp;&nbsp; -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT parser.o -MD -MP -MF ".deps/parser.Tpo" -c -o parser.o parser.c; \<br>then mv -f ".deps/parser.Tpo" ".deps/parser.Po"; else rm
 -f ".deps/parser.Tpo"; exit 1; fi<br>if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common&nbsp;&nbsp; -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include&nbsp;&nbsp; -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include&nbsp;&nbsp; -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT lexer.o -MD -MP -MF ".deps/lexer.Tpo" -c -o lexer.o lexer.c; \<br>then mv -f ".deps/lexer.Tpo" ".deps/lexer.Po"; else rm -f ".deps/lexer.Tpo"; exit 1; fi<br>lexer.c:1183: warning: 'yyunput' defined but not used<br>if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common&nbsp;&nbsp; -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include&nbsp;&nbsp; -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include&nbsp;&nbsp; -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT kword.o -MD -MP -MF ".deps/kword.Tpo" -c -o kword.o kword.c; \<br>then mv -f ".deps/kword.Tpo" ".deps/kword.Po"; else rm -f
 ".deps/kword.Tpo"; exit 1; fi<br>if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common&nbsp;&nbsp; -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include&nbsp;&nbsp; -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include&nbsp;&nbsp; -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT dbus-hci.o -MD -MP -MF ".deps/dbus-hci.Tpo" -c -o dbus-hci.o dbus-hci.c; \<br>then mv -f ".deps/dbus-hci.Tpo" ".deps/dbus-hci.Po"; else rm -f ".deps/dbus-hci.Tpo"; exit 1; fi<br>if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common&nbsp;&nbsp; -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include&nbsp;&nbsp; -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include&nbsp;&nbsp; -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT dbus-common.o -MD -MP -MF ".deps/dbus-common.Tpo" -c -o dbus-common.o dbus-common.c; \<br>then mv -f ".deps/dbus-common.Tpo" ".deps/dbus-common.Po"; else rm -f
 ".deps/dbus-common.Tpo"; exit 1; fi<br>if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common&nbsp;&nbsp; -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include&nbsp;&nbsp; -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include&nbsp;&nbsp; -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT dbus-error.o -MD -MP -MF ".deps/dbus-error.Tpo" -c -o dbus-error.o dbus-error.c; \<br>then mv -f ".deps/dbus-error.Tpo" ".deps/dbus-error.Po"; else rm -f ".deps/dbus-error.Tpo"; exit 1; fi<br>if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common&nbsp;&nbsp; -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include&nbsp;&nbsp; -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include&nbsp;&nbsp; -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT dbus-manager.o -MD -MP -MF ".deps/dbus-manager.Tpo" -c -o dbus-manager.o dbus-manager.c; \<br>then mv -f ".deps/dbus-manager.Tpo"
 ".deps/dbus-manager.Po"; else rm -f ".deps/dbus-manager.Tpo"; exit 1; fi<br>if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common&nbsp;&nbsp; -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include&nbsp;&nbsp; -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include&nbsp;&nbsp; -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT dbus-adapter.o -MD -MP -MF ".deps/dbus-adapter.Tpo" -c -o dbus-adapter.o dbus-adapter.c; \<br>then mv -f ".deps/dbus-adapter.Tpo" ".deps/dbus-adapter.Po"; else rm -f ".deps/dbus-adapter.Tpo"; exit 1; fi<br>if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common&nbsp;&nbsp; -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include&nbsp;&nbsp; -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include&nbsp;&nbsp; -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT dbus-device.o -MD -MP -MF ".deps/dbus-device.Tpo" -c -o dbus-device.o dbus-device.c; \<br>then mv -f
 ".deps/dbus-device.Tpo" ".deps/dbus-device.Po"; else rm -f ".deps/dbus-device.Tpo"; exit 1; fi<br>if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common&nbsp;&nbsp; -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include&nbsp;&nbsp; -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include&nbsp;&nbsp; -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT dbus-service.o -MD -MP -MF ".deps/dbus-service.Tpo" -c -o dbus-service.o dbus-service.c; \<br>then mv -f ".deps/dbus-service.Tpo" ".deps/dbus-service.Po"; else rm -f ".deps/dbus-service.Tpo"; exit 1; fi<br>if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common&nbsp;&nbsp; -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include&nbsp;&nbsp; -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include&nbsp;&nbsp; -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT dbus-security.o -MD -MP -MF ".deps/dbus-security.Tpo" -c -o dbus-security.o
 dbus-security.c; \<br>then mv -f ".deps/dbus-security.Tpo" ".deps/dbus-security.Po"; else rm -f ".deps/dbus-security.Tpo"; exit 1; fi<br>if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common&nbsp;&nbsp; -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include&nbsp;&nbsp; -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include&nbsp;&nbsp; -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT dbus-sdp.o -MD -MP -MF ".deps/dbus-sdp.Tpo" -c -o dbus-sdp.o dbus-sdp.c; \<br>then mv -f ".deps/dbus-sdp.Tpo" ".deps/dbus-sdp.Po"; else rm -f ".deps/dbus-sdp.Tpo"; exit 1; fi<br>if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common&nbsp;&nbsp; -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include&nbsp;&nbsp; -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include&nbsp;&nbsp; -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT dbus-rfcomm.o -MD -MP -MF ".deps/dbus-rfcomm.Tpo" -c -o
 dbus-rfcomm.o dbus-rfcomm.c; \<br>then mv -f ".deps/dbus-rfcomm.Tpo" ".deps/dbus-rfcomm.Po"; else rm -f ".deps/dbus-rfcomm.Tpo"; exit 1; fi<br>if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common&nbsp;&nbsp; -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include&nbsp;&nbsp; -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include&nbsp;&nbsp; -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT dbus-test.o -MD -MP -MF ".deps/dbus-test.Tpo" -c -o dbus-test.o dbus-test.c; \<br>then mv -f ".deps/dbus-test.Tpo" ".deps/dbus-test.Po"; else rm -f ".deps/dbus-test.Tpo"; exit 1; fi<br>rm -f libhciserver.a<br>arm-linux-gnu-ar cru libhciserver.a security.o device.o storage.o sdp.o parser.o lexer.o kword.o dbus-hci.o dbus-common.o dbus-error.o dbus-manager.o dbus-adapter.o dbus-device.o dbus-service.o dbus-security.o dbus-sdp.o dbus-rfcomm.o dbus-test.o<br>arm-linux-gnu-ranlib libhciserver.a<br>if arm-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I.
 -I.. -I../common&nbsp;&nbsp; -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include&nbsp;&nbsp; -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include&nbsp;&nbsp; -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -MT passkey-agent.o -MD -MP -MF ".deps/passkey-agent.Tpo" -c -o passkey-agent.o passkey-agent.c; \<br>then mv -f ".deps/passkey-agent.Tpo" ".deps/passkey-agent.Po"; else rm -f ".deps/passkey-agent.Tpo"; exit 1; fi<br>/bin/sh ../libtool --tag=CC --mode=link arm-linux-gnu-gcc -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include&nbsp;&nbsp; -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include&nbsp;&nbsp; -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2&nbsp;&nbsp; -o passkey-agent passkey-agent.o -ldbus-1<br>mkdir .libs<br>arm-linux-gnu-gcc -I/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include
 -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=2 -o passkey-agent passkey-agent.o&nbsp; -ldbus-1<br>/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/lib/gcc/arm-linux-gnu/3.4.4/../../../../arm-linux-gnu/bin/ld: cannot find -ldbus-1<br>collect2: ld returned 1 exit status<br>make[3]: *** [passkey-agent] Error 1<br>make[3]: Leaving directory `/home/user1/test/code/bluez3.8/bluez-utils-3.8/hcid'<br>make[2]: *** [all] Error 2<br>make[2]: Leaving directory `/home/user1/test/code/bluez3.8/bluez-utils-3.8/hcid'<br>make[1]: *** [all-recursive] Error 1<br>make[1]: Leaving directory `/home/user1/test/code/bluez3.8/bluez-utils-3.8'<br>make: *** [all] Error 2<br>********************************************************************************************<br>Thank you for helping<br><br>Regards<br><br><b><i>Marcel Holtmann &lt;marcel@holtmann.org&gt;</i></b> 說：<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px;
 padding-left: 5px;"> Hi,<br><br>&gt; I try to make the bluez-utils-3.8 after the configuration was done.<br>&gt; However I got the error "cannot find -ldbus-glib-1" during when make<br>&gt; the utils tools.  I have installed dbus. however not dbus-glib. <br><br>you actually don't need it. This is for some future stuff and it will be<br>disabled if configure doesn't find it. Otherwise it is a bug. Please<br>show us the exact error messages.<br><br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net's Techsay panel and you'll get the chance to share your<br>opinions on IT &amp; business topics through brief surveys - and earn cash<br>http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV<br>_______________________________________________<br>Bluez-users mailing
 list<br>Bluez-users@lists.sourceforge.net<br>https://lists.sourceforge.net/lists/listinfo/bluez-users<br></blockquote><br><p>&#32;_______________________________________<br> YM - 離線訊息<br> 就算你沒有上網，你的朋友仍可以留下訊息給你，當你上網時就能立即看到，任何說話都冇走失。<br> http://messenger.yahoo.com.hk
--0-766490042-1167748595=:71088--


--===============2086073380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============2086073380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============2086073380==--
