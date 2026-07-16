Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898B13F4825;
	Thu, 16 Jul 2026 08:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784191696; cv=none; b=OLhZOEqDiIlDPmQRgYH4HGatWGz8tYZ6Qeu1Uzl12WtOYzVEf3Bb+k8/MFzhP8uZz5ivK8rlNdrIqA6MXmxTB7liiXd5xWvrn516AqpVCwq+8EJ4NkZTg+C0LgnYWzyhjgiSziLVVzeFmp9hPhabDDUoI7DtYtGxUlCAopAf2oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784191696; c=relaxed/simple;
	bh=WUy/DueWHXdfslzF2Ib8dbFUG7k3Yte9eQjky9JmwPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9SVmjDcrsx6gP9kT0AYL6hBzXm6O1PsHpDIMq10LXfjFL2j6E8D4bU3AYCtmk5qxPS+wTzf+7BMCCIkSGJlgRjrkaTBFc18lTEihhean2fN3w+uzLdh5wexmcpUvPBQ2DKbWDrAxotwKKe0VzTX6yDNjNaGSdoRiSgG1cMxM6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0c7314aa80f311f1aa26b74ffac11d73-20260716
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:909b81ca-e4f2-4f5e-9d47-a5b9421acf68,IP:15,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:40
X-CID-INFO: VERSION:1.3.12,REQID:909b81ca-e4f2-4f5e-9d47-a5b9421acf68,IP:15,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:40
X-CID-META: VersionHash:e7bac3a,CLOUDID:98c56fec77a48d406ad30e5678ceb5d1,BulkI
	D:260716164802BG83684B,BulkQuantity:0,Recheck:0,SF:10|66|78|81|82|102|127|
	865|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,
	QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
	,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0c7314aa80f311f1aa26b74ffac11d73-20260716
X-User: liqiang01@kylinos.cn
Received: from cvdaxia.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liqiang01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 95112118; Thu, 16 Jul 2026 16:47:59 +0800
From: Li Qiang <liqiang01@kylinos.cn>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Li Qiang <liqiang01@kylinos.cn>
Subject: [PATCH 5/5] Bluetooth: hci_qca: validate controller memdump frames
Date: Thu, 16 Jul 2026 16:47:32 +0800
Message-ID: <d22a531ed598e7da1e715a0d620cb6f29fdc0e7f.1784191283.git.liqiang01@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784191283.git.liqiang01@kylinos.cn>
References: <cover.1784191283.git.liqiang01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The QCA controller memdump worker reads frame and dump-size headers
before validating the received skb length. The event classifier likewise
accesses its fixed header without ensuring that all accessed bytes are
present. Malformed controller data can therefore cause out-of-bounds
reads.

Validate every header and the initial dump size before changing the dump
state. Reset the local dump state when discarding an unstarted
collection. Use subtraction-based capacity checks to prevent overflow
while accounting for received and synthesized dump data.

Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
---
 drivers/bluetooth/hci_qca.c | 58 ++++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index b2d1ee3a3d11..b5d4b8e0e376 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1057,6 +1057,34 @@ static void qca_controller_memdump(struct work_struct *work)
 			return;
 		}
 
