Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794244729;
	b=0HhL6bMaT0P2D3fSiwB9PlZCo+tqrZliwic7isjuQamVMadwgffjApCkgGugIctjDEmv
	 aYSrUTY0x7F8USOB0TkqPQecTtF6couiGTA/uKCYZHBSetq7LuzcyyVh6z6iiUo4hk8H/
	 jKNx36pIAEo6504pFi9J5eg/3c3kRcONw0Lm1APOdRRX+Wk7mSg0lWqE0AZCYclwdGPFq
	 dWM+XQg1xgxUGM1/QtGRPXzSAGmgbDbSn+HzvkUSQZl/onMG3FNdXpTsn0n6QDcEZBBco
	 sRqHAekFN2ICqEjeta0JQPx3/31dEDKRgs7foQP7OwozbEajyg3wS3iyNLHrUCx9FZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794244729;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5ldYRqsgv1BF4JlXFf2XRzPRaMAbMuQaJW1Dz8F8usw=;
	b=j6ekElQYD8HbJXkQdPWJENRikxGZJdIt/92ZMjXmXEtINk1adf1gW/fmX4r9KlU/iutV
	 xWQivT/qbBS0/h8cF010DAsmV6y4AZUtEketJ3obwun37t7MkwZI1QwffA9Y0p2gTQOZS
	 xq0qmifZkH+5ND11d87fvPpDKf2XgiPUbDy02kK3D7d/NhxDvp8+58rRboz35c/tjswX7
	 vzc3kcc0lkcZjAdT4hIeHYtL7dPszy7I1NVVxaf0gWGKE34KtAxXCBeKMyVc3VkVVrayu
	 7PiIw3+kJY1ikyuzYcMZL2ZjZvF2DXqJ6sZmGV2KD0LFVLqW16E/+NepqWg1iGa8zSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cesiyn1V;
	arc=none smtp.remote-ip=209.85.222.50
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED74606A331
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 17:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4ED74606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cesiyn1V
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-99c0c1d07feso484186241.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 09:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794244728; x=1794849528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5ldYRqsgv1BF4JlXFf2XRzPRaMAbMuQaJW1Dz8F8usw=;
        b=Cesiyn1VC+zmRbnvHLuFzZP/bq6EW6jcD4JF/mnl1Op0mghVubvadUixgpE7Koqh+V
         GoDzUwkWu2W19jEc37SSYa9lyPe4XJ7CboJjv4TjjlFt8Zsj3e8iRmr7Png9Eezp/geB
         W/D5LM5cHyMj9Ls90Dn5hH698AsSPZcQCbAmHUbOIDWmZjnPEwpQ5uxrRlcViAM0wn7N
         AuFdNxbyRcw1xWjmmhPwe0B9qNgQUkWn3Rayn7Q+AU5cTT0VLd6x0lWjWoRbjUP0kpz9
         0q+NBUlaSdj/BA5AQHlnYRKeamZx72ztgpQIJGh2VxRNCq1t0i+nOBCp6jdaIrDLDz3V
         mOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794244728; x=1794849528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5ldYRqsgv1BF4JlXFf2XRzPRaMAbMuQaJW1Dz8F8usw=;
        b=KAKwTFBeWIa+yRg5U7vfsvVZnthbYI0VUIGh2eK8nxwnIWI6I9t5E+sh0l6U8TtRH5
         5xFfAZFLpxr3JN7qJgZEx5TrVUacXnKqD0rnbqQqO/suRZ3LJDYQicy/h59qrsrGGSGM
         0eQJObk3jJ5ghxrWAs0DwZrmfKvi978T3dvEiQm1BEMgMxIX3ZR5CJOd15wuOa6q8M0m
         cwJSg/sA7f/+PiGbJLKy4A9UMRXUYSdnEWPf6iBQ2/85Q2/FNO1Yf+uCXtNmUC8BKcpn
         vdXz0sF2kCaWRqeBZJmea4AM7EuK9VfWXGczR1J+YDU2h8WjpiEJC/ekl+hv3DmO6ucA
         bE+w==
X-Gm-Message-State: APuU4Z8ZxjouQwPecVLBibC9gWZ3Z7r8lk4tHEJsz/NbPh5LgxMd2YNk
	NEj8pjtRqBvmW51t/3tYT69zoXF9jwOgnc9HqgCMTd/DPyvb+ub9kdRRZKpUcQ==
