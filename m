Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth Intellimouse Explorer not working
	after reboot
From: Marcel Holtmann <marcel@holtmann.org>
To: Daniel Vollmer <maven@maven.de>
Cc: Marcel Holtmann <bluez-users@lists.sourceforge.net>
In-Reply-To: <475977561.20040824110859@maven.de>
References: <167432047.20040823200031@maven.de>
	 <1093285155.26717.25.camel@pegasus>  <489665030.20040823205505@maven.de>
	 <1093293640.26717.48.camel@pegasus>  <475977561.20040824110859@maven.de>
Content-Type: text/plain
Message-Id: <1093339588.26717.59.camel@pegasus>
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
Date: Tue, 24 Aug 2004 11:26:28 +0200

Hi Daniel,

> > the point in called "hciconfig hci0 noscan" before you call "hidd -K" is
> > that in this case the mouse can't reconnect if you touch it again while
> > your machine is shutting down.
> 
> But as I kill the hidd-daemon directly after issuing "hidd -K", this
> shouldn't be a problem as it wouldn't try to reconnect. Or am I
> missing something?

the mouse will try to reconnect if you press a button or move it. So it
is better to kill the hidd daemon before running "hidd -K". But even in
this case a connection to L2CAP will be established by the mouse. This
can cause troubles too.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
