Return-Path: <SRS0=OtJ6=EM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D138AC388F2
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Nov 2020 09:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76633208B3
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Nov 2020 09:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgKFJPH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Nov 2020 04:15:07 -0500
Received: from mga05.intel.com ([192.55.52.43]:30919 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbgKFJPG (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Nov 2020 04:15:06 -0500
IronPort-SDR: 2cr2blRLUmDeCd42lAo4tn++BCr3bNw1p3UmI+I4lsOXFJtDQxSDG4fh+eSQTd9RgdaDh59NnI
 f3jTSRYMP65Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="254228474"
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="254228474"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 01:15:05 -0800
IronPort-SDR: 27+GbXJIz6cQOylf48CDCtqQ37u34hlezwpHTdJBHHcdOCy2DkCUxxTSMqPmmRN+r3p2dn6L4b
 rdf9kxIfGpqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="353309373"
Received: from nsathish-latitude-7480.iind.intel.com ([10.224.186.105])
  by orsmga008.jf.intel.com with ESMTP; 06 Nov 2020 01:15:03 -0800
From:   Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chethan.tumkur.narayan@intel.com, ravishankar.srivatsa@intel.com,
        Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH] Bluetooth: btintel parse TLV structure
Date:   Fri,  6 Nov 2020 14:50:24 +0530
Message-Id: <20201106092024.20430-1-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Latest intel firmware supports TLV structure in operational mode for intel
read version. so made changes accordingly to support both bootloader
and operational mode . These changes are only to specific intel bluetooth
controller for example ThP, CcP.

Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
---
 drivers/bluetooth/btintel.c | 105 +++++++++++++++++++++++++++---------
 drivers/bluetooth/btintel.h |  16 ++++++
 drivers/bluetooth/btusb.c   |  41 ++++++++++----
 3 files changed, 129 insertions(+), 33 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 88ce5f0ffc4b..67267afc83e1 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -401,31 +401,9 @@ void btintel_version_info_tlv(struct hci_dev *hdev, struct intel_version_tlv *ve
 }
 EXPORT_SYMBOL_GPL(btintel_version_info_tlv);
 
-int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *version)
+static void btintel_parse_tlv(struct sk_buff *skb,
+			      struct intel_version_tlv *version)
 {
-	struct sk_buff *skb;
-	const u8 param[1] = { 0xFF };
-
-	if (!version)
-		return -EINVAL;
-
-	skb = __hci_cmd_sync(hdev, 0xfc05, 1, param, HCI_CMD_TIMEOUT);
-	if (IS_ERR(skb)) {
-		bt_dev_err(hdev, "Reading Intel version information failed (%ld)",
-			   PTR_ERR(skb));
-		return PTR_ERR(skb);
-	}
-
-	if (skb->data[0]) {
-		bt_dev_err(hdev, "Intel Read Version command failed (%02x)",
-			   skb->data[0]);
-		kfree_skb(skb);
-		return -EIO;
-	}
-
-	/* Consume Command Complete Status field */
-	skb_pull(skb, 1);
-
 	/* Event parameters contatin multiple TLVs. Read each of them
 	 * and only keep the required data. Also, it use existing legacy
 	 * version field like hw_platform, hw_variant, and fw_variant
@@ -496,6 +474,85 @@ int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *ver
 		/* consume the current tlv and move to next*/
 		skb_pull(skb, tlv->len + sizeof(*tlv));
 	}
+}
+
+int btintel_read_version_new(struct hci_dev *hdev, struct btintel_version *ver)
+{
+	struct sk_buff *skb;
+	struct intel_version *version = &ver->ver;
+	const u8 param[1] = { 0xFF };
+
+	skb = __hci_cmd_sync(hdev, 0xfc05, 1, param, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Reading Intel version info failed (%ld)",
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
+	/* The new Intel read version is backward compatible for Thp and CcP
+	 * type cards. when the controller is in bootloader mode the controller
+	 * response remains same as old intel_read version. For ThP/CcP cards
+	 * TLV structure supports only during the Operation Mode. The best way
+	 * to differentiate the read_version response is to check the length
+	 * parameter and the first byte of the payload, which is a fixed value.
+	 * After the status parameter if the payload starts with 0x37(This is
+	 * a fixed value) and length of the payload is 10 then it is identified
+	 * as legacy struct intel_version. In the latest firmware the support
+	 * of TLV structure is added during Operational Firmware.
+	 */
+	if (skb->len == sizeof(*version) && skb->data[1] == 0x37) {
+		memcpy(version, skb->data, sizeof(*version));
+		ver->tlv_format = false;
+		goto finish;
+	}
+
+	/* Consume Command Complete Status field */
+	skb_pull(skb, 1);
+
+	ver->tlv_format = true;
+
+	bt_dev_info(hdev, "Parsing TLV Supported intel read version");
+	btintel_parse_tlv(skb, &ver->ver_tlv);
+
+finish:
+	kfree_skb(skb);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btintel_read_version_new);
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
+	btintel_parse_tlv(skb, version);
 
 	kfree_skb(skb);
 	return 0;
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 09346ae308eb..952da44b79de 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -132,6 +132,15 @@ struct intel_debug_features {
 	__u8    page1[16];
 } __packed;
 
+struct btintel_version {
+	bool tlv_format;
+	union {
+		struct intel_version ver; /*Legacy Intel read version*/
+		struct intel_version_tlv ver_tlv;
+	};
+} __packed;
+
+#define INTEL_HW_VARIANT(cnvx_bt)	((u8)(((cnvx_bt) & 0x003f0000) >> 16))
 #if IS_ENABLED(CONFIG_BT_INTEL)
 
 int btintel_check_bdaddr(struct hci_dev *hdev);
@@ -151,6 +160,7 @@ int btintel_set_event_mask(struct hci_dev *hdev, bool debug);
 int btintel_set_event_mask_mfg(struct hci_dev *hdev, bool debug);
 int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver);
 int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *ver);
