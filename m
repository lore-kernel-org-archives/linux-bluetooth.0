Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDE03A9639
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 07:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786086580; cv=none; b=LZe/v9OAnkX7rvOMkLfRl7uF0fIAOBs1gBvX9Eygi340RIYWwCsIZvmri1vPsgNGwNLaGrHRKQa9FGHMcudeWGuAiktir7S9hTygFlhMMZxjrbJNQRShGpUu+ObKGK4NUTx3vK8WKo2RHJIl8X5e5WyADeVSM83MDbL0hhqZC6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786086580; c=relaxed/simple;
	bh=VoeN281Q/Ynlf8Lr5X/qG2nEweiKHrjONDeipjZasVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+6LD2azC6DNdOPEfrjAiZvyMU9RDhoLiz56u07PSXFe+nFK7mnWw0whQccrVLFZb3om+d/qv8kNnn21nl6sBQI3i2eTIDXep+3qzfRclcBHMO84TdaqVEhynfeqEHpcCSSAyP+CA1dz2qMzsLrrKRS0ulux8cHDS67R+idSC3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=NArUmkls; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="NArUmkls"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-81ed2a06b9eso31833277b3.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 00:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1786086576; x=1786691376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XwYAmUiFKZyLt0eV4KfzGWIesmvuZyHS4RTZnrKIuJU=;
        b=NArUmklsviy9vOBU0vsXIi8CpwrNh4n6Z0lm39FgMHdsUv6pfohvm4TMLOQNzeJUeJ
         3f19KIOEIfqllkFko+cauYKHnp2izjZqE0u1QKOP0VCVbzG71xaKtlo+z6c7vDKmNa1J
         tScsEWl4Od7KXBAJQ9QsEwQwCzU3gQerMMPxfsBPZ6t6Qswa1ZyPuV4UnQE91Y++z5/5
         BAtXHVoV/PusEgZc0/kZm5xZAZV8Ts+zO9mAZFpjvZ0eKk7j1YxpPevqdPOGC8Sqdlbj
         jaleC7G4QSru5XBTbCIoQhM8XFn3sXeMZhtRf+lHTO0HK27aedTuackrUDcu5taACshH
         /bfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786086576; x=1786691376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XwYAmUiFKZyLt0eV4KfzGWIesmvuZyHS4RTZnrKIuJU=;
        b=B3sE7Q5lqpKZ30IMlnq932MUnPPASwRD5y683zaH80zGVY/kQG/UJ15Y7v7NLzX8Qf
         MQeAm2KpDsAEH7+YPpky7GvP2g8v5avRtp2Gj+wHnDNOu1KXzVmnHNtJ+72ZcB7aSoGR
         Gv34+R6r8IQJ403tJCOa9Pmmv6Kk/TPLYAK46igP3/CtQg4lweC5EQshOKjNu06AUkAq
         zoCLxcBQi45l3q+ykNkJziWYWZO8pdppptCfg8L82w7+PTMfs8RlCMgAEsxEOtdc9Bex
         H/7Nz9BD7iTAiy1ONJoelt7cdx9K4VjkDSK/Ix3gzYWLJIq1T9DY+ia3TiIFGnZbMc/N
         xqyA==
X-Forwarded-Encrypted: i=1; AHgh+Rr3lWOCD6ZLpKwUvZECfaXfRTkXYfDJw+NGprpD/81C8KEfTb5+1HIVD1l9D0S13EmAVeMxWSMmMP9BJdUyB88=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBAaGBlUJ3OVKKLRVGqFyE0U2Em8LtlRAxSyrxbCs2k6WCP/Y3
	lgLTI25PAxYlI2C6fYsK5nBcn2NgA8Ft1kIpnIrVprljt47ajPEPeOdoPsigDVsdtCjawDE2nLj
	TGG82mU6ptA==
X-Gm-Gg: AR+sD135rV96Cb8V0V6lAXPiUAvDx5lvUZe2jUUlgfPjIKtbrZSozNYaok9QHGRJxJ+
	CP+lqV2BBeykyQGRrsLpH64aTMn5VBdKUCOs2mXN0fSQCBSgGEQ6Cn8yC4WdFgr29iBux5YJZj0
	bBUQTtF6Jg4r0VuVT6Qu0zAOtRvZAZAfRxIvPfgAyyDoYvGyPDbzkm97W8MM8H6m0RbNx+4Eo5p
	LdBb3nO8t3zPD6eoeaFk2GYgt1SZdZGUWc+N7RmSXuo4u8JKCchBqmFfRWpD2/2E7m6/CTKxxlA
	/KEOmfBZWi6mnC/SHCNnLnBbq3gLngJiD+NRKWgWC3J8XRMlr04PuPlyAkvguWID5828gEVR5z1
	WcuZR9t68wfxH5JYT0e4U9ai4r7kU+P1MTP7DtUI8e6AzNeouwOLI0mk+58rn+S6Zv9gVJ852DC
	ExatjAE0GI+0YTYJGv9ReaeOsINHeSxbGaEhCe2JHvx/LdvXkiXN1VBA/cSuqcceSpOwUX274qE
	J2Gc7P+aJEzkTLmpWxas7bz8w1MVNIKICnVNCzDW0mJOEb8JZ/STWNTrxfulgbXuefS+yGXgd44
	KzSdScdSLgrOtk3MoYbvvRjsuyHvXJkgXZ8=
X-Received: by 2002:a05:690c:6892:b0:81d:d035:eb4b with SMTP id 00721157ae682-8225ba2bd22mr40559047b3.19.1786086575744;
        Fri, 07 Aug 2026 00:09:35 -0700 (PDT)
Received: from buildmachine.tailf331da.ts.net (ec2-3-14-143-233.us-east-2.compute.amazonaws.com. [3.14.143.233])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-823f0e64324sm5230367b3.19.2026.08.07.00.09.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 07 Aug 2026 00:09:35 -0700 (PDT)
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
Subject: [PATCH 3/3] Bluetooth: MGMT: reference-count struct mgmt_mesh_tx
Date: Fri,  7 Aug 2026 16:09:16 +0900
Message-ID: <20260807070916.85771-4-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260807070916.85771-1-baul.lee@xbow.com>
References: <20260807070916.85771-1-baul.lee@xbow.com>
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
index 583e05ec4377..c562f8c95294 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1127,13 +1127,15 @@ static void mesh_next(struct hci_dev *hdev, void *data, int err)
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
@@ -2322,7 +2324,7 @@ static void mesh_send_start_complete(struct hci_dev *hdev, void *data, int err)
 	u8 mgmt_err = mgmt_status(err);
 
 	if (err == -ECANCELED)
-		return;
+		goto put;
 
 	/* Report any errors here, but don't report completion */
 
@@ -2332,12 +2334,15 @@ static void mesh_send_start_complete(struct hci_dev *hdev, void *data, int err)
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
@@ -2538,11 +2543,15 @@ static int mesh_send(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
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

