Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228DE811E7
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2024 09:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718790922; cv=none; b=YlKntfztp5yjpLnYwC9ODa8KyWfo4jthbCreuPMlaZV3ZVJz0oKGoAHZCyGFOE7jxatVZNDKptQqcwdt3it/KJ3y412APq5Iyi73zxulBxZLaPFAN3SIWTuND8TmigZ1fIcshY5U4IrQQ+w0hO2HJbG96kLXt5e1iJfF70aGfBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718790922; c=relaxed/simple;
	bh=GD1Zhw5MBQeCNEG84zzu1wlZymB4jmQbBCM0dT5fpA8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GSbaG8pVl6hKhkPpgi/CPnvggrFn9YB9EMlda/To25Ng2scPlnzgA9AKwskO5ygWTX7yd6E5nFdBdKnmyqQ6xPFkMLfWtdLMYT5q6JG4hrBZFnFEzC7NAAlLih/RHBiNYp4uZiT4KmzX8CVuh22858H7VH46YQOljM5honaaVKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K4OnFb7X; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K4OnFb7X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718790920; x=1750326920;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GD1Zhw5MBQeCNEG84zzu1wlZymB4jmQbBCM0dT5fpA8=;
  b=K4OnFb7X0bYsXk2Ii61QgezKVs/YiRdlSwm9XYcERetHXVXeWlvtY9KS
   tYk3u+OyTG8k5n9Q4/2pLAd2ImD4//VKx9xkf4qyFq4qbezuC+XGacHbK
   Jc0EQPQDB+ATgSK2gmO3GJZ+WzDOcOtdSvKJySqWnjpKFW31FFxH0s038
   WU164AVdemoOTLG/rHtJltD/xLIwtsgHeJ9hBXCWxMSZMpLhn9YjfwttM
   qD2qdRx/XRSYOxjaq6ydKpE8ta+mzfzfTJH2N+htS0svmZ02ddhwK0+Gs
   ncYmsgAE+6otqrYkwDqGAfMZi4Ahzo3Dvmy6AigeVxSAdLFr6lhIwlL12
   Q==;
X-CSE-ConnectionGUID: Iz8kxDzjQVecwmt6OnDI3w==
X-CSE-MsgGUID: 3vdad21MS3+WV1wBG9Qiow==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15837806"
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208,223";a="15837806"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 02:55:20 -0700
X-CSE-ConnectionGUID: JB1ZUDnBTNiHP1xnqfxUEg==
X-CSE-MsgGUID: k37nefqTRwuNTmdIzW49mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208,223";a="72605809"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa002.jf.intel.com with ESMTP; 19 Jun 2024 02:55:18 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	vijay.satija@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel: Add firmware ID to firmware name
Date: Wed, 19 Jun 2024 15:39:33 +0530
Message-Id: <20240619100933.2054286-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From BlazarI onwards, driver shall append the firmware ID (usually
represents transport type) while constructing the firmware name.
Firmware ID is returned on Intel Read Version command.

The new firmware file name for operational image and ddc file shall be,
ibt-<cnvi_top type+cnvi_top step>-<cnvr_top type+cnvr_top step-fw_id>.[sfi|ddc]

dmesg snippet from BlazarI pcie  product:

......

[17.098858] Bluetooth: hci0: Found device firmware: intel/ibt-0190-0291-pci.sfi
[17.098871] Bluetooth: hci0: Boot Address: 0x10000800
[17.098872] Bluetooth: hci0: Firmware Version: 214-25.24
[17.158229] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[17.158236] Bluetooth: BNEP filters: protocol multicast
[17.158241] Bluetooth: BNEP socket layer initialized
[17.468789] Bluetooth: hci0: Waiting for firmware download to complete
[17.468793] Bluetooth: hci0: Firmware loaded in 361262 usecs
[17.468872] Bluetooth: hci0: Waiting for device to boot
[17.504148] Bluetooth: hci0: Device booted in 34512 usecs
[17.504148] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
[17.504682] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-0190-0291-pci.ddc
[17.505380] Bluetooth: hci0: Applying Intel DDC parameters completed
[17.505622] Bluetooth: hci0: Firmware timestamp 2024.25 buildtype 3 build 64726
[17.505624] Bluetooth: hci0: Firmware SHA1: 0x9f4adddc
[17.505838] Bluetooth: hci0: Fseq status: Success (0x00)
[17.505839] Bluetooth: hci0: Fseq executed: 00.00.04.183
[17.505840] Bluetooth: hci0: Fseq BT Top: 00.00.04.183

