Return-Path: <SRS0=k5tg=AN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9051C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jul 2020 12:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EEB720884
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jul 2020 12:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgGBMCL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jul 2020 08:02:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:27652 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728668AbgGBMCK (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jul 2020 08:02:10 -0400
IronPort-SDR: jwmiNYVKGNJOSxLvoKwrqLmSn9Q0dRkRRDeJY7gznFtUwT3gCxsB8L6BYcTeR25/IkwbD8PYn4
 5MxSm5ZQn8nQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="145947815"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="145947815"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 05:02:09 -0700
IronPort-SDR: vY+9SStY/8TEzuxV6rTvQX2LczjwzClowCcBA0sN4oFzvMMBhEvtgmnZKMxm3LuplaMLtvYA4x
 ODP9XmnLkpfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="304224706"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by fmsmga004.fm.intel.com with ESMTP; 02 Jul 2020 05:02:06 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        kiraank@gmail.com, Kiran K <kiran.k@intel.com>,
        Amit K Bag <amit.k.bag@intel.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>
Subject: [PATCH 1/5] Bluetooth: btintel: Make controller version read generic
Date:   Thu,  2 Jul 2020 17:33:11 +0530
Message-Id: <20200702120315.26768-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702120315.26768-1-kiran.k@intel.com>
References: <20200702120315.26768-1-kiran.k@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Make controller read vesion function more generic to support different
type of controllers.

Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Sathish Narasimman <Sathish.Narasimman@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
 drivers/bluetooth/btintel.c   | 36 ++++++++++++++----
 drivers/bluetooth/btintel.h   | 15 ++++++--
 drivers/bluetooth/btusb.c     | 71 +++++++++++++++++++++++------------
 drivers/bluetooth/hci_ag6xx.c | 12 +++++-
 drivers/bluetooth/hci_intel.c | 12 +++++-
 5 files changed, 106 insertions(+), 40 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 5fa5be3c5598..dea96c585ecb 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -204,9 +204,15 @@ void btintel_hw_error(struct hci_dev *hdev, u8 code)
 }
 EXPORT_SYMBOL_GPL(btintel_hw_error);
 
-void btintel_version_info(struct hci_dev *hdev, struct intel_version *ver)
+void btintel_version_info(struct hci_dev *hdev, const struct btintel_version *version)
 {
 	const char *variant;
+	const struct intel_version *ver;
+
+	if (version->is_tlv_supported)
+		return;
+
+	ver = &version->intel_version;
 
 	switch (ver->fw_variant) {
 	case 0x06:
@@ -335,27 +341,41 @@ int btintel_set_event_mask_mfg(struct hci_dev *hdev, bool debug)
 }
 EXPORT_SYMBOL_GPL(btintel_set_event_mask_mfg);
 
-int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver)
+int btintel_read_version(struct hci_dev *hdev, struct btintel_version *version)
 {
 	struct sk_buff *skb;
+	u8 *data, param, status, check_tlv;
+
+	if (!version)
+		return -EINVAL;
 
-	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_CMD_TIMEOUT);
+	param = 0xFF;
+
+	skb = __hci_cmd_sync(hdev, 0xfc05, 1, &param, HCI_CMD_TIMEOUT);
 	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Reading Intel version information failed (%ld)",
 			   PTR_ERR(skb));
 		return PTR_ERR(skb);
 	}
 
-	if (skb->len != sizeof(*ver)) {
-		bt_dev_err(hdev, "Intel version event size mismatch");
+	data = skb->data;
+	status = *data;
+	if (status) {
+		bt_dev_err(hdev, "Intel Read Version command failed (%02x)",
+			   status);
 		kfree_skb(skb);
-		return -EILSEQ;
+		return -bt_to_errno(status);
 	}
 
-	memcpy(ver, skb->data, sizeof(*ver));
+	check_tlv = *(data + 1);
 
+	if (skb->len == sizeof(version->intel_version) && check_tlv == 0x37) {
+		memcpy(&version->intel_version, skb->data, sizeof(version->intel_version));
+		version->is_tlv_supported = false;
+	} else {
+		version->is_tlv_supported = true;
+	}
 	kfree_skb(skb);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(btintel_read_version);
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 08e20606fb58..0865d2d4aca7 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -66,6 +66,13 @@ struct intel_debug_features {
 	__u8    page1[16];
 } __packed;
 
+struct btintel_version {
+	bool is_tlv_supported;
+	union {
+		struct intel_version intel_version; /* legacy version */
+	};
+} __packed;
+
 #if IS_ENABLED(CONFIG_BT_INTEL)
 
 int btintel_check_bdaddr(struct hci_dev *hdev);
@@ -76,13 +83,13 @@ int btintel_set_diag(struct hci_dev *hdev, bool enable);
 int btintel_set_diag_mfg(struct hci_dev *hdev, bool enable);
 void btintel_hw_error(struct hci_dev *hdev, u8 code);
 
-void btintel_version_info(struct hci_dev *hdev, struct intel_version *ver);
+void btintel_version_info(struct hci_dev *hdev, const struct btintel_version *version);
 int btintel_secure_send(struct hci_dev *hdev, u8 fragment_type, u32 plen,
 			const void *param);
 int btintel_load_ddc_config(struct hci_dev *hdev, const char *ddc_name);
 int btintel_set_event_mask(struct hci_dev *hdev, bool debug);
 int btintel_set_event_mask_mfg(struct hci_dev *hdev, bool debug);
-int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver);
+int btintel_read_version(struct hci_dev *hdev, struct btintel_version *version);
 
 struct regmap *btintel_regmap_init(struct hci_dev *hdev, u16 opcode_read,
 				   u16 opcode_write);
