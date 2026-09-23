Received: from mail-vs2-f32.google.com (mail-vs2-f32.google.com [74.125.227.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5598C4D4896
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790166048; cv=none; b=JLvtWemxvymK8QOIIJkY/0bPBgnnL+hqfJ6LdbBwEM1n4ogQ9pt5boNBgd2BPDab/B5dXK1Pa8ea9KIcTrB2dUya44TrPbjDU4r/hC8CPo+hkwvUbHq8nxz7JOSuSWrZL0DPnkn8MJQIma9X4E79EyxMqgXnpl/BzXS4oMNld3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790166048; c=relaxed/simple;
	bh=fuV87aaUHDzuJt3uwaIZDnGcoihmJ6JF26OZkzkIRdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tImnx6rFWOUVFAhsJ25XJoxPWQOZZD2lYj1iuymCvmvzFt5qbZQdWNcyFhQZWOqesjkwCisTtzJBxWO5duHgV+Lk60Qp3nu0h5nW0ZroEZ6w1t0mVkx/jHE2qC5MWVaVfDhAyZOwLSskTjyACkaChVG2qOYBNiaRwQ8LkkDUQeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4PxMkdT; arc=none smtp.client-ip=74.125.227.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4PxMkdT"
Received: by mail-vs2-f32.google.com with SMTP id 71dfb90a1353d-5c67e4d8d8aso615392e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 05:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790166045; x=1790770845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YpFKYfPhZapcpo9PA/CRrUdbEtZcRrxPPY3WKgYlFtE=;
        b=K4PxMkdTQB2bDuEmS4q5QCJQurd7Rlw8a3YbYw//nXnnaEung5UdNAuZAQEm68dk/L
         bn6it3U7PynZabpQAGyvJ9T1AWQB6PFcdAFrvZp+mfUjXl76hwz1HQX9CibbvX4c4DDA
         AoIcZoszpR5Bq+MzsvFV85pN1v/TgvDObPzAa8jEM2IeppPsD2WEzPqIFLHVQGzDb05h
         gKgxU13gfEdhbg02tjJeG0PS6Gk+2cOao9TvTdq8W+zlRdE4sqbQAo88TBKeg2G7o0yI
         a82pnERO62QE6hE7US9fwq0anUCCFDBR6wCbpO5uxlA7KLQlZtxUl5yrs6BU/dkrWjnK
         JaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790166045; x=1790770845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YpFKYfPhZapcpo9PA/CRrUdbEtZcRrxPPY3WKgYlFtE=;
        b=0AXMG4lc1HUSV6DhnWJKwDJiQ/tAMVdy5b321FsIZvLJ0IQDKq9n+KLx7LiOZ9H9eF
         iOLy4IHOd6Bm56KNcvQsVCCCZ0w5tpGli0cAhebzjvmf4u51bmyTCNLXEs7BLzveCZS/
         cS0I85PzXCzBGmWsMCH0/khItNq9ep4rhIaQRu43li19sloAzo4ARGDohaKFeaBElPZH
         PhKg1qEI5zvyjjgyr2BhbaP196fniJgk9Ug4u9wG/nrDiLqjqy9zPfD//dAXDgjHeuGv
         RC+XFS6oCIIo9Nwn+f7Poh5B7ijjiz2CO+/I74Ra/AihGQlL82pnsgpalcBj+U2cYcvt
         RfOw==
X-Forwarded-Encrypted: i=1; AKwUvBy0xuQlPSAMKZOtOcgQruOOV1j+IpZv3/bdzlYORj4OgE5+dgUoBOoJc3WAwJqBChTYpzSrZyn4UAk/pJ1jH0c=@vger.kernel.org
X-Gm-Message-State: AFuF++nGpbm4gbFcRF+vFd8g/OKcIuB/paSaJeqy5Xd5TZGoq7LvZhIa
	4TL4uHZHlkRGLPBxMVAwsgsvXYwNg346Fb0LahnU0aWzZR6gbVA+CLbU
X-Gm-Gg: AYBFou1NGgvtj2IfEfS76SyxmsFFoTFkxza6vBjQBPzjCeZUKRJV3g9sYiE+c5hWvLy
	/pxfbv6Daru+UpQhV53CnGy2RbOA6m7FWuX8DOikoKoDD1TPHny1ELrf5mfXdQZ+f8Z54S1sRzD
	ScS0jRhjw/n9c70TmL5ix22gfzW6V2WzfEexv9gljE5zxKYZO3Fq0aR110RC80m+LXCHBpp/ChI
	vUbfvwQwynQG0Qnrolt+dEKsUWSZ48ClZLzZPgBUnFNT4y4s2sRUIVbWCgH7oklvexAKKuTuGE1
	zOhaHBJjP1kOQ1C77Ky4Wav//K3urIxYuPNCQTLPlPqauk321pWkDefQSv+1llY7Y3ioLg68BB2
	A7bzxthdjz69PkyLYDsD5xNT+iOfOEAjlVmcSsFPacgoH6F8/Q07azBMhkvN8uBnafAmIE3xKfB
	CxQLgQAp7yt3xPZdksb6e7mZFiLQ0W9o3Pa0/fQrpAMkbtC9Gy951pg8rGMtKTQ7hnIPeHnCF5D
	A==
X-Received: by 2002:a05:6122:e191:b0:5c7:ebed:1018 with SMTP id 71dfb90a1353d-5c9f15c8919mr2844793e0c.8.1790166045066;
        Wed, 23 Sep 2026 05:20:45 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ca4604daf9sm872471e0c.17.2026.09.23.05.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 05:20:44 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: pav@iki.fi,
	luiz.dentz@gmail.com
Cc: marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v3] Bluetooth: SCO: serialise sco_conn lifetime against sco_recv_scodata()
Date: Wed, 23 Sep 2026 09:20:26 -0300
Message-ID: <20260923122026.3465391-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sco_recv_scodata() upgrades the weak hcon->sco_data back-pointer to a
strong reference under hdev->lock:

    hci_dev_lock(hdev);
    hcon = hci_conn_hash_lookup_handle(hdev, handle);
    ...
    conn = sco_conn_hold_unless_zero(hcon->sco_data);
    hci_dev_unlock(hdev);

but the pointer is cleared from the other side without that lock. When
the last sco_conn reference is dropped, sco_conn_free() ran

    conn->hcon->sco_data = NULL;

with no hdev->lock held, so the RX path could read hcon->sco_data and
call kref_get_unless_zero() on an sco_conn that was concurrently freed:

    BUG: KASAN: slab-use-after-free in sco_conn_hold_unless_zero+0xbe/0x160
    Write of size 4 by task kworker/u17:0
    Workqueue: hci0 hci_rx_work
    Call Trace:
     sco_conn_hold_unless_zero+0xbe/0x160
     sco_recv_scodata+0x13f/0x490
     hci_rx_work+0x3af/0x730

kref_get_unless_zero() only guards against a zero refcount, not against
the backing memory already being freed.

Give hcon->sco_data an actual reference on the sco_conn it points to, so
the object cannot be freed while the pointer is still installed, and only
clear and drop it from sco_conn_del(), which runs under hdev->lock (its
callers, sco_connect_cfm() and sco_disconn_cfm(), hold it). The reader in
sco_recv_scodata() also takes hdev->lock, so the store and the read are
now serialised: the RX path either observes NULL or a reference that is
guaranteed to stay valid until it drops its own.

sco_conn_add() no longer hands its kref_init() reference to the caller as
the connection's only reference; that initial reference is the one owned
by hcon->sco_data, and callers get their own via sco_conn_hold().

Because the sco_conn can now outlive the socket (the association keeps it
alive until the link goes down), the hci_conn can no longer be dropped
from sco_conn_free() without regressing socket close: closing a connected
SCO socket must still tear the link down. Move hci_conn ownership to the
socket instead: __sco_chan_add() takes an hci_conn reference and it is
released from sco_chan_del() and sco_sock_destruct(), exactly once. The
sco_conn no longer owns an hci_conn reference, so sco_conn_add() stops
consuming one and sco_connect() drops the hci_connect_sco() reference on
every path; sco_connect_cfm() no longer needs its hci_conn_hold() dance.

Fixes: e6720779ae61 ("Bluetooth: SCO: Use kref to track lifetime of sco_conn")
Cc: stable@vger.kernel.org
Suggested-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
v3: fix two UAFs found by Pauli Virtanen in the v2 review:
    - sco_chan_del(): drop hci_conn ref before clearing conn->sk so that
      sco_conn_del() on another CPU cannot free hci_conn under our feet
    - sco_sock_destruct(): same ordering fix
    - remove dead branch in sco_conn_add() (conn->hcon == NULL impossible)
    - move hci_conn_drop in sco_connect() tighter after __sco_chan_add()
v2: quote inlined code and KASAN splat with spaces (bluez CI gitlint);
    no functional change.

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 3d4362a..a2f17ab 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -84,12 +84,14 @@ static void sco_conn_free(struct kref *ref)
 	if (conn->sk)
 		sco_pi(conn->sk)->conn = NULL;
 
-	if (conn->hcon) {
-		conn->hcon->sco_data = NULL;
-		hci_conn_drop(conn->hcon);
-	}
+	/* hcon->sco_data is cleared and the association's reference on the
+	 * sco_conn is dropped in sco_conn_del() under hdev->lock, and the
+	 * hci_conn is now owned by the socket (held in __sco_chan_add() and
+	 * dropped in sco_chan_del()/sco_sock_destruct()), so there is nothing
+	 * left to release towards hcon here.
+	 */
 
-	/* Ensure no more work items will run since hci_conn has been dropped */
+	/* Ensure no more work items will run before the connection is freed */
 	disable_delayed_work_sync(&conn->timeout_work);
 
 	kfree(conn);
@@ -188,25 +190,19 @@ static void sco_sock_clear_timer(struct sock *sk)
 }
 
 /* ---- SCO connections ---- */
