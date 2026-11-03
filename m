Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744371;
	b=N8gx7xVON39ukx7ivYYAOEdp3icf7TOEasme+r5I0TmeCzgEDTkSjaab2jiKa1wHZzhw
	 bmjba9o1WFoeNG0DrAlAwdywT9QjfJCzcq3gY673ewLM43Ayv/SddppzQstEK0KtW5wXC
	 AhJoDJBrYWAiogtrBZO0Hm5E728DkZufoGn7pdpx8u1kag0/DgRCayY85ZiyVKJfOXo/T
	 xliWA/8BLu5Vj7TC1cxdetT7kXi4nQRFuGW+XyIKBepgEFh2zhBbTIkpsTFAC69MTdCtc
	 Ns0cOAKVWxykslSJ9AEzpPJUDYXgyK+SPkJABftwMbOTS/J/z2iGdLSQE/moA7plccg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744371;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yiHnJ1b4JpPlDLLtRj/Kxho9wFcjl5E/e4r3JdhI3Wo=;
	b=Uax6Uj2HwJnhV5U7Cz7fVLbh32knlROT0EIuiTOyBsxsslY70LaMkB/S0RszQ1dkueR8
	 4JtpzCT0BE6RJ1TFV0PjZrUKq+5wJifxvVbW/1jYXIsjSR+s/4bIzIN/CWSMSHA6Vg1JE
	 Q6QXTKu/gtvGUZhliYsVn8EQzOl32EnC3MH4S6xDwzOP2eMflJiu2Jahg86Jv1n+5PDw0
	 Pdb3ZMsV4qNM1bzajIw7WU/Ic6FOclUNaiajfhlCipiCEvfLyz6/57yq5T43XAdcbBkon
	 xbAVUj7cFNkfipHBzVesFWjYV7O/FsT7fTcabTMjdoHREUJK+iOD7H8G+qB4hcMFiHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ucPBw+az;
	arc=none smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE04606A333
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 22:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BE04606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ucPBw+az
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9828fee1b4bso27255241.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 14:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744370; x=1794349170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yiHnJ1b4JpPlDLLtRj/Kxho9wFcjl5E/e4r3JdhI3Wo=;
        b=ucPBw+azEz55/64Fd4h/U53O1PLW4U8TG6R4mOY+UMSb8YicJlZ1GB7DBruc9XkK45
         +Sg7AaPzTIAMAgRmfDYOi06kEzjradQgs3KrMcfxPbnXhb1FkS8gKN2yveRE68Lh/9zN
         24WHQcyVoYx3qiL7JzNs4kcxboCZihcCKVffggVCIjyOjPM5p5b9xHt7Xg/TFxaqdFVJ
         hEkkdVfmEJ8xZ1RMJJ2Vmd1pf/nHqbSM3v6BfHqFmzw5ekw1xliZlQ39M4IUxu51hySk
         Zf+bS3Ch47af1dKJ5DnRqbP/+TO7UV0LU0BJ3/1mypvBz5HdqMsY6XDKBUwCEV8oioPF
         b3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744370; x=1794349170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yiHnJ1b4JpPlDLLtRj/Kxho9wFcjl5E/e4r3JdhI3Wo=;
        b=Mf0hzwIl0h9RrThhXp74COq/Nhzo6UPtiw2vwxd2s9iF8yPegtXuFg4P0gx8sesCrF
         N7+B8E7843fwd7r6kig/7Ce92jfdYilHC4UFIvhdRI94dYyYNWNYGlo+g9ftKWcjqpyR
         94iPRKrvga3rq++DwmL/9VJjq6SNbvp9iD81uHztDu22haDso4XDo1+1f6JKc/Asct92
         Uzg2/y+KLggVF6jnhLr3KMj69zvU0u+6LruhbRYbC218i20ekuhz44n0PDgefy5tquWj
         W7OH0hoe+4XvuweNHXUcP52KQBJxZ1pO9JioQAyAMIA2mSMYo//hcb0mu1Qs6LRNl1VY
         xi5A==
X-Gm-Message-State: APuU4Z8vQ141/3r9PztVbBCIUdgjWMlK86h+/4WhVFRI74HImwz1z7eO
	IeJSIDpvamX8k6OYl/zF3KuAwMORHpIRzI/uq54y/8ktzfBszhJ3dMBY1PSbyA==
