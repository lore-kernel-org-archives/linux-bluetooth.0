Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <3e9cdced0806120309i7d7dd9e7ta299c4bd5c325437@mail.gmail.com>
References: <3e9cdced0806120309i7d7dd9e7ta299c4bd5c325437@mail.gmail.com>
Date: Thu, 12 Jun 2008 12:29:06 +0200
Message-Id: <1213266546.17870.44.camel@violet.holtmann.net>
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

> hcitool cc --role=s <bdaddr> 
> establishes a low level ACL connection.
> 
> I have to do that in a self-written tool with error-handling etc.
> How can this be done through the dbus-interface, I've actually found
> no method in the interfaces listed here http://wiki.bluez.org/wiki

you don't have to do that at all. Never ever establish ACL links by
yourself. Let the kernel do it for you.

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
