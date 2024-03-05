Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA20EC2
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Mar 2024 14:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709649092; cv=none; b=mIABNYXB/9fTZTsAA7+ewRwiw1M+fbmZxQawYS9uulUnWw0vfjNyLl9FwUmhvfHCjX/q8cMznGMOKZDt3mjN7cmHyh39LaboEPDqMWVCRPsH4Tz1PZcp9xZuc3qCRBgzILKhKEtmaAU2gIqel3Gda1AxRlekzXxSH3risfNXWX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709649092; c=relaxed/simple;
	bh=jekZIpLj45/hKf2Ja13i6zhfqktp0jCtzRcKlnG2jUw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j6vL8JRxNMjUV/HvaLfQlMjC6dLUFZNeGPC242xQZTkYuREeoA7R450ZjfibeOPJMINU2GQNvrt9l/Scof7+XRDIGbvtYcXC85Bx9vfobe7R3mRC4G+jJ6G6yz8VHkg3D3kYL9qylmCoB4jH1obevwt858F6mzOou6Vgt0FnTZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rm/fxQuu; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rm/fxQuu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709649090; x=1741185090;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jekZIpLj45/hKf2Ja13i6zhfqktp0jCtzRcKlnG2jUw=;
  b=Rm/fxQuudDJBFhcGQlsR/Zj2lMCwKn+1MO2uLpSO4DhqzNKufx+E1hOl
   7UZoqToBB31gTwxqX6MlPkTsJYY3RUByCYmMQEeJy5mr7Kubnn7V3W6vk
   fILmaSD4RLjZlYKCJ5ja+3NaEP1i+CfOzSBvcUFDRPAhNfK4umNYsE1A+
   ZYSWtx3sQO2v24W/vnFKy88NQ4CljXbtyP3uYY9Ls/5OL/ixa2Ot1tmvx
   1jTu8FlfIaA3ofXftMHhTTQ4KuBSCWor+qf5dqy8RZZKzsqGcEovCvMzc
   X7TJ75E8JHTXiEoxIrnes4NT68tBgLPjZV8rEqXuL+zs9rjeVeGMObRK5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="21727604"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="21727604"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 06:31:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9555662"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa006.fm.intel.com with ESMTP; 05 Mar 2024 06:31:17 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v3 1/2] Bluetooth: btintel: Define macros for image types
Date: Tue,  5 Mar 2024 20:14:58 +0530
Message-Id: <20240305144459.119564-1-kiran.k@intel.com>
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
index 6ba7f5d1b837..ed98bb867cff 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -489,7 +489,7 @@ static int btintel_version_info_tlv(struct hci_dev *hdev,
 	}
 
 	switch (version->img_type) {
-	case 0x01:
+	case IMG_BOOTLOADER:
 		variant = "Bootloader";
 		/* It is required that every single firmware fragment is acknowledged
 		 * with a command complete event. If the boot parameters indicate
@@ -521,7 +521,7 @@ static int btintel_version_info_tlv(struct hci_dev *hdev,
 			    version->min_fw_build_nn, version->min_fw_build_cw,
 			    2000 + version->min_fw_build_yy);
 		break;
-	case 0x03:
+	case IMG_OP:
 		variant = "Firmware";
 		break;
 	default:
@@ -535,7 +535,7 @@ static int btintel_version_info_tlv(struct hci_dev *hdev,
 	bt_dev_info(hdev, "%s timestamp %u.%u buildtype %u build %u", variant,
 		    2000 + (version->timestamp >> 8), version->timestamp & 0xff,
 		    version->build_type, version->build_num);
-	if (version->img_type == 0x03)
+	if (version->img_type == IMG_OP)
 		bt_dev_info(hdev, "Firmware SHA1: 0x%8.8x", version->git_sha1);
 
 	return 0;
@@ -1172,7 +1172,7 @@ static int btintel_download_fw_tlv(struct hci_dev *hdev,
 	 * If the firmware version has changed that means it needs to be reset
 	 * to bootloader when operational so the new firmware can be loaded.
 	 */
-	if (ver->img_type == 0x03)
+	if (ver->img_type == IMG_OP)
 		return -EINVAL;
 
 	/* iBT hardware variants 0x0b, 0x0c, 0x11, 0x12, 0x13, 0x14 support
@@ -2230,7 +2230,7 @@ static int btintel_prepare_fw_download_tlv(struct hci_dev *hdev,
 	 * It is not possible to use the Secure Boot Parameters in this
 	 * case since that command is only available in bootloader mode.
 	 */
-	if (ver->img_type == 0x03) {
+	if (ver->img_type == IMG_OP) {
 		btintel_clear_flag(hdev, INTEL_BOOTLOADER);
 		btintel_check_bdaddr(hdev);
 	} else {
@@ -2600,7 +2600,7 @@ static int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 		return err;
 
 	/* check if controller is already having an operational firmware */
-	if (ver->img_type == 0x03)
+	if (ver->img_type == IMG_OP)
 		goto finish;
 
 	err = btintel_boot(hdev, boot_param);
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index d19fcdb9ff0b..52b2f1986f85 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -51,6 +51,9 @@ struct intel_tlv {
 	u8 val[];
 } __packed;
 
+#define IMG_BOOTLOADER		0x01	/* Bootloader image */
+#define IMG_OP			0x03	/* Operational image */
+
 struct intel_version_tlv {
 	u32	cnvi_top;
 	u32	cnvr_top;
-- 
2.34.1

