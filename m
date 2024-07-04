Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9801AE864;
	Thu,  4 Jul 2024 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720099389; cv=none; b=juDwEAHyXdxIVAKODBcEo6DmDMDnwe6GldARuGZGhYQ9zqageiKXzg850XA0v9qwd3Ky4T9NmD8y6KWm1HEvmk/8kgvEjeiZ+zP00I3SOpmXg9AQO+/yTUxter6Cf2aaAA2o0sWKZxGxqx/auBRXfBd+FpzXv0bNrdZMOiAVidM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720099389; c=relaxed/simple;
	bh=eV8haKKesia/HpOgKa8I/3DVswIM2msePbyY/laR3zo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GzxVAf3a5VCsZUgBMQ0p3Gi/i89zsN4ajyEmNQkqTCiMvz4QdT2kf7c2AYDE/dePqlnKUt0XJP3GLOb8eIYbfdDg0gOfoABOpF1bIpCXMSwdHliqtSnfa0nZoTomhoFaXVlphtZqZav1F6aGEOV17ruCjjs8DdUmzV0U29lIOug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3AA67200099;
	Thu,  4 Jul 2024 15:23:06 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 006CB200F8D;
	Thu,  4 Jul 2024 15:23:06 +0200 (CEST)
Received: from pe-lt8779.in-pnq01.nxp.com (pe-lt8779.in-pnq01.nxp.com [10.17.104.141])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 78545180226C;
	Thu,  4 Jul 2024 21:23:04 +0800 (+08)
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	rohit.fule@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	ziniu.wang_1@nxp.com,
	haibo.chen@nxp.com,
	LnxRevLi@nxp.com
Subject: [PATCH v1 2/2] Bluetooth: btnxpuart: Add support for IW615 chipset
Date: Thu,  4 Jul 2024 18:50:58 +0530
Message-Id: <20240704132058.716164-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704132058.716164-1-neeraj.sanjaykale@nxp.com>
References: <20240704132058.716164-1-neeraj.sanjaykale@nxp.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

This adds support for IW615 chipset with it's bootloader signature
and firmware file.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index e81c995748da..e9c2f2f7acc6 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -42,6 +42,8 @@
 #define FIRMWARE_W9098_OLD	"uartuart9098_bt_v1.bin"
 #define FIRMWARE_IW416		"uartiw416_bt_v0.bin"
 #define FIRMWARE_IW612		"uartspi_n61x_v1.bin.se"
+#define FIRMWARE_IW615		"uartspi_iw610_v0.bin"
+#define FIRMWARE_SECURE_IW615	"uartspi_iw610_v0.bin.se"
 #define FIRMWARE_IW624		"uartiw624_bt.bin"
 #define FIRMWARE_SECURE_IW624	"uartiw624_bt.bin.se"
 #define FIRMWARE_AW693		"uartaw693_bt.bin"
@@ -57,6 +59,8 @@
 #define CHIP_ID_IW624c		0x8001
 #define CHIP_ID_AW693a0		0x8200
 #define CHIP_ID_AW693a1		0x8201
+#define CHIP_ID_IW615a0		0x8800
+#define CHIP_ID_IW615a1		0x8801
 
 #define FW_SECURE_MASK		0xc0
 #define FW_OPEN			0x00
@@ -925,6 +929,15 @@ static char *nxp_get_fw_name_from_chipid(struct hci_dev *hdev, u16 chipid,
 		else
 			bt_dev_err(hdev, "Illegal loader version %02x", loader_ver);
 		break;
+	case CHIP_ID_IW615a0:
+	case CHIP_ID_IW615a1:
+		if ((loader_ver & FW_SECURE_MASK) == FW_OPEN)
+			fw_name = FIRMWARE_IW615;
+		else if ((loader_ver & FW_SECURE_MASK) != FW_AUTH_ILLEGAL)
+			fw_name = FIRMWARE_SECURE_IW615;
+		else
+			bt_dev_err(hdev, "Illegal loader version %02x", loader_ver);
+		break;
 	default:
 		bt_dev_err(hdev, "Unknown chip signature %04x", chipid);
 		break;
-- 
2.34.1

