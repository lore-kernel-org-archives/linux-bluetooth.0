Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <294019.42469.qm@web31708.mail.mud.yahoo.com>
References: <294019.42469.qm@web31708.mail.mud.yahoo.com>
Date: Mon, 12 Feb 2007 20:36:11 +0100
Message-Id: <1171308971.11774.11.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] installing latest bluez on edgy?
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

Hi Tim,

> is there a binary i can dl?
> 
> or a tutorial on compiling?

not that I know of. However it is straight forward and you should check
the README of the source first.

> also i frequently have to type:
> 
> dbus-send --system --dest=org.bluez /org/bluez/hci0
> org.bluez.Adapter.SetMode string:discoverable
> 
> is there a way to make it so i dont have to type this
> all the time?

This has been extensively discussed. Check the mailing list archive or
use the configuration applet from bluez-gnome.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
