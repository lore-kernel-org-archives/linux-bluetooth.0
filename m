Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0BC184524
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Feb 2026 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772268846; cv=none; b=QelhpqjSeBDvOV0hEtTBOfw2VDjSNlHgJ9/9hG5u5iag3m4OvM94LPBs/ojJw/ibjsctRArFE58T3ocknxW0XpsJOaoqIxaKxnhiFr0LxzbjVK7t7NeS5v9296QRMIXGzko8AaaDxFRxa5YFGloviA3iqoLcx/Nj1g8YER/gYYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772268846; c=relaxed/simple;
	bh=x1wdSEoakn+xeY1V05XBPL9T+5MTeS8Zg5/CU6EklnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UogwpPKl4s9XUAIVvTqmhWXly8RIpFb+nyxbO+cO3/+0+M0MvAZycYdFLkD7WqNJyn/GB8j1eOGFHFhmBz9UjxcKCa6QKt2xh6cWH8ljrA2qZy0IN5DU/NLfUF4qDkLS23/mtUxQhHutFzmMgRYjbk4zsZGx+1/Zj92eiSdWf7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NVVe5q2r; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NVVe5q2r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772268844; x=1803804844;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x1wdSEoakn+xeY1V05XBPL9T+5MTeS8Zg5/CU6EklnM=;
  b=NVVe5q2rqSOTocKK04IlG3kS5QuUC0TijfkitayVze5IVMH6xHJ9eHwZ
   AOKr3M+pME94Z8lGJjc6QdmD09Enx3NJQKBsV4j7n3ecnX4Nn4iEy32HM
   TySzldLQzxC5mqU3Oiuw47hu34CZmdS3WQpEm6hKL7ZyJms8Hkuf9UOAx
   q5K6u/UGGXHj85SfP7r6tmUQ2dkrlLV1yULxcmwfLODYTVpchRmHUhIUo
   wWNaRuX0+1iJmVTusPC4LKxSQQc1slO/VBPbqfR+K3GuwRYaSVcy7TFA1
   3qtS/f6pH4/GgS2wuOWkzs57pQKCa9iuyi7nM40NXONO6hTwJ1ctI3v9J
   w==;
X-CSE-ConnectionGUID: v2xzBe4+TwqdIbszTx3ymw==
X-CSE-MsgGUID: IMIcO42DQPyzC4OrC3i5wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="77189234"
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="77189234"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 00:54:03 -0800
X-CSE-ConnectionGUID: JERw4NcvS5mcOhc04CID/Q==
X-CSE-MsgGUID: SakIwywyTemM+8pepUE0pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="221630136"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa004.jf.intel.com with ESMTP; 28 Feb 2026 00:54:01 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chandrashekar.devegowda@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v3 1/9] Bluetooth: btintel: Add support for hybrid signature for ScP2 onwards
Date: Sat, 28 Feb 2026 14:42:31 +0530
Message-ID: <20260228091239.230284-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If FW image has hybrid signature (ECDSA and LMS) then send CSS header,
ECDSA public key, ECDSA signature, LMS public key, LMS signature and
command buffer to device.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 80 +++++++++++++++++++++++++++++++++----
 1 file changed, 72 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 9d29ab811f80..5999be2efef8 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -35,6 +35,19 @@ enum {
 	DSM_SET_RESET_METHOD = 3,
 };
 
+/* Hybrid ECDSA + LMS */
+#define BTINTEL_RSA_HEADER_VER		0x00010000
+#define BTINTEL_ECDSA_HEADER_VER	0x00020000
+#define BTINTEL_HYBRID_HEADER_VER	0x00069700
+#define BTINTEL_ECDSA_OFFSET		128
+#define BTINTEL_CSS_HEADER_SIZE		128
+#define BTINTEL_ECDSA_PUB_KEY_SIZE	96
+#define BTINTEL_ECDSA_SIG_SIZE		96
+#define BTINTEL_LMS_OFFSET		320
+#define BTINTEL_LMS_PUB_KEY_SIZE	52
+#define BTINTEL_LMS_SIG_SIZE		1744
+#define BTINTEL_CMD_BUFFER_OFFSET	2116
+
 #define BTINTEL_BT_DOMAIN		0x12
 #define BTINTEL_SAR_LEGACY		0
 #define BTINTEL_SAR_INC_PWR		1
@@ -505,8 +518,8 @@ int btintel_version_info_tlv(struct hci_dev *hdev,
 			return -EINVAL;
 		}
 
