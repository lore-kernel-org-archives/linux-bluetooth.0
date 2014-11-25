Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH v4] ath3k: Add support of MCI 13d3:3408 bt device
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <5473596C.6000100@gmail.com>
Date: Tue, 25 Nov 2014 09:40:48 +0800
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	stable@vger.kernel.org
Message-Id: <D3816634-7F86-4EAC-85A2-DBC23BE56E26@holtmann.org>
References: <5471CFE9.9070109@gmail.com> <4BD80C85-0288-404D-AB39-485359414DC9@holtmann.org> <5471FD0E.4060305@gmail.com> <5473596C.6000100@gmail.com>
To: Dmitry Tunin <hanipouspilot@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitry,

> Add support for bluetooth MCI WB335 (AR9565) Wi-Fi+bt module.
> This bluetooth module requires loading patch and sysconfig by ath3k driver.
> 
> CC: stable@vger.kernel.org
> Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>
> 
> ---
> 
> diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> index d85ced2..086240c 100644
> --- a/drivers/bluetooth/ath3k.c
> +++ b/drivers/bluetooth/ath3k.c
> @@ -105,6 +105,7 @@ static const struct usb_device_id ath3k_table[] = {
>     { USB_DEVICE(0x13d3, 0x3375) },
>     { USB_DEVICE(0x13d3, 0x3393) },
>     { USB_DEVICE(0x13d3, 0x3402) },
> +    { USB_DEVICE(0x13d3, 0x3408) },
>     { USB_DEVICE(0x13d3, 0x3432) },

please just send a clean v5 that I could apply. I have two v4 in my inbox now.

Regards

Marcel

