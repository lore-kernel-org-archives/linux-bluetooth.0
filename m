Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795126571;
	b=alpbmbJpIa1s9XajmOd19dkqg1ZmkADx9dir8nxVnqRQoPaoZ00izTu5TRdP8P49oWF0
	 +VlMhqQkm3RPkT3TjUrqPc8Skyfh0RE5BB/3jrHpGZvm0hYN2XX040O8MLZLJMzHUBhtb
	 lH2hWK3eRvz6udy/+HgHLV+SwD99OgPy2xak3LnYx89PzEI1ji2gSb3bkfE1sfOwLv9IJ
	 O5ntLVMpizJDhV/gMROlCoR43elfJCEkExG1/euR1znOeoQtYV2JoheA8QzZ+VTQR21Bo
	 JUuu5VsrlfV6ZZ/ysb0yMjNGVDf7L87Via76GYs2J1mvZveijbAUOFhR/V8ofIU1ryg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795126571;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LBgjvsgfC/v9OEIEH88v+AaX6WXgc8yE2z5xTPh6D0A=;
	b=W8COxEOZKH/dH+FFWI1BWePDeVvXXbtFH+uqXj7FLMjZC/V/aykH3momxV3YnE2rjUXk
	 t5lFNG9AN96ZmG+DTJK/+NIduh39Sv41lt4MK78jPk484XTBscnH/gPs/PSx4J1WA9O7a
	 0Mlgce5Y4dOKMkHuPMGkN8iGm3Y4po1EVMDxRKtDG7siGGkDMghMkSnB4q/xUUS/2PrB+
	 lx50vlBtMjfdCKDV3KrREajoJps0YDNsdjbWaII3XrPc2ikmPFd5gyImcj0+zW03MYWVI
	 pankfMVcYsj3tGpG+k8HDX8gxZVV7crXyq84ZXmi1+PuopcM0meXEkeFfhW8xYmpUJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dSyNHDN9;
	arc=none smtp.remote-ip=209.85.222.46
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A008606A338
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 22:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A008606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dSyNHDN9
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-97ca72f2cd9so176240241.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 14:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795126570; x=1795731370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LBgjvsgfC/v9OEIEH88v+AaX6WXgc8yE2z5xTPh6D0A=;
        b=dSyNHDN9kNqJ8an+YJO0hD8eAWSvvtHCbzYUcqIpgn33Dey9i4tHk6gC28t3MDkokF
         V5GXNg7ZMNjz1XKH8H4ZieUw2fADypq5CEcLXKmfdtDOA+9qo5UILY399uGLn3RP/ekO
         uIuXJPsTYy5T9mSF2zhQ3et9ebnMwU2stdBYSgT9NPGJsJ4Fenm5T+F+FpmrOWyvyM7b
         WeGXAF3hgQB2zH1xSCaFrPkGww2mz8S2mnKkx42v5yPcLgil11yGCZ1XGGQrF9p1HeJw
         zxj7gFARDHZn5zWPfL7Ln5fHlfBRtDi1/3MEL/uWWgRX+eKSwW35cmqf2rawOOmoOqWx
         05qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795126570; x=1795731370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LBgjvsgfC/v9OEIEH88v+AaX6WXgc8yE2z5xTPh6D0A=;
        b=DbuEdpivaFAa/drd+jtSoNPQbf+120A7hDt2OLzZ9oucKLvneCgf5259UboI/Ii/8Y
         3PU7TPuwRLztxfnVW6+ZRVBVOI61RAZxywstDOeyJETzPf7K1hTK0gtXFb63Swn0sJK9
         WJc6JTq/E8QCN4LrT3czuR+gN1Zw4NO3kf11/TK/WncCPZTm8U8EwT9MbKIfbdfjFl8V
         E3R+JG5158yJGVkdYw+ggAFnclANYRtJ1p3rppKjM9Z5jpJGJsekiH3TUBoUZu+1MtQf
         9nAOVkzOUjSTJK4fXg++mIGG5aaHf9FgLkOHZo5Wrq5Y0IYrSQNnLCOZKV5dg8ytAg+O
         hj1g==
X-Gm-Message-State: APuU4Z8qjuYyNFMIvpIgCzYzmDzBZpnDb8DBGdEvXjAbzqR5FwcSeC74
	651LBabhCkL1vF7JtI9diBi+ED6Zowx3JeKB4Xu+zMtCboAszbA+fZofnecrHZCq
