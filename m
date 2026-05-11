Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB3F157A5A
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 03:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778469569; cv=none; b=M9l1/LtucnQxjPxDNg5uRxt+F0bhpRPe3yPRACRt+wQaD3y2Og9+d/+q3wlW1h4quug+7hLO5A/+oly0JVH/G5/gFrn++s0A6K5Wk1jerYkinYvyaAMOvPlyzseMu9f+l4FZUScrNQofaJfzetupdEazLkezEob3A4z88rQsglw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778469569; c=relaxed/simple;
	bh=hVxLbyw+mDSOeCecgbwf/II5SQzftgMnVATS3jJW1CA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mSEzEeYlczgPX9QGzGMr/4rSNX3DKmxyhdRBEb0MHsJSqGm5XDGIwFmaLi0l8HQ6eGVcAGci2HAEEdm6MF7IvTROr94TjtPy6RrzmeZ8izIZASMvLl+m5DeI7URitFA5cu9hMu7EDYNBjUDZA4TRC3GeWuLviSNvWyX6DI4yaak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=FJu/HJJX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dzVJ1Yxk; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="FJu/HJJX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dzVJ1Yxk"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EB4C01400054;
	Sun, 10 May 2026 23:19:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 10 May 2026 23:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1778469566; x=
	1778555966; bh=WLG9pkhsmwl+iZQnTrLb/lDRUQq+fTV2rnMiAIFk9kc=; b=F
	Ju/HJJX0t5/pelKwW/0wVl07X0p1n0F1uK1H7WI730NkTe7sdnvcDXIKwE7BAwlY
	D8LZXzD3hpiEurSjZmYBU1odG4006hGnUgq1v44zVyYq4mZzN9mUgJuCti7GqAqK
	Iz6NWIKlj1KpC493p2CdDky4ZSBcIou3qIgADmWFJNHV3GL1AaYIvqCUqEaxfgH6
	waIHoNYBmZrUZF8EwHgePgB7Iuei2pMab6S0LZheFhOmV8DclgVczwlpiMoEpG+5
	OwjVdpsW1KJ/5btrA1cMqAnQ4dzw8v0KyRxx/ck/k1IE0kG3SF1pAZpeNzddVuQd
	60awfELXhu+k/Mbz7MD+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1778469566; x=1778555966; bh=W
	LG9pkhsmwl+iZQnTrLb/lDRUQq+fTV2rnMiAIFk9kc=; b=dzVJ1Yxk2hF111EbI
	HabtNmfxW1aGS7rlbMtkz6XpcY4bQaTG6lmUA+QTeTymFBGpzXcgZlH1p5Rg6oZ3
	CySeGu5R4Z3AZuGKX45kDvnLYq34cHjEjFsdgUwVJwCg4S/5R+7TAwERfhPIInFV
	9QRejPxnoSFELQao8qAWn0Y9OvhBk+KT09L05+93EykHpZRIbCI7pqNdLQJMw5eC
	9bNlJ7N/ipLALIv4FEt4CSZ/fmtNykYqgD/liVbvHBgUHIdwYkDuR1vBIAHbZNkf
	CbMjRorrvyEHmO+F82AvLoMravZ9SeieKi/qel6QUIcNSwhgo1GGDA7XPl9FJ9Sd
	kpAow==
X-ME-Sender: <xms:vkoBarxw_1JWyBrIDXfvXgLFsa8RCCRZnIcvQJq0pS9FPpmjQ94iAg>
    <xme:vkoBaqSoii6Y6mMrcQYbM8i_IOn3_5fRCsFpmMqYNgux9oCfvtrUgk1h_0X1iLagO
    mhnC0HzRAvm1c4LrjM7i6_2E2DwI8YXRuadmVSOvl6Vey3w_PzxFCs>
X-ME-Received: <xmr:vkoBaqUzp4HjAYHHPM-MeuGWKQbH2f6kuwQeJBS8GycJP32J7zRnkph2SRwPWOClPKoLd4k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudejkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpefuihifvghiucgkhhgrnhhguceoohhsshesfhhouhhrughimhdrgiihii
    eqnecuggftrfgrthhtvghrnhepkedtleeiteevueetudevjeefheejueevffejteffvdeh
    lefftdffleegleduvdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepohhsshesfhhouhhrughimhdrgiihiidpnhgspghrtghpthhtohepgedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhgtvghlsehhohhlthhmrghnnh
    drohhrghdprhgtphhtthhopehluhhiiidruggvnhhtiiesghhmrghilhdrtghomhdprhgt
    phhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepohhsshesfhhouhhrughimhdrgiihii
