Return-Path: <SRS0=bfEF=6B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BF3C3815B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Apr 2020 09:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09A2E221EA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Apr 2020 09:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgDQJtl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Apr 2020 05:49:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:42811 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbgDQJtl (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Apr 2020 05:49:41 -0400
IronPort-SDR: g62q211aAWI9tvZDWetFhEJrtDsrIO7E+zqsryE9vP2gpC6TgEhwI5s/aMsYZSrQPK+p8kBH2I
 5fOkD60xO7gg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 02:49:37 -0700
IronPort-SDR: V1H+kfeXV9Ny8YECPVF9c+/xlBh7cCdk6gxMqge2F0T/Hj0/KEBm8UNVt0vv3m6eMQoPHufD6g
 4yn2c4Uq60Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,394,1580803200"; 
   d="scan'208";a="242961379"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by orsmga007.jf.intel.com with ESMTP; 17 Apr 2020 02:49:33 -0700
From:   Amit K Bag <amit.k.bag@intel.com>
List-Id: <linux-firmware.lore.kernel.org>
To:     linux-firmware@kernel.org
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        chethan.tumkur.narayan@intel.com,
        "Hegde, Raghuram" <raghuram.hegde@intel.com>,
        Amit K Bag <amit.k.bag@intel.com>
Subject: [PATCH 2/2] Bluetooth: btusb: Add support for TLV read version format and multiple Secure Boot Engines
Date:   Fri, 17 Apr 2020 15:20:12 +0530
Message-Id: <20200417095012.8443-2-amit.k.bag@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200417095012.8443-1-amit.k.bag@intel.com>
References: <20200417095012.8443-1-amit.k.bag@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: "Hegde, Raghuram" <raghuram.hegde@intel.com>

Two FW download flows are implemented.
1. For controllers responding to Intel Read Version in Legacy response format
2. For controllers responding to Intel Read Version in TLV response format

Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
---
 drivers/bluetooth/Makefile    |   2 +-
 drivers/bluetooth/btintel.c   | 352 +++++++++++++++++++++--
 drivers/bluetooth/btintel.h   | 185 +++++++++++-
 drivers/bluetooth/btusb.c     | 524 ++++++++++++++++++++++++----------
 drivers/bluetooth/hci_intel.c |   6 +-
 5 files changed, 887 insertions(+), 182 deletions(-)

diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index 1a58a3ae142c..070b22e5ce17 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -43,6 +43,6 @@ hci_uart-$(CONFIG_BT_HCIUART_3WIRE)	+= hci_h5.o
 hci_uart-$(CONFIG_BT_HCIUART_INTEL)	+= hci_intel.o
 hci_uart-$(CONFIG_BT_HCIUART_BCM)	+= hci_bcm.o
 hci_uart-$(CONFIG_BT_HCIUART_QCA)	+= hci_qca.o
-hci_uart-$(CONFIG_BT_HCIUART_AG6XX)	+= hci_ag6xx.o
+#hci_uart-$(CONFIG_BT_HCIUART_AG6XX)	+= hci_ag6xx.o
 hci_uart-$(CONFIG_BT_HCIUART_MRVL)	+= hci_mrvl.o
 hci_uart-objs				:= $(hci_uart-y)
diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 6a0e2c5a8beb..efe66483d057 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -204,7 +204,8 @@ void btintel_hw_error(struct hci_dev *hdev, u8 code)
 }
 EXPORT_SYMBOL_GPL(btintel_hw_error);
 
-void btintel_version_info(struct hci_dev *hdev, struct intel_version *ver)
+void btintel_legacy_version_info(struct hci_dev *hdev,
+				 struct legacy_intel_version *ver)
 {
 	const char *variant;
 
@@ -224,7 +225,53 @@ void btintel_version_info(struct hci_dev *hdev, struct intel_version *ver)
 		    ver->fw_build_num, ver->fw_build_ww,
 		    2000 + ver->fw_build_yy);
 }
-EXPORT_SYMBOL_GPL(btintel_version_info);
+EXPORT_SYMBOL_GPL(btintel_legacy_version_info);
+
+void btintel_tlv_version_info(struct hci_dev *hdev,
+			struct tlv_intel_version *ver)
+{
+	const char *variant;
+
+	switch (ver->img_type) {
+	case 0x01:
+		variant = "Bootloader";
+		break;
+	case 0x03:
+		variant = "Firmware";
+		break;
+	default:
+		return;
+	}
+
+	bt_dev_info(hdev, "%s timestamp %u.%u buildtype %u build %u",
+		    variant, 2000 + (ver->timestamp >> 8),
+		    ver->timestamp & 0xff, ver->build_type, ver->build_num);
+}
+EXPORT_SYMBOL_GPL(btintel_tlv_version_info);
+
+void btintel_tlv_boot_info(struct hci_dev *hdev,
+			   struct tlv_intel_version *ver)
+{
+	bt_dev_info(hdev, "Device revision is %u",
+		    ver->dev_rev_id);
+
+	bt_dev_info(hdev, "Secure boot is %s",
+		    ver->secure_boot ? "enabled" : "disabled");
+
+	bt_dev_info(hdev, "OTP lock is %s",
+		    ver->otp_lock ? "enabled" : "disabled");
+
+	bt_dev_info(hdev, "API lock is %s",
+		    ver->api_lock ? "enabled" : "disabled");
+
+	bt_dev_info(hdev, "Debug lock is %s",
+		    ver->debug_lock ? "enabled" : "disabled");
+
+	bt_dev_info(hdev, "Minimum firmware build %u week %u %u",
+		    ver->min_fw_build_nn, ver->min_fw_build_cw,
+		    2000 + ver->min_fw_build_yy);
+}
+EXPORT_SYMBOL_GPL(btintel_tlv_boot_info);
 
 int btintel_secure_send(struct hci_dev *hdev, u8 fragment_type, u32 plen,
 			const void *param)
@@ -335,11 +382,88 @@ int btintel_set_event_mask_mfg(struct hci_dev *hdev, bool debug)
 }
 EXPORT_SYMBOL_GPL(btintel_set_event_mask_mfg);
 
