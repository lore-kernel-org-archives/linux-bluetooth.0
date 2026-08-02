Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD2D4A21
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Aug 2026 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785676837; cv=none; b=VKqjUJPD9P9yUVg2M6n1VmJqkE6wlpm8wQlj/Heg3G4sM9a1z/k/5GNNXsW4gFQAvi3V9nacsVr5ym6DUOyiwOJQXsZyYrUjUvffnBzIdwiNVpA+rfb2M2OnuVUeUNVPmHHh2s68SK2m4wf95u+QCLONVfATgAUK3Knt3okFFK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785676837; c=relaxed/simple;
	bh=VLQyAYtULRZagQmNoCHD7IAvvHyJU9vQFCpQQCOoadM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oG8Zi3Ill/bh5klWCTtSam4YE6tBzlop/myavKRW7yr+3tF81BPgW3i/lezCzn72CTS7mCeCVUOJJHIGUvCWRTGblTGarP3kMddw2Iu2MKUtpaFgJwsB4CbBBymaj91u4e5KLgvCvea6dP8iKhBXohW33CH3caho80p0O+dskF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=sc7mXQ8N; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="sc7mXQ8N"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47fe2d179e2so2515f8f.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 02 Aug 2026 06:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1785676833; x=1786281633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hV44Gh0Q41UPQ1NztmVqRIIGr05UAdzVNPCYL2ru+ao=;
        b=sc7mXQ8NeYE2eVvWL29QNmCroQmg1ADDGevFkxqA2/p2O3B8PZw59rJqwo8jgrhBQK
         uDJH7YqFl+3E/seMpzNSTbOJ+nj/3vE8Fo3ABOUITk+f9aRlM4/7dz29RELbrqCt0xiu
         /OpGYCAVTM7k9PWpQCjWrEIUJC4yo7ZCdBuFaiPpb/7Floj6Su7BR7iCA5Zw96C87foK
         18kxg0Wt8lQ5WFcvtclaIwBmvfZsg9fTq+epTMl/YmR/fWrhNHbBeqwihNcxMa+nrd6M
         IMjDPuSTLVkbGwqc8l3PQAB8pOT4RhFTzMsOKhougEqV8IWa36Ut93xEzs1l0waSnnHq
         +R/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785676833; x=1786281633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hV44Gh0Q41UPQ1NztmVqRIIGr05UAdzVNPCYL2ru+ao=;
        b=UZH9K9U3jeqlWcpOLfY7ZNTG+QQ0G/GYWc6W47JumE9bE7Nz8ZvfdtR9PUCtvwcR9j
         LBapIUzCaFFENvADBrByJOXI9CuU5T2o/DmTYP/VxVlO1x1mAoqBfhMnKL1CmsqP5nRT
         AjnN50XgB+60/qdSCkSHhP2dHjlxeJ7pi0hasjscZ9R1AND0ioVImJqxihbw9AuXpDOQ
         SP/NsoflRSkUocATHYWLN44Kr2UFCMrp/6usrFJC3s/TqsvaPqLId6a3rZFACTJ7sVPd
         G1c0QFE7hpG7seD6zQ1HeAicn23p8e1QMIYckKiP1wPjxdJTU5JCOVXpSEZ54ClXOfza
         OGxw==
X-Gm-Message-State: AOJu0Yy4ICooeaNA5iQczFzySNLAT/LJNpJ48amVciPmnyKhpNpy+Xe6
	6RniVPmEyjhnafLP3+v80j2mABX6+bhwXu1sAoYsjeqP3irzn8v/EcJhiYMDfzcADauo
X-Gm-Gg: AR+sD10PBMGK47Ky8uEbVBmRK8bVIreFH4zOINKkFtdeeuXSACbu+wySBB1UYDP9rI7
	t1e2zL1Det+jNbwfH1Al9f4/mfN970ETvd0mJ/6D/S5nN0JPxokxTV4SxSnNDYAqov4POe2Smsi
	2xQ8Is5Ki0BKNUlkcWjR2QcBHOy2KW5CFqvseRI/1t6I2MIceqK1ttPwttVqPe9DuUlx64cBd2L
	JNkUg/L3cd44F3hTsSmVEdBH8Ash+H8fddTWTILaP0IRAZqBl4sQUdjotkoaj+oYZdFmuvkZwlx
	MR/T6WqeX5gPFvvu2GTOmi7LFrJ8K/dOgQQMPTLtfbi75Qb7YVERcQdaljjVLusA82n8UMGy3RY
	IA+p0kGo6xN9/GrLHNyqeK64InI/V8jFOmKG/39PVHjA7N3zcM123tv6QpFtooORvILqC3eBPgE
	SmRhOinrkyYT4YK7x7M9QleiFtMeP/Cv8/2soKrIUaoSR5WeL7CQtnD1OMVlLP3yaTPwuRGSO0l
	plFiVgj0AYnH5eqbPLkL4oRHTjHVCW3bhW5zaCzQ8/d/r4KQoxCEXwWuKFyBvHBJ2Kncl+4zOH3
	7Qx64SszaNpFIsIc1kzYbvFsK+Ex9w==
