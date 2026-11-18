Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010731;
	b=bamY7fCJn6NgPFy558XPDRxzj3J8BwRZx1a0eu5A4YfG/XXsB5wlLMtHxmpE5WM+KiFe
	 JD7BeNnMEdFSIwyP5VVD+lpnCABg/qnFS6X1Z0TBAfqQ1HMgujlER7Y3YpydGM9u3lh10
	 /hnnt/rcC7HiYXlW8CiqePF1GI557BueuK0gA6yhbT0rZrvtK1+Je+ahDQkXFlrq8OQZK
	 fMB+76mJY8qNVdjyB6TWPdfDsvKcuT7jUhrS+6XruxnhQm3K3XD81RyuoAjIWiOBgPlZr
	 VL5UOgdz55wDEwP4uOZItEDw5yezVgt4PJeKORLkT8DWXVZUxoexXMyQwMWzWYqlCwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010731;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Uxwhy0o+X5KUc2XoZP1Ee3r9SdhBd3ZHqWg3FlhSUsk=;
	b=kV+NgFVJzaD5es2C5RJdyS0RkDQ+1wg1D6Icf/o4XVfbtejxMrYJsvyAn/dzg3gedolo
	 dtjcXzY+lhVy4MhizUYHdzdLQ7TdnRSy/vNp0+1sMjfIiFiB2p8wlxYDnyDD1vtEoz5GJ
	 3pyCjTk5d1luX4KmmT0yqAE02j61RJI6z03Q0NaSy9RVZ3Ca0R7PSxCMASpfCnQ1R71eL
	 W1qxU1P2KEBTmASR7TsadmI/Nio9vWWXgKNn9CBdfa9Q13nDWEyRSaWEe4kAGs6RlaGMj
	 2Y6f+0x4XprgDQYPFndbtvzJ3Nn1dZqOmUw8nFsVQegr8GWH8ucDq4IHtIJ0+mDh52g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MnxlNJkM;
	arc=none smtp.remote-ip=209.85.222.43
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7546606A33D
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 14:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7546606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MnxlNJkM
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-99e145569c6so258785241.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 06:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795010730; x=1795615530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Uxwhy0o+X5KUc2XoZP1Ee3r9SdhBd3ZHqWg3FlhSUsk=;
        b=MnxlNJkMqSWBgVVYB0HnvFAIYkW3Ca2Z4PKaKj6ZfYRxFIiP/vzRyiysyPx2i8Ufih
         q1M0vGiCaIKAJK3iaMVS8/1nrWPJg4wnCiaeted7OZN0ZkcxnGMDyndJE20yNvLSXcJo
         ZCIMkWpZFMNL8Tqt9bfm1hJT9TXQJZ/2KwvIWjU9lHEOCnXpuorDTbnbG72RAC3/pei5
         DDVwMtYltuwqssF+Kg+KMLofmcA2Dj4H+/w9giiwhkUwrjfp4auL6gL7C7VUvYuAL+4Z
         35QX+DwiTGuTSR/Di6/3cgl1xLBYqoQeGzmSyrpxud8hBPrGE2yjt+KrqAS0MjLPUs5f
         UiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010730; x=1795615530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Uxwhy0o+X5KUc2XoZP1Ee3r9SdhBd3ZHqWg3FlhSUsk=;
        b=ytiraISZ1InFm4K+V2nsM50zJz/DlF0AxfjPUpUIV/h9pNWB+5x+IcI6qfogAMPsqd
         LLvz804Wre2H55V7/94jsy/nCBFtnqv0gDpDvVQ0QSqAmZaQIvyfxN5uO86RUkVsGXtv
         +LS27ZVv9d6x6jVUvIy2nNi9OXrSTsTnkj6NH3wLW6eQUCFaJgjl3/PwRW7WjwfwZ+XR
         vukajvOZ+9tyVCFZe0Xck3t2Br6jdIRuSXyeFBdPywe9n3oafDpSmNXhwya4psQMwLAB
         jINsuxesEK/JD4y8LsS8T019QN/hrtif6fDwx0ch4eMWqKxX1b55oVwfwIypYL4clBQR
         zEEw==
X-Gm-Message-State: APuU4Z+PprMemnlebSOn0vPfWQs9emBDigXWnR7G635EqIgr1nDBF+rx
	YT53ZNo8pQq44kbrkRR6zprk1Gj6DHkitsL7DM9re1S5W0E84lcqmRWILfpyqx5N
