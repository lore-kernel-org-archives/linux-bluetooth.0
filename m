Return-Path: <cyrus@holtmann.org>
From: "An, Tedd" <tedd.an@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Johan
 Hedberg <johan.hedberg@gmail.com>
Subject: Re: [RFC v2 3/4] Bluetooth: Set file extension to SFI file for
 bootloader mode
Date: Wed, 10 Dec 2014 01:13:21 +0000
Message-ID: <D0ACC2F7.4394%tedd.an@intel.com>
References: <20141208152454.2985e44d@tedd-test>
 <0013894E-DDEA-4A97-8047-E2D4BC7AEDE1@holtmann.org>
In-Reply-To: <0013894E-DDEA-4A97-8047-E2D4BC7AEDE1@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 12/8/14, 9:47 PM, "Marcel Holtmann" <marcel@holtmann.org> wrote:

>Hi Tedd,
>
>> This patch sets extension for firmware file to SFI if the device mode
>> is bootloader.
>>=20
>> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
>> ---
>> drivers/bluetooth/btusb.c | 12 ++++++++++++
>> 1 file changed, 12 insertions(+)
>>=20
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index b3ce85f..0c6eb333 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -1336,6 +1336,7 @@ struct intel_version {
>>=20
>> enum {
>> 	INTEL_FW_MODE_OP,
>> +	INTEL_FW_MODE_BL,
>> };
>>=20
>> static const struct firmware *btusb_setup_intel_get_fw(struct hci_dev
>>*hdev,
>> @@ -1397,6 +1398,17 @@ static const struct firmware
>>*btusb_setup_intel_get_fw(struct hci_dev *hdev,
>> 			return NULL;
>> 		}
>> 		strncpy(ext, "bseq", 4);
>> +	} else if (fw_mode =3D=3D INTEL_FW_MODE_BL) {
>> +		/* If fw_variant is 0x23, the device is already running in
>> +		 * operational mode, so no need to download the firmware
>> +		 */
>> +		if (ver->fw_variant =3D=3D 0x23) {
>> +			BT_INFO("%s: Intel device is running in operation mode",
>> +				hdev->name);
>> +			btusb_check_bdaddr_intel(hdev);
>> +			return NULL;
>> +		}
>> +		strncpy(ext, "sfi", 3);
>> 	} else {
>> 		BT_ERR("%s: Invalid Intel firmware type: %d",
>> 		       hdev->name, fw_mode);
>
>I think you also want to skip looking for ROM patches. I know that in
>theory you can ROM patch the RAM firmware, but that seems a bit pointless
>here since the whole firmware has just been downloaded. So I would prefer
>if we only request the extra configuration based on the hw info. Or is
>there some reason to do it otherwise.

Actually we need to run ROM patching routine (using bseq) even after
running with RAM firmware, in order to update the device specific
configuration parameter (like BDDATA from 7260 and 7265). So we need to
separate here to distinguish between call from ROM patch flow and call
from RAM patch flow.


Regarding fw_variant, when the device is running on bootloader mode, it is
0x06 which needs to download the firmeware. If it is 0x23, it is running
with RAM firmware, so it can skip the firmware downloading.


>
>In addition, I think we want to build the firmware name solely based on
>the hw info from the device. Or does the fw information provide details
>about the bootloader version now. And we would need different firmware
>files depending on which bootloader version is running.

If we use the hw info only for firmware name, it cannot support multiple
SKUs from same product family, for example, new ROM spinned module after
releasing to customer like 7260.

If you concern about weird long firmware file name, we can do something
simpler but it needs something more than hw info.


>
>Regards
>
>Marcel
>

Regards,
Tedd