-/* Consumes a reference on @hcon, which the returned sco_conn owns until it is
- * freed. On failure (NULL return) the reference is left for the caller to drop.
+/* Returns a new reference the caller must drop with sco_conn_put(). The
+ * hcon->sco_data association holds its own reference on the sco_conn for the
+ * connection's lifetime; it is dropped in sco_conn_del() under hdev->lock.
+ * @hcon is not consumed: the hci_conn reference is taken and owned by the
+ * socket in __sco_chan_add().
  */
 static struct sco_conn *sco_conn_add(struct hci_conn *hcon)
 {
 	struct sco_conn *conn = hcon->sco_data;
 
 	conn = sco_conn_hold_unless_zero(conn);
-	if (conn) {
-		if (!conn->hcon) {
-			sco_conn_lock(conn);
-			conn->hcon = hcon;
-			sco_conn_unlock(conn);
-		} else {
-			/* conn already owns a reference on hcon */
-			hci_conn_drop(hcon);
-		}
+	if (conn)
 		return conn;
-	}
 
 	conn = kzalloc_obj(struct sco_conn);
 	if (!conn)
@@ -227,7 +223,10 @@ static struct sco_conn *sco_conn_add(struct hci_conn *hcon)
 
 	BT_DBG("hcon %p conn %p", hcon, conn);
 
-	return conn;
+	/* kref_init() above set the association reference owned by
+	 * hcon->sco_data; hand the caller its own reference.
+	 */
+	return sco_conn_hold(conn);
 }
 
 /* Delete channel.
@@ -242,6 +241,19 @@ static void sco_chan_del(struct sock *sk, int err)
 	BT_DBG("sk %p, conn %p, err %d", sk, conn, err);
 
 	if (conn) {
+		struct hci_conn *hcon;
+
+		sco_conn_lock(conn);
+		hcon = conn->hcon;
+		sco_conn_unlock(conn);
+
+		/* Drop the socket's hci_conn reference BEFORE clearing
+		 * conn->sk, so sco_conn_del() on another CPU cannot free
+		 * the hci_conn while we still hold a pointer to it.
+		 */
+		if (hcon)
+			hci_conn_drop(hcon);
+
 		sco_conn_lock(conn);
 		conn->sk = NULL;
 		sco_conn_unlock(conn);