X-Gm-Gg: AYBFou1Lq2wKbn8m6pB0YCaQ/TA2lVos3FfDq6mBpmAFDd/JJfNLtRfDi9zJFbhN/cX
	7b8TEx7FbdmX5yUsFJWUgkFm97FWgSc+2s0x9YbIynVk0KmYaK17Oc2yt6hJESCqpaxhPuR9ACF
	JgsaGq9fR/RzUM+xP0CnT6ySc8N5+l8vBkpokIuhg1+nb/n4Jh+1mQErw+teLkV55FGYqTnjQUE
	A0dlNhSlJYCgRTAI7lARM3v41oheB+7ZTupsEK2eUpz/YY+UOg1E0C/NLjqeNFvaiIpcDZIKYGL
	2DsbVVn3uFtSxHp/CPpAgcYuadvzMnfvhNstGb5ImIdHhnfaFy2E2DQ4DVgYMB1uexN3EDMIqNR
	ElzlQlACLgeigm47C5pUCsWZ5IvnD5VxHP9NunhRbLYTbImtHfjF5CujwvThHDGf456Q/0dpbHK
	N5k+gX6kiUGyw8CvcCC+pr4MqcABpOQ8vFo3KdkZ6EEY3vK1NrU+NxTrr7WaR7/6pljVMh+4Bog
	tsGcM4yzBFd2P80hOT8cqZODLvxop3pszr2p3cojTpgbhAUkv309Jh2heLshs2QMz/x5huN/B+o
	iqLr7QaRC5UE6Yerk1fuIT4CCpoqAi8ZrD7Cr9xEkwrSDb0BIO0yjAjL5qZGzeuIOXjBlEFa7wY
	0ef2QT/RDXnWGOIiWVngvc/DAw/UMTqlfbS9Hup1uRefG+HhCwxZUdtG+f0UNZJy0iFBaw0kgIM
	dUOGdS
X-Received: by 2002:a67:e112:0:b0:7d2:cdd6:6be with SMTP id ada2fe7eead31-7d6ba40ed05mr566140137.21.1795010729655;
        Wed, 18 Nov 2026 06:05:29 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b914e10esm1697639137.3.2026.11.18.06.05.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:05:29 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 11/17] Bluetooth: mgmt: Fix mesh transmission locking and lifetime
Date: Wed, 18 Nov 2026 09:05:12 -0500
Message-ID: <20261118140518.59878-12-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118140518.59878-1-luiz.dentz@gmail.com>
References: <20261118140518.59878-1-luiz.dentz@gmail.com>
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
cmd_sync callbacks and Mesh Send Cancel add/remove entries and touch
hdev->adv_instances without it, which corrupts the list and the advertising
instances. In addition the queued mesh_send_sync entry holds a raw pointer
to the mesh_tx which a cancel of the transmission can free while the entry
is running, leading to use-after-free.

Fix this by:
 - taking hdev->lock around every mesh_pending/adv_instances access in the
   cmd_sync callbacks and Mesh Send Cancel, but never across HCI commands;
 - queueing the cmd_sync entries with the transmission handle and looking
   it up under the lock instead of passing the pointer;
 - always sending the first transmission, tracked by HCI_MESH_SENDING which
   is only cleared together with the removal of the transmission so Mesh
   Send can't start another one in between, and making sure none is left
   stranded if queueing fails;
 - cancelling a transmission by dequeuing its entry, and the done entry if
   it is the one in progress, stopping the done timer, which is queued
   with hdev->lock held so a cancel can't miss it;
 - not taking hdev->lock from callbacks invoked with -ECANCELED since
   those run with the cmd_sync lock held, the transmission is removed by
   whoever cancelled the entry;
 - removing the transmissions left and clearing HCI_MESH_SENDING when the
   controller is powered off or the index is removed, as nothing is going
   to send them, and not reporting the completion of a transmission that
   failed to be queued by Mesh Send itself since userspace wasn't told
   about its handle.

Reported-by: sashiko.dev (linux-4ab89465-fc27-4d91-a870-a8ed49b22e91)
Reported-by: sashiko.dev (linux-ab941894-dbe1-49da-8bac-c52efda6eaee)
Reported-by: sashiko.dev (linux-4016f774-7ac7-4b8a-916f-587ec9d597d4)
Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 274 +++++++++++++++++++++++++++++++++----------
 1 file changed, 215 insertions(+), 59 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fc0be4ca033f..773411406300 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1087,6 +1087,7 @@ static void discov_off(struct work_struct *work)
 
 static int send_settings_rsp(struct sock *sk, u16 opcode, struct hci_dev *hdev);
 
