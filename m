Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981559;
	b=ehBQI050RxakRAoKr5PnEqcNnPXR6boUGBX7xK6X3bmWf2eTPln4UtudeH9/9S3FIMSm
	 WFEGJTVBDVQMTCdFu8bcwW3vVC4use5lfAHq37XJK7hCnUjQv/ZR/6q6tQuzCkaO4TaxX
	 cFlLKWyqS8PTrsS6YFyP9wMG3/pysUlxbF3jKCHRGg4cdGRgcs8KxULwbCqHYFwtWDQvu
	 SfMjdbLo56e0XGyRo+fw1EeS8XDsMXSnSBDPrPBFExsMxf4XGLb0A++mHlbxOwrigEUTf
	 HhNmIEBLumx0H5r0EC4O6tXRJtJPDWHbbcTW+/JPwpS+2XjL6LI072xF0ODwqF6e2PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981559;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WuvN2CTOm1zQotmXjAeuNjnDDydokF8UdAIJ485raCs=;
	b=3B3y9cTB5rBNtTU0WuiNGBBWWFU+ghC0UT40Pk5I8EtRWN6Xmvd8x4r8QQy/JNDe9CBS
	 32EHh9MJ+nkaYQkHzeRdiFcwMhf9wkTYd7hnwgvNSXi6fCslsSKx7t/lY87gG893vgcR9
	 /ZbNOOmqR+Yo3qpUd3WKdvwhHFokYAc2+FgRI7qVc0+vnqtx/uj03sbCl1MPfp4WnK/u7
	 6kHO//J4fl4tN001J/fkTZ0OhhUZJgLfWc9rB7enbT7XMB3fq1OeEh5o0lT7rGbzuArbp
	 8EUvenLjXj+B2OG8WBWsZAQfmeevnEATT539H5yJqJfGLOI3e4KqAWd88zRoQmO9buA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n0f6xuM8;
	arc=none smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E22606A98B
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 16:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47E22606A98B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n0f6xuM8
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5eaefe5b523so655057e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 08:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793981558; x=1794586358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WuvN2CTOm1zQotmXjAeuNjnDDydokF8UdAIJ485raCs=;
        b=n0f6xuM87jPzegqAMpKys/iDui94dcHnYfAO8dWerR7fUosYme+A8HUMrItRn81vye
         g+E9AdsAG0eLb+HkhL3DWy1Oz3l8X/tzX3fScwCgRd1+PxN972BkT8NvtLfS+LdvvPRr
         pccqi6ILbyGv5iq+bGmmcpAhgeiu5McWixApu8Ga/mvpgcW6PJrXBpg6LZ8gB1GCeDDR
         0D1Inp1tS/czGfHXZHCoHC7YbzhV80dTZMF84GA8m2lTExAKYUEObzRDuqN4et3s7Gy4
         bWZV4ZFHGU7eJ2n3A2seNHm2LsAEpztwBuAeKhf087pkrYEpu2uCgXlgD+PmKXHdUmP/
         I09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793981558; x=1794586358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WuvN2CTOm1zQotmXjAeuNjnDDydokF8UdAIJ485raCs=;
        b=jku510/4bbNP06rxzKp1LRSi3CzkSQgZXD32JCHkQ7jUcQ79PEl1JuoRvz9PnqyMks
         SN6DxHUhCDro99V88Yhh1GcWPTA97ZbVwZZpwFncKdqV60O7smQuGI1O/nH47EzXvpwO
         e1BzcSEaeSqPii+jddnUS+E7rt7xS+nZkcnuGuPBXAG2WPs2j3cHpNTmbN4v1YDu0g0Z
         iveZqINhO4aYtXPSBAiT9ESnKNKvDNPT3RRHjtpJ3/QiQE00bgZ+6jhTyFys6VM5gJHk
         q2dTOeGwAPgo3L7xa72A3CH+mC+yUEfMwYtdLsGIN+An6hZCUeFD5AIM5Wb0VQW7gINe
         UhVg==
X-Gm-Message-State: APuU4Z8RRDuV0v6HOzMrsfS+U86HO+qM2QhEEKuImcMGHtPZwfC9F6Hy
	tH5UYCfnASVuxI5TICcklYGGXC+5rgK+N1Vl4tHO8WzDEx0gLUVO7vzTDch8yA==
X-Gm-Gg: AYBFou1+Hx8dIiNgE8waEnA4u2hlaGz8pRTPQSme5l0h/SZp3VuvwXvuZ9pVGLU3RIk
	iDXpLWisEv42y87DRqdQa7V0agYiBWBpq9A4rIpwV15bK51Ulj0SO3FUS0JrstCbwUyt6L8AAmf
	6Zl1BLfkdvnSVkQG7AV+UBiVHbkAu2Qd1+J4tuW/98S4CNa/FeqLDkyQxIzLqhu1fCnOEwwafWt
	5qripyc/2BgcJHsaDhWXGeNC4kkKl/0irIu3oW8pAZOBDAr/NlaKyci/FdLr6tmcP0O7KPw1mj1
	1Aa63UD4vibJCuODDXMzk8dHnslHf9ZMWfwizwqx1/FnQH8PytwIYDNoP/uVVwtozDX5sQujvLI
	0ReBBUS9mgwMO2PH09MHl7brbv3qXZuONE6jAHmW4rh8jgBylT/06pgIJ+qNdsp4wPyZOIApIU7
	ff/ZSLqI2K7/MP1CNRvFzzZeKr21GS+wrpTn9hjXC2/AjUNVVh7f5C1JnpOAUUj8sMgBsOwRWog
	QLEhaPX4I03B2DvRFLszk5PyhOpvQ0J4tmzaZ1C+P5O8ZOKWnoABWgHnbx7prFVnqBG8T7MMEmL
	vLVWmMW76fPbjKtOCCev5f6bLD5dTbJyF2DOKdknSEQhgV/HGDKFgXls/eSgVOWGXbDg8BbnCFG
	Rqq94wWqo7Dix+WXJF5tkEIYLUoD+YsY30GwzyPex+TiVSU/LryrvD5e3jnvrz7qgKhFZCrmr7l
	Z4iPw=