-int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver)
+bool btintel_legacy_get_fw_name(struct legacy_intel_version *ver,
+				struct intel_boot_params *params,
+				char *fw_name, size_t len,
+				const char *suffix)
+{
+	/* This is for legacy HCI_Intel_Read_Version command.
+	 *
+	 * With this Intel bootloader only the hardware variant and device
+	 * revision information are used to select the right firmware for SfP
+	 * and WsP.
+	 *
+	 * The firmware filename is ibt-<hw_variant>-<dev_revid>.sfi.
+	 *
+	 * Currently the supported hardware variants are:
+	 *   11 (0x0b) for iBT3.0 (LnP/SfP)
+	 *   12 (0x0c) for iBT3.5 (WsP)
+	 *
+	 * For ThP/JfP and for future SKU's, the FW name varies based on HW
+	 * variant, HW revision and FW revision, as these are dependent on CNVi
+	 * and RF Combination.
+	 *
+	 *   17 (0x11) for iBT3.5 (JfP)
+	 *   18 (0x12) for iBT3.5 (ThP)
+	 *
+	 * The firmware file name for these will be
+	 * ibt-<hw_variant>-<hw_revision>-<fw_revision>.sfi.
+	 *
+	 */
+
+	switch (ver->hw_variant) {
+	case 0x0b:	/* SfP */
+	case 0x0c:	/* WsP */
+		snprintf(fw_name, len, "intel/ibt-%u-%u.%s",
+			le16_to_cpu(ver->hw_variant),
+			le16_to_cpu(params->dev_revid),
+			suffix);
+		break;
+	case 0x11:	/* JfP */
+	case 0x12:	/* ThP */
+	case 0x13:	/* HrP */
+	case 0x14:	/* CcP */
+		snprintf(fw_name, len, "intel/ibt-%u-%u-%u.%s",
+			le16_to_cpu(ver->hw_variant),
+			le16_to_cpu(ver->hw_revision),
+			le16_to_cpu(ver->fw_revision),
+			suffix);
+		break;
+	default:
+		return false;
+	}
+	return true;
+}
+EXPORT_SYMBOL_GPL(btintel_legacy_get_fw_name);
+
+void btintel_tlv_get_fw_name(struct tlv_intel_version *ver,
+				char *fw_name, size_t len,
+				const char *suffix)
+{
+	/* This is for legacy HCI_Intel_Read_Version command.
+	 * The firmware file name for these will be
+	 * ibt-<cnvi_top type+cnvi_top step>-<cnvr_top type+cnvr_top step>
+	 *
+	 * Currently the supported hardware variants are:
+	 * iBT4.2 23 (0x17) for TyP
+	 * iBT4.2 24 (0x18) for Solar
+	 */
+	snprintf(fw_name, len, "intel/ibt-%04x-%04x.%s",
+		INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver->cnvi_top),
+		INTEL_CNVX_TOP_STEP(ver->cnvi_top)),
+		INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver->cnvr_top),
+		INTEL_CNVX_TOP_STEP(ver->cnvr_top)),
+		suffix);
+}
+EXPORT_SYMBOL_GPL(btintel_tlv_get_fw_name);
+
+int btintel_read_version(struct hci_dev *hdev,
+			 struct legacy_intel_version *ver)
 {
 	struct sk_buff *skb;
 
-	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_CMD_TIMEOUT);
+	skb = __hci_cmd_sync(hdev, INTEL_READ_VERSION_CMD, 0, NULL,
+			     HCI_CMD_TIMEOUT);
 	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Reading Intel version information failed (%ld)",
 			   PTR_ERR(skb));
@@ -360,6 +484,54 @@ int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver)
 }
 EXPORT_SYMBOL_GPL(btintel_read_version);
 
+int btintel_new_read_version(struct hci_dev *hdev, bool *is_tlv_format,
+		struct sk_buff **skb)
+{
+	u8 param;
+	u8 status;
+	u8 tlv_check_octet;
+
+	param = 0xFF;
+
+	*skb = __hci_cmd_sync(hdev, INTEL_READ_VERSION_CMD, 1, &param,
+			      HCI_CMD_TIMEOUT);
+	if (IS_ERR(*skb)) {
+		bt_dev_err(hdev, "Reading Intel version failed (%ld)",
+			   PTR_ERR(*skb));
+		return PTR_ERR(*skb);
+	}
+
+	/* Check status */
+	status = *((u8 *)((*skb)->data));
+	if (status) {
+		bt_dev_err(hdev, "Intel Read Version command failed (%02x)",
+			   status);
+		kfree_skb(*skb);
+		return -bt_to_errno(status);
+	}
+
+	/* There are two variants of HCI_Intel_Read_Version_Command_Complete
+	 * depending on SKU type (legacy and TLV format).If the skb->len
+	 * parameter is equal to LEGACY_INTEL_VERSION_LEN  AND the first octet
+	 * after the status parameter is either equal to 0x37 or less than
+	 * 0x10, then it's the legacy format, otherwise it's the TLV format
+	 */
+
+	/* Fetch the octet after status */
+	tlv_check_octet = *(((u8 *)((*skb)->data)) + 1);
+
+	if ((*skb)->len == LEGACY_INTEL_VERSION_LEN &&
+		tlv_check_octet == INTEL_PLATFORM) {
+		bt_dev_dbg(hdev, "Using Legacy Intel Version command");
+		*is_tlv_format = false;
+	} else {
+		bt_dev_dbg(hdev, "Using TLV format Version command");
+		*is_tlv_format = true;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btintel_new_read_version);
+
 /* ------- REGMAP IBT SUPPORT ------- */
 
 #define IBT_REG_MODE_8BIT  0x00
@@ -626,12 +798,10 @@ int btintel_read_boot_params(struct hci_dev *hdev,
 }
 EXPORT_SYMBOL_GPL(btintel_read_boot_params);
 
-int btintel_download_firmware(struct hci_dev *hdev, const struct firmware *fw,
-			      u32 *boot_param)
+static int btintel_sfi_rsa_header_secure_send(struct hci_dev *hdev,
+					      const struct firmware *fw)
 {
 	int err;
-	const u8 *fw_ptr;
-	u32 frag_len;
 
 	/* Start the firmware download transaction with the Init fragment
 	 * represented by the 128 bytes of CSS header.
@@ -639,7 +809,7 @@ int btintel_download_firmware(struct hci_dev *hdev, const struct firmware *fw,
 	err = btintel_secure_send(hdev, 0x00, 128, fw->data);
 	if (err < 0) {
 		bt_dev_err(hdev, "Failed to send firmware header (%d)", err);
-		goto done;
+		return err;
 	}
 
 	/* Send the 256 bytes of public key information from the firmware
@@ -648,7 +818,7 @@ int btintel_download_firmware(struct hci_dev *hdev, const struct firmware *fw,
 	err = btintel_secure_send(hdev, 0x03, 256, fw->data + 128);
 	if (err < 0) {
 		bt_dev_err(hdev, "Failed to send firmware pkey (%d)", err);
-		goto done;
+		return err;
 	}
 
 	/* Send the 256 bytes of signature information from the firmware
@@ -657,15 +827,60 @@ int btintel_download_firmware(struct hci_dev *hdev, const struct firmware *fw,
 	err = btintel_secure_send(hdev, 0x02, 256, fw->data + 388);
 	if (err < 0) {
 		bt_dev_err(hdev, "Failed to send firmware signature (%d)", err);
-		goto done;
+		return err;
+	}
+	return 0;
+}
+
+static int btintel_sfi_ecdsa_header_secure_send(struct hci_dev *hdev,
+						const struct firmware *fw)
+{
+	int err;
+
+	/* Start the firmware download transaction with the Init fragment
+	 * represented by the 128 bytes of CSS header.
+	 */
+	err = btintel_secure_send(hdev, 0x00, 128, fw->data + 644);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to send firmware header (%d)", err);
+		return err;
+	}
+
+	/* Send the 96 bytes of public key information from the firmware
+	 * as the PKey fragment.
+	 */
+	err = btintel_secure_send(hdev, 0x03, 96, fw->data + 644 + 128);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to send firmware pkey (%d)", err);
+		return err;
 	}
 
