Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Subject: Re: [PATCH v2 1/2] Bluetooth: hci_bcm: Add support for MINIX Z83-4
 based devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <252d14ef-693e-fd5d-d720-0eae53e2cbf2@gmail.com>
Date: Fri, 6 Oct 2017 20:30:06 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, hdegoede@redhat.com,
        frederic.danis.oss@gmail.com
Message-Id: <1D920EEC-CDED-487A-94E4-F31EA5C6C551@holtmann.org>
References: <252d14ef-693e-fd5d-d720-0eae53e2cbf2@gmail.com>
To: Ian W MORRISON <ianwmorrison@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ian,

> The MINIX NEO Z83-4 and MINIX NEO Z83-4 Pro devices use an AP6255 chip
> for wifi and bluetooth. Bluetooth requires an ACPI device id of BCM2EA4
> with BCM4345 rev C0 firmware.
> 
> This patch adds the device id and to use trigger type IRQF_TRIGGER_FALLING.
> 
> Signed-off-by: ianwmorrison <ianwmorrison@gmail.com>
> 
> ---
> drivers/bluetooth/hci_bcm.c | 8 ++++++++
> 1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index ab1455e63b92..77326eeb6146 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -726,6 +726,13 @@ static const struct dmi_system_id bcm_active_low_irq_dmi_table[] = {
> 			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "ThinkPad 8"),
> 		},
> 	},
> +	{
> +		.ident = "MINIX Z83-4",
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "MINIX"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Z83-4"),
> +		},
> +	},
> 	{ }
> };
> 
> @@ -934,6 +941,7 @@ static const struct acpi_device_id bcm_acpi_match[] = {
> 	{ "BCM2E7C", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
> 	{ "BCM2E95", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
> 	{ "BCM2E96", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
> +	{ "BCM2EA4", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
> 	{ },
> };
> MODULE_DEVICE_TABLE(acpi, bcm_acpi_match);

can you actually add an extract of the ACPI table where the IRQ polarity is described wrongly. I like to have that in the commit message so that this becomes some sort of record.

Regards

Marcel

