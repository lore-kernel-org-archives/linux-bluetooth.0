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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68FAC4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 04:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4CDF61100
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 04:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbhHDEk5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 00:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbhHDEkz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 00:40:55 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30FFC0613D5
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 21:40:42 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id nh14so1257097pjb.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 21:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jYRLgfHTRsJVLzZv/ykNOamtJ0dqreqsQaxbQDO1RbY=;
        b=RmYjm4dw04lVf1SFnGM6WkRKKdWPmE89DdAygcuxVMCJqVn7u9jYcUMAG6Abu0Bdps
         yfoIqGwu3mgFrb9vv3/FpKzxQ7WhTFpQcnRZ5HubacoC0GPkpIM1dHm+lxoEF4DPt5zq
         jRmgCVu4rTdRqfoZeyu1LKw3AtRo+BSaG9TfA7tnDwarEkrBdiOAdQdYW24E05P7dq6Q
         8xzV67hAros5dV+Euo++reU3wlqP2dGjTd7r3ZC1SFoevzeHdWLyzv6XutTNeyymY+eY
         7n2nPi3dqKElMYOs+4e4z6k9B4XAd59uyVV/2OczqUfn6rN42gTXPXFkBqET8UOHaVq6
         Mvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jYRLgfHTRsJVLzZv/ykNOamtJ0dqreqsQaxbQDO1RbY=;
        b=tUfpKlrfrHUzcgextiE3rE/Tdbhhw2tSQ5X0oCwsUF1JafzaoAli9nZphJHt5e5+JH
         fSiiUcIdjKnBJO6eEi5vHjzqg3bj5thNWhvEYe8TrnvZ1uAvlMhi/oHP2if8XEzaBo6z
         uClaj290Xp/9LPjqQSenDERTMtZJfDmaFM0rENqmClcpUv89MsJh1grj6vALHnuAYHnx
         WkTWfD79e2va5EiKf/RriqHDhmtWTe9I+ZbvJD5la4Rs/e4oQa9Y4OC+IKRWL/nhpIh+
         zZYY1A/AQOcYLnnuzZRUH3i8njKaKYbzP4LHWwqovr5lPTdp5VkPxVVb2f0DBei7fbe7
         ymVw==
X-Gm-Message-State: AOAM531f8L8r1C0ww+DhKoPrmQ84cwWe8nEob1rYkvhDg6MZJnpAiJY1
        G3EbmU3XcVLn2nhj3B9n4mGvS39SyVw=
X-Google-Smtp-Source: ABdhPJww8oh+rTSH7GrVfFC6tul8QqjY14UvyFy0fVJuckYnEGvLYFBZpLMaEyH1Xaf8Es1hLaS9oQ==
X-Received: by 2002:a63:5659:: with SMTP id g25mr211460pgm.354.1628052042092;
        Tue, 03 Aug 2021 21:40:42 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:12af:cd05:f7eb:e8f5])
        by smtp.gmail.com with ESMTPSA id w2sm835478pjq.5.2021.08.03.21.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 21:40:40 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH v6 03/12] Bluetooth: btintel: Refactoring setup routine for legacy ROM sku
Date:   Tue,  3 Aug 2021 21:40:23 -0700
Message-Id: <20210804044032.59729-4-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210804044032.59729-1-hj.tedd.an@gmail.com>
References: <20210804044032.59729-1-hj.tedd.an@gmail.com>
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
 drivers/bluetooth/btintel.c | 293 +++++++++++++++++++++++++++-
 drivers/bluetooth/btintel.h |   6 -
 drivers/bluetooth/btusb.c   | 370 ++----------------------------------
 3 files changed, 301 insertions(+), 368 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 3d98fc2a64b9..a4c8329a8945 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -164,7 +164,7 @@ int btintel_set_diag(struct hci_dev *hdev, bool enable)
 }
 EXPORT_SYMBOL_GPL(btintel_set_diag);
 
