Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: Bluetooth: hci_intel: Update firmware filename for Intel 9x60 and
 later
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1516671220.15252.5.camel@linux.intel.com>
Date: Tue, 23 Jan 2018 09:20:40 +0100
Cc: linux-bluetooth@vger.kernel.org, amit.k.bag@intel.com,
        tedd.an@intel.com
Message-Id: <9B59984D-DAC9-43D3-BECD-5525DECC915E@holtmann.org>
References: <1516671220.15252.5.camel@linux.intel.com>
To: Tedd Ho-Jeong An <tedd.an@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,


> From: Tedd Ho-Jeong An <tedd.an@intel.com>
> Bluetooth: hci_intel: Update firmware filename for Intel 9x60 and later

something went wrong here. I prefer using git format-patch and git send-email.

> 
> The format of Intel Bluetooth firmware for bootloader product is
> ibt-<hw_variant>-<device_revision_id>.sfi and .ddc.
> 
> But for the 9x60 SKU, there are three variants of FW, which cannot be
> differenticate just with hw_variant and device_revision_id.
> So, to pick the appropriate FW file for 9x60 SKU, three fields,
> hw_variant, hw_revision, and fw_revision, needs to be used rather than
> hw_variant and device_revision_id.
> 
> Format will be like this:
> ibt-<hw_variant>-<hw_revision>-<fw_revision>.sfi and .ddc
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
>  drivers/bluetooth/hci_intel.c | 56 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 49 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
> index aad07e4..a3a4ea8 100644
> --- a/drivers/bluetooth/hci_intel.c
> +++ b/drivers/bluetooth/hci_intel.c
> @@ -708,16 +708,43 @@ static int intel_setup(struct hci_uart *hu)
>  	}
>  
>  	/* With this Intel bootloader only the hardware variant and device
> -	 * revision information are used to select the right firmware.
> +	 * revision information are used to select the right firmware for SfP
> +	 * and WsP.
>  	 *
>  	 * The firmware filename is ibt-<hw_variant>-<dev_revid>.sfi.
>  	 *
>  	 * Currently the supported hardware variants are:
>  	 *   11 (0x0b) for iBT 3.0 (LnP/SfP)
> +	 *   12 (0x0c) for iBT3.5 (WsP)

iBT 3.5 please (with a space in between).

> +	 *
> +	 * For ThP/JfP and for future SKU's, the FW name varies based on HW
> +	 * variant, HW revision and FW revision, as these are dependent on CNVi
> +	 * and RF Combination.
> +	 *
> +	 *   18 (0x12) for iBT3.5 (Pulsar/ThP)

Actually lets list ThP and JfP here. Pulsar is not meaningful.

> +	 *
> +	 * The firmware file name for these will be
> +	 * ibt-<hw_variant>-<hw_revision>-<fw_revision>.sfi.
> +	 *
>  	 */
> -	snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u.sfi",
> -		le16_to_cpu(ver.hw_variant),
> -		le16_to_cpu(params->dev_revid));
> +	switch (ver.hw_variant) {
> +	case 0x0b:      /* SfP */
> +	case 0x0c:      /* WsP */
> +		snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u.sfi",
> +			 le16_to_cpu(ver.hw_variant),
> +			 le16_to_cpu(params->dev_revid));
> +		break;
> +	case 0x12:      /* ThP */
> +		snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u-%u.sfi",
> +			 le16_to_cpu(ver.hw_variant),
> +			 le16_to_cpu(ver.hw_revision),
> +			 le16_to_cpu(ver.fw_revision));
> +		break;
> +	default:
> +		bt_dev_err(hdev, "Unsupported Intel hardware variant (%u)",
> +			   ver.hw_variant);
> +		return -EINVAL;
> +	}
>  
>  	err = request_firmware(&fw, fwname, &hdev->dev);
>  	if (err < 0) {
> @@ -730,9 +757,24 @@ static int intel_setup(struct hci_uart *hu)
>  	bt_dev_info(hdev, "Found device firmware: %s", fwname);
>  
>  	/* Save the DDC file name for later */
> -	snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u.ddc",
> -		le16_to_cpu(ver.hw_variant),
> -		le16_to_cpu(params->dev_revid));
> +	switch (ver.hw_variant) {
> +	case 0x0b:      /* SfP */
> +	case 0x0c:      /* WsP */
> +		snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u.ddc",
> +			 le16_to_cpu(ver.hw_variant),
> +			 le16_to_cpu(params->dev_revid));
> +	break;

Missing tab here.

> +	case 0x12:      /* ThP */
> +		snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u-%u.ddc",
> +			 le16_to_cpu(ver.hw_variant),
> +			 le16_to_cpu(ver.hw_revision),
> +			 le16_to_cpu(ver.fw_revision));
> +		break;
> +	default:
> +		bt_dev_err(hdev, "Unsupported Intel hardware variant (%u)",
> +			   ver.hw_variant);
> +		return -EINVAL;
> +	}
>  
>  	kfree_skb(skb);

Regards

Marcel

