Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5DB4437D;
	Wed, 15 May 2024 07:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715756944; cv=none; b=LELa5L3idU2amkLvMHV69QHv7aNejEXyiETnDZ5Cu1Dlf8qbNIVDsAeWfeoZVZ3+CBS5TqMCCBLeturUmOQDunSo6yV83tgTOm7/4yrZKIztF20z2dPcVSfTaX9yqkzFKEabZMKDCPUe2CoCsNCJ3OCTTalzbYuosg2IitQUTA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715756944; c=relaxed/simple;
	bh=6AUHB010gIMdAQfAKcUP+WZtCSfx5bX4hBjphhoQI+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FYMiIkaoTqpkMzgYBgPZU30xEZ2HdDXP29CyU9VTY3kk9V8RbtYIfaRCTEYHAQJ8MA6jcToCnR7xo8/4QnNJBcZWTTorJTl4MWNUyL7lF4vL11VNBX+1KVWJ6FL/YUGfCvUuXNAVTmJ8VUL5d1kQvjMNFiUIhdDq9fZdcqg/QEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 072041A1F66;
	Wed, 15 May 2024 09:09:01 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B5EC51A1F51;
	Wed, 15 May 2024 09:09:00 +0200 (CEST)
Received: from pe-lt8779.in-pnq01.nxp.com (pe-lt8779.in-pnq01.nxp.com [10.17.104.141])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id F1CD7180222C;
	Wed, 15 May 2024 15:08:58 +0800 (+08)
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
Subject: [PATCH v1 2/3] Bluetooth: btnxpuart: Enable status prints for firmware download
Date: Wed, 15 May 2024 12:36:56 +0530
Message-Id: <20240515070657.85132-3-neeraj.sanjaykale@nxp.com>
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

This enables prints for firmware download which can help automation
tests to verify firmware download functionality.

dmesg logs before:
modprobe btnxpuart
[ 1999.187264] Bluetooth: MGMT ver 1.22

dmesg logs with this patch:
modprobe btnxpuart
[16179.758515] Bluetooth: hci0: ChipID: 7601, Version: 0
[16179.764748] Bluetooth: hci0: Request Firmware: nxp/uartspi_n61x_v1.bin.se
[16181.217490] Bluetooth: hci0: FW Download Complete: 372696 bytes
[16182.701398] Bluetooth: MGMT ver 1.22

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Tested-by: Guillaume Legoupil <guillaume.legoupil@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 0677b48a456e..c22f2ad7d751 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -693,7 +693,7 @@ static int nxp_request_firmware(struct hci_dev *hdev, const char *fw_name)
 	if (!strlen(nxpdev->fw_name)) {
 		snprintf(nxpdev->fw_name, MAX_FW_FILE_NAME_LEN, "%s", fw_name);
 
-		bt_dev_dbg(hdev, "Request Firmware: %s", nxpdev->fw_name);
+		bt_dev_info(hdev, "Request Firmware: %s", nxpdev->fw_name);
 		err = request_firmware(&nxpdev->fw, nxpdev->fw_name, &hdev->dev);
 		if (err < 0) {
 			bt_dev_err(hdev, "Firmware file %s not found", nxpdev->fw_name);
@@ -781,7 +781,7 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	if (!len) {
-		bt_dev_dbg(hdev, "FW Downloaded Successfully: %zu bytes",
+		bt_dev_info(hdev, "FW Download Complete: %zu bytes",
 			   nxpdev->fw->size);
 		if (nxp_data->helper_fw_name && !nxpdev->helper_downloaded) {
 			nxpdev->helper_downloaded = true;
@@ -890,6 +890,7 @@ static int nxp_recv_chip_ver_v3(struct hci_dev *hdev, struct sk_buff *skb)
 
 	chip_id = le16_to_cpu(req->chip_id);
 	loader_ver = req->loader_ver;
+	bt_dev_info(hdev, "ChipID: %04x, Version: %d", chip_id, loader_ver);
 	if (!nxp_request_firmware(hdev, nxp_get_fw_name_from_chipid(hdev,
 								    chip_id, loader_ver)))
 		nxp_send_ack(NXP_ACK_V3, hdev);
@@ -934,7 +935,7 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	if (req->len == 0) {
-		bt_dev_dbg(hdev, "FW Downloaded Successfully: %zu bytes",
+		bt_dev_info(hdev, "FW Download Complete: %zu bytes",
 			   nxpdev->fw->size);
 		clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
 		wake_up_interruptible(&nxpdev->fw_dnld_done_wait_q);
@@ -1037,7 +1038,7 @@ static int nxp_setup(struct hci_dev *hdev)
 		if (err < 0)
 			return err;
 	} else {
-		bt_dev_dbg(hdev, "FW already running.");
+		bt_dev_info(hdev, "FW already running.");
 		clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
 	}
 
-- 
2.34.1

