Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795029093;
	b=YjxoUHqz/8bG9ETKdd5LaGOkG6H4i9AWko+VfKiGRa0HoBDU/pQ9+yj+p/JImQM9B4px
	 P4zBGX52d1H7T4eH8vC5qUIfFpv8DQPjKyndLXzX1r33+7EMqvEWB47BOALSVWKeHtzdQ
	 38xhSO4dYbLh3KkT2+KjDp/NJQQSaVrd58qxDV8WLKf5DzcgIKfzsltGuuloFV+kafT1u
	 xLX6oht3QV99/cOJ4wYJQH4k1vsX+CImli5faDOiGueyBvRLqCBVJJksn2nXSSZTP7RHP
	 1zVDJvdHaC5P6pCavF5pgF0nnTbfnaASiCNxUokZHGS75nHhgOOc3vKsgbjEs4Z2J1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029093;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NCKE9/nON8xox39Av6sLxez59+XTDzeBXfAvbyiusYg=;
	b=cXJwEaVCumm+SQsIPZT+x/jxZz7HLN2dyS1BaySwlQnwvfdN8oQTOHjkpveB8T+NcnQT
	 0lvc17w+V9xO7RmsvRJzJ5RNvN1QN8EU3ujpGRhuBB47nGVcnBsFlfVlrhg9i2sKXMN40
	 dtZFoE7bkbHCU8A3nB9csMTTCt80ItvH2Bg8cw1cb68b1pehPme7jU6bMXj9tAyBtn/RP
	 XwmI3/Qy7ZqGui20yGi5HqBs0+5aasypzx6TzEmjz/5LAplqmdleWC7f0ejY1yDFqD/p1
	 eNHOv2U1QaoXFXxSVQrbXGUm+sP7XD1DFTjR3HxeTucgUIxg+4tQ/XFcgzScnQcPEkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="aWmNY2f/";
	arc=none smtp.remote-ip=209.85.217.51
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE46606A333
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDE46606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aWmNY2f/
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7d2db1b9bf2so441411137.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 11:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795029092; x=1795633892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NCKE9/nON8xox39Av6sLxez59+XTDzeBXfAvbyiusYg=;
        b=aWmNY2f/G0U9fgMaxRonvsz5Qlc9teu9P0jnKtnkndeTMoMwac+hugbiFRlxhCwaEC
         pwAudiV2jm3dM/+ZSYTL+YI0Wj06cR+/DwxaFs97UFgTLc8kUteFMMuU3EWsfx0z/v0x
         g2eZL9LlQG4btvrUrIAyAFYoGBGKqb8vDBZnkUoPeIj2zbTKmCu4kyltT1MnL5NaS/jW
         hJpcjv+XqaRSEsXVwf4IdkwkYzIgfO8r2OqIqF+0FFSrTPWLSr92c1WwQKYrXw7Zzy5r
         R8bfpYoCysPLD4XY5ax8NdhGmCj6CPo3omGAGrJPKVuHrpXaGxnt3W+vxGKUK1S6s7WO
         +ejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795029092; x=1795633892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=NCKE9/nON8xox39Av6sLxez59+XTDzeBXfAvbyiusYg=;
        b=MDXrF4kWx0fHmRS3kWaSkULgxVUbpTe9728CaTiEIx3OEAWQz4HJiLe2yv0Z5eaqwa
         gYV6P4hnf2JGKRVjzMhNOCX/Q4uG7xHEvlosAGwy4UMALiSJvLPKWiV21HGsPCyHtnol
         USr7VIYs8VlCP1FdwKKLCHN4iP745DSazgref7nVQ4lDOS+AzYgH06raWA68M70FioZx
         IJK/bZHc1Pwa4CSZHKLPx1YfDd4YJwLxf/vEGcf7ui4QQgwwjYyG7azmnYcXnG//lgpf
         Rk2EO9AylE4A680dTkDhlbWoWOnV8qqCxTUUoeYRBuA5UOtZIJ2GBrpoLdTFjYQaf5Wi
         1/aA==
X-Gm-Message-State: APuU4Z+lKSAwDblF7FMqBEmSg8HUPPi0KDqGfCX9yJMnOGClF28E849t
	lV1Xwp6LNA7gNduUtTStovkvAINuvdR2+QS2kE/USMyLfeNlQPIkTDUTSyEM4xYX