-int btintel_set_diag_mfg(struct hci_dev *hdev, bool enable)
+static int btintel_set_diag_mfg(struct hci_dev *hdev, bool enable)
 {
 	int err, ret;
 
@@ -180,7 +180,6 @@ int btintel_set_diag_mfg(struct hci_dev *hdev, bool enable)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(btintel_set_diag_mfg);
 
 void btintel_hw_error(struct hci_dev *hdev, u8 code)
 {
@@ -1381,6 +1380,291 @@ int btintel_set_debug_features(struct hci_dev *hdev,
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
 static int btintel_setup_combined(struct hci_dev *hdev)
 {
 	const u8 param[1] = { 0xFF };
@@ -1432,7 +1716,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		case 0x07:	/* WP */
 		case 0x08:	/* StP */
 			/* Legacy ROM product */
-			/* TODO: call setup routine for legacy rom product */
+			err = btintel_legacy_rom_setup(hdev, &ver);
 			break;
 		case 0x0b:      /* SfP */
 		case 0x0c:      /* WsP */
@@ -1493,10 +1777,11 @@ static int btintel_shutdown_combined(struct hci_dev *hdev)
 
 int btintel_configure_setup(struct hci_dev *hdev)
 {
-	/* TODO: Setup hdev callback here */
 	hdev->manufacturer = 2;
 	hdev->setup = btintel_setup_combined;
 	hdev->shutdown = btintel_shutdown_combined;
+	hdev->set_diag = btintel_set_diag_mfg;
+	hdev->set_bdaddr = btintel_set_bdaddr;
 
 	return 0;
 }
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index dda890d94a07..2c87fd029ddf 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -145,7 +145,6 @@ int btintel_enter_mfg(struct hci_dev *hdev);
 int btintel_exit_mfg(struct hci_dev *hdev, bool reset, bool patched);
 int btintel_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 int btintel_set_diag(struct hci_dev *hdev, bool enable);
-int btintel_set_diag_mfg(struct hci_dev *hdev, bool enable);
 void btintel_hw_error(struct hci_dev *hdev, u8 code);
 
 int btintel_version_info(struct hci_dev *hdev, struct intel_version *ver);
@@ -203,11 +202,6 @@ static inline int btintel_set_diag(struct hci_dev *hdev, bool enable)
 	return -EOPNOTSUPP;
 }
 
-static inline int btintel_set_diag_mfg(struct hci_dev *hdev, bool enable)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline void btintel_hw_error(struct hci_dev *hdev, u8 code)
 {
 }
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b1a05bb9f4bf..54a951ee00ce 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -43,7 +43,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_BROKEN_ISOC	0x20
 #define BTUSB_WRONG_SCO_MTU	0x40
 #define BTUSB_ATH3012		0x80
-#define BTUSB_INTEL		0x100
+#define BTUSB_INTEL_COMBINED	0x100
 #define BTUSB_INTEL_BOOT	0x200
 #define BTUSB_BCM_PATCHRAM	0x400
 #define BTUSB_MARVELL		0x800
@@ -372,11 +372,11 @@ static const struct usb_device_id blacklist_table[] = {
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
@@ -1964,319 +1964,6 @@ static int btusb_setup_csr(struct hci_dev *hdev)
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
@@ -3055,41 +2742,6 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 
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
@@ -4664,13 +4316,15 @@ static int btusb_probe(struct usb_interface *intf,
 		data->diag = usb_ifnum_to_if(data->udev, ifnum_base + 2);
 	}
 
-	if (id->driver_info & BTUSB_INTEL) {
-		hdev->manufacturer = 2;
-		hdev->setup = btusb_setup_intel;
-		hdev->shutdown = btusb_shutdown_intel;
-		hdev->set_diag = btintel_set_diag_mfg;
-		hdev->set_bdaddr = btintel_set_bdaddr;
+	/* Combined Intel Device setup to support multiple setup routine */
+	if (id->driver_info & BTUSB_INTEL_COMBINED) {
+		err = btintel_configure_setup(hdev);
+		if (err)
+			goto out_free_dev;
+
+		/* Transport specific configuration */
 		hdev->cmd_timeout = btusb_intel_cmd_timeout;
+
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
-- 
2.25.1

