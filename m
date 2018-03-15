Return-Path: <hdegoede@redhat.com>
Subject: Re: [RFC] Bluetooth: hci_bcm: Do not tie GPIO pin order to a specific
 ACPI HID
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20180314135454.8387-1-hdegoede@redhat.com>
 <20180314135454.8387-2-hdegoede@redhat.com>
 <7B14886D-E218-468B-A4E1-0D137BA4B461@holtmann.org>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <f38645fe-96d4-79ec-837d-65af2fac33c3@redhat.com>
Date: Thu, 15 Mar 2018 19:52:40 +0100
MIME-Version: 1.0
In-Reply-To: <7B14886D-E218-468B-A4E1-0D137BA4B461@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 15-03-18 19:36, Marcel Holtmann wrote:
> Hi Hans,
> 
>> Since I've been doing a lot of work on Linux Bay Trail / Cherry Trail
>> support, I've gathered a collection of ACPI DSDTs from about 50 such
>> machines.
>>
>> Looking at these DSTDs many have an ACPI device entry describing a bcm
>> bluetooth device (often disabled in the DSDT), quite a few of these ACPI
>> device entries have a resource-table where the order does not match with
>> the order currently associated with the HID of that entry in the
>> bcm_acpi_match table.
>>
>> Looking at the Windows .inf files, there is nothing indicating a specific
>> order there, so I believe that there is no 1:1 mapping between the ACPI
>> HID and the order in which the resources are listed.
>>
>> Therefor this commit replaces the hardcoded mapping based on ACPI HID,
>> with code which actually checks in which order the resources are listed
>> and bases the gpio-mapping on that.
>>
>> This should ensure that we always pick the right mapping and this will
>> make adding new ACPI HIDs to the driver easier.

<snip>

>> @@ -983,6 +979,30 @@ static int bcm_acpi_probe(struct bcm_device *dev)
>> 	}
>> 	acpi_dev_free_resource_list(&resources);
>>
>> +	/*
>> +	 * If the DSDT uses an Interrupt resource for the IRQ, then there are
>> +	 * only 2 GPIO resources, we use the irq-last mapping for this, since
>> +	 * we already have an irq the 3th / last mapping will not be used.
>> +	 */
> 
> minor nitpick that we use the net multi-line comment style. At least for new comments.

Ok, will fix for the non RFC version. As for the reason why this was RFC,
the problem turned out to be another IRQ polarity issue. I've a more generic
fix for that too now. I will submit 2 series with my work soonish (still need
to run a bunch of tests first).

>> +	if (dev->irq)
>> +		gpio_mapping = acpi_bcm_int_last_gpios;
>> +	else if (dev->gpio_int_idx == 0)
>> +		gpio_mapping = acpi_bcm_int_first_gpios;
>> +	else if (dev->gpio_int_idx == 2)
>> +		gpio_mapping = acpi_bcm_int_last_gpios;
>> +	else
>> +		dev_warn(dev->dev, "Unexpected ACPI gpio_int_idx: %d\n",
>> +			 dev->gpio_int_idx);
>> +
>> +	/* Warn if our expectations are not met. */
>> +	if (dev->gpio_count != (dev->irq ? 2 : 3))
>> +		dev_warn(dev->dev, "Unexpected number of ACPI GPIOs: %d\n",
>> +			 dev->gpio_count);
>> +
>> +	ret = devm_acpi_dev_add_driver_gpios(dev->dev, gpio_mapping);
>> +	if (ret)
>> +		return ret;
>> +
>> 	dmi_id = dmi_first_match(bcm_active_low_irq_dmi_table);
>> 	if (dmi_id) {
>> 		dev_warn(dev->dev, "%s: Overwriting IRQ polarity to active low",
>> @@ -1073,26 +1093,26 @@ static const struct hci_uart_proto bcm_proto = {
>>
>> #ifdef CONFIG_ACPI
>> static const struct acpi_device_id bcm_acpi_match[] = {
>> -	{ "BCM2E1A", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
>> -	{ "BCM2E39", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
>> -	{ "BCM2E3A", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
>> -	{ "BCM2E3D", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
>> -	{ "BCM2E3F", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
>> -	{ "BCM2E40", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
>> -	{ "BCM2E54", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
>> -	{ "BCM2E55", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
>> -	{ "BCM2E64", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
>> -	{ "BCM2E65", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
>> -	{ "BCM2E67", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
>> -	{ "BCM2E71", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
>> -	{ "BCM2E72", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
>> -	{ "BCM2E7B", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
>> -	{ "BCM2E7C", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
>> -	{ "BCM2E7E", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
>> -	{ "BCM2E84", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
>> -	{ "BCM2E95", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
>> -	{ "BCM2E96", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
>> -	{ "BCM2EA4", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
>> +	{ "BCM2E1A" },
>> +	{ "BCM2E39" },
>> +	{ "BCM2E3A" },
>> +	{ "BCM2E3D" },
>> +	{ "BCM2E3F" },
>> +	{ "BCM2E40" },
>> +	{ "BCM2E54" },
>> +	{ "BCM2E55" },
>> +	{ "BCM2E64" },
>> +	{ "BCM2E65" },
>> +	{ "BCM2E67" },
>> +	{ "BCM2E71" },
>> +	{ "BCM2E72" },
>> +	{ "BCM2E7B" },
>> +	{ "BCM2E7C" },
>> +	{ "BCM2E7E" },
>> +	{ "BCM2E84" },
>> +	{ "BCM2E95" },
>> +	{ "BCM2E96" },
>> +	{ "BCM2EA4" },
> 
> Otherwise I like this a lot since it makes thing easier and potentially adding new IDs via new_id should become simple (if that is actually supported for ACPI).

Yes being able to use new_id (or bind) is the idea. Note if this is
supported is not APCI specific, the ACPI code only generates the
modalias, the rest is up to the serdev bus code, which I think
should just work.

Note supporting new_id is only one reason, looking at the DSTDs I
have we're going to run out of luck at one point and have 2 machines
which both use the same ACPI HID but need a different order. I've
made a summary of various settings found in all the DSTDs I've with
BCM2E## ids in them here:

https://fedorapeople.org/~jwrdegoede/bcm-bt-stuff

As you can see there are several cases where the order in the old
bcm_acpi_match does not match with what is in the DSTD. Note not
necessarily all devices with a BCM2E## device in their DSTD actually
have one, because there is a lot of copy and paste going on in
DSTD tables.

Regards,

Hans
