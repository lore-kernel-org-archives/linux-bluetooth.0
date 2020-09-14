Return-Path: <SRS0=Sobe=CX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095A3C433E2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Sep 2020 14:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A15BB20EDD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Sep 2020 14:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdrGKrX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgINORL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Sep 2020 10:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgINNZj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Sep 2020 09:25:39 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7491C06178A
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2020 06:25:39 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x123so12627371pfc.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2020 06:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2D93YQlVq3/F7NWnGdwtrXN5hz11APEKsPD3SeHWzpw=;
        b=IdrGKrX8iSl5vhvbBky4xLfFI/DFJDgxELSOu7RVLpjRbP0LQsGqSp0cCI/u69gG5i
         HeoCiCXvNIbyAGXZ9helnn1180JUI5PMMYmfh37RmkcTOF7fCNXSWUtW2t+REAti0Hrh
         srkT+GtLZxWYBp87Gvtd0plF9bpF7Xci4q1uu9vaWHAsUR0FWfZ/XciwFoZ6fYxgl0Lk
         DNLxwDFyk7zC1G/90NwZidaPerthi7I8ArQ3z4WOhoOjcl6ZJ7shZ5p+TeO3BZy+tqCR
         NfKCHezhBsNdKtp79wOu6EGcJWMWD6miTpZv55tC7ceU49mT51DBbBtwWLkF4J54mRn1
         EfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2D93YQlVq3/F7NWnGdwtrXN5hz11APEKsPD3SeHWzpw=;
        b=uTjrApBAkc3SzGblYmUfOjU/ECqxNgYvwAPX09HvU/+QNRlCMoEqfIHG1Dp/uEm4mo
         j246Yb+/+EGxtVrnpjImAPmMbikX0+FyAw+ceXP8IuB5VTAI+z+Nek0gXu0y3xzpPLFW
         Dr+4b7CJFvsk2RX+janovyr07ThtN1unex3D6+0wgEVcHfrs4l8B/Vm+cWpL02CvXRSg
         xcD6JD48HTw1prg1xTP9rRj4N2KdO//cAu2bhKpYZEXTH6nJwxFCS2UTzcByr5WirmcV
         7T9llnbLLIx4O2Aj2Yu6jR44Edjz8f54T6JqHf5HAHO9Dai2rVWKFxMnkgm+cfAAab5g
         GFeg==
X-Gm-Message-State: AOAM531x8SRJBb5KG/Bh9hOZDi91clWq+VC1vz7C/rH2CPW4hJKA99+2
        KHleZGu5GdUrbBpzN5lteHet5/HDcGso4g==
X-Google-Smtp-Source: ABdhPJxZYyAxhxf65G28vtUPOO2VXNhT/iUVIl6lcPPy+W7GFriVSRkbeTwW7HpypOJVYB736dP7ag==
X-Received: by 2002:a63:806:: with SMTP id 6mr3675459pgi.71.1600089938553;
        Mon, 14 Sep 2020 06:25:38 -0700 (PDT)
Received: from localhost.localdomain ([171.61.74.206])
        by smtp.gmail.com with ESMTPSA id m20sm10776707pfa.115.2020.09.14.06.25.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Sep 2020 06:25:37 -0700 (PDT)
From:   Kiran K <kiraank@gmail.com>
X-Google-Original-From: Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chethan.tumkur.narayan@intel.com, ravishankar.srivatsa@intel.com,
        kiraank@gmail.com, Kiran K <kiran.k@intel.com>,
        Amit K Bag <amit.k.bag@intel.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>
Subject: [PATCH v1 1/2] Bluetooth: btintel: Add infrastructure to read controller information
Date:   Mon, 14 Sep 2020 18:55:05 +0530
Message-Id: <1600089906-9852-1-git-send-email-kiran.k@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

New generation Intel controllers returns version information in TLV
format. This patch adds,

1) Enums, structures for TLV

2) function to read controller information, parse TLV data and populate
   intel_version_tlv structure

3) function to print version information

Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
 drivers/bluetooth/btintel.c | 138 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h |  79 +++++++++++++++++++++++++
 2 files changed, 217 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index dc6f1a9..e99fc6e 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -361,6 +361,144 @@ int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver)
 }
 EXPORT_SYMBOL_GPL(btintel_read_version);
 