@@ -133,7 +140,7 @@ static inline void btintel_hw_error(struct hci_dev *hdev, u8 code)
 }
 
 static inline void btintel_version_info(struct hci_dev *hdev,
-					struct intel_version *ver)
+					struct btintel_version *version)
 {
 }
 
@@ -160,7 +167,7 @@ static inline int btintel_set_event_mask_mfg(struct hci_dev *hdev, bool debug)
 }
 
 static inline int btintel_read_version(struct hci_dev *hdev,
-				       struct intel_version *ver)
+				       struct btintel_version *version)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index faa863dd5d0a..d06c946f7810 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1938,6 +1938,7 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	const u8 *fw_ptr;
 	int disable_patch, err;
 	struct intel_version ver;
+	struct btintel_version version;
 
 	BT_DBG("%s", hdev->name);
 
@@ -1963,10 +1964,16 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	 * The returned information are hardware variant and revision plus
 	 * firmware variant, revision and build number.
 	 */
-	err = btintel_read_version(hdev, &ver);
+	err = btintel_read_version(hdev, &version);
 	if (err)
 		return err;
 
+	if (version.is_tlv_supported) {
+		bt_dev_err(hdev, "FW download in tlv format not supported");
+		return -EOPNOTSUPP;
+	}
+	ver = version.intel_version;
+
 	bt_dev_info(hdev, "read Intel version: %02x%02x%02x%02x%02x%02x%02x%02x%02x",
 		    ver.hw_platform, ver.hw_variant, ver.hw_revision,
 		    ver.fw_variant,  ver.fw_revision, ver.fw_build_num,
@@ -2049,11 +2056,11 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	/* Need build number for downloaded fw patches in
 	 * every power-on boot
 	 */
-       err = btintel_read_version(hdev, &ver);
-       if (err)
-               return err;
-       bt_dev_info(hdev, "Intel BT fw patch 0x%02x completed & activated",
-		   ver.fw_patch_num);
+	err = btintel_read_version(hdev, &version);
+	if (err)
+		return err;
+	bt_dev_info(hdev, "Intel BT fw patch 0x%02x completed & activated",
+		    version.intel_version.fw_patch_num);
 
 	goto complete;
 
@@ -2251,11 +2258,18 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 	return -EILSEQ;
 }
 
