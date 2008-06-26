Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300806260726w7582e5b4lba29322f5ea2b9cd@mail.gmail.com>
Date: Thu, 26 Jun 2008 08:26:03 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <a1c657a80806252303p2563497fs70b548dbbe4f3388@mail.gmail.com>
MIME-Version: 1.0
References: <a1c657a80806252303p2563497fs70b548dbbe4f3388@mail.gmail.com>
Subject: Re: [Bluez-users] Sbc encode optimization
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

Paul

> I see "There are a couple of optimizations the codec could see but it
> performs reasonably on 200MHz+ devices. " on the wiki.bluez.org site.
> Would you tell me how to optimise the sbc encode for arm926ejs? Thanks.

The input data is copied a couple of times inside the encoder. It
would be faster if it was not being copied.

There are places, like the precomputed tables, that could be
represented in 16 bits. There was no advantage to doing this on the TI
arm chip but it might be a different result for other chips.

-- 
Brad

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