dmesg snippet from BlazarI usb product:

.......

[14.212072] Bluetooth: hci0: Found device firmware: intel/ibt-0190-0291-usb.sfi
[14.212091] Bluetooth: hci0: Boot Address: 0x10000800
[14.212093] Bluetooth: hci0: Firmware Version: 79-21.24
[14.262125] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[14.262129] Bluetooth: BNEP filters: protocol multicast
[14.262133] Bluetooth: BNEP socket layer initialized
[15.865421] Bluetooth: hci0: Waiting for firmware download to complete
[15.865991] Bluetooth: hci0: Firmware loaded in 1615150 usecs
[15.866017] Bluetooth: hci0: Waiting for device to boot
[15.899934] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
[15.899942] Bluetooth: hci0: Device booted in 33139 usecs
[15.900172] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-0190-0291-usb.ddc
[15.901928] Bluetooth: hci0: Applying Intel DDC parameters completed
[15.904993] Bluetooth: hci0: Firmware timestamp 2024.21 buildtype 3 build 63311
[15.904996] Bluetooth: hci0: Firmware SHA1: 0x8b217cf7
[15.908929] Bluetooth: hci0: Fseq status: Success (0x00)
[15.908934] Bluetooth: hci0: Fseq executed: 00.00.04.180
[15.908935] Bluetooth: hci0: Fseq BT Top: 00.00.04.180

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 88 ++++++++++++++++++++++++++++---------
 drivers/bluetooth/btintel.h |  6 ++-
 2 files changed, 73 insertions(+), 21 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index ff33e1aa2929..5d735391545a 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -631,6 +631,10 @@ int btintel_parse_version_tlv(struct hci_dev *hdev,
 		case INTEL_TLV_GIT_SHA1:
 			version->git_sha1 = get_unaligned_le32(tlv->val);
 			break;
+		case INTEL_TLV_FW_ID:
+			snprintf(version->fw_id, sizeof(version->fw_id),
+				 "%s", tlv->val);
+			break;
 		default:
 			/* Ignore rest of information */
 			break;
@@ -2133,30 +2137,61 @@ static void btintel_get_fw_name_tlv(const struct intel_version_tlv *ver,
 				    const char *suffix)
 {
 	const char *format;
-	/* The firmware file name for new generation controllers will be
-	 * ibt-<cnvi_top type+cnvi_top step>-<cnvr_top type+cnvr_top step>
-	 */
-	switch (ver->cnvi_top & 0xfff) {
+	u32 cnvi, cnvr;
+
+	cnvi = INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver->cnvi_top),
+					INTEL_CNVX_TOP_STEP(ver->cnvi_top));
+
+	cnvr = INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver->cnvr_top),
+					INTEL_CNVX_TOP_STEP(ver->cnvr_top));
+
 	/* Only Blazar  product supports downloading of intermediate loader
 	 * image
 	 */
-	case BTINTEL_CNVI_BLAZARI:
-		if (ver->img_type == BTINTEL_IMG_BOOTLOADER)
+	if ((ver->cnvi_top & 0xfff) >= BTINTEL_CNVI_BLAZARI) {
+		u8 zero[BTINTEL_FWID_MAXLEN];
+
+		if (ver->img_type == BTINTEL_IMG_BOOTLOADER) {
 			format = "intel/ibt-%04x-%04x-iml.%s";
-		else
-			format = "intel/ibt-%04x-%04x.%s";
-		break;
-	default:
-			format = "intel/ibt-%04x-%04x.%s";
-		break;
+			snprintf(fw_name, len, format, cnvi, cnvr, suffix);
+			return;
+		}
+
+		memset(zero, 0, sizeof(zero));
+
+		/* ibt-<cnvi_top type+cnvi_top step>-<cnvr_top type+cnvr_top step-fw_id> */
+		if (memcmp(ver->fw_id, zero, sizeof(zero))) {
+			format = "intel/ibt-%04x-%04x-%s.%s";
+			snprintf(fw_name, len, format, cnvi, cnvr,
+				 ver->fw_id, suffix);
+			return;
+		}
+		/* If firmware id is not present, fallback to legacy naming
+		 * convention
+		 */
 	}
