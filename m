Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346DA46DFEA
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 10:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786097749; cv=none; b=EJG2OYUue0mgqmuS0trrUMzS+cF1xUha0a2djOnn6AYmMHLFG0HLnV2+zCOmyaClmjC5zyWcGha7bwChy1TfbyBw9k1Y1moYWlN9NQps/ls4fMEifiAP6aKYz2TsSYkB5Ddfwd2xNpgzzhl/2k+SAZIS3p6UnCalGEh7yoAd6Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786097749; c=relaxed/simple;
	bh=ANx/c0Jk601dswbPSYZBwq6fhwU5VWnvdJTjOTY1Sh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICojYelDp7C9yh+hWCDIZv54WMfcV1jWtFhuX4eSO0xRN2aMYu5h5YPOywHdszJNmwSBZe8XOysHxnSQZWlhXu7buJHqg4GmEEpuyQ8qA8Qmami+CIOWSGG8YIZZr82C3cnWxCSTtP+/bL2APQxyCBpvLLnz6BX3e5pv6XFFcMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=eqfAp9p5; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="eqfAp9p5"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-382ef647e20so3461661a91.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 03:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1786097747; x=1786702547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=exzP3UOlfEvklmVgKj5tdk2JL1c2GVIFvVBR+QT0kmQ=;
        b=eqfAp9p5R1m9lBCSnuKzrrDBcveDW51s3tfmNkgMenxwRRdsZs6V2Q8raP4ZRK44Iz
         asciyuy14dHVIEWo9eIhZS2/BnM61ZHEgjdlcbED6HatA1TTt9yfW3zg7s4BxT+UQ0Yu
         tDDoyQtFlQuAaUABtRfhslkw/1xpujewwz4B6sBR53O3p3jFCp4SY8oLIEj6kFUc+2AD
         g5L3VXImM5mCHGtDgI3B4O6Bex5BEqbQhslAUrUFTG6T83S9pofYPCKYHcb0KTiaOO4O
         MOKSU9rXzat/csJFb61Bkvf0H0GjlpX8kQ/8m/e5bgfBTopfoiACOaGA95t7VpEwTjN5
         +U3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786097747; x=1786702547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=exzP3UOlfEvklmVgKj5tdk2JL1c2GVIFvVBR+QT0kmQ=;
        b=hyBNAmCjPkX80mXspsa3CNTqQNEGnTp6K+oREkuD/HeHd4/nM6WWoGeyRPeTkMiPus
         uvYPYcxsfhnyEZmxm+7NyGOXnVJnD6P5Nhqlj68KYol3Nf+SMXrjjqX0JJsGHyjn7gPG
         TtA2/+u/ZvtMxRdCeAyrQiJ1TpCHH9dQLUpekOO4w4Z+Gb17O6MmVziB3A/fUj2Ivl6p
         AxGnXD7OqOndC8fDaPPXccnXA25yKji2MVaarVmBk8o7QC+oyiXbTiXT6/LoUP5wRX+E
         c2Vyad8q05QauiJ0Hd/zaigPyFlRwMrBfPfAHWO2v/leWrfCZmsCCyIulyGLnay+orq+
         aVMg==
X-Forwarded-Encrypted: i=1; AHgh+Rr0pp29v1Ujkiuw9LNUv6eS/vM8OiixEaGLlUPIfOzoSH9RfTX5K6vCVPtoRMlG7PggumXBuq/QJm7sIWekbf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTrVN/aAUxdLDeaEeC/iZj3PiQfNlTV8fhN3zi/IPNCKF8cMST
	5rTcNdcbvATx+CHqzAs/8CMBcERvWyio3duQRIqq0IxoD3jGz4Ud5JFokWRsymXkaiR21nv8S44
	n6Qt2K+1WbQ==
X-Gm-Gg: AR+sD13Dip/renmm4n/X+rkrbcupZeeVp9Fbbmg0SjdZkHZ3bG5kQrYpjfV+NEkpA5s
	hKu7c9/sRfDOpmzRkqxc7Mx0Jcf06aFwM5n0lah8pyYcBGimenvULGJ8toaK8yzKMH1pTiuKaFM
	Q8ON2yhrIHt/5hydHD0tmYNQAQGKjYM/wGG1Z96CRbeL57v4OrOmuuNPxN0udY47g1ikOn2Jtot
	URW66aUVok/B7TWBGivi7an7NP8+Xc6y464wP0IC4C7I5JaG3KIyzXz1NSsmNhkAWJ54NRvWCwu
	slN1CWy2s6e7AX6UKZgeSdZGHaZivpK8eNKMPza+WnGEdWIb/o37gv9V1NZVtWLHesYFpuvE2JK
	gLcmWOZ+8LqnJhH13BwhBcwLGiKsVnfFo3+VUCUpUypCSA2gCKg1NNccPSW4JJaaZElBKDGPltR
	gfmFMFer/DOZjHrqRxwi5ptWiIVYOhkldYG50/jBljoBN4ulCI/yIdVdbLcUxSRk3uDlPMssKFo
	lyrakYXuF4XzJKMzIq66bZ/nVh0dyWU8VDxUpNeAHQ=
