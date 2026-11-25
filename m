Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624044;
	b=0quiTJTnkh9IvgMaPy2wthhWdObLZMqofquFYIMWc3vdGm51RE92yAhwPFXDKZhQ6hbP
	 0QwF0vSo4A3TSHazyIb8Q52NNDzbQjGnnMoi2Bh/HVoE8DUxFd5NAAs77tUhZiLgzxOP6
	 lViFp9B0xrjzXICkNaoFCTl/usTRQc+KFSyZoNKMQnkdcpyMaW2CcYr03gJwqqm/TCOQM
	 LOXa8HSmSIg7yUTUf12+RmbNdvOreLEedh3oZ+BgoxV7fwT4QkZMnnEcU3lPhevKUwmyj
	 e333IVpHZND8fM3jr5svhYlutr7hEnzE5NZp/BEZFluMZZxidEdCVC4LzvdBvuFm1Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624044;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZzGaoEIuMkWnnykCkgT/ViIFgrHknATB4qvqRFbdR/s=;
	b=qpcNXnFLxxsjTCiTy7NpirNkBuyZvkPvrBs5QVe4eNhp5JwosLqAc1xHd0/bxsLWOKHD
	 7LHkrXM2mokjETkA4S7b51nlFoMstGVFZMi1HLGePmd76vjbaKyy9qLeYU1aOQ81bXKtn
	 B6oIx7Rum3l9ILorC8hRjFe3UcpiWoQcn/QyrI+QqHXf619j9wLpeBMPbCi8KwELxhYIw
	 9VrKFnGd3x9bdTMs8uRq1DmiIJSXfrc/gfmCtu/1Hy7YdIqy/FPOvIUxcU6L1qM0u6xL2
	 biWpL39oWEolo5mV1gXZizAkHpNfKQ/yBZIPqh0qFfhNYOnejDEzQiXDFe6qAldjnfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XJeyC37q;
	arc=none smtp.remote-ip=209.85.217.41
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76FE606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 16:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E76FE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XJeyC37q
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-7cc2bb73cd9so2270632137.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 08:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795624043; x=1796228843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZzGaoEIuMkWnnykCkgT/ViIFgrHknATB4qvqRFbdR/s=;
        b=XJeyC37qWPBOWQywjuI43DSNunCXe3zf5iW4sflrGMMpjMBnDEj690Ht1UW31K0Rze
         Z9J2O19OyX7dtCnFbmz+rnoYgvzL/KgtlEEU4e7ukzvCoXdQXrt8DEynAX/5aUCKbB9N
         MlmIh0SJDdZPkrMCL9Hg+9KWGk+R+KEQzdTDZJYiDAvnZHN8tA4224CNbjfScbFosBzX
         H03tCgKnzdJ7JtMKtOrVn4KcveYUuPLKCqfFOHI475eEyezgMecVCSAzHAdf4vbcLEej
         s6x1tEOhHu8Xd60GR4WC8MQ04wn4SaOo9vCSm/yoJk8ESQ3wSGYrbPcv/F6BK2yHyAen
         YblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795624043; x=1796228843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZzGaoEIuMkWnnykCkgT/ViIFgrHknATB4qvqRFbdR/s=;
        b=EBROnbviukLdGPYbmN5sVUNydVNPvu9XN6FqzlS2Gq5Mk3Wl5nmChf7RN+mrddhjIg
         i8CjO/f5Nt0PzSzwNwFVBnfu9Aam+QW0Ys/EbkwmrAxnsuIZdZ8GNyDpvOY04wh/CRLd
         1SM6icA2HEUQzYXlyySGbOHWhs1rBBpZ5mqLFo1oGaEspq9rMNdsLvSyp7ONy4OFn3iY
         Mko4JqljjQs4BVpp6DbuVIXnjZ7R7wEw02dSklFCXc1CYQM9OQ53tTroDrnZ8fnxAc76
         xcX5hFG5cfEhQ1n0OPFztyKs9e0OtlQfl7LGqG9rKwUVRm2TGy++4h7oYKQk24TZm4VW
         m4WA==
X-Gm-Message-State: APuU4Z8se2BUdXNSLx2YhMi6Q5qnPYgqOSz4+ebLTI54ktQUidHSIE4c
	XvTThbqNL7/oiLSDThWjjn27NN540G/cOtckS4lA+6mlkRM5vpLrT9q307WktQ==
