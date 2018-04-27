Return-Path: <hdegoede@redhat.com>
Subject: Re: [4.15 stable regression] "Bluetooth: btusb: Fix quirk for Atheros
 1525/QCA6174" breaks bluetooth on some devices
From: Hans de Goede <hdegoede@redhat.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Marcel Holtmann <marcel@holtmann.org>, "M. Kristall" <mkpdev@gmail.com>,
 linux-bluetooth@vger.kernel.org
References: <6c97cffb-751f-466d-cd7b-42624fdb18c7@redhat.com>
 <9a752bfc-74bf-25e7-8820-91d1e3163b75@redhat.com>
 <20180425124757.GA29829@kroah.com>
 <e5cbd297-f8b1-2fd0-cd99-cfd39ea55b62@redhat.com>
 <s5hmuxrjusq.wl-tiwai@suse.de>
 <9b2d31fc-be06-cc05-1ec1-3d0f6f1e21bf@redhat.com>
 <s5hsh7igc65.wl-tiwai@suse.de> <s5hk1stu8ln.wl-tiwai@suse.de>
 <ac4374d3-64b9-8a5e-0716-4805bad598ec@redhat.com>
Message-ID: <acf2c235-beb2-6136-cf37-eb1472292b9e@redhat.com>
Date: Fri, 27 Apr 2018 11:23:49 +0200
MIME-Version: 1.0
In-Reply-To: <ac4374d3-64b9-8a5e-0716-4805bad598ec@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 27-04-18 10:57, Hans de Goede wrote:
>> -- 8< --
>> From: Takashi Iwai <tiwai@suse.de>
>> Subject: [PATCH] Bluetooth: btusb: Apply QCQ_ROME setup for BTUSB_ATH3012
>>   quirk, too
>>
>> In commit f44cb4b19ed4 ("Bluetooth: btusb: Fix quirk for Atheros
>> 1525/QCA6174") we tried to address the non-working Atheros BT devices
>> by changing the quirk from BTUSB_ATH3012 to BTUSB_QCQ_ROME.  This made
>> such devices working while it turned out to break other existing chips
>> with the very same USB ID.
>>
>> This is another attempt to tackle the issue.  The essential point to
>> use BTUSB_QCA_ROME is to apply the btusb_setup_qca() and do RAM-
>> patching.  And the previous attempt failed because btusb_setup_qcq()
>> returns -ENODEV if the ROM version doesn't match with the expected
>> ones.  For some devices that have already the "correct" ROM versions,
>> we may just skip the setup procedure and continue the rest.
>>
>> So, this patch applies btusb_setup_qca() also in BTUSB_ATH3012 quirk,
>> and adds a check of the ROM version in the function to skip the setup
>> if the ROM version looks already sane.
>>
>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>> ---
>>   drivers/bluetooth/btusb.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index c8c8b0b8d333..720356320ace 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -2673,6 +2673,10 @@ static int btusb_setup_qca(struct hci_dev *hdev)
>>           return err;
>>       ver_rom = le32_to_cpu(ver.rom_version);
>> +    /* Don't care about high ROM versions */
>> +    if (ver_rom & ~0xffffU)
>> +        return 0;
>> +
>>       for (i = 0; i < ARRAY_SIZE(qca_devices_table); i++) {
>>           if (ver_rom == qca_devices_table[i].rom_version)
>>               info = &qca_devices_table[i];
>> @@ -3055,6 +3059,7 @@ static int btusb_probe(struct usb_interface *intf,
>>       }
>>       if (id->driver_info & BTUSB_ATH3012) {
>> +        data->setup_on_usb = btusb_setup_qca;
>>           hdev->set_bdaddr = btusb_set_bdaddr_ath3012;
>>           set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
>>           set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
>>


p.s.

This change makes the BTUSB_ATH3012 / BTUSB_QCA_ROME code-paths almost
the same, the only difference is the BTUSB_ATH3012 path also setting the
HCI_QUIRK_STRICT_DUPLICATE_FILTER flag. Does anyone know if it perhaps
would be correct to also set that flag for the QCA_ROME chipset and
then unify the 2 code-paths?

Regards,

Hans
