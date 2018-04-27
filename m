Return-Path: <0100016308bf007d-2db8a482-febb-4244-81de-e57ac8ba90fe-000000@amazonses.com>
Subject: Re: [PATCH] Bluetooth: btusb: Only check needs_reset_resume DMI table
 for QCA rome chipsets
To: Hans de Goede <hdegoede@redhat.com>, Marcel Holtmann
 <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, stable@vger.kernel.org,
 Jeremy Cline <jcline@redhat.com>
References: <20180427092643.27140-1-hdegoede@redhat.com>
 <0100016307676ed2-fd5830a5-1933-4fc2-b356-a5112a65579f-000000@email.amazonses.com>
 <55a828e6-01b3-891b-acaa-1bb12aa73a8c@redhat.com>
From: Jeremy Cline <jeremy@jcline.org>
Message-ID: <0100016308bf007d-2db8a482-febb-4244-81de-e57ac8ba90fe-000000@email.amazonses.com>
Date: Fri, 27 Apr 2018 20:15:25 +0000
MIME-Version: 1.0
In-Reply-To: <55a828e6-01b3-891b-acaa-1bb12aa73a8c@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

On 04/27/2018 02:43 PM, Hans de Goede wrote:
> Hi,
> 
> On 04/27/2018 04:00 PM, Jeremy Cline wrote:
>> On 04/27/2018 05:26 AM, Hans de Goede wrote:
>>> Jeremy Cline correctly points out in rhbz#1514836 that a device where
>>> the
>>> QCA rome chipset needs the USB_QUIRK_RESET_RESUME quirk, may also ship
>>> with a different wifi/bt chipset in some configurations.
>>>
>>> If that is the case then we are needlessly penalizing those other
>>> chipsets
>>> with a reset-resume quirk, typically causing 0.4W extra power use
>>> because
>>> this disables runtime-pm.
>>>
>>> This commit moves the DMI table check to a
>>> btusb_check_needs_reset_resume()
>>> helper (so that we can easily also call it for other chipsets) and calls
>>> this new helper only for QCA_ROME chipsets for now.
>>>
>>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1514836
>>> Cc: stable@vger.kernel.org
>>> Cc: Jeremy Cline <jcline@redhat.com>
>>> Suggested-by: Jeremy Cline <jcline@redhat.com>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>>   drivers/bluetooth/btusb.c | 10 +++++++---
>>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>> index f064984c9ec0..15e7cdca6eb5 100644
>>> --- a/drivers/bluetooth/btusb.c
>>> +++ b/drivers/bluetooth/btusb.c
>>> @@ -2863,6 +2863,12 @@ static int btusb_config_oob_wake(struct
>>> hci_dev *hdev)
>>>   }
>>>   #endif
>>>   +static void btusb_check_needs_reset_resume(struct usb_interface
>>> *intf)
>>> +{
>>> +    if (dmi_check_system(btusb_needs_reset_resume_table))
>>> +        interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
>>> +}
>>> +
>>>   static int btusb_probe(struct usb_interface *intf,
>>>                  const struct usb_device_id *id)
>>>   {
>>> @@ -2985,9 +2991,6 @@ static int btusb_probe(struct usb_interface *intf,
>>>       hdev->send   = btusb_send_frame;
>>>       hdev->notify = btusb_notify;
>>>   -    if (dmi_check_system(btusb_needs_reset_resume_table))
>>> -        interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
>>> -
>>>   #ifdef CONFIG_PM
>>>       err = btusb_config_oob_wake(hdev);
>>>       if (err)
>>> @@ -3076,6 +3079,7 @@ static int btusb_probe(struct usb_interface *intf,
>>>           data->setup_on_usb = btusb_setup_qca;
>>>           hdev->set_bdaddr = btusb_set_bdaddr_ath3012;
>>>           set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
>>> +        btusb_check_needs_reset_resume(intf);
>>
>> If we later need the quirk applied to an Intel chipset for a particular
>> DMI, this call would get added to the Intel block and then the quirk
>> would start getting applied to the Intel variety of the XPS 13 9360
>> again, right?
>>
>> I have a feeling that's a rather large "if" and I don't have any idea
>> how likely it is. Is it even something worth worrying about?
> 
> ATM that seems rather unlikely, but we are tracking the USB-ids to
> which the DMI quirks belong (as comments) so we can later switch from
> a dmi-id only check to a combined dmi + usb-id check if necessary.

Makes sense, thanks.

Regards,
Jeremy
