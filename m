Return-Path: <cyrus@holtmann.org>
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@intel.com, don.fry@intel.com, gustavo@padovan.org
Subject: Re: [PATCH v6] Bluetooth: Add support for Intel Bluetooth device [8087:07dc]
Date: Fri, 19 Apr 2013 09:37:34 -0700
Message-ID: <4621368.dgD9J29ZcX@tedd-ubuntu>
In-Reply-To: <6F77B4B7-2A24-4FD4-A833-FF2CCC715DD3@holtmann.org>
References: <227727795.ov4BGilfep@tedd-ubuntu> <6F77B4B7-2A24-4FD4-A833-FF2CCC715DD3@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, Marcel,

On Friday, April 19, 2013 07:16:54 AM Marcel Holtmann wrote:
> Hi Tedd,
> 
> > +struct intel_version {
> > +	u8	status;
> > +	u8	hw_platform;
> > +	u8	hw_variant;
> > +	u8	hw_revision;
> > +	u8	fw_variant;
> > +	u8	fw_revision;
> > +	u8	fw_build_num;
> > +	u8	fw_build_ww;
> > +	u8	fw_build_yy;
> > +	u8	fw_patch_num;
> > +} __packed;
> 
> I just realized that you might not need to use tabs here to align the names. You can just use one space in between. However here I am not even sure what the official net/ coding style is.

I checked hci.h as an example but it wasn't consistent. some place used tab but some place used space(?) to align. 
I will change to space here.

> > +	/* If there is a command that loads a patch in the firmware
> > +	 * file, then enable the patch upon success, otherwise just
> > +	 * disable the manufacturer mode, for example patch activation
> > +	 * is not required when the default firmware patch file is used
> > +	 * because there are no patch data to load.
> > +	 */
> > +	if (*disable_patch && __constant_le16_to_cpu(cmd->opcode) == 0xfc8e)
> 
> This has to be the other way around.
> 
> 		cmd->opcode == __constant_cpu_to_le16(0xfc8e)
> 
> Or you need to use le16_to_cpu(cmd->opcode) like you do below. It is just an optimization to use the constant version on a real constant.

That's what I was a little confused. I will use the second method (le16_to_cpu(cmd->opcode)) to align with other code below.

> 
> > +		*disable_patch = 0;
> > +
> > +	cmd_param = *fw_ptr;
> > +	*fw_ptr += cmd->plen;
> > +	remain -= cmd->plen;
> > +
> > +	/* This reads the expected events when the above command is sent to the
> > +	 * device. Some vendor commands expects more than one events, for
> > +	 * example command status event followed by vendor specific event.
> > +	 * For this case, it only keeps the last expected event. so the command
> > +	 * can be sent with __hci_cmd_sync_ev() which returns the sk_buff of
> > +	 * last expected event.
> > +	 */
> > +	while (remain > HCI_EVENT_HDR_SIZE && *fw_ptr[0] == 0x02) {
> > +		(*fw_ptr)++;
> > +		remain--;
> > +
> > +		evt = (struct hci_event_hdr *)(*fw_ptr);
> > +		*fw_ptr += sizeof(*evt);
> > +		remain -= sizeof(*evt);
> > +
> > +		if (remain < evt->plen) {
> > +			BT_ERR("%s Intel fw corrupted: invalid evt len",
> > +			       hdev->name);
> > +			return -EFAULT;
> > +		}
> > +
> > +		evt_param = *fw_ptr;
> > +		*fw_ptr += evt->plen;
> > +		remain -= evt->plen;
> > +	}
> > +
> > +	/* Every HCI commands in the firmware file has its correspond event.
> > +	 * If event is not found or remain is smaller than zero, the firmware
> > +	 * file is corrupted.
> > +	 */
> > +	if (!evt || !evt_param || remain < 0) {
> > +		BT_ERR("%s Intel fw corrupted: invalid evt read", hdev->name);
> > +		return -EFAULT;
> > +	}
> > +
> > +	skb = __hci_cmd_sync_ev(hdev, le16_to_cpu(cmd->opcode), cmd->plen,
> > +				(void *)cmd_param, evt->evt, HCI_INIT_TIMEOUT);
> 
> Is this (void *) casting really needed. The parameter is void already. So it should not be needed at a all. If it throws a compiler warning please let us know which one. Same goes for the others where you cast.

Originally the compiler complained since cmd_param is "const". However with Johan's new change, it doesn't need (void *).

