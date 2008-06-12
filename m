Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <3e9cdced0806120412ic2904bai44cd6eee00179c2f@mail.gmail.com>
References: <3e9cdced0806120309i7d7dd9e7ta299c4bd5c325437@mail.gmail.com>
	<1213266546.17870.44.camel@violet.holtmann.net>
	<3e9cdced0806120337p5043c4celf7092d086f937691@mail.gmail.com>
	<3e9cdced0806120412ic2904bai44cd6eee00179c2f@mail.gmail.com>
Date: Thu, 12 Jun 2008 15:09:44 +0200
Message-Id: <1213276184.17870.52.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] implement hcitool cc call with dbus interface
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

Hi Fritz,

> Ok taking a look at hcitool.c I understand.
> I will simply take the functions hci_open_dev and
> hci_create_connection (provided by bluez-lib) in order to implement
> the 
> hcitool cc call in my application. So the kernel handles the low-level
> stuff like socket-calls etc ....

I am serious here. If you are trying to do this, then you are doing
something wrong. Your application should not deal with low-level ACL
link establishment.

> But anyway is there a way to do that through  the comfortable dbus
> interface? I guess not.

No and that is because it is not needed.

Regards

Marcel



-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
