Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <4642E716.1010905@tao-group.com>
References: <4641DA61.8040709@tao-group.com>
	<1178722356.8628.96.camel@aeonflux.holtmann.net>
	<4641E662.6080303@tao-group.com>
	<1178724426.8628.102.camel@aeonflux.holtmann.net>
	<4641EA96.7070204@tao-group.com>
	<1178726532.8628.107.camel@aeonflux.holtmann.net>
	<be976db60705090927n71d22c0an5116c8a1323ed3a3@mail.gmail.com>
	<46420306.8020509@tao-group.com>
	<1178780976.25565.6.camel@aeonflux.holtmann.net>
	<4642E716.1010905@tao-group.com>
Date: Thu, 10 May 2007 11:40:04 +0200
Message-Id: <1178790004.25565.80.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] API documentation?
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

Hi David,

> > Since I haven't heard of hcilib before your post, I am not sure that
> > this holds valid. The BlueZ project doesn't use hcilib and also doesn't
> > support hcilib. So ask the hcilib maintainer.
> 
> Actually I got the name wrong --- I was working off the header files, which
> refer to hcilib. The shared library itself is called libbluetooth, and this is
> shipped as bluez-libs, and is used by hcid itself.

as I said, I've never heard of hcilib and so I have no idea if it is an
actual library or only some additional header files or whatever.

In case of libbluetooth you will find enough examples in bluez-utils and
as you mentioned, hcid is using it.

The HCI raw socket that is used by libbluetooth and hcid is not a nice
programming interface and actually I already have plans to restrict or
completely remove it. The D-Bus abstraction works really nicely and
makes Bluetooth simple. Direct HCI programming is not easy and we needed
two years to get the current hcid in shape for the defined tasks. To
make this point even more clear. Only the kernel should mess around with
HCI directly. Userspace can never get it fully correct.

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
