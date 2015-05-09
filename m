Return-Path: <cyrus@holtmann.org>
Date: Sat, 9 May 2015 04:17:16 -0700
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann
 <marcel@holtmann.org>
Subject: Re: [PATCH] Bluetooth: btusb: Apply Intel device configuration
 routine
Message-ID: <20150509041716.6e10056c@tedd-fedora-vm>
In-Reply-To: <20150508035946.0039963d@intel.com>
References: <20150508035946.0039963d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

I just wonder if you had a chance to review this pacth.

Let me know if you have any comments.

Regards,
Tedd

On Fri, 8 May 2015 03:59:46 -0700
Tedd Ho-Jeong An <tedd.an@intel.com> wrote:

> From: Tedd Ho-Jeong An <tedd.an@intel.com>
> 
> This patch adds support to apply the device configuration parameters
> (DDC) after firwmare downloading on Intel 8265 device.
> 
> This is optional configuration parameters and good to have.
> So, even if it fails to apply it, it is not necessary to fail the
> setup.
> 
> The file format is same as previous firmware patch (.bseq) and
> this is only applicable to Intel 8265 device.
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
>  drivers/bluetooth/btusb.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index d21f3b4..27cd2bf 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2644,6 +2644,40 @@ done:
>  
>  	clear_bit(BTUSB_BOOTLOADER, &data->flags);
>  
> +	/* Once the device is running in operational mode, it needs to apply
> +	 * the configuration parameters to the device.
> +	 */
> +	snprintf(fwname, sizeof(fwname), "intel/ibt-11.bseq");
> +
> +	/* Device can work without this configuration so even if it fails
> +	 * to load the file, no need to fail the setup
> +	 */
> +	err = request_firmware_direct(&fw, fwname, &hdev->dev);
> +	if (err < 0) {
> +		BT_INFO("%s: WARNING: unable to load configuration file (%d)",
> +			hdev->name, err);
> +		return 0;
> +	}
> +
> +	BT_INFO("%s: Found device configuration file: %s", hdev->name, fwname);
> +
> +	fw_ptr = fw->data;
> +	while (fw->size > fw_ptr - fw->data) {
> +		int ignore;
> +
> +		err = btusb_setup_intel_patching(hdev, fw, &fw_ptr,
> +						 &ignore);
> +		if (err < 0) {
> +			BT_INFO("%s: WARNING: failed to send configuration(%d)",
> +				hdev->name, err);
> +			release_firmware(fw);
> +			return 0;
> +		}
> +	}
> +	release_firmware(fw);
> +
> +	BT_INFO("%s: Device configuration completed", hdev->name);
> +
>  	return 0;
>  }
>  