X-Received: by 2002:a17:90a:d644:b0:38e:2860:253f with SMTP id 98e67ed59e1d1-3903c582511mr22513549a91.12.1786097746982;
        Fri, 07 Aug 2026 03:15:46 -0700 (PDT)
Received: from localhost.localdomain ([1.220.41.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085dea04bsm4399162a91.8.2026.08.07.03.15.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 07 Aug 2026 03:15:46 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Brian Gix <brian.gix@intel.com>
Cc: Baul Lee <baul.lee@xbow.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	federico.kirschbaum@xbow.com,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] Bluetooth: MGMT: reference-count struct mgmt_mesh_tx
Date: Fri,  7 Aug 2026 19:15:29 +0900
Message-ID: <20260807101529.17348-4-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260807101529.17348-1-baul.lee@xbow.com>
References: <20260807101529.17348-1-baul.lee@xbow.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_cmd_sync_submit() stores the caller's pointer in a work entry and
takes no reference to what it names.  hci_cmd_sync_work() drains that
list from the head on an ordered workqueue, so an entry queued earlier
runs to completion before a later one is looked at.

mesh_send() links a struct mgmt_mesh_tx onto hdev->mesh_pending and
queues mesh_send_sync() with the raw pointer.  A MESH_SEND_CANCEL issued
before that send leaves its send_cancel() entry ahead in the queue, so
send_cancel() runs first: it picks the object out of hdev->mesh_pending
with mgmt_mesh_next(), which returns it without unlinking it, and frees
it through mesh_send_complete().  Nothing invalidates the pointer the
later entry still holds, so mesh_send_sync() and its destroy callback
mesh_send_start_complete() run on freed memory:

[   43.618774] BUG: KASAN: slab-use-after-free in mesh_send_sync+0xec/0x1b4
[   43.618851] Write of size 1 at addr ffff000009f2a6a9 by task kworker/u5:2/148
[   43.619464]  mesh_send_sync+0xec/0x1b4
[   43.619531]  hci_cmd_sync_work+0xac/0x128
[   43.620882] Freed by task 148:
[   43.621171]  mgmt_mesh_remove+0x94/0x110
[   43.621218]  send_cancel+0xd8/0x1cc
[   43.621270]  hci_cmd_sync_work+0xac/0x128

Offset 41 is mesh_tx->instance, the only byte mesh_send_sync() stores
through mesh_tx; it reads further fields of the same freed object, and
hci_set_adv_instance_data() copies 31 of those bytes into a live
struct adv_info.  The free and the use are consecutive iterations of one
hci_cmd_sync_work() loop on one kworker, so queue order alone decides
it.

Give struct mgmt_mesh_tx a reference count.  hdev->mesh_pending holds
one, and every pointer handed to hci_cmd_sync_queue() takes a second one
that the destroy callback drops, so a cancel that unlinks the object
while a work entry is still queued no longer releases it.
mgmt_mesh_remove() becomes an unlink plus a put and returns early when
the object is already unlinked, because it can now outlive its removal
from the list.  The list reference is still dropped under hci_dev_lock()
only, so mesh_send()'s use of mesh_tx->handle after queueing stays
covered by the lock it holds.

A cancel that arrives before the queued mesh_send_sync() now lets that
send run rather than freeing the object under it; suppressing the
transmission as well is a separate change.

hci_cmd_sync_dequeue() is the other in-tree option, but
mgmt_mesh_remove() is not given the hci_dev it needs and cannot tell
whether the work entry has already been taken off cmd_sync_work_list.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 net/bluetooth/mgmt.c      | 25 +++++++++++++++++--------
 net/bluetooth/mgmt_util.c | 23 +++++++++++++++++++++--
 net/bluetooth/mgmt_util.h |  3 +++
 3 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 853a80fd15af..61d279ae2f71 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1133,13 +1133,15 @@ static void mesh_next(struct hci_dev *hdev, void *data, int err)
 		return;
 	}
 
-	err = hci_cmd_sync_queue(hdev, mesh_send_sync, mesh_tx,
+	err = hci_cmd_sync_queue(hdev, mesh_send_sync, mgmt_mesh_get(mesh_tx),
 				 mesh_send_start_complete);
 
-	if (err < 0)
+	if (err < 0) {
+		mgmt_mesh_put(mesh_tx);
 		mesh_send_complete(hdev, mesh_tx, false);
-	else
+	} else {
 		hci_dev_set_flag(hdev, HCI_MESH_SENDING);
+	}
 
 	hci_dev_unlock(hdev);
 }
