Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Elad <eladmoshe@hotmail.com>
Date: Wed, 16 May 2007 11:25:56 +0000 (UTC)
Message-ID: <loom.20070516T132350-178@post.gmane.org>
Mime-Version: 1.0
Subject: [Bluez-devel] Unable to compile plugz
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

When I try to install plugz as described in:
http://bluetooth-alsa.sourceforge.net/build.html

I receive the following messages :

$ ./bootstrap
alsa-plugins/a2dpd/Makefile.am:32: compiling `a2dpd.c' with per-target flags
requires `AM_PROG_CC_C_O' in `configure.in'

$ ./configure --prefix=/usr --sysconfdir=/etc
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
/bin/bash: /home/elad/Desktop/To: No such file or directory
configure: WARNING: `missing' script is too old or missing
checking for a thread-safe mkdir -p... /bin/mkdir -p
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking for gcc... gcc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... no
checking for suffix of executables... 
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ISO C89... none needed
checking for style of include used by make... GNU
checking dependency style of gcc... gcc3
checking for a BSD-compatible install... /usr/bin/install -c
checking for ranlib... ranlib
checking how to run the C preprocessor... gcc -E
checking for grep that handles long lines and -e... /bin/grep
checking for egrep... /bin/grep -E
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
checking for hci_open_dev in -lbluetooth... yes
checking for sdp_connect in -lbluetooth... yes
checking build system type... i686-pc-linux-gnu
checking host system type... i686-pc-linux-gnu
checking for a sed that does not truncate output... /bin/sed
checking for ld used by gcc... /usr/bin/ld
checking if the linker (/usr/bin/ld) is GNU ld... yes
checking for /usr/bin/ld option to reload object files... -r
checking for BSD-compatible nm... /usr/bin/nm -B
checking whether ln -s works... yes
checking how to recognise dependent libraries... pass_all
checking dlfcn.h usability... yes
checking dlfcn.h presence... yes
checking for dlfcn.h... yes
checking the maximum length of command line arguments... 32768
checking command to parse /usr/bin/nm -B output from gcc object... ok
checking for objdir... .libs
checking for ar... ar
checking for ranlib... (cached) ranlib
checking for strip... strip
checking if gcc supports -fno-rtti -fno-exceptions... no
checking for gcc option to produce PIC... -fPIC
checking if gcc PIC flag -fPIC works... yes
checking if gcc static flag -static works... yes
checking if gcc supports -c -o file.o... yes
checking whether the gcc linker (/usr/bin/ld) supports shared libraries... yes
checking whether -lc should be explicitly linked in... no
checking dynamic linker characteristics... cat: /etc/ld.so.conf.d/*.conf: No
such file or directory
GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... yes
configure: creating libtool
checking for ALSA CFLAGS... 
checking for ALSA LDFLAGS...  -lasound -lm -ldl -lpthread
checking for libasound headers version >= 1.0.10... found.
checking for snd_ctl_open in -lasound... yes
checking for pkg-config... /usr/bin/pkg-config
checking pkg-config is at least version 0.9.0... yes
checking for GLIB... yes
checking for DBUS... yes
configure: creating ./config.status
config.status: creating Makefile
config.status: creating avdtp/Makefile
config.status: creating alsa-plugins/Makefile
config.status: creating alsa-plugins/headsetd/Makefile
config.status: creating alsa-plugins/a2dpd/Makefile
config.status: creating config.h
config.status: config.h is unchanged
config.status: executing depfiles commands


$ make
make  all-recursive
make[1]: Entering directory `/home/elad/Desktop/To do/plugz'
Making all in avdtp
make[2]: Entering directory `/home/elad/Desktop/To do/plugz/avdtp'
make[2]: Nothing to be done for `all'.
make[2]: Leaving directory `/home/elad/Desktop/To do/plugz/avdtp'
Making all in alsa-plugins
make[2]: Entering directory `/home/elad/Desktop/To do/plugz/alsa-plugins'
Making all in a2dpd
make[3]: Entering directory `/home/elad/Desktop/To do/plugz/alsa-plugins/a2dpd'
/bin/bash ../../libtool --tag=CC   --mode=link gcc -I/usr/include
-I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include -I/usr/include/glib-2.0
-I/usr/lib/glib-2.0/include   -pthread -Wall -O2   -o
libasound_module_pcm_a2dpd.la -rpath /usr/lib/alsa-lib pcm_a2dpd.lo -lasound -lm
-ldl -lpthread -lrt -lpthread  -la2dpdcommon -lbluetooth 
gcc -shared  .libs/pcm_a2dpd.o  -pthread /usr/lib/libasound.so -lm -ldl -lrt
-lpthread -la2dpdcommon /usr/lib/libbluetooth.so  -Wl,-soname
-Wl,libasound_module_pcm_a2dpd.so.0 -o .libs/libasound_module_pcm_a2dpd.so.0.0.0
/usr/bin/ld: cannot find -la2dpdcommon
collect2: ld returned 1 exit status
make[3]: *** [libasound_module_pcm_a2dpd.la] Error 1
make[3]: Leaving directory `/home/elad/Desktop/To do/plugz/alsa-plugins/a2dpd'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/home/elad/Desktop/To do/plugz/alsa-plugins'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/elad/Desktop/To do/plugz'
make: *** [all] Error 2

---------------------------------------------------

I am running Ubuntu feisty.
I downloaded all the files today (16 of May 07) using 
the cvs command, so they are updated.
I also download all the packages described in the manual.

Any suggestions? 
Thanks!



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