@@ -266,6 +278,13 @@ static void sco_conn_del(struct hci_conn *hcon, int err)
 
 	BT_DBG("hcon %p conn %p, err %d", hcon, conn, err);
 
+	/* Detach from the hci_conn and drop the association's reference.
+	 * The caller holds hdev->lock, which serialises this against the
+	 * read of hcon->sco_data in sco_recv_scodata().
+	 */
+	hcon->sco_data = NULL;
+	sco_conn_put(conn);
+
 	sco_conn_lock(conn);
 	sk = sco_sock_hold(conn);
 	sco_conn_unlock(conn);
@@ -290,6 +309,11 @@ static void __sco_chan_add(struct sco_conn *conn, struct sock *sk,
 	sco_pi(sk)->conn = sco_conn_hold(conn);
 	conn->sk = sk;
 
+	/* The socket owns an hci_conn reference for as long as it stays
+	 * attached; it is dropped in sco_chan_del()/sco_sock_destruct().
+	 */
+	hci_conn_hold(conn->hcon);
+
 	if (parent)
 		bt_accept_enqueue(parent, sk, true);
 }
@@ -371,6 +395,7 @@ static int sco_connect(struct sock *sk)
 	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND) {
 		release_sock(sk);
 		sco_conn_put(conn);
+		hci_conn_drop(hcon);
 		err = -EBADFD;
 		goto unlock;
 	}
