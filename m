Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510E0143C53;
	Fri,  5 Jul 2024 07:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720162838; cv=none; b=A32lHsmdeDf07DAxafviH7Y0JzCCq+sC0z7IKBzBKT1pMt4H0t2JNPgLx2g0hpqxIuV8G8Cr2pTwrnR/Uev4kVtJsZIsjSoZDpstnP/z6JhMYpcvLfx28i0QeKnuAR026YW5snDSCa1Ralpq/ZVLBKlCDxbsxNMzX7b66nHPYRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720162838; c=relaxed/simple;
	bh=bOFk8R3sjMWU0W/yovems56xZAEkgJVdHq4/eiNM8gE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HkE5wAoESZcgWMlndoh00n4u5UReBPk+Ahv3pKJeHbmkVp8Szq7CpHbx3XDjS7asG6asp4fg3jQwKjY/0yAMrbGXQlXOTJTTj9wcHACSf6lMaUwygh0rJzZSB7+R8Sq3Z3Z5XeVlY1j5bhyDu/WFMWbv4g+8J1s5tE9w4YTS7iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 962E11A051D;
	Fri,  5 Jul 2024 09:00:35 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4D1E61A0516;
	Fri,  5 Jul 2024 09:00:35 +0200 (CEST)
Received: from pe-lt8779.in-pnq01.nxp.com (pe-lt8779.in-pnq01.nxp.com [10.17.104.141])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C43A5180222B;
	Fri,  5 Jul 2024 15:00:33 +0800 (+08)
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
Subject: [PATCH v2] Bluetooth: btnxpuart: Add system suspend and resume handlers
Date: Fri,  5 Jul 2024 12:28:26 +0530
Message-Id: <20240705065826.782059-1-neeraj.sanjaykale@nxp.com>
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
v2: Rename new suspend/resume function names to nxp_serdev_suspend and
nxp_serdev_resume. (Luke Wang)
---
 drivers/bluetooth/btnxpuart.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index da18fd4f54f3..c5b40bba6bfa 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1498,6 +1498,24 @@ static void nxp_serdev_remove(struct serdev_device *serdev)
 	hci_free_dev(hdev);
 }
 
+static int nxp_serdev_suspend(struct device *dev)
+{
+	struct btnxpuart_dev *nxpdev = dev_get_drvdata(dev);
+	struct ps_data *psdata = &nxpdev->psdata;
+
+	ps_control(psdata->hdev, PS_STATE_SLEEP);
+	return 0;
+}
+
+static int nxp_serdev_resume(struct device *dev)
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
+	SET_SYSTEM_SLEEP_PM_OPS(nxp_serdev_suspend, nxp_serdev_resume)
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

