Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54A51F0E29;
	Thu,  6 Aug 2026 13:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021231; cv=none; b=IKBRf5Fmn8r4Y0cjxKxnO/keOjspV+NVYArd8SyxI74aQlD90xauWrgT9ozjwLN0Fq7fcHKgCyjvqowJABXZf5W24cqJgJIZmvaLys4c2ItsTKCKpoi/G7GMrI7u6L4djo30w1K74YFrrKiM1X1rqEqvxbqw5l8dcOkcrv1Idg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021231; c=relaxed/simple;
	bh=7vrqT986iwcbo5gUIILeFrHRFIiW6cKy5ohx231gdEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cqFAwNum9LI6b8+rHnpO6qkTCvMfegcdlIaCUESgRbg0v1qQrmdwCCd788UXskPeNq71n2KNPrGdWLpthqP5HwUb/kT5ix0iKv5kEFr3vt8YwuYmyflg5g4sQKOVwyhdenVhdt9+Yocy27qJBJniI99w7NQYiiB0OTfNSdtlo+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c7d92a96919611f1aa26b74ffac11d73-20260806
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:4073e5af-0cd4-4108-8585-7ceb0a29fb3f,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:b5da540dc652c9efa0e4cb77c8e9bf48,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|865|898,TC:nil,Content:0|1
	5|50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c7d92a96919611f1aa26b74ffac11d73-20260806
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1533056951; Thu, 06 Aug 2026 21:00:20 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Brian Gix <brian.gix@intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH bluetooth 4/4] Bluetooth: MGMT: free the HCI command when it is cancelled
Date: Thu,  6 Aug 2026 20:59:57 +0800
Message-Id: <20260806125957.698760-5-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260806125957.698760-1-lilinmao@kylinos.cn>
References: <20260806125957.698760-1-lilinmao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mgmt_hci_cmd_sync() queues the pending command with a NULL destroy
callback, so it is only freed if send_hci_cmd_sync() runs. A cancelled
entry is leaked, as _hci_cmd_sync_cancel_entry() does not release
entry->data when there is no destroy callback, and hci_cmd_sync_clear()
cancels every pending entry when the controller is unregistered. Nothing
else reclaims it either: mgmt_pending_new() does not put the command on
hdev->mgmt_pending.

The leak also pins the socket reference taken by mgmt_pending_new(), so
the mgmt socket is never released.

Free the command from a destroy callback. The now-empty done label is
replaced by a direct return.

Fixes: 827af4787e74 ("Bluetooth: MGMT: Add initial implementation of MGMT_OP_HCI_CMD_SYNC")
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
 net/bluetooth/mgmt.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a80653b5b875d..7e9d27eefb504 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2647,7 +2647,7 @@ static int send_hci_cmd_sync(struct hci_dev *hdev, void *data)
 	if (IS_ERR(skb)) {
 		mgmt_cmd_status(cmd->sk, hdev->id, MGMT_OP_HCI_CMD_SYNC,
 				mgmt_status(PTR_ERR(skb)));
-		goto done;
+		return 0;
 	}
 
 	mgmt_cmd_complete(cmd->sk, hdev->id, MGMT_OP_HCI_CMD_SYNC, 0,
@@ -2655,12 +2655,14 @@ static int send_hci_cmd_sync(struct hci_dev *hdev, void *data)
 
 	kfree_skb(skb);
 
-done:
-	mgmt_pending_free(cmd);
-
 	return 0;
 }
 
+static void send_hci_cmd_sync_destroy(struct hci_dev *hdev, void *data, int err)
+{
+	mgmt_pending_free(data);
+}
+
 static int mgmt_hci_cmd_sync(struct sock *sk, struct hci_dev *hdev,
 			     void *data, u16 len)
 {
@@ -2678,7 +2680,8 @@ static int mgmt_hci_cmd_sync(struct sock *sk, struct hci_dev *hdev,
 	if (!cmd)
 		err = -ENOMEM;
 	else
-		err = hci_cmd_sync_queue(hdev, send_hci_cmd_sync, cmd, NULL);
+		err = hci_cmd_sync_queue(hdev, send_hci_cmd_sync, cmd,
+					 send_hci_cmd_sync_destroy);
 
 	if (err < 0) {
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_HCI_CMD_SYNC,
-- 
2.25.1

