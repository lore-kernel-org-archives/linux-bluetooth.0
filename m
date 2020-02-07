Return-Path: <SRS0=kXS7=33=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348C2C2BA83
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Feb 2020 19:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29E32051A
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Feb 2020 19:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfi6FYEG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgBGTA6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Feb 2020 14:00:58 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45497 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgBGTA6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Feb 2020 14:00:58 -0500
Received: by mail-pl1-f194.google.com with SMTP id b22so102828pls.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Feb 2020 11:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H6T5GFpVncp3uTMFQTfNNKb0/TVtd76WEoQut+fghAk=;
        b=rfi6FYEGgwqiCqwYXY+WguUKG+AQFWEG2dWlSl709RbuuiWSi3u57D3Xh2AxJjSyTe
         sSCsXJzfK278kMesnbT03KdWUEnBA9O1skCQzgGPZHf2yc8PbNhn5hJtPGS+wwqN0Z0b
         OP5GeLX+xaLMaNK8pyBF/p0xZLQ31dZDdnrNSYCV/sQnh7Ym+qdUaXz5gUSJWZjKP83Q
         I7KHIiPdni39/qV+Ep2H3SlboO+m+iI7hbWxv4RDnHmHGIDnAyxbyOMEMA4ZRLV+n/Xj
         +ZzRTfDejQ1jWE4cOrY4AbuPitjHBYNXlHTv1XkKCory4Dsf7goFncWySqGAeUtDGQWh
         DFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H6T5GFpVncp3uTMFQTfNNKb0/TVtd76WEoQut+fghAk=;
        b=idsjVbgCzI1wXyW9eRN3Q2oAdAlfo09BMg3shJzz0NjGHq3N+80gS0TXyvZx0o/QH8
         JfyOD2EkBEUS8cSQ4BOKitrDKBBm32vo8dhgnfEgL1Gux794ZkK8HM7jxRgt8EvezB6d
         lLCg/BUMaMrJmSWk6nm7Xx5XbryQABVyyqyZiyMJyIdhFRatQUZwyBX2GsDyf57ZuTR5
         +ZapVk/aXXySTea8hc67FNrLUNNKWFMFXf+IGWic1RsSPSll1TP82zKcqFYuf1LvAgOv
         7wvB2L2ekoZRNwxYTRPi2hI2u/xaNW+rnmP9BuSL/YDt9G/d5RnQNb1/9RDkFIzFufTT
         K7kA==
X-Gm-Message-State: APjAAAWgIvQqYYg8q1QodpqTTlTuNqQA8XkJQW5Qhu65vwbN/x0t8vzm
        MoZ0sJpCMiDJUXUZMISBzd8I5OWT
X-Google-Smtp-Source: APXvYqzcPzgeNHCgIoLxDQZeKnTSXrGUxP1hyxuqCcxpO08cgZIb6uCkth9exS80iWiKj53++dXIQw==
X-Received: by 2002:a17:90a:2e86:: with SMTP id r6mr5414471pjd.104.1581102056765;
        Fri, 07 Feb 2020 11:00:56 -0800 (PST)
Received: from vudentzs-t460s.hsd1.or.comcast.net ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id e26sm3821547pfl.59.2020.02.07.11.00.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 11:00:55 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add BT_PHY socket option
Date:   Fri,  7 Feb 2020 11:00:55 -0800
Message-Id: <20200207190055.15249-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds BT_PHY socket option (read-only) which can be used to read
the PHYs in use by the underline connection.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/bluetooth.h | 17 ++++++
 include/net/bluetooth/hci_core.h  |  2 +
 net/bluetooth/hci_conn.c          | 88 +++++++++++++++++++++++++++++++
 net/bluetooth/l2cap_sock.c        | 13 +++++
 net/bluetooth/sco.c               | 13 +++++
 5 files changed, 133 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index e42bb8e03c09..1576353a2773 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -121,6 +121,23 @@ struct bt_voice {
 
 #define BT_SNDMTU		12
 #define BT_RCVMTU		13
+#define BT_PHY			14
+
+#define BT_PHY_BR_1M_1SLOT	0x00000001
+#define BT_PHY_BR_1M_3SLOT	0x00000002
+#define BT_PHY_BR_1M_5SLOT	0x00000004
+#define BT_PHY_EDR_2M_1SLOT	0x00000008
+#define BT_PHY_EDR_2M_3SLOT	0x00000010
+#define BT_PHY_EDR_2M_5SLOT	0x00000020
+#define BT_PHY_EDR_3M_1SLOT	0x00000040
+#define BT_PHY_EDR_3M_3SLOT	0x00000080
+#define BT_PHY_EDR_3M_5SLOT	0x00000100
+#define BT_PHY_LE_1M_TX		0x00000200
+#define BT_PHY_LE_1M_RX		0x00000400
+#define BT_PHY_LE_2M_TX		0x00000800
+#define BT_PHY_LE_2M_RX		0x00001000
+#define BT_PHY_LE_CODED_TX	0x00002000
+#define BT_PHY_LE_CODED_RX	0x00004000
 
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 89ecf0a80aa1..dcc0dc6e2624 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1477,6 +1477,8 @@ void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
 struct sk_buff *hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
 			     const void *param, u32 timeout);
 