-	fw_ptr = fw->data + 644;
+	/* Send the 96 bytes of signature information from the firmware
+	 * as the Sign fragment
+	 */
+	err = btintel_secure_send(hdev, 0x02, 96, fw->data + 644 + 224);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to send firmware signature (%d)",
+				err);
+		return err;
+	}
+	return 0;
+}
+
+static int btintel_download_firmware(struct hci_dev *hdev,
+				     const struct firmware *fw,
+				     size_t offset,
+				     u32 *boot_param)
+{
+	const u8 *fw_ptr;
+	u32 frag_len;
+	int err;
+
+	fw_ptr = fw->data + offset;
 	frag_len = 0;
 
 	while (fw_ptr - fw->data < fw->size) {
 		struct hci_command_hdr *cmd = (void *)(fw_ptr + frag_len);
-
 		/* Each SKU has a different reset parameter to use in the
 		 * HCI_Intel_Reset command and it is embedded in the firmware
 		 * data. So, instead of using static value per SKU, check
@@ -675,13 +890,12 @@ int btintel_download_firmware(struct hci_dev *hdev, const struct firmware *fw,
 			/* The boot parameter is the first 32-bit value
 			 * and rest of 3 octets are reserved.
 			 */
-			*boot_param = get_unaligned_le32(fw_ptr + sizeof(*cmd));
-
+			*boot_param = get_unaligned_le32(fw_ptr + frag_len
+							 + sizeof(*cmd));
 			bt_dev_dbg(hdev, "boot_param=0x%x", *boot_param);
 		}
 
 		frag_len += sizeof(*cmd) + cmd->plen;
-
 		/* The parameter length of the secure send command requires
 		 * a 4 byte alignment. It happens so that the firmware file
 		 * contains proper Intel_NOP commands to align the fragments
@@ -696,18 +910,116 @@ int btintel_download_firmware(struct hci_dev *hdev, const struct firmware *fw,
 				bt_dev_err(hdev,
 					   "Failed to send firmware data (%d)",
 					   err);
-				goto done;
+				return err;
 			}
 
 			fw_ptr += frag_len;
 			frag_len = 0;
 		}
 	}
+	return 0;
+}
 
-done:
-	return err;
+int btintel_legacy_download_firmware(struct hci_dev *hdev,
+				const struct firmware *fw,
+				u32 *boot_param)
+{
+	int err;
+
+	err = btintel_sfi_rsa_header_secure_send(hdev, fw);
+	if (err)
+		return err;
+
+	err = btintel_download_firmware(hdev, fw, RSA_HEADER_LEN, boot_param);
+	if (err)
+		return err;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btintel_legacy_download_firmware);
+
+int btintel_tlv_download_firmware(struct hci_dev *hdev,
+			const struct firmware *fw, u32 *boot_param,
+			u8 hw_variant, u8 sbe_type)
+{
+	int err;
+	u32 css_header_ver;
+
+	/* iBT hardware variants 0x0b, 0x0c, 0x11, 0x12, 0x13, 0x14 support
+	 * only RSA secure boot engine. Hence, the corresponding sfi file will
+	 * have RSA header of 644 bytes followed by Command Buffer.
+	 *
+	 * iBT hardware variants 0x17, 0x18 onwards support both RSA and ECDSA
+	 * secure boot engine. As a result, the corresponding sfi file will
+	 * have RSA header of 644, ECDSA header of 320 bytes followed by
+	 * Command Buffer.
+	 *
+	 * CSS Header byte positions 0x08 to 0x0B represent the CSS Header
+	 * version: RSA(0x00010000) , ECDSA (0x00020000)
+	 */
+	css_header_ver = (fw->data[CSS_HEADER_OFFSET + 3] << 24) |
+			(fw->data[CSS_HEADER_OFFSET + 2] << 16) |
+			(fw->data[CSS_HEADER_OFFSET + 1] << 8) |
+			fw->data[CSS_HEADER_OFFSET];
+	if (css_header_ver != 0x00010000) {
+		bt_dev_err(hdev, "Invalid CSS Header version");
+		return -EINVAL;
+	}
+
+	if (hw_variant <= 0x14) {
+		if (sbe_type != 0x00) {
+			bt_dev_err(hdev, "Invalid SBE type for hardware variant (%d)",
+					hw_variant);
+			return -EINVAL;
+		}
+
+		err = btintel_sfi_rsa_header_secure_send(hdev, fw);
+		if (err)
+			return err;
+
+		err = btintel_download_firmware(hdev, fw, RSA_HEADER_LEN,
+						boot_param);
+		if (err)
+			return err;
+	} else if (hw_variant == 0x17 || hw_variant == 0x18) {
+		/* Check if CSS header for ECDSA follows the RSA header */
+		if (fw->data[ECDSA_OFFSET] != 0x06)
+			return -EINVAL;
+
+		/* Check if the CSS Header version is ECDSA(0x00020000) */
+		css_header_ver = (fw->data[ECDSA_OFFSET + CSS_HEADER_OFFSET + 3] << 24) |
+				(fw->data[ECDSA_OFFSET + CSS_HEADER_OFFSET + 2] << 16) |
+				(fw->data[ECDSA_OFFSET + CSS_HEADER_OFFSET + 1] << 8) |
+				fw->data[ECDSA_OFFSET + CSS_HEADER_OFFSET];
+		if (css_header_ver != 0x00020000) {
+			bt_dev_err(hdev, "Invalid CSS Header version");
+			return -EINVAL;
+		}
+
+		if (sbe_type == 0x00) {
+			err = btintel_sfi_rsa_header_secure_send(hdev, fw);
+			if (err)
+				return err;
+
+			err = btintel_download_firmware(hdev, fw,
+					RSA_HEADER_LEN + ECDSA_HEADER_LEN,
+					boot_param);
+			if (err)
+				return err;
+		} else if (sbe_type == 0x01) {
+			err = btintel_sfi_ecdsa_header_secure_send(hdev, fw);
+			if (err)
+				return err;
+
+			err = btintel_download_firmware(hdev, fw,
+					RSA_HEADER_LEN + ECDSA_HEADER_LEN,
+					boot_param);
+			if (err)
+				return err;
+		}
+	}
+	return 0;
 }
