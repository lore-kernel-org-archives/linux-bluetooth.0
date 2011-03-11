Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110310192941.GC2190@joana>
References: <AANLkTims_WHKQ4pNPZNgWS390ASeU8Kw1=w4LN2TOsR3@mail.gmail.com>
	<20110310153754.GA2190@joana>
	<AANLkTi=ckPmqtRZQvHq5Rkg0jKCuk7uvisM10r+o2hjF@mail.gmail.com>
	<20110310192941.GC2190@joana>
Date: Fri, 11 Mar 2011 09:23:48 +0800
Message-ID: <AANLkTim+dmSSYUJWF=Sd6raSUUurtsbih6YhjH89Q+9w@mail.gmail.com>
Subject: Re: some questions about Bluez
From: loody <miloody@gmail.com>
To: loody <miloody@gmail.com>, linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hi:

2011/3/11 Gustavo F. Padovan <padovan@profusion.mobi>:
> Hi Loody,
>
> * loody <miloody@gmail.com> [2011-03-11 03:01:52 +0800]:
>
>> hi gustavo:
>>
>> 2011/3/10 Gustavo F. Padovan <padovan@profusion.mobi>:
>> > Hi Loody,
>> >
>> > * loody <miloody@gmail.com> [2011-03-10 20:33:49 +0800]:
>> >
>> >> hi all:
>> >> I have some questions about bluetooth.
>> >> 1. how many additional libs that I need to successfully compile bluez?
>> >> so far as I know are:
>> >>     a. DBUS
>> >>     b. GLIB
>> >>     c. ALSA
>> >>     d. GSTREAMER
>> >>     e. USB
>> >>     f. SNDFILE
>> >>     g.CAPNG
>> >> am I right?
>> >>
>> >> 2. I try to compile Bluez to run on mips platform.
>> >> What I need is a simple tool which can tell me what kind of bluetooth
>> >> device around my usb bluetooth controller.
>> >> it seems I only need to enable USB lib above, right?
>> >>
>> >> 3. from configure, I found we can turn off features by setting
>> >> "--disable-xxxx", so I use below configure command for configuring
>> >> ./configure --prefix=/media/sdb1/bluez-4.89.mips/build
>> >> --host=mipsel-linux-gnu --disable-optimization --disable-fortify
>> >> --disable-pie --disable-network --disable-serial --disable-input
>> >> --disable-audio --disable-service
>> >>
>> >> but it still complain to me that he cannot find alsa header files and libs.
>> >
>> > The ./configure line you provided work for me in x86_64. Can you provide the
>> > logs of ./configure && make?
>> Here you are :)
>
> Send in plain text please.
./configure :
configure: WARNING: If you wanted to set the --build type, don't use --host.
    If a cross compiler is detected then cross compile mode will be used.
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for mipsel-linux-gnu-strip... mipsel-linux-gnu-strip
checking for a thread-safe mkdir -p... /bin/mkdir -p
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking whether to enable maintainer-specific portions of Makefiles... no
checking for mipsel-linux-gnu-pkg-config... no
checking for pkg-config... /usr/bin/pkg-config
checking pkg-config is at least version 0.9.0... yes
checking for mipsel-linux-gnu-gcc... mipsel-linux-gnu-gcc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... yes
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether mipsel-linux-gnu-gcc accepts -g... yes
checking for mipsel-linux-gnu-gcc option to accept ISO C89... none needed
checking for style of include used by make... GNU
checking dependency style of mipsel-linux-gnu-gcc... gcc3
checking whether mipsel-linux-gnu-gcc and cc understand -c and -o
together... yes
checking whether mipsel-linux-gnu-gcc accepts -fPIE... yes
checking for a BSD-compatible install... /usr/bin/install -c
checking for bison... bison -y
checking for flex... flex
checking lex output file root... lex.yy
checking lex library... none needed
checking whether yytext is a pointer... no
checking build system type... i686-pc-linux-gnu
checking host system type... mipsel-unknown-linux-gnu
checking for a sed that does not truncate output... /bin/sed
checking for grep that handles long lines and -e... /bin/grep
checking for egrep... /bin/grep -E
checking for fgrep... /bin/grep -F
checking for ld used by mipsel-linux-gnu-gcc...
/media/sdb1/toolchain/mips/codesourcery.ss/mips-4.3-154/mipsel-linux-gnu/bin/ld
checking if the linker
(/media/sdb1/toolchain/mips/codesourcery.ss/mips-4.3-154/mipsel-linux-gnu/bin/ld)
is GNU ld... yes
checking for BSD- or MS-compatible name lister (nm)...
/media/sdb1/toolchain/mips/codesourcery.ss/mips-novatek/bin/mipsel-linux-gnu-nm
-B
checking the name lister
(/media/sdb1/toolchain/mips/codesourcery.ss/mips-novatek/bin/mipsel-linux-gnu-nm
-B) interface... BSD nm
checking whether ln -s works... yes
checking the maximum length of command line arguments... 1572864
checking whether the shell understands some XSI constructs... yes
checking whether the shell understands "+="... yes
checking for /media/sdb1/toolchain/mips/codesourcery.ss/mips-4.3-154/mipsel-linux-gnu/bin/ld
option to reload object files... -r
checking for mipsel-linux-gnu-objdump... mipsel-linux-gnu-objdump
checking how to recognize dependent libraries... pass_all
checking for mipsel-linux-gnu-ar... mipsel-linux-gnu-ar
checking for mipsel-linux-gnu-strip... (cached) mipsel-linux-gnu-strip
checking for mipsel-linux-gnu-ranlib... mipsel-linux-gnu-ranlib
checking command to parse
/media/sdb1/toolchain/mips/codesourcery.ss/mips-novatek/bin/mipsel-linux-gnu-nm
-B output from mipsel-linux-gnu-gcc object... ok
checking how to run the C preprocessor... mipsel-linux-gnu-gcc -E
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
checking for dlfcn.h... yes
checking for objdir... .libs
checking if mipsel-linux-gnu-gcc supports -fno-rtti -fno-exceptions... no
checking for mipsel-linux-gnu-gcc option to produce PIC... -fPIC -DPIC
checking if mipsel-linux-gnu-gcc PIC flag -fPIC -DPIC works... yes
checking if mipsel-linux-gnu-gcc static flag -static works... yes
checking if mipsel-linux-gnu-gcc supports -c -o file.o... yes
checking if mipsel-linux-gnu-gcc supports -c -o file.o... (cached) yes
checking whether the mipsel-linux-gnu-gcc linker
(/media/sdb1/toolchain/mips/codesourcery.ss/mips-4.3-154/mipsel-linux-gnu/bin/ld)
supports shared libraries... yes
checking whether -lc should be explicitly linked in... no
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... no
checking for ppoll... yes
checking for dlopen in -ldl... yes
checking for DBUS... yes
checking for dbus_watch_get_unix_fd in -ldbus-1... no
checking for dbus_connection_can_send_type in -ldbus-1... no
checking for GLIB... yes
checking for ALSA... yes
checking for clock_gettime in -lrt... yes
checking for GSTREAMER... no
checking for USB... no
checking for usb_get_busses in -lusb... no
checking for usb_interrupt_read in -lusb... no
checking for SNDFILE... no
checking readline/readline.h usability... no
checking readline/readline.h presence... no
checking for readline/readline.h... no
configure: creating ./config.status
config.status: creating Makefile
config.status: creating scripts/bluetooth.rules
config.status: creating doc/version.xml
config.status: creating src/bluetoothd.8
config.status: creating bluez.pc
config.status: creating config.h
config.status: config.h is unchanged
config.status: executing depfiles commands
config.status: executing libtool commands