+void btintel_version_info_tlv(struct hci_dev *hdev, struct intel_version_tlv *version)
+{
+	const char *variant;
+
+	switch (version->img_type) {
+	case 0x01:
+		variant = "Bootloader";
+		bt_dev_info(hdev, "Device revision is %u", version->dev_rev_id);
+		bt_dev_info(hdev, "Secure boot is %s",
+			    version->secure_boot ? "enabled" : "disabled");
+		bt_dev_info(hdev, "OTP lock is %s",
+			    version->otp_lock ? "enabled" : "disabled");
+		bt_dev_info(hdev, "API lock is %s",
+			    version->api_lock ? "enabled" : "disabled");
+		bt_dev_info(hdev, "Debug lock is %s",
+			    version->debug_lock ? "enabled" : "disabled");
+		bt_dev_info(hdev, "Minimum firmware build %u week %u %u",
+			    version->min_fw_build_nn, version->min_fw_build_cw,
+			    2000 + version->min_fw_build_yy);
+		break;
+	case 0x03:
+		variant = "Firmware";
+		break;
+	default:
+		bt_dev_err(hdev, "Unsupported image type(%02x)", version->img_type);
+		goto done;
+	}
+
+	bt_dev_info(hdev, "%s timestamp %u.%u buildtype %u build %u", variant,
+		    2000 + (version->timestamp >> 8), version->timestamp & 0xff,
+		    version->build_type, version->build_num);
+
+done:
+	return;
+}
+EXPORT_SYMBOL_GPL(btintel_version_info_tlv);
+
+int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *version)
+{
+	struct sk_buff *skb;
+	const u8 param[1] = { 0xFF };
+
+	if (!version)
+		return -EINVAL;
+
+	skb = __hci_cmd_sync(hdev, 0xfc05, 1, param, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Reading Intel version information failed (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	if (skb->data[0]) {
+		bt_dev_err(hdev, "Intel Read Version command failed (%02x)",
+			   skb->data[0]);
+		kfree_skb(skb);
+		return -EIO;
+	}
+
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
+			version->timestamp = get_unaligned_le16(tlv->val);
+			break;
+		case INTEL_TLV_BUILD_TYPE:
+			version->build_type = tlv->val[0];
+			break;
+		case INTEL_TLV_BUILD_NUM:
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
+	kfree_skb(skb);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btintel_read_version_tlv);
+
 /* ------- REGMAP IBT SUPPORT ------- */
 
 #define IBT_REG_MODE_8BIT  0x00
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 08e2060..829e1fc 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -6,6 +6,72 @@
  *  Copyright (C) 2015  Intel Corporation
  */
 
+/* List of tlv type */
+enum {
+	INTEL_TLV_CNVI_TOP = 0x10,
+	INTEL_TLV_CNVR_TOP,
+	INTEL_TLV_CNVI_BT,
+	INTEL_TLV_CNVR_BT,
+	INTEL_TLV_CNVI_OTP,
+	INTEL_TLV_CNVR_OTP,
+	INTEL_TLV_DEV_REV_ID,
+	INTEL_TLV_USB_VENDOR_ID,
+	INTEL_TLV_USB_PRODUCT_ID,
+	INTEL_TLV_PCIE_VENDOR_ID,
+	INTEL_TLV_PCIE_DEVICE_ID,
+	INTEL_TLV_PCIE_SUBSYSTEM_ID,
+	INTEL_TLV_IMAGE_TYPE,
+	INTEL_TLV_TIME_STAMP,
+	INTEL_TLV_BUILD_TYPE,
+	INTEL_TLV_BUILD_NUM,
+	INTEL_TLV_FW_BUILD_PRODUCT,
+	INTEL_TLV_FW_BUILD_HW,
+	INTEL_TLV_FW_STEP,
+	INTEL_TLV_BT_SPEC,
+	INTEL_TLV_MFG_NAME,
+	INTEL_TLV_HCI_REV,
+	INTEL_TLV_LMP_SUBVER,
+	INTEL_TLV_OTP_PATCH_VER,
+	INTEL_TLV_SECURE_BOOT,
+	INTEL_TLV_KEY_FROM_HDR,
+	INTEL_TLV_OTP_LOCK,
+	INTEL_TLV_API_LOCK,
+	INTEL_TLV_DEBUG_LOCK,
+	INTEL_TLV_MIN_FW,
+	INTEL_TLV_LIMITED_CCE,
+	INTEL_TLV_SBE_TYPE,
+	INTEL_TLV_OTP_BDADDR,
+	INTEL_TLV_UNLOCKED_STATE
+};
+
+struct intel_tlv {
+	u8 type;
+	u8 len;
+	u8 val[0];
+} __packed;
+
+struct intel_version_tlv {
+	u32	cnvi_top;
+	u32	cnvr_top;
+	u32	cnvi_bt;
+	u32	cnvr_bt;
+	u16	dev_rev_id;
+	u8	img_type;
+	u16	timestamp;
+	u8	build_type;
+	u32	build_num;
+	u8	secure_boot;
+	u8	otp_lock;
+	u8	api_lock;
+	u8	debug_lock;
+	u8	min_fw_build_nn;
+	u8	min_fw_build_cw;
+	u8	min_fw_build_yy;
+	u8	limited_cce;
+	u8	sbe_type;
+	bdaddr_t otp_bd_addr;
+};
+
 struct intel_version {
 	u8 status;
 	u8 hw_platform;
@@ -77,12 +143,14 @@ int btintel_set_diag_mfg(struct hci_dev *hdev, bool enable);
 void btintel_hw_error(struct hci_dev *hdev, u8 code);
 
 void btintel_version_info(struct hci_dev *hdev, struct intel_version *ver);
+void btintel_version_info_tlv(struct hci_dev *hdev, struct intel_version_tlv *version);
 int btintel_secure_send(struct hci_dev *hdev, u8 fragment_type, u32 plen,
 			const void *param);
 int btintel_load_ddc_config(struct hci_dev *hdev, const char *ddc_name);
 int btintel_set_event_mask(struct hci_dev *hdev, bool debug);
 int btintel_set_event_mask_mfg(struct hci_dev *hdev, bool debug);
 int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver);
+int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *ver);
 
 struct regmap *btintel_regmap_init(struct hci_dev *hdev, u16 opcode_read,
 				   u16 opcode_write);
@@ -137,6 +205,11 @@ static inline void btintel_version_info(struct hci_dev *hdev,
 {
 }
 
+static inline void btintel_version_info_tlv(struct hci_dev *hdev,
+					    struct intel_version_tlv *version)
+{
+}
+
 static inline int btintel_secure_send(struct hci_dev *hdev, u8 fragment_type,
 				      u32 plen, const void *param)
 {
@@ -165,6 +238,12 @@ static inline int btintel_read_version(struct hci_dev *hdev,
 	return -EOPNOTSUPP;
 }
 
+static inline int btintel_read_version_tlv(struct hci_dev *hdev,
+					   struct intel_version_tlv *ver)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline struct regmap *btintel_regmap_init(struct hci_dev *hdev,
 						 u16 opcode_read,
 						 u16 opcode_write)
-- 
2.7.4

