Return-Path: <cyrus@holtmann.org>
Date: Mon, 15 Jul 2013 22:14:13 +0200
From: Gustavo Padovan <gustavo@padovan.org>
To: sujith@msujith.org
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] ath3k: Add support for ID 0x13d3/0x3402
Message-ID: <20130715201413.GB21442@joana>
References: <1373860743-8073-1-git-send-email-sujith@msujith.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1373860743-8073-1-git-send-email-sujith@msujith.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sujith,

* sujith@msujith.org <sujith@msujith.org> [2013-07-15 09:29:03 +0530]:

> From: Sujith Manoharan <sujith@msujith.org>
> 
> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=59701
> 
> Signed-off-by: Sujith Manoharan <sujith@msujith.org>
> ---
>  drivers/bluetooth/ath3k.c | 2 ++
>  drivers/bluetooth/btusb.c | 1 +
>  2 files changed, 3 insertions(+)

I would need the output of /sys/kernel/debug/usb/devices for this devices.
We need to keep track of the devices we support. Could you please resend this
patch with this information in the commit message? Thanks.

	Gustavo
