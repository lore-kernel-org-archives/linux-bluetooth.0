Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D63C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 18:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BB3960EE6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 18:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbhG2SgM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 14:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhG2SgM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 14:36:12 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08E3C061765
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 11:36:07 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id e21so8005215pla.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 11:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Chkib0MLXoSOAwzcdqHUO3pPhvzarPtaHsJidhj36M=;
        b=NxmQhLC6ftFamw8BHaRIi361tqwuSxp+tzFSDsX+6uqFGhqXyHxCrdgb1luQr59HLs
         V8InSy/mSuYkAVnCpKSDaC1vpYklS64jyJR1mlQgE73zH7etM0km6lhjPjh3PD7LWHWk
         Piel/CbX6iFjSHLG/Ug7aPSZDrjbkG1iD5MVdqZNBbk5HazdRBHUqK0GC8C6aC76uaBE
         zOOTHvUpFi6KciCL6tPulbK0QuadMdnpZpeJO7BCX85bIdy11MwlO2/etuvuEcChR8TF
         VeRN8LegpqL51vWEFPwORgUi1PgCHf9vC4ywESIg64Uqtqwwbbnm8nudJBP9rX6WhIj8
         aPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Chkib0MLXoSOAwzcdqHUO3pPhvzarPtaHsJidhj36M=;
        b=RTUNY+fZUo6EvZZvC1PPc85pwC983nfMLEuB/hmFtpxsUd6SRnVAEjUODlHv+8b5Ho
         87gLZJCwpOyrhrEqaHur/eQ6P+ZvaDE7kkbz71TdjwQAdwnABrgD+G0CUCSBB39MCazp
         xgLS2/d0Bb8tIV0LhEQJC7XzyQmNGoOGgbgT8HvzfVf9LV+BUzZNWyZGsZf2hetnWjzb
         X887ERbX/PL+CVfzxm6DVrh/UOMXQLV2x8q5abNF9bvSVVZNNRX+vASWuJNI5ooUYIGH
         XxkCj/KgewgUTdpV1pKdbwNWqjYCpxJvDgOjQM6t7BMsAJDCRz+0JRthCOVXMhNIzf19
         qRaw==
X-Gm-Message-State: AOAM530BraTMTdqfa9jta3SfbesG8sn8CpmSvlG71FBS3Ort/sDDlfcD
        pmdD1lqZN+HlkEhyUVtO2RuCxeWTr1Q=
X-Google-Smtp-Source: ABdhPJxVit5M2sr5miYx4p2cw0AY2li9ZpddM5GGpBB02NJoouQXzLZTas2nbUaCj9FTfi1qZFe/8w==
X-Received: by 2002:aa7:804f:0:b029:334:4951:da88 with SMTP id y15-20020aa7804f0000b02903344951da88mr6456470pfm.29.1627583766943;
        Thu, 29 Jul 2021 11:36:06 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:6349:1ee2:dda3:7891])
        by smtp.gmail.com with ESMTPSA id i1sm10943130pjs.31.2021.07.29.11.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 11:36:06 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH v5 03/11] Bluetooth: btintel: Refactoring setup routine for legacy ROM sku
Date:   Thu, 29 Jul 2021 11:35:52 -0700
Message-Id: <20210729183600.281586-4-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210729183600.281586-1-hj.tedd.an@gmail.com>
References: <20210729183600.281586-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch refactors the setup routines for legacy ROM product into
combined setup, and move the related functions from btusb to btintel.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btintel.c | 287 +++++++++++++++++++++++++++-
 drivers/bluetooth/btusb.c   | 362 +-----------------------------------
 2 files changed, 294 insertions(+), 355 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index a23304435814..cfc097694b53 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1372,6 +1372,291 @@ int btintel_set_debug_features(struct hci_dev *hdev,
 }
 EXPORT_SYMBOL_GPL(btintel_set_debug_features);
 
