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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3683C4320E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 00:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9899361040
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 00:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbhHEAck (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 20:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236205AbhHEAcj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 20:32:39 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAA1C061765
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Aug 2021 17:32:25 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so11506198pjs.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Aug 2021 17:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aH2xZxF7WBQ1in2KTPvVvNq1F43XYlTmuuTjLi5L3K8=;
        b=ECWT5TXhwfVWJeZK2jVUVfudDSuxucV4/WdDGnjOmUyua79YHuOOvTJKFcdF5k0k/6
         m/qwJQIIiFLUPdA4KU5A51jHHvMu5M1G/9qQVxPw24EY1y/FVn7WIgzPS0St6GpAe41P
         3PbvXAgX4L86Xu8BKFdGuwTuWJ+1ILFv41Dv56YtZfvczssKv91u6SBIq/AqZuLfJEFq
         wxKKqEHEcNUR9XJ6xgKONhttiq3eLZqbIYA/JmnwxMOtsQPuLsU4nONESYg6xDN8mVyp
         jyV4Lo97Z/YemBBX6hUccKiBWo5ntSlq9q70F7x+rKj7YLoWqwfBNbiW4TtIepni46PA
         6hmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aH2xZxF7WBQ1in2KTPvVvNq1F43XYlTmuuTjLi5L3K8=;
        b=dd5EGNiyXztDTUjZDp5SL4QSisLpD3aIWbfBM+0Ufs16bVPjkpwJEkCNTieZ+t7dB0
         iftsPg06Jcx82L+kyIu7sj6xv8FIj1gczASUChPbIgmhUJbAUU1ZGaJLkwRoBCF8UBUv
         d28OtobtMlDYNqV2zJpTtk5xtNHOBfmog994oUXGIwYlhzN6pAD5fpHqQDiefNgQLDtg
         6kGyULBPouEyzxg1RuvOaQaZo8DEmpSiSRruBF6/Z5eo7DLF7j/2AAREBHaDH8NcPvDM
         owFRxX2E3IjzTe+5lV1Cye7boVhPKRhNj3osnvk/+uXwFkYsJT2JES8FtHV2wGPRCY0N
         Ntvg==
X-Gm-Message-State: AOAM531rPwSPfYrXdTMxuS/22J10E+0qHiLkq9Z1/NxXzQYekNAxvjyh
        cZ22ztaM4UpfHi0C3WQLUOyg0ugqBww=
X-Google-Smtp-Source: ABdhPJym3OZ5JMeCAdEjTVoj2aIu8XoYZTSkWbJSv9fWhqwwdIPG9MPMMyUrbctmTUdkaO4cEItI8g==
X-Received: by 2002:a62:17d8:0:b029:3b1:c2b0:287c with SMTP id 207-20020a6217d80000b02903b1c2b0287cmr1967654pfx.23.1628123544976;
        Wed, 04 Aug 2021 17:32:24 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:e0b8:5332:84:7056])
        by smtp.gmail.com with ESMTPSA id q4sm4761787pgv.16.2021.08.04.17.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 17:32:24 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH v7 02/12] Bluetooth: btintel: Add combined setup and shutdown functions
Date:   Wed,  4 Aug 2021 17:32:09 -0700
Message-Id: <20210805003219.23221-3-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210805003219.23221-1-hj.tedd.an@gmail.com>
References: <20210805003219.23221-1-hj.tedd.an@gmail.com>
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
 drivers/bluetooth/btintel.c | 235 ++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h |   6 +
 2 files changed, 241 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index e44b6993cf91..2fac6babb4b1 100644
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
@@ -483,6 +491,108 @@ int btintel_version_info_tlv(struct hci_dev *hdev, struct intel_version_tlv *ver
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
+		if (skb->len < sizeof(*tlv))
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
+			memcpy(&version->otp_bd_addr, tlv->val,
+							sizeof(bdaddr_t));
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
@@ -1272,6 +1382,131 @@ int btintel_set_debug_features(struct hci_dev *hdev,
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
+		err = -EIO;
+		goto exit_error;
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
+			err = -EINVAL;
+		}
+
+		goto exit_error;
+	}
+
+	/* For TLV type device, parse the tlv data */
+	err = btintel_parse_version_tlv(hdev, &ver_tlv, skb);
+	if (err) {
+		bt_dev_err(hdev, "Failed to parse TLV version information");
+		goto exit_error;
+	}
+
+	if (INTEL_HW_PLATFORM(ver_tlv.cnvi_bt) != 0x37) {
+		bt_dev_err(hdev, "Unsupported Intel hardware platform (0x%2x)",
+			   INTEL_HW_PLATFORM(ver_tlv.cnvi_bt));
+		err = -EINVAL;
+		goto exit_error;
+	}
+
+	/* Display version information of TLV type */
+	btintel_version_info_tlv(hdev, &ver_tlv);
+
+	/* TODO: Need to filter the device for new generation */
+	/* TODO: call setup routine for tlv based bootloader product */
+
+exit_error:
+	kfree_skb(skb);
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