make log:
make --no-print-directory all-am
  CC     audio/audio_libasound_module_pcm_bluetooth_la-pcm_bluetooth.lo
cc1: warning: include location "/usr/include/alsa" is unsafe for
cross-compilation
audio/pcm_bluetooth.c:40:28: error: alsa/asoundlib.h: No such file or directory
audio/pcm_bluetooth.c:41:31: error: alsa/pcm_external.h: No such file
or directory
audio/pcm_bluetooth.c:130: error: expected specifier-qualifier-list
before 'snd_pcm_ioplug_t'
audio/pcm_bluetooth.c:151: error: expected ')' before '*' token
audio/pcm_bluetooth.c:158: error: expected ')' before '*' token
audio/pcm_bluetooth.c: In function 'playback_hw_thread':
audio/pcm_bluetooth.c:171: error: array type has incomplete element type
audio/pcm_bluetooth.c:174: error: 'struct bluetooth_data' has no
member named 'server'
audio/pcm_bluetooth.c:174: error: 'POLLIN' undeclared (first use in
this function)
audio/pcm_bluetooth.c:174: error: (Each undeclared identifier is
reported only once
audio/pcm_bluetooth.c:174: error: for each function it appears in.)
audio/pcm_bluetooth.c:177: error: 'struct bluetooth_data' has no
member named 'server'
audio/pcm_bluetooth.c:178: error: 'struct bluetooth_data' has no
member named 'stream'
audio/pcm_bluetooth.c:181: error: 'struct bluetooth_data' has no
member named 'io'
audio/pcm_bluetooth.c:181: error: 'struct bluetooth_data' has no
member named 'io'
audio/pcm_bluetooth.c:194: error: 'struct bluetooth_data' has no
member named 'stopped'
audio/pcm_bluetooth.c:197: error: 'struct bluetooth_data' has no
member named 'reset'
audio/pcm_bluetooth.c:199: error: 'struct bluetooth_data' has no
member named 'reset'
audio/pcm_bluetooth.c:215: error: 'struct bluetooth_data' has no
member named 'hw_ptr'
audio/pcm_bluetooth.c:215: error: 'struct bluetooth_data' has no
member named 'io'
audio/pcm_bluetooth.c:216: error: 'struct bluetooth_data' has no
member named 'hw_ptr'
audio/pcm_bluetooth.c:216: error: 'struct bluetooth_data' has no
member named 'io'
audio/pcm_bluetooth.c:221: error: 'struct bluetooth_data' has no
member named 'pipefd'
audio/pcm_bluetooth.c:237: warning: implicit declaration of function 'poll'
audio/pcm_bluetooth.c:241: warning: implicit declaration of function 'SNDERR'
audio/pcm_bluetooth.c:248: error: 'POLLERR' undeclared (first use in
this function)
audio/pcm_bluetooth.c:248: error: 'POLLHUP' undeclared (first use in
this function)
audio/pcm_bluetooth.c:248: error: 'POLLNVAL' undeclared (first use in
this function)
audio/pcm_bluetooth.c:256: error: 'struct bluetooth_data' has no
member named 'hw_thread'
audio/pcm_bluetooth.c:171: warning: unused variable 'fds'
audio/pcm_bluetooth.c: At top level:
audio/pcm_bluetooth.c:260: error: expected ')' before '*' token
audio/pcm_bluetooth.c:277: error: expected ')' before '*' token
audio/pcm_bluetooth.c:288: error: expected '=', ',', ';', 'asm' or
'__attribute__' before 'bluetooth_pointer'
audio/pcm_bluetooth.c: In function 'bluetooth_exit':

Thanks a lot,
miloody
