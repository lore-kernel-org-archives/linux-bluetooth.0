Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200607281203.27951.fexpop@onlinehome.de>
References: <200607271240.49400.fexpop@onlinehome.de>
	<200607281128.09414.fexpop@onlinehome.de>
	<1154079513.2298.20.camel@localhost>
	<200607281203.27951.fexpop@onlinehome.de>
Date: Fri, 28 Jul 2006 12:06:10 +0200
Message-Id: <1154081170.2298.26.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Several problems with bluez-utils 3.1,
	kbluetoothd and a Belkin dongle in Debian
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

Hi Felix,

> > the dbus-test is a Python script. Simple checkout the CVS and use this
> > one. You need to modify DiscoverableTimeout and Mode. No need to update
> > the whole BlueZ packages.
> 
> Here's what I get:
> 
> #./dbus-test
>   File "./dbus-test", line 178
>     @dbus.decorators.explicitly_pass_message
>     ^
> SyntaxError: invalid syntax

no idea what's wrong here. I am not a Python expert.

> BTW, if I could change settings via dbus-test would they be remembered the 
> next time I plug the dongle in?

Yes. All changes over the D-Bus API will be remembered. This is also
includes the device name and the class of device.

> Furthermore, if iscan/pscan options in hcid.conf are not working as before it 
> shoud be mentioned somewhere in the documentation.

This stuff will all go away. It is part of the cleanup process.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
