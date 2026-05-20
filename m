Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C0636404E
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 16:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295187; cv=none; b=g4mKfhhj+GMDjjdQf+sqFLqXhWEtHUzwDbY1xUDZfRhTJ//9JV7IQ5ZdrN34j+9LZjnqPapyRV7onY55BMhYR72dvcnhScPh+nH3cLcMdJKhLoPwF4MBP7dW4UtVeqF1DYggt8Lp2/io11twygAqc5ZoqbTBS/9nLA/NRtJ2Bds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295187; c=relaxed/simple;
	bh=5rk21phLLOn18anFyujMULAQLbEP84WvcUFHAsaKn4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRBB3GJQjgSpmZ0VtSGVHHzPJOFBQ59fMG8OcXZmN8XbNMevbfYGEq7xsvVAY2TnhJq8g1kjljuCa0NzOgIHGFy8X8RssPl5WEwWm08fDco9AyZnBTlOmvDR+h/YzlV10LsJ4VsDNPXcIdgjkcUg5uOg8F/c8+nh3cYfnNUmt/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=oR9gdxBu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QX0QqCW7; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="oR9gdxBu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QX0QqCW7"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 42FAD7A0079;
	Wed, 20 May 2026 12:39:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 20 May 2026 12:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1779295182; x=
	1779381582; bh=qvSDCxybMlqEBLI6e8lWqkcJBRDlRQCzOmJPg/WXleg=; b=o
	R9gdxBued7lc7YfDsrzAsHwBRVy0T7zPWeelgLJtiYEbnuLKo21OYSS0izRQNbon
	BFFbVwRMqziD8IGhVU9SaOfwVostYkre0rrwNcQpC81wmaHMBclVM613aUOlnQKw
	rrA300jcATZWUpiYwc413O//2XQspzWPnT/MirjorWvnJdNyD6gGWAsBRpsHc5mF
	qE9kmc/f2JR+yNzuNEfhm+CQMXdSJrSDaa2iKxi4drwbP1dwj1OQCK+gx4NE8Pmr
	P25M2G4NECCPpHabCcVILBiY19dpMJ98nJ+h5DX3jn6huinbJ2UhOP9cHMA9FdkH
	uUVeTXf2hfu9NpKa0n5VQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1779295182; x=1779381582; bh=q
	vSDCxybMlqEBLI6e8lWqkcJBRDlRQCzOmJPg/WXleg=; b=QX0QqCW7h8p4MT7Nz
	VbaDoKZP3OMroJAFUDt8wiRs5vYZBpnUtZnpAktu+iF8jlkjDyg0UWqd0reVaFDw
	s9TrW/h3V73vcrgFftZeVpZ9/z1tag8t8vcQAVyR73tmGnoIU5Eh3QdFu09FQCfF
	bpSM1g8Z4t+7KUm37zQSkOzvqK4ZCKgLN9XWXzTOhqiEVqLfnAGPxt0mH5Ez5Uj9
	O8m4NnKDxd1SlzVwkr3gOTVISvZjDpzEhgJImpeGJaHslfW/O+BiaQBWlubL9dNR
	5UCcUOKkinvWDMbYFU9eV9dEvtorSHwqHyoOsjcvbFVxXmAusQUHdIESPjU3tvTz
	W6ZEQ==
X-ME-Sender: <xms:zeMNavTJuVgLXs8RnQ7IXqkINhSFn4d2MPJDaZjO8Y6gchOEVTk4lA>
    <xme:zeMNanobqZJc_KH_zUmboRMfVcPCWjkPH62PUjxBs0glPAyLk4WaplrPtzbBfn0Kq
    tYhL5ZRv3y2F9p_bDwcwnN7ecQSRv2yvOWGt5gWvfWqeROq22q-CzKa>
X-ME-Received: <xmr:zeMNatLhOiSQ2hRrNu6_paRyp9aliGnkI694O0d9eqTMhWARgjVhY7vUb2FulawrmC6RIvo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeehudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpefuihifvghiucgkhhgrnhhguceoohhsshesfhhouhhrughimhdrgiihii
    eqnecuggftrfgrthhtvghrnhepkedtleeiteevueetudevjeefheejueevffejteffvdeh
    lefftdffleegleduvdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepohhsshesfhhouhhrughimhdrgiihiidpnhgspghrtghpthhtohephedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhgtvghlsehhohhlthhmrghnnh
    drohhrghdprhgtphhtthhopehluhhiiidruggvnhhtiiesghhmrghilhdrtghomhdprhgt
    phhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshgrfhgrrdhkrghrrghkuhhssehsvggtuhhnnhhigidrtghomhdp
    rhgtphhtthhopehoshhssehfohhurhguihhmrdighiii
