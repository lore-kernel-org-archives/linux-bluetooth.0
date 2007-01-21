Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Tobias Lorenz <tobias.lorenz@gmx.net>
To: bluez-devel@lists.sourceforge.net
Date: Sun, 21 Jan 2007 22:54:44 +0100
MIME-Version: 1.0
Message-Id: <200701212254.45812.tobias.lorenz@gmx.net>
Subject: [Bluez-devel] try_to_freeze implicit declaration
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

Hi,

I use linux-2.6.19.2. When trying to compile the snd-bt-sco kernel module, I got the following errors:

<<< snip
root@laptop:/usr/src/downloads/bluetooth-alsa/btsco/kernel# LANG=C make
make[1]: Entering directory `/usr/src/linux-2.6.19'
  CC [M]  /usr/src/downloads/bluetooth-alsa/btsco/kernel/btsco.o
/usr/src/downloads/bluetooth-alsa/btsco/kernel/btsco.c: In function 'snd_card_bt_sco_thread':
/usr/src/downloads/bluetooth-alsa/btsco/kernel/btsco.c:911: warning: implicit declaration of function 'try_to_freeze'
  LD [M]  /usr/src/downloads/bluetooth-alsa/btsco/kernel/snd-bt-sco.o
  Building modules, stage 2.
  MODPOST 1 modules
WARNING: "try_to_freeze" [/usr/src/downloads/bluetooth-alsa/btsco/kernel/snd-bt-sco.ko] undefined!
  CC      /usr/src/downloads/bluetooth-alsa/btsco/kernel/snd-bt-sco.mod.o
  LD [M]  /usr/src/downloads/bluetooth-alsa/btsco/kernel/snd-bt-sco.ko
make[1]: Leaving directory `/usr/src/linux-2.6.19'
<<< snap

This is due to the missing "#include <linux/freezer.h>". I found this by looking at other kernel files using the try_to_freeze function. This following patch corrects the problem:

<<< snip
root@laptop:/usr/src/downloads/bluetooth-alsa/btsco/kernel# cvs diff btsco.c
Index: btsco.c
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/kernel/btsco.c,v
retrieving revision 1.15
diff -r1.15 btsco.c
56a57
> #include <linux/freezer.h>
<<< snap

Bye,
  Toby

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
