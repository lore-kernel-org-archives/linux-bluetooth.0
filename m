Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793830409;
	b=V5evKvD2+kaKO4l6goh63iw+43d4+ddmoWGatP9wtBB7Iu/NjRW1ku8QVAt6WiSWGx9u
	 g08tZkJ4oCM56r/Iwcc6Gt0ceDHfweLJVspQUJp74eyPUN3g+U4HPSLiCMUzkNUKbBKNN
	 Y2h7Rj8Nup/ZfnBaKL3Si/BgZ8NT5FkTzsL+1dp1hTwcjswSsl+3zh9SJ9I6OLPflmu32
	 wZMfXfezAqPGTvKju8Pjzm50z53f8PGxTbCp9NQZf3NmoTsWn2wLe0DfVXLbxQxHszzNt
	 X7IegTnH2Ae4qKpFn1ReBnU6NF1VBUN0kTTRnxFhTXEOnyBFoVdj6Gx9Ak092wvUdkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793830409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LcAevmfxzHbNb5gMaASJwyzL6KwobYxMEoyB3np+C7g=;
	b=Yq/sskiNKQSCU81JU2YtdQ1pw02k2N09h4LoRIEtd4kpsw2pqxK947DIOYUNfvt/OYkq
	 z8dWBGB+iSbPqTup66/hy4Z44fydDOLmLTSahf1NFHDlUYyQFp+QFGU4j5wHTWOc+HBnk
	 wVnM4VC1w+RnDpc1AJLitR59obAaP5GFHp5Z3iHACPrPk7cKfO8RFT5fS6oYy/A7UE0wE
	 +quI2iyZO4Oh6OdvkCkZRP+MIvOLYOTS9EZsz+ABAEKVfuG/ht3gQyYI6O7XRn/oYSpIF
	 wXHqLVwD7lxFvKMipdiBzn6vrECQ4+IxjKeqDdzQa3Nq11JQ6Sl5zLmYD9mZALnUbFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dlYutXT4;
	arc=none smtp.remote-ip=209.85.222.41
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F98A6070330
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 22:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F98A6070330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dlYutXT4
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-97ca72f2cd9so590548241.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 14:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793830408; x=1794435208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LcAevmfxzHbNb5gMaASJwyzL6KwobYxMEoyB3np+C7g=;
        b=dlYutXT4L5yxaj3QZC+fBZTvkSSSf8U8l93wBn9vYx1UT0XFMfOb1eUqXQV4py0Tqw
         IAZ2YMTFev2NvKRZzv4f2cLKAqXFX0ZKDkdzNqXCblp9or5GJAkyvIryaUMGX0iSMaPt
         WEwpOJ7+PTUAe3gyBBjxcu00JAE0yZWCdMrzqQ0wtrqrRT7OQCZGxa/vyJUfqjVSAe6X
         Wpey7wKOudJdP4G+tn3I+YH2oEE9LIHcLBfbfP/5lnhXywwfzgbohTPhny/bnzjgW8vl
         +ATMinLscrETBNKAYO8wlaFCq+LczyvyCiyRF14hfQFTo8rWUo3OvOYaCuPXfboVn0NQ
         +wcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793830408; x=1794435208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LcAevmfxzHbNb5gMaASJwyzL6KwobYxMEoyB3np+C7g=;
        b=E9hTfjIBoX5ClOJwAaoXGNvIN+B3QLxnWlRVhliy/BtycDJM1uIncCRAfBdKTtgP5G
         OWWNDhJlmAB9wKQyZt8I/6U/Zclj6Pex8ysoodr65ZG9DDezxBL2cYFDc4v+kJVjxRPJ
         fZ639Jfj8rALWYhy0oaUw/CvaV3c2DWIXSnGAk2CHp8F5Ck7lzyaQcdLsaGHOQUErSlS
         9zaVJXcixS3KeHwdTu0cTtgwJ7gTeJF2iCy1v6dN1WRzumSaPfMiZhPlrziqE5ueVr0O
         1srddIR7zsRWsgTPXs9SBQGAPmJ6KuzeYxA5Ke0veJBb2U9GYwiOQpXRP8PlW2UCPxHS
         QAhQ==
X-Gm-Message-State: APuU4Z8vvJss+SUFsnr4Nt2mULlw33TL29ZShjCVbi7XGct42EKioh03
	D/qpx8fVsWIfbaHe+ikB7oMIEeNOzL928itwUWlsr6sT+aAy/tBllEQzU0yXEA==
