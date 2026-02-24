Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E7239B4BA
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 15:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771946176; cv=none; b=UPIw+Bevz8pHNrMVYBghRAV2REO79SGWppoiiTuvPT7d0s439AUrtkIM4y0jMyBlGdBYseO+sSGf9SVrsA6mOoXFg49KCF+CkBL1zUxo/hlcCL5yVsgv1aOfQnwxeNRBVbfWKMZc2yXvoVrhrxvSEmuKMN7IavliIuPIEBIzWOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771946176; c=relaxed/simple;
	bh=x1wdSEoakn+xeY1V05XBPL9T+5MTeS8Zg5/CU6EklnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nEAFzox5JNKyrI/adaOIkV3J/kJ6AFzDsOrenNKUbClsKCnfoZ6po/r9Tst8tYTymttDKz/oIIthgyKjL/9ANRHtXZsnO2dTE9DSx1Rp+0dffcMJztphzsPOc43T6TtXH5UVrTSdkZfr6F2endskKaOYimYAJYN3icvW2D26JmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bSlGal3Y; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bSlGal3Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771946175; x=1803482175;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x1wdSEoakn+xeY1V05XBPL9T+5MTeS8Zg5/CU6EklnM=;
  b=bSlGal3Y+3FCri+mtGP5g3lHpfBE5/dKOI36OgA4bj2c48H+QYPj/HVs
   a5GU0+pjRyN68wPzkcVJaXtUyVG56R2c8EzrwPFHcPt9zfRMl/4Ba0Nyy
   l2HE5XoUfmqQOVzvS/xuU/icuUxLU5z70Ywe48+zluV/P7/eB7AxWR4JX
   V7+DpJsrH2qK6yc9kpimZvdADD9vk+bkPogdj/LKv3gWDjjjSIh9TwHae
   EIQII+VnViAYS3iNabLkv3sES+VXWhjMCGvLqqBgK0I/upp6Qs6JWQMd/
   TcSGZ+SNjfkvkU+3lFjWN8C998IVMR3vnOaJRKSlKZQtIhRm17SToy7Ah
   Q==;
X-CSE-ConnectionGUID: QJGfbpGFTdaQ669UXMpKXg==
X-CSE-MsgGUID: jO8zye31QSOmY/MjI6SY3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72874679"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="72874679"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 07:16:14 -0800
X-CSE-ConnectionGUID: 1LUSHQqcRJqDI2nDqro1Iw==
X-CSE-MsgGUID: n5D5FVY/TXiUkucJvbJH5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="253676458"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa001.jf.intel.com with ESMTP; 24 Feb 2026 07:16:12 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chandrashekar.devegowda@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 1/9] Bluetooth: btintel: Add support for hybrid signature for ScP2 onwards
Date: Tue, 24 Feb 2026 21:04:40 +0530
Message-ID: <20260224153449.193551-1-kiran.k@intel.com>
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

