Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] dbus.c: cleanup/fix method parameter
	getting
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20051105124837.GA27883@localhost.localdomain>
References: <20051105124837.GA27883@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1131315924.5824.14.camel@blade>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 06 Nov 2005 23:25:24 +0100

Hi Johan,

> The range checking for periodic inquiry and role switch should probably
> also be fixed at some point. However, the controller should return an
> error if invalid values are passed to it, so I'm not even sure that it
> should be hcid's task to check them. What do you think?

we should do our own range check, because the intention is to design an
API and not to simply map the Bluetooth HCI to D-Bus. If we have weird
parameters that doesn't matter in real or are only for internal inside
hcid or the kernel then we leave them out. If we wanna combine to HCI
commands into one D-Bus method then we do this to. So please don't try
to stick to the HCI specification. Try to design some logical API for
Bluetooth.

> Another thing with the inquiry and periodic inquiry methods is that the
> inquiry method allows the caller to specify the num_responses parameter
> while the periodic inquiry method has it hardcoded to 100 currently.
> Should the parameter also be added to periodic inquiry or should it be
> removed from normal inquiry?

See my comment above. The question here is if we need this parameter for
any method call or should we make it a configurable option. So we have a
sane default for num_responses and if somebody wants to use a different
one that a second method to change it is needed.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
