Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795553430;
	b=CPDT6PJNlXleMDib6el4h6F7EZoR3kMxqQz0O3qg6AaXI4NQ3qkNT1/beHOlGOE7wmtO
	 xW3Vx8O2Mrp68XCAIpFodDVnLvqnx0B1H6d8sLsYXasPHThJVsOjmKO7qROeNn6IqJfDK
	 DFVokE2rd0gDBjl9kqGQiipBvr37RCcGJNFbnl2uqo7cg8S3WmQwAg8pe0hu2l7O6YWq8
	 FezY3KZfkSoa5WR2XRrXWS8TILfJwTJGMYI28yVZeMIxSfiKywF9Vmh9YYQUC+grjC/BU
	 tNAqaTC71udTIflT2ZUGt6Q+V9iTgel2ThkZ9NwhQ2H7847+kyXLUObNu+lbJu1lkiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795553430;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8HH6KqmKpec76I723jaKS50gscDGdpHDg9azqAkahI4=;
	b=11awf/33vUdDR+NsoAG6BJD4+2IW65le3gDCVd2U8bgJzp4yCc9pGYbBxHGVzFi3DFvW
	 ddKhLRdEGNonKcwNYaQpAtJRmNxjxQWeK/z3WnLHm6/L6jxKIJA5GjPbnMou8ATZQwDHq
	 4gYiZMvbvP7epgZb8sn/xGHZj9JTIrxqx0CT2EDOECr3GKZBHKVStHKwPDtJitDtJwVKP
	 3dfGOLQ0FKEaLlLRHayQMwZ/C9qBkOxy2fIEQHe0Fb7p7VBd1dvkxTiz4TSwPvQQ+8MaU
	 CDGEd6+2rkKY61Z9Q8TZQKg2/BxZPIeRw1MNsZplk/HrMCUcNJkGAHHvo7qLbUtIulQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wrrzMAtP;
	arc=none smtp.remote-ip=209.85.222.47
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC031606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 20:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC031606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wrrzMAtP
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-99e0b1ee864so1864651241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 12:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795553428; x=1796158228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8HH6KqmKpec76I723jaKS50gscDGdpHDg9azqAkahI4=;
        b=wrrzMAtPs6jAXfhdYH0p8Vf7gr705sw+3hmWt3HxzcXaQG7D/Smv3WQ8SLLTipHLXT
         6AnifiKW8TXdMRUhwIg1iV6zK4FaM5XNRmq5f/Bj0lcfJJPv3kEwQfvfB92Mjc5vWxhF
         rMnDDelPZBAkzS+gjkv53BokNZfnp6YKSCUgbacZHpe4okJhl0I53bmIYFqQUrnkW84d
         gl9LG3VA9cH8HzhmM1aYRqvrIKt7SfPEjdrIvOyOMn1tAuS5NgOBNUxXFyBCe815V2Cs
         KwZjQYcLdFfR8MTmRhpji0mCClI6XOiszW1rZUjs6zGZ2T5dBTf2E48FHJHkD9LHkG4K
         wxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795553428; x=1796158228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8HH6KqmKpec76I723jaKS50gscDGdpHDg9azqAkahI4=;
        b=vHZzzIWoJSXb2y0EGtIE/bEH3tV1aEo14Xlz7xEY8y7FXqMrVqbAkDn8jwE5rSgBhJ
         F64m3gCo+hgr6qC6EGv2u+sn+rpWp8WyrKHSNOZ+UfbxgSS77LnkFYK08OPzF9c3NoSI
         +h3WiwqHABHkuambji8aEludAY1H74ACAb3eCfHhsIxgs3Nzz3DFpCE/urMbxXPwxagE
         j4Bsb473TwnGSKfip749FQPe5Ymh6OMkC8z31s0VzYVo1eEOm6AQrTqUGfCWAKA7bY1Z
         Y0ZJ1CriyeK6KWyBcb1o3LaCXhNb5WIyYPcGYtKW4Es7eym8cpC8iZDf1WkGVQ8CgeNb
         4kVg==
X-Gm-Message-State: APuU4Z9+9Pe+LEW84l4cF7HcODWRp6NHMehMnO+Hsb+BZeHdgvHf06VA
	jCcrNf/QmgzMVhFGC4MqyRpYyVN24DgZGkc8+3+XdH8Eq8Mp0o6k4RbrRzsIhQ==
