Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200607281700.24209.fexpop@onlinehome.de>
References: <200607271240.49400.fexpop@onlinehome.de>
	<200607281203.27951.fexpop@onlinehome.de>
	<1154081170.2298.26.camel@localhost>
	<200607281700.24209.fexpop@onlinehome.de>
Date: Fri, 28 Jul 2006 17:07:50 +0200
Message-Id: <1154099270.2298.41.camel@localhost>
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

> > > BTW, if I could change settings via dbus-test would they be remembered
> > > the next time I plug the dongle in?
> >
> > Yes. All changes over the D-Bus API will be remembered. This is also
> > includes the device name and the class of device.
> 
> No, unfortunately the settings I've changed via dbus-test are lost after 
> unplugging the dongle.
> 
> So, I'm stuck again: My system won't be visible after plugging the dongle in 
> unless I manually make it visible again, and there's no way to configure it 
> differently...or am I missing something?

they must stay, because otherwise it is a bug. You did set the
discoverable timeout to zero, do you?

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