X-Gm-Gg: AYBFou3Q4l6sreNs9HhXgeSEG0402SoiaiyfWH0wQyLvWPbJGbva3kYT6KxIqxDUXtF
	L1UDP4iPWl8/mbiAPVH1DjYz4vjGjkdC9Tjox0UAe9d3VtJWq9W1vpmsUCjn7/PZeZv2Zymf9u/
	U5idac7ua79hCYJHYf40ZcVYyKSTXu9M43/IJPDzyxdmb5WP4HLDma8Lz0qXx/5RnutyRQfBoB7
	GkOKTOV6faoaj31vgb1/mGK34PPfiVa+Rml0OasvVvu8riVL9MO2EG0bdsvdycQ32r0kqOKglkw
	pAcWWmjZf4wBG6SjFImCff2xk96VudmDJR/llbh0hBlRsp8FpE3fCN3EwXkzNl4djZmHe6BijqA
	CIHlj77EVr3UwxjTllqsYU/RcTA1kqOyMnvHWm/obQYHvJ7nhgKzoCTmBKArwp8MfVHq9f9NyDg
	KY1aaQCEBH9Y/Rq1AYyw+VtfyppzYoQgzm8mjtjoCuUlGNKcd+A65COYimj8omyfEGkZuBL8lnJ
	rvMEavB/zVdyFkr/9cy2lChnFbLSemyVii54FCS3Qa0Z88hNZj/tdAjduxzPe87XN5KByZJdp13
	yi7nMOUBPQOH2DKzKizM657+UjSBDi+T2w2TLao5II5uBYiLgyy6V0VgeQqt86JZe2uObLyETN3
	XkmKPNjliK08wBX6zU1f6EuP+bnDGLmpoe6x0Ubk9vDLVJu1tp6sP+KnV9mzMd931vcCuu0jt/y
	8ZUERayVRtn2KveS6RS9lVZgGo
X-Received: by 2002:a67:e10d:0:b0:7b2:b159:98c3 with SMTP id ada2fe7eead31-7d072640147mr4945593137.28.1793744370296;
        Tue, 03 Nov 2026 14:19:30 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fef4ed3sm306572137.11.2026.11.03.14.19.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:19:29 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 4/6] Bluetooth: L2CAP: Add MIC length validation for HDT PHY
Date: Tue,  3 Nov 2026 17:19:19 -0500
Message-ID: <20261103221921.4071765-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103221921.4071765-1-luiz.dentz@gmail.com>
References: <20261103221921.4071765-1-luiz.dentz@gmail.com>
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

Add a mic_len field to struct bt_security so userspace can require a
minimum MIC length on an L2CAP channel with BT_SECURITY, and read the
MIC length in use on the link back. The field is added at the end of
the struct, so the shorter struct is still accepted, leaving mic_len
unset.

The requirement is propagated to the connection so LE Enable Encryption
v2 asks for it, and the MIC length reported by Encryption Change v3 is
stored on the connection. When a connection is encrypted on the LE HDT
PHY with a MIC shorter than the channel requires, the LE Credit Based
and Enhanced Credit Based connection requests are rejected with MIC
Length Too Short.

