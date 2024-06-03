Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D3D219E8;
	Mon,  3 Jun 2024 06:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717395914; cv=none; b=QCrTFx3gf4tZZoBB/VLJfs/FSxlVyASIWhBswZ/C854xCVUi2CGeYiqwyYHgNTA669jtmHZnue99VFZOYQiyFCSbrysy8q66F4gIchS7dQEw3hQlcDMRUrnG/2L4T21kJW/M73XAYyqGUQzokI755ZMyns6KD3ji7hnE0Eff6gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717395914; c=relaxed/simple;
	bh=DN8MJhZE/6ABuaOgDNbrslUWBDHWkr4DQN1q02HGp+I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GOL+tOV35QCdNYNwJmPimFthrn3GzWq9c7eftOUnrhSlKmoy8QmG3vLgg3UEiIgzj2WBvHUVCK2Q09FnM7JPVT1agSrQUYzK3nQDryToFxz4FeWVPWxphOAM9TYWUmUd6OX0y/YJASFDO8YuS/nMLljnkjadRbPnqhItCZ3Wx6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 193BA1A163A;
	Mon,  3 Jun 2024 08:25:05 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9D8861A0BBF;
	Mon,  3 Jun 2024 08:25:04 +0200 (CEST)
Received: from pe-lt8779.in-pnq01.nxp.com (pe-lt8779.in-pnq01.nxp.com [10.17.104.141])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0A8771820F59;
	Mon,  3 Jun 2024 14:25:02 +0800 (+08)
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
Subject: [PATCH v2] Bluetooth: btnxpuart: Enable Power Save feature on startup
Date: Mon,  3 Jun 2024 11:52:55 +0530
Message-Id: <20240603062255.121063-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

This sets the default power save mode setting to enabled.

The power save feature is now stable and stress test issues, such as the
TX timeout error, have been resolved.
commit c7ee0bc8db32 ("Bluetooth: btnxpuart: Resolve TX timeout error in
power save stress test")

With this setting, the driver will send the vendor command to FW at
startup, to enable power save feature.

User can disable this feature using the following vendor command:
hcitool cmd 3f 23 03 00 00 (HCI_NXP_AUTO_SLEEP_MODE)

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
v2: Corrected subject line. Added commit reference. (Paul Menzel)
 drivers/bluetooth/btnxpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 7f88b6f52f26..42e929f0d141 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -281,7 +281,7 @@ static u8 crc8_table[CRC8_TABLE_SIZE];
 
 /* Default configurations */
 #define DEFAULT_H2C_WAKEUP_MODE	WAKEUP_METHOD_BREAK
-#define DEFAULT_PS_MODE		PS_MODE_DISABLE
+#define DEFAULT_PS_MODE		PS_MODE_ENABLE
 #define FW_INIT_BAUDRATE	HCI_NXP_PRI_BAUDRATE
 
 static struct sk_buff *nxp_drv_send_cmd(struct hci_dev *hdev, u16 opcode,
-- 
2.34.1

