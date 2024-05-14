Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EA5208CE;
	Tue, 14 May 2024 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715677767; cv=none; b=SKlzKCtr8sPsiB4KD795690jY6Vq/bRHSXwf0iNzCsDTkTBPolizA0bQk8GUtlKQ7qN2Rn6s4w5geSfUjFLMqeekxFwqgk27GQc4laeMg2/LWQlquIbdFmpx9Mb9/PaW2UgudIbc6WjbCX6dyy/uIVHQ0vBJ8RGRWhi+4ZruWyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715677767; c=relaxed/simple;
	bh=wy1kEIFNWuIKDXwii9P9BWgUPVTkXwG6PerXplT8Hik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o9K7920lh9AAi1zCZYydSA0Al3mVcdZq0/gChmFfwCuuHTfqRKmAo4xjM+ne/Q8Irxn0aKxPe8lymrEd33aitIWTz1dUd36zy5fcir5axy2ac4cJwQoOq8/bODv/E0yO4f9zf8Mshu0DybdWvd6RAqVhh+fjAnIMYGzAzt/yBXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A083C2015E6;
	Tue, 14 May 2024 11:09:23 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 591AD201909;
	Tue, 14 May 2024 11:09:23 +0200 (CEST)
Received: from pe-lt8779.in-pnq01.nxp.com (pe-lt8779.in-pnq01.nxp.com [10.17.104.141])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 7E902180222C;
	Tue, 14 May 2024 17:09:21 +0800 (+08)
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
Subject: [PATCH v1 1/1] Bluetooth: btnxpuart: Add handling for boot-signature timeout errors
Date: Tue, 14 May 2024 14:39:13 +0530
Message-Id: <20240514090913.1507990-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

This handles the timeout errors seen in the bootloader signatures during
FW download.

When the bootloader does not receive a response packet from the host
within a specific time, it adds an error code to the bootloader
signature while requesting for the FW chunk from the same offset.

The host is expected to clear this error code with a NAK, and reply to
only those bootloader signatures which have error code 0.

This error handling is valid for data_req bootloader signatures for V3
and future bootloader versions.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 46 ++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 0b93c2ff29e4..2018513fb961 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -187,6 +187,10 @@ struct btnxpuart_dev {
 #define NXP_NAK_V3		0x7b
 #define NXP_CRC_ERROR_V3	0x7c
 
+#define NXP_ACK_RX_TIMEOUT	0x0002
+#define NXP_HDR_RX_TIMEOUT	0x0003
+#define NXP_DATA_RX_TIMEOUT	0x0004
+
 #define HDR_LEN			16
 
 #define NXP_RECV_CHIP_VER_V1 \
@@ -277,6 +281,12 @@ struct nxp_bootloader_cmd {
 	__be32 crc;
 } __packed;
 
+struct nxp_v3_rx_timeout_nak {
+	u8 nak;
+	__le32 offset;
+	u8 crc;
+} __packed;
+
 static u8 crc8_table[CRC8_TABLE_SIZE];
 
 /* Default configurations */
@@ -899,6 +909,32 @@ static int nxp_recv_chip_ver_v3(struct hci_dev *hdev, struct sk_buff *skb)
 	return 0;
 }
 
+static void nxp_handle_fw_dnld_error(struct hci_dev *hdev, struct v3_data_req *req)
+{
+	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	__u32 offset = __le32_to_cpu(req->offset);
+	__u16 err = __le16_to_cpu(req->error);
+	struct nxp_v3_rx_timeout_nak nak_tx_buf;
+
+	switch (err) {
+	case NXP_ACK_RX_TIMEOUT:
+	case NXP_HDR_RX_TIMEOUT:
+	case NXP_DATA_RX_TIMEOUT:
+		nak_tx_buf.nak = NXP_NAK_V3;
+		nak_tx_buf.offset = __cpu_to_le32(offset);
+		nak_tx_buf.crc = crc8(crc8_table, (u8 *)&nak_tx_buf,
+				      sizeof(nak_tx_buf) - 1, 0xff);
+		serdev_device_write_buf(nxpdev->serdev, (u8 *)&nak_tx_buf,
+					sizeof(nak_tx_buf));
+		break;
+	default:
+		bt_dev_dbg(hdev, "Unknown bootloader error: %d", err);
+		break;
+
+	}
+
+}
+
 static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
@@ -913,7 +949,12 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!req || !nxpdev->fw)
 		goto free_skb;
 
-	nxp_send_ack(NXP_ACK_V3, hdev);
+	if (!req->error) {
+		nxp_send_ack(NXP_ACK_V3, hdev);
+	} else {
+		nxp_handle_fw_dnld_error(hdev, req);
+		goto free_skb;
+	}
 
 	len = __le16_to_cpu(req->len);
 
@@ -940,9 +981,6 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 		wake_up_interruptible(&nxpdev->fw_dnld_done_wait_q);
 		goto free_skb;
 	}
-	if (req->error)
-		bt_dev_dbg(hdev, "FW Download received err 0x%02x from chip",
-			   req->error);
 
 	offset = __le32_to_cpu(req->offset);
 	if (offset < nxpdev->fw_v3_offset_correction) {
-- 
2.34.1