X-Gm-Gg: AYBFou1ek6DMnZrG6mMVlkCc5QyFx7rf1r3fayVUXWvnKx72NJ259Y6O4OSSpQebz8V
	bKqeUcoQEz0uTKdCnWAFOlNE9RmBFjeM5V5amF3E4xp/orOeQ8cBCmUh0HtMSVR/FiOs1Y2P7BV
	PRP5GFmHFOiOSQtyKlCLB87tQ/RcXAgJ/x2SRXEF+Q402pvkJ/BGO/jZuzKoFFrrQb8DOS8xhBx
	3eo1lYhofng8j1d03SAUyfamDsyUraK3LlLD1eCKL63tOh+voGTeH5qG7La4DunG8teslA4l1OR
	fYl7eOSSsX+qTqUXNWgVc/Nf+HHtuQl8J+E4uccNBGvbGFZCaL17LpuvyV8+aTTNycdSjrjDkeG
	Ctkl2gd/1tkAMKjIFm5NUaXmqhZoZgehFcPUOzXdMBdg45G9rs7c3DffeGwMYN2UO1gJxMwSegN
	54DdGQYyakzOnwPY+u2wJNpqhjuIYcGDrPtcahgPUvSb/hU2ov/p1YXUxpbpGvcUmpznR9z4gLM
	TS06THd+LFTGB6hxHHeyYb6aY9C/ilo6BhMTPhINrp+esRGX82KbZ46FyACXOcKvBy7foBO7e0y
	i61E3DiG3ZChkyp1vz0JuUr6CCTvgt+RHsBfzsQ3HDTIWNDhzWjAwhLd2xa58UDaN6diaWsbbNC
	KJSwFP3bTVnK2jS3TcHIokdAJIaobny/VXEl+mazTLjzsC7p2GzHu+rswWctqTyBq+6qjH45MHJ
	Z4Ofkm
X-Received: by 2002:a05:6102:5489:b0:7cc:80ba:5e5c with SMTP id ada2fe7eead31-7d2db16a05amr1779868137.6.1794244727830;
        Mon, 09 Nov 2026 09:18:47 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c5b2233sm21944e0c.10.2026.11.09.09.18.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 09:18:47 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v11 4/6] Bluetooth: L2CAP: Add MIC length validation for HDT PHY
Date: Mon,  9 Nov 2026 12:18:36 -0500
Message-ID: <20261109171838.1592267-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109171838.1592267-1-luiz.dentz@gmail.com>
References: <20261109171838.1592267-1-luiz.dentz@gmail.com>
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
the struct, so the shorter struct is still accepted by L2CAP and RFCOMM,
leaving mic_len unset, and values other than 32, 64 and 128 bits are
rejected.

The MIC length a channel requires is requested on the connection on
every path starting LE security, so LE Enable Encryption v2 asks for
it, while the MIC length the controller reports with Encryption Change
v3 and Encryption Key Refresh Complete v2 is kept separately, so a
request never stands for what is in use. When a connection is
encrypted on the LE HDT PHY with a MIC shorter than the channel
requires, the LE Credit Based and Enhanced Credit Based connection
requests are rejected with MIC Length Too Short.

