Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH] Another ACPI ID for bcm43241
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAA+NYvQ7bh1Sq4dG3Xp17g5oq_cgxtDpb7-PqJ1mLyDYWg9a9w@mail.gmail.com>
Date: Thu, 21 Jan 2016 12:14:06 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <582B8532-AC7B-40EC-ACAC-A0B9EC7C4AEE@holtmann.org>
References: <CAA+NYvQ7bh1Sq4dG3Xp17g5oq_cgxtDpb7-PqJ1mLyDYWg9a9w@mail.gmail.com>
To: Jaap Jan Meijer <jjmeijer88@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaap,

> I found another ID for the bcm43241 in my HP Omni10's dsdt. With
> attached patch the driver works nicely.
> 
> Kind, regards,
> 
> J.J.
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 5f3de18..11ac590 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -820,6 +820,7 @@ static const struct acpi_device_id bcm_acpi_match[] = {
>        { "BCM2E3D", 0 },
>        { "BCM2E3F", 0 },
>        { "BCM2E40", 0 },
> +       { "BCM2E54", 0 },
>        { "BCM2E64", 0 },
>        { "BCM2E65", 0 },
>        { "BCM2E67", 0 },

please create a proper patch with commit message, export it via git format-patch and send it via git send-email so I can apply it. This one is not something I can apply. And especially not with whitespace damage, no commit message and missing signed-off-by.

Regards

Marcel