> 
> > +	if (IS_ERR(skb)) {
> > +		BT_ERR("%s sending Intel patch command (0x%4.4x) failed (%ld)",
> > +		       hdev->name, cmd->opcode, PTR_ERR(skb));
> > +		return -PTR_ERR(skb);
> > +	}
> > +
> > +	/* It ensures that the returned event matches the event data read from
> > +	 * the firmware file. At fist, it checks the length and then
> > +	 * the contents of the event.
> > +	 */
> > +	if (skb->len != evt->plen) {
> > +		BT_ERR("%s mismatch event length (opcode 0x%4.4x)", hdev->name,
> > +		       le16_to_cpu(cmd->opcode));
> > +		kfree_skb(skb);
> > +		return -EFAULT;
> > +	}
> > +
> > +	if (memcmp(skb->data, evt_param, evt->plen)) {
> > +		BT_ERR("%s mismatch event parameter (opcode 0x%4.4x)",
> > +		       hdev->name, le16_to_cpu(cmd->opcode));
> > +		kfree_skb(skb);
> > +		return -EFAULT;
> > +	}
> > +	kfree_skb(skb);
> > +
> > +	return 0;
> > +}
> > +
> > +static int btusb_setup_intel(struct hci_dev *hdev)
> > +{
> > +	struct sk_buff *skb;
> > +	const struct firmware *fw;
> > +	const u8 *fw_ptr;
> > +	int disable_patch;
> > +	struct intel_version *ver;
> > +
> > +	u8 mfg_enable[] = { 0x01, 0x00 };
> > +	u8 mfg_disable[] = { 0x00, 0x00 };
> > +	u8 mfg_reset_deactivate[] = { 0x00, 0x01 };
> > +	u8 mfg_reset_activate[] = { 0x00, 0x02 };
> 
> Since the patch from Johan got applied to bluetooth-next, please make these const.
> 

Done.

> > +
> > +	BT_DBG("%s", hdev->name);
> > +
> > +	/* The controller has a bug with the first HCI command sent to it
> > +	 * returning number of completed commands as zero. This would stall the
> > +	 * command processing in the Bluetooth core.
> > +	 *
> > +	 * As a workaround, send HCI Reset command first which will reset the
> > +	 * number of completed commands and allow normal command processing
> > +	 * from now on.
> > +	 */
> > +	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
> > +	if (IS_ERR(skb)) {
> > +		BT_ERR("%s sending initial HCI reset command failed (%ld)",
> > +		       hdev->name, PTR_ERR(skb));
> > +		return -PTR_ERR(skb);
> > +	}
> > +	kfree_skb(skb);
> > +
> > +	/* Read Intel specific controller version first to allow selection of
> > +	 * which firmware file to load.
> > +	 *
> > +	 * The returned information are hardware variant and revision plus
> > +	 * firmware variant, revision and build number.
> > +	 */
> > +	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_INIT_TIMEOUT);
> > +	if (IS_ERR(skb)) {
> > +		BT_ERR("%s reading Intel fw version command failed (%ld)",
> > +		       hdev->name, PTR_ERR(skb));
> > +		return -PTR_ERR(skb);
> > +	}
> > +
> > +	if (skb->len != sizeof(*ver)) {
> > +		BT_ERR("%s Intel version event length mismatch", hdev->name);
> > +		kfree_skb(skb);
> > +		return -EIO;
> > +	}
> > +
> > +	ver = (struct intel_version *)skb->data;
> > +	if (ver->status) {
> > +		BT_ERR("%s Intel fw version event failed (%02x)", hdev->name,
> > +		       ver->status);
> > +		kfree_skb(skb);
> > +		return -bt_to_errno(ver->status);
> > +	}
> > +
> > +	BT_INFO("%s: read Intel version: %02x%02x%02x%02x%02x%02x%02x%02x%02x",
> > +		hdev->name, ver->hw_platform, ver->hw_variant,
> > +		ver->hw_revision, ver->fw_variant,  ver->fw_revision,
> > +		ver->fw_build_num, ver->fw_build_ww, ver->fw_build_yy,
> > +		ver->fw_patch_num);
> > +
> > +	/* fw_patch_num indicates the version of patch the device currently
> > +	 * have. If there is no patch data in the device, it is always 0x00.
> > +	 * So, if it is other than 0x00, no need to patch the deivce again.
> > +	 */
> > +	if (ver->fw_patch_num) {
> > +		BT_INFO("%s: Intel device is already patched. patch num: %02x",
> > +			hdev->name, ver->fw_patch_num);
> > +		kfree_skb(skb);
> > +		return 0;
> > +	}
> > +
> > +	/* Opens the firmware patch file based on the firmware version read
> > +	 * from the controller. If it fails to open the matching firmware
> > +	 * patch file, it tries to open the default firmware patch file.
> > +	 * If no patch file is found, allow the device to operate without
> > +	 * a patch.
> > +	 */
> > +	fw = btusb_setup_intel_get_fw(hdev, ver);
> > +	if (!fw) {
> > +		kfree_skb(skb);
> > +		return 0;
> > +	}
> > +	fw_ptr = fw->data;
> > +
> > +	/* This Intel specific command enables the manufacturer mode of the
> > +	 * controller.
> > +	 *
> > +	 * Only while this mode is enabled, the driver can download the
> > +	 * firmware patch data and configuration parameters.
> > +	 */
> > +	skb = __hci_cmd_sync(hdev, 0xfc11, 2, mfg_enable, HCI_INIT_TIMEOUT);
> > +	if (IS_ERR(skb)) {
> > +		BT_ERR("%s entering Intel manufacturer mode failed (%ld)",
> > +		       hdev->name, PTR_ERR(skb));
> > +		release_firmware(fw);
> > +		return -PTR_ERR(skb);
> > +	}
> > +
> > +	if (skb->data[0]) {
> > +		u8 evt_status = skb->data[0];
> > +		BT_ERR("%s enable Intel manufacturer mode event failed (%02x)",
> > +		       hdev->name, evt_status);
> > +		kfree_skb(skb);
> > +		release_firmware(fw);
> > +		return -bt_to_errno(evt_status);
> > +	}
> > +	kfree_skb(skb);
> > +
> > +	disable_patch = 1;
> > +
> > +	/* The firmware data file consists of list of Intel specific HCI
> > +	 * commands and its expected events. The first byte indicates the
> > +	 * type of the message, either HCI command or HCI event.
> > +	 *
> > +	 * It reads the command and its expected event from the firmware file,
> > +	 * and send to the controller. Once __hci_cmd_sync_ev() returns,
> > +	 * the returned event is compared with the event read from the firmware
> > +	 * file and it will continue until all the messages are downloaded to
> > +	 * the controller.
> > +	 *
> > +	 * Once the firmware patching is completed successfully,
> > +	 * the manufacturer mode is disabled with reset and activating the
> > +	 * downloaded patch.
> > +	 *
> > +	 * If the firmware patching fails, the manufacturer mode is
> > +	 * disabled with reset and deactivating the patch.
> > +	 *
> > +	 * If the default patch file is used, no reset is done when disabling
> > +	 * the manufacturer.
> > +	 */
> > +	while (fw->size > fw_ptr - fw->data) {
> > +		int ret;
> > +
> > +		ret = btusb_setup_intel_patching(hdev, fw, &fw_ptr,
> > +						 &disable_patch);
> > +		if (ret < 0)
> > +			goto exit_mfg_deactivate;
> > +	}
> > +
> > +	release_firmware(fw);
> > +
> > +	if (disable_patch)
> > +		goto exit_mfg_disable;
> > +
> > +	/* Patching completed successfully and disable the manufacturer mode
> > +	 * with reset and activate the downloaded firmware patches.
> > +	 */
> > +	skb = __hci_cmd_sync(hdev, 0xfc11, sizeof(mfg_reset_activate),
> > +			     mfg_reset_activate, HCI_INIT_TIMEOUT);
> > +	if (IS_ERR(skb)) {
> > +		BT_ERR("%s exiting Intel manufacturer mode failed (%ld)",
> > +		       hdev->name, PTR_ERR(skb));
> > +		return -PTR_ERR(skb);
> > +	}
> > +	kfree_skb(skb);
> > +
> > +	BT_INFO("%s: Intel Bluetooth firmware patch completed and activated",
> > +		hdev->name);
> > +
> > +	return 0;
> > +
> > +exit_mfg_disable:
> > +
> 
> Remove this empty line above.

