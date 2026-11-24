Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795553430;
	b=X2DbUnyPNUkZKVrsrx8PNPq1M75L7D79ZEI/AqrV1AgWoMxeixQWwhdlVorTZ//8ALo9
	 QkwgtYnpErI4x4fl2SXHvRK8IlGu2Uegv6oXU/X5Lf5oypIXe3w83GVM+d5UqsfQ5fX4s
	 XhXn3qwYjIxa9BXjS0DRgN2h0U1HjXYPIwqtdO+ioPpw4RKDu3JWkXG273Vxt0jsOpwEe
	 3JLdc9fWZ/kPd4UtLu2TVMVgeipw7J7eUXZjyGgZ785Awp/yvngBKvVA+9b4PefujSYLo
	 WFFiTtGie3QtYaGrvmTQX+ivqbeRQuw3EU9PBwVw7a0a5WP2y/Qj5d4x6aIds0J43vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795553430;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Xh0NYCmg7UZkXOyH2mnhTkKOlvnecQbCf1jrDQ1tDDQ=;
	b=P67KpeZ3uLRlFYP50IMBg85XtWtz/BeJk1RuIgpEnUSLD8P4WDPL6TE+9NoQiKl2muF+
	 T/BtkhcS4yTajAYkx03R3c7kK9z7JovYTnD6l9GX7vsheztJ+xb4UyJY5Lj3l8a0uo0uP
	 CgtYBxLgtVSJhKN3oQIWqUP8vnjTWCtB1sarBKCgmFhkEjcPOmi4Hur43ePU283oghm3I
	 JhqzL88YSjQW+hih5BbQ00QgH0xV9EI3OOw4HNuDYnKMgIjayzDy7bvfh/IX0mP4V6x0f
	 Hd0DHAzVrNuK40N6smvIggkjNR1N8FRDVGE+WNihGWn1Fyjw7EAbpFxnZcDkbIxcNBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AnMRjLNR;
	arc=none smtp.remote-ip=209.85.222.47
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32097606A326
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 20:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32097606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AnMRjLNR
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-97ca72f2cd9so2722305241.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 12:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795553429; x=1796158229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Xh0NYCmg7UZkXOyH2mnhTkKOlvnecQbCf1jrDQ1tDDQ=;
        b=AnMRjLNRxBx5YTkJaI6Bn0Zi++6Eb4/pmAOp8ojFPZj6m08clycXyg8xzcmhMHnzio
         r8rRWD2CxXqILJTU+4J9g1SyYf3+srDOCMf2lu02ok7ABk/B/7yrK6CjufSOwFCeO9+P
         /lH6zJjb/ARuhCUA/qYoB4AP3glgsuLN2+mdxgAUDn7CCoc5qo84NbRhfdD5zP+YZOEN
         9KCFQk0EMKqAxWCqxxwrNx8OFLftOhzs7kK79EGZm/BA2yhcHGLsJNwyFbB//HezX14y
         6SE7/qesQfmWhqQ1e68JCsq+OaWUpfFeTOSHjV+bzTjzSjX12n/6mjunBFsazlXSooyp
         gsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795553429; x=1796158229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Xh0NYCmg7UZkXOyH2mnhTkKOlvnecQbCf1jrDQ1tDDQ=;
        b=qIa755sZmDr/4aIiBOkpaWBda9E78vLpJpodmJsl1NSkNa3voMSvg79s12djCXCYsE
         wCC9baX57cSE0JODj6Fcc/Bc54yBdXSHiVdrw5379peWcb2Wr4TBY3qp3lh6I4IsMccy
         D2l/LBBmPM4tARBSOlGd5+JVBGhZtzowVuv+KT/CSamHmLeSgE28Xa7zFZ251BB+onot
         fUJ4CRY1vXlXwOetZBwLKIR9oA4eXnB4ljWURN+Zc8nwksaQX1o3kHK2zW4rig1BMIbY
         IHgF+Pcd/Frie100mF+6tRA/2YrEVLCBsXX3JlUVTY88RS26SKEO/yecyxNBCVgZA8Mf
         sF9A==
X-Gm-Message-State: APuU4Z8xGta4+a+40Sf30yLoE9BNFvzuE4J1xJAgIvFQaCv5CB1anymI
	9yDTFv+KcKiHowHMzOyydiSk9P4oOCnqSzrX+Clcu20dELnQOhQR3HgTAGYZ9A==
