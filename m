Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2577E1A6811;
	Thu,  6 Aug 2026 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021216; cv=none; b=pNJMVQEtdKWsRj5rYkP3ytN9lUeGy4gdvoYBX7rALoOXZcBvHyXxpR1LnY3lvvk9gtQ1QpI28G+vHGS1YpEPAnya0vLNau7vJQyjcCAWxquDxTOKICJ7nIp+Am36/I0szjoUF5XB60IqC4VSgkgQr9RYHS11Kh+9RghRXMSm83w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021216; c=relaxed/simple;
	bh=uytQJkFwbSJVR9WerDh6/MyYSJXxEMX+p4hPRyKr6mE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ln1Ixopgt1ZRXpeNf14GiJgxPsV8rg5ekAmqICXFWwdM7BT+PXPHvR+9muEG34iiCzP47TxYJdZs/LLwNy9/WzI+be20y7Q3MfG58qZEZdM1JvzwNEWTXLRSLau+F34eJ7CgdxzcaRnhVxh3rVODjoePO5hqWoFgjg3pSS4PYlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: bee95f3c919611f1aa26b74ffac11d73-20260806
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:23f66040-8084-4fff-a208-d5a29117c92e,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:5e12b33f8d537a1c9334a9c0520b16ae,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|865|898,TC:nil,Content:0|1
	5|50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: bee95f3c919611f1aa26b74ffac11d73-20260806
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1083245973; Thu, 06 Aug 2026 21:00:05 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Brian Gix <brian.gix@intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH bluetooth 1/4] Bluetooth: hci_conn: fix the SCO setup context lifetime
Date: Thu,  6 Aug 2026 20:59:54 +0800
Message-Id: <20260806125957.698760-2-lilinmao@kylinos.cn>
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

hci_setup_sync() queues a conn_handle_t with a NULL destroy callback, so
the context is only freed if hci_enhanced_setup_sync() actually runs. An
entry that is cancelled instead is leaked, as
_hci_cmd_sync_cancel_entry() does not release entry->data when there is
no destroy callback, and hci_cmd_sync_clear() cancels every pending entry
when the controller is unregistered.

The context also stores a bare hci_conn pointer, so the connection can be
freed while the work is queued. The dequeue in hci_conn_del() does not
cover it either, as it matches on entry->data == conn and entry->data is
the wrapper here. Same problem as commit 2f5d635ad590 ("Bluetooth:
hci_sync: hold conn in hci_connect_acl/le_sync() callbacks").

Hold the connection and release both from a destroy callback. The
submission failure path drops both, since hci_cmd_sync_submit() does not
call the destroy callback when it fails to queue.

Fixes: e07a06b4eb41 ("Bluetooth: Convert SCO configure_datapath to hci_sync")
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
 net/bluetooth/hci_conn.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b1f911fd4ad6a..19b7629b1cc10 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -283,8 +283,6 @@ static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
 	struct hci_cp_enhanced_setup_sync_conn cp;
 	const struct sco_param *param;
 
-	kfree(conn_handle);
-
 	if (!hci_conn_valid(hdev, conn))
 		return -ECANCELED;
 
@@ -453,6 +451,15 @@ static bool hci_setup_sync_conn(struct hci_conn *conn, __u16 handle)
 	return true;
 }
 
+static void hci_enhanced_setup_sync_destroy(struct hci_dev *hdev, void *data,
+					    int err)
+{
+	struct conn_handle_t *conn_handle = data;
+
+	hci_conn_put(conn_handle->conn);
+	kfree(conn_handle);
+}
+
 bool hci_setup_sync(struct hci_conn *conn, __u16 handle)
 {
 	int result;
@@ -464,12 +471,15 @@ bool hci_setup_sync(struct hci_conn *conn, __u16 handle)
 		if (!conn_handle)
 			return false;
 
-		conn_handle->conn = conn;
+		conn_handle->conn = hci_conn_get(conn);
 		conn_handle->handle = handle;
 		result = hci_cmd_sync_queue(conn->hdev, hci_enhanced_setup_sync,
-					    conn_handle, NULL);
-		if (result < 0)
+					    conn_handle,
+					    hci_enhanced_setup_sync_destroy);
+		if (result < 0) {
+			hci_conn_put(conn);
 			kfree(conn_handle);
+		}
 
 		return result == 0;
 	}
-- 
2.25.1

