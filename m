Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941870;
	b=aRe+t89sQ423DBG3nNAygcoIV7qnKcXrPiSykyhCLpUHpfkNRO+AtySIBdhXd+vbk9gY
	 swstqNYziuVRM8cLqIawG5pIjMqR/Ho3a6JQ178TQ/GJZ9heGZ/b40SSzCy3lvzvlWeJw
	 CO9Fdhrr7T3s7JwTrAeQNuhMIzEt92WSu7iHALTrryAjIBDICtgw17vfKdIYX6lyXcqI4
	 qtZMvEZ4YaVjUSd3WT9M6td0SAlhGdQeiXC418Cwu/WUMLm6A9iuDzuNVH38gmRzFhilG
	 LZYlFulpJ1ie4wrLrsVNOUEQNP2x/0twkbP8kN5GSRJCyAAvpbrWOvPMe9FggGMXP6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941870;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Lj6O8iUfhLf6pTIA8Z/ZsVVYly0/CRqpt0rkIHUNL3k=;
	b=ZAHRrJOEyqdSGouHooY0LyrTeRBOkMOTGZjXVE2u9fy+S7K51lBItYpSBBjxfQ31B9PO
	 SLPjgdqTO1uHQH1S+IDPP+swJgI+hjy1leFD37Jel9hK0gNMe61qXlcwP6bkvWba0AFca
	 k3YhFCRcPjhm69LD763F6pkz7xbTmXF+UVlELzuS1lnMPKjz+gX1pW40FSY7ffU/fS0Hj
	 iBFBiAR9kXLy51qZ3RvUqkteTHVQsqg5rAwQQ8eTMu9+vz/3TVv6ElWT88UhpnI/u0hs9
	 it0do7Lpmy8EQgKbf95Ii1bykosNCLdYrNTAIXMvyLlzyVp2ggZfU7SOUtbcZG8VxQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iYIKNRkl;
	arc=none smtp.remote-ip=209.85.217.42
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1619606A338
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 18:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1619606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iYIKNRkl
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7d2da1667b2so56693137.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 10:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794941869; x=1795546669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Lj6O8iUfhLf6pTIA8Z/ZsVVYly0/CRqpt0rkIHUNL3k=;
        b=iYIKNRkl20S+mlzGC+EZcpALSXw/H16iaJ6qQy3IL6LDr3UyKKA7Gtdbv0KEK77dud
         yIyvo9kWOSPLnUwhlrYVbc9HJO1W693QPhW4zjSECnt4ylUKa38SvQxun6ON+1eaLvfl
         Dh1OBM9HdpK2STa8Kgp9U23/ptIubdgCYNrN3WkLAImRoKbVNPW0SNQjMWMmHi3mOHF3
         BMSi/Hkb7/lKikezN5y6LLMzIq2chV7FFvVs4xo3hzEefG0Tfw7ZP8iMMo6v4MszvNLD
         a/1T1N3dWpl3hEBdN4XCc/RxInxg5o0q5fAnZGr/zDHnUuqgitS/QDiLmpIzS5ave8bR
         AqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941869; x=1795546669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Lj6O8iUfhLf6pTIA8Z/ZsVVYly0/CRqpt0rkIHUNL3k=;
        b=c9twH1bDZr4suLJ0uvrtuHhOlgiD6/LH2njeRnA+i+ui9kj5iNPTwpzPmD+ZbvymLs
         RaqgvbZDophzlXnzEwudCKdUpLocZV4iFCSr+8XnrP98P9TYpefJHEQP5lmWe981pg0x
         +doEmniAl9OnWwRAR387QjPqrAfiH60jBoZTwA/sxFeLJGGwUXpY2+R5dafNZcHi8E0u
         1alW5rvQVswAWzvFyrf7FtqQ0CbJHMq3nVc1puSZEeQ1zz6Kyf6Baj2lo2mACUV0S0Rx
         bWIA531KzWlrxSBeSTXBV1WRHrCeM1WO9xjJVooi2YLu8cYSWCkCzN1ayQSX2cKpWsvT
         i/bQ==
X-Gm-Message-State: APuU4Z91G0OPB0yADJfWmdPAHSah9NPUCT/vQF+0h2IOwtHl6+VGkv81
	SITUb7ksA6u/LUYjbrYZkaWAfqrDLf9oD1895ePYxT5yHVl9fF2xi8MYvlFIEg==
