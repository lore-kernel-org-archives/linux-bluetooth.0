Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88867E9;
	Thu,  4 Jul 2024 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720098049; cv=none; b=ptX4K0XhIxiOdjHCgh4NN3hYePbChXs2t5pN2CoRgIZd5whF/XPf6a+Zwlz9NtpyX7FB/oFx0ogOoOE0sguQHCgnlktnGl6rHi7/xGITkDpcTbQgXqBGKxFSYiKvW9Yy+QgvU7wI+haInflTX6DSU1m0Wrym3joG9InJzIVdR1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720098049; c=relaxed/simple;
	bh=6iEPaEZmh+B842HzffrRpZPpysqpM05orObQ1SfKGdk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BpDPFC/jMoxqySN7IQYiJBnLA7JAp2fBx1aG1VEOUC7SksxI7A/gMtiaQma5u6fbDwdE6tHTsMFPRMVlZB0Q+HREs7gm49TznXrPreQo5UVak8MqpiZOPjYubPpfeKNm0ii4rOsjwzNSMahu1P9BgH3A/UHwh5Ec/gyA/vcYcjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 71E4A2013AD;
	Thu,  4 Jul 2024 15:00:40 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 42EBD2013B7;
	Thu,  4 Jul 2024 15:00:40 +0200 (CEST)
Received: from pe-lt8779.in-pnq01.nxp.com (pe-lt8779.in-pnq01.nxp.com [10.17.104.141])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id BAA13180222B;
	Thu,  4 Jul 2024 21:00:38 +0800 (+08)
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
Subject: [PATCH v1] Bluetooth: btnxpuart: Add system suspend and resume handlers
Date: Thu,  4 Jul 2024 18:28:26 +0530
Message-Id: <20240704125826.715387-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

This adds handling for system suspend and resume. While the host enters
suspend state, the driver will drive the chip into low power state.

Similarly when system is resuming, the driver will wake up the chip.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index da18fd4f54f3..acd360fcc3b8 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1498,6 +1498,24 @@ static void nxp_serdev_remove(struct serdev_device *serdev)
 	hci_free_dev(hdev);
 }
 
+static int nxp_suspend(struct device *dev)
+{
+	struct btnxpuart_dev *nxpdev = dev_get_drvdata(dev);
+	struct ps_data *psdata = &nxpdev->psdata;
+
+	ps_control(psdata->hdev, PS_STATE_SLEEP);
+	return 0;
+}
+
+static int nxp_resume(struct device *dev)
+{
+	struct btnxpuart_dev *nxpdev = dev_get_drvdata(dev);
+	struct ps_data *psdata = &nxpdev->psdata;
+
+	ps_control(data->hdev, PS_STATE_AWAKE);
+	return 0;
+}
+
 static struct btnxpuart_data w8987_data __maybe_unused = {
 	.helper_fw_name = NULL,
 	.fw_name = FIRMWARE_W8987,
@@ -1517,12 +1535,17 @@ static const struct of_device_id nxpuart_of_match_table[] __maybe_unused = {
 };
 MODULE_DEVICE_TABLE(of, nxpuart_of_match_table);
 
+static const struct dev_pm_ops nxp_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(nxp_suspend, nxp_resume)
+};
+
 static struct serdev_device_driver nxp_serdev_driver = {
 	.probe = nxp_serdev_probe,
 	.remove = nxp_serdev_remove,
 	.driver = {
 		.name = "btnxpuart",
 		.of_match_table = of_match_ptr(nxpuart_of_match_table),
+		.pm = &nxp_pm_ops,
 	},
 };
 
-- 
2.34.1