X-Gm-Gg: AYBFou3GNdFRDMCJpD3DBUagIXmJu/86r0VeJaAPZ+MTO932omN5Z39lBnSdBLOTrMO
	MlHPJlGtCjONjEooNUpqmUebG+92pNWHV40+M1RJ8Jz9VCSq/NG0RmMb43+sggquJUfr9VX0h3p
	m2PAHQVhQka9IK7QRY18+hbnBRTeKJF/nd7CNsQl1B200i4qZq/Fi7DhLSGIbwntmhjBPPYwIs/
	NrOfKwBOtI0tmKdfKtpuc7FlBpGRrkarv5az0k/RHXXanB+APZPn1JebQeavy9dw21hQTshw3v3
	K2rtvaEnE4Zf2+mXb6EnC5j0bngtm9YxMXpr+Wasv6tNGtqNlahUajjv71bFtPaozOpW8GXXD2F
	jdfZC/F+ziE281N3Ro9DtKBLLEOJTfaZYIdnubJCW3+sjFBD0CGBmgAsSR5FaIShSkz6E3MNxxL
	BPiwpx7xEtgLf73QlgzVdNncHpmgkoLAw65Tn7mRPNV+ADQqsQMsb6X6IgJ0IRg9yAYMo46tdK1
	86p+Xy6vSkfoTBsuYVZP4mYMf8fxlTuGGt86tjLZ7S3JUZI8ABBYpM/qUvxNqFjcCf2KUaI4gQp
	dfR/O6UBH//C4KAIWftyW6Y9dgDjPPhr2VkYg7SGA/ezy7AazRzta3OfDXy9cixKWUb/9tGfeOH
	jbriJOe36yR8OGt3d08f+8pxJxNu3sPSOGXGQ6fpcrZ/uK+p+14fZDteiiSRgNqGOJKlX3Cbjy/
	WKJGQiB8DbwGbyXM9WSxhwb7vc
X-Received: by 2002:a05:6102:510b:b0:7cc:56a:58da with SMTP id ada2fe7eead31-7d6ba4045dbmr1341996137.23.1795029091520;
        Wed, 18 Nov 2026 11:11:31 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64c1801fsm2479672e0c.0.2026.11.18.11.11.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:11:31 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 11/17] Bluetooth: mgmt: Fix mesh transmission locking and lifetime
Date: Wed, 18 Nov 2026 14:11:12 -0500
Message-ID: <20261118191118.318779-12-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118191118.318779-1-luiz.dentz@gmail.com>
References: <20261118191118.318779-1-luiz.dentz@gmail.com>
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
 - flushing the transmissions left, dequeuing the entries still queued for
   them and clearing HCI_MESH_SENDING, when the controller is closed (also
   when auto powered off) or the index is removed, as nothing is going to
   send them and the stale entries would act on the ones started after
   the controller is powered on again, and not accepting Mesh Send while
   the controller is not powered so none can be left behind;
 - not reporting the completion of a transmission that failed to be queued
   by Mesh Send itself since userspace wasn't told about its handle;
 - not reusing the handle of a transmission still pending when the handle
   counter wraps around, now that it is what identifies a transmission.

Reported-by: sashiko.dev (linux-4ab89465-fc27-4d91-a870-a8ed49b22e91)
Reported-by: sashiko.dev (linux-ab941894-dbe1-49da-8bac-c52efda6eaee)
Reported-by: sashiko.dev (linux-4016f774-7ac7-4b8a-916f-587ec9d597d4)
Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |   1 +
 net/bluetooth/hci_sync.c         |   5 +
 net/bluetooth/mgmt.c             | 301 +++++++++++++++++++++++++------
 net/bluetooth/mgmt_util.c        |  23 ++-
 4 files changed, 267 insertions(+), 63 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 543d8d99b295..4aa0b49ae104 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2578,6 +2578,7 @@ void mgmt_index_removed(struct hci_dev *hdev);
 void mgmt_set_powered_failed(struct hci_dev *hdev, int err);
 void mgmt_power_on(struct hci_dev *hdev, int err);
 void __mgmt_power_off(struct hci_dev *hdev);
+void mgmt_mesh_flush(struct hci_dev *hdev);
 void mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 		       bool persistent);
 void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index b1925153c2c7..6a329b78976b 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6125,6 +6125,11 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 
 	auto_off = hci_dev_test_and_clear_flag(hdev, HCI_AUTO_OFF);
 