X-Gm-Gg: AYBFou3YWyM7sqfFuWjZNsJSDCtuuX3gOArACwnjFDD/u9LAteC/Rz1QvkzFztmlelC
	x3xeZEoKwmLUgSKtZ8aLILApRiSaKWt42fClwSBbdoJtqLsDiZIvP4A7v+50KC1YS9E4yUzvd5N
	IprUlRn97KrcYv3sHWgRiKn2Xs4G6bu6jD902a/gyrOeGlcHnDs7NAi+M1vxbYjEYztZgzSaqaC
	0tE31lSeRhp5LR62xYAg34KNDhULOJRhVUcxhSNSJLCeIVfmvEGQd1zWRG35mv9LOVLbmiYFBaP
	VWDezzn4fOn6sCjcIlFR9umbeVcFsCA5t8uTpt4Gma8057/ybQZwDGxQ2j+NCaIXs8p9bRTttxY
	Pq5gBI79+UKfeFjsmdqVB2QisQZSZ0g+oPQrgWWSXIHDG8xMjT8IIaT5Nw63x7H+2/6PDWN7nKH
	oxgKA+rwcgVWnfWWVG5lgMGOMNvMjs+SpmXPmBiSoYN9zWwbheqJkX+bOt1ntWGKwJKrmeM5QVQ
	oah3xlD2A1CSZkYUbKMdcfFCld42yUtwjb73qIg1y4ec290md2LcBqaE6fzROiGuK3AhZs0pljV
	Xu489/col+mnq+z+ANTQwHDO3xKgptrXHes1fJY4TPyMV4B0d5I2vA3uFthsPLmogn88Fv9Navs
	Qlq0kQu65dJWtGBLabzJT0Sc4pxmy1ZVsKm07h+gwF1+yhLBZVEGSTXfPqqkgJJ2rrlkKE58H8W
	NcjU9mZFQgvw3yEZY9d53Opx38
X-Received: by 2002:a05:6102:f07:b0:7d0:6cf3:d8f3 with SMTP id ada2fe7eead31-7d739444d6cmr495016137.18.1795126570406;
        Thu, 19 Nov 2026 14:16:10 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e7f92680sm1135355137.5.2026.11.19.14.16.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 14:16:10 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: L2CAP: Don't offer deferred channels before security is met
Date: Thu, 19 Nov 2026 17:16:07 -0500
Message-ID: <20261119221607.1311815-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119221607.1311815-1-luiz.dentz@gmail.com>
References: <20261119221607.1311815-1-luiz.dentz@gmail.com>
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

bt_accept_poll() and bt_accept_dequeue() assume that a child in
BT_CONNECT2 of a listener using BT_DEFER_SETUP is waiting to be
authorized, so although the listener is only notified once the security
is met, a listener that doesn't wait for it can accept() the child and
then authorize it with recvmsg() while authentication is still pending.
l2cap_sock_defer() then moves the channel to BT_CONFIG and responds with
L2CAP_CR_SUCCESS, and if authentication fails afterwards the channel is
left open since l2cap_security_cfm() doesn't close channels in
BT_CONFIG.

Fix this by only moving the socket to BT_CONNECT2 when the channel is
offered to the listener with l2cap_sock_defer_cb(), which is only called
once the security is met, and by not letting accept() return a child of
a listener using BT_DEFER_SETUP while it is still in BT_OPEN. The child
stays in the accept queue so the backlog limit and the cleanup done when
the listener is closed are not affected.

Fixes: f66dc81f44d9 ("Bluetooth: Add support for deferring L2CAP connection setup")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v2: New patch.
---
 net/bluetooth/af_bluetooth.c |  6 +++++-
 net/bluetooth/l2cap_sock.c   | 10 +++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 7758e9ea3848..81f4ee0223cc 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -330,8 +330,12 @@ struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
 			continue;
 		}
 
+		/* With deferred setup a child still in BT_OPEN has not been
+		 * offered to the listener yet.
+		 */
 		if (sk->sk_state == BT_CONNECTED || !newsock ||
-		    test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags)) {
+		    (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags) &&
+		     sk->sk_state != BT_OPEN)) {
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