X-Gm-Gg: AYBFou0Zwg6KICfrbYbDSg3d5RxWf3X0zBo4zj5eo7vGcik+sLt25cQEmAiJ3Z+Vxay
	S1KT9y/oZ9d7CGEMASSvmHCAPakVHdsaXCJ3BEqfqLrydI6bno0v8KMWIMdBQkXbaTRpiDXO0I/
	ZeddmrCd4xD25tgVqUiT2FuRchlPyss0qG2QwpReIqDsJA6ddU6ngt2spBbd8VcermhdHjvP8Lh
	fAMyZXCZCXcYEjWKzt+RoHKoVuH8fEVI5OkGnhIcM5UgAWGkAyd70Z14ziGgarawXXUiMPU4faf
	not4w6XcR2LaXF5izUobKWmGGZkqBl9LrA5XxjEqEkNPtJY+tVK4xVTbPJw/87YXGYAbUhU24Cw
	67nahnQm1FeRzwTSIATCrv+eXMCQzHi4vLHfyJgluxKYDkquw8scF+uI0+g9H5Bxd7xDs53bRzW
	xpFWbGbveHLPiy6vCfqX9Lk81RFTOuoWPXEe0ZwoMawPiovZcvb14rH0NUXhBT63Odnk/QH3W7t
	C8YsPWPqZVJGqXAIpchqZhiLH3+/6UBxD87qkiO5rgj2sOluRXWNM4OaA4JB7t3icNB1jJ3B8M9
	xPr6k0LrmIch2bozphYcy2OYDTNmKL6lrFzkEzjfCubncz8zO+3prUeOb3Fg1Rl8b96Xn29zg7H
	OZZeOGKT/CXOMEp7el/V1yGWzsMyHYUC+KvbSbzyj3trp/X4PVuGaDof4B0tRhZ83PZK2uuS3Hz
	W9RPg=
X-Received: by 2002:a05:6102:5106:b0:7c1:94eb:d72b with SMTP id ada2fe7eead31-7d64d85c3f2mr5937388137.34.1794941868660;
        Tue, 17 Nov 2026 10:57:48 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e4a1b61eesm357064241.3.2026.11.17.10.57.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 10:57:48 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 11/16] Bluetooth: mgmt: Fix mesh transmission locking and lifetime
Date: Tue, 17 Nov 2026 13:57:32 -0500
Message-ID: <20261117185737.3758255-12-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117185737.3758255-1-luiz.dentz@gmail.com>
References: <20261117185737.3758255-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The mesh_pending list is modified under hdev->lock by Mesh Send, but the
cmd_sync callbacks, Mesh Send Cancel and mgmt_cleanup() add/remove entries
and touch hdev->adv_instances without it, which corrupts the list and the
advertising instances. In addition the queued mesh_send_sync entry holds a
raw pointer to the mesh_tx which mgmt_cleanup() (socket close) or a cancel
of the running transmission can free, leading to use-after-free.

Fix this by:
 - taking hdev->lock around every mesh_pending/adv_instances access in the
   cmd_sync callbacks, send_cancel() and mgmt_cleanup(), but never across
   HCI commands;
 - queueing the cmd_sync entries with the transmission handle and looking
   it up under the lock instead of passing the pointer;
 - cancelling a transmission the same way from Mesh Send Cancel and
   mgmt_cleanup(): dequeue its entry, stop the done timer if it is the one
   in progress so the timer doesn't complete an unrelated transmission,
   then resume with the next one. mgmt_cleanup() takes references on the
   controllers instead of holding hci_dev_list_lock for this;
 - not taking hdev->lock from callbacks invoked with -ECANCELED since
   those run with the cmd_sync lock held, the transmission is removed by
   whoever cancelled the entry;
 - removing the transmissions left when the index is removed, nothing
   would send or free them afterwards;
 - removing the transmission if queueing fails in Mesh Send.

Reported-by: sashiko.dev (linux-4ab89465-fc27-4d91-a870-a8ed49b22e91)
Reported-by: sashiko.dev (linux-93ef41e7-8b48-4483-aa5d-d21f1e27c104)
Reported-by: sashiko.dev (linux-ab941894-dbe1-49da-8bac-c52efda6eaee)
Reported-by: sashiko.dev (linux-4016f774-7ac7-4b8a-916f-587ec9d597d4)
Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 234 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 196 insertions(+), 38 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fc0be4ca033f..dbaf0e0b06f5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1087,6 +1087,7 @@ static void discov_off(struct work_struct *work)
 
 static int send_settings_rsp(struct sock *sk, u16 opcode, struct hci_dev *hdev);
 
