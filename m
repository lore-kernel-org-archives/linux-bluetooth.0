Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH v2] Bluetooth: hci_bcm: Add BCM2E65 ACPI ID
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <56769547.5020706@gmail.com>
Date: Sun, 20 Dec 2015 13:05:50 +0100
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Frederic Danis <frederic.danis@linux.intel.com>
Message-Id: <113AB4B4-EF1C-475A-BD00-2D57B9E31FD7@holtmann.org>
References: <56769547.5020706@gmail.com>
To: Luka Karinja <luka.karinja@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luka,

> Add BCM2E65 device in acpi_device_id table used on Asus T100TAF.
> 
> Signed-off-by: Luka Karinja <luka.karinja@gmail.com>
> ---
> drivers/bluetooth/hci_bcm.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 3eed35e..5c7c696 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -815,6 +815,7 @@ static const struct hci_uart_proto bcm_proto = {
> #ifdef CONFIG_ACPI
> static const struct acpi_device_id bcm_acpi_match[] = {
>     { "BCM2E39", 0 },
> +    { "BCM2E65", 0 },
>     { "BCM2E67", 0 },
>     { },
> };

Applying: Bluetooth: hci_bcm: Add BCM2E65 ACPI ID
error: patch failed: drivers/bluetooth/hci_bcm.c:815
error: drivers/bluetooth/hci_bcm.c: patch does not apply
Patch failed at 0001 Bluetooth: hci_bcm: Add BCM2E65 ACPI ID

Actually it seems you email client is clearly messing tabs. Use git send-email.

Regards

Marcel

