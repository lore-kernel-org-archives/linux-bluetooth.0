Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <8c7950360712120508j3da5da11sf79e1c321cc37865@mail.gmail.com>
References: <8c7950360712120508j3da5da11sf79e1c321cc37865@mail.gmail.com>
Date: Wed, 12 Dec 2007 16:49:26 +0100
Message-Id: <1197474566.5644.12.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-users] PAN security questions
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

Hi Shane,

> PAND MAN file lists the following options regarding security:
> --encrypt -E
>     Enable encryption
> --secure -S
>     Secure connection
> 
> The PAND howto (http://bluez.sourceforge.net/contrib/HOWTO-PAN)
> explains --encrypt as follows:
>      "activates BT security (authentication and encryption)"
> 
> so then what does the option --secure do?

the --encrypt does authentication and then encrypt the link. With the
--secure you do the authentication, then encrypt the link and then make
sure the link key will be re-generated. It is an extra step of
protection since the link key itself has no expiration date.

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
