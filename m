Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956603D6463
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778519365; cv=none; b=XIIH8+DrqqYldhvUypkA3tRgm6v2kUdchnetDZw5bGkttdjwI05t/E839OiTz7wRU1TlOUsbbMjEnCSSVvhIl6Wk9mrzSAZRQdRqcAxRTFU1/pZKmNucROJSnyHOli6C6ni47rii7MB8XjykwBgYvMrH+ZKMGqG9qOm50Qoea5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778519365; c=relaxed/simple;
	bh=wOh6yzk2qnTtkhSS9+xEkB/ImPcZ6XdXQQKd/oRBmkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwFtHBUvhFF6X9DrRWpr7iJ971vfqRZ/REtnNBIwE5LII9/3FqHuHmxcycrx8QsoyBgVGZuq8kQJPkVV3HPt3NzPKB1NsRPi2iJc9YczBw9HmNI8zeohqDDbWmprLvsPP/XJtq8m+EUO6kHz4OyHMV8YIzWRHxPAVUkN4tDf8NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=fGSOwtzD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M1TQQJVQ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="fGSOwtzD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M1TQQJVQ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A6749EC038A;
	Mon, 11 May 2026 13:09:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 11 May 2026 13:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1778519362; x=
	1778605762; bh=arD6BGn2YZcHxCYZIbO2qRn2lMx74FTf/6fjEmV3r90=; b=f
	GSOwtzD0w/kxzKcLLlMsBwW9W5dnU10GfzFt2aRinQZo5l43p86bql318ZA1HobO
	ZA/q81SBkZYHZngDlOTWe594/l8L/6Gqf6leMHoHNq5PyLRB8jRxad+a9f+nefw6
	9Xphv3PZLGM4HG7iBos/5NtxNT97QYTKIjjrCskbv8yo3oWdHOFRBBmPmLU1RndR
	Q44bLFo8Eubud9RHL1aKESsX1gKB+zeokkME3uLHPhgxcaYc/G7XL3LspifINy6V
	c6/itvA4cZcEXRLrIDeo0uT+nz+xXj1rNxr0SUgQvJVsFCnqjYv4WzRvFZ7qSu4R
	3/mTp5rSiZIiprHTSHXNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1778519362; x=1778605762; bh=a
	rD6BGn2YZcHxCYZIbO2qRn2lMx74FTf/6fjEmV3r90=; b=M1TQQJVQHBz3GXwGb
	BEJFLMVv4rCMsCy+CZu/OjPSVfW0sGZnX0O4tZz/nZRv6kzssTw8kFN8DdQqyaR+
	N/9mdxz8gDpcj/GsxsELF4Puj0mg8yJFEfIW3Sg2FKvPp87DXNutetOk5Z7BFJMs
	hIsrcgvpWjkwzgCUYy1Mk1kh0ZgG6QRIZ0N5fLVJ9Xk+ZRSrxssJp2ON16I000h5
	HyGaRm68bab1t6IL7eh+59ZEpKOQw2thHdivCAxnELteVZfUVWWTxONWm22Jnjdg
	C1dTZLAgqOOWXiTsnuW4D3h9G5+Ov7PpF0YC/s+s4q6kPP07B/YNv7aiTX0tOo7I
	wgnCw==
X-ME-Sender: <xms:Qg0CamENW40GxPQaTduIGljCM6XeWHhc4hnuYCxkc6bMD8XXjLvTzQ>
    <xme:Qg0CauWYZNQwUQLsBtIvwuXjsM_M6_AB6DLPBq25i3ec483Ff0RsfTmwH-B0dZlnn
    vobEGcDLfCAskFHqJGJSg7OQAnr2KUPg4bsgQ_ttWpL4hn5i5KU>
X-ME-Received: <xmr:Qg0CalLlOMdsKDd43SIHxQ53lfipfvj1jd6TY63BOfTxd7qStz-qtCZd48WEaBbTANo8_Uc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudelgeelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Qg0Cau9d-U1cVCovgsK3_FmvZ3oiZ9LK_yAdbgtQjXYdzsPi9c50AA>
    <xmx:Qg0CaoLuJsU_YbWWXXKcnH65dZgUG0XsUnWGXhMXSNnP7Uq5sNBBhw>
    <xmx:Qg0CajmnStaPgwjRNDnTlSGxY_m-M-Use5KddxTf_55YUIaYlqDKDg>
    <xmx:Qg0CasN8fW7O5TZ7-cQRjJwJYbhueZomY3eXhusHAHoJ_KtFvRXs5A>
    <xmx:Qg0Can7x1FR5zWbNRPMVYyzYF19hJiB2lwF1-mSbae0Izo5plyQVSsZW>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 13:09:22 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH RESEND v4 1/1] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
Date: Mon, 11 May 2026 13:09:18 -0400
Message-ID: <20260511170929.709823-2-oss@fourdim.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511170929.709823-1-oss@fourdim.xyz>
References: <20260511170929.709823-1-oss@fourdim.xyz>
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

