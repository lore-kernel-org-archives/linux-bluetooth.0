Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: "Tom Lloyd" <thomaslloyd@yahoo.com>
To: <bluez-devel@lists.sourceforge.net>
Date: Wed, 3 Jan 2007 14:44:56 -0000
Message-ID: <003b01c72f45$bd503e30$0300a8c0@2600xp>
MIME-Version: 1.0
Subject: [Bluez-devel] Compilation Problem Plugz
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello All,

I have recently got hold of a Bluetooth headset and decided that I would get
it working with my Linux box running Ubuntu 6.10 (woody). I have been
playing around with btsco which is installed and works almost perfectly. The
headset is paired and I am able to make calls with skype. The problem I am
having is it does not always close the connection to the headset when it is
not being used. This is a drain on the headset battery and I really want it
to last a day. The battery has a life of five hours and then it need
recharging. 

So I have downloaded your software from the cvs depositories and have made
and installed libsbc which went without a hitch this was after installing
all the packages you recommended for Ubuntu. Then I got a copy of the plugz
and tried to run through the same process. I got stuck at the configuration
stage, a few packages were still missing after installing them I created the
config file. There were still a number of warnings which I have included
below. Then I want to make it and got this list of errors. I hope this is
useful and that someone can point me in the right direction. Please can I
ask that you reply to this e-mail address get me on msn
thomaslloyd82@hotmail.com and skype me on my bt headset at thomas_lloyd. The
config and make oututs follow below:

Thanks in advance

oem@VIP-UK-LINUX:~/sbc/plugz$ ./configure --prefix=/usr
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking whether make sets $(MAKE)... yes
checking for working aclocal-1.4... found
checking for working autoconf... found
checking for working automake-1.4... found
checking for working autoheader... found
checking for working makeinfo... missing
checking for gcc... gcc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... no
checking for suffix of executables... 
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ISO C89... none needed
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
checking whether the gcc linker (/usr/bin/ld) supports shared libraries...
yes
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
config.status: WARNING:  Makefile.in seems to ignore the --datarootdir
setting
config.status: creating avdtp/Makefile
config.status: WARNING:  avdtp/Makefile.in seems to ignore the --datarootdir
setting
config.status: creating alsa-plugins/Makefile
config.status: WARNING:  alsa-plugins/Makefile.in seems to ignore the
--datarootdir setting
config.status: creating alsa-plugins/headsetd/Makefile
config.status: WARNING:  alsa-plugins/headsetd/Makefile.in seems to ignore
the --datarootdir setting
config.status: creating alsa-plugins/a2dpd/Makefile
config.status: WARNING:  alsa-plugins/a2dpd/Makefile.in seems to ignore the
--datarootdir setting
config.status: creating config.h
config.status: config.h is unchanged
config.status: executing default-1 commands

-----------------------------------------------------------

