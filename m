Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF813A1E67;
	Fri, 24 Jul 2026 20:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924530; cv=pass; b=lDCpWOd/5JG0AGcFXNim1AOoKTxn5XZ1tokONeGGdj2vGfEtQrFtd/oZUlTECXI9CT32bEXzUpuwfh7H1VVaxxzr4AgLxKGcaf8jmbqd87PwuNxpjctfwTGIdxMtVGsMTYV67VyMy2baOHR6lWPmT9PTUU6pOHW8v7HOYfsBO9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924530; c=relaxed/simple;
	bh=tcMBm2dVOcDlfzrNh0HhverVF3HbHIOncLJSsVeRL2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mcPOed/49SbuSsjdffsf0R6vIx6WJ1Ngqri70aBMIBs9l1xl4ggD6v16l53g5OXplOCtQwIDtH/vZPyEKrQrAffEBMVFyY9xcstW0lUfrCdI1XpP00l1vMZ/Arl0BkfQzsTDTeDTuSeFuPn3BISG6nLLx+NFiy1ni4lyCyTm2Wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=U6CSNPQy; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="U6CSNPQy"
Received: from monolith.lan (unknown [89.37.63.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4h6KCd2DLmzyVm;
	Fri, 24 Jul 2026 23:22:05 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1784924526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6NcDNrmp9hpCK1prRMPvKQzVwRCfKNPIjYJwflZJUUs=;
	b=U6CSNPQy0CFQVatJE+rRzPpPKkjYqKG/qjcgDsckKgsDitffgcaU292NutyxDw3YzenQ9d
	DkIOmwiOAWxUVPt52gfVwKR3MuHD1fImf4PnYB3s5RK955FY6r1X/+XMWlvXnzhBC2LKjZ
	8tSedA7eJKYrJGBVc3k+7A3TEC3C8jE=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1784924526;
	b=k0jf+7NkgZu0Lzd7NrLD/3NygnZyssrsfbInbnPtZfcOif8nFaor4addTwAXExDFT7owME
	DbAyvwBoZeo1vFno65PfJ4OIuk3le0z7jhntDMn1jMSGoMOnLgYfzVyVI8vwGd6NHckJZd
	Miaurs9mbLZ1/o6XFglA44RtuE0pFsE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1784924526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6NcDNrmp9hpCK1prRMPvKQzVwRCfKNPIjYJwflZJUUs=;
	b=uvA5zAYzXaxNoGI8MfGkV5McasevNHS3BSAZakcUVmNGt+yJn/6ono+dJ/vQpNTXb/DnWx
	10dja/8D57xkKtZvcaxfq4xsDlo9gtmfnY8pSTQLl90C6kEi4szADaTb+p/Llq9aX0fIcA
	i3FO4gSaG4CpUWhCXEcJN5dnRUXszOY=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] Bluetooth: ISO: fix race of kfree vs kref_get_unless_zero
Date: Fri, 24 Jul 2026 23:20:34 +0300
Message-ID: <b84fd01c20f0d2975c7817da345a6937d67cf314.1784923689.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1784923689.git.pav@iki.fi>
References: <cover.1784923689.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_conn::iso_data is accessed and modified without lock or RCU.
This leads to a race

    [Task hdev->workqueue]                 	[Task 2]
    iso_recv                                    iso_conn_put(conn)
      conn = LOAD hcon->iso_data                  iso_conn_free(conn)
      iso_conn_hold_unless_zero(conn)               hcon->iso_data = NULL
                                                    kfree(conn)
        kref_get_unless_zero(&conn->ref) /* UAF */

and also to races in iso_conn_add() vs. iso_conn_free().

Fix by adding spinlock hci_conn::proto_lock and using it to guard
hci_conn::iso_data.

Fixes: dc26097bdb86 ("Bluetooth: ISO: Use kref to track lifetime of iso_conn")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 include/net/bluetooth/hci_core.h |  4 +-
 net/bluetooth/hci_conn.c         |  2 +
 net/bluetooth/iso.c              | 64 ++++++++++++++++++++++++++------
 3 files changed, 58 insertions(+), 12 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e7133ff87fbf..3df59849dcbe 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -767,9 +767,11 @@ struct hci_conn {
 	struct dentry	*debugfs;
 
 	struct hci_dev	*hdev;
+
+	spinlock_t	proto_lock; /* lock guarding protocol data */
 	void		*l2cap_data;
 	void		*sco_data;
-	void		*iso_data;
+	void		*iso_data __guarded_by(&proto_lock);
 
 	struct list_head link_list;
 	struct hci_conn	*parent;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 1966cd153d97..ebb04badf10c 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1123,6 +1123,8 @@ static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type,
 	INIT_DELAYED_WORK(&conn->idle_work, hci_conn_idle);
 	INIT_DELAYED_WORK(&conn->le_conn_timeout, le_conn_timeout);
 
+	spin_lock_init(&conn->proto_lock);
+
 	atomic_set(&conn->refcnt, 0);
 
 	hci_dev_hold(hdev);
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 30de99ba4b30..a461c8a4efed 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -109,9 +109,16 @@ static void iso_conn_free(struct kref *ref)
 	BT_DBG("conn %p", conn);
 
 	if (conn->hcon) {
-		conn->hcon->iso_data = NULL;
-		if (!test_and_set_bit(ISO_CONN_DROPPED, conn->flags))
-			hci_conn_drop(conn->hcon);
+		spin_lock(&conn->hcon->proto_lock);
+
+		/* Check we are not racing with iso_conn_add */
+		if (conn->hcon->iso_data == conn) {
+			conn->hcon->iso_data = NULL;
+			if (!test_and_set_bit(ISO_CONN_DROPPED, conn->flags))
+				hci_conn_drop(conn->hcon);
+		}
+
+		spin_unlock(&conn->hcon->proto_lock);
 	}
 
 	kfree_skb(conn->rx_skb);
@@ -126,7 +133,21 @@ static void iso_conn_put(struct iso_conn *conn)
 
 	BT_DBG("conn %p refcnt %d", conn, kref_read(&conn->ref));
 
+	/* The following race vs. iso_conn_del() is possible:
+	 *
+	 * 1. conn->hcon != NULL here
+	 * 2. kref_put puts the last reference
+	 * 3. concurrent iso_conn_del() gets iso_conn_hold_unless_zero() -> NULL
+	 *    and returns immediately, so conn->hcon is not cleared
+	 * 4. iso_conn_free() dereferences conn->hcon
+	 *
+	 * To avoid UAF in step 4, take RCU before decrementing the refcount.
+	 */
+	rcu_read_lock();
+
 	kref_put(&conn->ref, iso_conn_free);
+
+	rcu_read_unlock();
 }
 
 static struct iso_conn *iso_conn_hold_unless_zero(struct iso_conn *conn)
@@ -205,22 +226,28 @@ static void iso_sock_disable_timer(struct sock *sk)
 
 /* ---- ISO connections ---- */
 static struct iso_conn *iso_conn_add(struct hci_conn *hcon)
+	__must_hold(&hcon->hdev->lock)
 {
-	struct iso_conn *conn = hcon->iso_data;
+	struct iso_conn *conn;
 
-	conn = iso_conn_hold_unless_zero(conn);
+	spin_lock(&hcon->proto_lock);
+
+	conn = iso_conn_hold_unless_zero(hcon->iso_data);
 	if (conn) {
 		if (!conn->hcon) {
 			iso_conn_lock(conn);
 			conn->hcon = hcon;
 			iso_conn_unlock(conn);
 		}
+		spin_unlock(&hcon->proto_lock);
 		return conn;
 	}
 
-	conn = kzalloc_obj(*conn);
-	if (!conn)
+	conn = kzalloc_obj(*conn, GFP_ATOMIC);
+	if (!conn) {
+		spin_unlock(&hcon->proto_lock);
 		return NULL;
+	}
 
 	kref_init(&conn->ref);
 	spin_lock_init(&conn->lock);
@@ -229,6 +256,8 @@ static struct iso_conn *iso_conn_add(struct hci_conn *hcon)
 	conn->hcon = hcon;
 	conn->tx_sn = 0;
 
+	spin_unlock(&hcon->proto_lock);
+
 	BT_DBG("hcon %p conn %p", hcon, conn);
 
 	return conn;
@@ -269,10 +298,12 @@ static void iso_chan_del(struct sock *sk, int err)
 static void iso_conn_del(struct hci_conn *hcon, int err)
 	__must_hold(&hcon->hdev->lock)
 {
-	struct iso_conn *conn = hcon->iso_data;
+	struct iso_conn *conn;
 	struct sock *sk;
 
-	conn = iso_conn_hold_unless_zero(conn);
+	spin_lock(&hcon->proto_lock);
+	conn = iso_conn_hold_unless_zero(hcon->iso_data);
+	spin_unlock(&hcon->proto_lock);
 	if (!conn)
 		return;
 
@@ -296,10 +327,12 @@ static void iso_conn_del(struct hci_conn *hcon, int err)
 
 done:
 	/* No sk access to conn->hcon any more (lock_sock + hdev->lock) */
+	spin_lock(&hcon->proto_lock);
 	iso_conn_lock(conn);
 	conn->hcon = NULL;
 	hcon->iso_data = NULL;
 	iso_conn_unlock(conn);
+	spin_unlock(&hcon->proto_lock);
 
 	iso_conn_put(conn);
 }
@@ -421,6 +454,8 @@ static int iso_connect_bis(struct sock *sk)
 			iso_pi(sk)->bc_sid = hcon->sid;
 	}
 
+	lockdep_assert_held(&hcon->hdev->lock);
+
 	conn = iso_conn_add(hcon);
 	if (!conn) {
 		hci_conn_drop(hcon);
@@ -524,6 +559,8 @@ static int iso_connect_cis(struct sock *sk)
 		}
 	}
 