X-Received: by 2002:adf:e9cc:0:b0:47f:4e42:669 with SMTP id ffacd0b85a97d-47fd72b0a31mr11669791f8f.22.1785676832932;
        Sun, 02 Aug 2026 06:20:32 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458adc9sm25429435f8f.27.2026.08.02.06.20.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 02 Aug 2026 06:20:31 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: luiz.dentz@gmail.com,
	marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] Bluetooth: L2CAP: Fix list corruption in ecred defer recvmsg path
Date: Sun,  2 Aug 2026 15:20:29 +0200
Message-ID: <20260802132029.5118-1-doruk@0sec.ai>
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
L2CAP_DISCONN_REQ -> l2cap_chan_del()) under conn->lock.  Every other
walker of the list holds that lock: l2cap_chan_list() takes it around
__l2cap_chan_list(), and the signalling handlers reach the list from
l2cap_recv_frame(), which runs with it held.  The deferred-accept path
from l2cap_sock_recvmsg() is the only one that does not, so a peer
disconnect landing during the walk leaves it on a poisoned entry:

  list_del corruption, ffff88810420c480->next is LIST_POISON1
  (dead000000000100)
  WARNING: CPU: 1 PID: 88 at lib/list_debug.c:56
  __list_del_entry_valid_or_report+0xd6/0x140
   l2cap_chan_del+0x7c/0x7c0
   __l2cap_ecred_conn_rsp_defer+0x333/0x340
   l2cap_sock_recvmsg+0x338/0x340
   sock_recvmsg+0xec/0xf0
   __sys_recvfrom+0x14c/0x1f0

  BUG: KASAN: wild-memory-access in
  __l2cap_ecred_conn_rsp_defer+0x1c0/0x340
  Read of size 8 at addr dead000000000100 by task race/95
   __l2cap_ecred_conn_rsp_defer+0x1c0/0x340
   l2cap_sock_recvmsg+0x338/0x340
   sock_recvmsg+0xec/0xf0
   __sys_recvfrom+0x14c/0x1f0
  Oops: general protection fault, probably for non-canonical
  address 0xdead000000000100

Take conn->lock around __l2cap_ecred_conn_rsp_defer().  The established
lock order is conn->lock -> chan->lock -> sk_lock (the RX worker reaches
the socket via l2cap_chan_del() -> l2cap_sock_teardown_cb() ->
lock_sock_nested()), so the socket lock is dropped before conn->lock is
taken, mirroring l2cap_sock_shutdown().  The conn is pinned with
l2cap_conn_hold_unless_zero() across the unlocked window.  Only the
EXT_FLOWCTL branch needs this; the LE and BR/EDR defer paths respond for
a single channel and do not walk conn->chan_l.

Reproduced with hci_vhci on a KASAN + PROVE_LOCKING kernel: a peer sends
L2CAP_ECRED_CONN_REQ over LE, userspace accepts the deferred channels,
and an L2CAP_DISCONN_REQ for a sibling channel races the recvmsg() that
completes the accept.  7 of 10 unpatched boots reproduced it; 10 patched
boots gave neither a splat nor a lockdep report.  Well-formed traffic is
unaffected: the response is built from the same channels with the same
contents, and the only case now skipped is a channel the RX worker has
already removed from conn->chan_l, for which no response is meaningful.

Found by 0sec (https://0sec.ai).
Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:multi-model
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v2: Rewrite the commit message.  v1 called this the recvmsg-path sibling
    of 41c2713b204e; that commit fixes iterator invalidation in a path
    that already runs under conn->lock, not a missing lock, so the
    reference is dropped and the invariant is stated directly instead.
    v1 also cited l2cap_sock_cleanup_listen() as precedent for taking
    conn->lock, which is backwards: it deliberately avoids conn->lock
    because it runs under the parent sk lock.  Only l2cap_sock_shutdown()
    is cited now.  The splat is quoted from an actual run.  Shorten the
    subject to 80 columns and use the AGENT_NAME:MODEL_VERSION form for
    Assisted-by.  The only code change from v1 is four comment lines on
    why chan needs no extra reference across the unlocked window.

    Note for stable: this uses FLAG_DEL, added by b66774b48dd9
    ("Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn ref",
    v7.2-rc1).  Trees without that commit need it first; the patch does
    not build otherwise.

v1: https://lore.kernel.org/linux-bluetooth/20260714125209.39790-1-doruk@0sec.ai/
 net/bluetooth/l2cap_sock.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 735167f73f312..af35608791994 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1227,9 +1227,42 @@ static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
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
+			 * across the unlocked window; chan needs no extra
+			 * reference because the socket holds one until
+			 * sk->sk_socket is cleared, which cannot happen while
+			 * this call is in progress.
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

