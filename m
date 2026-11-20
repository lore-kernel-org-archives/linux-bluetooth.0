Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795189701;
	b=owSeyqlh+mymVmj2t0siBTh1g9Pt0jehA+0Oe4EgqrazgOARDP1diTCWcNlAv4aS5Tt5
	 9oDEjEaftY4N+HO5XprIZtrenOjc1QbCkLGi4oR7Y8AWrSiLpIdqZelsks+q6bQs/9qqn
	 XpVfmGJVRfAMrMWSNIbmjFBqZlp3u38WwCUgzOyCGwWAJl2UV3PDGbxWB/RME8YNl4xaA
	 jpr9NFSqwLN4qu2mqSTfKR5EPaqJDsZFAeGgcFfWbxD2Iowl4pvo+sPLCe9ydEJ1miFgR
	 FLHOPhzn+43YQIz0pni68h+jM/4AwhgQW+rX/xAqQdsRDoR0If8PTveSKlXEknxvrlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189701;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0u6vAxCXwuIQM4WwNEYl7bkzWCDOZvHT+QIhOY4Zyk0=;
	b=CmkevzcitMtLkU+V/mn++ExNenJPL5jgEOO7aLgwNhoS0FrMzo+aL2N3ovWPiA1VsXsl
	 wJ/JtfMYIDZbEhwfeARYMozXuHBcc1g36eKhExYc0bxOIAm9sTyw+JH4AZWf+EcTa55jS
	 u28t1kcalwwEEoQZ4XdkvKQVbWHlTWWpk45EHY+812+KkxInLtE2Eu/nDbUtnyW7Iev/4
	 kbp+cC0wh3mdxNOO2So0bCY3WDtVt4kvFcjViMEti0pHNKgL/ORB/g8mfKGHgs5tOOVfe
	 dObqqXGWux1XVco4Yi1d9lo7pDYCSZ4YEwLiQeTGnrWRa8EtIG2PvwKflNQ2RwhWEAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U7TYZj+l;
	arc=none smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F3960A2608
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 15:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96F3960A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U7TYZj+l
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5eac6c5f927so400985e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 07:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795189700; x=1795794500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0u6vAxCXwuIQM4WwNEYl7bkzWCDOZvHT+QIhOY4Zyk0=;
        b=U7TYZj+l9vbF0JzacRyu2YbmpxeBbikZ0ADT2e0Gz5XRWidM5e0YFJf8Oq06/k3oJu
         Ux82q/JyE17Cwon/IHAlPh8lsDeW1KpX3+VaIaCArvSaV3mTbQ3H4Sd3FvbDCmsgCTQ3
         zL2Uh5wckP+cqZ1bmcGEnNUzeQ42qURtP1cGx9215kqxXGZf0i4C6UqXLRhEl+8qHoU4
         TpuVzFTC4n53wyZpBeJRcip5XGmAT48Xsmvrj4VyhtF858aPyP0xvDPFF4TALxqYY3aD
         A2Xfqfz1srzYlAgDKtNemSiHfcnuC5rmdJ0PrHmRdEHREHPE1g7DeU7PB6SLnBNtDtCS
         rvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795189700; x=1795794500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0u6vAxCXwuIQM4WwNEYl7bkzWCDOZvHT+QIhOY4Zyk0=;
        b=YzhL+fk3VnLzTkJpdS220CwxpnAzjyOeIeTOMqFuZRehTH9eoWs3/C32hYMctu9sKp
         idR/1t4RAlw8VhUUtN3qIMYMxV6FArMKpxA23wo+e2xgwsPRV9Vd+INEqDcupaDqDh6W
         xrj7pB5QleqQzoZ6s1whtZo0enzz3RLz9IMiN/xqmy4lqyfNwDe4Xh+t51KL2iGLQXd3
         RD5XisOCLsxgejZnnbYsiRWtROU9etc7+U59/NVQzDaFJ7hFwDnpqB0YeRhkVWbGZ6S6
         NP35BPhOQNRmkZNsIqdwx/dWVb7xQlKZQfslyTRGXgZzeysy1uxZ+zvBYPCx31l4krUV
         EMYQ==
X-Gm-Message-State: APuU4Z91++Qbfmn+aTTo/xjG05vE62Fii3oa2PZ138FUox+Cpe9RLGuR
	kuM/nG4wvPnHK57b/kJdVOe4EyKDjZgxlEZq8OPzQxg2hgRS4g1hrjJY2CqUAJQ8
X-Gm-Gg: AZFdTZdl+HL2NKzZP+fZBfBv2TH0NNeoLXBTPhqNGs0CLDFsHdde3xU9xNI5V2DE+NE
	sshf4llSnCPAG1mzTHMm4kJmT4scaZ5+hkbM6JLt2jYn9ugUDvsA5rNx7JerbkpDupRt+14gdHr
	DU0oUqX2OUhv9W8lT2dUsJjKZsm1Llc7tErepaGSety1ifSMgHVKwi1+62gAXoJS0MNz024uyAg
	z7a14IdYbQrApTolz3x/lorjtA+NILobwfbbmQVKaoK/3tn9lipQMhw7cYc5/RbiN4235Xk7Myc
	47qr5/4V9LxsOX4um5/dQZcD5SIVfhwTqJTjTGJTYmbqGOdfFTQBowyAGS6ofPxP/bmEGRMDJtw
	QeyPkhNw83xlpYtOEqwfwhLyMnSdZmc0PFBnulpAb7U7tBBw8oOAc17VvUo8dg7RLQfevOna6nU
	ikfX6XZJEJPD6k96otTvg+CBDF+2Z5WTdhWWF6+GFB0EgMYQGaaA96R4m6lKwXu8O43q2jvsuQK
	QGAvBAF1JVYh2963DNgoyrnQcAdQPDVHt0kqsTDCTIU31oek+IC6ppK8t7DZF0njprcXDhhrs4o
	rywVKdY1EDvNpqYEQxg8eZU+cZTmfw2Xgv2sHXNKLtMTnaEsFPn9CmVUNoXM4xMSV26zkafsFga
	1HsFx1pLKnK6bN8pVzQ4scg3f2YcHyKlBvviFNBhwFHSti/1CXUpJle2oCrYfqt7BJySs51F0dv
	ArS+Z2KMm3e3VaYu6ZJ6q4DT/m
X-Received: by 2002:a05:6123:10b:b0:5ea:c6c1:8dd4 with SMTP id 71dfb90a1353d-5ee8aea6de3mr1880901e0c.5.1795189700472;
        Fri, 20 Nov 2026 07:48:20 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b555137sm2830847e0c.3.2026.11.20.07.48.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:48:20 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/2] Bluetooth: L2CAP: Don't offer deferred channels before security is met
Date: Fri, 20 Nov 2026 10:48:16 -0500
Message-ID: <20261120154816.1745952-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120154816.1745952-1-luiz.dentz@gmail.com>
References: <20261120154816.1745952-1-luiz.dentz@gmail.com>
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
v3: Only let accept() return children in BT_CONNECT2, as
    bt_accept_poll() does, instead of only skipping the ones in
    BT_OPEN.
v2: New patch.
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