+		if (skb->len < sizeof(*cmd_hdr)) {
+			bt_dev_err(hu->hdev, "Rx short memdump header");
+			kfree_skb(skb);
+			mutex_unlock(&qca->hci_memdump_lock);
+			continue;
+		}
+
+		cmd_hdr = (void *) skb->data;
+		seq_no = __le16_to_cpu(cmd_hdr->seq_no);
+		skb_pull(skb, sizeof(struct qca_memdump_event_hdr));
+
+		if (!seq_no) {
+			if (skb->len < sizeof(*dump)) {
+				bt_dev_err(hu->hdev, "Rx short memdump size");
+				kfree_skb(skb);
+				mutex_unlock(&qca->hci_memdump_lock);
+				continue;
+			}
+
+			dump = (void *)skb->data;
+			if (!__le32_to_cpu(dump->dump_size)) {
+				bt_dev_err(hu->hdev, "Rx invalid memdump size");
+				kfree_skb(skb);
+				mutex_unlock(&qca->hci_memdump_lock);
+				continue;
+			}
+		}
+
 		if (!qca_memdump) {
 			qca_memdump = kzalloc_obj(*qca_memdump, GFP_ATOMIC);
 			if (!qca_memdump) {
@@ -1068,9 +1096,6 @@ static void qca_controller_memdump(struct work_struct *work)
 		}
 
 		qca->memdump_state = QCA_MEMDUMP_COLLECTING;
-		cmd_hdr = (void *) skb->data;
-		seq_no = __le16_to_cpu(cmd_hdr->seq_no);
-		skb_pull(skb, sizeof(struct qca_memdump_event_hdr));
 
 		if (!seq_no) {
 
@@ -1082,15 +1107,7 @@ static void qca_controller_memdump(struct work_struct *work)
 			 */
 			set_bit(QCA_IBS_DISABLED, &qca->flags);
 			set_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
-			dump = (void *) skb->data;
 			qca_memdump->ram_dump_size = __le32_to_cpu(dump->dump_size);
-			if (!(qca_memdump->ram_dump_size)) {
-				bt_dev_err(hu->hdev, "Rx invalid memdump size");
-				kfree(qca_memdump);
-				kfree_skb(skb);
-				mutex_unlock(&qca->hci_memdump_lock);
-				return;
-			}
 
 			queue_delayed_work(qca->workqueue,
 					   &qca->ctrl_memdump_timeout,
@@ -1123,6 +1140,8 @@ static void qca_controller_memdump(struct work_struct *work)
 		if (!test_bit(QCA_MEMDUMP_COLLECTION, &qca->flags)) {
 			bt_dev_err(hu->hdev, "QCA: Discarding other packets");
 			kfree(qca_memdump);
+			qca->qca_memdump = NULL;
+			qca->memdump_state = QCA_MEMDUMP_IDLE;
 			kfree_skb(skb);
 			mutex_unlock(&qca->hci_memdump_lock);
 			return;
@@ -1140,9 +1159,11 @@ static void qca_controller_memdump(struct work_struct *work)
 			seq_no != QCA_LAST_SEQUENCE_NUM) {
 			bt_dev_err(hu->hdev, "QCA controller missed packet:%d",
 				   qca_memdump->current_seq_no);
-			rx_size = qca_memdump->received_dump;
-			rx_size += QCA_DUMP_PACKET_SIZE;
-			if (rx_size > qca_memdump->ram_dump_size) {
+			if (qca_memdump->received_dump >
+				    qca_memdump->ram_dump_size ||
+			    QCA_DUMP_PACKET_SIZE >
+				    qca_memdump->ram_dump_size -
+				    qca_memdump->received_dump) {
 				bt_dev_err(hu->hdev,
 					   "QCA memdump received %d, no space for missed packet",
 					   qca_memdump->received_dump);
@@ -1154,8 +1175,10 @@ static void qca_controller_memdump(struct work_struct *work)
 			qca_memdump->current_seq_no++;
 		}
 
-		rx_size = qca_memdump->received_dump  + skb->len;
-		if (rx_size <= qca_memdump->ram_dump_size) {
+		if (qca_memdump->received_dump <= qca_memdump->ram_dump_size &&
+		    skb->len <= qca_memdump->ram_dump_size -
+				qca_memdump->received_dump) {
+			rx_size = qca_memdump->received_dump + skb->len;
 			if ((seq_no != QCA_LAST_SEQUENCE_NUM) &&
 			    (seq_no != qca_memdump->current_seq_no)) {
 				bt_dev_err(hu->hdev,
@@ -1235,7 +1258,8 @@ static int qca_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 	 * received we store dump into a file before closing hci. This
 	 * dump will help in triaging the issues.
 	 */
-	if ((skb->data[0] == HCI_VENDOR_PKT) &&
+	if (skb->len >= offsetof(struct qca_memdump_event_hdr, seq_no) &&
+	    (skb->data[0] == HCI_VENDOR_PKT) &&
 	    (get_unaligned_be16(skb->data + 2) == QCA_SSR_DUMP_HANDLE))
 		return qca_controller_memdump_event(hdev, skb);
 
-- 
2.43.0

