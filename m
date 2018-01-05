Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: Intel BT[8087:0025] leads to system auto resume from S3 randomly
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAFv23Qk1zv-Otg_EJXndfiXgxzO2O44JTbV12SJyZapjPwPwaw@mail.gmail.com>
Date: Fri, 5 Jan 2018 15:59:39 +0100
Cc: linux-bluetooth@vger.kernel.org,
        Ethan Hsieh <ethan.hsieh@canonical.com>
Message-Id: <DD31674B-4AE6-4759-9986-0F0736EDBCE3@holtmann.org>
References: <CAFv23Qk1zv-Otg_EJXndfiXgxzO2O44JTbV12SJyZapjPwPwaw@mail.gmail.com>
To: AceLan Kao <acelan.kao@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi AceLan,

> We found an issue that when system enters S3, it stays in S3 for a few
> seconds, and somehow it resumes automatically.
> And we try below quirk which can prevent it from waking up.
> 
> drivers/usb/core/quirks.c
> @@ -208,11 +208,11 @@ static const struct usb_device_id usb_quirk_list[] = {
>                        USB_QUIRK_DISCONNECT_SUSPEND },
>        { USB_DEVICE(0x12d1, 0x15c3), .driver_info =
>                        USB_QUIRK_DISCONNECT_SUSPEND },
> +        { USB_DEVICE(0x8087, 0x0025), .driver_info =
> +                        USB_QUIRK_DISCONNECT_SUSPEND },
> 
> Here are some findings from the system.
> 
> $ lsusb
> Bus 001 Device 004: ID 8087:0025 Intel Corp.

can we be a bit more specific here on what is going on and triage this a bit more. I have not heard of our hardware needing such a broad quirk. Also disconnecting on suspend means that we loose the support for remote wakeup and I am pretty sure that we do not want that.

Regards

Marcel

