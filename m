Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704D0128369;
	Wed, 10 Jul 2024 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720614998; cv=none; b=etRW88U6x65/U4UKTNUk/94h1lBlP+UYm47j4eNq4JNvbDVoBeWj2oDVNAArJIy5qCv3IMU5V0Ml3sUWMSoIPqaRDiKGCLDkCfpZJjW+FU6FM5AL1fIeyzZYECGoR09ZMaNcXuJsaS1xe/noRCnMcqrjICB1mTpyiAbW5Uh0gXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720614998; c=relaxed/simple;
	bh=It3imBc3BM6SehI+VEHWR2OIlg/DcDnLWTXrkGkSGLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FUCJv8QwOCX2J9Fdidg/xbsZG5uvNrn9fKmqNCL4VeUIpFUul5CjSZMyJFMivXenmwRmnCoDcqTYtenVyoDZdYNqQsk0y2Hh0WnLiC/MEtZZ5WDk/Hi9bLYOAZysth5Y4kx7gFJpY84hOHuobIxYbcaW/yI6EAVbbUWv9kVqLXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4B4392006AD;
	Wed, 10 Jul 2024 14:36:29 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 12D04200E34;
	Wed, 10 Jul 2024 14:36:29 +0200 (CEST)
Received: from pe-lt8779.in-pnq01.nxp.com (pe-lt8779.in-pnq01.nxp.com [10.17.104.141])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9D1C1183487B;
	Wed, 10 Jul 2024 20:36:27 +0800 (+08)
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
Subject: [PATCH v2] Bluetooth: btnxpuart: Fix warnings for suspend and resume functions
Date: Wed, 10 Jul 2024 18:04:26 +0530
Message-Id: <20240710123426.935122-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

This fixes the warnings 'nxp_serdev_resume' and 'nxp_serdev_suspend'
defined but not used.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407100518.06Xxq5PK-lkp@intel.com/
---
v2: Rebase master, fix conflict due to copy-paste error from previous
patch (bluez.test.bot)
---
 drivers/bluetooth/btnxpuart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index f75b24bd3045..31d3dd90b672 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1522,6 +1522,7 @@ static void nxp_serdev_remove(struct serdev_device *serdev)
 	hci_free_dev(hdev);
 }
 
+#ifdef CONFIG_PM_SLEEP
 static int nxp_serdev_suspend(struct device *dev)
 {
 	struct btnxpuart_dev *nxpdev = dev_get_drvdata(dev);
@@ -1539,6 +1540,7 @@ static int nxp_serdev_resume(struct device *dev)
 	ps_control(psdata->hdev, PS_STATE_AWAKE);
 	return 0;
 }
+#endif
 
 static struct btnxpuart_data w8987_data __maybe_unused = {
 	.helper_fw_name = NULL,
-- 
2.34.1