X-Received: by 2002:a05:6122:1d04:b0:5ec:4653:2431 with SMTP id 71dfb90a1353d-5ecc43ea226mr1587055e0c.15.1793981557841;
        Fri, 06 Nov 2026 08:12:37 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc64ee921sm1689697e0c.12.2026.11.06.08.12.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 08:12:37 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 4/6] Bluetooth: L2CAP: Add MIC length validation for HDT PHY
Date: Fri,  6 Nov 2026 11:12:25 -0500
Message-ID: <20261106161227.2814291-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106161227.2814291-1-luiz.dentz@gmail.com>
References: <20261106161227.2814291-1-luiz.dentz@gmail.com>
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
 include/net/bluetooth/hci_core.h  |  9 ++++++
 include/net/bluetooth/l2cap.h     |  7 ++++
 net/bluetooth/hci_event.c         | 19 +++++++++--
 net/bluetooth/hci_sync.c          | 15 +++++++--
 net/bluetooth/l2cap_core.c        | 54 ++++++++++++++++++++++++++++++-
 net/bluetooth/l2cap_sock.c        | 23 +++++++++++--
 net/bluetooth/rfcomm/sock.c       | 13 ++++++--
 8 files changed, 129 insertions(+), 12 deletions(-)

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
index 7a4f87236854..fb4f6735f69b 100644
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
@@ -2178,6 +2180,13 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
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
index 0979a4ff677a..dce2dd56ff01 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3762,7 +3762,8 @@ static void hci_remote_name_evt(struct hci_dev *hdev, void *data,
 	hci_dev_unlock(hdev);
 }
 
-static void hci_change_encrypt(struct hci_conn *conn, u8 status, u8 encrypt)
+static void hci_change_encrypt(struct hci_conn *conn, u8 status, u8 encrypt,
+			       u8 mic_len)
 {
 	struct hci_dev *hdev = conn->hdev;
 
@@ -3781,6 +3782,14 @@ static void hci_change_encrypt(struct hci_conn *conn, u8 status, u8 encrypt)
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
@@ -3890,7 +3899,7 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 	if (!conn)
 		goto unlock;
 
-	hci_change_encrypt(conn, ev->status, ev->encrypt);
+	hci_change_encrypt(conn, ev->status, ev->encrypt, 0);
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -3910,7 +3919,7 @@ static void hci_encrypt_change_v3_evt(struct hci_dev *hdev, void *data,
 	if (!conn)
 		goto unlock;
 
-	hci_change_encrypt(conn, ev->status, ev->mode);
+	hci_change_encrypt(conn, ev->status, ev->mode, ev->mic_len);
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -5696,6 +5705,10 @@ static void hci_key_refresh_complete_v2_evt(struct hci_dev *hdev, void *data,
 	if (!conn)
 		goto unlock;
 
+	/* The key refresh may change the MIC length */
+	if (!ev->status)
+		conn->mic_len = ev->mic_len;
+
 	hci_conn_refresh_key(conn, ev->status);
 
 unlock:
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 52cf63bdf01c..fb6683ff7501 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -8654,8 +8654,21 @@ static void le_enable_encrypt_failed(struct hci_dev *hdev, __le16 handle)
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
@@ -8680,8 +8693,6 @@ static int hci_le_enable_encrypt_v2(struct hci_conn *conn, __le16 ediv,
 	cp->handle = cpu_to_le16(conn->handle);
 	cp->rand = rand;
 	cp->ediv = ediv;
-	cp->mic_len = 0x02; /* Always prefer 128 bits? */
-
 	/* The key is zero padded when shorter than 16 octets */
 	if (ltk) {
 		memcpy(cp->ltk, ltk, key_size);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 70ad30b091e4..04a32c2d62ff 100644
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
@@ -5283,6 +5316,13 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
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
@@ -5494,6 +5534,11 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 
 	l2cap_chan_lock(pchan);
 
+	/* Record the MIC length the channel requires before checking the
+	 * security, so encryption started for it requests that.
+	 */
+	l2cap_chan_req_mic_len(pchan, conn->hcon);
+
 	if (!smp_sufficient_security(conn->hcon, pchan->sec_level,
 				     SMP_ALLOW_STK)) {
 		result = pchan->sec_level == BT_SECURITY_MEDIUM ?
@@ -5501,6 +5546,12 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
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
@@ -5697,6 +5748,7 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
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

