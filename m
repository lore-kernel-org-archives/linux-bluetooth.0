Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7869581ACA
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 04:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778475083; cv=none; b=pCBePi1giNZifx0QR3Zq9u9RBHBIBugWhp9pt5vWXC0A9HHttoG3w5HA2Gb+5yvmoVFxykyzIIAkBISzqvfGFGNIjqxEJqCpgdij4BPGHzHrTgchfQGMNzrM98PmKtHlthYdKgvhsWBkI+RTaHSeHGUOpYNaPx90nprDwxuBcOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778475083; c=relaxed/simple;
	bh=wOh6yzk2qnTtkhSS9+xEkB/ImPcZ6XdXQQKd/oRBmkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYTLPdRXNiZJOxUMV34UWBmO6rKKkye8BBZCDBYZ3onoB9THGBBKpWH5MX99esx35kmC0eok8TLAzxk0A5x3B9iJO0sYe3w2D/ECJwwuRh7Mgx+uGDgJqwJHjQkDddLpng1DX10lPaZhRRTJwfMNkRQnY83747h+oLWH2nZ4f2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=MoFeKYLK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TO60dK1a; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="MoFeKYLK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TO60dK1a"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id BC6D8EC0073;
	Mon, 11 May 2026 00:51:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 11 May 2026 00:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1778475080; x=
	1778561480; bh=arD6BGn2YZcHxCYZIbO2qRn2lMx74FTf/6fjEmV3r90=; b=M
	oFeKYLKsbIvodK6hH5tDhbNfxC2RzfCkid7SiBO5u4rIgADgHGHRsnyOZ0oh1gxd
	3V2u32Yd6MlgLKs0guNNIjdMAp47zxl9kf5FNyTgjnk/TORnoyp22dI9obO7V5Cl
	uKlqlzY0vGNdGgitkrJJcBVWTYSAeo79LWN+p8fb60zxuDgfmJPkO6CeEfPl8s2E
	WRN/bm9KfWs9AeQQTeI5m3HWj6XH/t/PRdB6/m3r0ZzAngfDTWfcY37rWsQT2YBJ
	iLd8dVG4CQRceI/VxndKpPylD6JKBFvH9GIKL/LUC1EW38ukbBqzROErGtBNqvkR
	7iy0MkXTIR8Q2LD4HxPWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1778475080; x=1778561480; bh=a
	rD6BGn2YZcHxCYZIbO2qRn2lMx74FTf/6fjEmV3r90=; b=TO60dK1aq+qpOhoja
	eq5svz5P/cv99avBhHIPg8cSkOFMhMvPJ7WplFpan0/d6VrojJYXR1L3OjZe8HOK
	bYvf8f1uBr5fm8ElJNFb4shyeQXmhnx/JaTIDqi6CxquBV2ZrzEfmdbmWSOsE4Oe
	22zAbBTDWIQck3TN9sRFbKKK1dY62kk4Mh7CGocmQZ0KMYkEo9eMbgyq6jfCkDwn
	jBMDwNT79D9+HgIY0TwlKjwAXRjhpJe2s7WuSHRjzxyOjhoGYuKWacdqXm2IIdGS
	ZkTjtbvE4ulqCfdK+5NvjI3eCEcfHkLKumSOoq2p2YcimbQj/N9vKfcovLxd5SEz
	gb7DQ==
X-ME-Sender: <xms:SGABaly5L4F3Om0ZGe_5ZaJ3G_mWdVaOihGsMFGvjKEoroJ_6bOp8Q>
    <xme:SGABasRU2e2wACHvHIBeGBzsRphBQwSSs40Wcq8pp1Q0GfJOJMcqUJYV32LOz6GH-
    bVsz1eFdlsVsdtTsWyLTUGYEkKuRLvutBImg1uh16paOthb64TM2OY>
X-ME-Received: <xmr:SGABakU9SxLZ39tfdJHEcnMsgS5Z_UhHbU-KQ2_XnP7LWhWzE2DMC9Ss8p2IeBxfDewWa5o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudektdejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:SGABamYi0Y0lZ9ZXgA90lBUSeNdHyLGJZzs31cq2ug2cevnaZlid0w>
    <xmx:SGABai1_PB4nJlj_PuDyLl5l4E-IMNQs6555k29gbKe29tICOEG7Ng>
    <xmx:SGABagjiFsx3H3_nm8H22U3S19fbOaRoM1YzTyHgqrRbkzhmT_0ZAA>
    <xmx:SGABauaAHExSKRB-xYVaJIFtojVQvgwrM9qWstSmk8hSJ-p5hp9-EA>
    <xmx:SGABapnhMawBf0lydBYf-32h1eqbnhfBTSLSz4j5tllfwSEwLmhRY5PT>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 00:51:20 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH 1/1] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
Date: Mon, 11 May 2026 00:51:07 -0400
Message-ID: <20260511045124.298319-2-oss@fourdim.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511045124.298319-1-oss@fourdim.xyz>
References: <20260511045124.298319-1-oss@fourdim.xyz>
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
index 23a229ab6a33..71c1c04b61e5 100644
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
index 7701528f1167..0f6c3c651207 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4071,6 +4071,9 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 
 	__l2cap_chan_add(conn, chan);
 
+	/* Drop the ops->new_connection() ref; conn list now pins chan. */
+	l2cap_chan_put(chan);
+
 	dcid = chan->scid;
 
 	__set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
@@ -4970,6 +4973,9 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 
 	__l2cap_chan_add(conn, chan);
 
+	/* Drop the ops->new_connection() ref; conn list now pins chan. */
+	l2cap_chan_put(chan);
+
 	l2cap_le_flowctl_init(chan, __le16_to_cpu(req->credits));
 
 	dcid = chan->scid;
@@ -5194,6 +5200,9 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 
 		__l2cap_chan_add(conn, chan);
 
+		/* Drop the ops->new_connection() ref; conn list now pins chan. */
+		l2cap_chan_put(chan);
+
 		l2cap_ecred_init(chan, __le16_to_cpu(req->credits));
 
 		/* Init response */
@@ -7407,6 +7416,9 @@ static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 			chan->dst_type = dst_type;
 
 			__l2cap_chan_add(conn, chan);
+
+			/* Drop the ops->new_connection() ref; conn list now pins chan. */
+			l2cap_chan_put(chan);
 		}
 
 		l2cap_chan_unlock(pchan);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index cf590a67d364..295c79cf5cf3 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1497,6 +1497,7 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
 static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 {
 	struct sock *sk, *parent = chan->data;
+	struct l2cap_chan *child_chan;
 
 	if (!parent)
 		return NULL;
@@ -1523,9 +1524,19 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 
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
index 1739c1989dbd..9796c3030434 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3231,6 +3231,11 @@ static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *pchan)
 
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