X-Gm-Gg: AZFdTZcS86h2bnwIhOPY1yUwVVnAPM4rYjwBvEdIt9cJesxNEclH56Bz6KBjxw1r9xJ
	6Qyec44IfAQPwig4LrDM2rSQ2elyarwFpFzSto0/acOTi9kJI67klPLFmaoOgcZO4eEkGgKFP4G
	wxaoZ3ZQGC+x1fULG8TlF4h0M5HkgBRhYdgGj4dUjgOPG+QIpUpyznUrV9xYLUhDNlrXZC94jRv
	VbtdUmI4iDYp/URcpBsn+woWEg58qGQA+oJG8cVu0ViwS/LhUSSVekU+h84Z8xXQD/3jbQDiGYn
	0ZsWarWiSd1Hcv+vlkXUgEnpzIC5m1lq4wYtPQo37i4aC6T2W23JTBwvtkyEzNI4rLlMP6PaJT6
	iG+MWUAgHJcNckgC241zaFBafHhOaAn4uW/SifEes1X3WKVJRZ9yUTbxaXXLzGgeyapfjRTNyVv
	tE1fb2NGyY+tZZus84R4M0edXMRntmUDZDQeKdjXJky74aUH57iAOmUFcG861TPaWk30Oa7IQOf
	556aGOEFqffNSmlDtQqg9gDfsDRG2VMRZOEKoPw6i+mN0oW3rcbl7kejEV4ihBs7DdaXU3fFkAe
	VNymb4aAoM/ssGlEOQo2hyrn2JUkLkICJhBFwOgBhpVGIKCgJEaSAOE/qWdE9oPgTZzn4q2t9MB
	CT7vtYYsLcKSCPH8RgBJDcv/aWzZYJKpsjzh9ur1BYLv1kTL5LPnloTrAJqMObmn6M9VcMvlwtE
	vSjBikIC/wIDft1gtnHofagLq7
X-Received: by 2002:a05:6102:3f13:b0:7c3:9a36:bbda with SMTP id ada2fe7eead31-7d72b368b75mr9682453137.5.1795624042531;
        Wed, 25 Nov 2026 08:27:22 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e8265e55sm19511881137.11.2026.11.25.08.27.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:27:22 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 1/2] Bluetooth: L2CAP: Fix accepting channels with insufficient security
Date: Wed, 25 Nov 2026 11:27:18 -0500
Message-ID: <20261125162719.1407771-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125162719.1407771-1-luiz.dentz@gmail.com>
References: <20261125162719.1407771-1-luiz.dentz@gmail.com>
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

From: Mohammed Alquraini <mohammed.saad.alquraini@gmail.com>

When the link security changes, l2cap_security_cfm() doesn't check
that the result meets the security level required by the channels:

 - If encryption completes it sets chan->sec_level to hcon->sec_level,
   so a channel requiring a higher security level than the one the
   link ended up with has its requirement lowered instead of being
   refused.

 - A channel in BT_CONNECT2 is accepted, or offered to the listener if
   it uses BT_DEFER_SETUP, as long as the status is success and the
   encryption key size is valid, e.g. if the peer disables encryption
   while the channel waits for userspace to authorize it, the channel
   is offered again and, once authorized, it is established over an
   unencrypted link.

 - A channel in BT_CONNECT is started as long as the status is
   success, no matter if the link meets its security level.

 - The security level of the link is updated when authentication
   completes, before encryption is enabled, so it can't be used alone
   to tell if the link is secure enough.

Fix this by treating encryption completing with a security level
below the one required by a channel as a downgrade: the security level
of the channel is no longer lowered and the channel is disconnected,
or refused with L2CAP_CR_SEC_BLOCK if it was pending. There is no way
to disconnect a fixed channel at L2CAP, so for those the link is
disconnected instead. Channels in BT_CONNECT2 and BT_CONNECT are only
accepted, or started, if the link is encrypted and meets their
security level.

Since chan->sec_level follows the security level of the link once
encryption is enabled it can't tell what a channel requires, so keep
that in the new min_sec_level, which is set wherever the security level
is requested for the channel, otherwise channels that never asked for
more than BT_SECURITY_LOW, like SMP, would be considered downgraded
when the link is paired again with a lower security level.

