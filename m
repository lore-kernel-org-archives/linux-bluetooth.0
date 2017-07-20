Return-Path: <ian@mnementh.co.uk>
Subject: Re: [PATCH] hciattach: bcm43xx: fix the delay timer for firmware
 download
To: Marcel Holtmann <marcel@holtmann.org>, maxin.john@gmail.com
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
 Andy Duan <fugang.duan@nxp.com>, "Maxin B. John" <maxin.john@intel.com>
References: <1500556499-2146-1-git-send-email-maxin.john@gmail.com>
 <0F93CDF6-8019-4744-B02B-0C9BD44F9D0B@holtmann.org>
From: Ian Molton <ian@mnementh.co.uk>
Message-ID: <768de172-bf01-e9ea-a4c9-ea8f46cf5f1d@mnementh.co.uk>
Date: Thu, 20 Jul 2017 23:28:23 +0100
MIME-Version: 1.0
In-Reply-To: <0F93CDF6-8019-4744-B02B-0C9BD44F9D0B@holtmann.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-bluetooth.vger.kernel.org>

On 20/07/17 19:23, Marcel Holtmann wrote:
> 
> However I would prefer if we stop using hciattach and focus on hci_bcm.c support with btattach and serdev.

I can resubmit my serdev driver if you like? It needs a little cleanup
but its been solid here over the last week or two. Mostly its missing
some runtime PM support (I cant test that as my device is crippled and
has no host-wakeup or device-suspend lines).

I cant see a nice way to integrate it with the existing driver due to
the fact that it differs markedly in the routines that need pointers to
the serio structures.

The non-serio version uses a linked list that it traverses during
startup to reconcile the port with the tty. Its a much uglier way to do
it, but kinda by necessity.

Is there any particular issue with having both drivers in-tree?

A lot of legacy hardware will *never* use the serio method as it doesn't
have the information available from firmware as to which serio device it
should attach to. I guess some of the ACPI versions might be adaptable,
but that would require some kind of ACPI->serio mapping that I'm not
sure exists at present? ICBW though?

-Ian