+u32 hci_conn_get_phy(struct hci_conn *conn);
+
 /* ----- HCI Sockets ----- */
 void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb);
 void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 87691404d0c6..9ff2611b272f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1725,3 +1725,91 @@ struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle)
 
 	return hchan;
 }
+
+u32 hci_conn_get_phy(struct hci_conn *conn)
+{
+	u32 phys = 0;
+
+	hci_dev_lock(conn->hdev);
+
+	switch (conn->type) {
+	case SCO_LINK:
+		phys |= BT_PHY_BR_1M_1SLOT;
+
+		break;
+
+	case ACL_LINK:
+		phys |= BT_PHY_BR_1M_1SLOT;
+
+		if (conn->pkt_type & (HCI_DM3 | HCI_DH3))
+			phys |= BT_PHY_BR_1M_3SLOT;
+
+		if (conn->pkt_type & (HCI_DM5 | HCI_DH5))
+			phys |= BT_PHY_BR_1M_5SLOT;
+
+		if (!(conn->pkt_type & HCI_2DH1))
+			phys |= BT_PHY_EDR_2M_1SLOT;
+
+		if (!(conn->pkt_type & HCI_2DH3))
+			phys |= BT_PHY_EDR_2M_3SLOT;
+
+		if (!(conn->pkt_type & HCI_2DH5))
+			phys |= BT_PHY_EDR_2M_5SLOT;
+
+		if (!(conn->pkt_type & HCI_3DH1))
+			phys |= BT_PHY_EDR_3M_1SLOT;
+
+		if (!(conn->pkt_type & HCI_3DH3))
+			phys |= BT_PHY_EDR_3M_3SLOT;
+
+		if (!(conn->pkt_type & HCI_3DH5))
+			phys |= BT_PHY_EDR_3M_5SLOT;
+
+		break;
+
+	case ESCO_LINK:
+		phys |= BT_PHY_BR_1M_1SLOT;
+
+		if (!(conn->pkt_type & (ESCO_EV4 | ESCO_EV5)))
+			phys |= BT_PHY_BR_1M_3SLOT;
+
+		if (!(conn->pkt_type & ESCO_2EV3))
+			phys |= BT_PHY_EDR_2M_1SLOT;
+
+		if (!(conn->pkt_type & ESCO_2EV5))
+			phys |= BT_PHY_EDR_2M_3SLOT;
+
+		if (!(conn->pkt_type & ESCO_3EV3))
+			phys |= BT_PHY_EDR_3M_1SLOT;
+
+		if (!(conn->pkt_type & ESCO_3EV5))
+			phys |= BT_PHY_EDR_3M_3SLOT;
+
+		break;
+
+	case LE_LINK:
+		if (conn->le_tx_phy & HCI_LE_SET_PHY_1M)
+			phys |= BT_PHY_LE_1M_TX;
+
+		if (conn->le_rx_phy & HCI_LE_SET_PHY_1M)
+			phys |= BT_PHY_LE_1M_RX;
+
+		if (conn->le_tx_phy & HCI_LE_SET_PHY_2M)
+			phys |= BT_PHY_LE_2M_TX;
+
+		if (conn->le_rx_phy & HCI_LE_SET_PHY_2M)
+			phys |= BT_PHY_LE_2M_RX;
+
+		if (conn->le_tx_phy & HCI_LE_SET_PHY_CODED)
+			phys |= BT_PHY_LE_CODED_TX;
+
+		if (conn->le_rx_phy & HCI_LE_SET_PHY_CODED)
+			phys |= BT_PHY_LE_CODED_RX;
+
+		break;
+	}
+
+	hci_dev_unlock(conn->hdev);
+
+	return phys;
+}
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 390a9afab647..3df4a7cf85a3 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -499,6 +499,7 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 	struct bt_security sec;
 	struct bt_power pwr;
+	u32 phys;
 	int len, err = 0;
 
 	BT_DBG("sk %p", sk);
@@ -603,6 +604,18 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 			err = -EFAULT;
 		break;
 
+	case BT_PHY:
+		if (sk->sk_state == BT_CONNECTED) {
+			err = -EINVAL;
+			break;
+		}
+
+		phys = hci_conn_get_phy(chan->conn->hcon);
+
+		if (put_user(phys, (u32 __user *) optval))
+			err = -EFAULT;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index b91d6b440fdf..95fdfa4b9b62 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -922,6 +922,7 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 	struct sock *sk = sock->sk;
 	int len, err = 0;
 	struct bt_voice voice;
+	u32 phys;
 
 	BT_DBG("sk %p", sk);
 
@@ -956,6 +957,18 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 
 		break;
 
+	case BT_PHY:
+		if (sk->sk_state == BT_CONNECTED) {
+			err = -EINVAL;
+			break;
+		}
+
+		phys = hci_conn_get_phy(sco_pi(sk)->conn->hcon);
+
+		if (put_user(phys, (u32 __user *) optval))
+			err = -EFAULT;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
-- 
2.21.0