Deferred LE Credit Based and Enhanced Credit Based channels wait in
BT_CONNECT2 for userspace to authorize them, which doesn't check the
security level, so refuse them there if the link no longer meets it.

This means a channel requiring a security level that pairing can't
provide, e.g. BT_SECURITY_HIGH when the IO capability is
NoInputNoOutput, is now refused instead of being connected with the
security level the link ended up with.

AI assistance was used in finding and preparing this patch.

Fixes: f66dc81f44d9 ("Bluetooth: Add support for deferring L2CAP connection setup")
Signed-off-by: Mohammed Alquraini <mohammed.saad.alquraini@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/l2cap.h |  6 +++
 net/bluetooth/l2cap_core.c    | 83 ++++++++++++++++++++++++++++++++---
 net/bluetooth/l2cap_sock.c    | 33 +++++++++++---
 net/bluetooth/rfcomm/core.c   |  1 +
 4 files changed, 110 insertions(+), 13 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 72d9d56c6f2a..c93f5b9722d9 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -544,7 +544,12 @@ struct l2cap_chan {
 	__u8		chan_type;
 	__u8		chan_policy;
 
+	/* The security level of the link, which sec_level follows once
+	 * encryption is enabled, so it can't tell what the channel requires,
+	 * that is what min_sec_level is for.
+	 */
 	__u8		sec_level;
+	__u8		min_sec_level;
 	__u8		mic_len;
 
 	__u8		ident;
@@ -987,6 +992,7 @@ int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le16 psm);
 int l2cap_add_scid(struct l2cap_chan *chan,  __u16 scid);
 
 struct l2cap_chan *l2cap_chan_create(void);
+bool l2cap_chan_sec_level_ok(struct l2cap_chan *chan);
 void l2cap_chan_close_unlocked(struct l2cap_chan *chan, int reason)
 	__must_not_hold(&chan->lock);
 int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 943effc86740..3d6974872194 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -551,6 +551,7 @@ void l2cap_chan_set_defaults(struct l2cap_chan *chan, struct l2cap_chan *pchan)
 	chan->remote_tx_win = chan->tx_win;
 	chan->ack_win = L2CAP_DEFAULT_TX_WINDOW;
 	chan->sec_level = BT_SECURITY_LOW;
+	chan->min_sec_level = BT_SECURITY_LOW;
 	chan->flush_to = L2CAP_DEFAULT_FLUSH_TO;
 	chan->retrans_timeout = L2CAP_DEFAULT_RETRANS_TO;
 	chan->monitor_timeout = L2CAP_DEFAULT_MONITOR_TO;
@@ -567,6 +568,7 @@ void l2cap_chan_set_defaults(struct l2cap_chan *chan, struct l2cap_chan *pchan)
 		chan->tx_win = pchan->tx_win;
 		chan->tx_win_max = pchan->tx_win_max;
 		chan->sec_level = pchan->sec_level;
+		chan->min_sec_level = pchan->min_sec_level;
 		chan->mic_len = pchan->mic_len;
 		chan->conf_state = pchan->conf_state;
 		chan->flags = pchan->flags;
@@ -5173,6 +5175,8 @@ static int l2cap_le_connect_rsp(struct l2cap_conn *conn,
 		sec_level = hcon->sec_level + 1;
 		if (chan->sec_level < sec_level)
 			chan->sec_level = sec_level;
+		if (chan->min_sec_level < sec_level)
+			chan->min_sec_level = sec_level;
 
 		/* We'll need to send a new Connect Request */
 		clear_bit(FLAG_LE_CONN_REQ_SENT, &chan->flags);
@@ -5789,6 +5793,8 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 			sec_level = hcon->sec_level + 1;
 			if (chan->sec_level < sec_level)
 				chan->sec_level = sec_level;
+			if (chan->min_sec_level < sec_level)
+				chan->min_sec_level = sec_level;
 
 			/* We'll need to send a new Connect Request */
 			clear_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags);
@@ -8095,11 +8101,31 @@ static inline void l2cap_check_encryption(struct l2cap_chan *chan, u8 encrypt)
 	}
 }
 
