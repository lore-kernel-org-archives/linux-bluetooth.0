Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795641137;
	b=v9QZpeuoy/WMAjW3NuLNDCcwBGSRyaqZsDCiHrxsSFR4sLRZXQwPKkwCAwAJUoGWg2mM
	 Gy/JbPhL22Amx53TFsd3rRPKN621u7hL9vsq7jCHN6jvE9HCdpKWH0vdnXP4mJugrDHR9
	 xZKjjdq9cJej/zjNoEMD+fwLfyvhv+T6RP5xLhCcsWQIydtC5EcF8A/PYT4u1PmEiIHXa
	 yT6rsyeBiwEryyaWlDKIe0IxBGL3xo1rOoUyQoeCazzKs+0E7aauMOyMbCDFpgbiXYife
	 azybAFdkuZfdCmylwMuWnXYYiStAvF/FZbEKb2P9YCTeayAoS2DtQIcJqQ8FOPlerEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795641137;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AE6hA4MazPlaWh2P3yCkzbOiLlc/5hzyt0IYFYI9OLc=;
	b=xVE/rSZTHpEL5nOHvLDOESvs0O0K3Ol+Sra4CoWkIdDXP3LvnL5fYQWlWEJYXC+1TZTz
	 nz8XnHo6xx5rp0OHF3ysB8Ll1BW+4VZEzcvXcbEA5h5TGsI2inOZG4XsyMvRKQm9A/nrM
	 Iwaz2UICcdgncHR9WQo0t5D+FVhwhFUb1qG3rs+J4my69CIH3lzDY/5xMjGFuGGTtg7+z
	 QZQqdiApDoIwgmJG+uRzhye2ESgejpVmGyRlSJra/22rNbRDvV1rR1K8T2o83E2674+i3
	 iEXypt6zSO0UJVVrmPfmVnTvVE5kY7u5dVCi4NHcDuJyKYXihO30JojcNmlG6dw8srw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tkGTLvuP;
	arc=none smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3C7606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 21:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF3C7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tkGTLvuP
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5ee2ad94713so3997401e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 13:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795641136; x=1796245936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AE6hA4MazPlaWh2P3yCkzbOiLlc/5hzyt0IYFYI9OLc=;
        b=tkGTLvuPrVdMTmGZ3c389FyNpw+65Aaiwrx+o7zz/XIZmIQQTckXTKqzbY56KEdbxT
         QcUysJ5QbQq8DnZ2BfHE9D35a6o/Lz1e+JL+hCTAoJCA08AecJFP2d73eyrPp2Hi13cg
         L/kJILwZkGUTFJu3B6hCIfgmfKVuuiCFcNUWnbo61r1ZqFbf3QUkgtgWjh73tKLFStib
         N2D4FkFGMz2g2djjuxkvVlIBHQAjRduB4X8qh350b4DJrQUOVQHvLJATvMDkNQq+upny
         YHDtADplJ9tyUXjZaNoUaKWXhAVjz/5D9Hj9wJJNoVea+LSZkHqBRyOpnawqnxK89uIe
         WaqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795641136; x=1796245936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AE6hA4MazPlaWh2P3yCkzbOiLlc/5hzyt0IYFYI9OLc=;
        b=vuaJ9Ob91+JJlgAA7kkxWCw5lDccXt9/tTuZBM7jTSEU9GMIAKxKgOMzZ47REsmPXu
         eZjTRw9brAy7jvVF58B8jinBgNnBPG/8gV3xI8H8OAhurHaJvqhkp8XTm3nEtKjO4aVd
         pzVh16dqVPW6Yp5k4U/sXMMf0CUI+/1SpsX0wTa25pHf49to2DSC1MSM8706kIDVW4dA
         VsgwKVmxqiFMHMooI2/9UX1SglNISjjMiX+UTB+oYhOvkOutZyUpQwlzoUAWZTN0LRDa
         zS4VSMdX4HkX0FP+fpJfLXDEGkVpU6uZ8dwqKPEggTrRHX2nA89dafhyxR1gls20+pjB
         Ulqw==
X-Gm-Message-State: APuU4Z9qDcQz9VAE/AeiwGP0Qvar64+f+LVa6H06uOyJ7KUPOwkzHptm
	h6nqGJkA9kQFl2D0A2aUjaoiWNowSh/ZZS4yjQYiW6Gc4/bXe7puAY6l0iGRGA==
X-Gm-Gg: AZFdTZeNN2+PvukVs9YRfKxaj6p/phKabtEKdkVTa+obpXmKw46CMoGCEnWM4U+L3p5
	0ym+jgDv/cVN/SbEytJXI5+E6AnHHC3WYBXcYZm18YxeaRiEEqMsG99/bGb6qXOjqkTIeayfJOI
	z3xQqfu9K7b5qKGoH0FLzkFB2U0/NidF/Np2o7EVYMw3tAUuwPoQXXD0ynrfdSoyKZWCDofU5UI
	udQCdvDmqLZ9ox8CX/v6CTI6aImdhz/CFPWkXKgoH1d5lJzndKTRQL86Aye8My3QQ1BtPKjBJ4Z
	bvFvsVunVAvE3u/gYK9/Bx4yRnCxij+5YOPX3iDQbKIaahf+uJwI2LvbgEboME4qQxcrP0BLNUb
	+9YPW2Hj2fPz3Tb7U1LkmGoekIfY3gcMXgGH8jhDT84qc26KpHmvvnrT/4cT3rYeGjY5C2nGYRa
	+hq8qqzCs7h6S9joLs30OpPx/tColSCUGpOgQW6Ah3z/AqIdImRbYkpfx7isTPsCauzZX2/UrEZ
	Eme0YnM7eMOdr8r1Wu/GatrUYpskfWRDHRYMV5DTeFUpGooX06s5AsW5d949yg9iVAFc4Axui3M
	UKhQVW5BJ9g8/ycCCbUnwqzOr0+QkjMrkMGPJhkXit0ElVW5LpPauYMp9ZYyhZbm3TYWh5UrpbQ
	CgA1ljFu3jLcJHxHbCxAbutapu3foPs38tLH4Dwc9/XScN0L4hz8Mqo/Q4Gla8oChFZD6iFEXyX
	ToHUM=
X-Received: by 2002:a05:6122:32c8:b0:5eb:7686:48f5 with SMTP id 71dfb90a1353d-5ee8af0af4bmr11515367e0c.8.1795641135824;
        Wed, 25 Nov 2026 13:12:15 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b556db7sm18316369e0c.4.2026.11.25.13.12.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 13:12:15 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 4/4] Bluetooth: L2CAP: Don't offer deferred channels before security is met
Date: Wed, 25 Nov 2026 16:12:10 -0500
Message-ID: <20261125211210.1955598-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125211210.1955598-1-luiz.dentz@gmail.com>
References: <20261125211210.1955598-1-luiz.dentz@gmail.com>
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
index a6916e01d1b6..77520c7b908a 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1840,7 +1840,13 @@ static void l2cap_sock_state_change_cb(struct l2cap_chan *chan, int state,
 
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
@@ -1908,6 +1914,8 @@ static void l2cap_sock_defer_cb(struct l2cap_chan *chan)
 
 	lock_sock(sk);
 
+	sk->sk_state = BT_CONNECT2;
+
 	parent = bt_sk(sk)->parent;
 	if (parent)
 		parent->sk_data_ready(parent);
-- 
2.56.0