+/* This function requires the caller holds hdev->lock */
 static void mesh_send_complete(struct hci_dev *hdev,
 			       struct mgmt_mesh_tx *mesh_tx, bool silent)
 {
@@ -1099,37 +1100,95 @@ static void mesh_send_complete(struct hci_dev *hdev,
 	mgmt_mesh_remove(mesh_tx);
 }
 
-static int mesh_send_done_sync(struct hci_dev *hdev, void *data)
+/* The cmd_sync entries identify the transmission by handle rather than by
+ * pointer since the mesh_tx can be removed while the entry is queued or
+ * running.
+ */
+#define MESH_TX_DATA(_handle)	((void *)(unsigned long)(_handle))
+#define MESH_TX_HANDLE(_data)	((u8)(unsigned long)(_data))
+
+static int mesh_send_sync(struct hci_dev *hdev, void *data);
+static void mesh_send_start_complete(struct hci_dev *hdev, void *data, int err);
+
+/* Start sending the first transmission unless one is already in progress,
+ * HCI_MESH_SENDING is set while the first transmission is being sent.
+ * Completion is not reported for @new, the handle of a transmission userspace
+ * wasn't told about yet.
+ *
+ * This function requires the caller holds hdev->lock.
+ */
+static void __mesh_next(struct hci_dev *hdev, u8 new)
 {
 	struct mgmt_mesh_tx *mesh_tx;
+	int err;
 
-	hci_dev_clear_flag(hdev, HCI_MESH_SENDING);
-	if (list_empty(&hdev->adv_instances))
-		hci_disable_advertising_sync(hdev);
-	mesh_tx = mgmt_mesh_next(hdev, NULL);
-
-	if (mesh_tx)
-		mesh_send_complete(hdev, mesh_tx, false);
+	while (!hci_dev_test_flag(hdev, HCI_MESH_SENDING)) {
+		mesh_tx = mgmt_mesh_next(hdev, NULL);
+		if (!mesh_tx)
+			return;
 
-	return 0;
+		err = hci_cmd_sync_queue(hdev, mesh_send_sync,
+					 MESH_TX_DATA(mesh_tx->handle),
+					 mesh_send_start_complete);
+		if (err < 0)
+			mesh_send_complete(hdev, mesh_tx,
+					   mesh_tx->handle == new);
+		else
+			hci_dev_set_flag(hdev, HCI_MESH_SENDING);
+	}
 }
 
-static int mesh_send_sync(struct hci_dev *hdev, void *data);
-static void mesh_send_start_complete(struct hci_dev *hdev, void *data, int err);
 static void mesh_next(struct hci_dev *hdev, void *data, int err)
 {
-	struct mgmt_mesh_tx *mesh_tx = mgmt_mesh_next(hdev, NULL);
-
-	if (!mesh_tx)
+	/* The entry is being cancelled with the cmd_sync lock held, which
+	 * can't be taken before hdev->lock.
+	 */
+	if (err == -ECANCELED)
 		return;
 
-	err = hci_cmd_sync_queue(hdev, mesh_send_sync, mesh_tx,
-				 mesh_send_start_complete);
+	hci_dev_lock(hdev);
+	__mesh_next(hdev, 0);
+	hci_dev_unlock(hdev);
+}
 
-	if (err < 0)
+static int mesh_send_done_sync(struct hci_dev *hdev, void *data)
+{
+	struct mgmt_mesh_tx *mesh_tx;
+	u8 handle;
+	bool disable;
+
+	hci_dev_lock(hdev);
+
+	mesh_tx = mgmt_mesh_next(hdev, NULL);
+	if (!mesh_tx || !hci_dev_test_flag(hdev, HCI_MESH_SENDING)) {
+		hci_dev_unlock(hdev);
+		return 0;
+	}
+
+	handle = mesh_tx->handle;
+	disable = list_empty(&hdev->adv_instances);
+
+	hci_dev_unlock(hdev);
+
+	if (disable)
+		hci_disable_advertising_sync(hdev);
+
+	hci_dev_lock(hdev);
+
+	/* The transmission can be cancelled meanwhile, in which case whoever
+	 * did so already moved on to the next one. HCI_MESH_SENDING is only
+	 * cleared with the transmission removed so Mesh Send doesn't start
+	 * another one in between.
+	 */
+	mesh_tx = mgmt_mesh_find(hdev, handle);
+	if (mesh_tx) {
 		mesh_send_complete(hdev, mesh_tx, false);
-	else
-		hci_dev_set_flag(hdev, HCI_MESH_SENDING);
+		hci_dev_clear_flag(hdev, HCI_MESH_SENDING);
+	}
+
+	hci_dev_unlock(hdev);
+
+	return 0;
 }
 
 static void mesh_send_done(struct work_struct *work)
@@ -1143,6 +1202,22 @@ static void mesh_send_done(struct work_struct *work)
 	hci_cmd_sync_queue(hdev, mesh_send_done_sync, NULL, mesh_next);
 }
 
