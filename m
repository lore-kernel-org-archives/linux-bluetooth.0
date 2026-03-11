Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB69356A3C
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245778; cv=pass; b=t9GsyHodboTTCrn6bN8KyTbZRGVlOQ0IrqTEGfXAHBFPkIBxZX5FkbU9oYCSMctd7qdd8Xnl3AumKBLFYufzFA7OgvcB+DR+lZhBhFeaC76pusk0MUiy3ds+nP3pXc24F5WW/XDbhN5W+Rk8RcLTB1TM7IE0iYCSLeLayrASEjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245778; c=relaxed/simple;
	bh=lyIlHPK7rpTzxJcT7qJzJhyzLBHWdLwWnpYk5J2EPjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/KVXlGMg2+f0/aS1ZpSDnJahYsIMJ90Z/c18TvLnYpKhjklz2n9pBtTRjfNcXuVch1vlpNdqcJ4mY7W38c7q6nNz1FF3pN5I4K1pu87oUwWWYLuQQCQ8Mi4AIA4OC+9uF6wx9yXX5sTtuawem6WXI3njiwDxQiR6vtzrWhWdqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=iY564kzR; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="iY564kzR"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fWG8750xdzyXV;
	Wed, 11 Mar 2026 18:16:07 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1773245767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z5kmTSBnOUZT3j/by2tXBX7oeCCj2tZSRi3caiY2YFg=;
	b=iY564kzRbnr0kFP3JrqNX0VOTRgkSUA0ix1xo0zxzSoJoSaa13/hoX6P/I91p9pVnhxnN+
	ad+MXc78PiueJ+CZnrDgTLaK0bjKabN+hRrx2EpJrcm6HL//AcZ50QSvOV+dUzVVVVBC0G
	FzXh1mj4fgwbL8WYEpdPr5IDAqK5uH4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1773245767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z5kmTSBnOUZT3j/by2tXBX7oeCCj2tZSRi3caiY2YFg=;
	b=LKxH7n8M8cfCbxnF2thQ/bINQYTKkb95EMubiJBIBuGUidqrLrchLon9F0Y6Hx8aM2wFEf
	AtCef9qGoXAIoaZ0NNpW2Gz322+25NM3ndnMmXpzaJqUJFVlv7eYYo/tFws2SamZa51oNM
	ewm7eUbq5bVpLAtaajiFQbEyv8uHnwY=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1773245767;
	b=XflXQLtVrKuHtuG8CYpMemSxqjYnJC5eSuNnihTweWQ3fllYH+mhxuSncM3kwUCSOTi7pR
	OwtL6lLKRJ2xkgl8KASe0/Vci7KxBq6f/YeUiAfF8FURhS8FSZciZFTdN/sOnqF35l4LgE
	yIEUNB8S5mvemOQCRQ8c6/5URCJ1fVQ=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 1/2] Bluetooth: ISO: allow userspace to set seqnum and timestamp for sending
Date: Wed, 11 Mar 2026 18:15:50 +0200
Message-ID: <08692f3273776c975e6bf5974c77673a28dd0236.1773245666.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773245666.git.pav@iki.fi>
References: <cover.1773245666.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel currently leaves ISO packet scheduling to userspace.  To do this
properly, e.g. to ensure different CIS are synchronized, userspace needs
to be able to set packet timestamps. Core v6.2 Vol 6 Part G Sec 3.3
specifies that seqnum and timestamp shall correspond to each other, so
userspace must also be able to override the sequence number.

Add new CMSG BT_SCM_PKT_ISO_TS for the ISO timestamp.

Support BT_SCM_PKT_SEQNUM and BT_SCM_PKT_ISO_TS CMSG for sent packets.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    This is more or less the same patch as
    https://lore.kernel.org/linux-bluetooth/20260311081401.3832000-1-tailu.shi@samsung.com/
    but in slightly different words.
    
    Sending anyway now, since I had the test series written against this
    one.

 include/net/bluetooth/bluetooth.h |  2 +
 include/net/bluetooth/hci_core.h  |  2 +-
 net/bluetooth/hci_core.c          |  8 ++--
 net/bluetooth/iso.c               | 70 +++++++++++++++++++++++++++----
 4 files changed, 68 insertions(+), 14 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 69eed69f7f26..7f7e13a51de7 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -259,6 +259,8 @@ struct bt_codecs {
 
 #define BT_SCM_PKT_SEQNUM	0x05
 
+#define BT_SCM_PKT_ISO_TS	0x06
+
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
 __printf(1, 2)
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a7bffb908c1e..c82cec45a9a1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2336,7 +2336,7 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen,
 		 const void *param);
 void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags);
 void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);