-EXPORT_SYMBOL_GPL(btintel_download_firmware);
+EXPORT_SYMBOL_GPL(btintel_tlv_download_firmware);
 
 void btintel_reset_to_bootloader(struct hci_dev *hdev)
 {
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index a69ea8a87b9b..07e8fc44857d 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -6,7 +6,53 @@
  *  Copyright (C) 2015  Intel Corporation
  */
 
-struct intel_version {
+/* List of tlv type */
+enum {
+	INTEL_VER_TLV_CNVI_TOP = 0x10,
+	INTEL_VER_TLV_CNVR_TOP,
+	INTEL_VER_TLV_CNVI_BT,
+	INTEL_VER_TLV_CNVR_BT,
+	INTEL_VER_TLV_CNVI_OTP,
+	INTEL_VER_TLV_CNVR_OTP,
+	INTEL_VER_TLV_DEV_REV_ID,
+	INTEL_VER_TLV_USB_VENDOR_ID,
+	INTEL_VER_TLV_USB_PRODUCT_ID,
+	INTEL_VER_TLV_PCIE_VENDOR_ID,
+	INTEL_VER_TLV_PCIE_DEVICE_ID,
+	INTEL_VER_TLV_PCIE_SUBSYSTEM_ID,
+	INTEL_VER_TLV_IMAGE_TYPE,
+	INTEL_VER_TLV_TIME_STAMP,
+	INTEL_VER_TLV_BUILD_TYPE,
+	INTEL_VER_TLV_BUILD_NUM,
+	INTEL_VER_TLV_FW_BUILD_PRODUCT,
+	INTEL_VER_TLV_FW_BUILD_HW,
+	INTEL_VER_TLV_FW_STEP,
+	INTEL_VER_TLV_BT_SPEC,
+	INTEL_VER_TLV_MFG_NAME,
+	INTEL_VER_TLV_HCI_REV,
+	INTEL_VER_TLV_LMP_SUBVER,
+	INTEL_VER_TLV_OTP_PATCH_VER,
+	INTEL_VER_TLV_SECURE_BOOT,
+	INTEL_VER_TLV_KEY_FROM_HDR,
+	INTEL_VER_TLV_OTP_LOCK,
+	INTEL_VER_TLV_API_LOCK,
+	INTEL_VER_TLV_DEBUG_LOCK,
+	INTEL_VER_TLV_MIN_FW,
+	INTEL_VER_TLV_LIMITED_CCE,
+	INTEL_VER_TLV_SBE_TYPE,
+	INTEL_VER_TLV_OTP_BDADDR,
+	INTEL_VER_TLV_UNLOCKED_STATE
+};
+
+struct intel_tlv {
+	u8 type;
+	u8 len;
+	u8 val[0];
+} __packed;
+
+/* Length of legacy HCI_Intel_Read_Version structure*/
+#define LEGACY_INTEL_VERSION_LEN	10
+struct legacy_intel_version {
 	u8 status;
 	u8 hw_platform;
 	u8 hw_variant;
@@ -19,6 +65,46 @@ struct intel_version {
 	u8 fw_patch_num;
 } __packed;
 
+struct tlv_intel_version {
+	u8	 status;
+	u32	 cnvi_top;
+	u32	 cnvr_top;
+	u32	 cnvi_bt;
+	u32	 cnvr_bt;
+	u16	 cnvi_otp;
+	u16	 cnvr_otp;
+	u16	 dev_rev_id;
+	u16	 usb_vid;
+	u16	 usb_pid;
+	u16	 pcie_vendor_id;
+	u16	 pcie_dev_id;
+	u16	 pcie_subsys_id;
+	u8	 img_type;
+	u16	 timestamp;
+	u8	 build_type;
+	u32	 build_num;
+	u8	 fw_build_prod;
+	u8	 fw_build_hw;
+	u8	 fw_build_step;
+	u8	 bt_spec_ver;
+	u16	 mfg_name;
+	u16	 hci_rev;
+	u16	 lmp_sub_ver;
+	u8	 otp_patch_ver;
+	u8	 secure_boot;
+	u8	 key_from_hdr;
+	u8	 otp_lock;
+	u8	 api_lock;
+	u8	 debug_lock;
+	u8	 min_fw_build_nn;
+	u8	 min_fw_build_cw;
+	u8	 min_fw_build_yy;
+	u8	 limited_cce;
+	u8	 sbe_type;
+	bdaddr_t otp_bd_addr;
+	u8	 unlocked_state;
+} __packed;
+
 struct intel_boot_params {
 	__u8     status;
 	__u8     otp_format;
@@ -62,6 +148,29 @@ struct intel_reset {
 	__le32   boot_param;
 } __packed;
 
+#define INTEL_READ_VERSION_CMD		 0xfc05
+
+#define INTEL_PLATFORM			 0x37
+#define INTEL_HW_PLATFORM_MASK           0x0000ff00
+#define INTEL_HW_VARIANT_MASK            0x003f0000
+#define INTEL_CNVX_TOP_TYPE_MASK         0x00000fff
+#define INTEL_CNVX_TOP_STEP_MASK         0x0f000000
+
+#define INTEL_HW_PLATFORM(cnvx_bt) ((u8)((cnvx_bt & INTEL_HW_PLATFORM_MASK)  >> 8))
+
+#define INTEL_HW_VARIANT(cnvx_bt)  ((u8)((cnvx_bt & INTEL_HW_VARIANT_MASK)   >> 16))
+
+#define INTEL_CNVX_TOP_TYPE(cnvx_top)  (cnvx_top & INTEL_CNVX_TOP_TYPE_MASK)
+
+#define INTEL_CNVX_TOP_STEP(cnvx_top)  ((cnvx_top & INTEL_CNVX_TOP_STEP_MASK) >> 24)
+
+#define INTEL_CNVX_TOP_PACK_SWAB(t, s)	__swab16(((__u16)((t << 4) | s)))
+
+#define CSS_HEADER_OFFSET	8
+#define RSA_HEADER_LEN		644
+#define ECDSA_HEADER_LEN	320
+#define ECDSA_OFFSET		RSA_HEADER_LEN
+
 #if IS_ENABLED(CONFIG_BT_INTEL)
 
 int btintel_check_bdaddr(struct hci_dev *hdev);
@@ -72,21 +181,40 @@ int btintel_set_diag(struct hci_dev *hdev, bool enable);
 int btintel_set_diag_mfg(struct hci_dev *hdev, bool enable);
 void btintel_hw_error(struct hci_dev *hdev, u8 code);
 
-void btintel_version_info(struct hci_dev *hdev, struct intel_version *ver);
+void btintel_legacy_version_info(struct hci_dev *hdev,
+			struct legacy_intel_version *ver);
+void btintel_tlv_version_info(struct hci_dev *hdev,
+			struct tlv_intel_version *ver);
+void btintel_tlv_boot_info(struct hci_dev *hdev,
+			struct tlv_intel_version *ver);
 int btintel_secure_send(struct hci_dev *hdev, u8 fragment_type, u32 plen,
 			const void *param);
 int btintel_load_ddc_config(struct hci_dev *hdev, const char *ddc_name);
 int btintel_set_event_mask(struct hci_dev *hdev, bool debug);
 int btintel_set_event_mask_mfg(struct hci_dev *hdev, bool debug);
-int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver);
+int btintel_new_read_version(struct hci_dev *hdev, bool *is_tlv_format,
+			struct sk_buff **skb);
+int btintel_read_version(struct hci_dev *hdev,
+			struct legacy_intel_version *ver);
+bool btintel_legacy_get_fw_name(struct legacy_intel_version *ver,
+			struct intel_boot_params *params,
+			char *fw_name, size_t len,
+			const char *suffix);
+void btintel_tlv_get_fw_name(struct tlv_intel_version *ver,
+			char *fw_name, size_t len,
+			const char *suffix);
 
 struct regmap *btintel_regmap_init(struct hci_dev *hdev, u16 opcode_read,
 				   u16 opcode_write);
 int btintel_send_intel_reset(struct hci_dev *hdev, u32 boot_param);
 int btintel_read_boot_params(struct hci_dev *hdev,
 			     struct intel_boot_params *params);
-int btintel_download_firmware(struct hci_dev *dev, const struct firmware *fw,
-			      u32 *boot_param);
+int btintel_legacy_download_firmware(struct hci_dev *dev,
+			const struct firmware *fw,
+			u32 *boot_param);
+int btintel_tlv_download_firmware(struct hci_dev *hdev,
+			const struct firmware *fw,
+			u32 *boot_param, u8 hw_variant, u8 sbe_type);
 void btintel_reset_to_bootloader(struct hci_dev *hdev);
 #else
 
@@ -124,8 +252,18 @@ static inline void btintel_hw_error(struct hci_dev *hdev, u8 code)
 {
 }
 
-static inline void btintel_version_info(struct hci_dev *hdev,
-					struct intel_version *ver)
+static inline void btintel_legacy_version_info(struct hci_dev *hdev,
+					struct legacy_intel_version *ver)
+{
+}
+
+static inline void btintel_tlv_version_info(struct hci_dev *hdev,
+					struct tlv_intel_version *ver)
+{
+}
+
+static inline void btintel_tlv_boot_info(struct hci_dev *hdev,
+					struct tlv_intel_version *ver)
 {
 }
 
@@ -151,8 +289,29 @@ static inline int btintel_set_event_mask_mfg(struct hci_dev *hdev, bool debug)
 	return -EOPNOTSUPP;
 }
 
+static inline int btintel_new_read_version(struct hci_dev *hdev,
+			bool *is_tlv_format, struct sk_buff **skb)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int btintel_read_version(struct hci_dev *hdev,
-				       struct intel_version *ver)
+		struct legacy_intel_version *ver)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline bool btintel_legacy_get_fw_name(struct legacy_intel_version *ver,
+				 struct intel_boot_params *params,
+				 char *fw_name, size_t len,
+				 const char *suffix)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void btintel_tlv_get_fw_name(struct tlv_intel_version *ver,
+				char *fw_name, size_t len,
+				const char *suffix)
 {
 	return -EOPNOTSUPP;
 }
@@ -176,13 +335,21 @@ static inline int btintel_read_boot_params(struct hci_dev *hdev,
 	return -EOPNOTSUPP;
 }
 
-static inline int btintel_download_firmware(struct hci_dev *dev,
+static inline int btintel_legacy_download_firmware(struct hci_dev *dev,
 					    const struct firmware *fw,
 					    u32 *boot_param)
 {
 	return -EOPNOTSUPP;
 }
 
+static inline int btintel_tlv_download_firmware(struct hci_dev *hdev,
+		const struct firmware *fw,
+		u32 *boot_param,
+		u8 hw_variant, u8 sbe_type)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline void btintel_reset_to_bootloader(struct hci_dev *hdev)
 {
 }
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7a71d851b6c9..8f1408b530f9 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1753,7 +1753,7 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 }
 
 static const struct firmware *btusb_setup_intel_get_fw(struct hci_dev *hdev,
-						       struct intel_version *ver)
+						       struct legacy_intel_version *ver)
 {
 	const struct firmware *fw;
 	char fwname[64];
@@ -1913,7 +1913,7 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	const struct firmware *fw;
 	const u8 *fw_ptr;
 	int disable_patch, err;
-	struct intel_version ver;
+	struct legacy_intel_version ver;
 
 	BT_DBG("%s", hdev->name);
 
@@ -2227,98 +2227,328 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 	return -EILSEQ;
 }
 
