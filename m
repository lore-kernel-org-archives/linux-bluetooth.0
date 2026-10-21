Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792586657;
	b=Wlsibxbyzy1seTF/OeE6RA4UhQRmZqncy8eS51R9ADE9lodcbnHsRAQ4q1b0PPQqwSlw
	 HLcFrydLb5JHaGGN4r7qqvpzIkiWCJ9GipnesnQyv8tFVFGr22IBP3QTKJuETdCIHXuch
	 uJPETfxCMnsF5QPqv+hv6qAKdfahJoDuD1BVXKnnKmNwkx4U7eER5xmitqThBFQPFY2PX
	 owjz78OQ4iZzw72ssMGPwrw1zJuDzUoVoMCL3dcisTgYFK7cf3ysq0iJeShbWm9kF2Q7P
	 Tt3Qi0F/+ErKkBG2ivhvnU/D0svlGc1gc5Uj12SJl7DmEWAN8tqdlQrOt0s3KG1/zEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586657;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=+ktZJnkfh9zHdZjz8vvQumSoqSoZNp6WgwE/N/5ViG8=;
	b=iqY3ffuSUR5lkoSn0E0lBrievb4CEPb0VNTpMJzRZDl6oqynUO2xEYFys7dTPteWStj1
	 U5YX/VsUPhhmSSiv8bZvbo5iFP/YuDzuRZQwWo/9iuTwXWixcl9tSueuOgfS3Y6czHsoE
	 LqsG3myLKTrJpZanfqDaw6ub1WxUxOb6WsUehWtrxPA+nRcB7WloGaLOhCaPoZ376zdP9
	 3PI/LIzWrU5uOkhPOlJ2KcOdV+rC8CarirYfKiMYacaGd5RoUiASUtlrvt4ygaKetmvgN
	 ZrQO/hGD29DQAct0G+9KKQ/nuDIwZW/LyKHMj6gjwN6/F8VDFkx6/SznXHYREnvPlNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZscicndX;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618D5606A32A
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 12:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 618D5606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZscicndX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792586655; x=1824122655;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7hIXUyRPCGbZ/1AZhIUrwiZvUt7uvBWsMUOAec0fk68=;
  b=ZscicndXgU8KhcOAECk73ZKW8bP+Z64fxDUwwzWgVXaUbFt5RXOmi9dh
   7gFUHlRmzsan+XUHQF6kIeDoFJBb7gVy+4zI6ZuWyqFPGjs4bXz5bkT1+
   5ZDdzyAu7G00+s8N9oUB1vJT6RjMha64KBq4DMXpI5pyje9/FcInCSwSq
   5TvEYJClnxmQi8dZoaGglxxPyTb9u1H7sC1SPT+Uc52Ittd/WETcH9a0j
   tRhpIVNeJS40Df7OceKzihRTGdPupLXcBb32rBKpT7C7kcNIM1gJ6729P
   As/T2+OTm+vwi6tGO32y62k9RPZV+YpH0Rnp1/LpAkVpRzlEPA+KnNODE
   g==;
X-CSE-ConnectionGUID: 2UI1HXlZQl+/n908XdkiMQ==
X-CSE-MsgGUID: WCxlpzYlR9itfk5CPJFJ4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1319529"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1319529"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 05:44:15 -0700
X-CSE-ConnectionGUID: ig7pmxFQQXOoVUg5RAZflg==
X-CSE-MsgGUID: BaOcdBIDT2uEyrSmog9dwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3136739"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa006.jf.intel.com with ESMTP; 21 Oct 2026 05:44:13 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel: check FIPS status before firmware download
Date: Wed, 21 Oct 2026 18:34:24 +0530
Message-ID: <20261021130424.3042597-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel Bluetooth controllers (PCIe and USB) from Scorpius Peak2 onwards
report bootloader self-test results (CRC, security, patch) in the
INTEL_TLV_FIPS_STS TLV of the Intel Read Version event. Act on them
before firmware download:

  1. CRC failure      -> abort download.
  2. Security failure -> abort on USB / HW reset and retry on PCIe.
  3. Patch failure    -> abort on USB / HW reset and retry on PCIe.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c      | 66 +++++++++++++++++++++++++++++++-
 drivers/bluetooth/btintel.h      | 10 +++++
 drivers/bluetooth/btintel_pcie.c | 18 ++++++++-
 3 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 0709fb3212f9..f6deb3d7c5a0 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -485,10 +485,18 @@ int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver)
 }
 EXPORT_SYMBOL_GPL(btintel_read_version);
 
