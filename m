Return-Path: <hdegoede@redhat.com>
Subject: Re: [RFC] Bluetooth: btusb: Use DMI matching for QCA reset_resume
 quirking
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Bluez mailing list <linux-bluetooth@vger.kernel.org>,
 stable <stable@vger.kernel.org>, Brian Norris <briannorris@chromium.org>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>
References: <20180219143729.15985-1-hdegoede@redhat.com>
 <20180219143729.15985-2-hdegoede@redhat.com>
 <606AE5C9-7663-4285-A01B-32E2CAA0DE7F@holtmann.org>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <f71254af-d831-211e-31d5-ee55cb18dd31@redhat.com>
Date: Mon, 19 Feb 2018 17:37:06 +0100
MIME-Version: 1.0
In-Reply-To: <606AE5C9-7663-4285-A01B-32E2CAA0DE7F@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 19-02-18 16:33, Marcel Holtmann wrote:
> Hi Hans,
> 
>> Commit 61f5acea8737 ("Bluetooth: btusb: Restore QCA Rome suspend/resume fix
>> with a "rewritten" version") applied the USB_QUIRK_RESET_RESUME to all QCA
>> btusb devices. But it turns out that the resume problems are not caused by
>> the QCA Rome chipset, on most platforms it resumes fine. The resume
>> problems are actually a platform problem (likely the platform cutting all
>> power when suspended).
>>
>> The USB_QUIRK_RESET_RESUME quirk also disable runtime suspend, so by
>> matching on usb-ids, we're causing all boards with these chips to use extra
>> power, to fix resume problems which only happen on some boards.
>>
>> This commit fixes this by applying the quirk based on DMI matching instead
>> of on usb-ids, so that we match the platform and not the chipset.
> 
> just for the record, can we include the /sys/kernel/debug/usb/devices for that device here.

Will do.

>> Fixes: 61f5acea8737 ("Bluetooth: btusb: Restore QCA Rome suspend/resume..")
>> Cc: stable@vger.kernel.org
>> Cc: Brian Norris <briannorris@chromium.org>
>> Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> drivers/bluetooth/btusb.c | 26 ++++++++++++++++++++------
>> 1 file changed, 20 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index 2a55380ad730..a6023667f3b4 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -21,6 +21,7 @@
>>   *
>>   */
>>
>> +#include <linux/dmi.h>
>> #include <linux/module.h>
>> #include <linux/usb.h>
>> #include <linux/usb/quirks.h>
>> @@ -379,6 +380,22 @@ static const struct usb_device_id blacklist_table[] = {
>> 	{ }	/* Terminating entry */
>> };
>>
>> +/*
>> + * The btusb build into some devices needs to be reset on resume, this is a
> 
> Actually “btusb” is a driver name. So “Bluetooth USB modules”
> 
>> + * problem with the platform (likely shutting off all power) not with the
>> + * btusb chip itself. So we use a DMI list to match known broken platforms.
> 
> Here s/btusb/module/
> 
>> + */
>> +static const struct dmi_system_id btusb_plat_needs_reset_resume_list[] = {
> 
> I prefer to use _table instead of _list. Also drop the _plat_ part since that seems obvious.
> 
>> +	{
>> +		/* Lenovo yoga 920 */
> 
> Use “Yoga" please.

I will fix all of the above.

> And I would include “(QCA Rome device VID:PID)” so that we have a record of some sorts.
> 
>> +		.matches = {
>> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> +			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo YOGA 920”),
> 
> No DMI_EXACT_MATCH?

The DMI data actually has:

"Lenovo YOGA 920-13IKB"

I'm not using DMI_EXACT_MATCH on purpose here, I think Lenovo
might change the "-13IKB" part and I don't expect them to fix
this bug on newer revisions.

Regards,

Hans


> 
>> +		},
>> +	},
>> +	{}
>> +};
>> +
>> #define BTUSB_MAX_ISOC_FRAMES	10
>>
>> #define BTUSB_INTR_RUNNING	0
>> @@ -2945,6 +2962,9 @@ static int btusb_probe(struct usb_interface *intf,
>> 	hdev->send   = btusb_send_frame;
>> 	hdev->notify = btusb_notify;
>>
>> +	if (dmi_check_system(btusb_plat_needs_reset_resume_list))
>> +		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
>> +
>> #ifdef CONFIG_PM
>> 	err = btusb_config_oob_wake(hdev);
>> 	if (err)
>> @@ -3031,12 +3051,6 @@ static int btusb_probe(struct usb_interface *intf,
>> 	if (id->driver_info & BTUSB_QCA_ROME) {
>> 		data->setup_on_usb = btusb_setup_qca;
>> 		hdev->set_bdaddr = btusb_set_bdaddr_ath3012;
>> -
>> -		/* QCA Rome devices lose their updated firmware over suspend,
>> -		 * but the USB hub doesn't notice any status change.
>> -		 * explicitly request a device reset on resume.
>> -		 */
>> -		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
>> 	}
> 
> It is all cosmetic. So otherwise this looks good.
> 
> Regards
> 
> Marcel
> 