X-Gm-Gg: AZFdTZcMW30632mj6IpKPKkkTO9G4PROdDoN7sNjTV653Hn50Ig+88g62IM1L/h11yk
	ThvnrwYJH9Fh5oA2TkVGNeYbOd/wlFb5ow7Fz7cyi2YxG9dA9E0Lj3rvpe4Cw85Xc5ky7OjgRXU
	oyGwSo60qFvEgsd1bG5Yce2lpJOqBnfkv9c2+Fl/Ri93tnHzgWNaIDawdiwLpBvp2b7cAEXYhSw
	pKoKFALIt8J2ZXaRGOq5PQN9RKpl/342DmYcyhK2G1F1W9ZEUsM8LT41HxT/i8YmwbRIQYKFZXO
	ePUy/QXHNqfNJW7YNXmWBUu24CTk5w+I0zqKaSMKiLxo/Qc84z8QlXKOfIaj5RI5B+xOl1uGLae
	kZj2HuJTo5kGZ4SPoT0Hd1yqoDV3xN5pTq5Syq2S0stfU1v4vIldrbJPLWb0Eg1d7zKM1SyWAhB
	U+TL9LSGm6+SfNLhBRiHlD5Sx4BNSgJ5rnzeykgZp58v8zrDYh7fE+pUp9hxTA+Gfdh87rxDPY2
	STHCl9DbkO3xjjw2h/4Pv/tdsyPoxaoflrV8tEgw3z4jT5IE854QvSOyRXDoQPoAzWkFNbXDD+p
	c+0TY46Jqs3ctDiVLN3CVeFpNBbl5BUWpEwj+Fesz/R64OGgmBQf2VTe9W/LOwnH4lMB8rldQz+
	6q2dYiceXvCEvJrWH3TRAJYGoPjxdLydwy1Cr4i4eQLs//pwUZ4emrwEGBI+9sPEp2K/JBOdpq/
	vodlM=
X-Received: by 2002:a05:6102:1627:b0:7d2:8529:6892 with SMTP id ada2fe7eead31-7d739390113mr8670740137.11.1795553429146;
        Tue, 24 Nov 2026 12:50:29 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e80cb440sm16308884137.7.2026.11.24.12.50.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 12:50:28 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 2/2] Bluetooth: L2CAP: Don't offer deferred channels before security is met
Date: Tue, 24 Nov 2026 15:50:25 -0500
Message-ID: <20261124205025.736808-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124205025.736808-1-luiz.dentz@gmail.com>
References: <20261124205025.736808-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

A BR/EDR channel is moved to BT_CONNECT2 as soon as the connection
request is answered as pending, no matter if it is waiting for the
information exchange, for the link security or for userspace to
authorize it, and the socket state follows the channel state.

bt_accept_poll() assumes that a child in BT_CONNECT2 of a listener
using BT_DEFER_SETUP is waiting to be authorized, and
bt_accept_dequeue() returns any child of such a listener, so although
the listener is only notified once the security is met, a listener
that doesn't wait for it can accept() the child and then authorize it
with recvmsg() while authentication is still pending.
l2cap_sock_defer() then moves the channel to BT_CONFIG and responds
with L2CAP_CR_SUCCESS, and if authentication fails afterwards the
channel is left open since l2cap_security_cfm() doesn't close channels
in BT_CONFIG.

Fix this by only moving the socket to BT_CONNECT2 when the channel is
offered to the listener with l2cap_sock_defer_cb(), which is only
called once the security is met, and by only letting accept() return a
child of a listener using BT_DEFER_SETUP once it is in BT_CONNECT2, as
bt_accept_poll() does. The child stays in the accept queue so the
backlog limit and the cleanup done when the listener is closed are not
affected.

Fixes: f66dc81f44d9 ("Bluetooth: Add support for deferring L2CAP connection setup")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/af_bluetooth.c |  6 +++++-
 net/bluetooth/l2cap_sock.c   | 10 +++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 7758e9ea3848..103d61d13fbf 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -330,8 +330,12 @@ struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
 			continue;
 		}
 
+		/* With deferred setup only a child in BT_CONNECT2 has been
+		 * offered to the listener, see bt_accept_poll().
+		 */
 		if (sk->sk_state == BT_CONNECTED || !newsock ||
-		    test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags)) {
+		    (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags) &&
+		     sk->sk_state == BT_CONNECT2)) {
 			bt_accept_unlink(sk);
 			if (newsock)
 				sock_graft(sk, newsock);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index d5663a4642a9..57ada00f76eb 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1812,7 +1812,13 @@ static void l2cap_sock_state_change_cb(struct l2cap_chan *chan, int state,
 
 	lock_sock(sk);
 
-	sk->sk_state = state;
+	/* BT_CONNECT2 also covers a channel still waiting for the information
+	 * exchange or link security. Only l2cap_sock_defer_cb() moves the
+	 * socket to BT_CONNECT2, once the channel can be offered to the
+	 * listener.
+	 */
+	if (state != BT_CONNECT2)
+		sk->sk_state = state;
 
 	if (err)
 		sk->sk_err = err;
@@ -1880,6 +1886,8 @@ static void l2cap_sock_defer_cb(struct l2cap_chan *chan)
 
 	lock_sock(sk);
 
+	sk->sk_state = BT_CONNECT2;
+
 	parent = bt_sk(sk)->parent;
 	if (parent)
 		parent->sk_data_ready(parent);
-- 
2.56.0

