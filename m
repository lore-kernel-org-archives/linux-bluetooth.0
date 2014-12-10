Return-Path: <cyrus@holtmann.org>
From: "An, Tedd" <tedd.an@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Johan Hedberg" <johan.hedberg@gmail.com>
Subject: Re: [RFC v2 3/4] Bluetooth: Set file extension to SFI file for
 bootloader mode
Date: Wed, 10 Dec 2014 22:08:46 +0000
Message-ID: <D0ADC6E9.1287%tedd.an@intel.com>
References: <20141208152454.2985e44d@tedd-test>
 <0013894E-DDEA-4A97-8047-E2D4BC7AEDE1@holtmann.org>
 <D0ACC2F7.4394%tedd.an@intel.com>
 <8AF5F60E-D558-4D41-A758-0ADD4685BD12@holtmann.org>
In-Reply-To: <8AF5F60E-D558-4D41-A758-0ADD4685BD12@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 12/10/14, 3:25 AM, "Marcel Holtmann" <marcel@holtmann.org> wrote:

>Hi Tedd,
>
>>>> This patch sets extension for firmware file to SFI if the device mode
>>>> is bootloader.
>>>>=20
>>>> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
>>>> ---
>>>> drivers/bluetooth/btusb.c | 12 ++++++++++++
>>>> 1 file changed, 12 insertions(+)
>>>>=20
>>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>>> index b3ce85f..0c6eb333 100644
>>>> --- a/drivers/bluetooth/btusb.c
>>>> +++ b/drivers/bluetooth/btusb.c
>>>> @@ -1336,6 +1336,7 @@ struct intel_version {
>>>>=20
>>>> enum {
>>>> 	INTEL_FW_MODE_OP,
>>>> +	INTEL_FW_MODE_BL,
>>>> };
>>>>=20
>>>> static const struct firmware *btusb_setup_intel_get_fw(struct hci_dev
>>>> *hdev,
>>>> @@ -1397,6 +1398,17 @@ static const struct firmware
>>>> *btusb_setup_intel_get_fw(struct hci_dev *hdev,
>>>> 			return NULL;
>>>> 		}
>>>> 		strncpy(ext, "bseq", 4);
>>>> +	} else if (fw_mode =3D=3D INTEL_FW_MODE_BL) {
>>>> +		/* If fw_variant is 0x23, the device is already running in
>>>> +		 * operational mode, so no need to download the firmware
>>>> +		 */
>>>> +		if (ver->fw_variant =3D=3D 0x23) {
>>>> +			BT_INFO("%s: Intel device is running in operation mode",
>>>> +				hdev->name);
>>>> +			btusb_check_bdaddr_intel(hdev);
>>>> +			return NULL;
>>>> +		}
>>>> +		strncpy(ext, "sfi", 3);
>>>> 	} else {
>>>> 		BT_ERR("%s: Invalid Intel firmware type: %d",
>>>> 		       hdev->name, fw_mode);
>>>=20
>>> I think you also want to skip looking for ROM patches. I know that in
>>> theory you can ROM patch the RAM firmware, but that seems a bit
>>>pointless
>>> here since the whole firmware has just been downloaded. So I would
>>>prefer
>>> if we only request the extra configuration based on the hw info. Or is
>>> there some reason to do it otherwise.
>>=20
>> Actually we need to run ROM patching routine (using bseq) even after
>> running with RAM firmware, in order to update the device specific
>> configuration parameter (like BDDATA from 7260 and 7265). So we need to
>> separate here to distinguish between call from ROM patch flow and call
>> from RAM patch flow.
>
>you had that part in your comments and that is fine. However are we
>expecting only settings or also actual ROM patches on top of the RAM
>firmware.

It will be settings only.

>
>The settings would be fine by just looking for the hw version information
>and could stay the same even if the firmware has been updated to a new
>version.

I got your point. For setting, hw info should be good enough as you
suggested, like we have a default .bseq file.

>
>> Regarding fw_variant, when the device is running on bootloader mode, it
>>is
>> 0x06 which needs to download the firmeware. If it is 0x23, it is running
>> with RAM firmware, so it can skip the firmware downloading.
>
>Got that part as well. What I am looking for is to avoid confusing
>comments in dmesg when the ROM patching firmware is not found since we
>only have settings. My current understanding is that when we are new
>devices, then we load, the firmware, lock for settings file based on hw
>version (skip the first file with the fill hw and sw version) and be done.
>
>>> In addition, I think we want to build the firmware name solely based on
>>> the hw info from the device. Or does the fw information provide details
>>> about the bootloader version now. And we would need different firmware
>>> files depending on which bootloader version is running.
>>=20
>> If we use the hw info only for firmware name, it cannot support multiple
>> SKUs from same product family, for example, new ROM spinned module after
>> releasing to customer like 7260.
>
>But the ROM module would not boot up in bootloader mode? It would be the
>same as the existing ROM modules and just go through the ROM patching.
>For these we will require the full set of hw and sw version information
>to find the right firmware.
>
>For the pure RAM chips that boot up in bootloader mode it should be
>enough to just look for the hw version information to find a firmware.
>The only reason to include sw details would be if we have to load
>different firmware based on the bootloader version (since that is the sw
>we would see at this point).
>
>> If you concern about weird long firmware file name, we can do something
>> simpler but it needs something more than hw info.
>
>It is not the length of the files. It is the quantity of the files. For
>ROM chips there is no other way than keeping. You need all the details to
>pick the right firmware. For RAM chips however we should only include
>enough to pick the right firmware.
>
>Regards
>
>Marcel

I think, for summary, when new device power up in bootloader mode, it will
look for full firmware file (.sfi) with hw and sw info. After downloading
the firmware, it will look for setting file (.bseq) with hw info only.

>
>--
>To unsubscribe from this list: send the line "unsubscribe
>linux-bluetooth" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

Regards,

Tedd
