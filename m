Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <5256d0b05010520461ad68ff3@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-devel] btsco under FC3
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 6 Jan 2005 12:46:02 +0800

Hey All,

Just trying to compile btsco under FC3 and have run into a little
trouble compiling the latest CVS version. I can't actually get it to
compile as yet but will include the HW details FYI.

D-Link DBT-120 rev B2
Headset Motorola HS-810
I also have a Motorola HS-850 on the way (the 810 is actually a friends).

The actual problem is that it can't locate the @AO_CFLAGS@ directory
during compile. I'm following the directions on the website.

Cheers
Pete

hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:80:C8:26:F7:76 ACL MTU: 192:8  SCO MTU: 64:8
        HCI 15.3
        Chip version: BlueCore02
        Max key size: 56 bit
        SCO mapping:  HCI
[root@trinity ~]# lsusb
Bus 001 Device 003: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle

[peter@trinity btsco]$ ./configure
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
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
checking for gcc option to accept ANSI C... none needed
checking for style of include used by make... GNU
checking dependency style of gcc... none
checking for a BSD-compatible install... /usr/bin/install -c
checking for ranlib... ranlib
checking for ALSA CFLAGS...
checking for ALSA LDFLAGS...  -lasound -lm -ldl -lpthread
checking for libasound headers version >= 1.0.3... found.
checking for snd_ctl_open in -lasound... yes
./configure: line 3249: XIPH_PATH_AO: command not found
configure: creating ./config.status
config.status: creating Makefile
config.status: creating sbc/Makefile
config.status: creating avdtp/Makefile
config.status: creating config.h
config.status: config.h is unchanged
config.status: executing depfiles commands
[peter@trinity btsco]$ make
make  all-recursive
make[1]: Entering directory `/home/peter/download/voip/btsco'
Making all in sbc
make[2]: Entering directory `/home/peter/download/voip/btsco/sbc'
rm -f libsbc.a
ar cru libsbc.a sbc.o
ranlib libsbc.a
gcc -DHAVE_CONFIG_H -I. -I. -I..    @AO_CFLAGS@ -Wall -O2 -c sbcinfo.c
gcc: @AO_CFLAGS@: No such file or directory
make[2]: *** [sbcinfo.o] Error 1
make[2]: Leaving directory `/home/peter/download/voip/btsco/sbc'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/peter/download/voip/btsco'
make: *** [all] Error 2
[peter@trinity btsco]$


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
