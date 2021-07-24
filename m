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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563D8C4320E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Jul 2021 07:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 303D660E93
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Jul 2021 07:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbhGXGtv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 24 Jul 2021 02:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234398AbhGXGtl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 24 Jul 2021 02:49:41 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F203C061760
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Jul 2021 00:30:11 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so6763150pji.5
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Jul 2021 00:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4SluDkb1L3oRtZRJNuNua2R43YLcKawqwrHQeKH0Vzc=;
        b=aGE6UwxT8cCJD+AUXa8fx2YPC2IwavkoR2ZQadzFkeatPX84WGPh7d56RolgBLfQOT
         E3KC0Fs6Isbg92mKhO0JchjQv6kQyTQPjbvA0Ev4Ip68eHz3GRr4ZQqN+m57EHaFsGek
         5PaEZJj0tPJ1T4wlYngTm00VpXiRaBlUHeOReqVNdEHEODFNfmTX99BINgp2NQMtJYeg
         DfTwXi7rhvcAoRC2HQN5WH6HkIcQ9G7fOwgdOkbdMOfaw7tlDontS1TiBdzUAcajObZb
         exgLVjFrXEnGK5SgtyXbaUcRePBP32cu3zpMWmdfkVQwSILT/mfF3f5oRR9gq3ltQnxB
         DDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4SluDkb1L3oRtZRJNuNua2R43YLcKawqwrHQeKH0Vzc=;
        b=b6rHSxOrFj3yUM8lO0ETni85xTE9cHR56hG+Gf1F3qFIHBSPHqZib4FveFSrqgfh/0
         L7yUtszqq2lJLpHC83o3PukYkmzJFQ98acYj4I9rZkYilsprK27iVo2pt+/XZ71IVvAt
         0cQQNp2lhRVM1skX6jBWiP6SuXidxGJgjs2+wcTXYsrZ2gf/ZiwpzYWCDLh5/bMgZP+f
         iQFyPyCx1cebYSqCtPqoAU+uQgV+yxYWadaVdXKc/7GvAqwo0B3tsB1csiYxJuw/+u6Z
         k9HYa/mxXCgUYBIIICytLtvbJL3jpx/y6EFrdCfRn0WhGwvLdo5QBucS4CfRN7gWXIru
         U6vA==
X-Gm-Message-State: AOAM532KiILuj4/R5pA7fGEReUnL0GqWB+B8y5sNbdWXVXJv18sLICSu
        k5Rmbz3Itup3MtPinJIT5SLH8GApMgw=
X-Google-Smtp-Source: ABdhPJyhmkgsF1bgefKrwPxmWzbOZbTkiLb9RvRoepplJD8Fe6pS/Bcm0Xo+GrJtmeXlj1IKP0AA3w==
X-Received: by 2002:a17:903:1243:b029:ed:8298:7628 with SMTP id u3-20020a1709031243b02900ed82987628mr6614285plh.11.1627111810864;
        Sat, 24 Jul 2021 00:30:10 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830::1291])
        by smtp.gmail.com with ESMTPSA id u24sm38510919pfm.141.2021.07.24.00.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 00:30:10 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [RFC PATCH v3 2/9] Bluetooth: btintel: Add combined setup and shutdown functions
Date:   Sat, 24 Jul 2021 00:29:58 -0700
Message-Id: <20210724073005.714003-3-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210724073005.714003-1-hj.tedd.an@gmail.com>
References: <20210724073005.714003-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

There are multiple setup and shutdown functions for Intel device and the
setup function to use is depends on the USB PID/VID, which makes
difficult to maintain the code and increases the code size.

This patch adds combined setup and shutdown functions to provide a
single entry point for all Intel devices and choose the setup functions
based on the information read with HCI_Intel_Read_Version command.