The negotiated MIC length only applies on the LE HDT PHY, the MIC is
always 32 bits on the GFSK PHYs, so hci_conn_mic_len() reports it as
such both for the check and for BT_SECURITY.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/bluetooth.h |  1 +
 include/net/bluetooth/hci_core.h  |  9 +++++++++
 include/net/bluetooth/l2cap.h     |  2 ++
 net/bluetooth/hci_event.c         | 29 +++++++++++++++++----------
 net/bluetooth/hci_sync.c          |  3 ++-
 net/bluetooth/l2cap_core.c        | 33 ++++++++++++++++++++++++++++++-
 net/bluetooth/l2cap_sock.c        | 16 ++++++++++++---
 7 files changed, 78 insertions(+), 15 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 945c0bc58a95..9e462c58c4ce 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -66,6 +66,7 @@
 struct bt_security {
 	__u8 level;
 	__u8 key_size;
+	__u8 mic_len;
 };
 #define BT_SECURITY_SDP		0
 #define BT_SECURITY_LOW		1
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 60318740ec99..d1c6ae23714d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -765,6 +765,7 @@ struct hci_conn {
 	__u8		pending_sec_level;
 	__u8		pin_length;
 	__u8		enc_key_size;
+	__u8		mic_len;
 	__u8		io_capability;
 	__u32		passkey_notify;
 	__u8		passkey_entered;
@@ -2181,6 +2182,14 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 	((conn)->le_tx_def_phys & HCI_LE_SET_PHY_HDT)
 #define hdt_rx_capable(conn) \
 	((conn)->le_rx_def_phys & HCI_LE_SET_PHY_HDT)
+
+/* The MIC length negotiated with LE Enable Encryption v2 only applies on the
+ * LE HDT PHY, the MIC is always 32 bits (0x00) on the GFSK PHYs.
+ */
+static inline __u8 hci_conn_mic_len(struct hci_conn *conn)
+{
+	return conn->le_rx_phy == 0x05 ? conn->mic_len : 0x00;
+}
 #define eks_capable(dev) \
 	(le_feature(dev, 1, 1) & HCI_LE_EKS_FEATURE)
 
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 54eddcdd341f..182df5c5731e 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -285,6 +285,7 @@ struct l2cap_conn_rsp {
 #define L2CAP_CR_LE_SCID_IN_USE		0x000A
 #define L2CAP_CR_LE_UNACCEPT_PARAMS	0x000B
 #define L2CAP_CR_LE_INVALID_PARAMS	0x000C
+#define L2CAP_CR_LE_MIC_LEN_TOO_SHORT	0x00FE
 
 /* connect/create channel status */
 #define L2CAP_CS_NO_INFO	0x0000
@@ -533,6 +534,7 @@ struct l2cap_chan {
 	__u8		chan_policy;
 
 	__u8		sec_level;
+	__u8		mic_len;
 
 	__u8		ident;
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 896a2ebd806d..be8b480e6ab7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3725,7 +3725,8 @@ static void hci_remote_name_evt(struct hci_dev *hdev, void *data,
 	hci_dev_unlock(hdev);
 }
 
-static void hci_change_encrypt(struct hci_conn *conn, u8 status, u8 encrypt)
+static void hci_change_encrypt(struct hci_conn *conn, u8 status, u8 encrypt,
+			       u8 key_size, u8 mic_len)
 {
 	struct hci_dev *hdev = conn->hdev;
 
@@ -3744,14 +3745,21 @@ static void hci_change_encrypt(struct hci_conn *conn, u8 status, u8 encrypt)
 			    conn->type == LE_LINK)
 				set_bit(HCI_CONN_AES_CCM, conn->flags);
 
+			if (key_size)
+				conn->enc_key_size = key_size;
+
+			if (mic_len)
+				conn->mic_len = mic_len;
+
 			/* For ACL links the encryption key size is still
-			 * validated below via hci_read_enc_key_size(). Its
-			 * completion handler, hci_cc_read_enc_key_size(),
-			 * reports the final security level so userspace does
-			 * not see a transient "encrypted" state that a
-			 * key-size downgrade would immediately invalidate.
+			 * validated below via hci_read_enc_key_size(), unless
+			 * the event already carried it. Its completion
+			 * handler, hci_cc_read_enc_key_size(), reports the
+			 * final security level so userspace does not see a
+			 * transient "encrypted" state that a key-size
+			 * downgrade would immediately invalidate.
 			 */
-			if (conn->type != ACL_LINK)
+			if (conn->type != ACL_LINK || key_size)
 				mgmt_security_level_changed(conn);
 		} else {
 			clear_bit(HCI_CONN_ENCRYPT, conn->flags);
@@ -3796,7 +3804,7 @@ static void hci_change_encrypt(struct hci_conn *conn, u8 status, u8 encrypt)
 	}
 
 	/* Try reading the encryption key size for encrypted ACL links */
-	if (!status && encrypt && conn->type == ACL_LINK) {
+	if (!status && encrypt && conn->type == ACL_LINK && !key_size) {
 		if (hci_read_enc_key_size(hdev, conn)) {
 			/* Could not even issue the key-size read: report the
 			 * security level now since hci_cc_read_enc_key_size()
@@ -3853,7 +3861,7 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 	if (!conn)
 		goto unlock;
 
-	hci_change_encrypt(conn, ev->status, ev->encrypt);
+	hci_change_encrypt(conn, ev->status, ev->encrypt, 0, 0);
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -3873,7 +3881,8 @@ static void hci_encrypt_change_v3_evt(struct hci_dev *hdev, void *data,
 	if (!conn)
 		goto unlock;
 
-	hci_change_encrypt(conn, ev->status, ev->mode);
+	hci_change_encrypt(conn, ev->status, ev->mode, ev->key_size,
+			   ev->mic_len);
 
 unlock:
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 1c52b914c236..5f743cf362e5 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -8636,7 +8636,8 @@ static int hci_le_enable_encrypt_v2(struct hci_conn *conn, __le16 ediv,
 	cp->handle = cpu_to_le16(conn->handle);
 	cp->rand = rand;
 	cp->ediv = ediv;
-	cp->mic_len = 0x02; /* Always prefer 128 bits? */
+	/* Use requested mic_len from hcon, default to 128 bits if unset */
+	cp->mic_len = conn->mic_len ? conn->mic_len : 0x02;
 
 	if (ltk) {
 		memcpy(cp->ltk, ltk, sizeof(cp->ltk));
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 70ad30b091e4..4abb4b28ddec 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -579,6 +579,7 @@ void l2cap_chan_set_defaults(struct l2cap_chan *chan, struct l2cap_chan *pchan)
 		chan->tx_win = pchan->tx_win;
 		chan->tx_win_max = pchan->tx_win_max;
 		chan->sec_level = pchan->sec_level;
+		chan->mic_len = pchan->mic_len;
 		chan->conf_state = pchan->conf_state;
 		chan->flags = pchan->flags;
 		chan->tx_credits = pchan->tx_credits;
@@ -1031,8 +1032,13 @@ int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator)
 	struct l2cap_conn *conn = chan->conn;
 	__u8 auth_type;
 
-	if (conn->hcon->type == LE_LINK)
+	if (conn->hcon->type == LE_LINK) {
+		/* Propagate mic_len requirement to hcon for encrypt_v2 */
+		if (chan->mic_len > conn->hcon->mic_len)
+			conn->hcon->mic_len = chan->mic_len;
+
 		return smp_conn_security(conn->hcon, chan->sec_level);
+	}
 
 	auth_type = l2cap_get_auth_type(chan);
 
@@ -1579,6 +1585,18 @@ static bool l2cap_check_enc_key_size(struct hci_conn *hcon,
 		hcon->enc_key_size >= min_key_size);
 }
 
+static bool l2cap_check_mic_len(struct hci_conn *hcon, struct l2cap_chan *chan)
+{
+	/* If the channel has no MIC length requirement, skip check */
+	if (!chan->mic_len)
+		return true;
+
+	if (!test_bit(HCI_CONN_ENCRYPT, hcon->flags))
+		return true;
+
+	return hci_conn_mic_len(hcon) >= chan->mic_len;
+}
+
 static void l2cap_do_start(struct l2cap_chan *chan)
 	__must_hold(&chan->lock)
 	__must_hold(&chan->conn->lock)
@@ -5283,6 +5301,13 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 		goto response_unlock;
 	}
 
+	/* Check if MIC length is sufficient for HDT PHY */
+	if (!l2cap_check_mic_len(conn->hcon, pchan)) {
+		result = L2CAP_CR_LE_MIC_LEN_TOO_SHORT;
+		chan = NULL;
+		goto response_unlock;
+	}
+
 	/* Check for valid dynamic CID range */
 	if (scid < L2CAP_CID_DYN_START || scid > L2CAP_CID_LE_DYN_END) {
 		result = L2CAP_CR_LE_INVALID_SCID;
@@ -5501,6 +5526,12 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 		goto unlock;
 	}
 
+	/* Check if MIC length is sufficient */
+	if (!l2cap_check_mic_len(conn->hcon, pchan)) {
+		result = L2CAP_CR_LE_MIC_LEN_TOO_SHORT;
+		goto unlock;
+	}
+
 	/* Check if the listening channel has set an output MTU then the
 	 * requested MTU shall be less than or equal to that value.
 	 */
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 7a2551ef7f50..9b7798961266 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -623,8 +623,10 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 		if (conn) {
 			sec.level = conn->hcon->sec_level;
 
-			if (sk->sk_state == BT_CONNECTED)
+			if (sk->sk_state == BT_CONNECTED) {
 				sec.key_size = conn->hcon->enc_key_size;
+				sec.mic_len = hci_conn_mic_len(conn->hcon);
+			}
 		} else {
 			sec.level = chan->sec_level;
 		}
@@ -960,9 +962,16 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		sec.level = BT_SECURITY_LOW;
+		/* mic_len was added at the end of struct bt_security, so
+		 * accept the shorter struct as well, leaving mic_len unset.
+		 */
+		if (optlen < offsetofend(struct bt_security, key_size)) {
+			err = -EINVAL;
+			break;
+		}
 
-		err = copy_safe_from_sockptr(&sec, sizeof(sec), optval, optlen);
+		err = copy_struct_from_sockptr(&sec, sizeof(sec), optval,
+					       optlen);
 		if (err)
 			break;
 
@@ -973,6 +982,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 		}
 
 		chan->sec_level = sec.level;
+		chan->mic_len = sec.mic_len;
 
 		conn = l2cap_chan_conn(chan);
 		if (!conn)
-- 
2.56.0

