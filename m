Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA90E345CBC;
	Sat,  1 Aug 2026 18:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785609462; cv=pass; b=mSJjeNXnOB39KrZNqLEilMO7vj7nASNdQ41E3awgrdBFNaEwSIRX9/TgwDKwQBLFTfmTqVYfDlcvHeevXhbGr76TJKo64J6kgJWI85iIdChql8XMluw/C4lDeWMW/moxJsj2+7zVFgxdUXf9R274Kds0BD74/n5XffCrTAvpdaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785609462; c=relaxed/simple;
	bh=9GhyRWGHpgaoDZ+iYUE94pZMMeJkfCH9hzqwHkuPg48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qnaf1tgETDxY+YRc410K0L0jNLzOdSRsA0METj2Zc4jNiVvGDqKUqleVGVHBnnwoL3DCbLxM8+2PZpeHP+bDyTJJCBeIMJ070hxEypQkDjUunLOSUCFHOJmcugsWvIIWLNLDy+oVYhFkX6Ewvx5sJc8q0Fw+Nt26WoM4RV3UpqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=L2cYgAvE; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="L2cYgAvE"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:5:f011::a05d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hCBWK5Zx6z10KQ;
	Sat, 01 Aug 2026 21:37:33 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1785609454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=12IRhkCamCQ11kbSrr1KipyRnz7v4Wl1a8GcEjxCkm0=;
	b=L2cYgAvEg0U4Q3fgWkEMbAXvuJSzcvdOwm62my60SwrmNrlFYN3jSyR9JD3VUjLd7wBz+K
	6jy3vjk7STFnl3D/sLfxAEXAV57+jt5Ejhd1DTHCdNO5/QywYXySHVQzlNIHytkq+r6eZ+
	PWGT9jL63y3njs8HpkcHmXBwJapG45o=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1785609454;
	b=ym+OnqEUuTw2VHjw21tMgxtur2dBLuzrYULyDvQfDfeo3n8WUIvDR3HcfXoSO2/xrhOUmP
	apb/Qd7MsP5RJ3GC2jUvxTBBDaG86l7XONFiRQSamyav5efyqsKMEkby9g8KedcMXCLlFL
	TKAUbke3Yo50RS4oN0Icr3rv/XZCSmQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1785609454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=12IRhkCamCQ11kbSrr1KipyRnz7v4Wl1a8GcEjxCkm0=;
	b=LXdWLqReoEQPAq2cP6N+LhfE+bdZAaEGjPk00Ssn4Nx/0afF8mWBsbyyXUqzI0/LK+yT6v
	WQZVMRYNiXGzDCIbX0F2qyNAgJKF2YmyOf2VDKRHupcgKexUQz4fejyGaZUJrMEtnMvkP2
	5oZLcu5/A/jUPN+RoTSNnU5ozW8WIcA=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	syzbot+9c40ad7c6ed7165e46e8@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH 2/2] Bluetooth: add annotations for l2cap_data locking context
Date: Sat,  1 Aug 2026 21:37:24 +0300
Message-ID: <6d64f3cba0e369dd7bddb2064df63ae26dd94e33.1785609341.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <a672a4ee3d24c93156c51ef84ca4dc3364a18109.1785609341.git.pav@iki.fi>
References: <a672a4ee3d24c93156c51ef84ca4dc3364a18109.1785609341.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add context analysis annotations for hci_conn::l2cap_data locking.

Also add necessary lockdep_assert_held() and __must_hold annotations
to prove the access is safe.

The access in smp_conn_security() is supposed to be guarded by the
caller holding lock that blocks concurrent l2cap_conn_del() eg.
hdev->lock, conn->lock or chan->lock. Mark unsafe as can't be
automatically checked now.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 include/net/bluetooth/hci_core.h | 2 +-
 net/bluetooth/6lowpan.c          | 2 ++
 net/bluetooth/l2cap_core.c       | 9 +++++++++
 net/bluetooth/mgmt.c             | 2 ++
 net/bluetooth/smp.c              | 7 ++++++-
 net/bluetooth/smp.h              | 6 ++++--
 6 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 01b938c4b24a..c299daac7fbe 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -775,7 +775,7 @@ struct hci_conn {
 	struct hci_dev	*hdev;
 
 	spinlock_t	proto_lock; /* lock guarding protocol data */
-	void		*l2cap_data;
+	void		*l2cap_data __guarded_by(&proto_lock, &hdev->lock);
 	void		*sco_data;
 	void		*iso_data __guarded_by(&proto_lock);
 
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index d504a363a30f..30f4afa18bc8 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -1007,6 +1007,8 @@ static int get_l2cap_conn(char *buf, bdaddr_t *addr, u8 *addr_type,
 		return -ENOENT;
 	}
 
+	lockdep_assert_held(&hcon->hdev->lock);
+
 	*conn = l2cap_conn_hold_unless_zero(hcon->l2cap_data);
 
 	BT_DBG("conn %p dst %pMR type %u", *conn, &hcon->dst, hcon->dst_type);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 30d7120d3a15..ee459dd411f5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1791,6 +1791,7 @@ static void l2cap_unregister_all_users(struct l2cap_conn *conn)
 }
 
 static void l2cap_conn_del(struct hci_conn *hcon, int err)
