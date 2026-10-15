Received: from mail3-164.sinamail.sina.com.cn (mail3-164.sinamail.sina.com.cn [202.108.3.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE755243956
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 00:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792024789; cv=none; b=hCmGAsXxe73x3U8MCNilNzm5LozQzIfBeIW2VVVwFMCxafvCpMYDZOmrzeDo013CTrtpkwXDf772zhzdFB5RBXEnrAsVfhUPMZoBSQzJhjlBpjXrl39EHeXiOZbxlhdqTGicqPql9Ff/Bd7iSR2ZfHqqhHxKiWdi2O40kWkEnss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792024789; c=relaxed/simple;
	bh=idH0hCK9+Ac1zzsSvHM2DzrFyVKzPYMIMe9FcJ3Fnxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6xSLGzLFlQSOY8oLKPIZtX6nDwvLrcPrqOPMX/LX2h/n+k1HPGMe3s8Aic4YrroqSNogmZNL4hHS3LI3Qr/fiTkxdRtcZNB5svVhKz23Hn1r7gsIRnngmigvhjLmGLkQPBMHVi0jALoK+Z2QdNBfLerf7pDzOXhoHC6Cofcw2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=kZVjzFq1; arc=none smtp.client-ip=202.108.3.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="kZVjzFq1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1792024786;
	bh=qo6CsvOfDb2LpVW3di2AIauLJii7seDt0kp6m0r013o=;
	h=From:Subject:Date:Message-ID;
	b=kZVjzFq1WHTQ+gbv0ahor7uFK4bnWTI1u4aleQyD7oMFK7AwqfGTUHmqSovUz2YM/
	 Iqj2BM+chohdbxgZcXR4SV4++PQXDpSJ10/SoutC2xfh2mWhCjseFULiThjKopRcas
	 +fsbZqXcFnFRhw0RL3pS5K1VcQkcM13G0xnz3jOY=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.194])
	by sina.com (10.54.253.32) with ESMTP
	id 6AD020A6000010D5; Thu, 15 Oct 2026 08:39:05 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6215844456923
X-SMAIL-UIID: C02280566B0F444891C475ABBE904BB3-20261015-083905-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+f20755f37da70df33a16@syzkaller.appspotmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Igor Putko <igorpetindev@gmail.com>
Subject: Re: [PATCH] Bluetooth: mgmt: Fix UAF in mesh_send_sync caused by race in mesh queue
Date: Thu, 15 Oct 2026 08:38:51 +0800
Message-ID: <20261015003852.532-1-hdanton@sina.com>
In-Reply-To: <20261014160504.42527-1-igorpetindev@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test upstream  master

A race condition between mesh_send() and mesh_next() can lead to the
same struct mgmt_mesh_tx object being queued twice into the cmd_sync
work list.

Specifically, mesh_send_done_sync() and mesh_send_start_complete() clear
the HCI_MESH_SENDING flag before mesh_next() is executed or without
holding hci_dev_lock. If a concurrent mesh_send() arrives during this
window, it observes HCI_MESH_SENDING as cleared, adds the new mesh_tx
to hdev->mesh_pending, and queues it via hci_cmd_sync_queue().
Immediately thereafter, mesh_next() executes without holding
hci_dev_lock, inspects hdev->mesh_pending with mgmt_mesh_next(), and
queues the very same mesh_tx a second time.

When the first queued entry finishes, its completion callback invokes
mesh_send_complete(), which frees the mesh_tx structure. When the worker
subsequently picks up the duplicate second entry, mesh_send_sync()
attempts to access fields in the already freed mesh_tx, triggering a
KASAN slab-use-after-free read.

Fix this by:
1. Synchronizing mesh_next() under hci_dev_lock and checking if
   HCI_MESH_SENDING is already set before queueing.
2. Holding hci_dev_lock when modifying HCI_MESH_SENDING and completing
   mesh transactions in mesh_send_done_sync() and
   mesh_send_start_complete().
3. Unconditionally removing mesh_tx if hci_cmd_sync_queue() fails in
   mesh_send().

Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Reported-by: syzbot+f20755f37da70df33a16@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=d2762f31ce58dfcb900c2db500bf361f165c07bc
Signed-off-by: Igor Putko <igorpetindev@gmail.com>
---
 net/bluetooth/mgmt.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 251a896babd5..0dda38af00ec 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1094,13 +1094,15 @@ static int mesh_send_done_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_mesh_tx *mesh_tx;
 
-	hci_dev_clear_flag(hdev, HCI_MESH_SENDING);
 	if (list_empty(&hdev->adv_instances))
 		hci_disable_advertising_sync(hdev);
-	mesh_tx = mgmt_mesh_next(hdev, NULL);
 
+	hci_dev_lock(hdev);
+	mesh_tx = mgmt_mesh_next(hdev, NULL);
 	if (mesh_tx)
 		mesh_send_complete(hdev, mesh_tx, false);
+	hci_dev_clear_flag(hdev, HCI_MESH_SENDING);
+	hci_dev_unlock(hdev);
 
 	return 0;
 }
@@ -1109,18 +1111,30 @@ static int mesh_send_sync(struct hci_dev *hdev, void *data);
 static void mesh_send_start_complete(struct hci_dev *hdev, void *data, int err);
 static void mesh_next(struct hci_dev *hdev, void *data, int err)
 {
-	struct mgmt_mesh_tx *mesh_tx = mgmt_mesh_next(hdev, NULL);
+	struct mgmt_mesh_tx *mesh_tx;
+	int ret;
 
-	if (!mesh_tx)
+	hci_dev_lock(hdev);
+
+	if (hci_dev_test_flag(hdev, HCI_MESH_SENDING)) {
+		hci_dev_unlock(hdev);
 		return;
+	}
 
-	err = hci_cmd_sync_queue(hdev, mesh_send_sync, mesh_tx,
-				 mesh_send_start_complete);
+	mesh_tx = mgmt_mesh_next(hdev, NULL);
+	if (!mesh_tx) {
+		hci_dev_unlock(hdev);
+		return;
+	}
 
-	if (err < 0)
+	ret = hci_cmd_sync_queue(hdev, mesh_send_sync, mesh_tx,
+				 mesh_send_start_complete);
+	if (ret < 0)
 		mesh_send_complete(hdev, mesh_tx, false);
 	else
 		hci_dev_set_flag(hdev, HCI_MESH_SENDING);
+
+	hci_dev_unlock(hdev);
 }
 
 static void mesh_send_done(struct work_struct *work)
@@ -2309,9 +2323,12 @@ static void mesh_send_start_complete(struct hci_dev *hdev, void *data, int err)
 	/* Report any errors here, but don't report completion */
 
 	if (mgmt_err) {
+		hci_dev_lock(hdev);
 		hci_dev_clear_flag(hdev, HCI_MESH_SENDING);
 		/* Send Complete Error Code for handle */
 		mesh_send_complete(hdev, mesh_tx, false);
+		hci_dev_unlock(hdev);
+
 		if (err != -ECANCELED)
 			mesh_next(hdev, NULL, 0);
 		return;
@@ -2541,10 +2558,8 @@ static int mesh_send(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
 				      MGMT_STATUS_FAILED);
 
-		if (mesh_tx) {
-			if (sending)
-				mgmt_mesh_remove(mesh_tx);
-		}
+		if (mesh_tx)
+			mgmt_mesh_remove(mesh_tx);
 	} else {
 		hci_dev_set_flag(hdev, HCI_MESH_SENDING);
 
-- 
2.47.3
