Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41FE85A0.2040709@ieee.org>
From: joe sloan <jsloan@ieee.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Trying to compile for axis but Bluetooth library not found
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 31 Jan 2005 19:23:12 +0000

Hi,

I have compiled bluez-libs-2.14 but having problems with bluez-utils-2.14.

I'm working on a PC with SUSE 9.1, and the target is devboard_82 with 
linux-2.4.26.

I've tried almost every option at this stage and I keep getting the 
error related to /lib/libc.so.6 I cannot figure out where it is getting 
this from - my guess is that it should be pointing to 
../../target/cris-axis-linux-gnu/lib/libc.so.6  but cannot.

I'd appreciate some help or pointers with this (having searched the web 
and this newgroup - and tried loads of combinations of commands).

thanks

Joe

------------------------------------------------------------------------------------------------

The error I see is.....

checking for hci_open_dev in -lbluetooth... no
configure: error: Bluetooth library not found

and in config.log I have the entry

configure:3992: gcc-cris -mlinux -o conftest -Wall -O2   
-I/usr/include   -L/usr/lib conftest.c -lbluetooth   >&5
/lib/libc.so.6: could not read symbols: Invalid operation
collect2: ld returned 1 exit status
configure:3998: $? = 1
configure: failed program was:
| /* confdefs.h.  */
|
| #define PACKAGE_NAME ""
| #define PACKAGE_TARNAME ""
| #define PACKAGE_VERSION ""
| #define PACKAGE_STRING ""
| #define PACKAGE_BUGREPORT ""
| #define PACKAGE "bluez-utils"
| #define VERSION "2.14"
| #define CONFIGDIR "/usr/etc/bluetooth"
| #define STDC_HEADERS 1
| #define HAVE_SYS_TYPES_H 1
| #define HAVE_SYS_STAT_H 1
| #define HAVE_STDLIB_H 1
| #define HAVE_STRING_H 1
| #define HAVE_MEMORY_H 1
| #define HAVE_STRINGS_H 1
| #define HAVE_INTTYPES_H 1
| #define HAVE_STDINT_H 1
| #define HAVE_UNISTD_H 1
| /* end confdefs.h.  */
|
| /* Override any gcc2 internal prototype to avoid an error.  */
| #ifdef __cplusplus
| extern "C"
| #endif
| /* We use char because int might match the return type of a gcc2
|    builtin and then its argument prototype would still apply.  */
| char hci_open_dev ();
| int
| main ()
| {
| hci_open_dev ();
|   ;
|   return 0;
| }
configure:4023: result: no
configure:4028: error: Bluetooth library not found


Here's how I compiled it all



cd bluez-libs-2.14/
linux:/axis/devboard_82/apps/bluez-libs-2.14 # ./configure CC="gcc-cris 
-mlinux"  LD="cris-ld"   --target=cris-axis-linux --host=i686-pc-linux 
--prefix=/usr
configure: WARNING: If you wanted to set the --build type, don't use --host.
    If a cross compiler is detected then cross compile mode will be used.
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking for i686-pc-linux-strip... no
checking for strip... strip
checking whether to enable maintainer-specific portions of Makefiles... no
checking for i686-pc-linux-gcc... gcc-cris -mlinux
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... yes
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc-cris -mlinux accepts -g... yes
checking for gcc-cris -mlinux option to accept ANSI C... none needed
checking for style of include used by make... GNU
checking dependency style of gcc-cris -mlinux... none
checking for a BSD-compatible install... /usr/bin/install -c
checking build system type... i686-pc-linux-gnu
checking host system type... i686-pc-linux-gnu
checking for a sed that does not truncate output... /usr/bin/sed
checking for egrep... grep -E
checking for ld used by gcc-cris -mlinux... cris-ld
checking if the linker (cris-ld) is GNU ld... yes
checking for cris-ld option to reload object files... -r
checking for BSD-compatible nm... nm
checking whether ln -s works... yes
checking how to recognise dependent libraries... pass_all
checking how to run the C preprocessor... gcc-cris -mlinux -E
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
checking command to parse nm output from gcc-cris -mlinux object... ok
checking for objdir... .libs
checking for i686-pc-linux-ar... no
checking for ar... ar
checking for i686-pc-linux-ranlib... no
checking for ranlib... ranlib
checking for i686-pc-linux-strip... strip
checking if gcc-cris -mlinux static flag  works... yes
checking if gcc-cris -mlinux supports -fno-rtti -fno-exceptions... yes
checking for gcc-cris -mlinux option to produce PIC... -fPIC
checking if gcc-cris -mlinux PIC flag -fPIC works... yes
checking if gcc-cris -mlinux supports -c -o file.o... yes
checking whether the gcc-cris -mlinux linker (cris-ld) supports shared 
libraries... yes
checking whether -lc should be explicitly linked in... no
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... yes
configure: creating libtool
configure: creating ./config.status
config.status: creating Makefile
config.status: creating include/Makefile
config.status: creating src/Makefile
config.status: creating bluez.pc
config.status: creating config.h
config.status: config.h is unchanged
config.status: executing depfiles commands

