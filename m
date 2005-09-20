Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Artem Bizyukov <bizyukov@gmail.com>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <e98637f4050920082942759d50@mail.gmail.com>
References: <e98637f4050920082942759d50@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1127231935.5168.86.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: Re[2]: It may be a bug in hcidump
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
Date: Tue, 20 Sep 2005 17:58:55 +0200

Hi Artem,

> I`m save dump with -w option.  hcidump fail only with -V option. I`m
> tested this tool on the same system but use glibc-2.3.2. The result is
> the same.

the problem is easy, because it is not a valid HCI frame and hcidump is
not doing any robustness checks.

< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 4
  0000: 29 00 00 00                                       )...

A PIN code reply must include the BD_ADDR and not the connection handle.
Install bluez-utils-2.21 (or from CVS) and try again.

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
