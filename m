Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB513AA1A7
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 12:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784033535; cv=none; b=RR1kHedBfY5/6A0y2bgXu34HQpWn9QaAn6G89PwW/oYnVcwF0z7Y4l9poPdZUttW7YEwEMhvsIX1kEiYIYHo7ovpdnbG1jORJn4hqx31NuMNIYikevvYuULEy2gie2qCfS3DU3YVC8EqE+sHYd+/Hc9oSaSKRzEQr3WqFXT9Fj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784033535; c=relaxed/simple;
	bh=K/aLER6+ebVkGgjRtZVtDuCurkZdvKTMurcmLpU+6qo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=avaUcbUCEtvrSghYNmoQg+tXYFAk0ycf1UXveM4krU44XWyY/+Ng6KigAiGUq9GMpdKj6n471MgWtb153/f5TFiR8GqnoIkmAnNqTCenaR6/K1SESVz1RU/Wn0tGEcj7RfqCyUcrOo/AL6UcbR56Fz56TMQ0NSJE2MileGDib4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=sk3JiuPO; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="sk3JiuPO"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493bb510ce4so30363585e9.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 05:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784033532; x=1784638332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uhf+KlmAvjC3IU/9RdHkwgo2wg9fs34PDje4Hy9fpNw=;
        b=sk3JiuPOqxdxnkH7kO50+YJGa2IxqAOoVxMoO3FKJdtydnbninLrPlh48hQjpqpIMx
         PhgvGZgAMfcYIErJcDb1h/QoWxVP4uJUxProb1uO96XmzmviLdHICmubWE/w2xiTF0ES
         FQeBQqoiMQtIPppiWezODMiAVZw1kQsz+lzexh/uuPAk8u/Qx2xviaOQtgStfWY42sTd
         2YMEMTAUtygUjAsmi/HKdP7FiWxPwr1a9GWUz2m7foW2Vug2RqeIQIlzEZOnZUI1TKaN
         aOECkYFoKNUhqy+pvrF+Pt8FjXM+lOlATaxhvwDYyEGKecATuYyWgtdtsJFY9MMBXyLW
         GyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784033532; x=1784638332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uhf+KlmAvjC3IU/9RdHkwgo2wg9fs34PDje4Hy9fpNw=;
        b=Nm/6DLpzO7NiDgslBhLYo78YvWW5HmmdMOScaVVT5W6otJOEEy/3xoWN6cmrJD8Hps
         PTgQpiv/beDWLzzj2Tsc+wfrSTJS8UlKFwRcxvXFNYDaubLoABr9n1g/N5sgDFYGDWSh
         5tNtNcIn86CkbsDKfAXbj8d3PETILio2wC34VSYsglOZqPo99MD+2kQGf+sW1nCJGi5l
         NxOjB5rkDujjW8rz+pWYNL3Gdj+KZbabDKFPnIUxfNfzJGERKZdQfp3jMDdxL9/kfiOm
         0uaVem3PxnCTjm3gsSWwh9ACPLXQ4t14S9ItqSOWQaVCRiSnIBo/lS5laES7Hv0SYGlg
         8buA==
X-Gm-Message-State: AOJu0Yxm4bsNruRuv/6xS2Jzpw7l1OjbUsfzoZv5WVBLiaLbfqRhYhA5
	dGJJX1fcj798mzLZGGVZdUu/BHRWp43TcdzkX0jCS2qFs3s4dP0Yx1MGdDmvEFf5I+Xm9JXDOib
	Cosl9YU9i
X-Gm-Gg: AfdE7cmvSN/+aagJM1YcgUY0jNxzQsog0bi9/UA4H9lh0zwdpk/4mI4GRglfzj1YHNf
	wftW4IgoPMS/IbfNmhcal+oWjeaOwn95u+KVwZF+xMqL6hUGjAjcFQZX907smEXCA64G3Ddb1Na
	IveD60Ep3BvNCv3GLqi1NwuJH+fC0MOZ6xg9uSi6cwYS2eO/QZiXYzHLhzwyY88DfvlDXBr9hqK
	nQ/A6fWNPp1382WyV0WWY6bFIm3rsS/k9iW5z6ISQQ9Lt3xqlRk7539AcRtwy81M1tUGewzLEyF
	oK1tKTne8DdAHnlSG3VStVIygJ+8+xPM5wf1mNK3aDXjz8Q/WzSUWp7/+Potf5+JNSvTya9O9cB
	YXEMFoaxqt2t50pJDJFPbRIepwfBuiadsNnmrwdcWktHRRsaf4j1wtGjUaVtNHw4qIAzB8/5gdj
	ZgN+FNMKRGKyX/+IYQrTPAsA7if4qfrU2V21gFQ8+osX4tLL/lHqUMjQ/Zupa6n89+nq3K68GIM
	ViKp2zb4VbTIewEuvkU2kIFgngkD0pMu34=