+	/* Nothing is going to send the mesh transmissions left, whether or not
+	 * mgmt is told about the controller being powered off.
+	 */
+	mgmt_mesh_flush(hdev);
+
 	if (!auto_off && !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
 	    hci_dev_test_flag(hdev, HCI_MGMT))
 		__mgmt_power_off(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fc0be4ca033f..90517e7593c7 100644
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
@@ -1143,6 +1202,33 @@ static void mesh_send_done(struct work_struct *work)
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
+	/* Stop the timer first, it checks HCI_MESH_SENDING without hdev->lock
+	 * so once it is clear and the work is not running anymore nothing can
+	 * queue mesh_send_done_sync behind the dequeue below.
+	 */
+	hci_dev_clear_flag(hdev, HCI_MESH_SENDING);
+	cancel_delayed_work_sync(&hdev->mesh_send_done);
+
+	/* Entries still queued would otherwise run after the controller is
+	 * powered on again and act on the transmissions started by then. The
+	 * destroy callbacks don't take hdev->lock when cancelled.
+	 */
+	hci_cmd_sync_dequeue(hdev, mesh_send_sync, NULL, NULL);
+	hci_cmd_sync_dequeue(hdev, mesh_send_done_sync, NULL, NULL);
+
+	while ((mesh_tx = mgmt_mesh_next(hdev, NULL)))
+		mesh_send_complete(hdev, mesh_tx, silent);
+}
+
 static void mgmt_init_hdev(struct sock *sk, struct hci_dev *hdev)
 {
 	if (hci_dev_test_flag(hdev, HCI_MGMT))
@@ -2310,38 +2396,71 @@ static int set_mesh(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
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
@@ -2379,6 +2498,8 @@ static int mesh_send_sync(struct hci_dev *hdev, void *data)
 		instance = 0;
 	}
 
+	hci_dev_unlock(hdev);
+
 	if (instance)
 		return hci_schedule_adv_instance_sync(hdev, instance, true);
 
@@ -2422,37 +2543,80 @@ static int mesh_features(struct sock *sk, struct hci_dev *hdev,
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
@@ -2503,7 +2667,6 @@ static int mesh_send(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	struct mgmt_cp_mesh_send *send = data;
 	struct mgmt_rp_mesh_read_features rp;
 	u16 expected_len;
-	bool sending;
 	int err = 0;
 
 	if (!lmp_le_capable(hdev) ||
@@ -2525,6 +2688,15 @@ static int mesh_send(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	hci_dev_lock(hdev);
 
+	/* Transmissions are flushed when the controller is closed, which is
+	 * serialized with this by hdev->lock, so none can be left behind.
+	 */
+	if (!hdev_is_powered(hdev)) {
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
+				      MGMT_STATUS_NOT_POWERED);
+		goto done;
+	}
+
 	memset(&rp, 0, sizeof(rp));
 	rp.max_handles = MESH_HANDLES_MAX;
 
@@ -2536,27 +2708,27 @@ static int mesh_send(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
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
@@ -9920,7 +10092,8 @@ void mgmt_index_removed(struct hci_dev *hdev)
 	cancel_delayed_work_sync(&hdev->discov_off);
 	cancel_delayed_work_sync(&hdev->service_cache);
 	cancel_delayed_work_sync(&hdev->rpa_expired);
-	cancel_delayed_work_sync(&hdev->mesh_send_done);
+
+	mesh_flush(hdev, true);
 }
 
 void mgmt_power_on(struct hci_dev *hdev, int err)
@@ -9947,6 +10120,16 @@ void mgmt_power_on(struct hci_dev *hdev, int err)
 	hci_dev_unlock(hdev);
 }
 
+/* This function requires the caller holds hdev->lock */
+void mgmt_mesh_flush(struct hci_dev *hdev)
+{
+	/* The mesh work is only initialized once mgmt is used */
+	if (!hci_dev_test_flag(hdev, HCI_MGMT))
+		return;
+
+	mesh_flush(hdev, false);
+}
+
 void __mgmt_power_off(struct hci_dev *hdev)
 {
 	struct cmd_lookup match = { NULL, hdev };
diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
index 6ea107c0e054..d502e6b933e8 100644
--- a/net/bluetooth/mgmt_util.c
+++ b/net/bluetooth/mgmt_util.c
@@ -409,16 +409,31 @@ struct mgmt_mesh_tx *mgmt_mesh_add(struct sock *sk, struct hci_dev *hdev,
 				   void *data, u16 len)
 {
 	struct mgmt_mesh_tx *mesh_tx;
+	u8 handle = hdev->mesh_send_ref;
+	int i;
+
+	/* The handle is all that identifies a transmission, so it must not be
+	 * in use by one still pending when the counter wraps around.
+	 */
+	for (i = 0; i < 255; i++) {
+		handle++;
+		if (!handle)
+			handle++;
+
+		if (!mgmt_mesh_find(hdev, handle))
+			break;
+	}
+
+	if (i == 255)
+		return NULL;
 
 	mesh_tx = kzalloc_obj(*mesh_tx);
 	if (!mesh_tx)
 		return NULL;
 
-	hdev->mesh_send_ref++;
-	if (!hdev->mesh_send_ref)
-		hdev->mesh_send_ref++;
+	hdev->mesh_send_ref = handle;
 
-	mesh_tx->handle = hdev->mesh_send_ref;
+	mesh_tx->handle = handle;
 	mesh_tx->index = hdev->id;
 	memcpy(mesh_tx->param, data, len);
 	mesh_tx->param_len = len;
-- 
2.56.0

