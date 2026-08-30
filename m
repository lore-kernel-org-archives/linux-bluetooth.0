Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4686F2F6188;
	Sun, 30 Aug 2026 12:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788091459; cv=pass; b=IDYM36eZZRRv+/qzf2DWns+Jc4I37p7v+AwmmDro7lPtmnLr7pdyqH+THZz3X1eZM7kXNIjAkyj4FhEgkefcDyZIO1NrMEXQyVDK+4Dvrgc9j/w9nv888hc8d2uoc3quI4GsMPwxGa0wxq+nQOnufxEJ8JX0EsRhSP+2ik0jp/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788091459; c=relaxed/simple;
	bh=A9rklMPuyzrE14fi/pO/Ydf1YVTm+qJXiTBTZR5cdCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qS0RnB976B6FTKxabOrg8VtCf9wvm0J6CAfHS4ZVTa7hDECx56jtkcqGSQMv5LcFRAX5tIi0M9DS7qw+0ysV6C9CSxM1kFvV1UJ2+mHxDq6E4gEgdlCKi4+aNGO1b6ige/pazxK9vMhdoH3h8CiNtoMGVzEvA1sW0Fmr4bofyjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=zQMtRjGr; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="zQMtRjGr"
Received: from monolith.lan (unknown [IPv6:2a02:6ea0:1508:6::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hXrQ23Qp7zyVw;
	Sun, 30 Aug 2026 15:04:10 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788091450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Jpkq5gloEA+gu3kHhMtoFYmS0u3z3b9Q4t6Mlc4LPQY=;
	b=zQMtRjGr9RVQhx0WQlYKnSFsww097DVaOaxEpRfM9CK5KMJyBWQNHmSYOgKZFlCybO7mkO
	/YELfGm5MO8I5AaDiTFo3q2x5DbQGPcSW5SoocOzuMqVaKFRkav3iNURHoMRb6NRTV4oiS
	95g8NwzP9cetJYWfJEP+1dAOPXPYveY=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788091450;
	b=n1F3059OKBTQ6BAhRu8kKby2fQO+68KyFxc3EAekqgQAx0UZplITmCpMbcs9mo9mHtEjfH
	xnE2Uzu42RM87qXoPZqwcF3Y05btkQw79glHkMr/8IVrJ1WF+gLfxDzVXLVKmjJGbavFBJ
	kLSf155oZ+lm4vSo64X5sBE3klcGLPw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788091450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Jpkq5gloEA+gu3kHhMtoFYmS0u3z3b9Q4t6Mlc4LPQY=;
	b=TOyq5Hmey4EWPfDMbf5i7PtbY81LJWjoeRhftzJ+fx5doNCUk8z1bkhcfl1TtMFUIk04UH
	fMdF6kcSuVplOoixbJEMIu4NyFPAHTxuN/b/JI2ckBHZjhzPRIMdqPJEm+dq4MX4M4J66j
	EoxGAlYqeZutGnChAG8c9809Sq9uvrk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: L2CAP: fix out-of-bounds write in l2cap_ecred_connect
Date: Sun, 30 Aug 2026 15:04:01 +0300
Message-ID: <2b863abeea0ada6e990b07a7f3182e261ecd8e09.1788091154.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2cap_chan_connect() tries to ensure there are no more than
L2CAP_ECRED_CONN_SCID_MAX pending ECRED channels, so they fit in the
same L2CAP_ECRED_CONN_REQ that l2cap_ecred_connect() constructs.

However, the check only counts deferred channels.  If 6 L2CAP sockets
are connected at the same time in order DDDDND (D=deferred,
N=non-deferred), the last can bump the total to max+1.  It results to
one __le16 written out of bounds of the scid array, and an invalid
ECRED_CONN_REQ being sent.

Fix by leaving room for the non-deferred pending ECRED channels in the
counting in l2cap_chan_connect(), so the limit can't be exceeded.

Move counting under same critical section where the channel is added.
Although race conditions involving this appear unreachable, it's easier
to see.

Also add WARN_ON_ONCE check in l2cap_ecred_defer_connect() to make this
less brittle.

Fixes: da49b602f7f7 ("Bluetooth: L2CAP: Use DEFER_SETUP to group ECRED connections")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    Bug found as pre-existing in sashiko.dev report
    
    v2:
    - Do counting differently, to avoid calling chan->ops->get_peer_pid for
      non-deferred channels.
    - Move counting inside existing conn->lock critical section, it's better
      for locking context of get_peer_pid.

 net/bluetooth/l2cap_core.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 358b11eabd4f..1b612b9beaa8 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1329,7 +1329,7 @@ static void l2cap_le_connect(struct l2cap_chan *chan)
 struct l2cap_ecred_conn_data {
 	struct {
 		struct l2cap_ecred_conn_req_hdr req;
-		__le16 scid[5];
+		__le16 scid[L2CAP_ECRED_CONN_SCID_MAX];
 	} __packed pdu;
 	struct l2cap_chan *chan;
 	struct pid *pid;
@@ -1357,6 +1357,10 @@ static void l2cap_ecred_defer_connect(struct l2cap_chan *chan, void *data)
 	if (test_and_set_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))
 		return;
 
+	/* Unreachable, checked in l2cap_connect (+timer drops it if reached) */
+	if (WARN_ON_ONCE(conn->count >= ARRAY_SIZE(conn->pdu.scid)))
+		return;
+
 	l2cap_ecred_init(chan, 0);
 
 	/* Set the same ident so we can match on the rsp */
@@ -7374,6 +7378,9 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		goto done;
 	}
 
+	mutex_lock(&conn->lock);
+	l2cap_chan_lock(chan);
+
 	if (chan->mode == L2CAP_MODE_EXT_FLOWCTL) {
 		struct l2cap_chan_data data;
 
@@ -7381,19 +7388,20 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		data.pid = chan->ops->get_peer_pid(chan);
 		data.count = 1;
 
-		l2cap_chan_list(conn, l2cap_chan_by_pid, &data);
+		__l2cap_chan_list(conn, l2cap_chan_by_pid, &data);
+
+		/* Leave room for non-deferred channel that ends the group. */
+		if (test_bit(FLAG_DEFER_SETUP, &chan->flags))
+			data.count += 1;
 
 		/* Check if there isn't too many channels being connected */
 		if (data.count > L2CAP_ECRED_CONN_SCID_MAX) {
 			hci_conn_drop(hcon);
 			err = -EPROTO;
-			goto done;
+			goto chan_unlock;
 		}
 	}
 
-	mutex_lock(&conn->lock);
-	l2cap_chan_lock(chan);
-
 	if (cid && __l2cap_get_chan_by_dcid(conn, cid)) {
 		hci_conn_drop(hcon);
 		err = -EBUSY;
-- 
2.55.0

