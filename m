Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3903E1AE864;
	Thu,  4 Jul 2024 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720099393; cv=none; b=ZYECFmBpwqRYiz7m8Jhqe4u2dhkGFnc0xE9Ol07XYux+0tbQP0Xo0IIGwTOYFNP8q5pszxOM49JObCpBbJzUE6ooBcr0LMV5r3APyIfbMqADTzoKvlB+qZyPpd0FKqA8Q8ODM/ef8+9lfGuibzksWgda5WPtfEv5YN8n58XcSyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720099393; c=relaxed/simple;
	bh=qgfF4sjhfBrT1SQha/doaxEaVH9Z4HK1JT4TroN2RLk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qV9SPzBL1tj2suQDJcojJpn5v/hZoDW1NO+2QUKZSdtCiti1Hv7CnflbqiURKMXUKLnET78vROoYz8K5vo6EHAy1DOXgHzNkwjqqOidFprW4VeckawXfnL7LD3f5J3Y30EnQZ0w0DV/YIQT4L2+Kxyncx8kj4aYosYd9L4aeoLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 33C2E1A001F;
	Thu,  4 Jul 2024 15:23:05 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F065A1A0008;
	Thu,  4 Jul 2024 15:23:04 +0200 (CEST)
Received: from pe-lt8779.in-pnq01.nxp.com (pe-lt8779.in-pnq01.nxp.com [10.17.104.141])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 73134180222B;
	Thu,  4 Jul 2024 21:23:03 +0800 (+08)
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
Subject: [PATCH v1 1/2] Bluetooth: btnxpuart: Add support for AW693 A1 chipset
Date: Thu,  4 Jul 2024 18:50:57 +0530
Message-Id: <20240704132058.716164-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

This adds support for AW693 A1 chipset with it's bootloader signature
and firmware file.

No firmware name change needed for AW693 A0 chipset.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index da18fd4f54f3..e81c995748da 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -46,6 +46,8 @@
 #define FIRMWARE_SECURE_IW624	"uartiw624_bt.bin.se"
 #define FIRMWARE_AW693		"uartaw693_bt.bin"
 #define FIRMWARE_SECURE_AW693	"uartaw693_bt.bin.se"
+#define FIRMWARE_AW693_A1		"uartaw693_bt_v1.bin"
+#define FIRMWARE_SECURE_AW693_A1	"uartaw693_bt_v1.bin.se"
 #define FIRMWARE_HELPER		"helper_uart_3000000.bin"
 
 #define CHIP_ID_W9098		0x5c03
@@ -53,7 +55,8 @@
 #define CHIP_ID_IW612		0x7601
 #define CHIP_ID_IW624a		0x8000
 #define CHIP_ID_IW624c		0x8001
-#define CHIP_ID_AW693		0x8200
+#define CHIP_ID_AW693a0		0x8200
+#define CHIP_ID_AW693a1		0x8201
 
 #define FW_SECURE_MASK		0xc0
 #define FW_OPEN			0x00
@@ -906,7 +909,7 @@ static char *nxp_get_fw_name_from_chipid(struct hci_dev *hdev, u16 chipid,
 		else
 			bt_dev_err(hdev, "Illegal loader version %02x", loader_ver);
 		break;
-	case CHIP_ID_AW693:
+	case CHIP_ID_AW693a0:
 		if ((loader_ver & FW_SECURE_MASK) == FW_OPEN)
 			fw_name = FIRMWARE_AW693;
 		else if ((loader_ver & FW_SECURE_MASK) != FW_AUTH_ILLEGAL)
@@ -914,6 +917,14 @@ static char *nxp_get_fw_name_from_chipid(struct hci_dev *hdev, u16 chipid,
 		else
 			bt_dev_err(hdev, "Illegal loader version %02x", loader_ver);
 		break;
+	case CHIP_ID_AW693a1:
+		if ((loader_ver & FW_SECURE_MASK) == FW_OPEN)
+			fw_name = FIRMWARE_AW693_A1;
+		else if ((loader_ver & FW_SECURE_MASK) != FW_AUTH_ILLEGAL)
+			fw_name = FIRMWARE_SECURE_AW693_A1;
+		else
+			bt_dev_err(hdev, "Illegal loader version %02x", loader_ver);
+		break;
 	default:
 		bt_dev_err(hdev, "Unknown chip signature %04x", chipid);
 		break;
-- 
2.34.1

