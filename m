Return-Path: <cyrus@holtmann.org>
Date: Wed, 17 Apr 2013 11:14:29 +0300
From: Johan Hedberg <johan.hedberg@intel.com>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, don.fry@intel.com
Subject: Re: [PATCH v3] Bluetooth: Add support for Intel Bluetooth device
 [8087:07dc]
Message-ID: <20130417081429.GA3546@x220>
References: <3111343.Z0fLDzQXC4@tedd-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3111343.Z0fLDzQXC4@tedd-ubuntu>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

On Sun, Apr 14, 2013, Tedd Ho-Jeong An wrote:
> +static int btusb_setup_intel(struct hci_dev *hdev)
> +{
> +	struct sk_buff *skb;
> +	const struct firmware *fw;
> +	const u8 *fw_ptr;
> +	int require_activation;
> +	struct intel_version *ver;
> +
> +	u8 mfg_enable[] = { 0x01, 0x00 };
> +	u8 mfg_disable[] = { 0x00, 0x00 };
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
> +	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL,
> +			     HCI_INIT_TIMEOUT);

It doesn't look like the line split is necessary above.

> +	if (IS_ERR(skb)) {
> +		BT_ERR("%s reading Intel fw version command failed (%ld)",
> +		       hdev->name, PTR_ERR(skb));
> +		return -PTR_ERR(skb);
> +	}
> +
> +	if (skb->len != sizeof(*ver)) {
> +		BT_ERR("%s Intel version event length mismatch", hdev->name);
> +		kfree_skb(skb);
> +		return 0;
> +	}
> +
> +	ver = (struct intel_version *)skb->data;
> +	/* was command successful */
> +	if (ver->status) {
> +		BT_ERR("%s Intel fw version event failed (%02x)", hdev->name,
> +		       ver->status);
> +		kfree_skb(skb);
> +		return 0;
> +	}
> +
> +	BT_INFO("%s read Intel version: %02x%02x%02x%02x%02x%02x%02x%02x%02x",
> +		hdev->name, ver->hw_platform, ver->hw_variant,
> +		ver->hw_revision, ver->fw_variant,  ver->fw_revision,
> +		ver->fw_build_num, ver->fw_build_ww, ver->fw_build_yy,
> +		ver->fw_patch_num);
> +
> +	/* is the device already patched */
> +	if (ver->fw_patch_num) {
> +		BT_INFO("%s Intel device is already patched. patch num: %02x",
> +			hdev->name, ver->fw_patch_num);
> +		kfree_skb(skb);
> +		return 0;
> +	}
> +
> +	/* Opens the firmware patch file based on the firmware version read
> +	 * from the controller. If it failed to open the matching firmware
> +	 * patch file, it tries to open the default firmware patch file.
> +	 * If no patch file, allow the device to operate without a patch.
> +	 */
> +	fw = btusb_setup_intel_get_fw(hdev, ver);
> +	if (!fw) {
> +		kfree_skb(skb);
> +		return 0;
> +	}
> +	fw_ptr = fw->data;
> +
> +	/* This Intel specific command enables the manufacturer mode of the
> +	 * controller.
> +	 *
> +	 * Only while this mode is enabled, the driver can download the
> +	 * firmware patch data and configuration parameters.
> +	 */
> +	skb = __hci_cmd_sync(hdev, 0xfc11, 2, mfg_enable,
> +			     HCI_INIT_TIMEOUT);

Same here with the line split.

> +	if (IS_ERR(skb)) {
> +		BT_ERR("%s entering Intel manufacturer mode failed (%ld)",
> +		       hdev->name, PTR_ERR(skb));
> +		release_firmware(fw);
> +		return -PTR_ERR(skb);
> +	}
> +
> +	if (skb->data[0]) {
> +		int evt_status = skb->data[0];

Why int instead of u8?

> +	require_activation = 0;
> +
> +	/* The firmware data file consists of list of Intel specific HCI
> +	 * commands and its expected events. The first byte indicates the
> +	 * type of the message, either HCI command or HCI event.
> +	 *
> +	 * It reads the command and its expected event from the firmware file,
> +	 * and send to the controller. Once __hci_cmd_sync_ev() returns,
> +	 * the returned event is compared with the event read from the firmware
> +	 * file and it will continue until all the messages are downloaded to
> +	 * the controller.
> +	 *
> +	 * Once the firmware patching is completed successfully,
> +	 * the manufacturer mode is disabled with reset and activating the
> +	 * downloaded patch.
> +	 *
> +	 * If the firmware patching is failed, the manufacturer mode is
> +	 * disabled with reset and deactivating the patch.
> +	 *
> +	 * If the default patch file is used, no reset is done when disabling
> +	 * the manufacturer.
> +	 */
> +	while (1) {

At this point the function is starting to grow painfully long (even
without all the helpful code comments). Isn't there any way you could
try to refactor it? Maybe have part or all of the while loop content in
its own function with the return value indicating which one of your
"goto" sections needs to be run?

> +exit_mfg_activate:
> +	release_firmware(fw);
> +
> +	/* Reset is done when disabling the manufacturer mode and activate
> +	 * the downloaded firmware patches
> +	 */
> +	skb = __hci_cmd_sync(hdev, 0xfc11, 2, mfg_reset_activate,
> +			HCI_INIT_TIMEOUT);

Is the line split here really aligned with the opening parenthesis? It
doesn't look like it to me.

> +	skb = __hci_cmd_sync(hdev, 0xfc11, 2, mfg_reset_deactivate,
> +			HCI_INIT_TIMEOUT);

Same here.

> +	/* No reset is done when disabling the manufacturer mode */
> +	skb = __hci_cmd_sync(hdev, 0xfc11, 2, mfg_disable,
> +			     HCI_INIT_TIMEOUT);

This one looks fine though.

Johan