-static bool btusb_setup_intel_new_get_fw_name(struct intel_version *ver,
-					     struct intel_boot_params *params,
-					     char *fw_name, size_t len,
-					     const char *suffix)
+static bool btusb_setup_intel_new_get_fw_name(const struct btintel_version *version,
+					      struct intel_boot_params *params,
+					      char *fw_name, size_t len,
+					      const char *suffix)
 {
+	const struct intel_version *ver;
+
+	if (version->is_tlv_supported)
+		return false;
+
+	ver = &version->intel_version;
+
 	switch (ver->hw_variant) {
 	case 0x0b:	/* SfP */
 	case 0x0c:	/* WsP */
@@ -2281,18 +2295,21 @@ static bool btusb_setup_intel_new_get_fw_name(struct intel_version *ver,
 }
 
 static int btusb_intel_download_firmware(struct hci_dev *hdev,
-					 struct intel_version *ver,
+					 struct btintel_version *version,
 					 struct intel_boot_params *params)
 {
 	const struct firmware *fw;
 	u32 boot_param;
 	char fwname[64];
 	int err;
+	const struct intel_version *ver;
 	struct btusb_data *data = hci_get_drvdata(hdev);
 
-	if (!ver || !params)
+	if (!version || !params)
 		return -EINVAL;
 
+	ver = &version->intel_version;
+
 	/* The hardware platform number has a fixed value of 0x37 and
 	 * for now only accept this single value.
 	 */
@@ -2322,8 +2339,6 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 		return -EINVAL;
 	}
 
-	btintel_version_info(hdev, ver);
-
 	/* The firmware variant determines if the device is in bootloader
 	 * mode or is running operational firmware. The value 0x06 identifies
 	 * the bootloader and the value 0x23 identifies the operational
@@ -2398,7 +2413,7 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 	 * ibt-<hw_variant>-<hw_revision>-<fw_revision>.sfi.
 	 *
 	 */
-	err = btusb_setup_intel_new_get_fw_name(ver, params, fwname,
+	err = btusb_setup_intel_new_get_fw_name(version, params, fwname,
 						sizeof(fwname), "sfi");
 	if (!err) {
 		bt_dev_err(hdev, "Unsupported Intel firmware naming");
@@ -2483,6 +2498,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	unsigned long long duration;
 	int err;
 	struct intel_debug_features features;
+	struct btintel_version version;
 
 	BT_DBG("%s", hdev->name);
 
@@ -2494,21 +2510,28 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 
 	calltime = ktime_get();
 
-	/* Read the Intel version information to determine if the device
-	 * is in bootloader mode or if it already has operational firmware
-	 * loaded.
+	/* Read controller version information and support of tlv format
 	 */
-	err = btintel_read_version(hdev, &ver);
+	err = btintel_read_version(hdev, &version);
 	if (err) {
-		bt_dev_err(hdev, "Intel Read version failed (%d)", err);
+		bt_dev_err(hdev, "Intel Read version new failed (%d)", err);
 		btintel_reset_to_bootloader(hdev);
 		return err;
 	}
 
-	err = btusb_intel_download_firmware(hdev, &ver, &params);
+	if (version.is_tlv_supported) {
+		bt_dev_err(hdev, "Firmware download in tlv format is not supported");
+		return -EOPNOTSUPP;
+	}
+
+	btintel_version_info(hdev, &version);
+
+	err = btusb_intel_download_firmware(hdev, &version, &params);
 	if (err)
 		return err;
 
+	ver = version.intel_version;
+
 	/* controller is already having an operational firmware */
 	if (ver.fw_variant == 0x23)
 		goto finish;
@@ -2562,7 +2585,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 
 	clear_bit(BTUSB_BOOTLOADER, &data->flags);
 
-	err = btusb_setup_intel_new_get_fw_name(&ver, &params, ddcname,
+	err = btusb_setup_intel_new_get_fw_name(&version, &params, ddcname,
 						sizeof(ddcname), "ddc");
 
 	if (!err) {
@@ -2586,11 +2609,11 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	btintel_set_debug_features(hdev, &features);
 
 	/* Read the Intel version information after loading the FW  */
-	err = btintel_read_version(hdev, &ver);
+	err = btintel_read_version(hdev, &version);
 	if (err)
 		return err;
 
-	btintel_version_info(hdev, &ver);
+	btintel_version_info(hdev, &version);
 
 finish:
 	/* All Intel controllers that support the Microsoft vendor
diff --git a/drivers/bluetooth/hci_ag6xx.c b/drivers/bluetooth/hci_ag6xx.c
index 1f55df93e4ce..6f6a1e061972 100644
--- a/drivers/bluetooth/hci_ag6xx.c
+++ b/drivers/bluetooth/hci_ag6xx.c
@@ -153,6 +153,7 @@ static int ag6xx_setup(struct hci_uart *hu)
 	struct hci_dev *hdev = hu->hdev;
 	struct sk_buff *skb;
 	struct intel_version ver;
+	struct btintel_version version;
 	const struct firmware *fw;
 	const u8 *fw_ptr;
 	char fwname[64];
@@ -166,11 +167,18 @@ static int ag6xx_setup(struct hci_uart *hu)
 	if (err)
 		return err;
 
-	err = btintel_read_version(hdev, &ver);
+	err = btintel_read_version(hdev, &version);
 	if (err)
 		return err;
 
-	btintel_version_info(hdev, &ver);
+	if (version.is_tlv_supported) {
+		bt_dev_err(hdev, "Firmware download in tlv format over ag6xx is not supported");
+		return -EOPNOTSUPP;
+	}
+
+	btintel_version_info(hdev, &version);
+
+	ver = version.intel_version;
 
 	/* The hardware platform number has a fixed value of 0x37 and
 	 * for now only accept this single value.
diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index f1299da6eed8..f30cbc66d48f 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -532,6 +532,7 @@ static int intel_setup(struct hci_uart *hu)
 	struct hci_dev *hdev = hu->hdev;
 	struct sk_buff *skb;
 	struct intel_version ver;
+	struct btintel_version version;
 	struct intel_boot_params params;
 	struct list_head *p;
 	const struct firmware *fw;
@@ -584,10 +585,17 @@ static int intel_setup(struct hci_uart *hu)
 	 * is in bootloader mode or if it already has operational firmware
 	 * loaded.
 	 */
-	err = btintel_read_version(hdev, &ver);
+	err = btintel_read_version(hdev, &version);
 	if (err)
 		return err;
 
+	if (version.is_tlv_supported) {
+		/* firmware download in tlv format is not supported on UART transport */
+		bt_dev_err(hdev, "Firmware download in tlv format is not supported");
+		return -EOPNOTSUPP;
+	}
+	ver = version.intel_version;
+
 	/* The hardware platform number has a fixed value of 0x37 and
 	 * for now only accept this single value.
 	 */
@@ -614,7 +622,7 @@ static int intel_setup(struct hci_uart *hu)
 		return -EINVAL;
 	}
 
-	btintel_version_info(hdev, &ver);
+	btintel_version_info(hdev, &version);
 
 	/* The firmware variant determines if the device is in bootloader
 	 * mode or is running operational firmware. The value 0x06 identifies
-- 
2.17.1

