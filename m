Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Di Pietro Nicolas <potens@swing.be>
To: bluez <bluez-users@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1087773092.16254.29.camel@darthvader.linuxkot.kap>
Mime-Version: 1.0
Subject: [Bluez-users] DiNovo /MX900 : some help for the others (and questions for me)
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 21 Jun 2004 01:11:32 +0200

Hi all,
I'm writing this to say to you that I'm happy because my DiNovo set
(with keyboards, mediapad and mouse) works in BT mode !!! yeah, it's
great.
Thanks a lot to all the hackers who do that possible ! And for all the
people who respond to my (sometimes) stupid questions

<help>
For to people having bad luck with this, here are the steps I followed :
compile new kernel (2.6.6 or 2.6.7, no matter) with mh patches
here are the options I used :
<snip>
CONFIG_BT_HCIUSB=m
CONFIG_BT_HCIUSB_SCO=y
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_BCSP_TXCRC=y
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=m
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
</snip>

compile bluez-lib 2.7 and bluez-utils 2.7 (and install it !)
#modprobe bluetooth
#modprobe sbp2

there should be a script named bluetooth in your init.d
#/etc/init.d/bluetooth start

If all works, the BT hub should blink once and all should work !!!

If not, say what append, maybe I've missed a step in this explaination.
</help>

<question>
Has someone succeded getting all the buttons to work ?
I mean only 7 on the 30 special keys of the keyboard works and
only 5 of the 10 buttons of the mouse work for me.

If not, is there a way I could help developers with it ? I can't help
with code (I'm a java developer) but I can send dumps (with hcidumps) or
I can try some instructions. If someone think it could help, the only
thing he has to do is to tell it to me, I'll be pleased to give some
help by this way.

Is there something to do to get the keyboad  working after a reboot ?
Mine seems (in fact, the hub seems) the stay in BT mode but, it's a bit
annoying when you've to do something before the /etc/init.d/bluetooth is
lauched.

</question>

Good luck for the people having this keyboard and, once again,
thanks a lot to the developers.

Nicolas

PS: I've writen a letter to Logitech, they respond me that they won't
nor want to help the developers, they won't write some drivers and
that's all! So, if you own some Logitech device and this device doesn't
work under linux, write them to say that your're not happy to be
ignored. (but do it smartly, please, do give a bad picture of all the
people using Linux or some other free(as free speech, not as pirated) OS
!



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
