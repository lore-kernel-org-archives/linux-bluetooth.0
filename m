Return-Path: <cyrus@holtmann.org>
Message-ID: <493BC885.5030303@gentoo.org>
Date: Sun, 07 Dec 2008 12:58:45 +0000
From: Daniel Drake <dsd@gentoo.org>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
CC: Luca Santarelli <hrk@users.sourceforge.net>, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bluetooth usb hci: ISSC usb dongle with buggy SCO  support
References: <200812050002.13560.hrk@users.sourceforge.net> <20081207001953.c04b9357.akpm@linux-foundation.org>
In-Reply-To: <20081207001953.c04b9357.akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Andrew Morton wrote:
> commit 12421b40b81d101d7535e03f1af197365adc932b
> Author: Marcel Holtmann <marcel@holtmann.org>
> Date:   Sun Nov 30 12:17:21 2008 +0100
> 
>     Bluetooth: Remove deprecated hci_usb driver
>     
>     The old hci_usb driver has been fully replaced with the new btusb driver
>     and all major distributions switched to the new driver now. This removes
>     it since it should not be used at all anymore.
> 
> so please confirm that btusb correctly supports that hardware?

And if it doesn't, it should be trivial to come up with an equivalent 
patch to modify blacklist_table in btusb.

Daniel
