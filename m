Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61A9C4320A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 04:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE2D061104
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 04:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbhHDEky (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 00:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbhHDEkx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 00:40:53 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F186C061798
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 21:40:40 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l19so1301206pjz.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 21:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ilStQ9Gk25ZUDcWRrw6tl7PH8Lz2apw5gI7LgeIXME=;
        b=e8xKltKYSslEgH1WBn2qts6c4wuKZfislmrJIWIgOD4V+OaxGkr1DseJnRSyXb6Kym
         9jknXdDqihXq5uOqkVR1X3a2MtJOHBcjUvAebN7Y5svDuXbTiaZLY070gK8n7GXaqILm
         BeMgM0OLWNIy1EYOpnq3TQRmo7409h6/b5aMPFgqS+1CJPqxkodNpE+ksfA82O3qR7ll
         uBonc6nOCUNWlI9Z7ZmENg9G97GAYVR4P95dI+f0Rpz9Y6/8g+fTdWwNf7985fxTx4pT
         70LiDPzDMiMja/NpwyO+438mOdq1OBrhFJkKd2UCRxhbPDd02iATIgPLIAFrwyIkY8Sk
         MZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ilStQ9Gk25ZUDcWRrw6tl7PH8Lz2apw5gI7LgeIXME=;
        b=nr2BGUnr6kshxTLB8g722xmfW4cxabflNflPxTGle2afFX9x96qvpORmzFi9ov2Alh
         R7SiFKdmcuqdZ2sEN7XfXuMYOVg6lLEjrNywJ87iwMhjIOkS8Buq7Cjdo7A+ZFbnlZeN
         deyEG4dRLNP5VmRKIIglq/u6EVCxqYbTaAn96crYNm9F8X5aotmbE7epe/18eFJuCu2z
         NFpeYAxER6V8jXyxuRjcRooubkBJKZU4WqZY8uLsgg7bWcB+dYJgWKX2r92FXsXbg5N9
         YkLC6AP9oKuE5cEMxuFFoRbec10AJZa+mfyTl5nfoMpYpWiGpYwJ9jxMTcTLs/nXsLUu
         SPfg==
X-Gm-Message-State: AOAM533rjoD3+Yr0B7LUHxsdJAQLPgYtgy8tgtpBFccLsZllw4trNiwu
        8dLsASEVvqreglgPrmFfD8SfKGcNQvA=
X-Google-Smtp-Source: ABdhPJwIVZvuCKQIcY6rnRR9LMr/EVFt4vrQpzSCs791RZKvspigYt1zYs/oBNIX+hIGE0cEqkvhMA==
X-Received: by 2002:a63:a0d:: with SMTP id 13mr396327pgk.429.1628052039753;
        Tue, 03 Aug 2021 21:40:39 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:12af:cd05:f7eb:e8f5])
        by smtp.gmail.com with ESMTPSA id w2sm835478pjq.5.2021.08.03.21.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 21:40:39 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH v6 02/12] Bluetooth: btintel: Add combined setup and shutdown functions
Date:   Tue,  3 Aug 2021 21:40:22 -0700
Message-Id: <20210804044032.59729-3-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210804044032.59729-1-hj.tedd.an@gmail.com>
References: <20210804044032.59729-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

There are multiple setup and shutdown functions for Intel device and the
setup function to be used is depends on the USB PID/VID, which makes
difficult to maintain the code and increases the code size.

This patch adds combined setup and shutdown functions to provide a
single entry point for all Intel devices and choose the setup functions
based on the information read with HCI_Intel_Read_Version command.

Starting from TyP device, the command and response parameters for
HCI_Intel_Read_Version command are changed even though OCF remains
same. However, the legacy devices still can handle the command without
error even if it has a extra parameter, so to simplify the flow,
the new command format is used to read the version information for
both legacy and new (tlv based) format.

Also, it also adds a routine to setup the hdev callbacks in btintel.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btintel.c | 230 ++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h |   6 +
 2 files changed, 236 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index e44b6993cf91..3d98fc2a64b9 100644
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
@@ -483,6 +491,107 @@ int btintel_version_info_tlv(struct hci_dev *hdev, struct intel_version_tlv *ver
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
+		/* Make sure skb has a minimum length of the header */
+		if (skb->len < 2)
+			return -EINVAL;
+
+		tlv = (struct intel_tlv *)skb->data;
+
+		/* Make sure skb has a enough data */
+		if (skb->len < tlv->len + sizeof(*tlv))
+			return -EINVAL;
+
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
@@ -1272,6 +1381,127 @@ int btintel_set_debug_features(struct hci_dev *hdev,
 }
 EXPORT_SYMBOL_GPL(btintel_set_debug_features);
 
+static int btintel_setup_combined(struct hci_dev *hdev)
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
+	if (skb->len == sizeof(ver) && skb->data[1] == 0x37) {
+		bt_dev_dbg(hdev, "Read the legacy Intel version information");
+
+		memcpy(&ver, skb->data, sizeof(ver));
+
+		/* Display version information */
+		btintel_version_info(hdev, &ver);
+
+		/* Check for supported iBT hardware variants of this firmware
+		 * loading method.
+		 *
+		 * This check has been put in place to ensure correct forward
+		 * compatibility options when newer hardware variants come
+		 * along.
+		 */
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
+	err = btintel_parse_version_tlv(hdev, &ver_tlv, skb);
+	if (err) {
+		bt_dev_err(hdev, "Failed to parse TLV version information");
+		return err;
+	}
+
+	if (INTEL_HW_PLATFORM(ver_tlv.cnvi_bt) != 0x37) {
+		bt_dev_err(hdev, "Unsupported Intel hardware platform (0x%2x)",
+			   INTEL_HW_PLATFORM(ver_tlv.cnvi_bt));
+		return -EINVAL;
+	}
+
+	/* Display version information of TLV type */
+	btintel_version_info_tlv(hdev, &ver_tlv);
+
+	/* TODO: Need to filter the device for new generation */
+	/* TODO: call setup routine for tlv based bootloader product */
+
+	return err;
+}
+
+static int btintel_shutdown_combined(struct hci_dev *hdev)
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
+
+int btintel_configure_setup(struct hci_dev *hdev)
+{
+	/* TODO: Setup hdev callback here */
+	hdev->manufacturer = 2;
+	hdev->setup = btintel_setup_combined;
+	hdev->shutdown = btintel_shutdown_combined;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btintel_configure_setup);
+
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
 MODULE_VERSION(VERSION);
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index d184064a5e7c..dda890d94a07 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -175,6 +175,7 @@ int btintel_read_debug_features(struct hci_dev *hdev,
 				struct intel_debug_features *features);
 int btintel_set_debug_features(struct hci_dev *hdev,
 			       const struct intel_debug_features *features);
+int btintel_configure_setup(struct hci_dev *hdev);
 #else
 
 static inline int btintel_check_bdaddr(struct hci_dev *hdev)
@@ -307,4 +308,9 @@ static inline int btintel_set_debug_features(struct hci_dev *hdev,
 	return -EOPNOTSUPP;
 }
 
+static inline int btintel_configure_setup(struct hci_dev *hdev)
+{
+	return -ENODEV;
+}
+
 #endif
-- 
2.25.1