oem@VIP-UK-LINUX:~/sbc/plugz$ make
make  all-recursive
make[1]: Entering directory `/home/oem/sbc/plugz'
Making all in avdtp
make[2]: Entering directory `/home/oem/sbc/plugz/avdtp'
make[2]: Nothing to be done for `all'.
make[2]: Leaving directory `/home/oem/sbc/plugz/avdtp'
Making all in alsa-plugins
make[2]: Entering directory `/home/oem/sbc/plugz/alsa-plugins'
Making all in a2dpd
make[3]: Entering directory `/home/oem/sbc/plugz/alsa-plugins/a2dpd'
gcc -DHAVE_CONFIG_H -I. -I. -I../..    -I/usr/include -pthread -Wall -O2 -c
a2dpd_dbus.c
a2dpd_dbus.c:31:28: error: dbus/dbus-glib.h: No such file or directory
a2dpd_dbus.c:32:37: error: dbus/dbus-glib-lowlevel.h: No such file or
directory
a2dpd_dbus.c:46: error: expected '=', ',', ';', 'asm' or '__attribute__'
before '*' token
a2dpd_dbus.c:48: error: expected '=', ',', ';', 'asm' or '__attribute__'
before '*' token
a2dpd_dbus.c:51: error: expected '=', ',', ';', 'asm' or '__attribute__'
before 'a2dpd_dbus_Connect'
a2dpd_dbus.c:60: error: expected '=', ',', ';', 'asm' or '__attribute__'
before 'a2dpd_dbus_Disconnect'
a2dpd_dbus.c:69: error: expected '=', ',', ';', 'asm' or '__attribute__'
before 'a2dpd_dbus_StreamStart'
a2dpd_dbus.c:78: error: expected '=', ',', ';', 'asm' or '__attribute__'
before 'a2dpd_dbus_StreamSuspend'
a2dpd_dbus.c:87: error: expected '=', ',', ';', 'asm' or '__attribute__'
before 'a2dpd_dbus_SetAddress'
a2dpd_dbus.c:103: error: expected '=', ',', ';', 'asm' or '__attribute__'
before 'a2dpd_dbus_AutoConnect'
a2dpd_dbus.c:126: error: expected '=', ',', ';', 'asm' or '__attribute__'
before 'a2dpd_dbus_SetDebug'
a2dpd_dbus.c: In function 'a2dpd_signal_command':
a2dpd_dbus.c:149: error: 'gconnection' undeclared (first use in this
function)
a2dpd_dbus.c:149: error: (Each undeclared identifier is reported only once
a2dpd_dbus.c:149: error: for each function it appears in.)
a2dpd_dbus.c:150: error: 'DBusMessage' undeclared (first use in this
function)
a2dpd_dbus.c:150: error: 'signal' undeclared (first use in this function)
a2dpd_dbus.c:150: warning: implicit declaration of function
'dbus_message_new_signal'
a2dpd_dbus.c:152: warning: implicit declaration of function
'dbus_message_append_args'
a2dpd_dbus.c:153: error: 'DBUS_TYPE_STRING' undeclared (first use in this
function)
a2dpd_dbus.c:155: error: 'DBUS_TYPE_INVALID' undeclared (first use in this
function)
a2dpd_dbus.c:157: warning: implicit declaration of function
'dbus_connection_get_is_connected'
a2dpd_dbus.c:157: warning: implicit declaration of function
'dbus_g_connection_get_connection'
a2dpd_dbus.c:158: warning: implicit declaration of function
'dbus_connection_send'
a2dpd_dbus.c:161: warning: implicit declaration of function
'dbus_message_unref'
a2dpd_dbus.c: In function 'a2dpd_signal_state':
a2dpd_dbus.c:175: error: 'gconnection' undeclared (first use in this
function)
a2dpd_dbus.c:176: error: 'DBusMessage' undeclared (first use in this
function)
a2dpd_dbus.c:176: error: 'signal' undeclared (first use in this function)
a2dpd_dbus.c:179: error: 'DBUS_TYPE_STRING' undeclared (first use in this
function)
a2dpd_dbus.c:181: error: 'DBUS_TYPE_INVALID' undeclared (first use in this
function)
a2dpd_dbus.c: At top level:
a2dpd_dbus.c:196: error: expected '=', ',', ';', 'asm' or '__attribute__'
before 'a2dpd_handler_func'
a2dpd_dbus.c: In function 'a2dpd_thread_handler':
a2dpd_dbus.c:251: error: 'DBusError' undeclared (first use in this function)
a2dpd_dbus.c:251: error: expected ';' before 'dbusError'
a2dpd_dbus.c:252: error: expected '=', ',', ';', 'asm' or '__attribute__'
before 'dbus_vtable_a2dpd_server'
a2dpd_dbus.c:252: error: 'dbus_vtable_a2dpd_server' undeclared (first use in
this function)
a2dpd_dbus.c:252: error: expected expression before '{' token
a2dpd_dbus.c:253: warning: implicit declaration of function
'dbus_error_init'
a2dpd_dbus.c:253: error: 'dbusError' undeclared (first use in this function)
a2dpd_dbus.c:255: error: 'gconnection' undeclared (first use in this
function)
a2dpd_dbus.c:257: warning: implicit declaration of function
'dbus_connection_register_object_path'
a2dpd_dbus.c:259: warning: implicit declaration of function
'dbus_bus_request_name'
a2dpd_dbus.c:260: warning: implicit declaration of function
'dbus_error_is_set'
a2dpd_dbus.c:263: warning: implicit declaration of function
'g_main_loop_run'
a2dpd_dbus.c:263: error: 'loop' undeclared (first use in this function)
a2dpd_dbus.c:275: warning: implicit declaration of function
'dbus_error_free'
a2dpd_dbus.c: In function 'a2dpd_signal_init':
a2dpd_dbus.c:281: error: 'GError' undeclared (first use in this function)
a2dpd_dbus.c:281: error: 'gError' undeclared (first use in this function)
a2dpd_dbus.c:283: error: 'PTHREAD_STACK_MIN' undeclared (first use in this
function)
a2dpd_dbus.c:286: warning: implicit declaration of function
'g_thread_supported'
a2dpd_dbus.c:287: warning: implicit declaration of function 'g_thread_init'
a2dpd_dbus.c:288: warning: implicit declaration of function 'g_type_init'
a2dpd_dbus.c:290: error: 'loop' undeclared (first use in this function)
a2dpd_dbus.c:290: warning: implicit declaration of function
'g_main_loop_new'
a2dpd_dbus.c:290: error: 'FALSE' undeclared (first use in this function)
a2dpd_dbus.c:293: error: 'gconnection' undeclared (first use in this
function)
a2dpd_dbus.c:293: warning: implicit declaration of function 'dbus_g_bus_get'
a2dpd_dbus.c:293: error: 'DBUS_BUS_SESSION' undeclared (first use in this
function)
a2dpd_dbus.c:293: error: 'DBUS_BUS_SYSTEM' undeclared (first use in this
function)
a2dpd_dbus.c:304: warning: implicit declaration of function 'g_error_free'
a2dpd_dbus.c: In function 'a2dpd_signal_kill':
a2dpd_dbus.c:318: error: 'loop' undeclared (first use in this function)
a2dpd_dbus.c:320: warning: implicit declaration of function 'g_main_quit'
make[3]: *** [a2dpd_dbus.o] Error 1
make[3]: Leaving directory `/home/oem/sbc/plugz/alsa-plugins/a2dpd'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/home/oem/sbc/plugz/alsa-plugins'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/oem/sbc/plugz'
make: *** [all-recursive-am] Error 2
   


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
