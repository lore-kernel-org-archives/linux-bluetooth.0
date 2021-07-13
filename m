Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97850C07E9A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Jul 2021 03:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61FFB606A5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Jul 2021 03:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbhGMD02 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Jul 2021 23:26:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:12331 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229928AbhGMD02 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Jul 2021 23:26:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="190469931"
X-IronPort-AV: E=Sophos;i="5.84,235,1620716400"; 
   d="scan'208";a="190469931"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 20:23:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,235,1620716400"; 
   d="scan'208";a="459418285"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga008.jf.intel.com with ESMTP; 12 Jul 2021 20:23:37 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Kiran K <kiran.k@intel.com>
Subject: [PATCH v2] Bluetooth: btintel: Support Digital(N) + RF(N-1) combination
Date:   Tue, 13 Jul 2021 08:57:55 +0530
Message-Id: <20210713032755.19351-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

New generation Intel controllers(N) need to support RF from (N-1)
generation. Since PID comes from OTP present in RF module,
*setup* function gets mapped to BTUSB_INTEL_NEW instead of
BTUSB_INTEL_NEWGEN. This patch converges INTEL_NEW and INTEL_NEWGEN
mappings and defines a new generic *setup* function. All the
required information to load the correct driver is read from controller
in generic *setup* and branchs out appropriately.

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
changes in v2:
 * For compatibility b/w CNVi and CNVr, instead of overriding the callbacks
   find out the required information at run time and branch out appropriately
 * review comments

 drivers/bluetooth/btintel.c | 149 ++++++++++++++++++++++++++++++------
 drivers/bluetooth/btintel.h |  10 +++
 drivers/bluetooth/btusb.c   | 149 +++++++++++++++++++-----------------
 3 files changed, 215 insertions(+), 93 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index e44b6993cf91..b1a4e02c0680 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -58,8 +58,10 @@ int btintel_check_bdaddr(struct hci_dev *hdev)
 	 * address 00:03:19:9E:8B:00 can be found. These controllers are
 	 * fully operational, but have the danger of duplicate addresses
 	 * and that in turn can cause problems with Bluetooth operation.
+	 * Also mark controllers having zero bdaddress
 	 */