-		/* Secure boot engine type should be either 1 (ECDSA) or 0 (RSA) */
-		if (version->sbe_type > 0x01) {
+		/* Secure boot engine type can be 0 (RSA), 1 (ECDSA), 2 (LMS), 3 (ECDSA + LMS) */
+		if (version->sbe_type > 0x03) {
 			bt_dev_err(hdev, "Unsupported Intel secure boot engine type (0x%x)",
 				   version->sbe_type);
 			return -EINVAL;
@@ -1025,6 +1038,48 @@ static int btintel_sfi_ecdsa_header_secure_send(struct hci_dev *hdev,
 	return 0;
 }
 
+static int btintel_sfi_hybrid_header_secure_send(struct hci_dev *hdev,
+						 const struct firmware *fw)
+{
+	int err;
+
+	err = btintel_secure_send(hdev, 0x00, BTINTEL_CSS_HEADER_SIZE, fw->data);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to send firmware CSS header (%d)", err);
+		return err;
+	}
+
+	err = btintel_secure_send(hdev, 0x03, BTINTEL_ECDSA_PUB_KEY_SIZE,
+				  fw->data + BTINTEL_ECDSA_OFFSET);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to send firmware ECDSA pkey (%d)", err);
+		return err;
+	}
+
+	err = btintel_secure_send(hdev, 0x02, BTINTEL_ECDSA_SIG_SIZE,
+				  fw->data + BTINTEL_ECDSA_OFFSET + BTINTEL_ECDSA_PUB_KEY_SIZE);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to send firmware ECDSA signature (%d)", err);
+		return err;
+	}
+
+	err = btintel_secure_send(hdev, 0x05, BTINTEL_LMS_PUB_KEY_SIZE,
+				  fw->data + BTINTEL_LMS_OFFSET);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to send firmware LMS pkey (%d)", err);
+		return err;
+	}
+
+	err = btintel_secure_send(hdev, 0x04, BTINTEL_LMS_SIG_SIZE,
+				  fw->data + BTINTEL_LMS_OFFSET + BTINTEL_LMS_PUB_KEY_SIZE);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to send firmware LMS signature (%d)", err);
+		return err;
+	}
+
+	return 0;
+}
+
 static int btintel_download_firmware_payload(struct hci_dev *hdev,
 					     const struct firmware *fw,
 					     size_t offset)
@@ -1198,11 +1253,12 @@ static int btintel_download_fw_tlv(struct hci_dev *hdev,
 	 * Command Buffer.
 	 *
 	 * CSS Header byte positions 0x08 to 0x0B represent the CSS Header
-	 * version: RSA(0x00010000) , ECDSA (0x00020000)
+	 * version: RSA(0x00010000) , ECDSA (0x00020000) , HYBRID (0x00069700)
 	 */
 	css_header_ver = get_unaligned_le32(fw->data + CSS_HEADER_OFFSET);
-	if (css_header_ver != 0x00010000) {
-		bt_dev_err(hdev, "Invalid CSS Header version");
+	if (css_header_ver != BTINTEL_RSA_HEADER_VER &&
+	    css_header_ver != BTINTEL_HYBRID_HEADER_VER) {
+		bt_dev_err(hdev, "Invalid CSS Header version: 0x%8.8x", css_header_ver);
 		return -EINVAL;
 	}
 
@@ -1220,15 +1276,15 @@ static int btintel_download_fw_tlv(struct hci_dev *hdev,
 		err = btintel_download_firmware_payload(hdev, fw, RSA_HEADER_LEN);
 		if (err)
 			return err;
-	} else if (hw_variant >= 0x17) {
+	} else if (hw_variant >= 0x17 && css_header_ver == BTINTEL_RSA_HEADER_VER) {
 		/* Check if CSS header for ECDSA follows the RSA header */
 		if (fw->data[ECDSA_OFFSET] != 0x06)
 			return -EINVAL;
 
 		/* Check if the CSS Header version is ECDSA(0x00020000) */
 		css_header_ver = get_unaligned_le32(fw->data + ECDSA_OFFSET + CSS_HEADER_OFFSET);
-		if (css_header_ver != 0x00020000) {
-			bt_dev_err(hdev, "Invalid CSS Header version");
+		if (css_header_ver != BTINTEL_ECDSA_HEADER_VER) {
+			bt_dev_err(hdev, "Invalid CSS Header version: 0x%8.8x", css_header_ver);
 			return -EINVAL;
 		}
 
@@ -1251,6 +1307,14 @@ static int btintel_download_fw_tlv(struct hci_dev *hdev,
 			if (err)
 				return err;
 		}
+	} else if (hw_variant >= 0x20 && css_header_ver == BTINTEL_HYBRID_HEADER_VER) {
+		err = btintel_sfi_hybrid_header_secure_send(hdev, fw);
+		if (err)
+			return err;
+
+		err = btintel_download_firmware_payload(hdev, fw, BTINTEL_CMD_BUFFER_OFFSET);
+		if (err)
+			return err;
 	}
 	return 0;
 }
-- 
2.43.0

