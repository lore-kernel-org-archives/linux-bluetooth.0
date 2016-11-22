Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Subject: Re: hig_magicmouse HID_BATTERY_QUIRK_IGNORE
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAJxTCxxMvwdrLZnsMsOG4vLDNbYmtdGgAXLofUMLvPvoepTk7Q@mail.gmail.com>
Date: Tue, 22 Nov 2016 22:50:25 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <1E169F84-8B4E-4E63-B9BD-213FBBC1B36E@holtmann.org>
References: <CAJxTCxxMvwdrLZnsMsOG4vLDNbYmtdGgAXLofUMLvPvoepTk7Q@mail.gmail.com>
To: =?utf-8?B?SsOpcsOpbXkgTGFs?= <kapouer@melix.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jeremy,

> i've using this patch for a while, or else
> https://bugzilla.kernel.org/show_bug.cgi?id=103631
> happens (mouse freeze when battery reports).
> 
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -321,6 +321,9 @@
>  { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
>    USB_DEVICE_ID_APPLE_ALU_WIRELESS_ANSI),
>    HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE },
> +  { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
> +    USB_DEVICE_ID_APPLE_MAGICMOUSE),
> +    HID_BATTERY_QUIRK_IGNORE },
>  { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM,
>    USB_DEVICE_ID_ELECOM_BM084),
>    HID_BATTERY_QUIRK_IGNORE },

please send patches to linux-input@vger.kernel.org for HID drivers.

Regards

Marcel

