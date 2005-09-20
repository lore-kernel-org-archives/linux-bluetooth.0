Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] It may be a bug in hcidump
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <E1EHH9S-0008Z1-00.bizon_art-mail-ru@f13.mail.ru>
References: <E1EHH9S-0008Z1-00.bizon_art-mail-ru@f13.mail.ru>
Content-Type: text/plain
Message-Id: <1127215770.5168.6.camel@localhost.localdomain>
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
Date: Tue, 20 Sep 2005 13:29:30 +0200

Hi,

> < HCI Command: PIN Code Request Reply (0x01|0x000d) plen 4
>     bdaddr  len 160 pin ''
> Segmentation fault
> 
> The previos version of hcidump was work fine.
> My C lib is uClibc-0.9.26. kernel 2.6.13.1-omap1
> My application is simple:

maybe this is uClibc or OMAP specific problem or a general bug in
hcidump. Call "hcidump -w ..." to get a binary dump that I can analyze
on my machine.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