+	/* Fallback to legacy naming convention for other controllers
+	 * ibt-<cnvi_top type+cnvi_top step>-<cnvr_top type+cnvr_top step>
+	 */
+	format = "intel/ibt-%04x-%04x.%s";
+	snprintf(fw_name, len, format, cnvi, cnvr, suffix);
+}
+
+static void btintel_get_iml_tlv(const struct intel_version_tlv *ver,
+				char *fw_name, size_t len,
+				const char *suffix)
+{
+	const char *format;
+	u32 cnvi, cnvr;
+
+	cnvi = INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver->cnvi_top),
+					INTEL_CNVX_TOP_STEP(ver->cnvi_top));
 
-	snprintf(fw_name, len, format,
-		 INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver->cnvi_top),
-					  INTEL_CNVX_TOP_STEP(ver->cnvi_top)),
-		 INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver->cnvr_top),
-					  INTEL_CNVX_TOP_STEP(ver->cnvr_top)),
-		 suffix);
+	cnvr = INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver->cnvr_top),
+					INTEL_CNVX_TOP_STEP(ver->cnvr_top));
+
+	format = "intel/ibt-%04x-%04x-iml.%s";
+	snprintf(fw_name, len, format, cnvi, cnvr, suffix);
 }
 
 static int btintel_prepare_fw_download_tlv(struct hci_dev *hdev,
@@ -2164,7 +2199,7 @@ static int btintel_prepare_fw_download_tlv(struct hci_dev *hdev,
 					   u32 *boot_param)
 {
 	const struct firmware *fw;
-	char fwname[64];
+	char fwname[128];
 	int err;
 	ktime_t calltime;
 
@@ -2199,7 +2234,20 @@ static int btintel_prepare_fw_download_tlv(struct hci_dev *hdev,
 		}
 	}
 
-	btintel_get_fw_name_tlv(ver, fwname, sizeof(fwname), "sfi");
+	if (ver->img_type == BTINTEL_IMG_OP) {
+		/* Controller running OP image. In case of FW downgrade,
+		 * FWID TLV may not be present and driver may attempt to load
+		 * firmware image which doesn't exist. Lets compare the version
+		 * of IML image
+		 */
+		if ((ver->cnvi_top & 0xfff) >= BTINTEL_CNVI_BLAZARI)
+			btintel_get_iml_tlv(ver, fwname, sizeof(fwname), "sfi");
+		else
+			btintel_get_fw_name_tlv(ver, fwname, sizeof(fwname), "sfi");
+	} else {
+		btintel_get_fw_name_tlv(ver, fwname, sizeof(fwname), "sfi");
+	}
+
 	err = firmware_request_nowarn(&fw, fwname, &hdev->dev);
 	if (err < 0) {
 		if (!btintel_test_flag(hdev, INTEL_BOOTLOADER)) {
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 9dbad1a7c47c..aa70e4c27416 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -42,7 +42,8 @@ enum {
 	INTEL_TLV_SBE_TYPE,
 	INTEL_TLV_OTP_BDADDR,
 	INTEL_TLV_UNLOCKED_STATE,
-	INTEL_TLV_GIT_SHA1
+	INTEL_TLV_GIT_SHA1,
+	INTEL_TLV_FW_ID = 0x50
 };
 
 struct intel_tlv {
@@ -57,6 +58,8 @@ struct intel_tlv {
 #define BTINTEL_IMG_IML			0x02	/* Intermediate image */
 #define BTINTEL_IMG_OP			0x03	/* Operational image */
 
+#define BTINTEL_FWID_MAXLEN 64
+
 struct intel_version_tlv {
 	u32	cnvi_top;
 	u32	cnvr_top;
@@ -77,6 +80,7 @@ struct intel_version_tlv {
 	u8	limited_cce;
 	u8	sbe_type;
 	u32	git_sha1;
+	u8	fw_id[BTINTEL_FWID_MAXLEN];
 	bdaddr_t otp_bd_addr;
 };
 
-- 
2.40.1