Done

> 
> > +	/* Disable the manufacturer mode without reset */
> > +	skb = __hci_cmd_sync(hdev, 0xfc11, sizeof(mfg_disable), mfg_disable,
> > +			     HCI_INIT_TIMEOUT);
> > +	if (IS_ERR(skb)) {
> > +		BT_ERR("%s exiting Intel manufacturer mode failed (%ld)",
> > +		       hdev->name, PTR_ERR(skb));
> > +		return -PTR_ERR(skb);
> > +	}
> > +	kfree_skb(skb);
> > +
> > +	BT_INFO("%s: Intel Bluetooth firmware patch completed", hdev->name);
> > +	return 0;
> > +
> > +exit_mfg_deactivate:
> > +	release_firmware(fw);
> > +
> > +	/* Patching failed. Disable the manufacturer mode with reset and
> > +	 * deactivate the downloaded firmware patches.
> > +	 */
> > +	skb = __hci_cmd_sync(hdev, 0xfc11, sizeof(mfg_reset_deactivate),
> > +			     mfg_reset_deactivate, HCI_INIT_TIMEOUT);
> > +	if (IS_ERR(skb)) {
> > +		BT_ERR("%s exiting Intel manufacturer mode failed (%ld)",
> > +		       hdev->name, PTR_ERR(skb));
> > +		return -PTR_ERR(skb);
> > +	}
> > +	kfree_skb(skb);
> > +
> > +	BT_INFO("%s: Intel Bluetooth firmware patch completed and deactivated",
> > +		hdev->name);
> > +
> > +	return 0;
> > +}
> > +
> > static int btusb_probe(struct usb_interface *intf,
> > 				const struct usb_device_id *id)
> > {
> > @@ -1048,6 +1424,9 @@ static int btusb_probe(struct usb_interface *intf,
> > 	if (id->driver_info & BTUSB_BCM92035)
> > 		hdev->setup = btusb_setup_bcm92035;
> > 
> > +	if (id->driver_info & BTUSB_INTEL)
> > +		hdev->setup = btusb_setup_intel;
> > +
> > 	/* Interface numbers are hardcoded in the specification */
> > 	data->isoc = usb_ifnum_to_if(data->udev, 1);
> 
> Regards
> 
> Marcel
> 

-- 
Regards
Tedd Ho-Jeong An
Intel Corporation