+/* This function requires the caller holds hdev->lock */
 static void mesh_send_complete(struct hci_dev *hdev,
 			       struct mgmt_mesh_tx *mesh_tx, bool silent)
 {
@@ -1102,34 +1103,65 @@ static void mesh_send_complete(struct hci_dev *hdev,
 static int mesh_send_done_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_mesh_tx *mesh_tx;
+	bool disable;
 
 	hci_dev_clear_flag(hdev, HCI_MESH_SENDING);
-	if (list_empty(&hdev->adv_instances))
+
+	hci_dev_lock(hdev);
+	disable = list_empty(&hdev->adv_instances);
+	hci_dev_unlock(hdev);
+
+	if (disable)
 		hci_disable_advertising_sync(hdev);
+
+	hci_dev_lock(hdev);
 	mesh_tx = mgmt_mesh_next(hdev, NULL);
 
 	if (mesh_tx)
 		mesh_send_complete(hdev, mesh_tx, false);
+	hci_dev_unlock(hdev);
 
 	return 0;
 }
 
+/* The cmd_sync entries identify the transmission by handle rather than by
+ * pointer since the mesh_tx can be removed while the entry is queued or
+ * running.
+ */
+#define MESH_TX_DATA(_handle)	((void *)(unsigned long)(_handle))
+#define MESH_TX_HANDLE(_data)	((u8)(unsigned long)(_data))
+
 static int mesh_send_sync(struct hci_dev *hdev, void *data);
 static void mesh_send_start_complete(struct hci_dev *hdev, void *data, int err);
 static void mesh_next(struct hci_dev *hdev, void *data, int err)
 {
-	struct mgmt_mesh_tx *mesh_tx = mgmt_mesh_next(hdev, NULL);
+	struct mgmt_mesh_tx *mesh_tx;
 
-	if (!mesh_tx)
+	/* The entry is being cancelled with the cmd_sync lock held, which
+	 * can't be taken before hdev->lock.
+	 */
+	if (err == -ECANCELED)
 		return;
 
-	err = hci_cmd_sync_queue(hdev, mesh_send_sync, mesh_tx,
+	hci_dev_lock(hdev);
+
+	/* Only start the next transmission if there is none in progress */
+	mesh_tx = mgmt_mesh_next(hdev, NULL);
+	if (!mesh_tx || hci_dev_test_flag(hdev, HCI_MESH_SENDING)) {
+		hci_dev_unlock(hdev);
+		return;
+	}
+
+	err = hci_cmd_sync_queue(hdev, mesh_send_sync,
+				 MESH_TX_DATA(mesh_tx->handle),
 				 mesh_send_start_complete);
 
 	if (err < 0)
 		mesh_send_complete(hdev, mesh_tx, false);
 	else
 		hci_dev_set_flag(hdev, HCI_MESH_SENDING);
+
+	hci_dev_unlock(hdev);
 }
 
 static void mesh_send_done(struct work_struct *work)
@@ -2310,38 +2342,73 @@ static int set_mesh(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 static void mesh_send_start_complete(struct hci_dev *hdev, void *data, int err)
 {
-	struct mgmt_mesh_tx *mesh_tx = data;
-	struct mgmt_cp_mesh_send *send = (void *)mesh_tx->param;
+	struct mgmt_mesh_tx *mesh_tx;
+	struct mgmt_cp_mesh_send *send;
 	unsigned long mesh_send_interval;
 	u8 mgmt_err = mgmt_status(err);
 
+	/* The entry is being cancelled with the cmd_sync lock held, which
+	 * can't be taken before hdev->lock, so leave the removal of the
+	 * transmission to whoever cancelled it.
+	 */
+	if (err == -ECANCELED) {
+		hci_dev_clear_flag(hdev, HCI_MESH_SENDING);
+		return;
+	}
+
+	hci_dev_lock(hdev);
+
+	mesh_tx = mgmt_mesh_find(hdev, MESH_TX_HANDLE(data));
+	if (!mesh_tx) {
+		/* Removed while being sent (e.g. its socket was closed) */
+		hci_dev_unlock(hdev);
+		hci_dev_clear_flag(hdev, HCI_MESH_SENDING);
+		mesh_next(hdev, NULL, 0);
+		return;
+	}
+
 	/* Report any errors here, but don't report completion */
 
 	if (mgmt_err) {
 		hci_dev_clear_flag(hdev, HCI_MESH_SENDING);
 		/* Send Complete Error Code for handle */
 		mesh_send_complete(hdev, mesh_tx, false);
-		if (err != -ECANCELED)
-			mesh_next(hdev, NULL, 0);
+		hci_dev_unlock(hdev);
+		mesh_next(hdev, NULL, 0);
 		return;
 	}
 
+	send = (void *)mesh_tx->param;
 	mesh_send_interval = msecs_to_jiffies((send->cnt) * 25);
+	hci_dev_unlock(hdev);
+
 	queue_delayed_work(hdev->req_workqueue, &hdev->mesh_send_done,
 			   mesh_send_interval);
 }
 
 static int mesh_send_sync(struct hci_dev *hdev, void *data)
 {
-	struct mgmt_mesh_tx *mesh_tx = data;
-	struct mgmt_cp_mesh_send *send = (void *)mesh_tx->param;
+	struct mgmt_mesh_tx *mesh_tx;
+	struct mgmt_cp_mesh_send *send;
 	struct adv_info *adv, *next_instance;
 	u8 instance = hdev->le_num_of_adv_sets + 1;
 	u16 timeout, duration;
 	int err = 0;
 
-	if (hdev->le_num_of_adv_sets <= hdev->adv_instance_cnt)
+	hci_dev_lock(hdev);
+
+	mesh_tx = mgmt_mesh_find(hdev, MESH_TX_HANDLE(data));
+	if (!mesh_tx) {
+		hci_dev_unlock(hdev);
+		return -ENOENT;
+	}
+
+	send = (void *)mesh_tx->param;
+
+	if (hdev->le_num_of_adv_sets <= hdev->adv_instance_cnt) {
+		hci_dev_unlock(hdev);
 		return MGMT_STATUS_BUSY;
+	}
 
 	timeout = 1000;
 	duration = send->cnt * INTERVAL_TO_MS(hdev->le_adv_max_interval);
@@ -2379,6 +2446,8 @@ static int mesh_send_sync(struct hci_dev *hdev, void *data)
 		instance = 0;
 	}
 
+	hci_dev_unlock(hdev);
+
 	if (instance)
 		return hci_schedule_adv_instance_sync(hdev, instance, true);
 
@@ -2422,37 +2491,67 @@ static int mesh_features(struct sock *sk, struct hci_dev *hdev,
 	return 0;
 }
 
+/* Cancel a single transmission, the handle is looked up again after the
+ * entry has been dequeued since it may be gone or have completed meanwhile.
+ */
+static void mesh_cancel_tx(struct hci_dev *hdev, u8 handle, bool silent)
+{
+	struct mgmt_mesh_tx *mesh_tx;
+
+	hci_cmd_sync_dequeue(hdev, mesh_send_sync, MESH_TX_DATA(handle), NULL);
+
+	hci_dev_lock(hdev);
+
+	mesh_tx = mgmt_mesh_find(hdev, handle);
+	if (mesh_tx) {
+		/* If it is the transmission in progress make sure the timer
+		 * doesn't complete the next one in its place.
+		 */
+		if (hci_dev_test_flag(hdev, HCI_MESH_SENDING) &&
+		    mesh_tx == mgmt_mesh_next(hdev, NULL)) {
+			cancel_delayed_work(&hdev->mesh_send_done);
+			hci_dev_clear_flag(hdev, HCI_MESH_SENDING);
+		}
+
+		mesh_send_complete(hdev, mesh_tx, silent);
+	}
+
+	hci_dev_unlock(hdev);
+}
+
 static int send_cancel(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
 	struct mgmt_cp_mesh_send_cancel *cancel = (void *)cmd->param;
 	struct mgmt_mesh_tx *mesh_tx;
+	u8 handle;
 
 	if (!cancel->handle) {
-		do {
+		for (;;) {
+			hci_dev_lock(hdev);
 			mesh_tx = mgmt_mesh_next(hdev, cmd->sk);
+			handle = mesh_tx ? mesh_tx->handle : 0;
+			hci_dev_unlock(hdev);
 
-			if (mesh_tx) {
-				if (!hci_cmd_sync_dequeue(hdev, mesh_send_sync,
-							  mesh_tx, NULL))
-					mesh_send_complete(hdev, mesh_tx, false);
-			}
-		} while (mesh_tx);
+			if (!mesh_tx)
+				break;
+
+			mesh_cancel_tx(hdev, handle, false);
+		}
 	} else {
+		hci_dev_lock(hdev);
 		mesh_tx = mgmt_mesh_find(hdev, cancel->handle);
+		handle = mesh_tx && mesh_tx->sk == cmd->sk ? mesh_tx->handle : 0;
+		hci_dev_unlock(hdev);
 
-		if (mesh_tx && mesh_tx->sk == cmd->sk) {
-			if (!hci_cmd_sync_dequeue(hdev, mesh_send_sync,
-						  mesh_tx, NULL))
-				mesh_send_complete(hdev, mesh_tx, false);
-		}
+		if (handle)
+			mesh_cancel_tx(hdev, handle, false);
 	}
 
 	mgmt_cmd_complete(cmd->sk, hdev->id, MGMT_OP_MESH_SEND_CANCEL,
 			  0, NULL, 0);
 
-	if (!hci_dev_test_flag(hdev, HCI_MESH_SENDING))
-		mesh_next(hdev, NULL, 0);
+	mesh_next(hdev, NULL, 0);
 
 	return 0;
 }
@@ -2542,7 +2641,8 @@ static int mesh_send(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	if (!mesh_tx)
 		err = -ENOMEM;
 	else if (!sending)
-		err = hci_cmd_sync_queue(hdev, mesh_send_sync, mesh_tx,
+		err = hci_cmd_sync_queue(hdev, mesh_send_sync,
+					 MESH_TX_DATA(mesh_tx->handle),
 					 mesh_send_start_complete);
 
 	if (err < 0) {
@@ -2550,10 +2650,8 @@ static int mesh_send(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
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
 
@@ -9892,6 +9990,7 @@ void mgmt_index_added(struct hci_dev *hdev)
 void mgmt_index_removed(struct hci_dev *hdev)
 {
 	struct mgmt_ev_ext_index ev;
+	struct mgmt_mesh_tx *mesh_tx;
 	struct cmd_lookup match = { NULL, hdev, MGMT_STATUS_INVALID_INDEX };
 
 	if (hci_test_quirk(hdev, HCI_QUIRK_RAW_DEVICE))
@@ -9921,6 +10020,10 @@ void mgmt_index_removed(struct hci_dev *hdev)
 	cancel_delayed_work_sync(&hdev->service_cache);
 	cancel_delayed_work_sync(&hdev->rpa_expired);
 	cancel_delayed_work_sync(&hdev->mesh_send_done);
+
+	/* Nothing is going to send or complete the transmissions left */
+	while ((mesh_tx = mgmt_mesh_next(hdev, NULL)))
+		mesh_send_complete(hdev, mesh_tx, true);
 }
 
 void mgmt_power_on(struct hci_dev *hdev, int err)
@@ -11103,19 +11206,74 @@ void mgmt_exit(void)
 
 void mgmt_cleanup(struct sock *sk)
 {
-	struct mgmt_mesh_tx *mesh_tx;
+	struct hci_dev **hdevs;
 	struct hci_dev *hdev;
+	int i, n, count;
 
-	read_lock(&hci_dev_list_lock);
+	/* hci_dev_list_lock can't be held while taking hdev->lock so take
+	 * references on the controllers first.
+	 */
+	for (;;) {
+		bool more = false;
+
+		read_lock(&hci_dev_list_lock);
+		count = 0;
+		list_for_each_entry(hdev, &hci_dev_list, list)
+			count++;
+		read_unlock(&hci_dev_list_lock);
+
+		if (!count)
+			return;
+
+		hdevs = kcalloc(count, sizeof(*hdevs), GFP_KERNEL);
+		if (!hdevs)
+			return;
+
+		n = 0;
+		read_lock(&hci_dev_list_lock);
+		list_for_each_entry(hdev, &hci_dev_list, list) {
+			if (n == count) {
+				more = true;
+				break;
+			}
+			hdevs[n++] = hci_dev_hold(hdev);
+		}
+		read_unlock(&hci_dev_list_lock);
+
+		if (!more)
+			break;
 
-	list_for_each_entry(hdev, &hci_dev_list, list) {
-		do {
+		/* The list grew meanwhile, retry */
+		for (i = 0; i < n; i++)
+			hci_dev_put(hdevs[i]);
+		kfree(hdevs);
+	}
+
+	for (i = 0; i < n; i++) {
+		struct mgmt_mesh_tx *mesh_tx;
+		u8 handle;
+
+		hdev = hdevs[i];
+
+		for (;;) {
+			hci_dev_lock(hdev);
 			mesh_tx = mgmt_mesh_next(hdev, sk);
+			handle = mesh_tx ? mesh_tx->handle : 0;
+			hci_dev_unlock(hdev);
+
+			if (!mesh_tx)
+				break;
 
-			if (mesh_tx)
-				mesh_send_complete(hdev, mesh_tx, true);
-		} while (mesh_tx);
+			mesh_cancel_tx(hdev, handle, true);
+		}
+
+		/* Resume the transmissions of the other sockets in case the
+		 * one in progress was removed.
+		 */
+		mesh_next(hdev, NULL, 0);
+
+		hci_dev_put(hdev);
 	}
 
-	read_unlock(&hci_dev_list_lock);
+	kfree(hdevs);
 }
-- 
2.56.0

