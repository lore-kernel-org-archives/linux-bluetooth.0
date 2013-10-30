Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: [RFC v2 4/7] Bluetooth: Enable 6LoWPAN support for BT LE devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1383123661-15087-5-git-send-email-jukka.rissanen@linux.intel.com>
Date: Wed, 30 Oct 2013 13:11:56 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <4BAC5202-A8F6-4A36-8024-FA97E3FC3554@holtmann.org>
References: <1383123661-15087-1-git-send-email-jukka.rissanen@linux.intel.com> <1383123661-15087-5-git-send-email-jukka.rissanen@linux.intel.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

> Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> ---
> net/bluetooth/6lowpan.c | 1128 ++++++++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 1127 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index aff478b..1cba7fd 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -11,6 +11,20 @@
>    GNU General Public License for more details.
> */
> 
> +/*
> + * The compression, uncompression and IPv6 packet fragmentation code
> + * is from net/ieee802154/6lowpan.c with these copyrights
> + *
> + * Copyright 2011, Siemens AG
> + * written by Alexander Smirnov <alex.bluesman.smirnov@gmail.com>
> + *
> + * Based on patches from Jon Smirl <jonsmirl@gmail.com>
> + * Copyright (c) 2011 Jon Smirl <jonsmirl@gmail.com>
> + *
> + * Jon's code is based on 6lowpan implementation for Contiki which is:
> + * Copyright (c) 2008, Swedish Institute of Computer Science.
> + */
> +

I really think this should consolidated into either net/core/6lowpan.c or net/6lowpan/6lowpan.c.

Regards

Marcel