X-Gm-Gg: AZFdTZf6D37131Pc5BmVVMQbKLaCMu+oNb85xPap4HIFuhufd8VJeYcSsOl9CN3b4VU
	RuYPgq1FELSHFi+IBN2hMvS5n8DLFB3b6eFPo5/YK1vcYdhVdnZo6h3g/8upH1jfh1U+RmcR0WC
	tK7I8jHjuEDjyL4Tdi87l2xXe08VPlqC593b7JrRBq8FMtHOB2uW/Mb/WOSdrwY0s1ix6vYB1fg
	9drt7T2IBp0Sp8EA78N7em3orMz66Tt3hTU06cmAJJMwwrqTHAGN5KT0O+k1eO9VmzEBH/1O5P/
	ktwaMJrukWSqH9rhJvzlrKehTQlD685jm3P0ZRMvfZyR73fTlsRYoukwQQPu3Nt0FmCRi8UH+JB
	2PHucyCBcSWsfKx95T/jckc+MaZmiuL0s3WQXZU2nPj250Vhb8vp0yVckT1deYCE+3k5g5e0tpS
	/TWw04O6qHvH+mQFlhxbF/G//DbyH3uAlKfrU8dzYTAjQiwU9M/hWHDC6d/o8zhhm7bcCKNeEBu
	di1ePqwQBy0kRERvsots/vtZIIPasOwVcozrCiDjxAyhE+hbkoa+r5yph96Od1aUGtX7NqjD0S1
	E5fk3L0n/rLljSIaN5s2FzqdXt+2W1kQBl+6++4GbBHZX66QpC6DXRh6aR2pV/trouubC3gBGaD
	goEvJTe4xo8TwYBefRN/0wa3knUCJN6ewOIbO4Q0jZlQexsd79jknVVNJvqB3x23ltj5YYNjK2H
	Tlee8=
X-Received: by 2002:a05:6102:5794:b0:7c1:62d2:e18a with SMTP id ada2fe7eead31-7d739461a80mr8829361137.16.1795553428326;
        Tue, 24 Nov 2026 12:50:28 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e80cb440sm16308884137.7.2026.11.24.12.50.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 12:50:27 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 1/2] Bluetooth: L2CAP: Fix accepting channels with insufficient security
Date: Tue, 24 Nov 2026 15:50:24 -0500
Message-ID: <20261124205025.736808-2-luiz.dentz@gmail.com>
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

Fix this by treating encryption completing with a security level
below the one required by a channel as a downgrade: the security level
of the channel is no longer lowered and the channel is disconnected,
or refused with L2CAP_CR_SEC_BLOCK if it was pending. There is no way
to disconnect a fixed channel at L2CAP, so for those the link is
disconnected instead. Channels in BT_CONNECT2 and BT_CONNECT are only
accepted, or started, if the link meets their security level.

This means a channel requiring a security level that pairing can't
provide, e.g. BT_SECURITY_HIGH when the IO capability is
NoInputNoOutput, is now refused instead of being connected with the
security level the link ended up with.

AI assistance was used in finding and preparing this patch.

Fixes: f66dc81f44d9 ("Bluetooth: Add support for deferring L2CAP connection setup")
Signed-off-by: Mohammed Alquraini <mohammed.saad.alquraini@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 58 ++++++++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 943effc86740..eea74188db97 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -8095,11 +8095,19 @@ static inline void l2cap_check_encryption(struct l2cap_chan *chan, u8 encrypt)
 	}
 }
 
+/* Check if the link meets the security level required by the channel */
+static bool l2cap_chan_sec_level_met(struct hci_conn *hcon,
+				     struct l2cap_chan *chan)
+{
+	return chan->sec_level <= BT_SECURITY_LOW ||
+	       hcon->sec_level >= chan->sec_level;
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
@@ -8108,7 +8116,9 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 
 	mutex_lock(&conn->lock);
 
-	list_for_each_entry(chan, &conn->chan_l, list) {
+	list_for_each_entry_safe(chan, tmp, &conn->chan_l, list) {
+		bool downgrade = false;
+
 		l2cap_chan_lock(chan);
 
 		lockdep_assert_held(&chan->conn->lock);
@@ -8116,14 +8126,48 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 		BT_DBG("chan %p scid 0x%4.4x state %s", chan, chan->scid,
 		       state_to_string(chan->state));
 
-		if (!status && encrypt)
-			chan->sec_level = hcon->sec_level;
+		if (!status && encrypt) {
+			/* Encryption completing with a security level below
+			 * the one the channel requires is a downgrade, don't
+			 * lower the requirement of the channel to match it.
+			 */
+			if (!l2cap_chan_sec_level_met(hcon, chan))
+				downgrade = true;
+			else
+				chan->sec_level = hcon->sec_level;
+		}
 
 		if (!__l2cap_no_conn_pending(chan)) {
 			l2cap_chan_unlock(chan);
 			continue;
 		}
 
+		if (downgrade && (chan->state == BT_CONNECTED ||
+				  chan->state == BT_CONFIG ||
+				  (chan->state == BT_CONNECT2 &&
+				   chan->mode == L2CAP_MODE_LE_FLOWCTL))) {
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
@@ -8133,7 +8177,8 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 		}
 
 		if (chan->state == BT_CONNECT) {
-			if (!status && l2cap_check_enc_key_size(hcon, chan))
+			if (!status && l2cap_chan_sec_level_met(hcon, chan) &&
+			    l2cap_check_enc_key_size(hcon, chan))
 				l2cap_start_connection(chan);
 			else
 				__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
@@ -8143,7 +8188,8 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 			struct l2cap_conn_rsp rsp;
 			__u16 res, stat;
 
-			if (!status && l2cap_check_enc_key_size(hcon, chan)) {
+			if (!status && l2cap_check_enc_key_size(hcon, chan) &&
+			    l2cap_chan_sec_level_met(hcon, chan)) {
 				if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
 					res = L2CAP_CR_PEND;
 					stat = L2CAP_CS_AUTHOR_PEND;
-- 
2.56.0