+static const struct firmware *btintel_legacy_rom_get_fw(struct hci_dev *hdev,
+					       struct intel_version *ver)
+{
+	const struct firmware *fw;
+	char fwname[64];
+	int ret;
+
+	snprintf(fwname, sizeof(fwname),
+		 "intel/ibt-hw-%x.%x.%x-fw-%x.%x.%x.%x.%x.bseq",
+		 ver->hw_platform, ver->hw_variant, ver->hw_revision,
+		 ver->fw_variant,  ver->fw_revision, ver->fw_build_num,
+		 ver->fw_build_ww, ver->fw_build_yy);
+
+	ret = request_firmware(&fw, fwname, &hdev->dev);
+	if (ret < 0) {
+		if (ret == -EINVAL) {
+			bt_dev_err(hdev, "Intel firmware file request failed (%d)",
+				   ret);
+			return NULL;
+		}
+
+		bt_dev_err(hdev, "failed to open Intel firmware file: %s (%d)",
+			   fwname, ret);
+
+		/* If the correct firmware patch file is not found, use the
+		 * default firmware patch file instead
+		 */
+		snprintf(fwname, sizeof(fwname), "intel/ibt-hw-%x.%x.bseq",
+			 ver->hw_platform, ver->hw_variant);
+		if (request_firmware(&fw, fwname, &hdev->dev) < 0) {
+			bt_dev_err(hdev, "failed to open default fw file: %s",
+				   fwname);
+			return NULL;
+		}
+	}
+
+	bt_dev_info(hdev, "Intel Bluetooth firmware file: %s", fwname);
+
+	return fw;
+}
+
+static int btintel_legacy_rom_patching(struct hci_dev *hdev,
+				      const struct firmware *fw,
+				      const u8 **fw_ptr, int *disable_patch)
+{
+	struct sk_buff *skb;
+	struct hci_command_hdr *cmd;
+	const u8 *cmd_param;
+	struct hci_event_hdr *evt = NULL;
+	const u8 *evt_param = NULL;
+	int remain = fw->size - (*fw_ptr - fw->data);
+
+	/* The first byte indicates the types of the patch command or event.
+	 * 0x01 means HCI command and 0x02 is HCI event. If the first bytes
+	 * in the current firmware buffer doesn't start with 0x01 or
+	 * the size of remain buffer is smaller than HCI command header,
+	 * the firmware file is corrupted and it should stop the patching
+	 * process.
+	 */
+	if (remain > HCI_COMMAND_HDR_SIZE && *fw_ptr[0] != 0x01) {
+		bt_dev_err(hdev, "Intel fw corrupted: invalid cmd read");
+		return -EINVAL;
+	}
+	(*fw_ptr)++;
+	remain--;
+
+	cmd = (struct hci_command_hdr *)(*fw_ptr);
+	*fw_ptr += sizeof(*cmd);
+	remain -= sizeof(*cmd);
+
+	/* Ensure that the remain firmware data is long enough than the length
+	 * of command parameter. If not, the firmware file is corrupted.
+	 */
+	if (remain < cmd->plen) {
+		bt_dev_err(hdev, "Intel fw corrupted: invalid cmd len");
+		return -EFAULT;
+	}
+
+	/* If there is a command that loads a patch in the firmware
+	 * file, then enable the patch upon success, otherwise just
+	 * disable the manufacturer mode, for example patch activation
+	 * is not required when the default firmware patch file is used
+	 * because there are no patch data to load.
+	 */
+	if (*disable_patch && le16_to_cpu(cmd->opcode) == 0xfc8e)
+		*disable_patch = 0;
+
+	cmd_param = *fw_ptr;
+	*fw_ptr += cmd->plen;
+	remain -= cmd->plen;
+
+	/* This reads the expected events when the above command is sent to the
+	 * device. Some vendor commands expects more than one events, for
+	 * example command status event followed by vendor specific event.
+	 * For this case, it only keeps the last expected event. so the command
+	 * can be sent with __hci_cmd_sync_ev() which returns the sk_buff of
+	 * last expected event.
+	 */
+	while (remain > HCI_EVENT_HDR_SIZE && *fw_ptr[0] == 0x02) {
+		(*fw_ptr)++;
+		remain--;
+
+		evt = (struct hci_event_hdr *)(*fw_ptr);
+		*fw_ptr += sizeof(*evt);
+		remain -= sizeof(*evt);
+
+		if (remain < evt->plen) {
+			bt_dev_err(hdev, "Intel fw corrupted: invalid evt len");
+			return -EFAULT;
+		}
+
+		evt_param = *fw_ptr;
+		*fw_ptr += evt->plen;
+		remain -= evt->plen;
+	}
+
+	/* Every HCI commands in the firmware file has its correspond event.
+	 * If event is not found or remain is smaller than zero, the firmware
+	 * file is corrupted.
+	 */
+	if (!evt || !evt_param || remain < 0) {
+		bt_dev_err(hdev, "Intel fw corrupted: invalid evt read");
+		return -EFAULT;
+	}
+
+	skb = __hci_cmd_sync_ev(hdev, le16_to_cpu(cmd->opcode), cmd->plen,
+				cmd_param, evt->evt, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "sending Intel patch command (0x%4.4x) failed (%ld)",
+			   cmd->opcode, PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	/* It ensures that the returned event matches the event data read from
+	 * the firmware file. At fist, it checks the length and then
+	 * the contents of the event.
+	 */
+	if (skb->len != evt->plen) {
+		bt_dev_err(hdev, "mismatch event length (opcode 0x%4.4x)",
+			   le16_to_cpu(cmd->opcode));
+		kfree_skb(skb);
+		return -EFAULT;
+	}
+
+	if (memcmp(skb->data, evt_param, evt->plen)) {
+		bt_dev_err(hdev, "mismatch event parameter (opcode 0x%4.4x)",
+			   le16_to_cpu(cmd->opcode));
+		kfree_skb(skb);
+		return -EFAULT;
+	}
+	kfree_skb(skb);
+
+	return 0;
+}
+
+static int btintel_legacy_rom_setup(struct hci_dev *hdev,
+				    struct intel_version *ver)
+{
+	const struct firmware *fw;
+	const u8 *fw_ptr;
+	int disable_patch, err;
+	struct intel_version new_ver;
+
+	BT_DBG("%s", hdev->name);
+
+	/* fw_patch_num indicates the version of patch the device currently
+	 * have. If there is no patch data in the device, it is always 0x00.
+	 * So, if it is other than 0x00, no need to patch the device again.
+	 */
+	if (ver->fw_patch_num) {
+		bt_dev_info(hdev,
+			    "Intel device is already patched. patch num: %02x",
+			    ver->fw_patch_num);
+		goto complete;
+	}
+
+	/* Opens the firmware patch file based on the firmware version read
+	 * from the controller. If it fails to open the matching firmware
+	 * patch file, it tries to open the default firmware patch file.
+	 * If no patch file is found, allow the device to operate without
+	 * a patch.
+	 */
+	fw = btintel_legacy_rom_get_fw(hdev, ver);
+	if (!fw)
+		goto complete;
+	fw_ptr = fw->data;
+
+	/* Enable the manufacturer mode of the controller.
+	 * Only while this mode is enabled, the driver can download the
+	 * firmware patch data and configuration parameters.
+	 */
+	err = btintel_enter_mfg(hdev);
+	if (err) {
+		release_firmware(fw);
+		return err;
+	}
+
+	disable_patch = 1;
+
+	/* The firmware data file consists of list of Intel specific HCI
+	 * commands and its expected events. The first byte indicates the
+	 * type of the message, either HCI command or HCI event.
+	 *
+	 * It reads the command and its expected event from the firmware file,
+	 * and send to the controller. Once __hci_cmd_sync_ev() returns,
+	 * the returned event is compared with the event read from the firmware
+	 * file and it will continue until all the messages are downloaded to
+	 * the controller.
+	 *
+	 * Once the firmware patching is completed successfully,
+	 * the manufacturer mode is disabled with reset and activating the
+	 * downloaded patch.
+	 *
+	 * If the firmware patching fails, the manufacturer mode is
+	 * disabled with reset and deactivating the patch.
+	 *
+	 * If the default patch file is used, no reset is done when disabling
+	 * the manufacturer.
+	 */
+	while (fw->size > fw_ptr - fw->data) {
+		int ret;
+
+		ret = btintel_legacy_rom_patching(hdev, fw, &fw_ptr,
+						 &disable_patch);
+		if (ret < 0)
+			goto exit_mfg_deactivate;
+	}
+
+	release_firmware(fw);
+
+	if (disable_patch)
+		goto exit_mfg_disable;
+
+	/* Patching completed successfully and disable the manufacturer mode
+	 * with reset and activate the downloaded firmware patches.
+	 */
+	err = btintel_exit_mfg(hdev, true, true);
+	if (err)
+		return err;
+
+	/* Need build number for downloaded fw patches in
+	 * every power-on boot
+	 */
+	err = btintel_read_version(hdev, &new_ver);
+	if (err)
+		return err;
+
+	bt_dev_info(hdev, "Intel BT fw patch 0x%02x completed & activated",
+		    new_ver.fw_patch_num);
+
+	goto complete;
+
+exit_mfg_disable:
+	/* Disable the manufacturer mode without reset */
+	err = btintel_exit_mfg(hdev, false, false);
+	if (err)
+		return err;
+
+	bt_dev_info(hdev, "Intel firmware patch completed");
+
+	goto complete;
+
+exit_mfg_deactivate:
+	release_firmware(fw);
+
+	/* Patching failed. Disable the manufacturer mode with reset and
+	 * deactivate the downloaded firmware patches.
+	 */
+	err = btintel_exit_mfg(hdev, true, false);
+	if (err)
+		return err;
+
+	bt_dev_info(hdev, "Intel firmware patch completed and deactivated");
+
+complete:
+	/* Set the event mask for Intel specific vendor events. This enables
+	 * a few extra events that are useful during general operation.
+	 */
+	btintel_set_event_mask_mfg(hdev, false);
+
+	btintel_check_bdaddr(hdev);
+
+	return 0;
+}
+
 int btintel_setup_combined(struct hci_dev *hdev)
 {
 	const u8 param[1] = { 0xFF };
@@ -1417,7 +1702,7 @@ int btintel_setup_combined(struct hci_dev *hdev)
 		case 0x07:	/* WP */
 		case 0x08:	/* StP */
 			/* Legacy ROM product */
-			/* TODO: call setup routine for legacy rom product */
+			err = btintel_legacy_rom_setup(hdev, &ver);
 			break;
 		case 0x0b:      /* SfP */
 		case 0x0c:      /* WsP */
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1876a960b3dc..42f7176a6c70 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -61,6 +61,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_VALID_LE_STATES   0x800000
 #define BTUSB_QCA_WCN6855	0x1000000
 #define BTUSB_INTEL_NEWGEN	0x2000000
+#define BTUSB_INTEL_COMBINED	0x4000000
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -375,11 +376,11 @@ static const struct usb_device_id blacklist_table[] = {
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
 	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
-	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL },
-	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL },
+	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL_COMBINED },
+	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED },
 	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_NEW |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL |
