Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8887C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 19:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9088260C40
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 19:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhG2TZt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 15:25:49 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:55241 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhG2TZt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 15:25:49 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id A2B74CED1E;
        Thu, 29 Jul 2021 21:25:44 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v5 03/11] Bluetooth: btintel: Refactoring setup routine
 for legacy ROM sku
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210729183600.281586-4-hj.tedd.an@gmail.com>
Date:   Thu, 29 Jul 2021 21:25:44 +0200
Cc:     linux-bluetooth@vger.kernel.org,
        Tedd Ho-Jeong An <tedd.an@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <0F57AC75-6F97-4C1B-A823-1FE198402281@holtmann.org>
References: <20210729183600.281586-1-hj.tedd.an@gmail.com>
 <20210729183600.281586-4-hj.tedd.an@gmail.com>
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

> This patch refactors the setup routines for legacy ROM product into
> combined setup, and move the related functions from btusb to btintel.
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
> drivers/bluetooth/btintel.c | 287 +++++++++++++++++++++++++++-
> drivers/bluetooth/btusb.c   | 362 +-----------------------------------
> 2 files changed, 294 insertions(+), 355 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index a23304435814..cfc097694b53 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -1372,6 +1372,291 @@ int btintel_set_debug_features(struct hci_dev *hdev,
> }
> EXPORT_SYMBOL_GPL(btintel_set_debug_features);
> 
> +static const struct firmware *btintel_legacy_rom_get_fw(struct hci_dev *hdev,
> +					       struct intel_version *ver)
> +{
> +	const struct firmware *fw;
> +	char fwname[64];
> +	int ret;
> +
> +	snprintf(fwname, sizeof(fwname),
> +		 "intel/ibt-hw-%x.%x.%x-fw-%x.%x.%x.%x.%x.bseq",
> +		 ver->hw_platform, ver->hw_variant, ver->hw_revision,
> +		 ver->fw_variant,  ver->fw_revision, ver->fw_build_num,
> +		 ver->fw_build_ww, ver->fw_build_yy);
> +
> +	ret = request_firmware(&fw, fwname, &hdev->dev);
> +	if (ret < 0) {
> +		if (ret == -EINVAL) {
> +			bt_dev_err(hdev, "Intel firmware file request failed (%d)",
> +				   ret);
> +			return NULL;
> +		}
> +
> +		bt_dev_err(hdev, "failed to open Intel firmware file: %s (%d)",
> +			   fwname, ret);
> +
> +		/* If the correct firmware patch file is not found, use the
> +		 * default firmware patch file instead
> +		 */
> +		snprintf(fwname, sizeof(fwname), "intel/ibt-hw-%x.%x.bseq",
> +			 ver->hw_platform, ver->hw_variant);
> +		if (request_firmware(&fw, fwname, &hdev->dev) < 0) {
> +			bt_dev_err(hdev, "failed to open default fw file: %s",
> +				   fwname);
> +			return NULL;
> +		}
> +	}
> +
> +	bt_dev_info(hdev, "Intel Bluetooth firmware file: %s", fwname);
> +
> +	return fw;
> +}
> +
> +static int btintel_legacy_rom_patching(struct hci_dev *hdev,
> +				      const struct firmware *fw,
> +				      const u8 **fw_ptr, int *disable_patch)
> +{
> +	struct sk_buff *skb;
> +	struct hci_command_hdr *cmd;
> +	const u8 *cmd_param;
> +	struct hci_event_hdr *evt = NULL;
> +	const u8 *evt_param = NULL;
> +	int remain = fw->size - (*fw_ptr - fw->data);
> +
> +	/* The first byte indicates the types of the patch command or event.
> +	 * 0x01 means HCI command and 0x02 is HCI event. If the first bytes
> +	 * in the current firmware buffer doesn't start with 0x01 or
> +	 * the size of remain buffer is smaller than HCI command header,
> +	 * the firmware file is corrupted and it should stop the patching
> +	 * process.
> +	 */
> +	if (remain > HCI_COMMAND_HDR_SIZE && *fw_ptr[0] != 0x01) {
> +		bt_dev_err(hdev, "Intel fw corrupted: invalid cmd read");
> +		return -EINVAL;
> +	}
> +	(*fw_ptr)++;
> +	remain--;
> +
> +	cmd = (struct hci_command_hdr *)(*fw_ptr);
> +	*fw_ptr += sizeof(*cmd);
> +	remain -= sizeof(*cmd);
> +
> +	/* Ensure that the remain firmware data is long enough than the length
> +	 * of command parameter. If not, the firmware file is corrupted.
> +	 */
> +	if (remain < cmd->plen) {
> +		bt_dev_err(hdev, "Intel fw corrupted: invalid cmd len");
> +		return -EFAULT;
> +	}
> +
> +	/* If there is a command that loads a patch in the firmware
> +	 * file, then enable the patch upon success, otherwise just
> +	 * disable the manufacturer mode, for example patch activation
> +	 * is not required when the default firmware patch file is used
> +	 * because there are no patch data to load.
> +	 */
> +	if (*disable_patch && le16_to_cpu(cmd->opcode) == 0xfc8e)
> +		*disable_patch = 0;
> +
> +	cmd_param = *fw_ptr;
> +	*fw_ptr += cmd->plen;
> +	remain -= cmd->plen;
> +
> +	/* This reads the expected events when the above command is sent to the
> +	 * device. Some vendor commands expects more than one events, for
> +	 * example command status event followed by vendor specific event.
> +	 * For this case, it only keeps the last expected event. so the command
> +	 * can be sent with __hci_cmd_sync_ev() which returns the sk_buff of
> +	 * last expected event.
> +	 */
> +	while (remain > HCI_EVENT_HDR_SIZE && *fw_ptr[0] == 0x02) {
> +		(*fw_ptr)++;
> +		remain--;
> +
> +		evt = (struct hci_event_hdr *)(*fw_ptr);
> +		*fw_ptr += sizeof(*evt);
> +		remain -= sizeof(*evt);
> +
> +		if (remain < evt->plen) {
> +			bt_dev_err(hdev, "Intel fw corrupted: invalid evt len");
> +			return -EFAULT;
> +		}
> +
> +		evt_param = *fw_ptr;
> +		*fw_ptr += evt->plen;
> +		remain -= evt->plen;
> +	}
> +
> +	/* Every HCI commands in the firmware file has its correspond event.
> +	 * If event is not found or remain is smaller than zero, the firmware
> +	 * file is corrupted.
> +	 */
> +	if (!evt || !evt_param || remain < 0) {
> +		bt_dev_err(hdev, "Intel fw corrupted: invalid evt read");
> +		return -EFAULT;
> +	}
> +
> +	skb = __hci_cmd_sync_ev(hdev, le16_to_cpu(cmd->opcode), cmd->plen,
> +				cmd_param, evt->evt, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		bt_dev_err(hdev, "sending Intel patch command (0x%4.4x) failed (%ld)",
> +			   cmd->opcode, PTR_ERR(skb));
> +		return PTR_ERR(skb);
> +	}
> +
> +	/* It ensures that the returned event matches the event data read from
> +	 * the firmware file. At fist, it checks the length and then
> +	 * the contents of the event.
> +	 */
> +	if (skb->len != evt->plen) {
> +		bt_dev_err(hdev, "mismatch event length (opcode 0x%4.4x)",
> +			   le16_to_cpu(cmd->opcode));
> +		kfree_skb(skb);
> +		return -EFAULT;
> +	}
> +
> +	if (memcmp(skb->data, evt_param, evt->plen)) {
> +		bt_dev_err(hdev, "mismatch event parameter (opcode 0x%4.4x)",
> +			   le16_to_cpu(cmd->opcode));
> +		kfree_skb(skb);
> +		return -EFAULT;
> +	}
> +	kfree_skb(skb);
> +
> +	return 0;
> +}
> +
> +static int btintel_legacy_rom_setup(struct hci_dev *hdev,
> +				    struct intel_version *ver)
> +{
> +	const struct firmware *fw;
> +	const u8 *fw_ptr;
> +	int disable_patch, err;
> +	struct intel_version new_ver;
> +
> +	BT_DBG("%s", hdev->name);
> +
> +	/* fw_patch_num indicates the version of patch the device currently
> +	 * have. If there is no patch data in the device, it is always 0x00.
> +	 * So, if it is other than 0x00, no need to patch the device again.
> +	 */
> +	if (ver->fw_patch_num) {
> +		bt_dev_info(hdev,
> +			    "Intel device is already patched. patch num: %02x",
> +			    ver->fw_patch_num);
> +		goto complete;
> +	}
> +
> +	/* Opens the firmware patch file based on the firmware version read
> +	 * from the controller. If it fails to open the matching firmware
> +	 * patch file, it tries to open the default firmware patch file.
> +	 * If no patch file is found, allow the device to operate without
> +	 * a patch.
> +	 */
> +	fw = btintel_legacy_rom_get_fw(hdev, ver);
> +	if (!fw)
> +		goto complete;
> +	fw_ptr = fw->data;
> +
> +	/* Enable the manufacturer mode of the controller.
> +	 * Only while this mode is enabled, the driver can download the
> +	 * firmware patch data and configuration parameters.
> +	 */
> +	err = btintel_enter_mfg(hdev);
> +	if (err) {
> +		release_firmware(fw);
> +		return err;
> +	}
> +
> +	disable_patch = 1;
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
> +	 * If the firmware patching fails, the manufacturer mode is
> +	 * disabled with reset and deactivating the patch.
> +	 *
> +	 * If the default patch file is used, no reset is done when disabling
> +	 * the manufacturer.
> +	 */
> +	while (fw->size > fw_ptr - fw->data) {
> +		int ret;
> +
> +		ret = btintel_legacy_rom_patching(hdev, fw, &fw_ptr,
> +						 &disable_patch);
> +		if (ret < 0)
> +			goto exit_mfg_deactivate;
> +	}
> +
> +	release_firmware(fw);
> +
> +	if (disable_patch)
> +		goto exit_mfg_disable;
> +
> +	/* Patching completed successfully and disable the manufacturer mode
> +	 * with reset and activate the downloaded firmware patches.
> +	 */
> +	err = btintel_exit_mfg(hdev, true, true);
> +	if (err)
> +		return err;
> +
> +	/* Need build number for downloaded fw patches in
> +	 * every power-on boot
> +	 */
> +	err = btintel_read_version(hdev, &new_ver);
> +	if (err)
> +		return err;
> +
> +	bt_dev_info(hdev, "Intel BT fw patch 0x%02x completed & activated",
> +		    new_ver.fw_patch_num);
> +
> +	goto complete;
> +
> +exit_mfg_disable:
> +	/* Disable the manufacturer mode without reset */
> +	err = btintel_exit_mfg(hdev, false, false);
> +	if (err)
> +		return err;
> +
> +	bt_dev_info(hdev, "Intel firmware patch completed");
> +
> +	goto complete;
> +
> +exit_mfg_deactivate:
> +	release_firmware(fw);
> +
> +	/* Patching failed. Disable the manufacturer mode with reset and
> +	 * deactivate the downloaded firmware patches.
> +	 */
> +	err = btintel_exit_mfg(hdev, true, false);
> +	if (err)
> +		return err;
> +
> +	bt_dev_info(hdev, "Intel firmware patch completed and deactivated");
> +
> +complete:
> +	/* Set the event mask for Intel specific vendor events. This enables
> +	 * a few extra events that are useful during general operation.
> +	 */
> +	btintel_set_event_mask_mfg(hdev, false);
> +
> +	btintel_check_bdaddr(hdev);
> +
> +	return 0;
> +}
> +
> int btintel_setup_combined(struct hci_dev *hdev)
> {
> 	const u8 param[1] = { 0xFF };
> @@ -1417,7 +1702,7 @@ int btintel_setup_combined(struct hci_dev *hdev)
> 		case 0x07:	/* WP */
> 		case 0x08:	/* StP */
> 			/* Legacy ROM product */
> -			/* TODO: call setup routine for legacy rom product */
> +			err = btintel_legacy_rom_setup(hdev, &ver);
> 			break;
> 		case 0x0b:      /* SfP */
> 		case 0x0c:      /* WsP */
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 1876a960b3dc..42f7176a6c70 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -61,6 +61,7 @@ static struct usb_driver btusb_driver;
> #define BTUSB_VALID_LE_STATES   0x800000
> #define BTUSB_QCA_WCN6855	0x1000000
> #define BTUSB_INTEL_NEWGEN	0x2000000
> +#define BTUSB_INTEL_COMBINED	0x4000000

just rename BTUSB_INTEL into BTUSB_INTEL_COMBINED. Since the BTUSB_INTEL is now an orphan.

> 
> static const struct usb_device_id btusb_table[] = {
> 	/* Generic Bluetooth USB device */
> @@ -375,11 +376,11 @@ static const struct usb_device_id blacklist_table[] = {
> 						     BTUSB_WIDEBAND_SPEECH |
> 						     BTUSB_VALID_LE_STATES },
> 	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
> -	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL },
> -	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL },
> +	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL_COMBINED },
> +	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED },
> 	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_NEW |
> 						     BTUSB_WIDEBAND_SPEECH },
> -	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL |
> +	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL_COMBINED |
> 						     BTUSB_WIDEBAND_SPEECH },
> 	{ USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_NEW |
> 						     BTUSB_WIDEBAND_SPEECH |
> @@ -1962,319 +1963,6 @@ static int btusb_setup_csr(struct hci_dev *hdev)
> 	return 0;
> }

Regards

Marcel

