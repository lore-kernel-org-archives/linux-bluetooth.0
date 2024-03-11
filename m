Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5700963AE
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 04:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710131913; cv=none; b=fmvrUc+bqIQIMz8keC2b61b2kbAjJOc4AG2BgYIo+IxAMjHtzDRvmGa6McBSLKp42C9Gp563zV6XJoI0gPCN6Eeu/ieZbnW2nrYdh9BUqNmaP+ZTOJTYqF2bTJZZQMrA9+vOepffZNjBYf7Zyzapr8MKOmhCRMgYtWZuA2Vqt1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710131913; c=relaxed/simple;
	bh=pu9k6Eldd+MPhU0XJjYhdafbK7zhZ4wPgH85YbAGgeo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a0v/o2Pm5KM6SA+By2NrCn2jKz2ll9GJL82HowW3gCqBzL+MiwtjnUwa0lT21WdFJG70Ps8f5btFwHT4pBabeUthN0MoCYROotp5rtHbr7yMfnNWhgqS0UdpmAehJrKc8yT1QZXcQT6rGXP+MYuSXl3Zu1O2t69TMKB54BprxuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oC6HifiN; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oC6HifiN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710131911; x=1741667911;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pu9k6Eldd+MPhU0XJjYhdafbK7zhZ4wPgH85YbAGgeo=;
  b=oC6HifiNLFyslNYuWdfejJUSmG25rGVKH6EmoBa6SjL7cUKif+H9h7LE
   PdFOW2N4CP1v51SK3of+Amr7xNsIv2QyPHn+8a8wrISGfyruBlkSpm5kH
   cQ2zonEN4kkG7H9xARGnpQgAjEOQ19w8eEbAidSlGQwoMqjSAy2WnjaQ9
   Xn0ulsKlkBCLITNFdTln0v1VKrHfVbuS2TbQNtuqea4f3uhsL80seDxlR
   Mf2l9tJiWPD2aciedvdZsLhECOu39EafA5FBob3hvkz9VcfnQcdhmwar0
   xOjrVbBhhyZaKo3+3FFdYqtZ+wqsinTC/6yhaYWqXMpNsrYQmBI7jKah1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="15339150"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="15339150"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 21:38:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="10925130"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa009.fm.intel.com with ESMTP; 10 Mar 2024 21:38:29 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v4 1/2] Bluetooth: btintel: Define macros for image types
Date: Mon, 11 Mar 2024 10:22:13 +0530
Message-Id: <20240311045214.350475-1-kiran.k@intel.com>
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