+	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL_COMBINED |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_NEW |
 						     BTUSB_WIDEBAND_SPEECH |
@@ -1962,319 +1963,6 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 	return 0;
 }
 
-static const struct firmware *btusb_setup_intel_get_fw(struct hci_dev *hdev,
-						       struct intel_version *ver)
-{
-	const struct firmware *fw;
-	char fwname[64];
-	int ret;
-
-	snprintf(fwname, sizeof(fwname),
-		 "intel/ibt-hw-%x.%x.%x-fw-%x.%x.%x.%x.%x.bseq",
-		 ver->hw_platform, ver->hw_variant, ver->hw_revision,
-		 ver->fw_variant,  ver->fw_revision, ver->fw_build_num,
-		 ver->fw_build_ww, ver->fw_build_yy);
-
-	ret = request_firmware(&fw, fwname, &hdev->dev);
-	if (ret < 0) {
-		if (ret == -EINVAL) {
-			bt_dev_err(hdev, "Intel firmware file request failed (%d)",
-				   ret);
-			return NULL;
-		}
-
-		bt_dev_err(hdev, "failed to open Intel firmware file: %s (%d)",
-			   fwname, ret);
-
-		/* If the correct firmware patch file is not found, use the
-		 * default firmware patch file instead
-		 */
-		snprintf(fwname, sizeof(fwname), "intel/ibt-hw-%x.%x.bseq",
-			 ver->hw_platform, ver->hw_variant);
-		if (request_firmware(&fw, fwname, &hdev->dev) < 0) {
-			bt_dev_err(hdev, "failed to open default fw file: %s",
-				   fwname);
-			return NULL;
-		}
-	}
-
-	bt_dev_info(hdev, "Intel Bluetooth firmware file: %s", fwname);
-
-	return fw;
-}
-
-static int btusb_setup_intel_patching(struct hci_dev *hdev,
-				      const struct firmware *fw,
-				      const u8 **fw_ptr, int *disable_patch)
-{
-	struct sk_buff *skb;
-	struct hci_command_hdr *cmd;
-	const u8 *cmd_param;
-	struct hci_event_hdr *evt = NULL;
-	const u8 *evt_param = NULL;
-	int remain = fw->size - (*fw_ptr - fw->data);
-
-	/* The first byte indicates the types of the patch command or event.
-	 * 0x01 means HCI command and 0x02 is HCI event. If the first bytes
-	 * in the current firmware buffer doesn't start with 0x01 or
-	 * the size of remain buffer is smaller than HCI command header,
-	 * the firmware file is corrupted and it should stop the patching
-	 * process.
-	 */
-	if (remain > HCI_COMMAND_HDR_SIZE && *fw_ptr[0] != 0x01) {
-		bt_dev_err(hdev, "Intel fw corrupted: invalid cmd read");
-		return -EINVAL;
-	}
-	(*fw_ptr)++;
-	remain--;
-
-	cmd = (struct hci_command_hdr *)(*fw_ptr);
-	*fw_ptr += sizeof(*cmd);
-	remain -= sizeof(*cmd);
-
-	/* Ensure that the remain firmware data is long enough than the length
-	 * of command parameter. If not, the firmware file is corrupted.
-	 */
-	if (remain < cmd->plen) {
-		bt_dev_err(hdev, "Intel fw corrupted: invalid cmd len");
-		return -EFAULT;
-	}
-
-	/* If there is a command that loads a patch in the firmware
-	 * file, then enable the patch upon success, otherwise just
-	 * disable the manufacturer mode, for example patch activation
-	 * is not required when the default firmware patch file is used
-	 * because there are no patch data to load.
-	 */
-	if (*disable_patch && le16_to_cpu(cmd->opcode) == 0xfc8e)
-		*disable_patch = 0;
-
-	cmd_param = *fw_ptr;
-	*fw_ptr += cmd->plen;
-	remain -= cmd->plen;
-
-	/* This reads the expected events when the above command is sent to the
-	 * device. Some vendor commands expects more than one events, for
-	 * example command status event followed by vendor specific event.
-	 * For this case, it only keeps the last expected event. so the command
-	 * can be sent with __hci_cmd_sync_ev() which returns the sk_buff of
-	 * last expected event.
-	 */
-	while (remain > HCI_EVENT_HDR_SIZE && *fw_ptr[0] == 0x02) {
-		(*fw_ptr)++;
-		remain--;
-
-		evt = (struct hci_event_hdr *)(*fw_ptr);
-		*fw_ptr += sizeof(*evt);
-		remain -= sizeof(*evt);
-
-		if (remain < evt->plen) {
-			bt_dev_err(hdev, "Intel fw corrupted: invalid evt len");
-			return -EFAULT;
-		}
-
-		evt_param = *fw_ptr;
-		*fw_ptr += evt->plen;
-		remain -= evt->plen;
-	}
-
-	/* Every HCI commands in the firmware file has its correspond event.
-	 * If event is not found or remain is smaller than zero, the firmware
-	 * file is corrupted.
-	 */
-	if (!evt || !evt_param || remain < 0) {
-		bt_dev_err(hdev, "Intel fw corrupted: invalid evt read");
-		return -EFAULT;
-	}
-
-	skb = __hci_cmd_sync_ev(hdev, le16_to_cpu(cmd->opcode), cmd->plen,
-				cmd_param, evt->evt, HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		bt_dev_err(hdev, "sending Intel patch command (0x%4.4x) failed (%ld)",
-			   cmd->opcode, PTR_ERR(skb));
-		return PTR_ERR(skb);
-	}
-
-	/* It ensures that the returned event matches the event data read from
-	 * the firmware file. At fist, it checks the length and then
-	 * the contents of the event.
-	 */
-	if (skb->len != evt->plen) {
-		bt_dev_err(hdev, "mismatch event length (opcode 0x%4.4x)",
-			   le16_to_cpu(cmd->opcode));
-		kfree_skb(skb);
-		return -EFAULT;
-	}
-
-	if (memcmp(skb->data, evt_param, evt->plen)) {
-		bt_dev_err(hdev, "mismatch event parameter (opcode 0x%4.4x)",
-			   le16_to_cpu(cmd->opcode));
-		kfree_skb(skb);
-		return -EFAULT;
-	}
-	kfree_skb(skb);
-
-	return 0;
-}
-
-static int btusb_setup_intel(struct hci_dev *hdev)
-{
-	struct sk_buff *skb;
-	const struct firmware *fw;
-	const u8 *fw_ptr;
-	int disable_patch, err;
-	struct intel_version ver;
-
-	BT_DBG("%s", hdev->name);
-
-	/* The controller has a bug with the first HCI command sent to it
-	 * returning number of completed commands as zero. This would stall the
-	 * command processing in the Bluetooth core.
-	 *
-	 * As a workaround, send HCI Reset command first which will reset the
-	 * number of completed commands and allow normal command processing
-	 * from now on.
-	 */
-	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		bt_dev_err(hdev, "sending initial HCI reset command failed (%ld)",
-			   PTR_ERR(skb));
-		return PTR_ERR(skb);
-	}
-	kfree_skb(skb);
-
-	/* Read Intel specific controller version first to allow selection of
-	 * which firmware file to load.
-	 *
-	 * The returned information are hardware variant and revision plus
-	 * firmware variant, revision and build number.
-	 */
-	err = btintel_read_version(hdev, &ver);
-	if (err)
-		return err;
-
-	bt_dev_info(hdev, "read Intel version: %02x%02x%02x%02x%02x%02x%02x%02x%02x",
-		    ver.hw_platform, ver.hw_variant, ver.hw_revision,
-		    ver.fw_variant,  ver.fw_revision, ver.fw_build_num,
-		    ver.fw_build_ww, ver.fw_build_yy, ver.fw_patch_num);
-
-	/* fw_patch_num indicates the version of patch the device currently
-	 * have. If there is no patch data in the device, it is always 0x00.
-	 * So, if it is other than 0x00, no need to patch the device again.
-	 */
-	if (ver.fw_patch_num) {
-		bt_dev_info(hdev, "Intel device is already patched. "
-			    "patch num: %02x", ver.fw_patch_num);
-		goto complete;
-	}
-
-	/* Opens the firmware patch file based on the firmware version read
-	 * from the controller. If it fails to open the matching firmware
-	 * patch file, it tries to open the default firmware patch file.
-	 * If no patch file is found, allow the device to operate without
-	 * a patch.
-	 */
-	fw = btusb_setup_intel_get_fw(hdev, &ver);
-	if (!fw)
-		goto complete;
-	fw_ptr = fw->data;
-
-	/* Enable the manufacturer mode of the controller.
-	 * Only while this mode is enabled, the driver can download the
-	 * firmware patch data and configuration parameters.
-	 */
-	err = btintel_enter_mfg(hdev);
-	if (err) {
-		release_firmware(fw);
-		return err;
-	}
-
-	disable_patch = 1;
-
-	/* The firmware data file consists of list of Intel specific HCI
-	 * commands and its expected events. The first byte indicates the
-	 * type of the message, either HCI command or HCI event.
-	 *
-	 * It reads the command and its expected event from the firmware file,
-	 * and send to the controller. Once __hci_cmd_sync_ev() returns,
-	 * the returned event is compared with the event read from the firmware
-	 * file and it will continue until all the messages are downloaded to
-	 * the controller.
-	 *
-	 * Once the firmware patching is completed successfully,
-	 * the manufacturer mode is disabled with reset and activating the
-	 * downloaded patch.
-	 *
-	 * If the firmware patching fails, the manufacturer mode is
-	 * disabled with reset and deactivating the patch.
-	 *
-	 * If the default patch file is used, no reset is done when disabling
-	 * the manufacturer.
-	 */
-	while (fw->size > fw_ptr - fw->data) {
-		int ret;
-
-		ret = btusb_setup_intel_patching(hdev, fw, &fw_ptr,
-						 &disable_patch);
-		if (ret < 0)
-			goto exit_mfg_deactivate;
-	}
-
-	release_firmware(fw);
-
-	if (disable_patch)
-		goto exit_mfg_disable;
-
-	/* Patching completed successfully and disable the manufacturer mode
-	 * with reset and activate the downloaded firmware patches.
-	 */
-	err = btintel_exit_mfg(hdev, true, true);
-	if (err)
-		return err;
-
-	/* Need build number for downloaded fw patches in
-	 * every power-on boot
-	 */
-       err = btintel_read_version(hdev, &ver);
-       if (err)
-               return err;
-       bt_dev_info(hdev, "Intel BT fw patch 0x%02x completed & activated",
-		   ver.fw_patch_num);
-
-	goto complete;
-
-exit_mfg_disable:
-	/* Disable the manufacturer mode without reset */
-	err = btintel_exit_mfg(hdev, false, false);
-	if (err)
-		return err;
-
-	bt_dev_info(hdev, "Intel firmware patch completed");
-
-	goto complete;
-
-exit_mfg_deactivate:
-	release_firmware(fw);
-
-	/* Patching failed. Disable the manufacturer mode with reset and
-	 * deactivate the downloaded firmware patches.
-	 */
-	err = btintel_exit_mfg(hdev, true, false);
-	if (err)
-		return err;
-
-	bt_dev_info(hdev, "Intel firmware patch completed and deactivated");
-
-complete:
-	/* Set the event mask for Intel specific vendor events. This enables
-	 * a few extra events that are useful during general operation.
-	 */
-	btintel_set_event_mask_mfg(hdev, false);
-
-	btintel_check_bdaddr(hdev);
-	return 0;
-}
-
 static int inject_cmd_complete(struct hci_dev *hdev, __u16 opcode)
 {
 	struct sk_buff *skb;
@@ -3042,41 +2730,6 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 
 	return 0;
 }
