Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794002267;
	b=kI+mFkOpNeB+ROz7s+W7qf/3/V5DIWEl3Scna7W7Skud/Yr4HFKXzU5DW9Kx9/yfw80O
	 I50/vLT8GpqyXnZnWHnRNV1zpJ09UngMBYR0/S5Kri7KmPLzTQkW9j7tXXY1KOfmzXpO6
	 kkenW1ZGTwAXPGLRqWdkBpfIoEQIBYnIXl5dB8339sINpYJlQ1tV/wqcaeB+Z93PL4hJr
	 ntkdGx3fA8Z/930aqGm3qCaWat9hKaMoiKAUBggJ8bhCpFAgRz0M5HiQ+n605z3B6LujS
	 RjlW+RGgdpekvWj8Sh2NVislWxr7SrjEuAGxnXbUiWEQIeANTQT+j5RI7IRo8+1FC5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794002267;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uuC6wDvKvC9UPRzrKmnsdAzjdbEOaoXDpySTnK3OeFA=;
	b=VeiwURCQfKs109qOjm937XX97qTAwqvUtuiQ/0W6HbAeUrnsbHQ92njD2rjBe6ki7J7Y
	 7NRVfIrFIEmNDI5oRMbRrls+EsdLTUMRWpor0VkmyYQ4OUOlS7lI5buvU1LkaM2KsRCWl
	 5xNxYlwnpKrUSBDsoXvONj+0/LhHePPaoxwjrY1LRjigJMdx+OzhFsUvY+ovR/y54DGIc
	 2YJiIl+imr0EbLM7LPwBbFjCxVD4gECEw0niMISYZ9P+LmaL8mqSwJ3jHa7T63ZOi3Rh/
	 smBeXVWVJ1+4yeykqkfYHrURXIBOy9ZYFyUbyLLrjNAEoNQ02S6Q4SULkvkmnqBkXpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q5dHREts;
	arc=none smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DE6606D816
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 21:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8DE6606D816
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q5dHREts
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5eaabf28c06so846925e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 13:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794002266; x=1794607066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uuC6wDvKvC9UPRzrKmnsdAzjdbEOaoXDpySTnK3OeFA=;
        b=q5dHREtsSEH3iBztF7lx3YRAizfpjJ0EjR5AG4Fon/29Gv1D35BUshVB+amIWEBRSz
         w+Tfh/AzYD9l4H/5JUxVgHZbn81CcLIucsw64BmSwfxDaFuTvbjyks1jAKlxhecflj2n
         L3HIheG8/LWlHJEy44K8cwvLtm9cu3wr/jPYnXMz568d0n2cZmk3RWmjb+9LLx2rXZ5L
         U96fiyfoQQOI2yd4Dd3slUfCPkBSJJpPelTvQ/XPMHKKOnD6ICClnlyyO6ODQVqtgVJC
         Kqng4dDtnt94n6M/VBVKu45YhvGDV03aCcJ4okFpVispdR7mVCK/cneKoj7ewD2UsE7C
         mrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794002266; x=1794607066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uuC6wDvKvC9UPRzrKmnsdAzjdbEOaoXDpySTnK3OeFA=;
        b=VdDGQf5NolQJ2vjrAanFsEaNGSZONN5CskYhqLXA4l8UCSsWChQg1tiErBc+Q5phxD
         JQJ52uNuKHDtKzHoy2BO5o/BdsZYySubcxUixJkT+hJBEFjY9cztm9GiJjPYiuoGRC+F
         3pCjpwAqYcIeyFqLjOAZNJNUPMXPm/SYtnqQ6ZVPITFyDxoricWG4oojYoebRAQno58T
         oxId4kx+G3/NPbOlBn4ydTQC6YqZVD6za+2xx724HQMa6DGPynt6+xgPoqNme98nWWlY
         WPodTRtEWGFL7uPB04P+Q8XdTMd+UnFHgXkn4n7EjFB8/GXUjjMscvXIMKWMxZB5Wf0k
         /M0w==
X-Gm-Message-State: APuU4Z+e0qm5A3iwySSxcyZ/X2f6nTwFrfkxdYLpdKB0VhAlcg8r9+Mt
	B21la2oRIs/8ZBtx2ZXLsiUW7HvaMu95f1WU/QncbHR5vqtYBTdL7xuvSqSdMw==
X-Gm-Gg: AYBFou3K9YFUCd7clk9evOz5ZFUMoLGnQyR9dly0KEAifd+ktKn8WEfG7nuRdyvWAjM
	hwhJ6we/+uD+dOJGeWUq7ATqPfoUpdEfpq3lzW8MIyPLYx0gmVHtyfyTezPCJdy2GQMApOAOHH4
	dfUsCo8lEo741UHY9FmrVo3s8Ezqa5GYcH9qFVfF7LKY9QLkdFTUlokbEMwsOdhe2URRJzw6ggn
	ppw9nmLKlmOwFVcL53G2isSC8bjWMEpdz1+0qt5roO8bP9vrG0X/jzh4H/2uM0V0Yk8itTTO/Vh
	TuebsE/A+X1U974hhg0iEOHn2AK7Q3XfpKwPu8Zy00vOTgGYwD2o+B+SwMSitVbZAzqT10KBE5c
	QFQ/6y5qZIUfiJEkVL60kn2mWjQjBHvV8SDBdTVMM1akBwdNmDI94klOZwl3GuzP8EnEYy7qPRe
	p1UGNCit2CnMPxCLgmWLkoN7jc0mc+RJSOzxeTHpkGnECOCdr/j3TyGWnI3+aaBJtOrfv77KPlM
	vCM9EYHchJvzK4Nz3E/8hQrDyRJdhW2yGVql2koOrfHLC/bcL38odRbz946K7VPLrM6b5dWe8mA
	Pau6bdKUmkwQAFjgBy/x9yetzaE0/4i9BPlXwIVfur/jRlWhOYBZ5aosXXUVRPujL/dgAebsRkc
	U2RToDRBdeEdsQ5wNKB9LlofJXUbRf1mlAffVFSrAjJ8bxLrsV3QMzvKUXsKWMqFeGQCEk7IswM
	quLoY=
X-Received: by 2002:a05:6122:17a5:b0:5ec:c180:e1a1 with SMTP id 71dfb90a1353d-5ecc42de36emr2089406e0c.2.1794002265687;
        Fri, 06 Nov 2026 13:57:45 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc64a6103sm2542570e0c.6.2026.11.06.13.57.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 13:57:45 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v9 4/6] Bluetooth: L2CAP: Add MIC length validation for HDT PHY
Date: Fri,  6 Nov 2026 16:57:36 -0500
Message-ID: <20261106215738.3562688-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106215738.3562688-1-luiz.dentz@gmail.com>
References: <20261106215738.3562688-1-luiz.dentz@gmail.com>
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
index ca4f9780beda..3e6a0e9f66fc 100644
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
index 06b54857fd91..b892aef12121 100644
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

