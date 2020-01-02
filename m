Return-Path: <SRS0=Qv9v=2X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328EFC3276C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jan 2020 23:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC98721D7D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jan 2020 23:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvF63mrZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbgABXBE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jan 2020 18:01:04 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:56126 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbgABXBC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jan 2020 18:01:02 -0500
Received: by mail-pj1-f65.google.com with SMTP id d5so3848920pjz.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jan 2020 15:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7tKXYKPkHBK162bq0SRMS9f5TMCqjiPhJER2UPdGUm8=;
        b=kvF63mrZXMZfwC2bQDCY2rfmWfu9IP3Jl45FtyY+NdCtw9DXSRKYHxOpjGko4Efxlu
         JUN1GjsD32ZhqjDoZN93MEcY/MP+EY9KSDrxcpNw+Z9r9tHT5IfzhvWo4zvCgdrYqJQ9
         8duXvLkziDvCD1EfCpMrW022ojRPs3UwRgVgZjlrGYdTl5K4X4Qr/Q3EX83RAltwcarD
         plGA80yLrufmse5x0tR4xs6VohVx+PuApgvDpsTD5gLWH6A6NsmwKb9StliwHiUKTER7
         xwcZBO/yU1E6HlpeeRZDrxj7u6Ptbds0tQyfn1V2cNa/lIMv/AiVX+WC/bqyHhWzXY5F
         ysTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7tKXYKPkHBK162bq0SRMS9f5TMCqjiPhJER2UPdGUm8=;
        b=h/0aFx5HmujhNFNmsorDiPWEEUHcZmc2TTHNgkpv2Cpo2lJtWdKUzFG3LZsxKkm9r/
         ZzFyvq/zVx8NDfuRNGakPWyPoLYf/nYxOYu2WUUTG6ru/WcA0hzsenjp+aZvbIZMvq1g
         j6AZXdfAgByLOJD+OcLzsA9KL1JAVcYHW35zYxpyKDQHtgAAm8Mg0C0S2gddIC9jATqh
         s3+bNK9aIuxbwlnybhdvp8iTr4LIJN69q8FVReh3C1XJ6B4XihythqvHW9pNdg0HH/3c
         o3HEvMGxzwZCVnRgWvKTUKf5uijwG7sumlziD2JNUBlTHyZDj2YupFiEZ4UShDeizofh
         4T5Q==
X-Gm-Message-State: APjAAAUDtWMpy7we45R4bzqlConEdlblpuGVP996sraptAMFakgiWr7k
        3uhq1NKJu0iz0BWgAXszu539fxp1cro=
X-Google-Smtp-Source: APXvYqyjUC6KwqoyIHRURymI2tUJNCFFxLzx5cYQRXScSdqjzPeYC1nkGoQuAsLVsBLAsQQ9YhYMRg==
X-Received: by 2002:a17:902:9a8f:: with SMTP id w15mr87258532plp.149.1578006060619;
        Thu, 02 Jan 2020 15:01:00 -0800 (PST)
Received: from vudentzs-t460s.hsd1.or.comcast.net ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id 83sm61468946pgh.12.2020.01.02.15.00.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 15:01:00 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC 2/3] Bluetooth: Add BT_PHYS socket option
Date:   Thu,  2 Jan 2020 15:00:56 -0800
Message-Id: <20200102230057.31326-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200102230057.31326-1-luiz.dentz@gmail.com>
References: <20200102230057.31326-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds BT_PHYS socket option which can be used to read the PHYs in
use by the underline connection.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/bluetooth.h | 17 ++++++++
 include/net/bluetooth/hci_core.h  |  2 +
 net/bluetooth/hci_conn.c          | 64 +++++++++++++++++++++++++++++++
 net/bluetooth/l2cap_sock.c        | 13 +++++++
 net/bluetooth/sco.c               | 13 +++++++
 5 files changed, 109 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index e42bb8e03c09..69c0e7eb26d9 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -121,6 +121,23 @@ struct bt_voice {
 
 #define BT_SNDMTU		12
 #define BT_RCVMTU		13
+#define BT_PHYS			14
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
index faebe3859931..03cf3f0f22b9 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1467,6 +1467,8 @@ void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
 struct sk_buff *hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
 			     const void *param, u32 timeout);
 
+u32 hci_conn_get_phys(struct hci_conn *conn);
+
 /* ----- HCI Sockets ----- */
 void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb);
 void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 87691404d0c6..386e6b0bd2ab 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1725,3 +1725,67 @@ struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle)
 
 	return hchan;
 }
+
+u32 hci_conn_get_phys(struct hci_conn *conn)
+{
+	u32 phys = 0;
+
+	hci_dev_lock(conn->hdev);
+
+	switch (conn->type) {
+	case ACL_LINK:
+	case SCO_LINK:
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
index a7be8b59b3c2..fb011c6c67be 100644
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
 
+	case BT_PHYS:
+		if (sk->sk_state == BT_CONNECTED) {
+			err = -EINVAL;
+			break;
+		}
+
+		phys = hci_conn_get_phys(chan->conn->hcon);
+
+		if (put_user(phys, (u32 __user *) optval))
+			err = -EFAULT;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index b91d6b440fdf..dcd297f2acc6 100644
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
 
+	case BT_PHYS:
+		if (sk->sk_state == BT_CONNECTED) {
+			err = -EINVAL;
+			break;
+		}
+
+		phys = hci_conn_get_phys(sco_pi(sk)->conn->hcon);
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

