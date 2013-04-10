Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [RFC] Bluetooth: Add support for Intel Bluetooth device [8087:07dc]
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1640417.GJq4DRhhap@tedd-ubuntu>
Date: Wed, 10 Apr 2013 09:11:22 -0700
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	don.fry@intel.com, johan.hedberg@intel.com
Message-Id: <6C02E13F-AA1A-43B9-891F-8B42F9111DD8@holtmann.org>
References: <1640417.GJq4DRhhap@tedd-ubuntu>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

> This patch adds support for Intel Bluetooth device by adding
> btusb_setup_intel() routine that updates the device with ROM patch
> during HCI_SETUP.
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
> drivers/bluetooth/btusb.c |  198 +++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 198 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 35c967f..fafa95d 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -23,6 +23,7 @@
> 
> #include <linux/module.h>
> #include <linux/usb.h>
> +#include <linux/firmware.h>
> 
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
> @@ -700,12 +705,205 @@ static int btusb_flush(struct hci_dev *hdev)
> 	return 0;
> }

so I send a patch earlier to update the btusb.c a little bit to make this simpler. Please put the btusb_setup_intel function after the btusb_setup_bcm92035 function.

> 
> +int btusb_setup_intel(struct hci_dev *hdev)
> +{

This needs to be static.

> +	struct sk_buff		*skb;
> +	const struct firmware	*fw = NULL;

I rather do not have NULL assignment here. Instead we make the error exit code a bit smarter.

> +	const u8		*patch_curr;
> +	char			pfile[32];
> +	u8			*m_off_code;
> +
> +	u8 m_on[] = { 0x01, 0x00 };
> +	u8 m_off_1[] = { 0x00, 0x01 };
> +	u8 m_off_2[] = { 0x00, 0x02 };

Shouldn't this be __u8. Johan, any preference. I know that I used __u8 for the bcm92035 vendor command.

Also please use more descriptive names here. mfg_enable, mfg_reset_deactivate, mfg_reset_activate.

> +
> +	BT_DBG("%s", hdev->name);
> +
> +	m_off_code = m_off_2;

Not a huge fan of keeping this around. Our error handlers should just pick the right one. We just need to straighten that part out and then this extra pointer should not be needed.

> +	/* HCI_RESET - this is a workaround due to ncmd is 0 for the first
> +	 * event after booting up the device */

Please follow the coding style for multi-line comments for drivers/net/ and net/ here. And be more descriptive here anyway.

	/* The controller has a bug within the first HCI command send to it returning
	 * number of completed commands as zero. This would stall the command processing
	 * in the Bluetooth core.
	 *
	 * As a workaround, send HCI Reset command first which will reset the number of
	 * completed commands and allow normal command processing from now on.
	 */

Or something similar to this.

> +	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		BT_ERR("__hci_cmd_sync(reset): %ld", PTR_ERR(skb));
> +		goto exit_error;
> +	}
> +	BT_DBG("%s hci reset succeeded", hdev->name);

Please remove these debug statement for the final patch.

> +	kfree_skb(skb);
> +
> +	/* Read Version */

So here I would go also verbose and explain what we are doing.

	/* Read Intel specific controller version first to allow selection of which
	 * firmware file to load.
	 *
	 * The returned information are hardware variant and revision plus firmware variant,	
	 * revision and build number.
	 */

> +	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		BT_ERR("__hci_cmd_sync(version): %ld", PTR_ERR(skb));
> +		goto exit_error;
> +	}
> +	BT_DBG("%s version succeeded", hdev->name);

Same here, remove the debug and instead actually print one line for hardware variant and revision and one for the firmware variant, revision and build number. This will be super useful for debugging in the field when you need to know what is going and why firmware loading failed.

> +
> +	/* Get bseq file name */
> +	snprintf(pfile, 32, "intel/%02x%02x%02x%02x%02x%02x%02x%02x%02x.bseq",
> +				skb->data[1], skb->data[2], skb->data[3],
> +				skb->data[4], skb->data[5], skb->data[6],
> +				skb->data[7], skb->data[8], skb->data[9]);

