Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <3837d8b10807250948l20d30a1ld9f2867b382f54f7@mail.gmail.com>
References: <3837d8b10807241238r3284fdb6q60f4c86265146756@mail.gmail.com>
	<2d5a2c100807241345x48a0b1co22975c0fb0e0c8d9@mail.gmail.com>
	<3837d8b10807250948l20d30a1ld9f2867b382f54f7@mail.gmail.com>
Date: Fri, 08 Aug 2008 00:06:40 +0200
Message-Id: <1218146801.7819.40.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] a2dp_write patch
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

Hi Keith,

> > Well done, now Im wondering if it isn't possible to use alsa buffer
> > all the time instead of copying to a temporary buffer?
> 
> You definitely can't depend on the buffer still being there.   There
> are two options, you can just refuse to process any part of the buffer
> that is not a certain size, or you can do what we are trying to do and
> store it off temporarily.   I think the last is the best solution,
> because it makes it easier on the our clients,  we have to deal with
> the extra instead of an application needed to deal with half processed
> buffers.

I applied your patch to the BlueZ 4.x repository. Thanks.

Regards

Marcel



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
