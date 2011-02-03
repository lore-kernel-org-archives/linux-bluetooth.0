Return-Path: <cyrus@holtmann.org>
Message-ID: <4D4A60E1.3080000@atheros.com>
Date: Thu, 3 Feb 2011 13:31:37 +0530
From: Bala Shanmugam <sbalashanmugam@atheros.com>
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Luis Rodriguez" <Luis.Rodriguez@Atheros.com>
Subject: Re: [PATCH] linux-firmware: Remove ath3k-2.fw
References: <1296207208-4465-1-git-send-email-sbalashanmugam@atheros.com> <1296719005.12863.28.camel@macbook.infradead.org>
In-Reply-To: <1296719005.12863.28.camel@macbook.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 2/3/2011 1:13 PM, David Woodhouse wrote:
> On Fri, 2011-01-28 at 15:03 +0530, Bala Shanmugam wrote:
>> ath3k-2.fw is obsolete and not use by Atheros chipsets
>> anymore.
> Are you telling me that there is no extant hardware, and no old kernels,
> which would use this? It was added to the linux-firmware tree and
> *never* used?
>
Yes David, no older kernel uses this firmware.
We thought to have new firmware file for newer versions but
our driver patch was not accepted and we decided to
have single firmware for this chipset [ath3k-1.fw].

Thanks and Regards,
Bala.


