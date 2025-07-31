Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668051DF273
	for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jul 2025 19:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753991622; cv=none; b=Tb1tqhQ5H1SwW3gg6TtBSfWHsRPsG3+NflRyM6r1r/aUP9C0Qdumc44wr6FCYHu4qfz/yidWF0fb95j4iQTXETIpGUbXdDZVIwhe+EFamLxo9bnhG6F7NShQTtOjL5zMwzMh8BLIxddkgzO4FafAnhVwhg/s8RXdgC8qCVzwS6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753991622; c=relaxed/simple;
	bh=wH3E0KoPyo92g2wJwq87HEau3ut+7ih2Fqs5iE4+zGU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gHPfflFIBxksGb8uhqHjerHu3n+x8P+VIBoe8eH6TM+jNMqDyt7kcBPrc3qPRudutyuohXqzkw2Sk3jUd4eWni2Ay4mmYtq57TyvNbdGDXV8aKJndGK6E2yKJxWXm4NqPmVaHJlMPSlOXmZT47tdqqve2UqEzL2qdU1zJLCxqKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Py3RX4NK; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Py3RX4NK"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5393a970209so581286e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jul 2025 12:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753991618; x=1754596418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qGTeZrbWEgD3uJ+98p5b4qGUXrx0Gz86vPb8AG8UZC8=;
        b=Py3RX4NK2SKkiSxWoyJ6osefFCv6eIVRb3dtl68seia365vDYETb6RAulZI9GniATA
         40A1J4n5xWT6aMEDS7eQWeKFdbES4c8/fm/k6kbaUOzxfQPhEhTgduYDUmJS+n1G5II4
         OXqMQjUVmYrNw91QEacaozLuywdOrhYRycGcepElVO+hzx89j8O2scLUFn1PtkyfxhWt
         w1MHA0Uz3UY1bVPsMp80ogiZ0axaZkXsiyJQoUDTqFwrfPoFArR5UEfCTyLI2qUMF/QG
         8O71OQup71GJIDlcSMvt8HEXijIHfh5Mtv21cGVfPTDUryLmUTjKOtZMa18De3cHJvrf
         7n2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753991618; x=1754596418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qGTeZrbWEgD3uJ+98p5b4qGUXrx0Gz86vPb8AG8UZC8=;
        b=O9FTB9T9sbExk2ad4H+0oHRXZlNw+huURhBCSM1/zB5HtdKt+fZypabTAFxiOXMA6A
         pySQl7R0YNDYHY0QsWxg1Pe/cPTbu9gr5/UUTOl85llhOI7yGOahDknhYpB+N9clZV/D
         aS/4Wm7H3iOrkkkYv5+XPAOqkx93nsfHNdSx9wXYlcpd0sg/jaLNXph/HxJh1UbD4i4w
         KbJlgxOe5cMVqdqcb4WlUlFrrBDtUdZ+2uaPBPikpypPu8ojMTiiOsrxSFkhI0Xb7oCb
         OPPe1kiGO3KH/ycET5GfOU/oWT2WrnOpX4sdQWESYjp1UlXfpnL943hqTiNdEHvc6/H4
         0v8Q==
X-Gm-Message-State: AOJu0YylBrytp/eyGfLQZ2E7wyHLSUNx/qsgZUzIMxbr9KY+d0ikS/5g
	xsi+1mdiBaIfjVM9uVPSmHaW82RYa7zFpDu3GqCYdTO+TVLSWTD1c3cpGID8bI4U
X-Gm-Gg: ASbGnctx75N09WLLHWI3Dqcs+2/rIbJXvjXJzcb/hs106yIvKFqp7+ev+uXK6aAF+sn
	0qD53OI9TqZS2Ee13mwrql1RKNNIYH1KfOINYRGreou4rxj22wvl0I+yTnuT/GloKPbTDldTE+x
	i9a/3YeDHBDvsmWndtlKJERpki/onywS97RS80zuDHvpMfsjTNNGw0f9w5kPkOP823Gx9K8dSqR
	XUQSf589HEbiRRI3cBsVyQNmYwOpDJ2Cy7VJ1VLKQ+mSSvp8XplCpQzO/EpNjR5jI9XBJYJpHnl
	z4p+TAMn8f+zTaX7eoNTy1eZEIsmQtB3aS+mFeCe5dq7/Twu8fqINde5gFzJVJnMsZ8PIAot1mE
	Ar6yaDshTwjEQE07v+o2dNInDSHPRZLlm1pBNPB1hNW08I0ACdVgAG6b/chyMTmTN9QrIWGGm1X
	Y=