make install

linux:/axis/devboard_82/apps/bluez-libs-2.14 # make install
Making install in include
make[1]: Entering directory `/axis/devboard_82/apps/bluez-libs-2.14/include'
make[2]: Entering directory `/axis/devboard_82/apps/bluez-libs-2.14/include'
make[2]: Nothing to be done for `install-exec-am'.
/bin/sh ../mkinstalldirs /usr/include/bluetooth
 /usr/bin/install -c -m 644 bluetooth.h /usr/include/bluetooth/bluetooth.h
 /usr/bin/install -c -m 644 hci.h /usr/include/bluetooth/hci.h
 /usr/bin/install -c -m 644 hci_lib.h /usr/include/bluetooth/hci_lib.h
 /usr/bin/install -c -m 644 hci_uart.h /usr/include/bluetooth/hci_uart.h
 /usr/bin/install -c -m 644 hci_vhci.h /usr/include/bluetooth/hci_vhci.h
 /usr/bin/install -c -m 644 l2cap.h /usr/include/bluetooth/l2cap.h
 /usr/bin/install -c -m 644 sco.h /usr/include/bluetooth/sco.h
 /usr/bin/install -c -m 644 rfcomm.h /usr/include/bluetooth/rfcomm.h
 /usr/bin/install -c -m 644 sdp.h /usr/include/bluetooth/sdp.h
 /usr/bin/install -c -m 644 sdp_lib.h /usr/include/bluetooth/sdp_lib.h
 /usr/bin/install -c -m 644 bnep.h /usr/include/bluetooth/bnep.h
 /usr/bin/install -c -m 644 cmtp.h /usr/include/bluetooth/cmtp.h
 /usr/bin/install -c -m 644 hidp.h /usr/include/bluetooth/hidp.h
make[2]: Leaving directory `/axis/devboard_82/apps/bluez-libs-2.14/include'
make[1]: Leaving directory `/axis/devboard_82/apps/bluez-libs-2.14/include'
Making install in src
make[1]: Entering directory `/axis/devboard_82/apps/bluez-libs-2.14/src'
/bin/sh ../libtool --mode=compile gcc-cris -mlinux -DHAVE_CONFIG_H -I. 
-I. -I.. -I../include    -Wall -O2 -c -o bluetooth.lo `test -f 
'bluetooth.c' || echo './'`bluetooth.c
mkdir .libs
 gcc-cris -mlinux -DHAVE_CONFIG_H -I. -I. -I.. -I../include -Wall -O2 -c 
bluetooth.c  -fPIC -DPIC -o .libs/bluetooth.o
 gcc-cris -mlinux -DHAVE_CONFIG_H -I. -I. -I.. -I../include -Wall -O2 -c 
bluetooth.c -o bluetooth.o >/dev/null 2>&1
/bin/sh ../libtool --mode=compile gcc-cris -mlinux -DHAVE_CONFIG_H -I. 
-I. -I.. -I../include    -Wall -O2 -c -o hci.lo `test -f 'hci.c' || echo 
'./'`hci.c
 gcc-cris -mlinux -DHAVE_CONFIG_H -I. -I. -I.. -I../include -Wall -O2 -c 
hci.c  -fPIC -DPIC -o .libs/hci.o
 gcc-cris -mlinux -DHAVE_CONFIG_H -I. -I. -I.. -I../include -Wall -O2 -c 
hci.c -o hci.o >/dev/null 2>&1
/bin/sh ../libtool --mode=compile gcc-cris -mlinux -DHAVE_CONFIG_H -I. 
-I. -I.. -I../include    -Wall -O2 -c -o sdp.lo `test -f 'sdp.c' || echo 
'./'`sdp.c
 gcc-cris -mlinux -DHAVE_CONFIG_H -I. -I. -I.. -I../include -Wall -O2 -c 
sdp.c  -fPIC -DPIC -o .libs/sdp.o
 gcc-cris -mlinux -DHAVE_CONFIG_H -I. -I. -I.. -I../include -Wall -O2 -c 
