Return-Path: <cyrus@holtmann.org>
Message-ID: <55EDAD50.8030000@linux.intel.com>
Date: Mon, 07 Sep 2015 17:29:20 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 2/4] Bluetooth: hci_bcm: Fix IRQ polarity for T100
References: <1441373747-23042-1-git-send-email-frederic.danis@linux.intel.com> <1441373747-23042-3-git-send-email-frederic.danis@linux.intel.com> <16F8AF0D-420C-45C4-A042-1FCA3BD9DD1C@holtmann.org>
In-Reply-To: <16F8AF0D-420C-45C4-A042-1FCA3BD9DD1C@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Marcel,

On 04/09/2015 21:13, Marcel Holtmann wrote:
> Hi Fred,
>
>> ACPI table for BCM2E39 of T100TA is not correct.
>> Invert irq_polarity for this device.
>>
>> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
>> ---
>> drivers/bluetooth/hci_bcm.c | 21 +++++++++++++++++++++
>> 1 file changed, 21 insertions(+)
>>
>> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
>> index f306541..efb9566 100644
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
>> @@ -546,6 +547,20 @@ static int bcm_resource(struct acpi_resource *ares, void *data)
>> 	return 1;
>> }
>>
>> +/* IRQ polarity of some chipset are not defined correctly in ACPI table. */
>> +static const struct dmi_system_id bcm_wrong_irq_dmi_table[] = {
>> +#if defined(CONFIG_DMI) && defined(CONFIG_X86)
>> +	{
>> +		/* Asus T100TA */
>
> I think instead of a comment you could just fill in .ident here. Or is that suppose to be used for something else?

OK

>> +		.matches = {
>> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "T100TA"),
>
> Why are we not using DMI_EXACT_MATCH here in the first place. We really know which one is broken, correct?

Yes, I will use it.

>> +		},
>> +	},
>> +#endif
>
> What is this #ifdef buying us? Is include/linux/dmi.h in some way that we can not have this defined all the time?

OK, will be removed.

>> +	{ }
>> +};
>> +
>> static int bcm_acpi_probe(struct bcm_device *dev)
>> {
>> 	struct platform_device *pdev = dev->pdev;
>> @@ -608,6 +623,12 @@ static int bcm_acpi_probe(struct bcm_device *dev)
>>
>> 	acpi_dev_get_resources(adev, &resources, bcm_resource, dev);
>>
>> +	if (strstr(id->id, "BCM2E39") &&
>
> Lets not bother with that check and just always run through the DMI table here. Especially when using DMI_EXACT_MATCH that should not be a problem.

OK.
I will also use dmi_system_id.driver_data to store the correct polarity 
for T100TA.

> If however that causes a problem, then I prefer we actually set .driver_data in the ACPI module table and base the check on the .driver_data instead of checking the string here once more.
>
> I really don't know if BCM2E39 is specific to a single design or manufacture or platform. I am not sure how good we are in not accidentally re-using these IDs.
>
>> +	    dmi_check_system(bcm_wrong_irq_dmi_table)) {
>> +		bt_dev_dbg(dev, "Fix irq polarity");
>> +		dev->irq_polarity = !dev->irq_polarity;
>> +	}
>> +
>> 	return 0;
>> }
>> #else

Regards

Fred
