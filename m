Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <95bb57cb0806110251xe9cc530v80224cfd836aef05@mail.gmail.com>
References: <95bb57cb0806110251xe9cc530v80224cfd836aef05@mail.gmail.com>
Date: Wed, 11 Jun 2008 15:15:55 +0200
Message-Id: <1213190155.17870.28.camel@violet.holtmann.net>
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

> i've tried to compile Bluez on macbookpro and came across error:
> 
> /bin/sh ../libtool --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I.
> -I.. -I../include    -Wall -O2 -D_FORTIFY_SOURCE=2 -MT bluetooth.lo
> -MD -MP -MF .deps/bluetooth.Tpo -c -o bluetooth.lo bluetooth.c
> mkdir .libs
>  gcc -DHAVE_CONFIG_H -I. -I.. -I../include -Wall -O2
> -D_FORTIFY_SOURCE=2 -MT bluetooth.lo -MD -MP -MF .deps/bluetooth.Tpo
> -c bluetooth.c  -fno-common -DPIC -o .libs/bluetooth.o
> bluetooth.c:35:20: error: malloc.h: No such file or directory
> In file included from bluetooth.c:39:
> ../include/bluetooth/bluetooth.h:36:20: error: endian.h: No such file
> or directory
> ../include/bluetooth/bluetooth.h:37:22: error: byteswap.h: No such
> file or directory
> 
> does macros included in endian.h & byteswap.h can be coded in a
> portable way ?

I can fix the malloc.h include, because that is not needed, but for the
others, I have no idea. Maybe or maybe not.

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
