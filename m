Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795037648;
	b=xWCJwBAvhxAcrlYA0qokP34rwO959Bx+vl16L3f3kmypuLPR+LmbsaF3HFXdbVO6xIl+
	 iACfK2gqUvotri6VqfKJBOdyRERywwSRaqygF4O837bDAVQeRphrZKZhLOV5YND4mxcHW
	 hFWK70QWKhH9GIui6bvT/DqsEftXYdP0qaE2WK8A23cjaT+YONbJfoW/eGyuleFWVoSRs
	 26BwTBQ9hLIrE5fZRSEIR2iFS9VjH9w517FyARubvzZI5ErShTO/iqrNpoV0PuADiIibS
	 LaevIRkwhNVpX/fBmI87CnObWDT4jgCbN8rwz9AFHzPsu92svoxWphPZ+MRmKAAJACw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795037648;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=7wkVVAr94vmiTO/mQBiU6goP09UpUl9nKX+foqCxc40=;
	b=ZwngipQw5qoZIJR+dij1rmoqvygKVq6oGO+bUIWdcev01tq8P+8CYU7XKkyFq9ingF9D
	 TQUexRel0hBHvwxSr2EbOAlcGMyWMJCH7pzkJYzq1mXljbBwaUrdloE4TLgTaLJQAlC+I
	 s6XhR9amU7IWYP5RsqQBB3yw7sXmcJ0Xb+WGDf0gxndRH2Crwz42FE9Lf2yxKyJrZjsvI
	 bE+3Zh5ZUfhVOdmnHPeAvNOnVvC4+9H9ZNVExjdhuwgo6/WOx1l6I+S25jONjlPznSinU
	 dDSvMaADJ+CUwNUO3z6E9NGFGz5agyQNO7S6VDTtEAiIsGSjNgIXeIM/GhYCMgzY0NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=odREYZc1;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13218606A32A
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 21:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13218606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=odREYZc1
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4a32576da88so850652f8f.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 13:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795037646; x=1795642446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7wkVVAr94vmiTO/mQBiU6goP09UpUl9nKX+foqCxc40=;
        b=odREYZc1/GbDh/eSmuR6NoDDRRevw5GoM+eP3X4LTbkbVZwjGOglEoprh/KYAjM2Ib
         xvMJWQjUWhLso90cQ/VeXPK/eznybWngj1FdSb4Seo0mDR/dpBsPzwIcBrD4Ca4Muh6M
         MnfdPQdtEmln31VcIRfu4kiDrqXnZfGzgap3H8o5rJ7HdvrvjvdsVH3uyzjVCK98sK9B
         Ot3wbzIgQ2gXiSs5lamvnnfvUjFmyzdOSS/OoYlGx2mzmh1EEevsM5PutNK3fwByc/Rb
         CJY8DxL4HsSUJ479ETk5I7yNqUFoQZM84zZ681XQN09VSKW10YqPsEuLt8DA35m32LY9
         3Eyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795037646; x=1795642446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7wkVVAr94vmiTO/mQBiU6goP09UpUl9nKX+foqCxc40=;
        b=XZS56m9sfIupZZqHTatVsl3nquW7J1EKoD1I7Yjx+QnF77TrDfeYDfJnOHyoNLJopl
         2mWonfR5r7gsPGXPTGVjIT0ScZLtxd9026lbWvavxQOivd0oBMN3Hy9xBixBQzT+XdHk
         V0zPphLQLXes2nGDESe/paiZsD+knWEe15L+ajHkhZopaHsSN3+o2jEO78A578Czc0QU
         5g5YDphP8TnM3g13DFSEU9exZQqQIcKTSpcqCzmpuyZLKP9G0qhfKitzSuJANC86ch3Y
         nSbE459ys+l54ZgGFYsKZ3SCUabIcju8I34UqqIxtIbZh8X0zbOx++W1+0botz2AduIr
         SwhA==
X-Gm-Message-State: APuU4Z9ls7rhDA115KNGT/zyfQKs339EEC/JSbEWRPGcbv6BenBnUf3Q
	WpHblmT3EcF8WmyhoMQSGgqrpxR7aGAy3Ig/8mFoPDE/QYqsIqJZacP2MkrlNoKA
X-Gm-Gg: AYBFou1zexYvtXbje099Y4VUs1PvuzfzdBIC1WuBAUgvQyALSxfTVi58y8W+jfPJxGr
	fv5de5aH4/4H/GuRWGrQicV3vXNVKPKJBhEM9mMncBrcvH3WQG4SIEFVv+ryY3h113LufNSRwjd
	UJe/zx8t1pNQ6Vm+965WgnYYL7wBX6z4vpbCaVNopKHZFbHEvng2u7blz8DAyZ7WwC8sTXUpE19
	4czOSg1VULpfR3pse7HMXQXcVtcZElY+mt+yDwfg9C1ZCKvRNIzQUTpipGvx4m/h3z48QL9JhTw
	gRmP+82C1Rh6MW1cNk0cEWvOMNCucQujE8uvsbiLmWTtXxcu+n/GhgGqbeb73HP+Fea0+4V2hFm
	ItyS5/EHGAIWiT2Qh4aRdh1GVA8fSiXwS3EKArH/BbA1Bqq1dDyQb6KoXZHKhZotFZL5IA3aLO8
	NN1hIY2Z1S30bybOzNNAQvAhmyaj4H7uACc5zWF3cRHeOtScIJ5DZ+it75dRHfO78HxnZAg0QU9
	RvNOMwqkXP2vRQZxupJDqxQeA35D1a9O1KBTBo1oVeeD4qHjX/GaZe8V5UQkn0oD1CbjnibbjvQ
	0F/Wq2nqgXDxST+05yuCveh6ufCFL7xoi6TNu6kq7+54eLOtYRDch9JTbTTiKjsQFnaRdLaGQ8o
	3797sOyA=
