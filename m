Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE3138F226
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2026 12:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791376043; cv=none; b=VXrZw0gyfGlvVassqxx28biBSdcoPDErJDeJM6dClqNposUUTm/qr0+Wy4qn8b7cEe9rIlHv2tFWTp5akxZqRvW3PdiUqlfonSl92y6T2UeNpWWIFJMg/PTTx98bu1cUex4NZgnt8PzlH+LZBnb1ylB1dvMsLOFB29z5VRKEz8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791376043; c=relaxed/simple;
	bh=OW72klToLOtdaNERl94LmvXKi7DxGMSkcVP9y9D2WF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hD/8G+Bt/0vaOLqYiMFX7euX9p27bQGaI+OnrVfB78I5eZQvTZKamZch3hTpcmCLipSnl1drXvhgTUenApV7GHAkbc+gADfLLNy3ozrmDoijtl4yQikXfP2XAZYmMj+VT2TilvdH7gJq6HgfRmZ3Wt4/GZThykrvdeZ7OpVd6/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KkeHgS9w; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KkeHgS9w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791376033; x=1822912033;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OW72klToLOtdaNERl94LmvXKi7DxGMSkcVP9y9D2WF4=;
  b=KkeHgS9wZF0OSdRGGsco2f/hOSsnxBOvid1LL9mzV/wHIUagF+8ev7BO
   A77O6h13/QNj5pynTIm+t/SQwYRE8bpcdWssC4j90p1tgI+36qsUwgXI2
   2Z6Dh+gXNAPqwp1kPUiDJB9fKsTCE4WyUs0lbw+aEDh39wpfDX+VytIL0
   x8uqTptV8G3soW/cc/xmrEpeTZ+yRdlqieFuZ7o6GLO+pL0YqHMwPbrUh
   hcAXbjPL/YfKNe8FYu+VeqKbMcKQswe+YNJKOMbGpzY1EhEPXVGQ2+bs4
   YVjl24MgY4aa0diAG7Rq8+f+OCKJ4ngeW2UIjDxhOVuCux8d3UaHGsCCF
   A==;
X-CSE-ConnectionGUID: 6VQQ8OWlRLGeRtkMmQAraw==
X-CSE-MsgGUID: Qhev5y1WRZa+SuJTqfWWPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="19593"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="19593"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 05:27:13 -0700
X-CSE-ConnectionGUID: XKZbSNvYTwm75KG49sC3wA==
X-CSE-MsgGUID: HEwRhNN+RZKcIpMDRmE2vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="1524080"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa012.fm.intel.com with ESMTP; 07 Oct 2026 05:27:10 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>,
	Ravindra <ravindra@intel.com>
Subject: [PATCH v3] Bluetooth: btintel: load unlocker.sfi to allow unsigned firmware
Date: Wed,  7 Oct 2026 18:17:21 +0530
Message-ID: <20261007124721.2521956-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an unsigned operational firmware image is needed for debug, the
controller requires intel/unlocker.sfi to be loaded first. Without the
unlocker image, the controller rejects the unsigned operational firmware.

Support both firmware download flows based on the unlock policy advertised
in the version TLV:

  BlazarI/BlazarIW/BlazarU/Gale Peak (unlock_policy == 0):
      Boot ROM -> unlocker.sfi -> IML -> OPFW

  Scorpius Peak onwards (unlock_policy == 1):
      Boot ROM -> IML -> unlocker.sfi -> OPFW

Parse the new INTEL_TLV_UNLOCK_POLICY and INTEL_TLV_PLATFORM_ID TLVs
into struct intel_version_tlv, track the pending unlocker load through
a new btintel_data::unlocker flag, and pick intel/unlocker.sfi as the
firmware filename when that flag is set. If the unlocker image is not
present in the firmware search path, the driver silently falls through
to the normal firmware download path. If the unlocker image is present
but fails to download to the controller, the driver logs the error and
aborts bootloader setup, since continuing would leave the controller in
an inconsistent state.

