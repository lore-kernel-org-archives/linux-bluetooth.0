Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946846;
	b=3PIr52DXzQYjrVxXZtZFUl8mzNgJGldT3g7p1wCyyCy8gjtR+W+TL0Mkv8P4mtKRfQkO
	 OG4HyNOKWTg8HVAU5JX97eoRwRm29xRbpxT4eD486EA26N2rrGLL50bwC3cJQZpyxJ5Gt
	 RTHHBUPjdcg9AHpsmzXS+aCmmJk5Ea/kIsA0MjujMRMTJuph3c53ZVW5G9R+qCNSgvmLX
	 798WJOtjQnczTq94nn2WPsYMFC0HIJcY06U++GiFnpT3HCt/ejglM8Vk1cdY2pwvI/965
	 9jUgySZxusMo9IjuFhTxo5ixzTrjCPSNd2SkaV7PEpZ9uGVeeCDWxtZnWf6/BA8DJHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946846;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=T5ycSwl+pyr51N6kiwcxAW2kubWA8wzEHF6nPlv9R5U=;
	b=j2o6k2hm6DGDQM8PWBx8Vb/wxbyCn/vaffHD2MII8UBSBDNhY9qfh8tmyE3aQZuluatE
	 eAvDXWKiYj5t3k/XD7L6QignsKfmg+91g5DqLBzDQGYe3QG3ikV02TfAziJ7mj+TwmAN5
	 gxUASVZnP4tEfPnFudFGyeNFoqzdSYYlA9ZWb6K9w03p12+Dpq2vbv3ard7DMpZRGJTVC
	 OxqMvU7rozGNcCNcRvI6Z7DOSX7LUIN1kHDmmC6epHrKPh3h8Ckd8loWFtmmQsmRTfFwE
	 Mmf5ig+Bgm62kqGZ62D8c+jWwgYZplX0sNSO/WJc2zKo0EjApvgQW6qTrC6aWwwh+zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uER8sHTp;
	arc=none smtp.remote-ip=209.85.217.50
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837CF606A33B
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 20:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 837CF606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uER8sHTp
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7d2eba2b74aso105194137.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 12:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794946844; x=1795551644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=T5ycSwl+pyr51N6kiwcxAW2kubWA8wzEHF6nPlv9R5U=;
        b=uER8sHTpb07k7kATe5eQ03SuWx3WDUgmwOKcU3Ro5Wl2sBmuNf05/rBiwB9kvyvmuG
         dtGRLHG0AgYU1O84kREN7sLrtcU/jeRcPi71wupxJij2kUBvDeQaVv+0STqPrkDxP6hn
         umD5yKkGUHCoUY4lhH6eFaGvXeivMF43r+7laamJepDj3Tu/FVF5OazDnda9X2VRak/n
         L0jLDuDgQhkslb/JiLMOaPo7CEoGX3DHKxFBZLWd1l8BWDYkxvZ00DtXYuMY/IAiqzcj
         IMDfFGOkothZnU7v6T1TF74AWU4pr4/3m1pj+CBHeYOBalB1t28vsGxzLgPuu6hgAcQD
         cTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794946844; x=1795551644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=T5ycSwl+pyr51N6kiwcxAW2kubWA8wzEHF6nPlv9R5U=;
        b=hVQlVpZQhNKTdzkZfl8QL1A6HnRPxUN8LibEGM0JFnKWqTvY1FY9LtI5v5gCNK2xEg
         54ADCLafT2LmschoOWueE6JBzT2LxF/yIyL4TKnlA+jmJUotJkVJ0miGaYcXWX7XzVAA
         SqlSzNDwnPEeWtA2AsE0coeIO6L508GgD8YOr4EobezLdQxW9k3Mg/16T8Rt7Opa8jQ4
         zj3kokRaN23iCPZ8/B+c2IXN+7VPpYRBOJdq+ucyhFBEaZebVUsoQfEuSBewzJr1Tfdv
         fVB0wmRPKkIoQv2SiYQTBb+hV25abp2CFB1VNXTHmvR7UK3xcIMOChTAO3M/nGhI137x
         jcwg==
X-Gm-Message-State: APuU4Z9Iq6f70Ej+APunJO1vWJ9RXh+CQac4scJ/t5GElqte1f1gONUy
	ACTTj8AFh8Sa1ij5/fg4fdMVOzvl2gr3kMvrpCaCdaEP1pvv6x2zIwhnm6h1Hw==
X-Gm-Gg: AYBFou00wOW3q6rD3cRgA3wC9Mfam/Ya6iEle6lLyJoXUIWdR/wwQYTdbCn8iM68N5D
	sSnW85x4/plNbxVOcj4K8tPZPRw0LoN25IMTliQHJjx1aN4/uWvLg09hdFpZfk1XIHZ5K9B2vcd
	slP8znicfY5aTq5X/87hzzzxYM1Cft57hKuwRt6x0f6Z8jqUmg/WIwLP+2z+S6TmiRQ7z0NTg7e
	vkGZZNk1e82i8C37nPONxaOELtWPY3pQf23dwOIg01YRIWWk9O4DEAcayk7ISvHzmKW4oGhSNf8
	AKvpphOqrH26zRMjh6YcYjA2XJBGzsrUVcEXm60KR1YmHMSmqFT5PUalb7hrCLOgkaQhH1tHMRQ
	w8yE1NrMwwsVo0o0mtCoOV82Kok+iftRz6MP/tP9nNBJDqKlDsaESp6OoUbSmAl8TPnsOIjgImb
	5TmTtD39HD4vUq6bgBu4ULH+0wbNp6BCWZKna2H+nczTe9+uayNHIOWU6L2wb2apg50FOiSiNDx
	iBfhRNAzdqfmX49X/HhU5UmGwJtXIFR2EcPYFC57f1i8dn+iZSJoq/WpvlN6Mxpxt0Q47CZGJmh
	7M4bVKT5sXpVpqTERAuX2VJT4FC8OGHOK+Nr5zikrQqcicGTxfCJIFM6EmStNz9heZfM9/BuJFF
	/CoMUKOI61jns04KZ6ueeGGpud2vpOF+IkDgfZjjBXo1wIARVa2OcJ8JA2zRKi0nn3JP/OR3SN4
	ZVdxcTT2AsbnTCZL/XdHNR3FSY