+	lockdep_assert_held(&hcon->hdev->lock);
+
 	conn = iso_conn_add(hcon);
 	if (!conn) {
 		hci_conn_drop(hcon);
@@ -855,8 +892,8 @@ static void iso_sock_disconn(struct sock *sk)
 		 */
 		if (bis_sk) {
 			hcon->state = BT_OPEN;
-			hcon->iso_data = NULL;
-			iso_pi(sk)->conn->hcon = NULL;
+			set_bit(ISO_CONN_DROPPED, iso_pi(sk)->conn->flags);
+
 			iso_sock_clear_timer(sk);
 			iso_chan_del(sk, bt_to_errno(hcon->abort_reason));
 			sock_put(bis_sk);
@@ -1306,6 +1343,8 @@ static int iso_listen_bis(struct sock *sk)
 		goto unlock;
 	}
 
+	lockdep_assert_held(&hcon->hdev->lock);
+
 	conn = iso_conn_add(hcon);
 	if (!conn) {
 		hci_conn_drop(hcon);
@@ -2591,7 +2630,10 @@ int iso_recv(struct hci_dev *hdev, u16 handle, struct sk_buff *skb, u16 flags)
 		return -ENOENT;
 	}
 
+	spin_lock(&hcon->proto_lock);
 	conn = iso_conn_hold_unless_zero(hcon->iso_data);
+	spin_unlock(&hcon->proto_lock);
+
 	hcon = NULL;
 
 	hci_dev_unlock(hdev);
-- 
2.55.0

