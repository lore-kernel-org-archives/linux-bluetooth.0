Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH] Bluetooth: hci_bcm: Add BCM2E55 ACPI ID used in Lenovo ThinkPad Tablet 8
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CA+kEDGHWraudGyTcj9Og+hNKH2kCwFB7P7qvjQhTvQNCXfPOLw@mail.gmail.com>
Date: Wed, 2 Mar 2016 17:41:07 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <187A08C2-4D49-4B28-9FCD-6E94BF9AD4F0@holtmann.org>
References: <CA+kEDGHWraudGyTcj9Og+hNKH2kCwFB7P7qvjQhTvQNCXfPOLw@mail.gmail.com>
To: =?utf-8?Q?J=C3=A9r=C3=B4me_de_Bretagne?=
	<jerome.debretagne@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jerome,

> Lenovo ThinkPad Tablet 8 with BCM43241 rev B5 chipset uses the BCM2E55
> ACPI ID for Bluetooth. Add it to the list of supported devices.
> 
> Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> ---
> drivers/bluetooth/hci_bcm.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index bb4c5a0..d8881dc 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -821,6 +821,7 @@ static const struct acpi_device_id bcm_acpi_match[] = {
>     { "BCM2E3F", 0 },
>     { "BCM2E40", 0 },
>     { "BCM2E54", 0 },
> +    { "BCM2E55", 0 },
>     { "BCM2E64", 0 },
>     { "BCM2E65", 0 },
>     { "BCM2E67", 0 },

you need to use an email client or git send-email which does not garble up the patch.

Regards

Marcel