X-Received: by 2002:a05:6102:2912:b0:7bb:c382:2ff4 with SMTP id ada2fe7eead31-7d6ba460aabmr64638137.20.1794946844214;
        Tue, 17 Nov 2026 12:20:44 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b935ddf3sm303166137.11.2026.11.17.12.20.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:20:43 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 11/17] Bluetooth: mgmt: Fix mesh transmission locking and lifetime
Date: Tue, 17 Nov 2026 15:20:26 -0500
Message-ID: <20261117202032.3848411-12-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117202032.3848411-1-luiz.dentz@gmail.com>
References: <20261117202032.3848411-1-luiz.dentz@gmail.com>
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
   index is removed.

Reported-by: sashiko.dev (linux-4ab89465-fc27-4d91-a870-a8ed49b22e91)
Reported-by: sashiko.dev (linux-ab941894-dbe1-49da-8bac-c52efda6eaee)
Reported-by: sashiko.dev (linux-4016f774-7ac7-4b8a-916f-587ec9d597d4)
Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 257 +++++++++++++++++++++++++++++++++----------
 1 file changed, 199 insertions(+), 58 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fc0be4ca033f..fbabe3dd1555 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1087,6 +1087,7 @@ static void discov_off(struct work_struct *work)
 
 static int send_settings_rsp(struct sock *sk, u16 opcode, struct hci_dev *hdev);
 
+/* This function requires the caller holds hdev->lock */
 static void mesh_send_complete(struct hci_dev *hdev,
 			       struct mgmt_mesh_tx *mesh_tx, bool silent)
 {
@@ -1099,37 +1100,92 @@ static void mesh_send_complete(struct hci_dev *hdev,
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
+ *
+ * This function requires the caller holds hdev->lock.
+ */
+static void __mesh_next(struct hci_dev *hdev)
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
+			mesh_send_complete(hdev, mesh_tx, false);
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
+	__mesh_next(hdev);
+	hci_dev_unlock(hdev);
+}
+
+static int mesh_send_done_sync(struct hci_dev *hdev, void *data)
+{
+	struct mgmt_mesh_tx *mesh_tx;
+	u8 handle;
+	bool disable;
 
-	if (err < 0)
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
@@ -2310,38 +2366,73 @@ static int set_mesh(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
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
+	 * transmission to whoever cancelled it. If the controller is going
+	 * down nothing is being sent anymore though.
+	 */
+	if (err == -ECANCELED) {
+		hci_dev_clear_flag(hdev, HCI_MESH_SENDING);
+		return;
+	}
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
+		__mesh_next(hdev);
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
@@ -2379,6 +2470,8 @@ static int mesh_send_sync(struct hci_dev *hdev, void *data)
 		instance = 0;
 	}
 
+	hci_dev_unlock(hdev);
+
 	if (instance)
 		return hci_schedule_adv_instance_sync(hdev, instance, true);
 
@@ -2422,37 +2515,80 @@ static int mesh_features(struct sock *sk, struct hci_dev *hdev,
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
@@ -2503,7 +2639,6 @@ static int mesh_send(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	struct mgmt_cp_mesh_send *send = data;
 	struct mgmt_rp_mesh_read_features rp;
 	u16 expected_len;
-	bool sending;
 	int err = 0;
 
 	if (!lmp_le_capable(hdev) ||
@@ -2536,27 +2671,27 @@ static int mesh_send(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
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
+		__mesh_next(hdev);
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
@@ -9892,6 +10027,7 @@ void mgmt_index_added(struct hci_dev *hdev)
 void mgmt_index_removed(struct hci_dev *hdev)
 {
 	struct mgmt_ev_ext_index ev;
+	struct mgmt_mesh_tx *mesh_tx;
 	struct cmd_lookup match = { NULL, hdev, MGMT_STATUS_INVALID_INDEX };
 
 	if (hci_test_quirk(hdev, HCI_QUIRK_RAW_DEVICE))
@@ -9921,6 +10057,11 @@ void mgmt_index_removed(struct hci_dev *hdev)
 	cancel_delayed_work_sync(&hdev->service_cache);
 	cancel_delayed_work_sync(&hdev->rpa_expired);
 	cancel_delayed_work_sync(&hdev->mesh_send_done);
+
+	/* Nothing is going to send or complete the transmissions left */
+	hci_dev_clear_flag(hdev, HCI_MESH_SENDING);
+	while ((mesh_tx = mgmt_mesh_next(hdev, NULL)))
+		mesh_send_complete(hdev, mesh_tx, true);
 }
 
 void mgmt_power_on(struct hci_dev *hdev, int err)
-- 
2.56.0