+int btintel_read_version_new(struct hci_dev *hdev, struct btintel_version *ver);
 
 struct regmap *btintel_regmap_init(struct hci_dev *hdev, u16 opcode_read,
 				   u16 opcode_write);
@@ -248,6 +258,12 @@ static inline int btintel_read_version_tlv(struct hci_dev *hdev,
 	return -EOPNOTSUPP;
 }
 
+static inline int btintel_read_version_new(struct hci_dev *hdev,
+					   struct btintel_version *ver)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline struct regmap *btintel_regmap_init(struct hci_dev *hdev,
 						 u16 opcode_read,
 						 u16 opcode_write)
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1005b6e8ff74..c63bc8a0c84f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2554,7 +2554,8 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 static int btusb_setup_intel_new(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
-	struct intel_version ver;
+	struct btintel_version bt_ver;
+	u8 hw_variant;
 	struct intel_boot_params params;
 	u32 boot_param;
 	char ddcname[64];
@@ -2577,19 +2578,33 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	 * is in bootloader mode or if it already has operational firmware
 	 * loaded.
 	 */
-	err = btintel_read_version(hdev, &ver);
+	err = btintel_read_version_new(hdev, &bt_ver);
 	if (err) {
 		bt_dev_err(hdev, "Intel Read version failed (%d)", err);
 		btintel_reset_to_bootloader(hdev);
 		return err;
 	}
 
-	err = btusb_intel_download_firmware(hdev, &ver, &params, &boot_param);
+	/* If TLV format is supported then it is in Operational Firmware. TLV
+	 * structure is supported only in operational mode in latest Firmware.
+	 */
+	if (bt_ver.tlv_format && bt_ver.ver_tlv.img_type == 0x03) {
+		btintel_version_info_tlv(hdev, &bt_ver.ver_tlv);
+		clear_bit(BTUSB_BOOTLOADER, &data->flags);
+		goto finish;
+	}
+
+	err = btusb_intel_download_firmware(hdev, &bt_ver.ver,  &params,
+					    &boot_param);
 	if (err)
 		return err;
 
-	/* controller is already having an operational firmware */
-	if (ver.fw_variant == 0x23)
+	/* In case if old firmware is used, it should be backward compatible
+	 * to check for operational firmware. only on latest firmware the
+	 * support for TLV structure is added. so check for tlv is not
+	 * required here.
+	 */
+	if (bt_ver.ver.fw_variant == 0x23)
 		goto finish;
 
 	rettime = ktime_get();
@@ -2641,7 +2656,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 
 	clear_bit(BTUSB_BOOTLOADER, &data->flags);
 
-	err = btusb_setup_intel_new_get_fw_name(&ver, &params, ddcname,
+	err = btusb_setup_intel_new_get_fw_name(&bt_ver.ver, &params, ddcname,
 						sizeof(ddcname), "ddc");
 
 	if (!err) {
@@ -2665,17 +2680,25 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	btintel_set_debug_features(hdev, &features);
 
 	/* Read the Intel version information after loading the FW  */
-	err = btintel_read_version(hdev, &ver);
+	err = btintel_read_version_new(hdev, &bt_ver);
 	if (err)
 		return err;
 
-	btintel_version_info(hdev, &ver);
+	if (bt_ver.tlv_format)
+		btintel_version_info_tlv(hdev, &bt_ver.ver_tlv);
+	else
+		btintel_version_info(hdev, &bt_ver.ver);
 
 finish:
 	/* All Intel controllers that support the Microsoft vendor
 	 * extension are using 0xFC1E for VsMsftOpCode.
 	 */
-	switch (ver.hw_variant) {
+	if (!bt_ver.tlv_format)
+		hw_variant = bt_ver.ver.hw_variant;
+	else
+		hw_variant = INTEL_HW_VARIANT(bt_ver.ver_tlv.cnvi_bt);
+
+	switch (hw_variant) {
 	case 0x12:	/* ThP */
 		hci_set_msft_opcode(hdev, 0xFC1E);
 		break;
-- 
2.17.1

