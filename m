Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Apr 2013 13:28:46 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Tedd Ho-Jeong An <tedd.an@intel.com>, linux-bluetooth@vger.kernel.org,
	johan.hedberg@intel.com, don.fry@intel.com
Subject: Re: [PATCH v4] Bluetooth: Add support for Intel Bluetooth device
 [8087:07dc]
Message-ID: <20130418162846.GC10155@joana>
References: <3638763.erUlVvs0at@tedd-ubuntu>
 <20130418041217.GA28913@joana>
 <1466472.WPu0Nr1Sby@tedd-ubuntu>
 <BE8A2B9D-6282-4F70-B044-4CC43C95286A@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BE8A2B9D-6282-4F70-B044-4CC43C95286A@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

* Marcel Holtmann <marcel@holtmann.org> [2013-04-18 09:23:45 -0700]:

> Hi Tedd,
> 
> >>> This patch adds support for Intel Bluetooth device by adding
> >>> btusb_setup_intel() routine that update the device with ROM patch.
> >>> 
> >>> T:  Bus=02 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  4 Spd=12   MxCh= 0
> >>> D:  Ver= 2.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> >>> P:  Vendor=8087 ProdID=07dc Rev= 0.01
> >>> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> >>> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> >>> E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=1ms
> >>> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> >>> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> >>> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> >>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> >>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> >>> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> >>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> >>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> >>> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> >>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> >>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> >>> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> >>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> >>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> >>> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> >>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> >>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> >>> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> >>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> >>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> >>> 
> >>> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> >>> ---
> >>> v4 changes
> >>> - refactored patching routin to separate function
> >>> - changed varaible type for status to u8
> >>> - corrected minor format issues
> >>> 
> >>> drivers/bluetooth/btusb.c |  366 +++++++++++++++++++++++++++++++++++++++++++++
> >>> 1 file changed, 366 insertions(+)
> >>> 
> >>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> >>> index 3d684d2..52c0ec0 100644
> >>> --- a/drivers/bluetooth/btusb.c
> >>> +++ b/drivers/bluetooth/btusb.c
> >>> @@ -23,6 +23,7 @@
> >>> 
> >>> #include <linux/module.h>
> >>> #include <linux/usb.h>
> >>> +#include <linux/firmware.h>
> >>> 
> >>> #include <net/bluetooth/bluetooth.h>
> >>> #include <net/bluetooth/hci_core.h>
> >>> @@ -47,6 +48,7 @@ static struct usb_driver btusb_driver;
> >>> #define BTUSB_BROKEN_ISOC	0x20
> >>> #define BTUSB_WRONG_SCO_MTU	0x40
> >>> #define BTUSB_ATH3012		0x80
> >>> +#define BTUSB_INTEL		0x100
> >>> 
> >>> static struct usb_device_id btusb_table[] = {
> >>> 	/* Generic Bluetooth USB device */
> >>> @@ -207,6 +209,9 @@ static struct usb_device_id blacklist_table[] = {
> >>> 	/* Frontline ComProbe Bluetooth Sniffer */
> >>> 	{ USB_DEVICE(0x16d3, 0x0002), .driver_info = BTUSB_SNIFFER },
> >>> 
> >>> +	/* Intel Bluetooth device */
> >>> +	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL },
> >>> +
> >>> 	{ }	/* Terminating entry */
> >>> };
> >>> 
> >>> @@ -943,6 +948,364 @@ static int btusb_setup_bcm92035(struct hci_dev *hdev)
> >>> 	return 0;
> >>> }
> >>> 
> >>> +struct intel_version {
> >>> +	u8	status;
> >>> +	u8	hw_platform;
> >>> +	u8	hw_variant;
> >>> +	u8	hw_revision;
> >>> +	u8	fw_variant;
> >>> +	u8	fw_revision;
> >>> +	u8	fw_build_num;
> >>> +	u8	fw_build_ww;
> >>> +	u8	fw_build_yy;
> >>> +	u8	fw_patch_num;
> >>> +} __packed;
> >>> +
> >>> +static const struct firmware *btusb_setup_intel_get_fw(struct hci_dev *hdev,
> >>> +						struct intel_version *ver)
> >>> +{
> >>> +	const struct firmware *fw;
> >>> +	char fwname[64];
> >>> +	int ret;
> >>> +
> >>> +	snprintf(fwname, sizeof(fwname),
> >>> +		 "intel/ibt-hw-%x.%x.%x-fw-%x.%x.%x.%x.%x.bseq",
> >>> +		 ver->hw_platform, ver->hw_variant, ver->hw_revision,
> >>> +		 ver->fw_variant,  ver->fw_revision, ver->fw_build_num,
> >>> +		 ver->fw_build_ww, ver->fw_build_yy);
> >>> +
> >>> +	ret = request_firmware(&fw, fwname, &hdev->dev);
> >>> +	if (ret < 0) {
> >>> +		if (ret == -EINVAL) {
> >>> +			BT_ERR("%s Intel firmware file request failed (%d)",
> >>> +			       hdev->name, ret);
> >>> +			return NULL;
> >>> +		}
> >>> +
> >>> +		BT_ERR("%s failed to open Intel firmware file: %s(%d)",
> >>> +		       hdev->name, fwname, ret);
> >>> +
> >>> +		snprintf(fwname, sizeof(fwname), "intel/ibt-default-%x.%x.bseq",
> >>> +			 ver->hw_platform, ver->hw_variant);
> >>> +		if (request_firmware(&fw, fwname, &hdev->dev) < 0) {
> >>> +			BT_ERR("%s failed to open default Intel fw file: %s",
> >>> +			       hdev->name, fwname);
> >>> +			return NULL;
> >>> +		}
> >>> +	}
> >>> +
> >>> +	BT_INFO("%s Intel Bluetooth firmware file: %s", hdev->name, fwname);
> >>> +
> >>> +	return fw;
> >>> +}
> >>> +
> >>> +static int btusb_setup_intel_patching(struct hci_dev *hdev,
> >>> +				      const struct firmware *fw,
> >>> +				      const u8 **curr_fw_ptr,
> >>> +				      int *disable_patch)
> >>> +{
> >>> +	struct sk_buff *skb;
> >>> +	struct hci_command_hdr *cmd;
> >>> +	const u8 *cmd_param;
> >>> +	struct hci_event_hdr *evt = NULL;
> >>> +	const u8 *evt_param = NULL;
> >>> +	const u8 *fw_ptr = *curr_fw_ptr;
> >> 
> >> Why do you need an extra var to keep fw_ptr? can't you just use curr_fw_ptr
> >> directly?
> > 
> > Yes. I can.  I will make a change.
> > 
> >> 
> >>> +	int remain = fw->size - (fw_ptr - fw->data);
> >>> +
> >>> +	/* Read command */
> >>> +	if (remain > HCI_COMMAND_HDR_SIZE &&
> >>> +	    fw_ptr[0] != 0x01) {
> >> 
> >> Apparently you don't need to break line on the if.
> > 
> > ACK.
> > 
> >> 
> >>> +		BT_ERR("%s Intel fw corrupted: invalid cmd read", hdev->name);
> >>> +		return -1;
> >> 
> >> Please return a proper error code.
> > 
> > ACK.
> > 
> >> 
> >>> +	}
> >>> +	fw_ptr++;
> >>> +	remain--;
> >>> +
> >>> +	cmd = (struct hci_command_hdr *)fw_ptr;
> >>> +	fw_ptr += sizeof(*cmd);
> >>> +	remain -= sizeof(*cmd);
> >>> +
> >>> +	/* checking the length */
> >>> +	if (remain < cmd->plen) {
> >>> +		BT_ERR("%s Intel fw corrupted: invalid cmd len", hdev->name);
> >>> +		return -1;
> >> 
> >> Same here and all other places you return -1
> > 
> > ACK.
> > 
> >> 
> >>> +	}
> >>> +
> >>> +	/* If there is a command that loads a patch in the firmware
> >>> +	 * file, then enable the patch upon success, otherwise just
> >>> +	 * disable the manufacturer mode, for example patch activation
> >>> +	 * is not required when the default firmware patch file is used
> >>> +	 * because there are no patch data to load.
> >>> +	 */
> >>> +	if (*disable_patch && cmd->opcode == 0xfc8e)
> >>> +		*disable_patch = 0;
> >>> +
> >>> +	cmd_param = fw_ptr;
> >>> +	fw_ptr += cmd->plen;
> >>> +	remain -= cmd->plen;
> >>> +
> >>> +	/* Read event */
> >>> +	while (remain > HCI_EVENT_HDR_SIZE && fw_ptr[0] == 0x02) {
> >>> +		fw_ptr++;
> >>> +		remain--;
> >>> +
> >>> +		evt = (struct hci_event_hdr *)fw_ptr;
> >>> +		fw_ptr += sizeof(*evt);
> >>> +		remain -= sizeof(*evt);
> >>> +
> >>> +		if (remain < evt->plen) {
> >>> +			BT_ERR("%s Intel fw corrupted: invalid evt len",
> >>> +			       hdev->name);
> >>> +			return -1;
> >>> +		}
> >>> +
> >>> +		evt_param = fw_ptr;
> >>> +		fw_ptr += evt->plen;
> >>> +		remain -= evt->plen;
> >>> +	}
> >>> +
> >>> +	if (!evt || !evt_param || remain < 0) {
> >>> +		BT_ERR("%s Intel fw corrupted: invalid evt read", hdev->name);
> >>> +		return -1;
> >>> +	}
> >>> +
> >>> +	skb = __hci_cmd_sync_ev(hdev, le16_to_cpu(cmd->opcode),
> >>> +				cmd->plen, (void *)cmd_param, evt->evt,
> >>> +				HCI_INIT_TIMEOUT);
> >>> +	if (IS_ERR(skb)) {
> >>> +		BT_ERR("%s sending Intel patch command failed (%ld)",
> >>> +		       hdev->name, PTR_ERR(skb));
> >>> +		return -1;
> >>> +	}
> >>> +
> >>> +	/* Checking the returned event */
> >>> +	if (skb->len != evt->plen) {
> >>> +		BT_ERR("%s mismatch event length", hdev->name);
> >>> +		kfree_skb(skb);
> >>> +		return -1;
> >>> +	}
> >>> +
> >>> +	if (memcmp(skb->data, evt_param, evt->plen)) {
> >>> +		BT_ERR("%s mismatch event parameter", hdev->name);
> >>> +		kfree_skb(skb);
> >>> +		return -1;
> >>> +	}
> >>> +	kfree_skb(skb);
> >>> +
> >>> +	*curr_fw_ptr = fw_ptr;
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static int btusb_setup_intel(struct hci_dev *hdev)
> >>> +{
> >>> +	struct sk_buff *skb;
> >>> +	const struct firmware *fw;
> >>> +	const u8 *fw_ptr;
> >>> +	int disable_patch;
> >>> +	struct intel_version *ver;
> >>> +
> >>> +	u8 mfg_enable[] = { 0x01, 0x00 };
> >>> +	u8 mfg_disable[] = { 0x00, 0x00 };
> >>> +	u8 mfg_reset_deactivate[] = { 0x00, 0x01 };
> >>> +	u8 mfg_reset_activate[] = { 0x00, 0x02 };
> >>> +
> >>> +	BT_DBG("%s", hdev->name);
> >>> +
> >>> +	/* The controller has a bug with the first HCI command send to it
> >> 
> >> s/send/sent/
> > 
> > ACK.
> > 
> >> 
> >>> +	 * returning number of completed commands as zero. This would stall the
> >>> +	 * command processing in the Bluetooth core
> >>> +	 *
> >>> +	 * As a workaround, send HCI Reset command first which will reset the
> >>> +	 * number of completed commands and allow normal command processing
> >>> +	 * from now on
> >>> +	 */
> >>> +	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
> >>> +	if (IS_ERR(skb)) {
> >>> +		BT_ERR("%s sending initial HCI reset command failed (%ld)",
> >>> +		       hdev->name, PTR_ERR(skb));
> >>> +		return -PTR_ERR(skb);
> >>> +	}
> >>> +	kfree_skb(skb);
> >>> +
> >>> +	/* Read Intel specific controller version first to allow selection of
> >>> +	 * which firmware file to load.
> >>> +	 *
> >>> +	 * The returned information are hardware variant and revision plus
> >>> +	 * firmware variant, revision and build number.
> >>> +	 */
> >>> +	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_INIT_TIMEOUT);
> >> 
> >> Could you turn 0xfc05 into a macro that we can actually understand
> > 
> > My older version of patch used macro but I changed it later due to a comments from others.
> > I will make a change back to use macro. I think that will make the code cleaner.
> 
> please leave this as 0xfc05. The comment above is enough. That is why I asked for the comment to put above to explain what this command does.
> 
> There is no real point in creating a macro for this. We will not be releasing the vendor command specification any time soon. So even if you call this HCI_INTEL_FOO it has no extra meaning to anybody reading this. The comment above is way more helpful for anybody who has to review this code then a made up macro.
> 
> And in this specific cases, the macro forces a line split and makes the code even less readable without adding any extra value for the reader.

Okay, so please go with this approach, you can let the cmds code directly in the code.

	Gustavo
