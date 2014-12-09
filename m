Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [RFC v2 3/4] Bluetooth: Set file extension to SFI file for bootloader mode
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20141208152454.2985e44d@tedd-test>
Date: Tue, 9 Dec 2014 06:47:08 +0100
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <0013894E-DDEA-4A97-8047-E2D4BC7AEDE1@holtmann.org>
References: <20141208152454.2985e44d@tedd-test>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

> This patch sets extension for firmware file to SFI if the device mode
> is bootloader.
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
> drivers/bluetooth/btusb.c | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index b3ce85f..0c6eb333 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1336,6 +1336,7 @@ struct intel_version {
> 
> enum {
> 	INTEL_FW_MODE_OP,
> +	INTEL_FW_MODE_BL,
> };
> 
> static const struct firmware *btusb_setup_intel_get_fw(struct hci_dev *hdev,
> @@ -1397,6 +1398,17 @@ static const struct firmware *btusb_setup_intel_get_fw(struct hci_dev *hdev,
> 			return NULL;
> 		}
> 		strncpy(ext, "bseq", 4);
> +	} else if (fw_mode == INTEL_FW_MODE_BL) {
> +		/* If fw_variant is 0x23, the device is already running in
> +		 * operational mode, so no need to download the firmware
> +		 */
> +		if (ver->fw_variant == 0x23) {
> +			BT_INFO("%s: Intel device is running in operation mode",
> +				hdev->name);
> +			btusb_check_bdaddr_intel(hdev);
> +			return NULL;
> +		}
> +		strncpy(ext, "sfi", 3);
> 	} else {
> 		BT_ERR("%s: Invalid Intel firmware type: %d",
> 		       hdev->name, fw_mode);

I think you also want to skip looking for ROM patches. I know that in theory you can ROM patch the RAM firmware, but that seems a bit pointless here since the whole firmware has just been downloaded. So I would prefer if we only request the extra configuration based on the hw info. Or is there some reason to do it otherwise.

In addition, I think we want to build the firmware name solely based on the hw info from the device. Or does the fw information provide details about the bootloader version now. And we would need different firmware files depending on which bootloader version is running.

Regards

Marcel