-	if (!bacmp(&bda->bdaddr, BDADDR_INTEL)) {
+	if (!bacmp(&bda->bdaddr, BDADDR_INTEL) ||
+	    !bacmp(&bda->bdaddr, BDADDR_ANY)) {
 		bt_dev_err(hdev, "Found Intel default device address (%pMR)",
 			   &bda->bdaddr);
 		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
@@ -483,30 +485,15 @@ int btintel_version_info_tlv(struct hci_dev *hdev, struct intel_version_tlv *ver
 }
 EXPORT_SYMBOL_GPL(btintel_version_info_tlv);
 
-int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *version)
+static int btintel_parse_version_tlv(struct hci_dev *hdev, struct sk_buff *skb,
+				     struct intel_version_tlv *version)
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
+	int err = 0;
 
-	if (skb->data[0]) {
-		bt_dev_err(hdev, "Intel Read Version command failed (%02x)",
-			   skb->data[0]);
-		kfree_skb(skb);
-		return -EIO;
-	}
+	memset(version, 0x00, sizeof(*version));
 
 	/* Consume Command Complete Status field */
-	skb_pull(skb, 1);
+	skb_pull(skb, sizeof(__u8));
 
 	/* Event parameters contatin multiple TLVs. Read each of them
 	 * and only keep the required data. Also, it use existing legacy
@@ -516,27 +503,62 @@ int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *ver
 	while (skb->len) {
 		struct intel_tlv *tlv;
 
+		if (skb->len < sizeof(*tlv)) {
+			err = -EILSEQ;
+			break;
+		}
+
 		tlv = (struct intel_tlv *)skb->data;
+
+		if (skb->len < (sizeof(*tlv) + tlv->len)) {
+			err = -EILSEQ;
+			break;
+		}
+
 		switch (tlv->type) {
 		case INTEL_TLV_CNVI_TOP:
+			if (tlv->len != sizeof(__le32)) {
+				err = -EILSEQ;
+				break;
+			}
 			version->cnvi_top = get_unaligned_le32(tlv->val);
 			break;
 		case INTEL_TLV_CNVR_TOP:
+			if (tlv->len != sizeof(__le32)) {
+				err = -EILSEQ;
+				break;
+			}
 			version->cnvr_top = get_unaligned_le32(tlv->val);
 			break;
 		case INTEL_TLV_CNVI_BT:
+			if (tlv->len != sizeof(__le32)) {
+				err = -EILSEQ;
+				break;
+			}
 			version->cnvi_bt = get_unaligned_le32(tlv->val);
 			break;
 		case INTEL_TLV_CNVR_BT:
+			if (tlv->len != sizeof(__le32)) {
+				err = -EILSEQ;
+				break;
+			}
 			version->cnvr_bt = get_unaligned_le32(tlv->val);
 			break;
 		case INTEL_TLV_DEV_REV_ID:
+			if (tlv->len != sizeof(__le16)) {
+				err = -EILSEQ;
+				break;
+			}
 			version->dev_rev_id = get_unaligned_le16(tlv->val);
 			break;
 		case INTEL_TLV_IMAGE_TYPE:
 			version->img_type = tlv->val[0];
 			break;
 		case INTEL_TLV_TIME_STAMP:
+			if (tlv->len != sizeof(__le16)) {
+				err = -EILSEQ;
+				break;
+			}
 			/* If image type is Operational firmware (0x03), then
 			 * running FW Calendar Week and Year information can
 			 * be extracted from Timestamp information
@@ -549,6 +571,10 @@ int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *ver
 			version->build_type = tlv->val[0];
 			break;
 		case INTEL_TLV_BUILD_NUM:
+			if (tlv->len != sizeof(__le32)) {
+				err = -EILSEQ;
+				break;
+			}
 			/* If image type is Operational firmware (0x03), then
 			 * running FW build number can be extracted from the
 			 * Build information
@@ -569,6 +595,10 @@ int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *ver
 			version->debug_lock = tlv->val[0];
 			break;
 		case INTEL_TLV_MIN_FW:
+			if (tlv->len != 3) {
+				err = -EILSEQ;
+				break;
+			}
 			version->min_fw_build_nn = tlv->val[0];
 			version->min_fw_build_cw = tlv->val[1];
 			version->min_fw_build_yy = tlv->val[2];
@@ -580,21 +610,96 @@ int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *ver
 			version->sbe_type = tlv->val[0];
 			break;
 		case INTEL_TLV_OTP_BDADDR:
+			if (tlv->len != sizeof(version->otp_bd_addr)) {
+				err = -EILSEQ;
+				break;
+			}
 			memcpy(&version->otp_bd_addr, tlv->val, tlv->len);
 			break;
 		default:
 			/* Ignore rest of information */
 			break;
 		}
+
+		if (err)
+			break;
+
 		/* consume the current tlv and move to next*/
 		skb_pull(skb, tlv->len + sizeof(*tlv));
 	}
