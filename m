Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1183557790.4951.31.camel@localhost>
References: <1183557790.4951.31.camel@localhost>
Date: Thu, 05 Jul 2007 10:07:05 +0200
Message-Id: <1183622825.6351.77.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Bad transmission rate on second slave-client.
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

> in resolving the issue of two dongles I just posted a
> solution for, something else came up on transmission
> rate. I have this NAP-station running Bluez-utils 3.7
> using Debian Etch and full Dbus-support. Emulating
> future embedded systems I am using two laptops
> 
> 	A:   running Debian Sarge, Broadcom 2045 dongle
> 
> 	B:   running Debian Etch, CSR dongle
> 
> and both are using a privately built Bluez-utils 2.25,
> where my only changes are to switch of dbus, bluepin, 
> and bcm203x. The embedded systems cannot afford the
> space demands of dbus, hence it is switched of. Observe,
> these clients are internally operation without dbus,
> the server/master makes full use of dbus.
> 
> The remarkable thing is that, at first laptop A ran a 
> full speed bluetooth connection for several days, but
> laptop B had minimal speed with heavily fractured packets,
> and in addition forced itself to be a master aginst the
> server configuration. When this upset master-slave relation
> was remedied, laptop B achieved full speed. But to my dismay
> laptop A has now deteroriated to fractional transmission
> and terrible 7-8kbyte rates. In spite, of repeatedly halting
> laptop as well as server, and erasing /var/lib/bluetooth/*
> on both machines, I am presently stuck with this disfunction.
> At present it did not even help to let the two laptops
> establish connections to different dongles on the server,
> now that I managed to resolve that issue.

no idea what you are actually trying. Check your settings and make sure
you use dongles that are known to work correctly.

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
