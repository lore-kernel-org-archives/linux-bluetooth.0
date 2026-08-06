Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791E61A6811;
	Thu,  6 Aug 2026 13:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021234; cv=none; b=Jyh3hd/8VkBlH2kn67Ejf8AEeMH4yFsgGp5VSLTtmo8Y9eqmQ6wVGTWjVz94LF4f2SclGws4NgBXWeMtzh0+sCSfATyzvNK/ButTA+rszJfl5EqhBfUGC3v0X9CFG7cau3LIXL8xfd7JuF9Oonh8WEV8KgZeu8yDTy/MOIj2Ha0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021234; c=relaxed/simple;
	bh=wQYqSn39znyFeriEWAuyoOFvx7yAMdHlo1NkxOiJB2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ppXnks6qMvHEc25s04FXqvfKcNEguinjmZGH2vvyGC+VcjxyEFUL879SAS3a3FHNvzXolQiu0gbtFb0GkF/0BmH6X8pywY/ePZuW/Jqai0F9/qxrn/obipWxieYawmkDo+VXa7RDiHbDYOQykb8srBpLXGV8mp2c+rJcjVlgq/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c69e3950919611f1aa26b74ffac11d73-20260806
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c55b309e-4ecc-4b85-8e81-b16b60ff4187,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:177bc3b9de8ed4259b580199e078719e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|865|898,TC:nil,Content:0|1
	5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c69e3950919611f1aa26b74ffac11d73-20260806
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 838548469; Thu, 06 Aug 2026 21:00:18 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Brian Gix <brian.gix@intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH bluetooth 3/4] Bluetooth: MGMT: free the mesh send cancel command when it is cancelled
Date: Thu,  6 Aug 2026 20:59:56 +0800
Message-Id: <20260806125957.698760-4-lilinmao@kylinos.cn>
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

mesh_send_cancel() queues the pending command with a NULL destroy
callback, so it is only freed if send_cancel() runs. A cancelled entry is
leaked, as _hci_cmd_sync_cancel_entry() does not release entry->data when
there is no destroy callback, and hci_cmd_sync_clear() cancels every
pending entry when the controller is unregistered. Nothing else reclaims
it either: mgmt_pending_new() does not put the command on
hdev->mgmt_pending.

The leak also pins the socket reference taken by mgmt_pending_new(), so
the mgmt socket is never released.

Free the command from a destroy callback.

Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
 net/bluetooth/mgmt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 167d75e345266..a80653b5b875d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2431,11 +2431,15 @@ static int send_cancel(struct hci_dev *hdev, void *data)
 
 	mgmt_cmd_complete(cmd->sk, hdev->id, MGMT_OP_MESH_SEND_CANCEL,
 			  0, NULL, 0);
-	mgmt_pending_free(cmd);
 
 	return 0;
 }
 
+static void send_cancel_destroy(struct hci_dev *hdev, void *data, int err)
+{
+	mgmt_pending_free(data);
+}
+
 static int mesh_send_cancel(struct sock *sk, struct hci_dev *hdev,
 			    void *data, u16 len)
 {
@@ -2456,7 +2460,8 @@ static int mesh_send_cancel(struct sock *sk, struct hci_dev *hdev,
 	if (!cmd)
 		err = -ENOMEM;
 	else
-		err = hci_cmd_sync_queue(hdev, send_cancel, cmd, NULL);
+		err = hci_cmd_sync_queue(hdev, send_cancel, cmd,
+					 send_cancel_destroy);
 
 	if (err < 0) {
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND_CANCEL,
-- 
2.25.1