X-Received: by 2002:a05:600c:3ac5:b0:4b2:3c81:d1 with SMTP id 5b1f17b1804b1-4bb7da0f7e5mr78512745e9.5.1795037646220;
        Wed, 18 Nov 2026 13:34:06 -0800 (PST)
Received: from localhost.localdomain ([2001:16a2:c01c:327c:c4:b89d:8df9:7d38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb844ef1adsm527625e9.14.2026.11.18.13.34.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 13:34:05 -0800 (PST)
From: Mohammed Alquraini <mohammed.saad.alquraini@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org,
	Mohammed Alquraini <mohammed.saad.alquraini@gmail.com>
Subject: [PATCH] Bluetooth: L2CAP: check security before completing a deferred BR/EDR accept
Date: Thu, 19 Nov 2026 00:33:22 +0300
Message-ID: <20261118213322.60067-1-mohammed.saad.alquraini@gmail.com>
X-Mailer: git-send-email 2.50.1
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

A BR/EDR L2CAP service that listens with BT_DEFER_SETUP asks the kernel to
enforce its BT_SECURITY level and only decides which peer to admit. The
deferred-accept completion path does not honour that.

The child channel is placed on the parent's accept queue at CONN_REQ time and
is reported pollable (bt_accept_poll() returns EPOLLIN for a BT_CONNECT2 child
on a BT_DEFER_SETUP listener) before the link security procedure resolves.
When userspace recvmsg()s the deferred child in that window, l2cap_sock_defer()
moves the channel to BT_CONFIG and __l2cap_connect_rsp_defer() replies
L2CAP_CR_SUCCESS with no security check. If the security procedure then fails,
l2cap_security_cfm() has no branch that matches a failed result on a BT_CONFIG
channel, so the channel is never torn down: a peer that failed the service's
required security level keeps a connected, data-passing channel.

The sibling setsockopt(BT_SECURITY) path already rechecks with
l2cap_chan_check_security(), and the non-deferred incoming path denies with
L2CAP_CR_SEC_BLOCK; only the BR/EDR basic/ERTM deferred-accept path was
missed. This is the BR/EDR counterpart of commit 522e9ed157e3 ("Bluetooth:
l2cap: Check encryption key size on incoming connection").

Gate the deferred completion on the security state. In l2cap_sock_defer(),
before completing a BR/EDR deferred accept, call l2cap_chan_check_security();
if the level is not yet met, mark the socket BT_SK_ACCEPTED, leave the channel
in BT_CONNECT2 and send nothing. l2cap_security_cfm() then resolves it: on
failure the existing BT_CONNECT2 branch denies with L2CAP_CR_SEC_BLOCK; on
success, a channel the daemon already accepted is completed through the same
path a non-deferred accept takes (state -> BT_CONFIG, CONN_RSP SUCCESS +
CONF_REQ) rather than re-signalling an accept already made, so exactly one
CONN_RSP is sent per channel and the on-air sequence stays strictly monotonic
(AUTHEN_PEND, then AUTHOR_PEND for a not-yet-accepted channel, then SUCCESS).

Validated on an arm64 QEMU rig with a BR/EDR peer emulated over /dev/vhci:
with the patch, an early accept followed by a genuine Authentication_Complete
failure is answered with CONN_RSP result=3 (SEC_BLOCK) and no data is ever
delivered, identical to the non-deferred control; an early accept followed by
a successful (keyless) auth completes only after the security chain finishes,
with exactly one CONN_RSP SUCCESS and no trailing PEND; a deferred listener
that accepts only after the security resolves goes through the designed
CR_PEND -> recvmsg -> SUCCESS path with the link at the required level.

AI assistance was used in finding and preparing this patch.

Fixes: f66dc81f44d9 ("Bluetooth: Add support for deferring L2CAP connection setup")
Signed-off-by: Mohammed Alquraini <mohammed.saad.alquraini@gmail.com>
---
 include/net/bluetooth/bluetooth.h |  1 +
 net/bluetooth/l2cap_core.c        | 10 +++++++++-
 net/bluetooth/l2cap_sock.c        |  7 +++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -407,6 +407,7 @@
 	BT_SK_SUSPEND,
 	BT_SK_PKT_STATUS,
 	BT_SK_PKT_SEQNUM,
+	BT_SK_ACCEPTED,
 };

 struct bt_sock_list {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -8011,7 +8011,15 @@
 			__u16 res, stat;

 			if (!status && l2cap_check_enc_key_size(hcon, chan)) {
-				if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
+				bool deferred = test_bit(FLAG_DEFER_SETUP, &chan->flags);
+				struct sock *sk = chan->data;
+
+				/* Complete inline if the daemon accepted early. */
+				if (deferred && sk &&
+				    test_and_clear_bit(BT_SK_ACCEPTED, &bt_sk(sk)->flags))
+					deferred = false;
+
+				if (deferred) {
 					res = L2CAP_CR_PEND;
 					stat = L2CAP_CS_AUTHOR_PEND;
 					chan->ops->defer(chan);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1274,6 +1274,13 @@
 			release_sock(sk);
 			__l2cap_le_connect_rsp_defer(chan);
 		} else {
+			/* Defer completion until security resolves. */
+			if (!l2cap_chan_check_security(chan, false)) {
+				set_bit(BT_SK_ACCEPTED, &bt_sk(sk)->flags);
+				release_sock(sk);
+				l2cap_chan_unlock_conn(chan, have_conn);
+				return err;
+			}
 			sk->sk_state = BT_CONFIG;
 			chan->state = BT_CONFIG;
 			release_sock(sk);
--
2.43.0