[  413.375247] Bluetooth: hci0: Found device firmware: intel/unlocker.sfi
[  413.501051] Bluetooth: hci0: Waiting for firmware download to complete
[  413.501058] Bluetooth: hci0: Firmware loaded in 122864 usecs
[  413.501537] Bluetooth: hci0: Found device firmware: intel/ibt-02a2-01a1.sfi
[  413.501547] Bluetooth: hci0: Boot Address: 0x10001000
[  413.501548] Bluetooth: hci0: Firmware Version: 137-39.26
[  414.103473] Bluetooth: hci0: Waiting for firmware download to complete
[  414.103478] Bluetooth: hci0: Firmware loaded in 587841 usecs
[  414.149576] Bluetooth: hci0: Applying Intel DDC parameters completed
[  414.150089] Bluetooth: hci0: Firmware timestamp 2026.39 buildtype 3 build 86921
[  414.150092] Bluetooth: hci0: Firmware SHA1: 0xeb2e0a4b
[  414.150093] Bluetooth: hci0: Platform ID: 570c6ffbcbe6
[  414.150094] Bluetooth: hci0: Fseq status: Success (0x00)
[  414.150730] Bluetooth: hci0: Fseq executed: 15.255.00.98
[  414.150734] Bluetooth: hci0: Fseq BT Top: 06.32.00.02

Assisted-by: Copilot:Claude Opus 4.7
Signed-off-by: Ravindra <ravindra@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
changes in v3:
- Address Sashiko review comments
  https://sashiko.dev/#/patchset/20260929021056.1396791-1-kiran.k%40intel.com
changes in v2:
- Updated commit message

 drivers/bluetooth/btintel.c | 94 +++++++++++++++++++++++++++++++++++--
 drivers/bluetooth/btintel.h |  5 ++
 2 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index f298c91f4f4e..3bc59a2f3ba8 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -579,6 +579,11 @@ int btintel_version_info_tlv(struct hci_dev *hdev,
 	if (version->img_type == BTINTEL_IMG_OP)
 		bt_dev_info(hdev, "Firmware SHA1: 0x%8.8x", version->git_sha1);
 
+	if (!mem_is_zero(version->platform_id, sizeof(version->platform_id)))
+		bt_dev_info(hdev, "Platform ID: %6phN", version->platform_id);
+
+	bt_dev_info(hdev, "Unlock policy: 0x%2.2x", version->unlock_policy);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(btintel_version_info_tlv);
@@ -604,11 +609,14 @@ static u8 btintel_version_tlv_min_len(u8 type)
 	case INTEL_TLV_DEBUG_LOCK:
 	case INTEL_TLV_LIMITED_CCE:
 	case INTEL_TLV_SBE_TYPE:
+	case INTEL_TLV_UNLOCK_POLICY:
 		return sizeof(u8);
 	case INTEL_TLV_MIN_FW:
 		return 3;
 	case INTEL_TLV_OTP_BDADDR:
 		return sizeof(bdaddr_t);
+	case INTEL_TLV_PLATFORM_ID:
+		return sizeof(((struct intel_version_tlv *)0)->platform_id);
 	default:
 		return 0;
 	}