@@ -2328,7 +2330,7 @@ static void mesh_send_start_complete(struct hci_dev *hdev, void *data, int err)
 	u8 mgmt_err = mgmt_status(err);
 
 	if (err == -ECANCELED)
-		return;
+		goto put;
 
 	/* Report any errors here, but don't report completion */
 
@@ -2338,12 +2340,15 @@ static void mesh_send_start_complete(struct hci_dev *hdev, void *data, int err)
 		hci_dev_lock(hdev);
 		mesh_send_complete(hdev, mesh_tx, false);
 		hci_dev_unlock(hdev);
-		return;
+		goto put;
 	}
 
 	mesh_send_interval = msecs_to_jiffies((send->cnt) * 25);
 	queue_delayed_work(hdev->req_workqueue, &hdev->mesh_send_done,
 			   mesh_send_interval);
+
+put:
+	mgmt_mesh_put(mesh_tx);
 }
 
 static int mesh_send_sync(struct hci_dev *hdev, void *data)
@@ -2549,11 +2554,15 @@ static int mesh_send(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	sending = hci_dev_test_flag(hdev, HCI_MESH_SENDING);
 	mesh_tx = mgmt_mesh_add(sk, hdev, send, len);
 
-	if (!mesh_tx)
+	if (!mesh_tx) {
 		err = -ENOMEM;
-	else if (!sending)
-		err = hci_cmd_sync_queue(hdev, mesh_send_sync, mesh_tx,
+	} else if (!sending) {
+		err = hci_cmd_sync_queue(hdev, mesh_send_sync,
+					 mgmt_mesh_get(mesh_tx),
 					 mesh_send_start_complete);
+		if (err < 0)
+			mgmt_mesh_put(mesh_tx);
+	}
 
 	if (err < 0) {
 		bt_dev_err(hdev, "Send Mesh Failed %d", err);
diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
index a822091f2907..c7543964525a 100644
--- a/net/bluetooth/mgmt_util.c
+++ b/net/bluetooth/mgmt_util.c
@@ -422,6 +422,7 @@ struct mgmt_mesh_tx *mgmt_mesh_add(struct sock *sk, struct hci_dev *hdev,
 	if (!mesh_tx)
 		return NULL;
 
+	refcount_set(&mesh_tx->ref, 1);
 	hdev->mesh_send_ref++;
 	if (!hdev->mesh_send_ref)
 		hdev->mesh_send_ref++;
@@ -438,9 +439,27 @@ struct mgmt_mesh_tx *mgmt_mesh_add(struct sock *sk, struct hci_dev *hdev,
 	return mesh_tx;
 }
 
-void mgmt_mesh_remove(struct mgmt_mesh_tx *mesh_tx)
+struct mgmt_mesh_tx *mgmt_mesh_get(struct mgmt_mesh_tx *mesh_tx)
+{
+	refcount_inc(&mesh_tx->ref);
+
+	return mesh_tx;
+}
+
+void mgmt_mesh_put(struct mgmt_mesh_tx *mesh_tx)
 {
-	list_del(&mesh_tx->list);
+	if (!refcount_dec_and_test(&mesh_tx->ref))
+		return;
+
 	sock_put(mesh_tx->sk);
 	kfree(mesh_tx);
 }
+
+void mgmt_mesh_remove(struct mgmt_mesh_tx *mesh_tx)
+{
+	if (list_empty(&mesh_tx->list))
+		return;
+
+	list_del_init(&mesh_tx->list);
+	mgmt_mesh_put(mesh_tx);
+}
diff --git a/net/bluetooth/mgmt_util.h b/net/bluetooth/mgmt_util.h
index 20810cf06e81..b38970c1332c 100644
--- a/net/bluetooth/mgmt_util.h
+++ b/net/bluetooth/mgmt_util.h
@@ -19,6 +19,7 @@
 
 struct mgmt_mesh_tx {
 	struct list_head list;
+	refcount_t ref;
 	int index;
 	size_t param_len;
 	struct sock *sk;
@@ -72,4 +73,6 @@ struct mgmt_mesh_tx *mgmt_mesh_find(struct hci_dev *hdev, u8 handle);
 struct mgmt_mesh_tx *mgmt_mesh_next(struct hci_dev *hdev, struct sock *sk);
 struct mgmt_mesh_tx *mgmt_mesh_add(struct sock *sk, struct hci_dev *hdev,
 				   void *data, u16 len);
+struct mgmt_mesh_tx *mgmt_mesh_get(struct mgmt_mesh_tx *mesh_tx);
+void mgmt_mesh_put(struct mgmt_mesh_tx *mesh_tx);
 void mgmt_mesh_remove(struct mgmt_mesh_tx *mesh_tx);
-- 
2.50.1 (Apple Git-155)
