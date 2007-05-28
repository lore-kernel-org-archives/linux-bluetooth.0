Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200705280119.47962.dgollub@suse.de>
References: <1180273950.15368.42.camel@gilboa-work-dev.localdomain>
	<200705280119.47962.dgollub@suse.de>
Date: Mon, 28 May 2007 10:29:56 +0200
Message-Id: <1180340996.21432.90.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: opsidao@gmail.com
Subject: Re: [Bluez-devel] Suggesting bluez_pinhelper
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Daniel,

> > As some of you may be aware, the current version of kdebluetooth has no
> > support for recent (>= 3.9) bluez DBUS interface.
> Thats correct - it's even quite unmaintained for a while...
> I started at the #1 BlueZ Meeting a kdebluetooth-dbus-integration branch:
> 
> http://websvn.kde.org/branches/work/kdebluetooth-dbus-integration/
> 
> The libkbluetooth got a full rewrite and wraps the full BlueZ DBus API (and 
> the Input Service so far ...) - main goal: avoid any linking against 
> bluez-libs. 
> 
> The kio_slaves (kio_bluetooth, kio_sdp) and kcm_btpaired got ported to the new 
> libkbluetooth API. The kbluetoothd got rewrite and renamed to kbluetooth and 
> is now a "simple" tray icon application like bluez-gnome. And acts as 
> (Default) Passkey Agent and Authorization Agent. It also includes a (very 
> experimental) bluetooth input device wizard which makes use of the BlueZ 
> Input Service.
> 
> Actually i planned to make the first release last week ... but i run out of 
> time. Feel free to give the latest SVN revision a try...

please do releases and do them often. It is important to have releases,
because otherwise nobody really tests the code. Trust me on that one.
Only core developers check out the source from the SCM directly.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