X-ME-Proxy: <xmx:zeMNaqr8LSMo1wHft_dNrtHMGWK29Al7Y7FQZuE2HgpThFaAE4_a_w>
    <xmx:zeMNalwNY9mKqcdWJY2oTlWmBv_47Pqhbr1M2L0S8By74W5wLOU9nw>
    <xmx:zeMNauOx-alybW2FPznWJMga0iz91r8EZWgk_pV61xubEA4IHSBYng>
    <xmx:zeMNaq73n-I0Zz-WobDkqsL_PfJSQhI8IahtoG7ONx3YCStmnjz3PQ>
    <xmx:zuMNahA-_l6NCT-d6GzMkipe8x0h-wGsp8p6Uo7c3GizssDlVER1R_OI>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 May 2026 12:39:41 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	=?UTF-8?q?Safa=20Karaku=C5=9F?= <safa.karakus@secunnix.com>,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v7 RESEND 1/1] Bluetooth: L2CAP: Fix slab-use-after-free in l2cap_sock_cleanup_listen()
Date: Wed, 20 May 2026 12:38:17 -0400
Message-ID: <20260520163859.2859782-2-oss@fourdim.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520163859.2859782-1-oss@fourdim.xyz>
References: <20260520163859.2859782-1-oss@fourdim.xyz>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2cap_sock_cleanup_listen() calls l2cap_chan_close() without holding
conn->lock. A concurrent task iterating conn->chan_l under conn->lock
can access a channel that has been removed from the list and freed.
That can result in a slab-use-after-free.

Split cleanup into two phases. Drain the accept queue under the parent's
sk_lock onto a local list, taking a sock reference on each child so it
survives the lock drop. Then release the parent and close every drained
child under conn->lock + chan_lock, using
l2cap_chan_hold_unless_zero()/l2cap_conn_hold_unless_zero() to cope with
a teardown that has already started, and skipping any chan whose
->data has been cleared. Reacquire the parent's sk_lock at the end so
the caller's contract is preserved.

Noted that commit ab4eedb790ca
("Bluetooth: L2CAP: Fix corrupted list in hci_chan_del")
renamed chan_lock to lock in l2cap_conn.

Fixes: 3df91ea20e74 ("Bluetooth: Revert to mutexes from RCU list")
Cc: stable@kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
---
 net/bluetooth/l2cap_sock.c | 57 ++++++++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 71e8c1b45bce..48b018991ced 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1471,27 +1471,68 @@ static int l2cap_sock_release(struct socket *sock)
 static void l2cap_sock_cleanup_listen(struct sock *parent)
 {
 	struct sock *sk;
+	struct bt_sock *bs, *tmp;
+	LIST_HEAD(killable);
 
 	BT_DBG("parent %p state %s", parent,
 	       state_to_string(parent->sk_state));
 
-	/* Close not yet accepted channels */
+	/* Drain unaccepted children to a local list, pinning each so it
+	 * survives the parent lock-drop below.
+	 */
 	while ((sk = bt_accept_dequeue(parent, NULL))) {
-		struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+		sock_hold(sk);
+		list_add_tail(&bt_sk(sk)->accept_q, &killable);
+	}
 
-		BT_DBG("child chan %p state %s", chan,
-		       state_to_string(chan->state));
+	/* l2cap_chan_close() must run under conn->lock, but the rx path
+	 * (l2cap_sock_new_connection_cb) takes conn->lock then lock_sock(parent),
+	 * so parent must be released before we close.  Draining the queue
+	 * first means a concurrent cleanup_listen() on the same parent finds
+	 * it empty and is a no-op.
+	 */
+	release_sock(parent);
+
+	list_for_each_entry_safe(bs, tmp, &killable, accept_q) {
+		struct l2cap_chan *chan;
+		struct l2cap_conn *conn;
+
+		sk = (struct sock *)bs;
+		list_del_init(&bs->accept_q);
+
+		chan = l2cap_chan_hold_unless_zero(l2cap_pi(sk)->chan);
+		if (!chan) {
+			sock_put(sk);
+			continue;
+		}
 
-		l2cap_chan_hold(chan);
+		l2cap_chan_lock(chan);
+		conn = l2cap_conn_hold_unless_zero(chan->conn);
+		l2cap_chan_unlock(chan);
+
+		if (conn)
+			mutex_lock(&conn->lock);
 		l2cap_chan_lock(chan);
 
-		__clear_chan_timer(chan);
-		l2cap_chan_close(chan, ECONNRESET);
-		l2cap_sock_kill(sk);
+		BT_DBG("child chan %p state %s", chan,
+		       state_to_string(chan->state));
+
+		if (chan->data) {
+			__clear_chan_timer(chan);
+			l2cap_chan_close(chan, ECONNRESET);
+			l2cap_sock_kill(sk);
+		}
 
 		l2cap_chan_unlock(chan);
+		if (conn) {
+			mutex_unlock(&conn->lock);
+			l2cap_conn_put(conn);
+		}
 		l2cap_chan_put(chan);
+		sock_put(sk);
 	}
+
+	lock_sock_nested(parent, L2CAP_NESTING_PARENT);
 }
 
 static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
-- 
2.54.0