This magic binary hex string thing is something I do not like at all. Can we not make this at least a little bit nice.

So something like intel/hw-37.7.1.0-fw-10.1.0.bseq or something similar. I would even go that far that you look for a specific firmware version first and if not present, try to load a common one for the hardware.

Also please declare the version struct here. This magic accessing of skb->data is not really easy to read. It makes it hard for me to see if not a typo has sneaked in.

> +	kfree_skb(skb);
> +	BT_DBG("%s patch file: %s", hdev->name, pfile);
> +
> +	/* Open patch file */
> +	if (request_firmware(&fw, pfile, &hdev->dev) < 0) {
> +		BT_ERR("failed to open patch file: %s", pfile);
> +		goto exit_done;

This could be just a negative return here since we have not actually entered the manufacture mode. So no cleanup required. We should also some better -Exxx errors here to differentiate.

> +	}
> +	BT_DBG("%s open patch file succeeded: size: %d", hdev->name, fw->size);
> +
> +	patch_curr = fw->data;

I would just call this variable fw_ptr to make it a bit shorter.

> +
> +	/* Enter mfg mode */

Add some extra comment here on why we enter a special mode. See examples from above.

> +	skb = __hci_cmd_sync(hdev, 0xfc11, 2, m_on, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		BT_ERR("__hci_cmd_sync(mfg on): %ld", PTR_ERR(skb));

Use clear errors here. Using cmd_sync in the error message is not giving anybody any hints. Just use something like "Entering Intel manufacturer mode failed".

> +		goto exit_error;

And here as well, we could just return with an error. There is no cleanup to be done.

> +	}
> +
> +	/* Checking mfg_on event */

No need for this comment really.

> +	if (skb->data[0]) {
> +		BT_ERR("%s mfg_on failed(%02x)", hdev->name, skb->data[0]);
> +		kfree_skb(skb);
> +		goto exit_error;

See comments above.

> +	}
> +	BT_DBG("%s mfg_on succeeded", hdev->name);
> +	kfree_skb(skb);
> +
> +	BT_DBG("%s start patching!!", hdev->name);
> +	/* Patching */

Describe how the patching procedure is done here.

