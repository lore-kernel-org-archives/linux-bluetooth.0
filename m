Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95891836DE;
	Fri, 14 Jun 2024 08:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718353553; cv=none; b=ntG7A3QZr5hdxsaewNPHR00pyl2YUllKxE296LHQNkSfvSpjCAfd5xtRrDVJPMCFDiRiwjJo3WMV7crPptI2/y6ehYNp0SQo3dIcWCvWJsvoXCIpjg6322+wceGL2Q5eOS/XoWz+QBhgZ8snykz0AtPoDK3C0/6pbBplbJvNYOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718353553; c=relaxed/simple;
	bh=n5ERbc459S9Htag/xAuMET2+wMLaFjbD6QqIAA6kQCA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=udp0lDh22MwrUBVBnY/RjBB+xW3RPpuTyCoVGbO+1PPMroV6p27EXLRh94LEcsrQEfFKpoJIfYdhQvFWn0bHYW3kvB93GfovqY2sBqT+V9wWbWlXbh1GbuyuqR70bpV2Brjmdm1OPdRmb0jl/hl6Txk1YWa1Re+g1MmT+hWlGLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 28AF81A186A;
	Fri, 14 Jun 2024 10:25:50 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4462F1A1806;
	Fri, 14 Jun 2024 10:25:49 +0200 (CEST)
Received: from pe-lt8779.in-pnq01.nxp.com (pe-lt8779.in-pnq01.nxp.com [10.17.104.141])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 15B99180222A;
	Fri, 14 Jun 2024 16:25:47 +0800 (+08)
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
Subject: [PATCH v2] Bluetooth: btnxpuart: Add handling for boot-signature timeout errors
Date: Fri, 14 Jun 2024 13:53:38 +0530
Message-Id: <20240614082338.6530-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

This handles the timeout error codes sent by the chip as part of the
bootloader signatures during firmware download process.

When the bootloader does not receive a response packet from the host
within a specific time, it adds an error code to the bootloader
signature while requesting for the FW chunk from the same offset.

The host is expected to clear this error code with a NAK, and reply to
only those bootloader signatures which have error code 0.

However, the driver was ignoring this error code and replying with the
firmware chunks instead, which is apparently ignored by the chip and the
chip resends the same bootloader signature with the error code again. This
happens in a loop until the error code self clears and firmware download
proceeds ahead, adding a couple of milliseconds to the total firmware
download time.

Commit 689ca16e5232 was an initial implementation which simply printed
the following line during driver debug:
- FW Download received err 0x04 from chip

This commit adds the expected handling to the error codes.

This error handling is valid for data_req bootloader signatures for V3
and future bootloader versions.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets")
---
v2: Improve commit message, avoid type casting (Paul Menzel)
---
 drivers/bluetooth/btnxpuart.c | 52 ++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 00757a7cd8b5..fd7f25bed5b6 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -189,6 +189,11 @@ struct btnxpuart_dev {
 #define NXP_NAK_V3		0x7b
 #define NXP_CRC_ERROR_V3	0x7c
 
+/* Bootloader signature error codes */
+#define NXP_ACK_RX_TIMEOUT	0x0002	/* ACK not received from host */
+#define NXP_HDR_RX_TIMEOUT	0x0003	/* FW Header chunk not received */
+#define NXP_DATA_RX_TIMEOUT	0x0004	/* FW Data chunk not received */
+
 #define HDR_LEN			16
 
 #define NXP_RECV_CHIP_VER_V1 \
@@ -279,6 +284,17 @@ struct nxp_bootloader_cmd {
 	__be32 crc;
 } __packed;
 
+struct nxp_v3_rx_timeout_nak {
+	u8 nak;
+	__le32 offset;
+	u8 crc;
+} __packed;
+
+union nxp_v3_rx_timeout_nak_u {
+	struct nxp_v3_rx_timeout_nak pkt;
+	u8 buf[6];
+};
+
 static u8 crc8_table[CRC8_TABLE_SIZE];
 
 /* Default configurations */
@@ -912,6 +928,32 @@ static int nxp_recv_chip_ver_v3(struct hci_dev *hdev, struct sk_buff *skb)
 	return 0;
 }
 
+static void nxp_handle_fw_download_error(struct hci_dev *hdev, struct v3_data_req *req)
+{
+	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	__u32 offset = __le32_to_cpu(req->offset);
+	__u16 err = __le16_to_cpu(req->error);
+	union nxp_v3_rx_timeout_nak_u nak_tx_buf;
+
+	switch (err) {
+	case NXP_ACK_RX_TIMEOUT:
+	case NXP_HDR_RX_TIMEOUT:
+	case NXP_DATA_RX_TIMEOUT:
+		nak_tx_buf.pkt.nak = NXP_NAK_V3;
+		nak_tx_buf.pkt.offset = __cpu_to_le32(offset);
+		nak_tx_buf.pkt.crc = crc8(crc8_table, nak_tx_buf.buf,
+				      sizeof(nak_tx_buf) - 1, 0xff);
+		serdev_device_write_buf(nxpdev->serdev, nak_tx_buf.buf,
+					sizeof(nak_tx_buf));
+		break;
+	default:
+		bt_dev_dbg(hdev, "Unknown bootloader error code: %d", err);
+		break;
+
+	}
+
+}
+
 static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
@@ -926,7 +968,12 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!req || !nxpdev->fw)
 		goto free_skb;
 
-	nxp_send_ack(NXP_ACK_V3, hdev);
+	if (!req->error) {
+		nxp_send_ack(NXP_ACK_V3, hdev);
+	} else {
+		nxp_handle_fw_download_error(hdev, req);
+		goto free_skb;
+	}
 
 	len = __le16_to_cpu(req->len);
 
@@ -953,9 +1000,6 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
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