@@ -716,6 +724,13 @@ int btintel_parse_version_tlv(struct hci_dev *hdev,
 			snprintf(version->fw_id, sizeof(version->fw_id),
 				 "%.*s", tlv->len, tlv->val);
 			break;
+		case INTEL_TLV_UNLOCK_POLICY:
+			version->unlock_policy = tlv->val[0];
+			break;
+		case INTEL_TLV_PLATFORM_ID:
+			memcpy(version->platform_id, tlv->val,
+			       sizeof(version->platform_id));
+			break;
 		default:
 			/* Ignore rest of information */
 			break;
@@ -2472,7 +2487,12 @@ static int btintel_prepare_fw_download_tlv(struct hci_dev *hdev,
 		else
 			btintel_get_fw_name_tlv(ver, fwname, sizeof(fwname), "sfi");
 	} else {
-		btintel_get_fw_name_tlv(ver, fwname, sizeof(fwname), "sfi");
+		if (intel_data->unlocker) {
+			strscpy(fwname, "intel/unlocker.sfi");
+			intel_data->unlocker = false;
+		} else {
+			btintel_get_fw_name_tlv(ver, fwname, sizeof(fwname), "sfi");
+		}
 	}
 
 	err = firmware_request_nowarn(&fw, fwname, &hdev->dev);
@@ -3489,6 +3509,36 @@ static int btintel_set_specific_absorption_rate(struct hci_dev *hdev,
 	return 0;
 }
 
+/* Attempt to load intel/unlocker.sfi if it is present in the firmware
+ * search path. If the file is not available the device will be booted
+ * with a signed operational firmware, which is the common case, so its
+ * absence must be treated as normal and not logged as an error.
+ */
+static int btintel_try_load_unlocker(struct hci_dev *hdev,
+				     struct intel_version_tlv *ver)
+{
+	struct btintel_data *data = hci_get_priv(hdev);
+	const struct firmware *fw;
+	u32 boot_param = 0;
+	int err;
+
+	err = firmware_request_nowarn(&fw, "intel/unlocker.sfi", &hdev->dev);
+	if (err) {
+		bt_dev_dbg(hdev, "intel/unlocker.sfi not present (%d), skipping unlocker load",
+			   err);
+		return 0;
+	}
+	release_firmware(fw);
+
+	data->unlocker = true;
+	err = btintel_prepare_fw_download_tlv(hdev, ver, &boot_param);
+	if (err) {
+		bt_dev_err(hdev, "Failed to load intel/unlocker.sfi (%d)", err);
+		data->unlocker = false;
+	}
+	return err;
+}
+
 int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 				 struct intel_version_tlv *ver)
 {
@@ -3496,6 +3546,8 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 	char ddcname[64];
 	int err;
 	struct intel_version_tlv new_ver;
+	struct btintel_data *data = hci_get_priv(hdev);
+	u8 hw_variant = INTEL_HW_VARIANT(ver->cnvi_bt);
 
 	bt_dev_dbg(hdev, "");
 
@@ -3514,6 +3566,31 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 
 	btintel_set_flag(hdev, INTEL_BOOTLOADER);
 
+	data->unlocker = false;
+
+	/* Legacy unlocker flow (BlazarI / BlazarIW / BlazarU / Gale Peak):
+	 * Boot ROM -> unlocker.sfi -> IML -> OPFW
+	 *
+	 * Skip the unlocker check when the controller is already running
+	 * operational firmware (can happen on USB); the unlocker flow is
+	 * only meaningful from the bootloader stage.
+	 */
+	if (ver->img_type != BTINTEL_IMG_OP &&
+	    ver->api_lock && ver->unlock_policy == 0) {
+		switch (hw_variant) {
+		case BTINTEL_HWID_BZRI:
+		case BTINTEL_HWID_BZRIW:
+		case BTINTEL_HWID_BZRU:
+		case BTINTEL_HWID_GAP:
+			err = btintel_try_load_unlocker(hdev, ver);
+			if (err)
+				return err;
+			break;
+		default:
+			break;
+		}
+	}
+
 	err = btintel_prepare_fw_download_tlv(hdev, ver, &boot_param);
 	if (err)
 		return err;
@@ -3537,8 +3614,19 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 		return err;
 	}
 
-	/* If image type returned is BTINTEL_IMG_IML, then controller supports
-	 * intermediate loader image
+	/* New unlocker flow (Scorpius Peak onwards):
+	 * Boot ROM -> IML -> unlocker.sfi -> OPFW
+	 */
+	if (hw_variant >= BTINTEL_HWID_SCP &&
+	    ver->api_lock && ver->unlock_policy == 1) {
+		err = btintel_try_load_unlocker(hdev, ver);
+		if (err)
+			return err;
+	}
+
+	/* Transition to Operational Firmware
+	 * If image type returned is BTINTEL_IMG_IML, then controller supports
+	 * intermediate loader image.
 	 */
 	if (ver->img_type == BTINTEL_IMG_IML) {
 		err = btintel_prepare_fw_download_tlv(hdev, ver, &boot_param);
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index ff7c1d623007..9526acf65959 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -43,6 +43,8 @@ enum {
 	INTEL_TLV_OTP_BDADDR,
 	INTEL_TLV_UNLOCKED_STATE,
 	INTEL_TLV_GIT_SHA1,
+	INTEL_TLV_UNLOCK_POLICY = 0x3c,
+	INTEL_TLV_PLATFORM_ID = 0x3d,
 	INTEL_TLV_FW_ID = 0x50
 };
 
@@ -108,6 +110,8 @@ struct intel_version_tlv {
 	u32	git_sha1;
 	u8	fw_id[BTINTEL_FWID_MAXLEN];
 	bdaddr_t otp_bd_addr;
+	u8	unlock_policy;
+	u8	platform_id[6];
 };
 
 struct intel_version {
@@ -261,6 +265,7 @@ struct btintel_data {
 	DECLARE_BITMAP(flags, __INTEL_NUM_FLAGS);
 	int (*acpi_reset_method)(struct hci_dev *hdev);
 	u32 cnvi_bt;
+	bool	unlocker;
 };
 
 #define btintel_set_flag(hdev, nr)					\
-- 
2.54.0

