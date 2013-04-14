Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v2] Bluetooth: Add support for Intel Bluetooth device [8087:07dc]
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <9783629.ao7UZkXlOD@tedd-ubuntu>
Date: Sat, 13 Apr 2013 20:34:07 -0700
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@intel.com,
	don.fry@intel.com
Message-Id: <56B55E37-411B-4F5D-AD13-4A2AC83D1244@holtmann.org>
References: <9783629.ao7UZkXlOD@tedd-ubuntu>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

> This patch adds support for Intel Bluetooth device by adding
> btusb_setup_intel() routine that update the device with ROM patch.
> 
> This is v2 after running checkpatch script with "strict" option.

this comment does not belong here.

> 
> T:  Bus=02 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  4 Spd=12   MxCh= 0
> D:  Ver= 2.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=8087 ProdID=07dc Rev= 0.01
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=1ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---

The v2 changelog should go here. Otherwise git am turns it into the commit message.

> drivers/bluetooth/btusb.c |  333 +++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 333 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 3d684d2..c8c816b 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -23,6 +23,7 @@
> 
> #include <linux/module.h>
> #include <linux/usb.h>
> +#include <linux/firmware.h>

I just remembered that you most likely need also change the Kconfig to depend on the firmware loader support.

Actually you do not. You will get an -EINVAL error. Might want to print an error in that case. As a general principle, it would be a good idea if btusb.ko itself does not depend on the firmware loader.

> #include <net/bluetooth/bluetooth.h>
> #include <net/bluetooth/hci_core.h>
> @@ -47,6 +48,7 @@ static struct usb_driver btusb_driver;
> #define BTUSB_BROKEN_ISOC	0x20
> #define BTUSB_WRONG_SCO_MTU	0x40
> #define BTUSB_ATH3012		0x80
> +#define BTUSB_INTEL		0x100
> 
> static struct usb_device_id btusb_table[] = {
> 	/* Generic Bluetooth USB device */
> @@ -207,6 +209,9 @@ static struct usb_device_id blacklist_table[] = {
> 	/* Frontline ComProbe Bluetooth Sniffer */
> 	{ USB_DEVICE(0x16d3, 0x0002), .driver_info = BTUSB_SNIFFER },
> 
> +	/* Intel Bluetooth device */
> +	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL },
> +
> 	{ }	/* Terminating entry */
> };
> 
> @@ -943,6 +948,331 @@ static int btusb_setup_bcm92035(struct hci_dev *hdev)
> 	return 0;
> }
> 
> +static const struct firmware *btusb_setup_intel_get_fw(struct hci_dev *hdev,
> +							struct sk_buff *skb,
> +							int *use_default)