-static int btusb_shutdown_intel(struct hci_dev *hdev)
-{
-	struct sk_buff *skb;
-	long ret;
-
-	/* In the shutdown sequence where Bluetooth is turned off followed
-	 * by WiFi being turned off, turning WiFi back on causes issue with
-	 * the RF calibration.
-	 *
-	 * To ensure that any RF activity has been stopped, issue HCI Reset
-	 * command to clear all ongoing activity including advertising,
-	 * scanning etc.
-	 */
-	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		ret = PTR_ERR(skb);
-		bt_dev_err(hdev, "HCI reset during shutdown failed");
-		return ret;
-	}
-	kfree_skb(skb);
-
-	/* Some platforms have an issue with BT LED when the interface is
-	 * down or BT radio is turned off, which takes 5 seconds to BT LED
-	 * goes off. This command turns off the BT LED immediately.
-	 */
-	skb = __hci_cmd_sync(hdev, 0xfc3f, 0, NULL, HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		ret = PTR_ERR(skb);
-		bt_dev_err(hdev, "turning off Intel device LED failed");
-		return ret;
-	}
-	kfree_skb(skb);
-
-	return 0;
-}
 
 static int btusb_shutdown_intel_new(struct hci_dev *hdev)
 {
@@ -4649,10 +4302,11 @@ static int btusb_probe(struct usb_interface *intf,
 		data->diag = usb_ifnum_to_if(data->udev, ifnum_base + 2);
 	}
 
-	if (id->driver_info & BTUSB_INTEL) {
+	/* Combined Intel Device setup to support multiple setup routine */
+	if (id->driver_info & BTUSB_INTEL_COMBINED) {
 		hdev->manufacturer = 2;
-		hdev->setup = btusb_setup_intel;
-		hdev->shutdown = btusb_shutdown_intel;
+		hdev->setup = btintel_setup_combined;
+		hdev->shutdown = btintel_shutdown_combined;
 		hdev->set_diag = btintel_set_diag_mfg;
 		hdev->set_bdaddr = btintel_set_bdaddr;
 		hdev->cmd_timeout = btusb_intel_cmd_timeout;
-- 
2.25.1