+/* Check if the link meets the security level required by the channel, which
+ * for anything above BT_SECURITY_LOW needs the link to be encrypted since the
+ * security level of the link is updated when authentication completes, before
+ * encryption is enabled.
+ */
+static bool l2cap_chan_sec_level_met(struct hci_conn *hcon,
+				     struct l2cap_chan *chan)
+{
+	if (chan->min_sec_level <= BT_SECURITY_LOW)
+		return true;
+
+	return test_bit(HCI_CONN_ENCRYPT, hcon->flags) &&
+	       hcon->sec_level >= chan->min_sec_level;
+}
+
+bool l2cap_chan_sec_level_ok(struct l2cap_chan *chan)
+{
+	return l2cap_chan_sec_level_met(chan->conn->hcon, chan);
+}
+
 static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 	__must_hold(&hcon->hdev->lock)
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
-	struct l2cap_chan *chan;
+	struct l2cap_chan *chan, *tmp;
 
 	if (!conn)
 		return;
@@ -8108,7 +8134,10 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 
 	mutex_lock(&conn->lock);
 
-	list_for_each_entry(chan, &conn->chan_l, list) {
+	list_for_each_entry_safe(chan, tmp, &conn->chan_l, list) {
+		bool unmet = !status && !l2cap_chan_sec_level_met(hcon, chan);
+		bool downgrade = false;
+
 		l2cap_chan_lock(chan);
 
 		lockdep_assert_held(&chan->conn->lock);
@@ -8116,14 +8145,54 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 		BT_DBG("chan %p scid 0x%4.4x state %s", chan, chan->scid,
 		       state_to_string(chan->state));
 
-		if (!status && encrypt)
-			chan->sec_level = hcon->sec_level;
+		if (!status && encrypt) {
+			/* Encryption completing with a security level below
+			 * the one the channel requires is a downgrade, don't
+			 * lower the requirement of the channel to match it.
+			 */
+			if (unmet)
+				downgrade = true;
+			else
+				chan->sec_level = hcon->sec_level;
+		}
 
 		if (!__l2cap_no_conn_pending(chan)) {
 			l2cap_chan_unlock(chan);
 			continue;
 		}
 
+		/* A channel that is not established yet is refused as soon as
+		 * the link doesn't meet its security level, while an
+		 * established one is only closed on a downgrade since
+		 * l2cap_check_encryption() handles encryption being disabled.
+		 */
+		if ((downgrade && (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED ||
+				   chan->state == BT_CONNECTED ||
+				   chan->state == BT_CONFIG)) ||
+		    (unmet && chan->state == BT_CONNECT2 &&
+		     chan->mode == L2CAP_MODE_LE_FLOWCTL)) {
+			/* There is no way to disconnect a fixed channel at
+			 * L2CAP, so drop the link, which takes down the rest
+			 * of the channels as well.
+			 */
+			if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
+				hci_disconnect(hcon, HCI_ERROR_AUTH_FAILURE);
+				l2cap_chan_unlock(chan);
+				break;
+			}
+
+			/* The channel may be removed from the list */
+			l2cap_chan_hold(chan);
+			__l2cap_chan_close(chan, ECONNREFUSED);
+
+			if (test_bit(FLAG_DEL, &chan->flags))
+				chan->ops->close(chan);
+
+			l2cap_chan_unlock(chan);
+			l2cap_chan_put(chan);
+			continue;
+		}
+
 		if (!status && (chan->state == BT_CONNECTED ||
 				chan->state == BT_CONFIG)) {
 			chan->ops->resume(chan);
@@ -8133,7 +8202,8 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 		}
 
 		if (chan->state == BT_CONNECT) {
-			if (!status && l2cap_check_enc_key_size(hcon, chan))
+			if (!status && l2cap_chan_sec_level_met(hcon, chan) &&
+			    l2cap_check_enc_key_size(hcon, chan))
 				l2cap_start_connection(chan);
 			else
 				__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
@@ -8143,7 +8213,8 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 			struct l2cap_conn_rsp rsp;
 			__u16 res, stat;
 
-			if (!status && l2cap_check_enc_key_size(hcon, chan)) {
+			if (!status && l2cap_check_enc_key_size(hcon, chan) &&
+			    l2cap_chan_sec_level_met(hcon, chan)) {
 				if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
 					res = L2CAP_CR_PEND;
 					stat = L2CAP_CS_AUTHOR_PEND;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index d5663a4642a9..c8730e4b6c21 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -47,6 +47,15 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 				     struct l2cap_chan *chan);
 static void l2cap_sock_cleanup_listen(struct sock *parent);
 
+/* Set the security level required by the channel, as opposed to the one of the
+ * link that chan->sec_level follows.
+ */
+static void l2cap_sock_set_sec_level(struct l2cap_chan *chan, __u8 level)
+{
+	chan->sec_level = level;
+	chan->min_sec_level = level;
+}
+
 bool l2cap_is_socket(struct socket *sock)
 {
 	return sock && sock->ops == &l2cap_sock_ops;
@@ -143,15 +152,15 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr_unsized *addr, i
 	switch (chan->chan_type) {
 	case L2CAP_CHAN_CONN_LESS:
 		if (__le16_to_cpu(la.l2_psm) == L2CAP_PSM_3DSP)
-			chan->sec_level = BT_SECURITY_SDP;
+			l2cap_sock_set_sec_level(chan, BT_SECURITY_SDP);
 		break;
 	case L2CAP_CHAN_CONN_ORIENTED:
 		if (__le16_to_cpu(la.l2_psm) == L2CAP_PSM_SDP ||
 		    __le16_to_cpu(la.l2_psm) == L2CAP_PSM_RFCOMM)
-			chan->sec_level = BT_SECURITY_SDP;
+			l2cap_sock_set_sec_level(chan, BT_SECURITY_SDP);
 		break;
 	case L2CAP_CHAN_RAW:
-		chan->sec_level = BT_SECURITY_SDP;
+		l2cap_sock_set_sec_level(chan, BT_SECURITY_SDP);
 		break;
 	case L2CAP_CHAN_FIXED:
 		/* Fixed channels default to the L2CAP core not holding a
@@ -867,11 +876,11 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 		}
 
 		if (opt & L2CAP_LM_AUTH)
-			chan->sec_level = BT_SECURITY_LOW;
+			l2cap_sock_set_sec_level(chan, BT_SECURITY_LOW);
 		if (opt & L2CAP_LM_ENCRYPT)
-			chan->sec_level = BT_SECURITY_MEDIUM;
+			l2cap_sock_set_sec_level(chan, BT_SECURITY_MEDIUM);
 		if (opt & L2CAP_LM_SECURE)
-			chan->sec_level = BT_SECURITY_HIGH;
+			l2cap_sock_set_sec_level(chan, BT_SECURITY_HIGH);
 
 		assign_bit(FLAG_ROLE_SWITCH, &chan->flags,
 			   opt & L2CAP_LM_MASTER);
@@ -991,7 +1000,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		chan->sec_level = sec.level;
+		l2cap_sock_set_sec_level(chan, sec.level);
 		chan->mic_len = sec.mic_len;
 
 		conn = l2cap_chan_conn(chan);
@@ -1284,6 +1293,16 @@ static int l2cap_sock_defer(struct sock *sk)
 		if (!have_conn) {
 			release_sock(sk);
 			err = -ENOTCONN;
+		} else if ((chan->mode == L2CAP_MODE_EXT_FLOWCTL ||
+			    bdaddr_type_is_le(chan->src_type)) &&
+			   !l2cap_chan_sec_level_ok(chan)) {
+			/* The link doesn't meet the security level required
+			 * anymore, refuse the connection like closing it would.
+			 */
+			release_sock(sk);
+			l2cap_chan_unlock_conn(chan, have_conn);
+			l2cap_chan_close_unlocked(chan, ECONNREFUSED);
+			return -ECONNREFUSED;
 		} else if (chan->mode == L2CAP_MODE_EXT_FLOWCTL) {
 			sk->sk_state = BT_CONNECTED;
 			chan->state = BT_CONNECTED;
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index e6af6f5f5914..66c88390ca88 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -852,6 +852,7 @@ static struct socket *rfcomm_session_connect(bdaddr_t *src, bdaddr_t *dst,
 	/* Set MTU to 0 so L2CAP can auto select the MTU */
 	l2cap_pi(sk)->chan->imtu = 0;
 	l2cap_pi(sk)->chan->sec_level = sec_level;
+	l2cap_pi(sk)->chan->min_sec_level = sec_level;
 	if (l2cap_ertm)
 		l2cap_pi(sk)->chan->mode = L2CAP_MODE_ERTM;
 	release_sock(sk);
-- 
2.56.0

