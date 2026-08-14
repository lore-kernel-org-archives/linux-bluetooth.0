Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D04141A79D;
	Fri, 14 Aug 2026 08:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695160; cv=pass; b=M7W6FGop39U88JBHIffFxsT9L7A0kfKgLnBkHqAt5NnOOBnAMnr/6kPeO9EYWOfSwoL6Dxb72kSD2E/7Iwe0lof9caUWk37V90LxnSDmVqr0fvTeBLp3Cz1/Zu4Sqx6ormhnPmfo1JLffUTOQKMZpMJEfB/8215YTNHoxQYVBaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695160; c=relaxed/simple;
	bh=4xhCo1xqQe5/K5SytWSoLZS0p8cKchhWCUpT+EZ3Ahw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gDjN7sIPucQUCehj/WWEkJBl6WVNbAA0DmWcxas5aXcsrmQPzChQ+dI+eXmsbu6ztMPNRlICsbTrmWwGMy9Ix5FD1p9uAiAC63DRcBN/uERx7dwhahQ5pZO13PkA8St0EioPj/gaur05JKZK4Phn5DMC7JAOo+ItDH2XyD/zYjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=H33h0xNH; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="H33h0xNH"
ARC-Seal: i=1; a=rsa-sha256; t=1786695152; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=VBtAq6M4iBNOfdwNP7+6ILVk4zKQDPHRDpMN3tST/pus+kOiBRmnAKiPre/l63silnUNmMGL0orfOxpF7Leo4wfkC4HqRDKYUUR3PiceaUKtoGEaKN1DvGjWdZX+SUZ3x/jn/QRg65EhjQnVc1MrDjF0z5JTCiMdVYp/MygxAuM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1786695152; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uM24bwi+KAyeuSR0JV6MJSRBmd3bp1hEBK1GiH3rIdE=; 
	b=KT3xJJzlPkaiGLdK8sgU9uG8I0541s+lcysZatw2wilF9/K/7+Oy55NK2mpvNZQNIJaui22mk2MV5HdaHUr2aeRjl1/8wPEO5yZmeSwGpDnpObGPJxztNehzzR2726kpEZHvHOmJwG/zHupHQjlK7RgBSXw+WfDa8Uv8pgqRJu4=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786695151;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=uM24bwi+KAyeuSR0JV6MJSRBmd3bp1hEBK1GiH3rIdE=;
	b=H33h0xNHHJM8RC3j1EZqaMYcAzsTBn1f4bBNHS7GS4hYw1/muwdr6qm1Tvgy5Fii
	eQ6xJjatyffUhWyM20KYE9+VyHX3uATvNe16bCpPaXtHYdhQTmwvDnyA0G4oCbthq2o
	161vTX296N6amZR5zl6vzZ8OTqhmp9thCbtszHvo=
Received: by mx.zoho.eu with SMTPS id 1786695150487270.0671373009768;
	Fri, 14 Aug 2026 10:12:30 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btnxpuart: Validate the FW dump header length
Date: Fri, 14 Aug 2026 08:12:17 +0000
Message-ID: <20260814081221.913676-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

nxp_process_fw_dump() pulls the ACL header off the frame and then reads
seq_num and buf_len from a struct nxp_fw_dump_hdr placed at skb->data,
without checking that the ACL payload is long enough to contain it.

h4_recv_buf() collects HCI_ACL_HDR_SIZE bytes of header followed by the
number of payload bytes named in that header, so skb->len is 4 + dlen
with dlen supplied by the controller and possibly smaller than the 8
byte dump header, or zero. A short frame with connection handle 0xfff
therefore reads both fields from beyond the received data.

Beyond the read itself, buf_len is what terminates a dump, a value of
zero makes the driver call hci_devcd_complete() and reset the
controller, so a truncated frame can end a dump early.

Reject frames whose payload is shorter than the dump header.

Fixes: 998e447f443f ("Bluetooth: btnxpuart: Add support for HCI coredump feature")
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
 drivers/bluetooth/btnxpuart.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 6a1cffe08d5f..e540acdb784a 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1370,10 +1370,17 @@ static int nxp_process_fw_dump(struct hci_dev *hdev, struct sk_buff *skb)
 									  sizeof(*acl_hdr));
 	struct nxp_fw_dump_hdr *fw_dump_hdr = (struct nxp_fw_dump_hdr *)skb->data;
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
-	__u16 seq_num = __le16_to_cpu(fw_dump_hdr->seq_num);
-	__u16 buf_len = __le16_to_cpu(fw_dump_hdr->buf_len);
+	__u16 seq_num;
+	__u16 buf_len;
 	int err;
 
+	/* The ACL payload must be long enough to hold the FW dump header */
+	if (skb->len < sizeof(*fw_dump_hdr))
+		goto free_skb;
+
+	seq_num = __le16_to_cpu(fw_dump_hdr->seq_num);
+	buf_len = __le16_to_cpu(fw_dump_hdr->buf_len);
+
 	if (seq_num == 0x0001) {
 		if (test_and_set_bit(BTNXPUART_FW_DUMP_IN_PROGRESS, &nxpdev->tx_state)) {
 			bt_dev_err(hdev, "FW dump already in progress");
-- 
2.55.0