-void hci_send_iso(struct hci_conn *conn, struct sk_buff *skb);
+void hci_send_iso(struct hci_conn *conn, struct sk_buff *skb, bool ts);
 
 void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
 void *hci_recv_event_data(struct hci_dev *hdev, __u8 event);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index eb32802f6296..da2ac924aaf6 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3322,7 +3322,7 @@ static void hci_add_iso_hdr(struct sk_buff *skb, __u16 handle, __u8 flags)
 }
 
 static void hci_queue_iso(struct hci_conn *conn, struct sk_buff_head *queue,
-			  struct sk_buff *skb)
+			  struct sk_buff *skb, u8 ts)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct sk_buff *list;
@@ -3335,7 +3335,7 @@ static void hci_queue_iso(struct hci_conn *conn, struct sk_buff_head *queue,
 
 	list = skb_shinfo(skb)->frag_list;
 
-	flags = hci_iso_flags_pack(list ? ISO_START : ISO_SINGLE, 0x00);
+	flags = hci_iso_flags_pack(list ? ISO_START : ISO_SINGLE, ts);
 	hci_add_iso_hdr(skb, conn->handle, flags);
 
 	if (!list) {
@@ -3368,13 +3368,13 @@ static void hci_queue_iso(struct hci_conn *conn, struct sk_buff_head *queue,
 	bt_dev_dbg(hdev, "hcon %p queued %d", conn, skb_queue_len(queue));
 }
 
-void hci_send_iso(struct hci_conn *conn, struct sk_buff *skb)
+void hci_send_iso(struct hci_conn *conn, struct sk_buff *skb, bool ts)
 {
 	struct hci_dev *hdev = conn->hdev;
 
 	BT_DBG("%s len %d", hdev->name, skb->len);
 
-	hci_queue_iso(conn, &conn->data_q, skb);
+	hci_queue_iso(conn, &conn->data_q, skb, ts ? 0x01 : 0x00);
 
 	queue_work(hdev->workqueue, &hdev->tx_work);
 }
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index a38d3774176d..260eb2d96390 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -537,11 +537,13 @@ static struct bt_iso_qos *iso_sock_get_qos(struct sock *sk)
 }
 
 static int iso_send_frame(struct sock *sk, struct sk_buff *skb,
-			  const struct sockcm_cookie *sockc)
+			  const struct sockcm_cookie *sockc,
+			  u32 seqnum, u64 timestamp)
 {
 	struct iso_conn *conn = iso_pi(sk)->conn;
 	struct bt_iso_qos *qos = iso_sock_get_qos(sk);
-	struct hci_iso_data_hdr *hdr;
+	__le16 slen, sn;
+	bool ts;
 	int len = 0;
 
 	BT_DBG("sk %p len %d", sk, skb->len);
@@ -552,14 +554,29 @@ static int iso_send_frame(struct sock *sk, struct sk_buff *skb,
 	len = skb->len;
 
 	/* Push ISO data header */
-	hdr = skb_push(skb, HCI_ISO_DATA_HDR_SIZE);
-	hdr->sn = cpu_to_le16(conn->tx_sn++);
-	hdr->slen = cpu_to_le16(hci_iso_data_len_pack(len,
-						      HCI_ISO_STATUS_VALID));
+	ts = (timestamp <= U32_MAX);
+	slen = cpu_to_le16(hci_iso_data_len_pack(len,
+						 HCI_ISO_STATUS_VALID));
+	sn = cpu_to_le16(seqnum <= U16_MAX ? seqnum : conn->tx_sn++);
+
+	if (ts) {
+		struct hci_iso_ts_data_hdr *hdr;
+
+		hdr = skb_push(skb, HCI_ISO_TS_DATA_HDR_SIZE);
+		hdr->ts = cpu_to_le32(timestamp);
+		hdr->sn = sn;
+		hdr->slen = slen;
+	} else {
+		struct hci_iso_data_hdr *hdr;
+
+		hdr = skb_push(skb, HCI_ISO_DATA_HDR_SIZE);
+		hdr->sn = sn;
+		hdr->slen = slen;
+	}
 
 	if (sk->sk_state == BT_CONNECTED) {
 		hci_setup_tx_timestamp(skb, 1, sockc);
-		hci_send_iso(conn->hcon, skb);
+		hci_send_iso(conn->hcon, skb, ts);
 	} else {
 		len = -ENOTCONN;
 	}
@@ -1465,12 +1482,43 @@ static int iso_sock_getname(struct socket *sock, struct sockaddr *addr,
 	return len;
 }
 
+static int iso_cmsg_send(struct sock *sk, struct msghdr *msg,
+			 u32 *seqnum, u64 *timestamp)
+{
+	struct cmsghdr *cmsg;
+
+	for_each_cmsghdr(cmsg, msg) {
+		if (!CMSG_OK(msg, cmsg))
+			return -EINVAL;
+		if (cmsg->cmsg_level != SOL_BLUETOOTH)
+			continue;
+
+		switch (cmsg->cmsg_type) {
+		case BT_SCM_PKT_SEQNUM:
+			if (cmsg->cmsg_len != CMSG_LEN(sizeof(u16)))
+				return -EINVAL;
+			*seqnum = *(u16 *)CMSG_DATA(cmsg);
+			break;
+		case BT_SCM_PKT_ISO_TS:
+			if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
+				return -EINVAL;
+			*timestamp = *(u32 *)CMSG_DATA(cmsg);
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
 static int iso_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 			    size_t len)
 {
 	struct sock *sk = sock->sk;
 	struct sk_buff *skb, **frag;
 	struct sockcm_cookie sockc;
+	u32 seqnum = U32_MAX;
+	u64 timestamp = U64_MAX;
 	size_t mtu;
 	int err;
 
@@ -1486,6 +1534,10 @@ static int iso_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	hci_sockcm_init(&sockc, sk);
 
 	if (msg->msg_controllen) {
+		err = iso_cmsg_send(sk, msg, &seqnum, &timestamp);
+		if (err)
+			return err;
+
 		err = sock_cmsg_send(sk, msg, &sockc);
 		if (err)
 			return err;
@@ -1502,7 +1554,7 @@ static int iso_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 
 	release_sock(sk);
 
-	skb = bt_skb_sendmsg(sk, msg, len, mtu, HCI_ISO_DATA_HDR_SIZE, 0);
+	skb = bt_skb_sendmsg(sk, msg, len, mtu, HCI_ISO_TS_DATA_HDR_SIZE, 0);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
@@ -1536,7 +1588,7 @@ static int iso_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	lock_sock(sk);
 
 	if (sk->sk_state == BT_CONNECTED)
-		err = iso_send_frame(sk, skb, &sockc);
+		err = iso_send_frame(sk, skb, &sockc, seqnum, timestamp);
 	else
 		err = -ENOTCONN;
 
-- 
2.53.0

