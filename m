Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1183556624.4951.10.camel@localhost>
References: <1183412947.20815.7.camel@localhost>
	<1183433596.6351.25.camel@aeonflux.holtmann.net>
	<1183462763.4335.17.camel@localhost>
	<1183513706.6351.47.camel@aeonflux.holtmann.net>
	<1183556624.4951.10.camel@localhost>
Date: Thu, 05 Jul 2007 10:10:40 +0200
Message-Id: <1183623040.6351.85.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] dbus problem,   Was:  Only one pand-daemon?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Mats,

> > by default pand listens on all attached dongles. So that should work out
> > of the box.
> > 
> 
> I made an addition to the dbus-configuration in bluez-hcid.conf by
> inserting paths for hci0 and hci1 for root and console like this:
> 
> <policy user="root">
>    <allow own="org.bluez"/>
>    <allow send_path="/org/bluez/hci0"/>
>    <allow send_path="/org/bluez/hci1"/>
> </policy>
> 
> After that a single listening PAN daemon is receptive on both
> usb-dongles. My full configuration is attached here. It was already
> previously expanded, but it was the four lines with 'hci#' that brought
> the magic. I myself and probably other bluez-users, would improve our
> knowledge, could you be so kind as to commenting on what additions
> that could/should be eliminated from my configuration file. Please!

that is non-sense. The pand is not interacting with D-Bus at all. Some
other changes must have made this working for you.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