X-Gm-Gg: AYBFou3IjAvo3BLcKf0YJE0k7EuYN0cLcKIZ8aLQiTnJdpByR3BniUhAFTGUH1P78JQ
	R3MKYP8JfoDxxLjr86embGxZcxunFB6Ygg/Udf8w8uqVqCMiLLSjVKBRkAeK415Zb1/9n6WflI6
	hAqWovsl56ZeZprU2JfCPS1Isy9tefvFb/qtKNRqiIZAAuEpit/06zcSqXMqOJOzKn1ckiVd48/
	oG4xC+s5GT15NXUan/EhXMjQIyoWzSHW3EgrgOSkWF2FOjAYWauBucme8ciHqEjvk3KbbJsIzPK
	5PDa+IaVWcxsi6MJZ6bYiSoVAJGx4G+bqr8qhHS6d3iw+ib9gwp2UrCkqMnoOhecX9DtJQK34MZ
	hLrsakt8mO/DJ0WBVzrfsGXgBq+Udw7AYzCbgw40PEZP+hM98zApl/jSRg68bHOD3Wyq/fGXSvH
	dZnnfluExzZWp97Qdoy6jbYHu8E3hpi8pdabT+Jd6NgnsnJ6moL1FYHhXuBS5kbaR24R1Km0caW
	ntiBwgboEOWY1rN4oLvOEAixmCJ1tEsgC24LW/XoRpG0srK3BsUzygjBBu0XnuYSV5aryhrZGrV
	HkaqFwDBXFm/mgFA0BHbYCzVeuXWhWZb/iIOuW/JvlunZQyk1FhoLfEQtJ+OnYmE4Taq1ho9lbr
	RWL5vpTWYUshhc6U0k1dz6yWpQDopatkrJ80RLAhc/Zw2qOnuGzDyRe333eUsiu4r3+Ck0Qlwq3
	D3YeFa3INF8fYpwO1FMsnfQP+F
X-Received: by 2002:a05:6102:15a2:b0:7ce:62a0:6a14 with SMTP id ada2fe7eead31-7d07262d5d7mr7503840137.9.1793830408092;
        Wed, 04 Nov 2026 14:13:28 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998da178b59sm2934001241.12.2026.11.04.14.13.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:13:27 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 4/6] Bluetooth: L2CAP: Add MIC length validation for HDT PHY
Date: Wed,  4 Nov 2026 17:13:19 -0500
Message-ID: <20261104221321.1200529-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104221321.1200529-1-luiz.dentz@gmail.com>
References: <20261104221321.1200529-1-luiz.dentz@gmail.com>
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
 include/net/bluetooth/hci_core.h  |  9 +++++++
 include/net/bluetooth/l2cap.h     |  7 +++++
 net/bluetooth/hci_event.c         | 19 ++++++++++---
 net/bluetooth/hci_sync.c          |  5 +++-
 net/bluetooth/l2cap_core.c        | 44 ++++++++++++++++++++++++++++++-
 net/bluetooth/l2cap_sock.c        | 23 +++++++++++++---
 net/bluetooth/rfcomm/sock.c       | 13 ++++++---
 8 files changed, 110 insertions(+), 11 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 03530dab8b3a..fbec6c0f233d 100644
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
index 09a603dc43e0..d08bca919793 100644
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
@@ -2176,6 +2178,13 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 	(le_feature(dev, 1, 2) & HCI_LE_HDT_7_5_TX_FEATURE)
 #define hdt_pf1_capable(dev) \
 	(le_feature(dev, 1, 2) & HCI_LE_HDT_PF_1)
+/* The MIC length reported by the controller only applies on the LE HDT PHY,
+ * the MIC is always 32 bits (0x00) on the GFSK PHYs.
+ */
+static inline __u8 hci_conn_mic_len(struct hci_conn *conn)
+{
+	return conn->le_rx_phy == 0x05 ? conn->mic_len : 0x00;
+}
 #define eks_capable(dev) \
 	(le_feature(dev, 1, 1) & HCI_LE_EKS_FEATURE)
 
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 54eddcdd341f..7eda42071b06 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -285,6 +285,11 @@ struct l2cap_conn_rsp {
 #define L2CAP_CR_LE_SCID_IN_USE		0x000A
 #define L2CAP_CR_LE_UNACCEPT_PARAMS	0x000B
 #define L2CAP_CR_LE_INVALID_PARAMS	0x000C
+/* MIC Length Too Short has a different value in each response: the LE Credit
+ * Based value is Invalid Parameters in the Enhanced Credit Based one.
+ */
+#define L2CAP_CR_LE_MIC_LEN_TOO_SHORT	0x000C
+#define L2CAP_CR_ECRED_MIC_LEN_TOO_SHORT	0x0010
 
 /* connect/create channel status */
 #define L2CAP_CS_NO_INFO	0x0000
@@ -533,6 +538,7 @@ struct l2cap_chan {
 	__u8		chan_policy;
 
 	__u8		sec_level;
+	__u8		mic_len;
 
 	__u8		ident;
 
@@ -981,6 +987,7 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 		    const struct sockcm_cookie *sockc);
 void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
 void l2cap_chan_rx_avail(struct l2cap_chan *chan, ssize_t rx_avail);
+void l2cap_chan_req_mic_len(struct l2cap_chan *chan, struct hci_conn *hcon);
 int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator);
 void l2cap_chan_set_defaults(struct l2cap_chan *chan, struct l2cap_chan *pchan);
 int l2cap_ertm_init(struct l2cap_chan *chan);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index fb30615db02a..e826809f8c75 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3760,7 +3760,8 @@ static void hci_remote_name_evt(struct hci_dev *hdev, void *data,
 	hci_dev_unlock(hdev);
 }
 