+	__must_hold(&hcon->hdev->lock)
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
 	struct l2cap_chan *chan, *l;
@@ -7153,6 +7154,7 @@ static void process_pending_rx(struct work_struct *work)
 }
 
 static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
+	__must_hold(&hcon->hdev->lock)
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
 	struct hci_chan *hchan;
@@ -7358,6 +7360,8 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		goto done;
 	}
 
+	lockdep_assert_held(&hcon->hdev->lock);
+
 	conn = l2cap_conn_add(hcon);
 	if (!conn) {
 		hci_conn_drop(hcon);
@@ -7528,6 +7532,7 @@ static struct l2cap_chan *l2cap_global_fixed_chan(struct l2cap_chan *c,
 }
 
 static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
+	__must_hold(&hcon->hdev->lock)
 {
 	struct hci_dev *hdev = hcon->hdev;
 	struct l2cap_conn *conn;
@@ -7603,6 +7608,7 @@ int l2cap_disconn_ind(struct hci_conn *hcon)
 }
 
 static void l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason)
+	__must_hold(&hcon->hdev->lock)
 {
 	if (hcon->type != ACL_LINK && hcon->type != LE_LINK)
 		return;
@@ -7630,6 +7636,7 @@ static inline void l2cap_check_encryption(struct l2cap_chan *chan, u8 encrypt)
 }
 
 static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
+	__must_hold(&hcon->hdev->lock)
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
 	struct l2cap_chan *chan;
@@ -7814,6 +7821,8 @@ int l2cap_recv_acldata(struct hci_dev *hdev, u16 handle,
 		return -ENOENT;
 	}
 
+	lockdep_assert_held(&hcon->hdev->lock);
+
 	hci_conn_enter_active_mode(hcon, BT_POWER_FORCE_ACTIVE_OFF);
 
 	conn = hcon->l2cap_data;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 09edd72acc22..0d6b41fe0b34 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3876,6 +3876,8 @@ static int user_pairing_resp(struct sock *sk, struct hci_dev *hdev,
 	}
 
 	if (addr->type == BDADDR_LE_PUBLIC || addr->type == BDADDR_LE_RANDOM) {
+		lockdep_assert_held(&conn->hdev->lock);
+
 		err = smp_user_confirm_reply(conn, mgmt_op, passkey);
 		if (!err)
 			err = mgmt_cmd_complete(sk, hdev->id, mgmt_op,
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index c4470958b0d5..f23b695c487b 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2327,12 +2327,15 @@ static void smp_send_security_req(struct smp_chan *smp, __u8 auth)
 
 int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 {
-	struct l2cap_conn *conn = hcon->l2cap_data;
+	struct l2cap_conn *conn;
 	struct l2cap_chan *chan;
 	struct smp_chan *smp;
 	__u8 authreq;
 	int ret;
 
+	/* Caller shall ensure there can be no race with l2cap_conn_del() */
+	conn = context_unsafe(hcon->l2cap_data);
+
 	bt_dev_dbg(hcon->hdev, "conn %p hcon %p level 0x%2.2x", conn, hcon,
 		   sec_level);
 
@@ -2421,6 +2424,8 @@ int smp_cancel_and_remove_pairing(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	if (!hcon)
 		goto done;
 
+	lockdep_assert_held(&hcon->hdev->lock);
+
 	conn = hcon->l2cap_data;
 	if (!conn)
 		goto done;
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index eac27bd541bb..c86c46389007 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -180,11 +180,13 @@ enum smp_key_pref {
 
 /* SMP Commands */
 int smp_cancel_and_remove_pairing(struct hci_dev *hdev, bdaddr_t *bdaddr,
-				  u8 addr_type);
+				  u8 addr_type)
+	__must_hold(&hdev->lock);
 bool smp_sufficient_security(struct hci_conn *hcon, u8 sec_level,
 			     enum smp_key_pref key_pref);
 int smp_conn_security(struct hci_conn *hcon, __u8 sec_level);
-int smp_user_confirm_reply(struct hci_conn *conn, u16 mgmt_op, __le32 passkey);
+int smp_user_confirm_reply(struct hci_conn *conn, u16 mgmt_op, __le32 passkey)
+	__must_hold(&conn->hdev->lock);
 
 bool smp_irk_matches(struct hci_dev *hdev, const u8 irk[16],
 		     const bdaddr_t *bdaddr);
-- 
2.55.0

