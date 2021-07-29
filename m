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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE65C432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 18:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AF3760EFF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 18:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhG2SgL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 14:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhG2SgL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 14:36:11 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAA4C0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 11:36:06 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id a20so8065643plm.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 11:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gEtHqHDICOxC6nOLr8FC2FMeUC6BbFdru3RaNIXsAys=;
        b=W9HQLtMOyXeWQe9mbvcXWwsMAC3otbBgl3Y9cl4QFcWTUVD8uv+FFbZeU+JIlxC1R6
         ffFh6va8wckHv5NFKU9vdDKB7RF8lsMJ0KzSkNgf1M8tJvD2EhuJ/SAGL/GL4LqsOBJ3
         TjHmSlujzG7H94WqoU1Z8wSWTstPaf54dB4LVII3JaS4+Bye1usxa2RD+jTm6iIHpxQL
         hzOyLyuvXLjSt2ljwjrVsnzzLcV7EREkdEbiata6dwrL3sNVed5L7fOoU/UNpWFyRzql
         zIWWJ5BFnR4Y10XsisJxrOSBOPy3xU9V9wkZ9fUPDh30NRqnTtjunYSpbA5n7B2vMSmp
         arBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gEtHqHDICOxC6nOLr8FC2FMeUC6BbFdru3RaNIXsAys=;
        b=KGJdsJ41YjaXyNiqa+APeO3rormCpD0UcW+tenhRWLkH2Orwbn6xzDcYr68/0fRYhJ
         66/LGU/3W2RpdIW/xsiCXCiQViseRvnndK8E4ZnDYFIv9z8skLVuwQZxdcvR36XY8O59
         fO7WCDFnYpq7dw/L4nzjc6MdQjXW1knSL9D3KGSEpNw5OQ5H9xwdx0iFvoaRoUaUzZWC
         fU3Y74EzZKT+WwQacMDBLz6ZZ+efrA42e2FDi1x4KkuZnfnlcGh/sqX8P3qOvDxemo2w
         6SYJH9wXBzfUz2lVpJdSELFBwXLg0qxPbfCUhG0hSb+NrTYIy4DESfNgRqD7eq5bNfDC
         GtWQ==
X-Gm-Message-State: AOAM532vv0a66GJXowW0xbiCTpafqRloMea6kKjrIzwUIkdQdVJBFRX4
        Qym7yHpqMgTUiK259RCn1hfwQEmEQw0=
X-Google-Smtp-Source: ABdhPJyEGIty1MfT2tDlnPRJHdLPF7EEY2EkqE/A1Iwm3ZJpSObYT032CoXvw0ujHlIup2mOoNE5Tg==
X-Received: by 2002:a63:88c7:: with SMTP id l190mr2406229pgd.438.1627583766148;
        Thu, 29 Jul 2021 11:36:06 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:6349:1ee2:dda3:7891])
        by smtp.gmail.com with ESMTPSA id i1sm10943130pjs.31.2021.07.29.11.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 11:36:05 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH v5 02/11] Bluetooth: btintel: Add combined setup and shutdown functions
Date:   Thu, 29 Jul 2021 11:35:51 -0700
Message-Id: <20210729183600.281586-3-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210729183600.281586-1-hj.tedd.an@gmail.com>
References: <20210729183600.281586-1-hj.tedd.an@gmail.com>
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
 drivers/bluetooth/btintel.c | 196 ++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h |  12 +++
 2 files changed, 208 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index e44b6993cf91..a23304435814 100644
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
@@ -1272,6 +1372,102 @@ int btintel_set_debug_features(struct hci_dev *hdev,
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
2.25.1

