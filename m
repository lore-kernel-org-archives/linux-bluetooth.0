Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12E6481DF;
	Wed, 15 May 2024 07:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715756948; cv=none; b=KPwp4NYSvSED3qb9PqKkNFAynC5yO7v1czEpFcUKA1qsjV7Yi7RjO+wypzBEWND8eTHBGCrUxW7n8wt+RDsHOfbglPA57J3OnHaJWYPJzX0UCmqkzka4gz/z1Al8sQ1bZCvSVrwLGWY6S1DMfhcW2lHBX5IQrYmc4TrbIXQiWnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715756948; c=relaxed/simple;
	bh=njRyex57xZz0oe6JsmGT5/vRa7wbswWURMZAfYLgbPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RPPgAS8Tlj7lbmVICv6jfSC0nyIn1b7kbMWJwwNX6RYUeIF5rtJM6OX68fRXR2bpqwNoVAcdmDWnpKl/22kMvIVA8IWWf/Rj5HFnGixm0Pv5v4Njc4XaTQErogf9G2Ew75fsK900UIpySVKvk+ysC1+XfgD6IEESYS9hVUruzeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2DE2B1A1ACC;
	Wed, 15 May 2024 09:09:05 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9591E1A1ABC;
	Wed, 15 May 2024 09:09:04 +0200 (CEST)
Received: from pe-lt8779.in-pnq01.nxp.com (pe-lt8779.in-pnq01.nxp.com [10.17.104.141])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D3763180222A;
	Wed, 15 May 2024 15:09:02 +0800 (+08)
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
	LnxRevLi@nxp.com,
	guillaume.legoupil@nxp.com,
	salim.chebbo@nxp.com
Subject: [PATCH v1 3/3] Bluetooth: btnxpuart: Handle FW Download Abort scenario
Date: Wed, 15 May 2024 12:36:57 +0530
Message-Id: <20240515070657.85132-4-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515070657.85132-1-neeraj.sanjaykale@nxp.com>
References: <20240515070657.85132-1-neeraj.sanjaykale@nxp.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

This adds a new flag BTNXPUART_FW_DOWNLOAD_ABORT which handles the
situation where driver is removed while firmware download is in
progress.

logs:
modprobe btnxpuart
[65239.230431] Bluetooth: hci0: ChipID: 7601, Version: 0
[65239.236670] Bluetooth: hci0: Request Firmware: nxp/uartspi_n61x_v1.bin.se
rmmod btnxpuart
[65241.425300] Bluetooth: hci0: FW Download Aborted

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Tested-by: Guillaume Legoupil <guillaume.legoupil@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 47 ++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index c22f2ad7d751..97d0f6f089e8 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -29,6 +29,7 @@
 #define BTNXPUART_CHECK_BOOT_SIGNATURE	3
 #define BTNXPUART_SERDEV_OPEN		4
 #define BTNXPUART_IR_IN_PROGRESS	5
+#define BTNXPUART_FW_DOWNLOAD_ABORT	6
 
 /* NXP HW err codes */
 #define BTNXPUART_IR_HW_ERR		0xb0
@@ -159,6 +160,7 @@ struct btnxpuart_dev {
 	u8 fw_name[MAX_FW_FILE_NAME_LEN];
 	u32 fw_dnld_v1_offset;
 	u32 fw_v1_sent_bytes;
+	u32 fw_dnld_v3_offset;
 	u32 fw_v3_offset_correction;
 	u32 fw_v1_expected_len;
 	u32 boot_reg_offset;
@@ -550,6 +552,7 @@ static int nxp_download_firmware(struct hci_dev *hdev)
 	nxpdev->fw_v1_sent_bytes = 0;
 	nxpdev->fw_v1_expected_len = HDR_LEN;
 	nxpdev->boot_reg_offset = 0;
+	nxpdev->fw_dnld_v3_offset = 0;
 	nxpdev->fw_v3_offset_correction = 0;
 	nxpdev->baudrate_changed = false;
 	nxpdev->timeout_changed = false;
@@ -564,14 +567,23 @@ static int nxp_download_firmware(struct hci_dev *hdev)
 					       !test_bit(BTNXPUART_FW_DOWNLOADING,
 							 &nxpdev->tx_state),
 					       msecs_to_jiffies(60000));
+
+	release_firmware(nxpdev->fw);
+	memset(nxpdev->fw_name, 0, sizeof(nxpdev->fw_name));
+
 	if (err == 0) {
-		bt_dev_err(hdev, "FW Download Timeout.");
+		bt_dev_err(hdev, "FW Download Timeout. offset: %d",
+				nxpdev->fw_dnld_v1_offset ?
+				nxpdev->fw_dnld_v1_offset :
+				nxpdev->fw_dnld_v3_offset);
 		return -ETIMEDOUT;
 	}
+	if (test_bit(BTNXPUART_FW_DOWNLOAD_ABORT, &nxpdev->tx_state)) {
+		bt_dev_err(hdev, "FW Download Aborted");
+		return -EINTR;
+	}
 
 	serdev_device_set_flow_control(nxpdev->serdev, true);
-	release_firmware(nxpdev->fw);
-	memset(nxpdev->fw_name, 0, sizeof(nxpdev->fw_name));
 
 	/* Allow the downloaded FW to initialize */
 	msleep(1200);
@@ -955,8 +967,9 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 		goto free_skb;
 	}
 
-	serdev_device_write_buf(nxpdev->serdev, nxpdev->fw->data + offset -
-				nxpdev->fw_v3_offset_correction, len);
+	nxpdev->fw_dnld_v3_offset = offset - nxpdev->fw_v3_offset_correction;
+	serdev_device_write_buf(nxpdev->serdev, nxpdev->fw->data +
+				nxpdev->fw_dnld_v3_offset, len);
 
 free_skb:
 	kfree_skb(skb);
@@ -1390,16 +1403,22 @@ static void nxp_serdev_remove(struct serdev_device *serdev)
 	struct btnxpuart_dev *nxpdev = serdev_device_get_drvdata(serdev);
 	struct hci_dev *hdev = nxpdev->hdev;
 
-	/* Restore FW baudrate to fw_init_baudrate if changed.
-	 * This will ensure FW baudrate is in sync with
-	 * driver baudrate in case this driver is re-inserted.
-	 */
-	if (nxpdev->current_baudrate != nxpdev->fw_init_baudrate) {
-		nxpdev->new_baudrate = nxpdev->fw_init_baudrate;
-		nxp_set_baudrate_cmd(hdev, NULL);
+	if (is_fw_downloading(nxpdev)) {
+		set_bit(BTNXPUART_FW_DOWNLOAD_ABORT, &nxpdev->tx_state);
+		clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
+		wake_up_interruptible(&nxpdev->check_boot_sign_wait_q);
+		wake_up_interruptible(&nxpdev->fw_dnld_done_wait_q);
+	} else {
+		/* Restore FW baudrate to fw_init_baudrate if changed.
+		 * This will ensure FW baudrate is in sync with
+		 * driver baudrate in case this driver is re-inserted.
+		 */
+		if (nxpdev->current_baudrate != nxpdev->fw_init_baudrate) {
+			nxpdev->new_baudrate = nxpdev->fw_init_baudrate;
+			nxp_set_baudrate_cmd(hdev, NULL);
+		}
+		ps_cancel_timer(nxpdev);
 	}
-
-	ps_cancel_timer(nxpdev);
 	hci_unregister_dev(hdev);
 	hci_free_dev(hdev);
 }
-- 
2.34.1