+	return err;
+}
+
+int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *version)
+{
+	int err;
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
+	err = btintel_parse_version_tlv(hdev, skb, version);
 
 	kfree_skb(skb);
-	return 0;
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(btintel_read_version_tlv);
 
+int btintel_generic_read_version(struct hci_dev *hdev,
+				 struct intel_version_tlv *ver_tlv,
+				 struct intel_version *ver, bool *is_tlv)
+{
+	int err = 0;
+	struct sk_buff *skb;
+	const u8 param[1] = { 0xFF };
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
+	if (skb->len < sizeof(struct intel_version))
+		return -EILSEQ;
+
+	if (skb->len == sizeof(struct intel_version) &&
+	    skb->data[1] == 0x37) {
+		*is_tlv = false;
+		memcpy(ver, skb->data, sizeof(*ver));
+	} else {
+		*is_tlv = true;
+		err = btintel_parse_version_tlv(hdev, skb, ver_tlv);
+	}
+
+	kfree_skb(skb);
+	return err;
+}
+EXPORT_SYMBOL_GPL(btintel_generic_read_version);
+
 /* ------- REGMAP IBT SUPPORT ------- */
 
 #define IBT_REG_MODE_8BIT  0x00
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index d184064a5e7c..366cb746f9c4 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -175,6 +175,10 @@ int btintel_read_debug_features(struct hci_dev *hdev,
 				struct intel_debug_features *features);
 int btintel_set_debug_features(struct hci_dev *hdev,
 			       const struct intel_debug_features *features);
+int btintel_generic_read_version(struct hci_dev *hdev,
+				 struct intel_version_tlv *ver_tlv,
+				 struct intel_version *ver,
+				 bool *is_tlv);
 #else
 
 static inline int btintel_check_bdaddr(struct hci_dev *hdev)
@@ -307,4 +311,10 @@ static inline int btintel_set_debug_features(struct hci_dev *hdev,
 	return -EOPNOTSUPP;
 }
 
+static int btintel_generic_read_version(struct hci_dev *hdev,
+					struct intel_version_tlv *ver_tlv,
+					struct intel_version *ver, bool *is_tlv)
+{
+	return -EOPNOTSUPP;
+}
 #endif
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a9855a2dd561..6c5050bdcfcc 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -60,7 +60,6 @@ static struct usb_driver btusb_driver;
 #define BTUSB_WIDEBAND_SPEECH	0x400000
 #define BTUSB_VALID_LE_STATES   0x800000
 #define BTUSB_QCA_WCN6855	0x1000000
-#define BTUSB_INTEL_NEWGEN	0x2000000
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -368,9 +367,9 @@ static const struct usb_device_id blacklist_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x8087, 0x0029), .driver_info = BTUSB_INTEL_NEW |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x8087, 0x0032), .driver_info = BTUSB_INTEL_NEWGEN |
+	{ USB_DEVICE(0x8087, 0x0032), .driver_info = BTUSB_INTEL_NEW |
 						     BTUSB_WIDEBAND_SPEECH},
-	{ USB_DEVICE(0x8087, 0x0033), .driver_info = BTUSB_INTEL_NEWGEN |
+	{ USB_DEVICE(0x8087, 0x0033), .driver_info = BTUSB_INTEL_NEW |
 						     BTUSB_WIDEBAND_SPEECH},
 	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL },
@@ -2521,8 +2520,8 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
 		return -EINVAL;
 
 	/* The firmware variant determines if the device is in bootloader
-	 * mode or is running operational firmware. The value 0x03 identifies
-	 * the bootloader and the value 0x23 identifies the operational
+	 * mode or is running operational firmware. The value 0x23 identifies
+	 * the bootloader and the value 0x03 identifies the operational
 	 * firmware.
 	 *
 	 * When the operational firmware is already present, then only
@@ -2536,14 +2535,14 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
 	if (ver->img_type == 0x03) {
 		clear_bit(BTUSB_BOOTLOADER, &data->flags);
 		btintel_check_bdaddr(hdev);
-	}
-
-	/* If the OTP has no valid Bluetooth device address, then there will
-	 * also be no valid address for the operational firmware.
-	 */
-	if (!bacmp(&ver->otp_bd_addr, BDADDR_ANY)) {
-		bt_dev_info(hdev, "No device address configured");
-		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
+	} else {
+		/* In Boot mode, bd address is part of tlv data. Check for
+		 * valid bd address
+		 */
+		if (!bacmp(&ver->otp_bd_addr, BDADDR_ANY)) {
+			bt_dev_info(hdev, "No device address configured");
+			set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
+		}
 	}
 
 	btusb_setup_intel_newgen_get_fw_name(ver, fwname, sizeof(fwname), "sfi");
@@ -2842,10 +2841,9 @@ static int btusb_intel_boot(struct hci_dev *hdev, u32 boot_addr)
 	return err;
 }
 
