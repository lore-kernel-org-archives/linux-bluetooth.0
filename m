Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] DiNovo /MX900 : some help for the others (and
	questions for me)
From: Marcel Holtmann <marcel@holtmann.org>
To: Di Pietro Nicolas <potens@swing.be>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1087773092.16254.29.camel@darthvader.linuxkot.kap>
References: <1087773092.16254.29.camel@darthvader.linuxkot.kap>
Content-Type: text/plain
Message-Id: <1087788943.4781.170.camel@pegasus>
Mime-Version: 1.0
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
Date: Mon, 21 Jun 2004 05:35:43 +0200

Hi Nicolas,

> I'm writing this to say to you that I'm happy because my DiNovo set
> (with keyboards, mediapad and mouse) works in BT mode !!! yeah, it's
> great.
> Thanks a lot to all the hackers who do that possible ! And for all the
> people who respond to my (sometimes) stupid questions

you are welcome.

> For to people having bad luck with this, here are the steps I followed :
> compile new kernel (2.6.6 or 2.6.7, no matter) with mh patches
> here are the options I used :
> 
> CONFIG_BT_HCIUSB=m
> CONFIG_BT_HCIUSB_SCO=y
> CONFIG_BT_HCIUART=m
> CONFIG_BT_HCIUART_H4=y
> CONFIG_BT_HCIUART_BCSP=y
> CONFIG_BT_HCIUART_BCSP_TXCRC=y
> CONFIG_BT_HCIBCM203X=m
> CONFIG_BT_HCIBFUSB=m
> CONFIG_BT_HCIVHCI=m

You forgot the other options which select the Bluetooth core and the
upper layer protocols.

> CONFIG_NETDEVICES=y
> CONFIG_DUMMY=m

These two has nothing to do with it.

> compile bluez-lib 2.7 and bluez-utils 2.7 (and install it !)
> #modprobe bluetooth
> #modprobe sbp2

You don't need sbp2, because this is the storage layer of IEEE 1394 (aka
Firwire).

> Has someone succeded getting all the buttons to work ?
> I mean only 7 on the 30 special keys of the keyboard works and
> only 5 of the 10 buttons of the mouse work for me.
> 
> If not, is there a way I could help developers with it ? I can't help
> with code (I'm a java developer) but I can send dumps (with hcidumps) or
> I can try some instructions. If someone think it could help, the only
> thing he has to do is to tell it to me, I'll be pleased to give some
> help by this way.

Sorry, no help from me.

> Is there something to do to get the keyboad  working after a reboot ?
> Mine seems (in fact, the hub seems) the stay in BT mode but, it's a bit
> annoying when you've to do something before the /etc/init.d/bluetooth is
> lauched.

The HID proxy mode will refuse keyboards that are not paired. Try to
pair your keyboard with the "hcitool auth ..." command and it should
work.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
