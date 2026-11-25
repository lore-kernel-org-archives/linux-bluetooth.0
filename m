Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795633143;
	b=GD9dP6UnkpCFzFjoBJGB14RKzGAYc9zRkEpNIukygDILalK1T1PcOFU5Ie/nW9OSqvih
	 mTJgdc+XvG52NrL/7rcKj5dJuhPLm+KsJnpSUHZYhJ16P6vDUNxrSzNRK5DXFw+MnyUZK
	 kWMY6UrHyaituEO/HLXX/rLuJ4hM6dicO/EoX5axViGkaB6i/IKsll17/wEXfoRuZCfjg
	 jeG3pL8RfvkJB5SmhW9i0kZv2nyfW5UIWvJddFRv0BG9OL89ph5hrjWhrMTkPEMdIloV2
	 m56w9ztjNqwC0nkgDNXdh8kU/rv0LQDF3yZUX5wc1PvkTt9vTmOWCOnHIePQ7LT6QSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633143;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xXW+IHbFcDM/TQtb/O9viMYbhoj9kemYLdCNTfW1Y00=;
	b=JVh+1El9FtI4nzBIp6ERMyFluvkVH+XXEmFS0i6aV4xtIk9k84pJEMMV0YPSIr2XB14e
	 2bKUldqzo/O4z7eZOBzamtHWVymSK1XnO0HgJaleNgBpPCaT93c65C5ZR+d1qKGZSsJgj
	 vu8eHHZA/lmIj0sHh2T5ciWJZuLEA70r/aEzoI3ebZzsZxvcllwETw3zbqOnCdC5PR5mQ
	 5mBnPqWVHD1tQApoCK8pXqoWJfEkVOprFMn4yYp34GPKo3WcjDqHA5PsCkpPoqzqCPjhE
	 EAPY5VZel5htQyEtgmFYa7/1EKsJlldT8AlGfEAX5lG0RKiCeyjJD7Tshxwq5LimQiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="L/CLCBa1";
	arc=none smtp.remote-ip=209.85.222.42
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5245A606A326
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 18:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5245A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L/CLCBa1
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-99e145569c6so1426434241.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 10:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795633142; x=1796237942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xXW+IHbFcDM/TQtb/O9viMYbhoj9kemYLdCNTfW1Y00=;
        b=L/CLCBa1RV9OvoaK6HLDTkQVyMHbkATsmz43ER4nEe7mB7rxdohH4egsIou2n15Nev
         EkNLxF83n6fHbDVU7PxcLhKJQGLaAw5Z9EMBRQrlx22q4IBMxKnVKxbVr5CMv0THeiE3
         PnXQKu0Kx6ADUCBeiZBv4gFDByOAoUe0gM5EQB8eJF+HT2RXR8jgjeFjm+umYL9qFAAV
         bVOaNUL9aKfrtXfqdfSiskImp2JsKz++C+PI3mTkplHUsORjHtyRKJFD0GXz2BAWCuoI
         ad72uttiJ3tQ/VfYAlgb2Mh5yYFwKj3sCIZ6fjj+KQ5mANZEuGqUN5XzCmv89v2CA1JZ
         iAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795633142; x=1796237942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xXW+IHbFcDM/TQtb/O9viMYbhoj9kemYLdCNTfW1Y00=;
        b=EgZZEmEJrp+lQiRGZG2pe3zXqYRGWgJqIiO589XZ/E27NP+m6g+Ga3XYaZXbjMMZ3b
         u1l1tRczy3jddlf2L/JIQ2XT4zCvwGQiL7I6XCMvSfNLz/3XVNQU268+1UNW/QKV0Eqj
         3k7LQnSubcD0f25F4B65UykmoMqlG86Rh7Lf5l/lJnVjYjJAEsiZftTvvP6TnB7Ffz6Q
         MIpymgo+bOfxpfS83SxvBYO3EMc5PpfsOGVcV7ESQZuR/UkYubm3hQL+M8txkjiwXtup
         WMhsJx83m8Hm4+swLIWnlcNt9L6LH0aUCSrwMtQU9dsEVsUx+JQ8aldxYGyU/d7T4okt
         40xw==
X-Gm-Message-State: APuU4Z/Aa6mwgs3hJYFAfaGD8rFT4IUelzzyuYpaxd2K8H2tPFUopzpb
	B4e9jJ9A3K4h2ickflHcUvAltPrgYKQ4jPJRh3w8GgfhRxH2WE7nwl7ClZcpcg==
X-Gm-Gg: AZFdTZdF4uvLD1+kCOxFH6+dOk2Wi0YbO/CJcJZgM9j1Ql93vUDeNp5+fWYeE3jLENM
	4f4kGMfOyrn0/LEZSQ0sdNZmQKK//gNRGC5yt0qc8yHZqio9WjA9MnrJoojAbRsjBxf7fjMKvqv
	qJtZeiXCdtV7Szi8PXX8u4fpz5HnjFSExv2OdncuMW/i0IBp7YPs6J5iLtIM04PnAgCqnWTWYxA
	GNALt6ra7jIez0rN9YjWglvIlVO19S94ZMrJHD5O+x9Nk0KQliLnP9dPTCcfc9QD+eVHiCPZURS
	Z710O5VEoJXtXY0kzIRjW4oGYnXuDsyEvLexTM8UnQdHmOn6wRCONmYF78eVsq/GEdgruiKcB8X
	pqssyJiRZRhVtpzhiAcx9OAHCoj3/hHzhOdYmmRDuCHDN8yebkqRqlk0Weaj/6ud6Xp3DoKlZt1
	Je1mT2fzwUr6qtTlmA2/KDE+a5NN+fgbmua+jyOC+TA0C3KkDem/IRy5R/CcTJi/kZ2syqdno6c
	jrdc3LkDiritd/VpIcXIp5sZRoKsWW7AP2okMWSZs5qxBoUU0p3wnD+jzbdQMQkjdnRpoo6PFJ3
	6LIQHQV0SjnFOTdbaiftIPLF7EHR+WCvwRrRqvQyw1har+R56tCO075o12atkjGS+aBb31HbSpP
	7gcBEOBhL4ksaaeniIYVhF4KdAZCgdGWuOH4IatdQBeFzFnoWUjez4joHLzBOs7qaX4nSiyCxtY
	gje2c=
X-Received: by 2002:a05:6122:1352:b0:5ec:e7e:27d6 with SMTP id 71dfb90a1353d-5ee8aeb4a3bmr10496559e0c.4.1795633142122;
        Wed, 25 Nov 2026 10:59:02 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee91a4e0cfsm16994459e0c.13.2026.11.25.10.59.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 10:59:01 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 2/2] Bluetooth: L2CAP: Don't offer deferred channels before security is met
Date: Wed, 25 Nov 2026 13:58:57 -0500
Message-ID: <20261125185857.1666852-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125185857.1666852-1-luiz.dentz@gmail.com>
References: <20261125185857.1666852-1-luiz.dentz@gmail.com>
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
index ea2f276484ab..3adc9dbf8263 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1832,7 +1832,13 @@ static void l2cap_sock_state_change_cb(struct l2cap_chan *chan, int state,
 
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
@@ -1900,6 +1906,8 @@ static void l2cap_sock_defer_cb(struct l2cap_chan *chan)
 
 	lock_sock(sk);
 
+	sk->sk_state = BT_CONNECT2;
+
 	parent = bt_sk(sk)->parent;
 	if (parent)
 		parent->sk_data_ready(parent);
-- 
2.56.0