The reported MIC length only applies on the LE HDT PHY, the MIC is
always 32 bits on the GFSK PHYs, so hci_conn_mic_len() reports it as
such both for the check and for BT_SECURITY.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/bluetooth.h |  1 +
 include/net/bluetooth/hci_core.h  | 14 +++++++
 include/net/bluetooth/l2cap.h     |  9 +++++
 net/bluetooth/hci_event.c         | 20 ++++++---
 net/bluetooth/hci_sync.c          | 15 ++++++-
 net/bluetooth/l2cap_core.c        | 67 ++++++++++++++++++++++++++++++-
 net/bluetooth/l2cap_sock.c        | 27 +++++++++++--
 net/bluetooth/rfcomm/sock.c       | 13 ++++--
 8 files changed, 152 insertions(+), 14 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index d59407349b3e..777bc1a0336b 100644
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
index 7a4f87236854..d2435bf49c5e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -765,6 +765,8 @@ struct hci_conn {
 	__u8		pending_sec_level;
 	__u8		pin_length;
 	__u8		enc_key_size;
+	__u8		mic_len;
+	__u8		req_mic_len;
 	__u8		io_capability;
 	__u32		passkey_notify;
 	__u8		passkey_entered;
@@ -2178,6 +2180,18 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 	(le_feature(dev, 1, 2) & HCI_LE_HDT_7_5_TX_FEATURE)
 #define hdt_pf1_capable(dev) \
 	(le_feature(dev, 1, 2) & HCI_LE_HDT_PF_1)
+/* BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 4, Part E, Section 7.8.24:
+ *
+ * The HDT_MIC_Length parameter indicates the MIC length to be used when the
+ * ACL connection is on LE HDT PHY.
+ *
+ * So the MIC length reported by the controller only applies on the LE HDT
+ * PHY, the MIC is 32 bits (0x00) on the GFSK PHYs.
+ */
+static inline __u8 hci_conn_mic_len(struct hci_conn *conn)
+{
+	return conn->le_rx_phy == 0x05 ? conn->mic_len : 0x00;
+}
 #define eks_capable(dev) \
 	(le_feature(dev, 1, 1) & HCI_LE_EKS_FEATURE)
 
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 54eddcdd341f..ff80238f3a51 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -285,6 +285,13 @@ struct l2cap_conn_rsp {
 #define L2CAP_CR_LE_SCID_IN_USE		0x000A
 #define L2CAP_CR_LE_UNACCEPT_PARAMS	0x000B
 #define L2CAP_CR_LE_INVALID_PARAMS	0x000C
+/* BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 3, Part A, Sections 4.23
+ * and 4.26: "Connection refused - MIC length too short" is 0x000C and "All
+ * connections refused - MIC length too short" is 0x0010. The LE Credit Based
+ * value is Invalid Parameters in the Enhanced Credit Based one.
+ */
+#define L2CAP_CR_LE_MIC_LEN_TOO_SHORT	0x000C
+#define L2CAP_CR_ECRED_MIC_LEN_TOO_SHORT	0x0010
 
 /* connect/create channel status */
 #define L2CAP_CS_NO_INFO	0x0000
@@ -533,6 +540,7 @@ struct l2cap_chan {
 	__u8		chan_policy;
 
 	__u8		sec_level;
+	__u8		mic_len;
 
 	__u8		ident;
 
@@ -981,6 +989,7 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 		    const struct sockcm_cookie *sockc);
 void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
 void l2cap_chan_rx_avail(struct l2cap_chan *chan, ssize_t rx_avail);
+void l2cap_chan_req_mic_len(struct l2cap_chan *chan, struct hci_conn *hcon);
 int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator);
 void l2cap_chan_set_defaults(struct l2cap_chan *chan, struct l2cap_chan *pchan);
 int l2cap_ertm_init(struct l2cap_chan *chan);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 9dc0e13ce7c1..dfd889e376aa 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3777,10 +3777,11 @@ static void hci_remote_name_evt(struct hci_dev *hdev, void *data,
 }
 
 /* key_size is the encryption key size of an ACL link reported by the event,
- * or 0 if it doesn't report it, in which case it is read.
+ * or 0 if it doesn't report it, in which case it is read. mic_len is the MIC
+ * length reported by the event, 0x00 (32 bits) if it doesn't report it.
  */
 static void hci_change_encrypt(struct hci_conn *conn, u8 status, u8 encrypt,
-			       u8 key_size)
+			       u8 key_size, u8 mic_len)
 {
 	struct hci_dev *hdev = conn->hdev;
 
@@ -3799,6 +3800,9 @@ static void hci_change_encrypt(struct hci_conn *conn, u8 status, u8 encrypt,
 			    conn->type == LE_LINK)
 				set_bit(HCI_CONN_AES_CCM, conn->flags);
 
+			/* A 32-bit MIC is reported as 0x00 */
+			conn->mic_len = mic_len;
+
 			/* For ACL links the encryption key size is still
 			 * validated below by hci_conn_enc_key_size_set(),
 			 * once known. It reports the final security level so
@@ -3915,8 +3919,10 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 	if (!conn)
 		goto unlock;
 
-	/* This version doesn't report the key size, so it is read */
-	hci_change_encrypt(conn, ev->status, ev->encrypt, 0x00);
+	/* This version doesn't report the key size, so it is read, nor the
+	 * MIC length.
+	 */
+	hci_change_encrypt(conn, ev->status, ev->encrypt, 0x00, 0x00);
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -3955,7 +3961,7 @@ static void hci_encrypt_change_v3_evt(struct hci_dev *hdev, void *data,
 	    ev->key_size >= 0x07 && ev->key_size <= 0x10)
 		key_size = ev->key_size;
 
-	hci_change_encrypt(conn, ev->status, ev->mode, key_size);
+	hci_change_encrypt(conn, ev->status, ev->mode, key_size, ev->mic_len);
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -5741,6 +5747,10 @@ static void hci_key_refresh_complete_v2_evt(struct hci_dev *hdev, void *data,
 	if (!conn)
 		goto unlock;
 
+	/* The key refresh may change the MIC length */
+	if (!ev->status)
+		conn->mic_len = ev->mic_len;
+
 	hci_conn_refresh_key(conn, ev->status);
 
 unlock:
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 93cd95ecf309..0926dc844b44 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -8670,8 +8670,21 @@ static void le_enable_encrypt_failed(struct hci_dev *hdev, __le16 handle)
 static int hci_le_enable_encrypt_v2_sync(struct hci_dev *hdev, void *data)
 {
 	struct hci_cp_le_enable_encrypt_v2 *cp = data;
+	struct hci_conn *conn;
 	int err;
 
+	/* Use the MIC length requested by the time the command is sent, as
+	 * channels may still raise it after it was queued, defaulting to 128
+	 * bits if unset.
+	 */
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, le16_to_cpu(cp->handle));
+	if (conn)
+		cp->mic_len = conn->req_mic_len ? conn->req_mic_len : 0x02;
+
+	hci_dev_unlock(hdev);
+
 	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_ENABLE_ENCRYPT_V2,
 				    sizeof(*cp), cp, HCI_CMD_TIMEOUT);
 	if (err)
@@ -8696,8 +8709,6 @@ static int hci_le_enable_encrypt_v2(struct hci_conn *conn, __le16 ediv,
 	cp->handle = cpu_to_le16(conn->handle);
 	cp->rand = rand;
 	cp->ediv = ediv;
-	cp->mic_len = 0x02; /* Always prefer 128 bits? */
-
 	/* The key is zero padded when shorter than 16 octets */
 	if (ltk) {
 		memcpy(cp->ltk, ltk, key_size);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 70ad30b091e4..d3b4153ee58e 100644
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
@@ -1025,14 +1026,26 @@ static inline u8 l2cap_get_auth_type(struct l2cap_chan *chan)
 	}
 }
 
+/* Raise the MIC length requested for the connection to the one the channel
+ * requires, so the next time encryption is started it asks for it.
+ */
+void l2cap_chan_req_mic_len(struct l2cap_chan *chan, struct hci_conn *hcon)
+{
+	if (chan->mic_len > hcon->req_mic_len)
+		hcon->req_mic_len = chan->mic_len;
+}
+
 /* Service level security */
 int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator)
 {
 	struct l2cap_conn *conn = chan->conn;
 	__u8 auth_type;
 
-	if (conn->hcon->type == LE_LINK)
+	if (conn->hcon->type == LE_LINK) {
+		l2cap_chan_req_mic_len(chan, conn->hcon);
+
 		return smp_conn_security(conn->hcon, chan->sec_level);
+	}
 
 	auth_type = l2cap_get_auth_type(chan);
 
@@ -1512,6 +1525,8 @@ static void l2cap_le_start(struct l2cap_chan *chan)
 {
 	struct l2cap_conn *conn = chan->conn;
 
+	l2cap_chan_req_mic_len(chan, conn->hcon);
+
 	if (!smp_conn_security(conn->hcon, chan->sec_level))
 		return;
 
@@ -1579,6 +1594,18 @@ static bool l2cap_check_enc_key_size(struct hci_conn *hcon,
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
@@ -5119,6 +5146,7 @@ static int l2cap_le_connect_rsp(struct l2cap_conn *conn,
 		/* We'll need to send a new Connect Request */
 		clear_bit(FLAG_LE_CONN_REQ_SENT, &chan->flags);
 
+		l2cap_chan_req_mic_len(chan, hcon);
 		smp_conn_security(hcon, chan->sec_level);
 		break;
 
@@ -5268,6 +5296,11 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 
 	l2cap_chan_lock(pchan);
 
+	/* Record the MIC length the channel requires before checking the
+	 * security, so encryption started for it requests that.
+	 */
+	l2cap_chan_req_mic_len(pchan, conn->hcon);
+
 	if (!smp_sufficient_security(conn->hcon, pchan->sec_level,
 				     SMP_ALLOW_STK)) {
 		result = pchan->sec_level == BT_SECURITY_MEDIUM ?
@@ -5283,6 +5316,20 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 		goto response_unlock;
 	}
 
+	/* BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 3, Part A,
+	 * Section 10.1:
+	 *
+	 * If an L2CAP_LE_CREDIT_BASED_CONNECTION_REQ packet is received
+	 * and the encryption key size is long enough but the MIC length is
+	 * too short, then the connection shall be rejected with a result
+	 * value of "Connection refused - MIC length too short".
+	 */
+	if (!l2cap_check_mic_len(conn->hcon, pchan)) {
+		result = L2CAP_CR_LE_MIC_LEN_TOO_SHORT;
+		chan = NULL;
+		goto response_unlock;
+	}
+
 	/* Check for valid dynamic CID range */
 	if (scid < L2CAP_CID_DYN_START || scid > L2CAP_CID_LE_DYN_END) {
 		result = L2CAP_CR_LE_INVALID_SCID;
@@ -5494,6 +5541,11 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 
 	l2cap_chan_lock(pchan);
 
+	/* Record the MIC length the channel requires before checking the
+	 * security, so encryption started for it requests that.
+	 */
+	l2cap_chan_req_mic_len(pchan, conn->hcon);
+
 	if (!smp_sufficient_security(conn->hcon, pchan->sec_level,
 				     SMP_ALLOW_STK)) {
 		result = pchan->sec_level == BT_SECURITY_MEDIUM ?
@@ -5501,6 +5553,18 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 		goto unlock;
 	}
 
+	/* BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 3, Part A,
+	 * Section 10.2:
+	 *
+	 * If the encryption key size is long enough but the MIC length is
+	 * too short, then the connection shall be rejected with a result
+	 * value of "All connections refused - MIC length too short".
+	 */
+	if (!l2cap_check_mic_len(conn->hcon, pchan)) {
+		result = L2CAP_CR_ECRED_MIC_LEN_TOO_SHORT;
+		goto unlock;
+	}
+
 	/* Check if the listening channel has set an output MTU then the
 	 * requested MTU shall be less than or equal to that value.
 	 */
@@ -5697,6 +5761,7 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 			/* We'll need to send a new Connect Request */
 			clear_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags);
 
+			l2cap_chan_req_mic_len(chan, hcon);
 			smp_conn_security(hcon, chan->sec_level);
 			break;
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 7a2551ef7f50..8609cde925b4 100644
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
 
@@ -972,7 +981,18 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
+		/* BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 4,
+		 * Part E, Section 7.7.8: MIC_Length 0x00 is 32 bits,
+		 * 0x01 is 64 bits and 0x02 is 128 bits; all other
+		 * values are reserved for future use.
+		 */
+		if (sec.mic_len > 0x02) {
+			err = -EINVAL;
+			break;
+		}
+
 		chan->sec_level = sec.level;
+		chan->mic_len = sec.mic_len;
 
 		conn = l2cap_chan_conn(chan);
 		if (!conn)
@@ -980,6 +1000,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		/* change security for LE channels */
 		if (chan->scid == L2CAP_CID_ATT) {
+			l2cap_chan_req_mic_len(chan, conn->hcon);
 			if (smp_conn_security(conn->hcon, sec.level)) {
 				err = -EINVAL;
 				break;
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 3fb8b5474948..3ec2fb4ce580 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -700,9 +700,16 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		sec.level = BT_SECURITY_LOW;
+		/* mic_len was added at the end of struct bt_security, so
+		 * accept the shorter struct as well. RFCOMM ignores it.
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
 
@@ -844,8 +851,8 @@ static int rfcomm_sock_getsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
+		memset(&sec, 0, sizeof(sec));
 		sec.level = rfcomm_pi(sk)->sec_level;
-		sec.key_size = 0;
 
 		len = min(len, sizeof(sec));
 		if (copy_to_iter(&sec, len, &sopt->iter_out) != len)
-- 
2.56.0