X-ME-Proxy: <xmx:vkoBakZJ0_fnIAgDNy6bFhRWSFFgDac5cjwOjQJTft6zCfQay4Cogw>
    <xmx:vkoBao1MlEZbud1RRVibMMfA_HRjrQqQM7pHdnwsJyCSxm9yWLRj3Q>
    <xmx:vkoBauiTfXDLWOPTVWJavPlW4fP6JaR2T4FFVXqrdqegjBIGXJrscQ>
    <xmx:vkoBakZ9JcoEVaBzoEHnACWoPScVVRHtrS36gZACKkmMHzEQsiSAQQ>
    <xmx:vkoBavkcz2Hg7pa_Dd0PyogdKJa5OGsN9udk9bguMsnmmRJ4HVAtZb28>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 May 2026 23:19:26 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH 1/1] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
Date: Sun, 10 May 2026 23:18:26 -0400
Message-ID: <20260511031837.221778-2-oss@fourdim.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511031837.221778-1-oss@fourdim.xyz>
References: <20260511031837.221778-1-oss@fourdim.xyz>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2cap_sock_new_connection_cb() accesses l2cap_pi(sk)->chan after
release_sock(parent). Once the parent lock is released, the child
socket sk can be freed by another task.

Save the channel pointer into a local variable while the parent lock
is still held to prevent this.

Fixes: 8ffb929098a5 ("Bluetooth: Remove parent socket usage from l2cap_core.c")
Cc: stable@kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
---
 net/bluetooth/6lowpan.c    |  5 +++++
 net/bluetooth/l2cap_core.c | 12 ++++++++++++
 net/bluetooth/l2cap_sock.c | 13 ++++++++++++-
 net/bluetooth/smp.c        |  5 +++++
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 2f03b780b40d..bbe67bd73f9c 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -755,6 +755,11 @@ static inline struct l2cap_chan *chan_new_conn_cb(struct l2cap_chan *pchan)
 
 	BT_DBG("chan %p pchan %p", chan, pchan);
 
+	/* Match the put that the caller of ops->new_connection() performs
+	 * once it is done with the returned channel pointer.
+	 */
+	l2cap_chan_hold(chan);
+
 	return chan;
 }
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 95c65fece39b..fc663386872c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4071,6 +4071,9 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 
 	__l2cap_chan_add(conn, chan);
 
+	/* Drop the ops->new_connection() ref; conn list now pins chan. */
+	l2cap_chan_put(chan);
+
 	dcid = chan->scid;
 
 	__set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
@@ -4978,6 +4981,9 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 
 	__l2cap_chan_add(conn, chan);
 
+	/* Drop the ops->new_connection() ref; conn list now pins chan. */
+	l2cap_chan_put(chan);
+
 	l2cap_le_flowctl_init(chan, __le16_to_cpu(req->credits));
 
 	dcid = chan->scid;
@@ -5202,6 +5208,9 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 
 		__l2cap_chan_add(conn, chan);
 
+		/* Drop the ops->new_connection() ref; conn list now pins chan. */
+		l2cap_chan_put(chan);
+
 		l2cap_ecred_init(chan, __le16_to_cpu(req->credits));
 
 		/* Init response */
@@ -7402,6 +7411,9 @@ static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 			chan->dst_type = dst_type;
 
 			__l2cap_chan_add(conn, chan);
+
+			/* Drop the ops->new_connection() ref; conn list now pins chan. */
+			l2cap_chan_put(chan);
 		}
 
 		l2cap_chan_unlock(pchan);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 71e8c1b45bce..355fad9e2955 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1497,6 +1497,7 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
 static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 {
 	struct sock *sk, *parent = chan->data;
+	struct l2cap_chan *child_chan;
 
 	lock_sock(parent);
 
@@ -1520,9 +1521,19 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 
 	bt_accept_enqueue(parent, sk, false);
 
+	child_chan = l2cap_pi(sk)->chan;
+
+	/* Pin the channel for the caller. Once release_sock(parent) returns,
+	 * userspace can accept(2) and immediately close(2) the child socket,
+	 * which would drop the socket's references on the channel and free
+	 * it before the caller (e.g. l2cap_connect_req()) is done using the
+	 * returned pointer. The matching put is the caller's responsibility.
+	 */
+	l2cap_chan_hold(child_chan);
+
 	release_sock(parent);
 
-	return l2cap_pi(sk)->chan;
+	return child_chan;
 }
 
 static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 98f1da4f5f55..32761d3d252e 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3261,6 +3261,11 @@ static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *pchan)
 
 	BT_DBG("created chan %p", chan);
 
+	/* Match the put that the caller of ops->new_connection() performs
+	 * once it is done with the returned channel pointer.
+	 */
+	l2cap_chan_hold(chan);
+
 	return chan;
 }
 
-- 
2.54.0

