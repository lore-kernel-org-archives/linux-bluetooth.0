Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E50F134AB
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 08:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710145965; cv=none; b=hMz8IroKmFCgV+3CN8J8CvIaiFC76JQvvEIcTAs42mtaYkEa28+i90IiENruy+KHfJHUsUfVNLvMmJfqd/nlC6gYrIL5SMNPc3XzR5M2qd4aexSBQn9sqJLkVgWvkr8bdIwv61NNYiAC4T2nVZ1qt8b5chwwFQMCg/zU/ZAJka8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710145965; c=relaxed/simple;
	bh=pu9k6Eldd+MPhU0XJjYhdafbK7zhZ4wPgH85YbAGgeo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nNt3xnkJEUhhBbo+QjCoqGJfNgV58gJcSfcduX2C2NQIRnF0bP//LCQ8rICM6LsURyviLVbmrWHatRkaJuwWcta1eN40I2luOqzhyhDEFdBDGazaKazYbk9/oOiFU1hqUF4CHLVTBCFWj86zVCK8DMCIHpmme3o+ec9aaj/7TKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hA9ujoaJ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hA9ujoaJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710145963; x=1741681963;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pu9k6Eldd+MPhU0XJjYhdafbK7zhZ4wPgH85YbAGgeo=;
  b=hA9ujoaJPc0zyvYr2NRFZdd6lAG5oZmOFD66lVuEINL7ZH4aj1l+gQu+
   XORI5l6YmXhyk+O/yeEyaE+eNJg1GfJyjNYq0OvRmY+MV6NNHAmI24ge2
   XZi564BRzH6jYFOdONmZ7+ZN1yfA7igAKMfETdlDMfoMOuS8ucCky+jKb
   wOdLkVMAMGG0/71tRCVscPMWM4SL4E4IMJhaLhTacUQ0qXwmr7/ddms8U
   Gd0DlbZVo5sV7aXfK7IU0hsNWmjs9VXRCQ56HAFR4TECPcFfKBT+lYin2
   1PdH49o7zXyr4T43Ty7kIiYD+XkKopZqjcx7jg1gZTI6m0i+odu3fnoCl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="4645341"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="4645341"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 01:32:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="15692853"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa004.fm.intel.com with ESMTP; 11 Mar 2024 01:32:41 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v5 1/2] Bluetooth: btintel: Define macros for image types
Date: Mon, 11 Mar 2024 14:16:25 +0530
Message-Id: <20240311084626.402325-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use macro for image type instead of using hard code number.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 12 ++++++------
 drivers/bluetooth/btintel.h |  3 +++
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 6ba7f5d1b837..2abe75f06e9c 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -489,7 +489,7 @@ static int btintel_version_info_tlv(struct hci_dev *hdev,
 	}
 
 	switch (version->img_type) {
-	case 0x01:
+	case BTINTEL_IMG_BOOTLOADER:
 		variant = "Bootloader";
 		/* It is required that every single firmware fragment is acknowledged
 		 * with a command complete event. If the boot parameters indicate
@@ -521,7 +521,7 @@ static int btintel_version_info_tlv(struct hci_dev *hdev,
 			    version->min_fw_build_nn, version->min_fw_build_cw,
 			    2000 + version->min_fw_build_yy);
 		break;
-	case 0x03:
+	case BTINTEL_IMG_OP:
 		variant = "Firmware";
 		break;
 	default:
@@ -535,7 +535,7 @@ static int btintel_version_info_tlv(struct hci_dev *hdev,
 	bt_dev_info(hdev, "%s timestamp %u.%u buildtype %u build %u", variant,
 		    2000 + (version->timestamp >> 8), version->timestamp & 0xff,
 		    version->build_type, version->build_num);
-	if (version->img_type == 0x03)
+	if (version->img_type == BTINTEL_IMG_OP)
 		bt_dev_info(hdev, "Firmware SHA1: 0x%8.8x", version->git_sha1);
 
 	return 0;
@@ -1172,7 +1172,7 @@ static int btintel_download_fw_tlv(struct hci_dev *hdev,
 	 * If the firmware version has changed that means it needs to be reset
 	 * to bootloader when operational so the new firmware can be loaded.
 	 */
-	if (ver->img_type == 0x03)
+	if (ver->img_type == BTINTEL_IMG_OP)
 		return -EINVAL;
 
 	/* iBT hardware variants 0x0b, 0x0c, 0x11, 0x12, 0x13, 0x14 support
@@ -2230,7 +2230,7 @@ static int btintel_prepare_fw_download_tlv(struct hci_dev *hdev,
 	 * It is not possible to use the Secure Boot Parameters in this
 	 * case since that command is only available in bootloader mode.
 	 */
-	if (ver->img_type == 0x03) {
+	if (ver->img_type == BTINTEL_IMG_OP) {
 		btintel_clear_flag(hdev, INTEL_BOOTLOADER);
 		btintel_check_bdaddr(hdev);
 	} else {
@@ -2600,7 +2600,7 @@ static int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 		return err;
 
 	/* check if controller is already having an operational firmware */
-	if (ver->img_type == 0x03)
+	if (ver->img_type == BTINTEL_IMG_OP)
 		goto finish;
 
 	err = btintel_boot(hdev, boot_param);
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index d19fcdb9ff0b..d961a33bfbd6 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -51,6 +51,9 @@ struct intel_tlv {
 	u8 val[];
 } __packed;
 
+#define BTINTEL_IMG_BOOTLOADER		0x01	/* Bootloader image */
+#define BTINTEL_IMG_OP			0x03	/* Operational image */
+
 struct intel_version_tlv {
 	u32	cnvi_top;
 	u32	cnvr_top;
-- 
2.34.1

