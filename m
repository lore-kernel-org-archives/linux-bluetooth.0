Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <95bb57cb0806120201i63c7c753m4d72c9ed9138ee8e@mail.gmail.com>
References: <95bb57cb0806110251xe9cc530v80224cfd836aef05@mail.gmail.com>
	<1213190155.17870.28.camel@violet.holtmann.net>
	<95bb57cb0806120201i63c7c753m4d72c9ed9138ee8e@mail.gmail.com>
Date: Thu, 12 Jun 2008 11:10:55 +0200
Message-Id: <1213261855.17870.42.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] compile on apple
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

Hi Nico,

> following this
> page(http://wiki.openmoko.org/wiki/User:SNMoore#Patch_to_work_around_byteswap.h_and_endian.h_errors_on_OS_X), byteswap macro can be re-written and use  <machine/endian.h> as header
> 
> maybe it worth the try

I don't think so. Especially since it makes no sense to have BlueZ
running on OS X anyway. Without the kernel part it is useless.

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