X-Google-Smtp-Source: AGHT+IE9QDiGCRSBls4cEtN7fMabWoAlE8H9rm0J2ohAjXSBUNbEQf5M0zX9+/DPOcParbRsEXfYyw==
X-Received: by 2002:a05:6122:2186:b0:539:3524:2138 with SMTP id 71dfb90a1353d-539352421cdmr2678939e0c.4.1753991618468;
        Thu, 31 Jul 2025 12:53:38 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53936d10f3asm598344e0c.26.2025.07.31.12.53.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 12:53:37 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v1] Bluetooth: Add support for logging host packets into monitor
Date: Thu, 31 Jul 2025 15:53:28 -0400
Message-ID: <20250731195328.684121-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for logging host (enqueued/dequeued) packets so their
timing is visible in the logs:

l2cap-tester[41]: < HOST Data TX: len 12                 [hci0] 15:50:02.974141
l2cap-tester[41]: < ACL Data T.. flags 0x00 dlen 12  #83 [hci0] 15:50:02.974199
      Channel: 64 len 8 [PSM 4097 mode Basic (0x00)] {chan 0}
        01 02 03 04 05 06 07 08                          ........

> ACL Data RX: Handle 42 flags 0x02 dlen 12         #170 [hci0] 15:51:43.269961
      Channel: 64 len 8 [PSM 4097 mode Basic (0x00)] {chan 0}
        01 02 03 04 05 06 07 08                          ........
[45]: > HOST Data RX: len 8                              [hci0] 15:51:43.269976

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/bluetooth.h |  2 ++
 include/net/bluetooth/hci.h       |  1 +
 include/net/bluetooth/hci_core.h  |  1 +
 include/net/bluetooth/hci_mon.h   |  2 ++
 net/bluetooth/hci_core.c          | 18 ++++++++++++++++++
 net/bluetooth/hci_sock.c          |  8 +++++++-
 net/bluetooth/iso.c               |  7 +++++++
 net/bluetooth/l2cap_core.c        |  2 ++
 net/bluetooth/l2cap_sock.c        |  7 +++++++
 net/bluetooth/sco.c               |  7 +++++++
 10 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index ada5b56a4413..3a5f94577684 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -459,6 +459,8 @@ void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status,
 int hci_ethtool_ts_info(unsigned int index, int sk_proto,
 			struct kernel_ethtool_ts_info *ts_info);
 
+void hci_sock_copy_creds(struct sock *sk, struct sk_buff *skb);
+
 #define HCI_REQ_START	BIT(0)
 #define HCI_REQ_SKB	BIT(1)
 
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index df1847b74e55..cfcb8d816f8f 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -497,6 +497,7 @@ enum {
 #define HCI_ISODATA_PKT		0x05
 #define HCI_DIAG_PKT		0xf0
 #define HCI_DRV_PKT		0xf1
+#define HCI_HOST_PKT		0xf2
 #define HCI_VENDOR_PKT		0xff
 
 /* HCI packet types */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4dc11c66f7b8..46afc7ff7ac7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2248,6 +2248,7 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen,
 void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags);
 void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);
 void hci_send_iso(struct hci_conn *conn, struct sk_buff *skb);
+void hci_send_host(struct hci_dev *hdev, struct sk_buff *skb);
 
 void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
 void *hci_recv_event_data(struct hci_dev *hdev, __u8 event);
diff --git a/include/net/bluetooth/hci_mon.h b/include/net/bluetooth/hci_mon.h
index bbd752494ef9..153596625eee 100644
--- a/include/net/bluetooth/hci_mon.h
+++ b/include/net/bluetooth/hci_mon.h
@@ -53,6 +53,8 @@ struct hci_mon_hdr {
 #define HCI_MON_ISO_RX_PKT	19
 #define HCI_MON_DRV_TX_PKT	20
 #define HCI_MON_DRV_RX_PKT	21
+#define HCI_MON_SOCK_TX_PKT	22
+#define HCI_MON_SOCK_RX_PKT	23
 
 struct hci_mon_new_index {
 	__u8		type;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 55e0722fd066..54193faa7c8c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3269,12 +3269,26 @@ static void hci_queue_acl(struct hci_chan *chan, struct sk_buff_head *queue,
 	}
 }
 
+void hci_send_host(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	/* Mark as socket packet */
+	hci_skb_pkt_type(skb) = HCI_HOST_PKT;
+
+	/* Time stamp */
+	__net_timestamp(skb);
+
+	/* Send copy to monitor */
+	hci_send_to_monitor(hdev, skb);
+}
+
 void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags)
 {
 	struct hci_dev *hdev = chan->conn->hdev;
 
 	BT_DBG("%s chan %p flags 0x%4.4x", hdev->name, chan, flags);
 
+	hci_send_host(hdev, skb);
+
 	hci_queue_acl(chan, &chan->data_q, skb, flags);
 
 	queue_work(hdev->workqueue, &hdev->tx_work);
@@ -3288,6 +3302,8 @@ void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb)
 
 	BT_DBG("%s len %d", hdev->name, skb->len);
 