> +{
> +	struct intel_fw_version {

Make it intel_version since it is more than just the firmware version.

> +		u8 hw_platform;
> +		u8 hw_variant;
> +		u8 hw_revision;
> +		u8 fw_variant;
> +		u8 fw_revision;
> +		u8 fw_build_num;
> +		u8 fw_build_ww;
> +		u8 fw_build_yy;
> +		u8 fw_patch_num;
> +	} __packed;
> +
> +	struct intel_fw_version	*ver;
> +	const struct firmware	*fw;
> +	char			fwname[64];

Don't bother aligning these with white spaces. We only do that in structs.

> +
> +	if (skb->len != sizeof(*ver)) {
> +		BT_ERR("%s invalid length of Intel firmware version %d",
> +		       hdev->name, skb->len);
> +		return NULL;
> +	}
> +
> +	ver = (void *)skb->data;
> +	snprintf(fwname, sizeof(fwname),
> +		 "intel/ibt-hw-%x.%x.%x-fw-%x.%x.%x.%x.%x-%x.bseq",
> +		 ver->hw_platform, ver->hw_variant, ver->hw_revision,
> +		 ver->fw_variant,  ver->fw_revision, ver->fw_build_num,
> +		 ver->fw_build_ww, ver->fw_build_yy, ver->fw_patch_num);
> +	kfree_skb(skb);

So I am not so sure that this is what we should be doing for the firmware versions.

Lets brainstorm this a little bit. My idea is that we check give an easy way for configuration and firmware handling.

I have a few questions with this. Can we have firmware ROM masks with a pre-patched version already. Meaning can fw_patch_num be something else than 0. If we can not incremental patch anyway, then we should leave that part out and not continue here further.

Also it might be a good idea to look for default settings with hw_platform and hw_variant, but where revision is not relevant so much.

> +
> +	*use_default = 0;

About this one. Lets figure out if we have to activate a patch or not, but doing that in the patching routine and not by a firmware file name. If there is a command that loads a patch in the firmware file, then enable the activate otherwise just disable.

> +
> +	if (request_firmware(&fw, fwname, &hdev->dev) < 0) {
> +		BT_ERR("%s failed to open Intel firmware file: %s",
> +		       hdev->name, fwname);
> +
> +		snprintf(fwname, sizeof(fwname), "intel/ibt-default-%x.bseq",
> +			 ver->hw_variant);
> +		if (request_firmware(&fw, fwname, &hdev->dev) < 0) {
> +			BT_ERR("%s failed to open default Intel fw file: %s",
> +			       hdev->name, fwname);
> +			return NULL;
> +		}
> +
> +		*use_default = 1;
> +	}
> +
> +	BT_INFO("%s Intel Bluetooth firmware file: %s", hdev->name, fwname);
> +
> +	return fw;
> +}
> +
> +#define INTEL_HCI_MFG_MODE	0xfc11
> +#define INTEL_HCI_GET_VER	0xfc05
> +#define INTEL_HCI_CMD		0x01
> +#define INTEL_HCI_EVT		0x02

I am fine if you use this as hex codes in the code. The comment above gives enough explanation and it makes the lines shorter.

> +static int btusb_setup_intel(struct hci_dev *hdev)
> +{
> +	struct sk_buff		*skb;
> +	const struct firmware	*fw;
> +	const u8		*fw_ptr;
> +	int			use_default;
> +
> +	u8 mfg_enable[] = { 0x01, 0x00 };
> +	u8 mfg_no_reset[] = { 0x00, 0x00 };

I would call this one mfg_disable. Previous patch was not needing it, so I did not mention it.

> +	u8 mfg_reset_deactivate[] = { 0x00, 0x01 };
> +	u8 mfg_reset_activate[] = { 0x00, 0x02 };
> +
> +	BT_DBG("%s", hdev->name);
> +
> +	/* The controller has a bug with the first HCI command send to it
> +	 * returning number of completed commands as zero. This would stall the
> +	 * command processing in the Bluetooth core
> +	 *
> +	 * As a workaround, send HCI Reset command first which will reset the
> +	 * number of completed commands and allow normal command processing
> +	 * from now on
> +	 */
> +	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		BT_ERR("%s sending initial HCI reset command failed (%ld)",
> +		       hdev->name, PTR_ERR(skb));
> +		return -PTR_ERR(skb);
> +	}
> +	kfree_skb(skb);
> +
> +	/* Read Intel specific controller version first to allow selection of
> +	 * which firmware file to load.
> +	 *
> +	 * The returned information are hardware variant and revision plus
> +	 * firmware variant, revision and build number.
> +	 */
> +	skb = __hci_cmd_sync(hdev, INTEL_HCI_GET_VER, 0, NULL,
> +			     HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		BT_ERR("%s reading Intel fw version command failed (%ld)",
> +		       hdev->name, PTR_ERR(skb));
> +		return -PTR_ERR(skb);
> +	}
> +

Maybe add just a u8 status to the intel_version struct and make sure to check the length here. I would still print the version details with BT_INFO so we have them in dmesg logging.

Regards

Marcel