-static void hci_change_encrypt(struct hci_conn *conn, u8 status, u8 encrypt)
+static void hci_change_encrypt(struct hci_conn *conn, u8 status, u8 encrypt,
+			       u8 mic_len)
 {
 	struct hci_dev *hdev = conn->hdev;
 
@@ -3779,6 +3780,14 @@ static void hci_change_encrypt(struct hci_conn *conn, u8 status, u8 encrypt)
 			    conn->type == LE_LINK)
 				set_bit(HCI_CONN_AES_CCM, conn->flags);
 
+			/* The key size of Encryption Change v3 is not used:
+			 * it is ignored for LE, where it comes from SMP, and
+			 * the ACL key size is read below.
+			 *
+			 * A 32-bit MIC is reported as 0x00.
+			 */
+			conn->mic_len = mic_len;
+
 			/* For ACL links the encryption key size is still
 			 * validated below via hci_read_enc_key_size(). Its
 			 * completion handler, hci_cc_read_enc_key_size(),
@@ -3888,7 +3897,7 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 	if (!conn)
 		goto unlock;
 
-	hci_change_encrypt(conn, ev->status, ev->encrypt);
+	hci_change_encrypt(conn, ev->status, ev->encrypt, 0);
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -3908,7 +3917,7 @@ static void hci_encrypt_change_v3_evt(struct hci_dev *hdev, void *data,
 	if (!conn)
 		goto unlock;
 
-	hci_change_encrypt(conn, ev->status, ev->mode);
+	hci_change_encrypt(conn, ev->status, ev->mode, ev->mic_len);
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -5694,6 +5703,10 @@ static void hci_key_refresh_complete_v2_evt(struct hci_dev *hdev, void *data,
 	if (!conn)
 		goto unlock;
 
+	/* The key refresh may change the MIC length */
+	if (!ev->status)
+		conn->mic_len = ev->mic_len;
+
 	hci_conn_refresh_key(conn, ev->status);
 
 unlock:
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index f5083823223c..d79aef0c8468 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -8644,7 +8644,10 @@ static int hci_le_enable_encrypt_v2(struct hci_conn *conn, __le16 ediv,
 	cp->handle = cpu_to_le16(conn->handle);
 	cp->rand = rand;
 	cp->ediv = ediv;
-	cp->mic_len = 0x02; /* Always prefer 128 bits? */
+	/* Use the MIC length requested for the connection, default to 128
+	 * bits if unset.
+	 */
+	cp->mic_len = conn->req_mic_len ? conn->req_mic_len : 0x02;
 
 	/* The key is zero padded when shorter than 16 octets */
 	if (ltk) {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 70ad30b091e4..b19dd027adc3 100644
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
 
@@ -5283,6 +5311,13 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
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
@@ -5501,6 +5536,12 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 		goto unlock;
 	}
 
+	/* Check if MIC length is sufficient */
+	if (!l2cap_check_mic_len(conn->hcon, pchan)) {
+		result = L2CAP_CR_ECRED_MIC_LEN_TOO_SHORT;
+		goto unlock;
+	}
+
 	/* Check if the listening channel has set an output MTU then the
 	 * requested MTU shall be less than or equal to that value.
 	 */
@@ -5697,6 +5738,7 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 			/* We'll need to send a new Connect Request */
 			clear_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags);
 
+			l2cap_chan_req_mic_len(chan, hcon);
 			smp_conn_security(hcon, chan->sec_level);
 			break;
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 7a2551ef7f50..2fa93e84dc91 100644
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
 
@@ -972,7 +981,14 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
+		/* MIC_Length values: 32, 64 and 128 bits */
+		if (sec.mic_len > 0x02) {
+			err = -EINVAL;
+			break;
+		}
+
 		chan->sec_level = sec.level;
+		chan->mic_len = sec.mic_len;
 
 		conn = l2cap_chan_conn(chan);
 		if (!conn)
@@ -980,6 +996,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 
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