-static int btusb_setup_intel_new(struct hci_dev *hdev)
+static int btusb_setup_intel_new(struct hci_dev *hdev, struct intel_version *ver)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
-	struct intel_version ver;
 	struct intel_boot_params params;
 	u32 boot_param;
 	char ddcname[64];
@@ -2860,27 +2858,16 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	 */
 	boot_param = 0x00000000;
 
-	/* Read the Intel version information to determine if the device
-	 * is in bootloader mode or if it already has operational firmware
-	 * loaded.
-	 */
-	err = btintel_read_version(hdev, &ver);
-	if (err) {
-		bt_dev_err(hdev, "Intel Read version failed (%d)", err);
-		btintel_reset_to_bootloader(hdev);
-		return err;
-	}
-
-	err = btintel_version_info(hdev, &ver);
+	err = btintel_version_info(hdev, ver);
 	if (err)
 		return err;
 
-	err = btusb_intel_download_firmware(hdev, &ver, &params, &boot_param);
+	err = btusb_intel_download_firmware(hdev, ver, &params, &boot_param);
 	if (err)
 		return err;
 
 	/* controller is already having an operational firmware */
-	if (ver.fw_variant == 0x23)
+	if (ver->fw_variant == 0x23)
 		goto finish;
 
 	err = btusb_intel_boot(hdev, boot_param);
@@ -2889,7 +2876,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 
 	clear_bit(BTUSB_BOOTLOADER, &data->flags);
 
