Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <475B263E.4060801@aircable.net>
References: <1197153708.12292.247.camel@violet> <475B263E.4060801@aircable.net>
Date: Sun, 09 Dec 2007 00:28:29 +0100
Message-Id: <1197156509.12292.251.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] [BlueZ-Announce] Release of bluez-libs-3.23
	and	bluez-utils-3.23
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

Hi Manuel,

> I think there's a bug in the automake scripts, both bluez-libs and
> bluez-utils. In 64 bits systems if there's lib64 present then both
> packages are trying to install to lib instead of lib64. I sent a rather
> simple patch for this, but I think it should be more complex, and it
> didn't applied to libs only utils

the bluez-utils is not installing any libraries. Never has been and
never will be.

For the bluez-libs this is on purpose and you can overwrite it with
--libdir when calling configure. All distros are different and
especially with the new multi-arch stuff.

Regards

Marcel



-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