+/* Nothing is going to send the transmissions left, e.g. when the controller
+ * is powered off.
+ *
+ * This function requires the caller holds hdev->lock.
+ */
+static void mesh_flush(struct hci_dev *hdev, bool silent)
+{
+	struct mgmt_mesh_tx *mesh_tx;
+
+	cancel_delayed_work_sync(&hdev->mesh_send_done);
+	hci_dev_clear_flag(hdev, HCI_MESH_SENDING);
+
+	while ((mesh_tx = mgmt_mesh_next(hdev, NULL)))
+		mesh_send_complete(hdev, mesh_tx, silent);
+}
+
 static void mgmt_init_hdev(struct sock *sk, struct hci_dev *hdev)
 {
 	if (hci_dev_test_flag(hdev, HCI_MGMT))
@@ -2310,38 +2385,71 @@ static int set_mesh(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 static void mesh_send_start_complete(struct hci_dev *hdev, void *data, int err)
 {
-	struct mgmt_mesh_tx *mesh_tx = data;
-	struct mgmt_cp_mesh_send *send = (void *)mesh_tx->param;
-	unsigned long mesh_send_interval;
+	struct mgmt_mesh_tx *mesh_tx;
+	struct mgmt_cp_mesh_send *send;
 	u8 mgmt_err = mgmt_status(err);
 
+	/* The entry is being cancelled with the cmd_sync lock held, which
+	 * can't be taken before hdev->lock, so leave the removal of the
+	 * transmission, and HCI_MESH_SENDING, to whoever cancelled it or to
+	 * mgmt_power_off() if the controller is going down.
+	 */
+	if (err == -ECANCELED)
+		return;
+
+	hci_dev_lock(hdev);
+
+	/* Cancelled while the entry was running, whoever did so already moved
+	 * on to the next transmission.
+	 */
+	mesh_tx = mgmt_mesh_find(hdev, MESH_TX_HANDLE(data));
+	if (!mesh_tx) {
+		hci_dev_unlock(hdev);
+		return;
+	}
+
 	/* Report any errors here, but don't report completion */
 
 	if (mgmt_err) {
-		hci_dev_clear_flag(hdev, HCI_MESH_SENDING);
 		/* Send Complete Error Code for handle */
 		mesh_send_complete(hdev, mesh_tx, false);
-		if (err != -ECANCELED)
-			mesh_next(hdev, NULL, 0);
+		hci_dev_clear_flag(hdev, HCI_MESH_SENDING);
+		__mesh_next(hdev, 0);
+		hci_dev_unlock(hdev);
 		return;
 	}
 
-	mesh_send_interval = msecs_to_jiffies((send->cnt) * 25);
+	/* Queued with hdev->lock held so a cancel can't miss it */
+	send = (void *)mesh_tx->param;
 	queue_delayed_work(hdev->req_workqueue, &hdev->mesh_send_done,
-			   mesh_send_interval);
+			   msecs_to_jiffies((send->cnt) * 25));
+
+	hci_dev_unlock(hdev);
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
@@ -2379,6 +2487,8 @@ static int mesh_send_sync(struct hci_dev *hdev, void *data)
 		instance = 0;
 	}
 
+	hci_dev_unlock(hdev);
+
 	if (instance)
 		return hci_schedule_adv_instance_sync(hdev, instance, true);
 
@@ -2422,37 +2532,80 @@ static int mesh_features(struct sock *sk, struct hci_dev *hdev,
 	return 0;
 }
 
+/* Cancel a single transmission, the handle is looked up again after the
+ * entry has been dequeued since it may be gone or have completed meanwhile.
+ */
+static void mesh_cancel_tx(struct hci_dev *hdev, u8 handle)
+{
+	struct mgmt_mesh_tx *mesh_tx;
+	bool in_progress;
+
+	hci_cmd_sync_dequeue(hdev, mesh_send_sync, MESH_TX_DATA(handle), NULL);
+
+	hci_dev_lock(hdev);
+	mesh_tx = mgmt_mesh_find(hdev, handle);
+	in_progress = mesh_tx && hci_dev_test_flag(hdev, HCI_MESH_SENDING) &&
+		      mesh_tx == mgmt_mesh_next(hdev, NULL);
+	hci_dev_unlock(hdev);
+
+	/* The done timer may have fired already and be waiting to complete
+	 * the transmission in progress, which is being cancelled.
+	 */
+	if (in_progress)
+		hci_cmd_sync_dequeue(hdev, mesh_send_done_sync, NULL, NULL);
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
+		mesh_send_complete(hdev, mesh_tx, false);
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
+			mesh_cancel_tx(hdev, handle);
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
+			mesh_cancel_tx(hdev, handle);
 	}
 
 	mgmt_cmd_complete(cmd->sk, hdev->id, MGMT_OP_MESH_SEND_CANCEL,
 			  0, NULL, 0);
 
-	if (!hci_dev_test_flag(hdev, HCI_MESH_SENDING))
-		mesh_next(hdev, NULL, 0);
+	mesh_next(hdev, NULL, 0);
 
 	return 0;
 }