X-Received: by 2002:a05:600c:609a:b0:492:4363:e7eb with SMTP id 5b1f17b1804b1-495389d21cfmr22459345e9.32.1784033531857;
        Tue, 14 Jul 2026 05:52:11 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a2f9402sm78431305e9.13.2026.07.14.05.52.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 05:52:11 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: luiz.dentz@gmail.com,
	marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: take chan_l lock in ecred defer recvmsg path to fix list corruption
Date: Tue, 14 Jul 2026 14:52:09 +0200
Message-ID: <20260714125209.39790-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a deferred L2CAP_MODE_EXT_FLOWCTL connection is accepted,
l2cap_sock_recvmsg() (BT_CONNECT2 + BT_SK_DEFER_SETUP branch) calls
__l2cap_ecred_conn_rsp_defer() while holding only lock_sock(sk).  That
function walks conn->chan_l via __l2cap_chan_list_id() and, on the
authorization/refuse path, removes channels with l2cap_chan_del() ->
list_del(&chan->list) -- all without conn->lock.

conn->chan_l is serialised by conn->lock and is concurrently mutated by
the RX worker, which processes inbound signalling (e.g. an
L2CAP_DISCONN_REQ -> l2cap_chan_del()) under conn->lock.  A lockless
traversal/removal racing the RX worker's list_del() corrupts the list:

  list_del corruption, ...->next is LIST_POISON1 (dead000000000100)
  WARNING lib/list_debug.c:56 __list_del_entry_valid_or_report
   l2cap_chan_del+0xdb/0x1140
   __l2cap_ecred_conn_rsp_defer+0x61d/0x700
   l2cap_sock_recvmsg+0x758/0x8b0
  Oops: general protection fault
  KASAN: maybe wild-memory-access in range [dead000000000100-...]
   __l2cap_ecred_conn_rsp_defer+0x3c6/0x700
   l2cap_sock_recvmsg+0x758/0x8b0

This is the recvmsg-path sibling of commit 41c2713b204e ("Bluetooth:
L2CAP: Fix possible crash on l2cap_ecred_conn_rsp"), which addressed the
same conn->chan_l manipulation on the signalling (l2cap_ecred_conn_rsp)
side; the deferred-accept path was left unguarded.

Take conn->lock around __l2cap_ecred_conn_rsp_defer().  The established
lock order is conn->lock -> chan->lock -> sk_lock (the RX worker reaches
the socket via l2cap_chan_del() -> l2cap_sock_teardown_cb() ->
lock_sock_nested()), so the socket lock is dropped before conn->lock is
taken, mirroring l2cap_sock_shutdown() and l2cap_sock_cleanup_listen().
The conn is pinned with l2cap_conn_hold_unless_zero() across the
unlocked window.  Only the EXT_FLOWCTL branch needs this; the LE and
BR/EDR defer paths respond for a single channel and do not walk
conn->chan_l.

Found by 0sec (https://0sec.ai).
Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Cc: stable@vger.kernel.org
Assisted-by: 0sec
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 net/bluetooth/l2cap_sock.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 735167f73f31..796b9a4eee24 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1227,9 +1227,39 @@ static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	if (sk->sk_state == BT_CONNECT2 && test_bit(BT_SK_DEFER_SETUP,
 						    &bt_sk(sk)->flags)) {
 		if (pi->chan->mode == L2CAP_MODE_EXT_FLOWCTL) {
+			struct l2cap_chan *chan = pi->chan;
+			struct l2cap_conn *conn;
+
 			sk->sk_state = BT_CONNECTED;
-			pi->chan->state = BT_CONNECTED;
-			__l2cap_ecred_conn_rsp_defer(pi->chan);
+			chan->state = BT_CONNECTED;
+
+			/* __l2cap_ecred_conn_rsp_defer() walks and mutates
+			 * conn->chan_l (via __l2cap_chan_list_id() and
+			 * l2cap_chan_del()), which is serialised by conn->lock
+			 * and is concurrently modified by the RX worker.  The
+			 * established lock order is
+			 * conn->lock -> chan->lock -> sk_lock, so the socket
+			 * lock must be dropped before taking conn->lock to
+			 * avoid inverting it (lockdep deadlock).  Pin the conn
+			 * across the unlocked window.
+			 */
+			conn = l2cap_conn_hold_unless_zero(chan->conn);
+			release_sock(sk);
+			if (conn) {
+				mutex_lock(&conn->lock);
+				/* The RX worker may have torn the channel down
+				 * (FLAG_DEL, removed from conn->chan_l) while the
+				 * socket lock was dropped; skip the response in
+				 * that case. conn->lock below serialises the
+				 * chan_l walk against the RX worker's
+				 * l2cap_chan_del().
+				 */
+				if (!test_bit(FLAG_DEL, &chan->flags))
+					__l2cap_ecred_conn_rsp_defer(chan);
+				mutex_unlock(&conn->lock);
+				l2cap_conn_put(conn);
+			}
+			lock_sock(sk);
 		} else if (bdaddr_type_is_le(pi->chan->src_type)) {
 			sk->sk_state = BT_CONNECTED;
 			pi->chan->state = BT_CONNECTED;
-- 
2.43.0