+/* FIPS self-test status is only reported by ScP2 onwards, except BlazarIW */
+static bool btintel_fips_status_supported(u8 hw_variant)
+{
+	return hw_variant >= BTINTEL_HWID_SCP2 && hw_variant != BTINTEL_HWID_BZRIW;
+}
+
 int btintel_version_info_tlv(struct hci_dev *hdev,
 			     struct intel_version_tlv *version)
 {
 	const char *variant;
+	bool fips_status = false;
+	u8 hw_variant;
 
 	/* The hardware platform number has a fixed value of 0x37 and
 	 * for now only accept this single value.
@@ -505,7 +513,8 @@ int btintel_version_info_tlv(struct hci_dev *hdev,
 	 * This check has been put in place to ensure correct forward
 	 * compatibility options when newer hardware variants come along.
 	 */
-	switch (INTEL_HW_VARIANT(version->cnvi_bt)) {
+	hw_variant = INTEL_HW_VARIANT(version->cnvi_bt);
+	switch (hw_variant) {
 	case 0x17:	/* TyP */
 	case 0x18:	/* Slr */
 	case 0x19:	/* Slr-F */
@@ -521,10 +530,13 @@ int btintel_version_info_tlv(struct hci_dev *hdev,
 		break;
 	default:
 		bt_dev_err(hdev, "Unsupported Intel hardware variant (0x%x)",
-			   INTEL_HW_VARIANT(version->cnvi_bt));
+			   hw_variant);
 		return -EINVAL;
 	}
 
+	fips_status = btintel_fips_status_supported(hw_variant) &&
+		version->img_type == BTINTEL_IMG_BOOTLOADER;
+
 	switch (version->img_type) {
 	case BTINTEL_IMG_BOOTLOADER:
 		variant = "Bootloader";
@@ -584,6 +596,9 @@ int btintel_version_info_tlv(struct hci_dev *hdev,
 
 	bt_dev_info(hdev, "Unlock policy: 0x%2.2x", version->unlock_policy);
 
+	if (fips_status)
+		bt_dev_info(hdev, "crc status: %u security status: %u patch status: %u",
+			    version->crc_sts, version->sec_sts, version->patch_sts);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(btintel_version_info_tlv);
@@ -612,6 +627,7 @@ static u8 btintel_version_tlv_min_len(u8 type)
 	case INTEL_TLV_UNLOCK_POLICY:
 		return sizeof(u8);
 	case INTEL_TLV_MIN_FW:
+	case INTEL_TLV_FIPS_STS:
 		return 3;
 	case INTEL_TLV_OTP_BDADDR:
 		return sizeof(bdaddr_t);
@@ -720,6 +736,11 @@ int btintel_parse_version_tlv(struct hci_dev *hdev,
 		case INTEL_TLV_GIT_SHA1:
 			version->git_sha1 = get_unaligned_le32(tlv->val);
 			break;
+		case INTEL_TLV_FIPS_STS:
+			version->crc_sts = tlv->val[0];
+			version->sec_sts = tlv->val[1];
+			version->patch_sts = tlv->val[2];
+			break;
 		case INTEL_TLV_FW_ID:
 			snprintf(version->fw_id, sizeof(version->fw_id),
 				 "%.*s", tlv->len, tlv->val);
@@ -3831,6 +3852,43 @@ void btintel_print_fseq_info(struct hci_dev *hdev)
 }
 EXPORT_SYMBOL_GPL(btintel_print_fseq_info);
 
+int btintel_check_fips_status(struct hci_dev *hdev,
+			      struct intel_version_tlv *ver)
+{
+	u8 hw_variant;
+
+	/* FIPS status is reported only in the bootloader image */
+	if (ver->img_type != BTINTEL_IMG_BOOTLOADER)
+		return 0;
+
+	hw_variant = INTEL_HW_VARIANT(ver->cnvi_bt);
+
+	if (!btintel_fips_status_supported(hw_variant))
+		return 0;
+
+	/* 0 -> Test not executed
+	 * 1 -> Test executed and it passed
+	 * any other value -> Test failed
+	 */
+	if (ver->crc_sts > 1) {
+		bt_dev_err(hdev, "crc test failed: %u", ver->crc_sts);
+		return -ENOEXEC;
+	}
+
+	if (ver->sec_sts > 1) {
+		bt_dev_err(hdev, "security test failed: %u", ver->sec_sts);
+		return -EAGAIN;
+	}
+
+	if (ver->patch_sts > 1) {
+		bt_dev_err(hdev, "patch test failed: %u", ver->patch_sts);
+		return -EAGAIN;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btintel_check_fips_status);
+
 static int btintel_setup_combined(struct hci_dev *hdev)
 {
 	const u8 param[1] = { 0xFF };
@@ -4055,6 +4113,10 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		/* Display version information of TLV type */
 		btintel_version_info_tlv(hdev, &ver_tlv);
 
+		err = btintel_check_fips_status(hdev, &ver_tlv);
+		if (err)
+			goto exit_error;
+
 		/* Apply the device specific HCI quirks for TLV based devices
 		 *
 		 * All TLV based devices support WBS
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 9526acf65959..d5e125ec5168 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -43,6 +43,7 @@ enum {
 	INTEL_TLV_OTP_BDADDR,
 	INTEL_TLV_UNLOCKED_STATE,
 	INTEL_TLV_GIT_SHA1,
+	INTEL_TLV_FIPS_STS = 0x3b,
 	INTEL_TLV_UNLOCK_POLICY = 0x3c,
 	INTEL_TLV_PLATFORM_ID = 0x3d,
 	INTEL_TLV_FW_ID = 0x50
@@ -112,6 +113,7 @@ struct intel_version_tlv {
 	bdaddr_t otp_bd_addr;
 	u8	unlock_policy;
 	u8	platform_id[6];
+	u8	crc_sts, sec_sts, patch_sts;
 };
 
 struct intel_version {
@@ -331,6 +333,8 @@ int btintel_shutdown_combined(struct hci_dev *hdev);
 void btintel_hw_error(struct hci_dev *hdev, u8 code);
 void btintel_print_fseq_info(struct hci_dev *hdev);
 int btintel_acpi_reset_method(struct hci_dev *hdev);
+int btintel_check_fips_status(struct hci_dev *hdev,
+			      struct intel_version_tlv *ver);
 #else
 
 static inline int btintel_check_bdaddr(struct hci_dev *hdev)
@@ -468,4 +472,10 @@ static inline int btintel_acpi_reset_method(struct hci_dev *hdev)
 {
 	return -ENODEV;
 }
+
+static inline int btintel_check_fips_status(struct hci_dev *hdev,
+					    struct intel_version_tlv *ver)
+{
+	return -EOPNOTSUPP;
+}
 #endif
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index df95d16a163c..73822ba2acbb 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -3786,7 +3786,8 @@ static int btintel_pcie_get_debug_info_addr(struct hci_dev *hdev)
 	return err;
 }
 
-static int btintel_pcie_setup_internal(struct hci_dev *hdev)
+static int btintel_pcie_setup_internal(struct hci_dev *hdev,
+				       bool *fips_crc_failed)
 {
 	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
 	const u8 param[1] = { 0xFF };
@@ -3794,6 +3795,8 @@ static int btintel_pcie_setup_internal(struct hci_dev *hdev)
 	struct sk_buff *skb;
 	int err;
 
+	*fips_crc_failed = false;
+
 	BT_DBG("%s", hdev->name);
 
 	skb = __hci_cmd_sync(hdev, 0xfc05, 1, param, HCI_CMD_TIMEOUT);
@@ -3855,6 +3858,12 @@ static int btintel_pcie_setup_internal(struct hci_dev *hdev)
 		/* Display version information of TLV type */
 		btintel_version_info_tlv(hdev, &ver_tlv);
 
+		err = btintel_check_fips_status(hdev, &ver_tlv);
+		if (err) {
+			*fips_crc_failed = (err == -ENOEXEC);
+			goto exit_error;
+		}
+
 		/* Apply the device specific HCI quirks for TLV based devices
 		 *
 		 * All TLV based devices support WBS
@@ -3900,8 +3909,13 @@ static int btintel_pcie_setup(struct hci_dev *hdev)
 {
 	int err, fw_dl_retry = 0;
 	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
+	bool fips_crc_failed;
+
+	while ((err = btintel_pcie_setup_internal(hdev, &fips_crc_failed)) &&
+	       fw_dl_retry++ < 1) {
+		if (fips_crc_failed)
+			break;
 
-	while ((err = btintel_pcie_setup_internal(hdev)) && fw_dl_retry++ < 1) {
 		bt_dev_err(hdev, "Firmware download retry count: %d",
 			   fw_dl_retry);
 		btintel_pcie_dump_debug_registers(hdev);
-- 
2.54.0

