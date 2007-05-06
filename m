Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sun, 06 May 2007 07:42:20 +0400
From: John Frankish <frankish@dubai.oilfield.slb.com>
In-reply-to: <beb7688e0705051018o4e44994al22d18d11bd7d50f@mail.gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-id: <7.0.1.0.2.20070506074127.03b19b00@dubai.oilfield.slb.com>
MIME-version: 1.0
References: <beb7688e0705051018o4e44994al22d18d11bd7d50f@mail.gmail.com>
Subject: Re: [Bluez-devel] Unable to Compile Plugz
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

Chris,

You need to compile bluez-libs and/or bluez-utils to get the required 
header files.

Regards
John

At 21:18 05-05-07, you wrote:
>Hi,
>
>I've been trying to compile Plugz as described at
>http://bluetooth-alsa.sourceforge.net/build.html but I've been getting
>the error "Bluetooth header files not found". How do I fix this? The
>full console text is below.
>
>Thanks,
>Chris
>
>[plugz]$ ./bootstrap
>configure.in: installing `./install-sh'
>configure.in: installing `./missing'
>alsa-plugins/Makefile.am: installing `./depcomp'
>alsa-plugins/a2dpd/Makefile.am: installing `./compile'
>configure.in:95: installing `./config.guess'
>configure.in:95: installing `./config.sub'
>[plugz]$ ./configure --prefix=/usr --sysconfdir=/etc
>checking for a BSD-compatible install... /usr/bin/install -c
>checking whether build environment is sane... yes
>checking for gawk... gawk
>checking whether make sets $(MAKE)... yes
>checking for gcc... gcc
>checking for C compiler default output file name... a.out
>checking whether the C compiler works... yes
>checking whether we are cross compiling... no
>checking for suffix of executables...
>checking for suffix of object files... o
>checking whether we are using the GNU C compiler... yes
>checking whether gcc accepts -g... yes
>checking for gcc option to accept ANSI C... none needed
>checking for style of include used by make... GNU
>checking dependency style of gcc... gcc3
>checking for a BSD-compatible install... /usr/bin/install -c
>checking for ranlib... ranlib
>checking how to run the C preprocessor... gcc -E
>checking for egrep... grep -E
>checking for ANSI C header files... yes
>checking for sys/types.h... yes
>checking for sys/stat.h... yes
>checking for stdlib.h... yes
>checking for string.h... yes
>checking for memory.h... yes
>checking for strings.h... yes
>checking for inttypes.h... yes
>checking for stdint.h... yes
>checking for unistd.h... yes
>checking bluetooth/bluetooth.h usability... no
>checking bluetooth/bluetooth.h presence... no
>checking for bluetooth/bluetooth.h... no
>configure: error: Bluetooth header files not found
>[plugz]$ make
>make: *** No targets specified and no makefile found.  Stop.
>
>-------------------------------------------------------------------------
>This SF.net email is sponsored by DB2 Express
>Download DB2 Express C - the FREE version of DB2 express and take
>control of your XML. No limits. Just data. Click to get it now.
>http://sourceforge.net/powerbar/db2/
>_______________________________________________
>Bluez-devel mailing list
>Bluez-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
