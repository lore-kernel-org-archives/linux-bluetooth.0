Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] Bluetooth: btusb: Update firmware filename for Intel 9x60
 and,later
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <59B7D929.7060908@linux.intel.com>
Date: Tue, 12 Sep 2017 09:20:52 +0200
Cc: linux-bluetooth@vger.kernel.org, "An, Tedd" <tedd.an@intel.com>,
        anand.kalyanakrishnan@intel.com, ravishankar.srivatsa@intel.com,
        amit.k.bag@intel.com, sukumar.ghorai@intel.com
Message-Id: <4EDDF289-CFEE-4FF7-8D5D-95961EF6C5FE@holtmann.org>
References: <59B7D929.7060908@linux.intel.com>
To: "jaya.p.g" <jaya.p.g@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaya,

> The format of Intel Bluetooth firmware for bootloader product is
> ibt-<hw_variant>-<device_revision_id>.sfi and .ddc.
> 
> But for the SKU's 9x60, there a 3 variants of FW, which cannot be
> differentiated just with hw_variant and devision_revision_id.
> So to pick the appropriate FW file for 9x60 SKU's, it will be
> differentiated using hw_variant, hw_revision and fw_revision rather
> than hw_variant and device_revision_id only.
> 
> Format will be like this:
> ibt-<hw_variant>-<hw_revision>-<fw_revision>.sfi and .ddc
> 
> Signed-off-by: Jaya P G <jaya.p.g@intel.com>
> ---
> drivers/bluetooth/btusb.c | 40 +++++++++++++++++++++++++++++++---------
> 1 file changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 7a5c06a..370cc22 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2151,20 +2151,36 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
> 	}
> 
> 	/* With this Intel bootloader only the hardware variant and device
> -	 * revision information are used to select the right firmware.
> +	 * revision information are used to select the right firmware for SfP
> +	 * and WsP.
> 	 *
> 	 * The firmware filename is ibt-<hw_variant>-<dev_revid>.sfi.
> 	 *
> 	 * Currently the supported hardware variants are:
> 	 *   11 (0x0b) for iBT3.0 (LnP/SfP)
> 	 *   12 (0x0c) for iBT3.5 (WsP)
> +	 *
> +	 * For ThP/JfP and for future SKU's, the FW name varies based on HW
> +	 * variant, HW revision and FW revision, as these are dependent on CNVi
> +	 * and RF Combination.
> +	 *
> 	 *   17 (0x11) for iBT3.5 (JfP)
> 	 *   18 (0x12) for iBT3.5 (ThP)
> +	 *
> +	 * The firmware file name for these will be
> +	 * ibt-<hw_variant>-<hw_revision>-<fw_revision>.sfi.
> +	 *
> 	 */

can you send me the btmon binary traces that include the version information. One from bootloader and also from operational firmware. With the firmware issue currently discussed, we need to make sure that we can find the right firmware name based on information provided by the bootloader, but also from operational firmware.

I frankly don’t like including fw_revision in here. We should solely build the name based on hardware information.

Regards

Marcel