-static bool btusb_setup_intel_new_get_fw_name(struct intel_version *ver,
-					     struct intel_boot_params *params,
-					     char *fw_name, size_t len,
-					     const char *suffix)
+static int btusb_intel_wait_for_fw_download(struct hci_dev *hdev)
 {
-	switch (ver->hw_variant) {
-	case 0x0b:	/* SfP */
-	case 0x0c:	/* WsP */
-		snprintf(fw_name, len, "intel/ibt-%u-%u.%s",
-			le16_to_cpu(ver->hw_variant),
-			le16_to_cpu(params->dev_revid),
-			suffix);
-		break;
-	case 0x11:	/* JfP */
-	case 0x12:	/* ThP */
-	case 0x13:	/* HrP */
-	case 0x14:	/* CcP */
-		snprintf(fw_name, len, "intel/ibt-%u-%u-%u.%s",
-			le16_to_cpu(ver->hw_variant),
-			le16_to_cpu(ver->hw_revision),
-			le16_to_cpu(ver->fw_revision),
-			suffix);
+	int err;
+	struct btusb_data *data = hci_get_drvdata(hdev);
+
+	err = wait_on_bit_timeout(&data->flags, BTUSB_DOWNLOADING,
+				  TASK_INTERRUPTIBLE,
+				  msecs_to_jiffies(5000));
+	if (err == -EINTR) {
+		bt_dev_err(hdev, "Firmware loading interrupted");
+		return err;
+	}
+	if (err) {
+		bt_dev_err(hdev, "Firmware loading timeout");
+		return -ETIMEDOUT;
+	}
+	if (test_bit(BTUSB_FIRMWARE_FAILED, &data->flags)) {
+		bt_dev_err(hdev, "Firmware loading failed");
+		return -ENOEXEC;
+	}
+
+	return 0;
+}
+
+static bool btusb_check_intel_hw_varaint(struct hci_dev *hdev,
+					 u8 hw_variant)
+{
+	/* Check for supported iBT hardware variants of this firmware
+	 * loading method.
+	 *
+	 * This check has been put in place to ensure correct forward
+	 * compatibility options when newer hardware variants come along.
+	 */
+
+	switch (hw_variant) {
+	case 0x0b:		/* SfP */
+	case 0x0c:		/* WsP */
+	case 0x11:		/* JfP */
+	case 0x12:		/* ThP */
+	case 0x13:		/* HrP */
+	case 0x14:		/* QnJ, CcP, SuP */
+	case 0x17:		/* TyP */
+	case 0x18:		/* Solar */
 		break;
 	default:
+		bt_dev_err(hdev, "Unsupported Intel hardware variant (%u)",
+			   hw_variant);
 		return false;
 	}
 	return true;
 }
 
-static int btusb_setup_intel_new(struct hci_dev *hdev)
+static bool btusb_check_intel_hw_platform(struct hci_dev *hdev,
+					  u8 hw_platform)
+{
+	/* The hardware platform number has a fixed value of 0x37 and
+	 * for now only accept this single value.
+	 * TEST: FPGA build needs support for hardware platform 0x02
+	 */
+	if (hw_platform == INTEL_PLATFORM || hw_platform == 0x02) {
+		return true;
+	} else {
+		bt_dev_err(hdev, "Unsupported Intel hardware platform (%u)",
+			   hw_platform);
+		return false;
+	}
+}
+
+static int btusb_fw_download_intel_tlv_format(struct hci_dev *hdev,
+				struct sk_buff *skb, u32 *boot_param,
+				char *fwname, size_t size,
+				bool *is_bootloader)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
-	struct intel_version ver;
-	struct intel_boot_params params;
+	struct tlv_intel_version ver;
+	struct intel_tlv *tlv;
 	const struct firmware *fw;
-	u32 boot_param;
-	char fwname[64];
-	ktime_t calltime, delta, rettime;
-	unsigned long long duration;
 	int err;
 
-	BT_DBG("%s", hdev->name);
+	/* Consume Command Complete Status field */
+	skb_pull(skb, 1);
 
-	/* Set the default boot parameter to 0x0 and it is updated to
-	 * SKU specific boot parameter after reading Intel_Write_Boot_Params
-	 * command while downloading the firmware.
+	/* Event parameters contatin multiple TLVs. Read each of them
+	 * and only keep the required data. Also, it use existing legacy
+	 * version field like hw_platform, hw_variant, and fw_variant
+	 * to keep the existing setup flow
 	 */
-	boot_param = 0x00000000;
+	while (skb->len) {
+		tlv = (struct intel_tlv *)skb->data;
+		switch (tlv->type) {
+		case INTEL_VER_TLV_CNVI_TOP:
+			ver.cnvi_top = (tlv->val[3] << 24) |\
+					(tlv->val[2] << 16) |\
+					(tlv->val[1] << 8) |\
+					(tlv->val[0]);
+			break;
+		case INTEL_VER_TLV_CNVR_TOP:
+			ver.cnvr_top = (tlv->val[3] << 24) |\
+					(tlv->val[2] << 16) |\
+					(tlv->val[1] << 8) |\
+					(tlv->val[0]);
+			break;
+		case INTEL_VER_TLV_CNVI_BT:
+			ver.cnvi_bt = (tlv->val[3] << 24) |\
+					(tlv->val[2] << 16) |\
+					(tlv->val[1] << 8) |\
+					(tlv->val[0]);
+			break;
+		case INTEL_VER_TLV_CNVR_BT:
+			ver.cnvr_bt = (tlv->val[3] << 24) |\
+					(tlv->val[2] << 16) |\
+					(tlv->val[1] << 8) |\
+					(tlv->val[0]);
+			break;
+		case INTEL_VER_TLV_USB_VENDOR_ID:
+			ver.usb_vid = (tlv->val[1] << 8) |\
+					(tlv->val[0]);
+			break;
+		case INTEL_VER_TLV_USB_PRODUCT_ID:
+			ver.usb_pid = (tlv->val[1] << 8) |\
+					(tlv->val[0]);
+			break;
+		case INTEL_VER_TLV_IMAGE_TYPE:
+			ver.img_type = tlv->val[0];
+			break;
+		case INTEL_VER_TLV_TIME_STAMP:
+			ver.timestamp = (tlv->val[1] << 8) |\
+					(tlv->val[0]);
+			break;
+		case INTEL_VER_TLV_BUILD_TYPE:
+			ver.build_type = tlv->val[0];
+			break;
+		case INTEL_VER_TLV_BUILD_NUM:
+			ver.build_num = (tlv->val[3] << 24) |
+					(tlv->val[2] << 16) |\
+					(tlv->val[1] << 8) |\
+					(tlv->val[0]);
+			break;
+		case INTEL_VER_TLV_SECURE_BOOT:
+			ver.secure_boot = tlv->val[0];
+			break;
+		case INTEL_VER_TLV_KEY_FROM_HDR:
+			ver.key_from_hdr = tlv->val[0];
+			break;
+		case INTEL_VER_TLV_OTP_LOCK:
+			ver.otp_lock = tlv->val[0];
+			break;
+		case INTEL_VER_TLV_API_LOCK:
+			ver.api_lock = tlv->val[0];
+			break;
+		case INTEL_VER_TLV_DEBUG_LOCK:
+			ver.debug_lock = tlv->val[0];
+			break;
+		case INTEL_VER_TLV_MIN_FW:
+			ver.min_fw_build_nn = tlv->val[0];
+			ver.min_fw_build_cw = tlv->val[1];
+			ver.min_fw_build_yy = tlv->val[2];
+			break;
+		case INTEL_VER_TLV_LIMITED_CCE:
+			ver.limited_cce = tlv->val[0];
+			break;
+		case INTEL_VER_TLV_SBE_TYPE:
+			ver.sbe_type = tlv->val[0];
+			break;
+		case INTEL_VER_TLV_OTP_BDADDR:
+			memcpy(&ver.otp_bd_addr, tlv->val, tlv->len);
+			break;
+		default:
+			/* Ignore rest of information */
+			break;
+		}
+		/* Consume the current tlv and move to next tlv data */
+		skb_pull(skb, tlv->len + sizeof(*tlv));
+	}
+	kfree_skb(skb);
 
-	calltime = ktime_get();
+	if (!btusb_check_intel_hw_platform(hdev,
+				INTEL_HW_PLATFORM(ver.cnvi_bt)))
+		return -EINVAL;
 
-	/* Read the Intel version information to determine if the device
-	 * is in bootloader mode or if it already has operational firmware
-	 * loaded.
+	if (!btusb_check_intel_hw_varaint(hdev,
+				INTEL_HW_VARIANT(ver.cnvi_bt)))
+		return -EINVAL;
+
+	btintel_tlv_version_info(hdev, &ver);
+
+	/* The image type determines if the device is in bootloader
+	 * mode or is running operational firmware. The value 0x01
+	 * identifies the bootloader and the value 0x03 identifies
+	 * the operational firmware.
+	 *
+	 * When the operational firmware is already present, then only
+	 * the check for valid Bluetooth device address is needed. This
+	 * determines if the device will be added as configured or
+	 * unconfigured controller.
 	 */
-	err = btintel_read_version(hdev, &ver);
-	if (err) {
-		bt_dev_err(hdev, "Intel Read version failed (%d)", err);
-		btintel_reset_to_bootloader(hdev);
-		return err;
+	if (ver.img_type == 0x03) {
+		clear_bit(BTUSB_BOOTLOADER, &data->flags);
+		btintel_check_bdaddr(hdev);
+		*is_bootloader = false;
+		return 0;
 	}
 
-	/* The hardware platform number has a fixed value of 0x37 and
-	 * for now only accept this single value.
+	/* If the device is not in bootloader mode, then the only possible
+	 * choice is to return an error and abort the device initialization.
 	 */
-	if (ver.hw_platform != 0x37) {
-		bt_dev_err(hdev, "Unsupported Intel hardware platform (%u)",
-			   ver.hw_platform);
+	if (ver.img_type != 0x01) {
+		bt_dev_err(hdev, "Unsupported Intel firmware variant (%u)",
+			   ver.img_type);
+		return -ENODEV;
+	}
+
+	*is_bootloader = true;
+	btintel_tlv_boot_info(hdev, &ver);
+
+	/* It is required that every single firmware fragment is acknowledged
+	 * with a command complete event. If the limited_cce parameter
+	 * indicates that this bootloader does not send them, then abort
+	 * the setup.
+	 */
+	if (ver.limited_cce != 0x00) {
+		bt_dev_err(hdev, "Unsupported Intel firmware loading method (%u)",
+			   ver.limited_cce);
 		return -EINVAL;
 	}
 
-	/* Check for supported iBT hardware variants of this firmware
-	 * loading method.
+	/* Secure Boot Engine Type should be either 0 (RSA) or 1 (ECDSA) */
+	if (ver.sbe_type > 0x01) {
+		bt_dev_err(hdev, "Unsupported Intel Secure Boot Engine Type (%u)",
+			   ver.sbe_type);
+		return -EINVAL;
+	}
+
+	/* If the OTP has no valid Bluetooth device address, then there will
+	 * also be no valid address for the operational firmware.
+	 */
+	if (!bacmp(&ver.otp_bd_addr, BDADDR_ANY)) {
+		bt_dev_info(hdev, "No device address configured");
+		/* FPGA or blank OTP chip has a default BDADDR
+		 * For internal use, ignore it.
+		 *
+		 * set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
+		 */
+	}
+
+	/* Get the firmware filename for operational firmware */
+	btintel_tlv_get_fw_name(&ver, fwname, size, "sfi");
+
+	err = request_firmware(&fw, fwname, &hdev->dev);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to load Intel firmware file (%d)",
+			   err);
+		return err;
+	}
+
+	bt_dev_info(hdev, "Found device firmware: %s", fwname);
+
+	/* Save the DDC file name for later use to apply once the firmware
+	 * downloading is done.
+	 */
+	btintel_tlv_get_fw_name(&ver, fwname, size, "ddc");
+
+	if (fw->size < 644) {
+		bt_dev_err(hdev, "Invalid size of firmware file (%zu)",
+			   fw->size);
+		err = -EBADF;
+		goto done;
+	}
+	set_bit(BTUSB_DOWNLOADING, &data->flags);
+
+	/* Start firmware downloading and get boot parameter */
+	err = btintel_tlv_download_firmware(hdev, fw, boot_param,
+				INTEL_HW_VARIANT(ver.cnvi_bt),
+				ver.sbe_type);
+	if (err < 0)
+		goto done;
+
+	set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
+	bt_dev_info(hdev, "Waiting for firmware download to complete");
+
+	/* Before switching the device into operational mode and with that
+	 * booting the loaded firmware, wait for the bootloader notification
+	 * that all fragments have been successfully received.
 	 *
-	 * This check has been put in place to ensure correct forward
-	 * compatibility options when newer hardware variants come along.
+	 * When the event processing receives the notification, then the
+	 * BTUSB_DOWNLOADING flag will be cleared.
+	 *
+	 * The firmware loading should not take longer than 5 seconds
+	 * and thus just timeout if that happens and fail the setup
+	 * of this device.
 	 */
-	switch (ver.hw_variant) {
-	case 0x0b:	/* SfP */
-	case 0x0c:	/* WsP */
-	case 0x11:	/* JfP */
-	case 0x12:	/* ThP */
-	case 0x13:	/* HrP */
-	case 0x14:	/* CcP */
-		break;
-	default:
-		bt_dev_err(hdev, "Unsupported Intel hardware variant (%u)",
-			   ver.hw_variant);
+	err = btusb_intel_wait_for_fw_download(hdev);
+
+done:
+	release_firmware(fw);
+
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static int btusb_fw_download_intel_legacy_format(struct hci_dev *hdev,
+		struct sk_buff *skb, u32 *boot_param, char *fwname,
+		size_t size, bool *is_bootloader)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	struct legacy_intel_version ver;
+	struct intel_boot_params params;
+	const struct firmware *fw;
+	int err;
+
+	memcpy(&ver, skb->data, LEGACY_INTEL_VERSION_LEN);
+	kfree_skb(skb);
+
+	if (!btusb_check_intel_hw_platform(hdev, ver.hw_platform))
 		return -EINVAL;
-	}
 
-	btintel_version_info(hdev, &ver);
+	if (!btusb_check_intel_hw_varaint(hdev, ver.hw_variant))
+		return -EINVAL;
+
+	btintel_legacy_version_info(hdev, &ver);
 
 	/* The firmware variant determines if the device is in bootloader
 	 * mode or is running operational firmware. The value 0x06 identifies
@@ -2336,9 +2566,11 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	if (ver.fw_variant == 0x23) {
 		clear_bit(BTUSB_BOOTLOADER, &data->flags);
 		btintel_check_bdaddr(hdev);
-		goto finish;
+		*is_bootloader = false;
+		return 0;
 	}
 
+
 	/* If the device is not in bootloader mode, then the only possible
 	 * choice is to return an error and abort the device initialization.
 	 */
@@ -2348,6 +2580,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 		return -ENODEV;
 	}
 