+	hci_send_host(hdev, skb);
+
 	hdr.handle = cpu_to_le16(conn->handle);
 	hdr.dlen   = skb->len;
 
@@ -3365,6 +3381,8 @@ void hci_send_iso(struct hci_conn *conn, struct sk_buff *skb)
 
 	BT_DBG("%s len %d", hdev->name, skb->len);
 
+	hci_send_host(hdev, skb);
+
 	hci_queue_iso(conn, &conn->data_q, skb);
 
 	queue_work(hdev->workqueue, &hdev->tx_work);
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index fc866759910d..6df357a60981 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -265,7 +265,7 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
 	kfree_skb(skb_copy);
 }
 
-static void hci_sock_copy_creds(struct sock *sk, struct sk_buff *skb)
+void hci_sock_copy_creds(struct sock *sk, struct sk_buff *skb)
 {
 	struct scm_creds *creds;
 
@@ -398,6 +398,12 @@ void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb)
 		else
 			opcode = cpu_to_le16(HCI_MON_DRV_TX_PKT);
 		break;
+	case HCI_HOST_PKT:
+		if (bt_cb(skb)->incoming)
+			opcode = cpu_to_le16(HCI_MON_SOCK_RX_PKT);
+		else
+			opcode = cpu_to_le16(HCI_MON_SOCK_TX_PKT);
+		break;
 	case HCI_DIAG_PKT:
 		opcode = cpu_to_le16(HCI_MON_VENDOR_DIAG);
 		break;
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index eaffd25570e3..c7afabbcf982 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -569,6 +569,13 @@ static void iso_recv_frame(struct iso_conn *conn, struct sk_buff *skb)
 	if (sk->sk_state != BT_CONNECTED)
 		goto drop;
 
+	/* Copy pid information since the skb was not allocated using the sk as
+	 * source, otherwise tools cannot decode the process that is receiving
+	 * the packet.
+	 */
+	hci_sock_copy_creds(sk, skb);
+	hci_send_host(conn->hcon->hdev, skb);
+
 	if (!sock_queue_rcv_skb(sk, skb))
 		return;
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 805c752ac0a9..d405fbbacfac 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7440,6 +7440,8 @@ static int l2cap_recv_frag(struct l2cap_conn *conn, struct sk_buff *skb,
 			return -ENOMEM;
 		/* Init rx_len */
 		conn->rx_len = len;
+		/* Set rx_skb as incoming so it can be properly decoded */
+		bt_cb(conn->rx_skb)->incoming = 1;
 
 		skb_set_delivery_time(conn->rx_skb, skb->tstamp,
 				      skb->tstamp_type);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index f4257c4d3052..aedba0299e81 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1526,6 +1526,13 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 			goto done;
 	}
 
+	/* Copy pid information since the skb was not allocated using the sk as
+	 * source, otherwise tools cannot decode the process that is receiving
+	 * the packet.
+	 */
+	hci_sock_copy_creds(sk, skb);
+	hci_send_host(chan->conn->hcon->hdev, skb);
+
 	err = __sock_queue_rcv_skb(sk, skb);
 
 	l2cap_publish_rx_avail(chan);
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index d382d980fd9a..3f32bebe7f41 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -412,6 +412,13 @@ static void sco_recv_frame(struct sco_conn *conn, struct sk_buff *skb)
 	if (sk->sk_state != BT_CONNECTED)
 		goto drop;
 
+	/* Copy pid information since the skb was not allocated using the sk as
+	 * source, otherwise tools cannot decode the process that is receiving
+	 * the packet.
+	 */
+	hci_sock_copy_creds(sk, skb);
+	hci_send_host(conn->hcon->hdev, skb);
+
 	if (!sock_queue_rcv_skb(sk, skb))
 		return;
 
-- 
2.50.1