> +	while (1) {
> +		struct hci_command_hdr *cmd;
> +		const u8 *param;
> +		struct hci_event_hdr *evt = NULL;
> +		const u8 *evt_param = NULL;
> +
> +		/* Read cmd */
> +		if (patch_curr[0] != 0x01) {
> +			BT_ERR("%s invalid patch data(cmd)", hdev->name);
> +			m_off_code = m_off_1;
> +			goto exit_mfg;

As mentioned above, use a separate exit and not activate compared to exit and activate.

> +		}
> +		patch_curr++;
> +
> +		cmd = (struct hci_command_hdr *)patch_curr;
> +		patch_curr += sizeof(*cmd);

I think you need a few extra checks to ensure that the file is correct and not corrupted. If you want to put this into a separate helper functions, then that is fine with me.

> +
> +		param = patch_curr;
> +		patch_curr += cmd->plen;
> +
> +		/* Read evt - read the last event if there is more than 1 */
> +		while (patch_curr[0] == 0x02) {
> +			patch_curr++;
> +
> +			evt = (struct hci_event_hdr *)patch_curr;
> +			patch_curr += sizeof(*evt);
> +
> +			evt_param = patch_curr;
> +			patch_curr += evt->plen;
> +		}
> +
> +		if (!evt || !evt_param) {
> +			BT_ERR("%s invalid evt or evt_param data", hdev->name);
> +			m_off_code = m_off_1;
> +			goto exit_mfg;
> +		}
> +
> +		/* Send command based on the evt */
> +		if (evt->evt == HCI_EV_CMD_COMPLETE) {
> +			/* Command Complete Event */
> +			skb = __hci_cmd_sync(hdev, cmd->opcode, cmd->plen,
> +					(void *)param,
> +					HCI_INIT_TIMEOUT);
> +			if (IS_ERR(skb)) {
> +				BT_ERR("__hci_cmd_sync(patch): %ld",
> +						PTR_ERR(skb));
> +				m_off_code = m_off_1;
> +				goto exit_mfg;
> +			}
> +
> +			/* Check the event status */
> +			if (skb->data[0]) {
> +				BT_ERR("%s patch failed(%02x)", hdev->name,
> +						skb->data[0]);
> +				m_off_code = m_off_1;
> +				kfree_skb(skb);
> +				goto exit_mfg;
> +			}
> +		} else {
> +			/* Non Command Complete Event */
> +			skb = __hci_cmd_sync_ev(hdev, cmd->opcode, cmd->plen,
> +					(void *)param, evt->evt,
> +					HCI_INIT_TIMEOUT);
> +			if (IS_ERR(skb)) {
> +				BT_ERR("__hci_cmd_sync_ev(patch): %ld",
> +						PTR_ERR(skb));
> +				m_off_code = m_off_1;
> +				goto exit_mfg;
> +			}
> +
> +			/* Checking the returned event */
> +			if (memcmp(skb->data, evt_param, evt->plen)) {
> +				BT_ERR("%s patch event doesn't match!!",
> +						hdev->name);
> +				m_off_code = m_off_1;
> +				kfree_skb(skb);
> +				goto exit_mfg;
> +			}
> +		}

Check if the __hci_cmd_sync_ev can just take HCI_EV_CMD_COMPLETE as event and it would work the same.

> +		BT_DBG("%s patch cmd succeeded %d of %d",
> +				hdev->name, patch_curr - fw->data, fw->size);
> +		kfree_skb(skb);
> +
> +		/* Checking if EOF */
> +		if (fw->size == patch_curr - fw->data) {
> +			BT_DBG("%s patch completed - EOF", hdev->name);
> +			m_off_code = m_off_2;
> +			break;
> +		} else if (fw->size < patch_curr - fw->data) {
> +			BT_ERR("%s inconsistent patch read size", hdev->name);
> +			m_off_code = m_off_1;
> +			break;
> +		}
> +	}
> +
> +exit_mfg:
> +	/* Exit mfg mode */
> +	BT_DBG("%s mfg_off with %s", hdev->name,
> +			m_off_code == m_off_1 ? "m_off_1" : "m_off_2");
> +	skb = __hci_cmd_sync(hdev, 0xfc11, 2, m_off_code, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		BT_ERR("__hci_cmd_sync(mfg off): %ld", PTR_ERR(skb));
> +		goto exit_error;
> +	}
> +	BT_DBG("%s mfg_off succeeded", hdev->name);
> +	kfree_skb(skb);
> +
> +exit_done:
> +	if (fw)
> +		release_firmware(fw);
> +	BT_DBG("%s btusb_setup_intel() completed", hdev->name);
> +	return 0;
> +
> +exit_error:
> +	if (fw)
> +		release_firmware(fw);
> +	BT_ERR("%s btusb_setup_intel() failed", hdev->name);
> +	return -1;
> +}
> +
> static int btusb_setup(struct hci_dev *hdev)
> {
> 	struct btusb_data *data = hci_get_drvdata(hdev);
> 
> 	BT_DBG("%s", hdev->name);
> 
> +	if (data->driver_info & BTUSB_INTEL) {
> +		return btusb_setup_intel(hdev);
> +	}
> +

See my initial comment. This was a stupid idea of mine to have a generic btusb_setup and call others from it. Just assign the btusb_setup_intel when BTUSB_INTEL is defined and be done with this it. I did send the basic patch to fix this.

> 	if (data->driver_info & BTUSB_BCM92035) {
> 		struct sk_buff *skb;
> 		__u8 val = 0x00;

Regards

Marcel