+	*is_bootloader = true;
 	/* Read the secure boot parameters to identify the operating
 	 * details of the bootloader.
 	 */
@@ -2369,33 +2602,17 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	 * also be no valid address for the operational firmware.
 	 */
 	if (!bacmp(&params.otp_bdaddr, BDADDR_ANY)) {
-		bt_dev_info(hdev, "No device address configured");
-		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
+		bt_dev_info (hdev, "No device address configured");
+		/* FPGA or blank OTP chip has a default BDADDR
+		 * For internal use, ignore it.
+		 *
+		 * set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
+		 */
 	}
 
-	/* With this Intel bootloader only the hardware variant and device
-	 * revision information are used to select the right firmware for SfP
-	 * and WsP.
-	 *
-	 * The firmware filename is ibt-<hw_variant>-<dev_revid>.sfi.
-	 *
-	 * Currently the supported hardware variants are:
-	 *   11 (0x0b) for iBT3.0 (LnP/SfP)
-	 *   12 (0x0c) for iBT3.5 (WsP)
-	 *
-	 * For ThP/JfP and for future SKU's, the FW name varies based on HW
-	 * variant, HW revision and FW revision, as these are dependent on CNVi
-	 * and RF Combination.
-	 *
-	 *   17 (0x11) for iBT3.5 (JfP)
-	 *   18 (0x12) for iBT3.5 (ThP)
-	 *
-	 * The firmware file name for these will be
-	 * ibt-<hw_variant>-<hw_revision>-<fw_revision>.sfi.
-	 *
-	 */
-	err = btusb_setup_intel_new_get_fw_name(&ver, &params, fwname,
-						sizeof(fwname), "sfi");
+	/* Get the firmware filename for operational firmware */
+	err = btintel_legacy_get_fw_name(&ver, &params, fwname,
+					size, "sfi");
 	if (!err) {
 		bt_dev_err(hdev, "Unsupported Intel firmware naming");
 		return -EINVAL;
@@ -2403,17 +2620,19 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 
 	err = request_firmware(&fw, fwname, &hdev->dev);
 	if (err < 0) {
-		bt_dev_err(hdev, "Failed to load Intel firmware file (%d)", err);
+		bt_dev_err(hdev, "Failed to load Intel firmware file (%d)",
+			   err);
 		return err;
 	}
 
-	bt_dev_info(hdev, "Found device firmware: %s", fwname);
+	bt_dev_info(hdev, "%s: Found device firmware: %s", hdev->name, fwname);
 
 	/* Save the DDC file name for later use to apply once the firmware
 	 * downloading is done.
 	 */
-	err = btusb_setup_intel_new_get_fw_name(&ver, &params, fwname,
-						sizeof(fwname), "ddc");
+
+	err = btintel_legacy_get_fw_name(&ver, &params, fwname,
+					size, "ddc");
 	if (!err) {
 		bt_dev_err(hdev, "Unsupported Intel firmware naming");
 		return -EINVAL;
@@ -2429,16 +2648,11 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	set_bit(BTUSB_DOWNLOADING, &data->flags);
 
 	/* Start firmware downloading and get boot parameter */
-	err = btintel_download_firmware(hdev, fw, &boot_param);
-	if (err < 0) {
-		/* When FW download fails, send Intel Reset to retry
-		 * FW download.
-		 */
-		btintel_reset_to_bootloader(hdev);
+	err = btintel_legacy_download_firmware(hdev, fw, boot_param);
+	if (err < 0)
 		goto done;
-	}
-	set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
 
+	set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
 	bt_dev_info(hdev, "Waiting for firmware download to complete");
 
 	/* Before switching the device into operational mode and with that
@@ -2452,49 +2666,79 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	 * and thus just timeout if that happens and fail the setup
 	 * of this device.
 	 */
-	err = wait_on_bit_timeout(&data->flags, BTUSB_DOWNLOADING,
-				  TASK_INTERRUPTIBLE,
-				  msecs_to_jiffies(5000));
-	if (err == -EINTR) {
-		bt_dev_err(hdev, "Firmware loading interrupted");
-		goto done;
-	}
+	err = btusb_intel_wait_for_fw_download(hdev);
 
-	if (err) {
-		bt_dev_err(hdev, "Firmware loading timeout");
-		err = -ETIMEDOUT;
-		btintel_reset_to_bootloader(hdev);
-		goto done;
-	}
+done:
+	release_firmware(fw);
 
-	if (test_bit(BTUSB_FIRMWARE_FAILED, &data->flags)) {
-		bt_dev_err(hdev, "Firmware loading failed");
-		err = -ENOEXEC;
-		goto done;
+	if (err < 0)
+		return err;
+	return 0;
+}
+
+static int btusb_setup_intel_new(struct hci_dev *hdev)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	u32 boot_param;
+	ktime_t calltime, delta, rettime;
+	unsigned long long duration;
+	char fwname[64];
+	int err;
+	bool is_tlv_format;
+	bool is_bootloader;
+	struct sk_buff *skb;
+
+	bt_dev_dbg (hdev,"%s", __func__);
+
+	/* Set the default boot parameter to 0x0 and it is updated to
+	 * SKU specific boot parameter after reading Intel_Write_Boot_Params
+	 * command while downloading the firmware.
+	 */
+	boot_param = 0x00000000;
+
+	calltime = ktime_get();
+
+	/* Read the Intel version information to determine if the device
+	 * supports Command Complete Event with legacy format or TLV format
+	 */
+	err = btintel_new_read_version(hdev, &is_tlv_format, &skb);
+	if (err)
+		return err;
+
+	if (is_tlv_format) {
+		err = btusb_fw_download_intel_tlv_format(hdev, skb,
+							 &boot_param,
+							 fwname,
+							 sizeof(fwname),
+							 &is_bootloader);
+	} else {
+		err = btusb_fw_download_intel_legacy_format(hdev, skb,
+							    &boot_param,
+							    fwname, sizeof(fwname),
+							    &is_bootloader);
 	}
 
+	if (err)
+		return err;
+
+	/* Skip the following steps, if operational FW is already present
+	 */
+	if (!is_bootloader)
+		return 0;
+
 	rettime = ktime_get();
 	delta = ktime_sub(rettime, calltime);
 	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
 
 	bt_dev_info(hdev, "Firmware loaded in %llu usecs", duration);
 
-done:
-	release_firmware(fw);
-
-	if (err < 0)
-		return err;
-
 	calltime = ktime_get();
 
 	set_bit(BTUSB_BOOTING, &data->flags);
 
 	err = btintel_send_intel_reset(hdev, boot_param);
-	if (err) {
-		bt_dev_err(hdev, "Intel Soft Reset failed (%d)", err);
-		btintel_reset_to_bootloader(hdev);
+	if (err < 0)
 		return err;
-	}
 
 	/* The bootloader will not indicate when the device is ready. This
 	 * is done by the operational firmware sending bootup notification.
@@ -2516,7 +2760,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 
 	if (err) {
 		bt_dev_err(hdev, "Device boot timeout");
-		btintel_reset_to_bootloader(hdev);
 		return -ETIMEDOUT;
 	}
 
@@ -2536,23 +2779,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	 */
 	btintel_load_ddc_config(hdev, fwname);
 
-	/* Read the Intel version information after loading the FW  */
-	err = btintel_read_version(hdev, &ver);
-	if (err)
-		return err;
-
-	btintel_version_info(hdev, &ver);
-
-finish:
-	/* All Intel controllers that support the Microsoft vendor
-	 * extension are using 0xFC1E for VsMsftOpCode.
-	 */
-	switch (ver.hw_variant) {
-	case 0x12:	/* ThP */
-		hci_set_msft_opcode(hdev, 0xFC1E);
-		break;
-	}
-
 	/* Set the event mask for Intel specific vendor events. This enables
 	 * a few extra events that are useful during general operation. It
 	 * does not enable any debugging related events.
diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index f1299da6eed8..f817cface406 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -531,7 +531,7 @@ static int intel_setup(struct hci_uart *hu)
 	struct intel_data *intel = hu->priv;
 	struct hci_dev *hdev = hu->hdev;
 	struct sk_buff *skb;
-	struct intel_version ver;
+	struct legacy_intel_version ver;
 	struct intel_boot_params params;
 	struct list_head *p;
 	const struct firmware *fw;
@@ -614,7 +614,7 @@ static int intel_setup(struct hci_uart *hu)
 		return -EINVAL;
 	}
 
-	btintel_version_info(hdev, &ver);
+	btintel_legacy_version_info(hdev, &ver);
 
 	/* The firmware variant determines if the device is in bootloader
 	 * mode or is running operational firmware. The value 0x06 identifies
@@ -747,7 +747,7 @@ static int intel_setup(struct hci_uart *hu)
 	set_bit(STATE_DOWNLOADING, &intel->flags);
 
 	/* Start firmware downloading and get boot parameter */
-	err = btintel_download_firmware(hdev, fw, &boot_param);
+	err = btintel_legacy_download_firmware(hdev, fw, &boot_param);
 	if (err < 0)
 		goto done;
 
-- 
2.17.1