@@ -2503,7 +2656,6 @@ static int mesh_send(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	struct mgmt_cp_mesh_send *send = data;
 	struct mgmt_rp_mesh_read_features rp;
 	u16 expected_len;
-	bool sending;
 	int err = 0;
 
 	if (!lmp_le_capable(hdev) ||
@@ -2536,27 +2688,27 @@ static int mesh_send(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		goto done;
 	}
 
-	sending = hci_dev_test_flag(hdev, HCI_MESH_SENDING);
 	mesh_tx = mgmt_mesh_add(sk, hdev, send, len);
-
-	if (!mesh_tx)
+	if (!mesh_tx) {
 		err = -ENOMEM;
-	else if (!sending)
-		err = hci_cmd_sync_queue(hdev, mesh_send_sync, mesh_tx,
-					 mesh_send_start_complete);
+	} else {
+		u8 handle = mesh_tx->handle;
+
+		/* The first transmission is the one queued, which may not be
+		 * the one just added.
+		 */
+		__mesh_next(hdev, handle);
+
+		/* Queueing failed, the transmission was removed */
+		if (!mgmt_mesh_find(hdev, handle))
+			err = -EIO;
+	}
 
 	if (err < 0) {
 		bt_dev_err(hdev, "Send Mesh Failed %d", err);
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
 				      MGMT_STATUS_FAILED);
-
-		if (mesh_tx) {
-			if (sending)
-				mgmt_mesh_remove(mesh_tx);
-		}
 	} else {
-		hci_dev_set_flag(hdev, HCI_MESH_SENDING);
-
 		mgmt_cmd_complete(sk, hdev->id, MGMT_OP_MESH_SEND, 0,
 				  &mesh_tx->handle, 1);
 	}
@@ -9920,7 +10072,8 @@ void mgmt_index_removed(struct hci_dev *hdev)
 	cancel_delayed_work_sync(&hdev->discov_off);
 	cancel_delayed_work_sync(&hdev->service_cache);
 	cancel_delayed_work_sync(&hdev->rpa_expired);
-	cancel_delayed_work_sync(&hdev->mesh_send_done);
+
+	mesh_flush(hdev, true);
 }
 
 void mgmt_power_on(struct hci_dev *hdev, int err)
@@ -9969,6 +10122,9 @@ void __mgmt_power_off(struct hci_dev *hdev)
 
 	mgmt_pending_foreach(0, hdev, true, cmd_complete_rsp, &match);
 
+	/* The entries being sent were cancelled by the cmd_sync cleanup */
+	mesh_flush(hdev, false);
+
 	if (memcmp(hdev->dev_class, zero_cod, sizeof(zero_cod)) != 0) {
 		mgmt_limited_event(MGMT_EV_CLASS_OF_DEV_CHANGED, hdev,
 				   zero_cod, sizeof(zero_cod),
-- 
2.56.0