Starting from TyP device, for HCI_Intel_Read_Version command, the
command parameter and response are changed even though OCF remains
same. Luckly the legacy devices still can handle the command without
error even if it has a extra parameter, so it uses the new command
format to support both legacy and new (tlv based) format.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btintel.c | 210 ++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h |  12 +++
 2 files changed, 222 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index e44b6993cf91..5513a2ba2504 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -236,6 +236,8 @@ int btintel_version_info(struct hci_dev *hdev, struct intel_version *ver)
 	 * compatibility options when newer hardware variants come along.
 	 */
 	switch (ver->hw_variant) {
+	case 0x07:	/* WP - Legacy ROM */
+	case 0x08:	/* StP - Legacy ROM */
 	case 0x0b:      /* SfP */
 	case 0x0c:      /* WsP */
 	case 0x11:      /* JfP */
@@ -250,9 +252,15 @@ int btintel_version_info(struct hci_dev *hdev, struct intel_version *ver)
 	}
 
 	switch (ver->fw_variant) {
+	case 0x01:
+		variant = "Legacy ROM 2.5";
+		break;
 	case 0x06:
 		variant = "Bootloader";
 		break;
+	case 0x22:
+		variant = "Legacy ROM 2.x";
+		break;
 	case 0x23:
 		variant = "Firmware";
 		break;
@@ -483,6 +491,98 @@ int btintel_version_info_tlv(struct hci_dev *hdev, struct intel_version_tlv *ver
 }
 EXPORT_SYMBOL_GPL(btintel_version_info_tlv);
 
+static int btintel_parse_version_tlv(struct hci_dev *hdev,
+				     struct intel_version_tlv *version,
+				     struct sk_buff *skb)
+{
+	/* Consume Command Complete Status field */
+	skb_pull(skb, 1);
+
+	/* Event parameters contatin multiple TLVs. Read each of them
+	 * and only keep the required data. Also, it use existing legacy
+	 * version field like hw_platform, hw_variant, and fw_variant
+	 * to keep the existing setup flow
+	 */
+	while (skb->len) {
+		struct intel_tlv *tlv;
+
+		tlv = (struct intel_tlv *)skb->data;
+		switch (tlv->type) {
+		case INTEL_TLV_CNVI_TOP:
+			version->cnvi_top = get_unaligned_le32(tlv->val);
+			break;
+		case INTEL_TLV_CNVR_TOP:
+			version->cnvr_top = get_unaligned_le32(tlv->val);
+			break;
+		case INTEL_TLV_CNVI_BT:
+			version->cnvi_bt = get_unaligned_le32(tlv->val);
+			break;
+		case INTEL_TLV_CNVR_BT:
+			version->cnvr_bt = get_unaligned_le32(tlv->val);
+			break;
+		case INTEL_TLV_DEV_REV_ID:
+			version->dev_rev_id = get_unaligned_le16(tlv->val);
+			break;
+		case INTEL_TLV_IMAGE_TYPE:
+			version->img_type = tlv->val[0];
+			break;
+		case INTEL_TLV_TIME_STAMP:
+			/* If image type is Operational firmware (0x03), then
+			 * running FW Calendar Week and Year information can
+			 * be extracted from Timestamp information
+			 */
+			version->min_fw_build_cw = tlv->val[0];
+			version->min_fw_build_yy = tlv->val[1];
+			version->timestamp = get_unaligned_le16(tlv->val);
+			break;
+		case INTEL_TLV_BUILD_TYPE:
+			version->build_type = tlv->val[0];
+			break;
+		case INTEL_TLV_BUILD_NUM:
+			/* If image type is Operational firmware (0x03), then
+			 * running FW build number can be extracted from the
+			 * Build information
+			 */
+			version->min_fw_build_nn = tlv->val[0];
+			version->build_num = get_unaligned_le32(tlv->val);
+			break;
+		case INTEL_TLV_SECURE_BOOT:
+			version->secure_boot = tlv->val[0];
+			break;
+		case INTEL_TLV_OTP_LOCK:
+			version->otp_lock = tlv->val[0];
+			break;
+		case INTEL_TLV_API_LOCK:
+			version->api_lock = tlv->val[0];
+			break;
+		case INTEL_TLV_DEBUG_LOCK:
+			version->debug_lock = tlv->val[0];
+			break;
+		case INTEL_TLV_MIN_FW:
+			version->min_fw_build_nn = tlv->val[0];
+			version->min_fw_build_cw = tlv->val[1];
+			version->min_fw_build_yy = tlv->val[2];
+			break;
+		case INTEL_TLV_LIMITED_CCE:
+			version->limited_cce = tlv->val[0];
+			break;
+		case INTEL_TLV_SBE_TYPE:
+			version->sbe_type = tlv->val[0];
+			break;
+		case INTEL_TLV_OTP_BDADDR:
+			memcpy(&version->otp_bd_addr, tlv->val, tlv->len);
+			break;
+		default:
+			/* Ignore rest of information */
+			break;
+		}
+		/* consume the current tlv and move to next*/
+		skb_pull(skb, tlv->len + sizeof(*tlv));
+	}
+
+	return 0;
+}
+
 int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *version)
 {
 	struct sk_buff *skb;
@@ -1272,6 +1372,116 @@ int btintel_set_debug_features(struct hci_dev *hdev,
 }
 EXPORT_SYMBOL_GPL(btintel_set_debug_features);
 
+int btintel_setup_combined(struct hci_dev *hdev)
+{
+	const u8 param[1] = { 0xFF };
+	struct intel_version ver;
+	struct intel_version_tlv ver_tlv;
+	struct sk_buff *skb;
+	int err;
+
+	BT_DBG("%s", hdev->name);
+
+	/* Starting from TyP device, the command parameter and response are
+	 * changed even though the OCF for HCI_Intel_Read_Version command
+	 * remains same. The legacy devices can handle even if the
+	 * command has a parameter and returns a correct version information.
+	 * So, it uses new format to support both legacy and new format.
+	 */
+	skb = __hci_cmd_sync(hdev, 0xfc05, 1, param, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Reading Intel version command failed (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	/* Check the status */
+	if (skb->data[0]) {
+		bt_dev_err(hdev, "Intel Read Version command failed (%02x)",
+			   skb->data[0]);
+		kfree_skb(skb);
+		return -EIO;
+	}
+
+	/* For Legacy device, check the HW platform value and size */
+	if (skb->data[1] == 0x37 && skb->len == sizeof(ver)) {
+		bt_dev_dbg(hdev, "Read the legacy Intel version information");
+
+		memcpy(&ver, skb->data, sizeof(ver));
+
+		/* Display version information */
+		btintel_version_info(hdev, &ver);
+
+		/* Identify the device type based on the read version */
+		switch (ver.hw_variant) {
+		case 0x07:	/* WP */
+		case 0x08:	/* StP */
+			/* Legacy ROM product */
+			/* TODO: call setup routine for legacy rom product */
+			break;
+		case 0x0b:      /* SfP */
+		case 0x0c:      /* WsP */
+		case 0x11:      /* JfP */
+		case 0x12:      /* ThP */
+		case 0x13:      /* HrP */
+		case 0x14:      /* CcP */
+			/* TODO: call setup routine for bootloader product */
+			break;
+		default:
+			bt_dev_err(hdev, "Unsupported Intel hw variant (%u)",
+				   ver.hw_variant);
+			return -EINVAL;
+		}
+
+		return err;
+	}
+
+	/* For TLV type device, parse the tlv data */
+	btintel_parse_version_tlv(hdev, &ver_tlv, skb);
+
+	/* Display version information of TLV type */
+	btintel_version_info_tlv(hdev, &ver_tlv);
+
+	/* TODO: Need to filter the device for new generation */
+	/* TODO: call setup routine for tlv based bootloader product */
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(btintel_setup_combined);
+
+int btintel_shutdown_combined(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+
+	/* Send HCI Reset to the controller to stop any BT activity which
+	 * were triggered. This will help to save power and maintain the
+	 * sync b/w Host and controller
+	 */
+	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "HCI reset during shutdown failed");
+		return PTR_ERR(skb);
+	}
+	kfree_skb(skb);
+
+	/* Fix me: All legacy ROM and RAM works?
+	 * This code was only for legacy ROM
+	 */
+	/* Some platforms have an issue with BT LED when the interface is
+	 * down or BT radio is turned off, which takes 5 seconds to BT LED
+	 * goes off. This command turns off the BT LED immediately.
+	 */
+	skb = __hci_cmd_sync(hdev, 0xfc3f, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "turning off Intel device LED failed");
+		return PTR_ERR(skb);
+	}
+	kfree_skb(skb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btintel_shutdown_combined);
+
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
 MODULE_VERSION(VERSION);
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index d184064a5e7c..68ffa84fa87a 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -165,6 +165,8 @@ int btintel_read_boot_params(struct hci_dev *hdev,
 			     struct intel_boot_params *params);
 int btintel_download_firmware(struct hci_dev *dev, struct intel_version *ver,
 			      const struct firmware *fw, u32 *boot_param);
+int btintel_setup_combined(struct hci_dev *hdev);
+int btintel_shutdown_combined(struct hci_dev *hdev);
 int btintel_download_firmware_newgen(struct hci_dev *hdev,
 				     struct intel_version_tlv *ver,
 				     const struct firmware *fw,
@@ -283,6 +285,16 @@ static inline int btintel_download_firmware(struct hci_dev *dev,
 	return -EOPNOTSUPP;
 }
 
+static inline int btintel_setup_combined(struct hci_dev *hdev)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int btintel_shutdown_combined(struct hci_dev *hdev)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int btintel_download_firmware_newgen(struct hci_dev *hdev,
 						   const struct firmware *fw,
 						   u32 *boot_param,
-- 
2.26.3

