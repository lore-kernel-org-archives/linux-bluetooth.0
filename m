Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH] Bluetooth: hci_bcm: Add BCM2E65 ACPI ID
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <567404F4.5080807@gmail.com>
Date: Sun, 20 Dec 2015 08:10:26 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <9C4CC525-E2A7-4971-B4E0-5A839664B8A7@holtmann.org>
References: <567404F4.5080807@gmail.com>
To: Luka Karinja <luka.karinja@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luka,

> Add BCM2E65 device in acpi_device_id table. Used on Asus T100TAF.
> 
> Signed-off-by: Luka Karinja <luka.karinja@gmail.com>
> ---
> drivers/bluetooth/hci_bcm.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 835bfab..372f7bc 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -546,6 +546,7 @@ static const struct hci_uart_proto bcm_proto = {
> #ifdef CONFIG_ACPI
> static const struct acpi_device_id bcm_acpi_match[] = {
> 	{ "BCM2E39", 0 },
> +	{ "BCM2E65", 0 },
> 	{ "BCM2E67", 0 },
> 	{ },

Applying: Bluetooth: hci_bcm: Add BCM2E65 ACPI ID
error: patch failed: drivers/bluetooth/hci_bcm.c:546
error: drivers/bluetooth/hci_bcm.c: patch does not apply
Patch failed at 0001 Bluetooth: hci_bcm: Add BCM2E65 ACPI ID

Please make sure that patch applies cleanly against bluetooth-next tree.

Regards

Marcel