@@ -379,9 +404,13 @@ static int sco_connect(struct sock *sk)
 	sco_conn_put(conn);
 	if (err) {
 		release_sock(sk);
+		hci_conn_drop(hcon);
 		goto unlock;
 	}
 
+	/* __sco_chan_add() took its own hci_conn reference; drop ours. */
+	hci_conn_drop(hcon);
+
 	/* Update source addr of the socket */
 	bacpy(&sco_pi(sk)->src, &hcon->src);
 
@@ -495,9 +524,26 @@ static struct sock *sco_get_sock_listen(bdaddr_t *src)
 
 static void sco_sock_destruct(struct sock *sk)
 {
+	struct sco_conn *conn = sco_pi(sk)->conn;
+
 	BT_DBG("sk %p", sk);
 
-	sco_conn_put(sco_pi(sk)->conn);
+	/* If the channel was not already torn down via sco_chan_del(), drop
+	 * the socket's own references here.
+	 */
+	if (conn) {
+		struct hci_conn *hcon;
+
+		sco_conn_lock(conn);
+		hcon = conn->hcon;
+		sco_conn_unlock(conn);
+
+		if (hcon)
+			hci_conn_drop(hcon);
+		sco_pi(sk)->conn = NULL;
+		sco_conn_put(conn);
+		return;
+	}
 
 	skb_queue_purge(&sk->sk_receive_queue);
 	skb_queue_purge(&sk->sk_write_queue);
@@ -1511,12 +1557,10 @@ static void sco_connect_cfm(struct hci_conn *hcon, __u8 status)
 	if (!status) {
 		struct sco_conn *conn;
 
-		conn = sco_conn_add(hci_conn_hold(hcon));
+		conn = sco_conn_add(hcon);
 		if (conn) {
 			sco_conn_ready(conn);
 			sco_conn_put(conn);
-		} else {
-			hci_conn_drop(hcon);
 		}
 	} else
 		sco_conn_del(hcon, bt_to_errno(status));
-- 
2.43.0