-	err = btusb_setup_intel_new_get_fw_name(&ver, &params, ddcname,
+	err = btusb_setup_intel_new_get_fw_name(ver, &params, ddcname,
 						sizeof(ddcname), "ddc");
 
 	if (err < 0) {
@@ -2913,17 +2900,17 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	btintel_set_debug_features(hdev, &features);
 
 	/* Read the Intel version information after loading the FW  */
-	err = btintel_read_version(hdev, &ver);
+	err = btintel_read_version(hdev, ver);
 	if (err)
 		return err;
 
-	btintel_version_info(hdev, &ver);
+	btintel_version_info(hdev, ver);
 
 finish:
 	/* All Intel controllers that support the Microsoft vendor
 	 * extension are using 0xFC1E for VsMsftOpCode.
 	 */
-	switch (ver.hw_variant) {
+	switch (ver->hw_variant) {
 	case 0x11:	/* JfP */
 	case 0x12:	/* ThP */
 	case 0x13:	/* HrP */
@@ -2944,14 +2931,13 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	return 0;
 }
 
-static int btusb_setup_intel_newgen(struct hci_dev *hdev)
+static int btusb_setup_intel_newgen(struct hci_dev *hdev, struct intel_version_tlv *version)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	u32 boot_param;
 	char ddcname[64];
 	int err;
 	struct intel_debug_features features;
-	struct intel_version_tlv version;
 
 	bt_dev_dbg(hdev, "");
 
@@ -2961,27 +2947,16 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 	 */
 	boot_param = 0x00000000;
 
-	/* Read the Intel version information to determine if the device
-	 * is in bootloader mode or if it already has operational firmware
-	 * loaded.
-	 */
-	err = btintel_read_version_tlv(hdev, &version);
-	if (err) {
-		bt_dev_err(hdev, "Intel Read version failed (%d)", err);
-		btintel_reset_to_bootloader(hdev);
-		return err;
-	}
-
-	err = btintel_version_info_tlv(hdev, &version);
+	err = btintel_version_info_tlv(hdev, version);
 	if (err)
 		return err;
 
-	err = btusb_intel_download_firmware_newgen(hdev, &version, &boot_param);
+	err = btusb_intel_download_firmware_newgen(hdev, version, &boot_param);
 	if (err)
 		return err;
 
 	/* check if controller is already having an operational firmware */
-	if (version.img_type == 0x03)
+	if (version->img_type == 0x03)
 		goto finish;
 
 	err = btusb_intel_boot(hdev, boot_param);
@@ -2990,7 +2965,7 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 
 	clear_bit(BTUSB_BOOTLOADER, &data->flags);
 
-	btusb_setup_intel_newgen_get_fw_name(&version, ddcname, sizeof(ddcname),
+	btusb_setup_intel_newgen_get_fw_name(version, ddcname, sizeof(ddcname),
 					     "ddc");
 	/* Once the device is running in operational mode, it needs to
 	 * apply the device configuration (DDC) parameters.
@@ -3009,11 +2984,11 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 	btintel_set_debug_features(hdev, &features);
 
 	/* Read the Intel version information after loading the FW  */
-	err = btintel_read_version_tlv(hdev, &version);
+	err = btintel_read_version_tlv(hdev, version);
 	if (err)
 		return err;
 
-	btintel_version_info_tlv(hdev, &version);
+	btintel_version_info_tlv(hdev, version);
 
 finish:
 	/* Set the event mask for Intel specific vendor events. This enables
@@ -3027,6 +3002,56 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 
 	return 0;
 }
+
+static bool btintel_is_newgen_controller(struct hci_dev *hdev, u32 cnvi)
+{
+	bt_dev_dbg(hdev, "CNVi - %x", cnvi & 0xFFF);
+
+	switch (cnvi & 0xFFF) {
+	case 0x400: /* Slr */
+	case 0x401: /* Slr-F */
+	case 0x410: /* TyP */
+		return true;
+	}
+	return false;
+}
+
+static int btusb_setup_intel_generic(struct hci_dev *hdev)
+{
+	struct intel_version_tlv ver_tlv;
+	struct intel_version ver;
+	bool is_tlv;
+	int err;
+
+	err = btintel_generic_read_version(hdev, &ver_tlv, &ver, &is_tlv);
+	if (err) {
+		bt_dev_err(hdev, "Intel Read version failed (%d)", err);
+		btintel_reset_to_bootloader(hdev);
+		goto done;
+	}
+
+	if (!is_tlv) {
+		err = btusb_setup_intel_new(hdev, &ver);
+	} else {
+		/* In OP mode Quasar/Pulsar ram products returns TLV data.
+		 * Find out CNVi and then  branch out appropriately
+		 */
+		if (btintel_is_newgen_controller(hdev, ver_tlv.cnvi_top)) {
+			err = btusb_setup_intel_newgen(hdev, &ver_tlv);
+		} else {
+			err = btintel_read_version(hdev, &ver);
+			if (err) {
+				bt_dev_err(hdev, "Intel Read version failed (%d)", err);
+				goto done;
+			}
+			err = btusb_setup_intel_new(hdev, &ver);
+		}
+	}
+done:
+
+	return err;
+}
+
 static int btusb_shutdown_intel(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
@@ -4649,21 +4674,7 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_INTEL_NEW) {
 		hdev->manufacturer = 2;
 		hdev->send = btusb_send_frame_intel;
-		hdev->setup = btusb_setup_intel_new;
-		hdev->shutdown = btusb_shutdown_intel_new;
-		hdev->hw_error = btintel_hw_error;
-		hdev->set_diag = btintel_set_diag;
-		hdev->set_bdaddr = btintel_set_bdaddr;
-		hdev->cmd_timeout = btusb_intel_cmd_timeout;
-		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
-		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
-		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
-	}
-
-	if (id->driver_info & BTUSB_INTEL_NEWGEN) {
-		hdev->manufacturer = 2;
-		hdev->send = btusb_send_frame_intel;
-		hdev->setup = btusb_setup_intel_newgen;
+		hdev->setup = btusb_setup_intel_generic;
 		hdev->shutdown = btusb_shutdown_intel_new;
 		hdev->hw_error = btintel_hw_error;
 		hdev->set_diag = btintel_set_diag;
@@ -4672,10 +4683,6 @@ static int btusb_probe(struct usb_interface *intf,
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
-
-		data->recv_event = btusb_recv_event_intel;
-		data->recv_bulk = btusb_recv_bulk_intel;
-		set_bit(BTUSB_BOOTLOADER, &data->flags);
 	}
 
 	if (id->driver_info & BTUSB_MARVELL)
-- 
2.17.1

