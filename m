Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <3e9cdced0806120337p5043c4celf7092d086f937691@mail.gmail.com>
References: <3e9cdced0806120309i7d7dd9e7ta299c4bd5c325437@mail.gmail.com>
	<1213266546.17870.44.camel@violet.holtmann.net>
	<3e9cdced0806120337p5043c4celf7092d086f937691@mail.gmail.com>
Date: Thu, 12 Jun 2008 15:08:31 +0200
Message-Id: <1213276111.17870.50.camel@violet.holtmann.net>
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

> hm but I have to setup a connection manually just like hcitool does
> (hcitool cc --role=s) in my programm.
> Is there now way to do that through the comfortable dbus interface? 
> So just the same as hcitool cc --role=s <bdaddr> (this establishes a
> ACL connection, right? ) but more comfortable to implement
> error-handling etc.

let me repeat this. You should not do this at all! If a layer like
L2CAP, RFCOMM, SDP or whatever needs an ACL link, the kernel will create
it for you. No need to deal with it. So even in the case you issue a
manual HCI_Create_Connection, the kernel will take this down for you
after 2 seconds, if it has no users.

So again, don't deal with low-level ACL links by yourself. Your program
has no idea what it is doing anyway.

> >you don't have to do that at all. Never ever establish ACL links by
> >yourself. Let the kernel do it for you. 
> 
> In which ways does the kernel that for me, or how can I initiate it?
> I thought this can be done with socket-calls etc. as it done by a lot
> of tools like hcitool etc.

Call l2test -P 1 -n <bdaddr> and it will connect to the PSM for SDP and
the kernel will create the ACL in the background for you. Creating an
ACL link only is not useful at all. You always have to run a higher
level protocol.

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
