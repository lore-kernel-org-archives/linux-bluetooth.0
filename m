Return-Path: <cyrus@holtmann.org>
Message-ID: <55F14E85.6020703@linux.intel.com>
Date: Thu, 10 Sep 2015 11:33:57 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 1/3] Bluetooth: hci_bcm: Fix IRQ polarity for T100
References: <1441785286-5840-1-git-send-email-frederic.danis@linux.intel.com> <1441785286-5840-2-git-send-email-frederic.danis@linux.intel.com> <8BF54238-1D33-421A-B46A-F8EA4A49145C@holtmann.org>
In-Reply-To: <8BF54238-1D33-421A-B46A-F8EA4A49145C@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Marcel,

On 09/09/2015 18:13, Marcel Holtmann wrote:
> Hi Fred,
>
>> ACPI table for BCM2E39 of T100TA is not correct.
>> Set correct irq_polarity for this device.
>>
>> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
>> ---
>> drivers/bluetooth/hci_bcm.c | 24 ++++++++++++++++++++++++
>> 1 file changed, 24 insertions(+)
>>
>> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
>> index f306541..6551251 100644
>> --- a/drivers/bluetooth/hci_bcm.c
>> +++ b/drivers/bluetooth/hci_bcm.c
>> @@ -32,6 +32,7 @@
>> #include <linux/gpio/consumer.h>
>> #include <linux/tty.h>
>> #include <linux/interrupt.h>
>> +#include <linux/dmi.h>
>>
>> #include <net/bluetooth/bluetooth.h>
>> #include <net/bluetooth/hci_core.h>
>> @@ -513,6 +514,22 @@ static const struct acpi_gpio_mapping acpi_bcm_default_gpios[] = {
>> };
>>
>> #ifdef CONFIG_ACPI
>> +static u8 acpi_active_low = ACPI_ACTIVE_LOW;
>> +
>> +/* IRQ polarity of some chipsets are not defined correctly in ACPI table. */
>> +static const struct dmi_system_id bcm_wrong_irq_dmi_table[] = {
>> +	{
>> +		.ident = "Asus T100TA",
>> +		.matches = {
>> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR,
>> +					"ASUSTeK COMPUTER INC."),
>> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100TA"),
>> +		},
>> +		.driver_data = &acpi_active_low,
>> +	},
>> +	{ }
>> +};
>> +
>> static int bcm_resource(struct acpi_resource *ares, void *data)
>> {
>> 	struct bcm_device *dev = data;
>> @@ -552,6 +569,7 @@ static int bcm_acpi_probe(struct bcm_device *dev)
>> 	const struct acpi_device_id *id;
>> 	struct acpi_device *adev;
>> 	LIST_HEAD(resources);
>> +	const struct dmi_system_id *dmi_id;
>> 	int ret;
>>
>> 	id = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev->dev);
>> @@ -608,6 +626,12 @@ static int bcm_acpi_probe(struct bcm_device *dev)
>>
>> 	acpi_dev_get_resources(adev, &resources, bcm_resource, dev);
>>
>> +	dmi_id = dmi_first_match(bcm_wrong_irq_dmi_table);
>> +	if (dmi_id) {
>> +		bt_dev_dbg(dev, "Fix irq polarity");
>
> I would actually make this bt_dev_warn, but we do not have that helper at the moment. Might be worth while adding it. These obvious bugs in firmware need to be pointed out and not quietly swallowed.
>
> Also lets be a bit more verbose with these things
>
> 		bt_dev_warn(dev, "%s: Overwriting IRQ polarity to active low", dmi->ident)

OK, I will do this change and add BT_WARN and bt_dev_warn logging macros.

Regards

Fred
