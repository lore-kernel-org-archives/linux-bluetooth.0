Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0D21F03D9;
	Mon,  1 Jun 2026 01:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780277194; cv=none; b=a89/VdwN7pcIIfemWHKVpTpW9shLozDryjQDl4VoKRTpPgR0ZBGABSU7JXPayKUbNecWPS6B9iCCkIEnl+hEEECKHtkDOzj4YmmekC492aX2TnGsmev8CI1u4LtOdP3P5eH/zb1zLQ5UUkAP61tlcG4cK8kwMe6ZSiMwR9goyp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780277194; c=relaxed/simple;
	bh=0dLAJP2eab5FWZONr07We0DiGMa4IOMF9oKxmwQSUrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=crMdO51god9X3+/r1VRAwH5NKyuXEiu8ZmOfiKBw551UwaJ7Nvg5EbkZz2TsWrimvti8xZa2AJBR+K+3+Yqz0Q5ZeesrV9Cyln4ilpe6Rv6XU+SeA56QHzbMGT/vKWgyil7N2z8TVYjy8BPtukRQXAMppSyzsvatLZ8E1fAKdvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e84de2205d5811f1aa26b74ffac11d73-20260601
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:24c51549-1e18-400c-8802-ec5a900f6814,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:333bd0a667cb5c44efe9e3ad2e5ffd6e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|865|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e84de2205d5811f1aa26b74ffac11d73-20260601
X-User: liujiajia@kylinos.cn
Received: from nature.lan [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liujiajia@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 32413899; Mon, 01 Jun 2026 09:26:26 +0800
From: Jiajia Liu <liujiajia@kylinos.cn>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Brian Gix <brian.gix@intel.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiajia Liu <liujiajia@kylinos.cn>
Subject: [PATCH] Bluetooth: hci_sync: fix simultaneous discovery stuck in FINDING
Date: Mon,  1 Jun 2026 09:26:20 +0800
Message-ID: <20260601012620.11764-1-liujiajia@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When hci_inquiry_complete_evt is called between le_scan_disable and
le_set_scan_enable_complete and no remote name needs to be resolved,
the interleaved discovery with SIMULTANEOUS quirk gets stuck in
DISCOVERY_FINDING. le_set_scan_enable_complete does not check inquiry
state. No one sets DISCOVERY_STOPPED in this process.

  < HCI Command: LE Set Extended Scan Enable  #1764 [hci0] 608.610392
          Extended scan: Disabled (0x00)
          Filter duplicates: Disabled (0x00)
          Duration: 0 msec (0x0000)
          Period: 0.00 sec (0x0000)
  > HCI Event: Inquiry Complete (0x01)        #1765 [hci0] 608.610548
          Status: Success (0x00)
  > HCI Event: Command Complete (0x0e)        #1766 [hci0] 608.611589
        LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
          Status: Success (0x00)

Add scan_disable_complete to check state and stop discovery if stuck.
Tested with bluetooth AX201 (8087:0026) in Dell Vostro 13 laptop.

  [4517.963204] hci0: state 0 -> 1
  [4518.096858] hci0: state 1 -> 2
  [4528.353765] hci0: state 2 -> 0
  [4528.353776] hci0: state finding to stopped
  [4533.966844] hci0: state 0 -> 1
  [4534.097702] hci0: state 1 -> 2
  [4544.478600] hci0: state 2 -> 0

Fixes: 8ffde2a73f2c ("Bluetooth: Convert le_scan_disable timeout to hci_sync")
Signed-off-by: Jiajia Liu <liujiajia@kylinos.cn>
---
 net/bluetooth/hci_sync.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index aff8562a8690..4cb1c82cc3f0 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -361,6 +361,28 @@ static int interleaved_inquiry_sync(struct hci_dev *hdev, void *data)
 	return hci_inquiry_sync(hdev, DISCOV_INTERLEAVED_INQUIRY_LEN, 0);
 }
 
+static void scan_disable_complete(struct hci_dev *hdev, void *data, int err)
+{
+	if (err)
+		return;
+
+	hci_dev_lock(hdev);
+
+	if (hdev->discovery.type != DISCOV_TYPE_INTERLEAVED)
+		goto unlock;
+
+	if (hci_test_quirk(hdev, HCI_QUIRK_SIMULTANEOUS_DISCOVERY)) {
+		if (!test_bit(HCI_INQUIRY, &hdev->flags) &&
+		    hdev->discovery.state == DISCOVERY_FINDING) {
+			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+			bt_dev_dbg(hdev, "state finding to stopped");
+		}
+	}
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
 static void le_scan_disable(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
@@ -373,7 +395,8 @@ static void le_scan_disable(struct work_struct *work)
 	if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
 		goto _return;
 
-	status = hci_cmd_sync_queue(hdev, scan_disable_sync, NULL, NULL);
+	status = hci_cmd_sync_queue(hdev, scan_disable_sync, NULL,
+				    scan_disable_complete);
 	if (status) {
 		bt_dev_err(hdev, "failed to disable LE scan: %d", status);
 		goto _return;
-- 
2.53.0

