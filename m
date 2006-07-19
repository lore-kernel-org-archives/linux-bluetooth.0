Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44BE9DE5.7000000@over-here.org>
Date: Thu, 20 Jul 2006 00:02:29 +0300
From: Eran <eran_l@over-here.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Problems with Ambicom BT-2000E
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello,


I am the not-so-proud owner of an Ambicom BT-2000E card.

I tried using it both on a Zaurus running OZ 3.5.4.1 (kernel 2.6.16) and 
a Tablet PC with similar kernel version (might have been 2.6.16.14).

Pcmcia configuration for bluetooth still says this card should get the 
bt950_cs module, which I understood is a goner.

I modified the pcmcia package to use "serial_cs" class bluetooth for 
this device, however - the best I get is that upon insertion of the card 
I get a ttyS0 (I can see on dmesg) and after modifying the bluetooth 
script itself to run hciattach /dev/ttyS0 ericsson - I see on hciconfig 
a device with 00:00:00:00:00:00 as the mac address (which I can't take 
up) and bluetooth will not work.

Can anyone with knowledge about this card direct me? or tell me any 
other way to make this card working under kernel 2.6?


Thank you,

ERan


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
