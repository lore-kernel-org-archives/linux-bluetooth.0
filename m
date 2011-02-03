Return-Path: <cyrus@holtmann.org>
Message-ID: <4D4A4AF4.3030200@atheros.com>
Date: Thu, 3 Feb 2011 11:58:04 +0530
From: Bala Shanmugam <sbalashanmugam@atheros.com>
MIME-Version: 1.0
To: "dwmw2@infradead.org" <dwmw2@infradead.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	<jkumar@atheros.com>, Luis Rodriguez <Luis.Rodriguez@Atheros.com>
Subject: Re: [PATCH] linux-firmware: Remove ath3k-2.fw
References: <1296207208-4465-1-git-send-email-sbalashanmugam@atheros.com>
In-Reply-To: <1296207208-4465-1-git-send-email-sbalashanmugam@atheros.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 1/28/2011 3:03 PM, Shanmugamkamatchi Balashanmugam wrote:
> ath3k-2.fw is obsolete and not use by Atheros chipsets
> anymore.
>
> Signed-off-by: Bala Shanmugam<sbalashanmugam@atheros.com>
> ---
>   WHENCE     |    9 ---------
>   ath3k-2.fw |  Bin 246804 ->  0 bytes
>   2 files changed, 0 insertions(+), 9 deletions(-)
>   delete mode 100644 ath3k-2.fw
>
> diff --git a/WHENCE b/WHENCE
> index 1cbd0a6..c022b4a 100644
> --- a/WHENCE
> +++ b/WHENCE
> @@ -1306,15 +1306,6 @@ Licence: Redistributable, provided by Realtek in their driver
>
>   --------------------------------------------------------------------------
>
> -Driver: DFU Driver for Atheros bluetooth chipset AR3011
> -
> -File: ath3k-2.fw
> -Info: v2.0
> -
> -Licence: Redistributable. See LICENCE.atheros_firmware for details
> -
> ---------------------------------------------------------------------------
> -
>   Driver: lgs8gxx - Legend Silicon GB20600 demodulator driver
>
>   File: lgs8g75.fw
> diff --git a/ath3k-2.fw b/ath3k-2.fw
> deleted file mode 100644
> index 3fa8cff36301a7005936d54a407d6879923aa354..0000000000000000000000000000000000000000
> GIT binary patch
> literal 0
> HcmV?d00001
>
> literal 246804
>
Hi David,

Can you please upload this patch sent before.

Regards,
Bala.

