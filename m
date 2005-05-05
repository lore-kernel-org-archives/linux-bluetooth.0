Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Guylhem Aznar <bluez-devel@externe.net>
To: bluez-devel@lists.sourceforge.net
Cc: steve.crane@rococosoft.com
Message-ID: <20050505182213.GA22967@externe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] cross compiling bluez 2.16 for arm (Zaurus)
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
Date: Thu, 5 May 2005 14:22:13 -0400

Hello

While trying to compile 2.16 utils to provide newer packages for
fellow Zaurus users, I got the following error:

arm-linux-gcc -DHAVE_CONFIG_H -I. -I. -I..  -I/home/guylhem/bluez-libs-2.16//include  -I/usr/include -Wall -O2 -c `test -f 'sdptool.c' || echo './'`sdptool.c
/tmp/ccsosFZV.s: Assembler messages:
/tmp/ccsosFZV.s:1094: Error: bad instruction `rorw $8,r4'
/tmp/ccsosFZV.s:1094: Error: bad instruction `rorl $16,r4'
/tmp/ccsosFZV.s:1094: Error: bad instruction `rorw $8,r4'
/tmp/ccsosFZV.s:1096: Error: bad instruction `rorw $8,r3'
/tmp/ccsosFZV.s:1099: Error: bad instruction `rorw $8,r2'
/tmp/ccsosFZV.s:1102: Error: bad instruction `rorw $8,r3'
/tmp/ccsosFZV.s:1105: Error: bad instruction `rorw $8,r2'
/tmp/ccsosFZV.s:1105: Error: bad instruction `rorl $16,r2'
/tmp/ccsosFZV.s:1105: Error: bad instruction `rorw $8,r2'
/tmp/ccsosFZV.s:1108: Error: bad instruction `rorw $8,r3'

This should mean x86 asm sneaked in. However I could not find any.

So I commented out this part. Went fine for a while when I got:

/bin/sh ../libtool --mode=link arm-linux-gcc -I/home/guylhem/bluez-libs-2.16//include  -I/usr/include -Wall -O2   -o hciconfig  hciconfig.o csr.o -L/home/guylhem/bluez-libs-2.16//lib -lbluetooth -L/home/guylhem/bluez-libs-2.16/lib -lbluetooth
arm-linux-gcc -I/home/guylhem/bluez-libs-2.16//include -I/usr/include -Wall -O2 -o hciconfig hciconfig.o csr.o  -L/home/guylhem/bluez-libs-2.16//lib -L/home/guylhem/bluez-libs-2.16/lib -lbluetooth
hciconfig.o: In function `cmd_name':
hciconfig.o(.text+0x10ac): undefined reference to `__ctype_b_loc'
collect2: ld returned 1 exit status
make: *** [hciconfig] Error 1

This is due to an old bug (https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=91290) - I recommand removing ctype.h include to fix that one.

I'm using:
export PATH=/opt/Embedix/tools/bin/:$PATH
for libs:
./configure --host=arm-linux
for utils:
./configure --host=arm-linux  --with-bluez=/home/guylhem/bluez-libs-2.16

and the Embedix tools from http://externe.net/zaurus/sdk/ (gcc 2.95 is the only one binary compatible with the zaurus default rom)

Any clue for sdptool ?

Guylhem


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