sdp.c -o sdp.o >/dev/null 2>&1
/bin/sh ../libtool --mode=link gcc-cris -mlinux  -Wall -O2   -o 
libbluetooth.la -rpath /usr/lib -version-info 1:14:0 bluetooth.lo hci.lo 
sdp.lo
gcc-cris -mlinux -shared  .libs/bluetooth.o .libs/hci.o .libs/sdp.o   
-mlinux -Wl,-soname -Wl,libbluetooth.so.1 -o .libs/libbluetooth.so.1.0.14
(cd .libs && rm -f libbluetooth.so.1 && ln -s libbluetooth.so.1.0.14 
libbluetooth.so.1)
(cd .libs && rm -f libbluetooth.so && ln -s libbluetooth.so.1.0.14 
libbluetooth.so)
ar cru .libs/libbluetooth.a  bluetooth.o hci.o sdp.o
ranlib .libs/libbluetooth.a
creating libbluetooth.la
(cd .libs && rm -f libbluetooth.la && ln -s ../libbluetooth.la 
libbluetooth.la)
make[2]: Entering directory `/axis/devboard_82/apps/bluez-libs-2.14/src'
/bin/sh ../mkinstalldirs /usr/lib
 /bin/sh ../libtool --mode=install /usr/bin/install -c  libbluetooth.la 
/usr/lib/libbluetooth.la
/usr/bin/install -c .libs/libbluetooth.so.1.0.14 
/usr/lib/libbluetooth.so.1.0.14
(cd /usr/lib && rm -f libbluetooth.so.1 && ln -s libbluetooth.so.1.0.14 
libbluetooth.so.1)
(cd /usr/lib && rm -f libbluetooth.so && ln -s libbluetooth.so.1.0.14 
libbluetooth.so)
/usr/bin/install -c .libs/libbluetooth.lai /usr/lib/libbluetooth.la
/usr/bin/install -c .libs/libbluetooth.a /usr/lib/libbluetooth.a
ranlib /usr/lib/libbluetooth.a
chmod 644 /usr/lib/libbluetooth.a
PATH="$PATH:/sbin" ldconfig -n /usr/lib
----------------------------------------------------------------------
Libraries have been installed in:
   /usr/lib

If you ever happen to want to link against installed libraries
in a given directory, LIBDIR, you must either use libtool, and
specify the full pathname of the library, or use the `-LLIBDIR'
flag during linking and do at least one of the following:
   - add LIBDIR to the `LD_LIBRARY_PATH' environment variable
     during execution
   - add LIBDIR to the `LD_RUN_PATH' environment variable
     during linking
   - use the `-Wl,--rpath -Wl,LIBDIR' linker flag
   - have your system administrator add LIBDIR to `/etc/ld.so.conf'

See any operating system documentation about shared libraries for
more information, such as the ld(1) and ld.so(8) manual pages.
----------------------------------------------------------------------
make[2]: Nothing to be done for `install-data-am'.
make[2]: Leaving directory `/axis/devboard_82/apps/bluez-libs-2.14/src'
make[1]: Leaving directory `/axis/devboard_82/apps/bluez-libs-2.14/src'
make[1]: Entering directory `/axis/devboard_82/apps/bluez-libs-2.14'
make[2]: Entering directory `/axis/devboard_82/apps/bluez-libs-2.14'
make[2]: Nothing to be done for `install-exec-am'.
/bin/sh ./mkinstalldirs /usr/share/aclocal
 /usr/bin/install -c -m 644 bluez.m4 /usr/share/aclocal/bluez.m4
/bin/sh ./mkinstalldirs /usr/lib/pkgconfig
 /usr/bin/install -c -m 644 bluez.pc /usr/lib/pkgconfig/bluez.pc
make[2]: Leaving directory `/axis/devboard_82/apps/bluez-libs-2.14'
make[1]: Leaving directory `/axis/devboard_82/apps/bluez-libs-2.14'
linux:/axis/devboard_82/apps/bluez-libs-2.14 #


 cd ../bluez-utils-2.14/
linux:/axis/devboard_82/apps/bluez-utils-2.14 # ./configure CC="gcc-cris 
-mlinux"  LD="cris-ld"   --target=cris-axis-linux --host=i686-pc-linux 
--prefix=/usr
configure: WARNING: If you wanted to set the --build type, don't use --host.
    If a cross compiler is detected then cross compile mode will be used.
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking for i686-pc-linux-strip... no
checking for strip... strip
checking whether to enable maintainer-specific portions of Makefiles... no
checking for i686-pc-linux-gcc... gcc-cris -mlinux
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... yes
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc-cris -mlinux accepts -g... yes
checking for gcc-cris -mlinux option to accept ANSI C... none needed
checking for style of include used by make... GNU
checking dependency style of gcc-cris -mlinux... none
checking whether gcc-cris -mlinux accepts -fPIE... no
checking for a BSD-compatible install... /usr/bin/install -c
checking for bison... bison -y
checking for flex... flex
checking for yywrap in -lfl... no
checking for yywrap in -ll... no
checking lex output file root... lex.yy
checking whether yytext is a pointer... no
checking how to run the C preprocessor... gcc-cris -mlinux -E
checking for egrep... grep -E
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
checking bluetooth/bluetooth.h usability... yes
checking bluetooth/bluetooth.h presence... yes
checking for bluetooth/bluetooth.h... yes
checking for hci_open_dev in -lbluetooth... no
configure: error: Bluetooth library not found
linux:/axis/devboard_82/apps/bluez-utils-2.14 #







-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
