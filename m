Return-Path: <SRS0=GIG2=4C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C7FC3B1B2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Feb 2020 18:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026842168B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Feb 2020 18:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vSfeX+4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392772AbgBNSJA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:09:00 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37813 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392764AbgBNSJA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Feb 2020 13:09:00 -0500
Received: by mail-pg1-f196.google.com with SMTP id z12so5344900pgl.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2020 10:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GeefxMOXsfvoEQPONUV5SfRNZrsTJIkc7/VEWLZOm7E=;
        b=vSfeX+4P1D7+iYItk0rPjfPKQ6fXongyteDTgqi0fkkf2ZAimms8X2vETuS190CZBa
         37T00uUsLF499ZlOJs4EBgR3b/mhU1UHQLCDxOASkdS7Y+NKH8vX3wKXCX6mdc7ihSE1
         7+Gvbh7llTKkTxntNYQaXrnQgndRBjO5nRSXEH3R5AmKgWXFrqK4oSc0ZR0nWxV6ouq2
         IJvcASY6EZK7vhl1/ePhDTQU0XjXe4k8yeoIsqf6VTpCq9N2stsHuL70rOA6ePmYyTps
         6XisVc/RTUptFJWCdyqa5dyvJWJcUp8XLEyxbZqZh6xGe5QxgYxMKP0nHYC/uOwEZp57
         1HtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GeefxMOXsfvoEQPONUV5SfRNZrsTJIkc7/VEWLZOm7E=;
        b=fhLVrXnOFR6f/vjXo+xLaoFLEQ5sbt3lPlnl8gsqXK3eMCiaLxqdja5vWmGBTqpoHN
         VAzu4YAADJDKjS286qDYz3FX43mOvVgLFRSe+eeUec06ObWGhOHQhMsTzZX+Fnl5atv/
         r8amcJQdMf3A8+V8DdQ6ttbCPeyTx8FPBvuq0BHqlPBlZOlUVrptTGhHp0cs81mJ4Ghb
         CxDs87CMCAGfl64pNDgumxup14Hq/VegaV6vRmbMsna6bhcZRCBlYA0KDHpHSy/b8fET
         OmjLI99ufreAnXpCW8RUAzJcw3Dl/RJpLuRBmmaaF5m2SzA3EjpZfwGJo8XPfBgcYnOm
         PAtA==
X-Gm-Message-State: APjAAAUP+uX65fsLCDRcW1jXtqDKPI008adHsK651wERxw0NzIHN7vQz
        neEW7YzpXUvD3ik/MrHVUbd/d6PJ
X-Google-Smtp-Source: APXvYqwzrLFjFTQZH4PO/8C32bV5I+7XKZDM03DuXMnGMznHxDHtg9ui6SYUluMhj2AaQqSyEkjNkA==
X-Received: by 2002:a63:7a1a:: with SMTP id v26mr4745030pgc.51.1581703738990;
        Fri, 14 Feb 2020 10:08:58 -0800 (PST)
Received: from vudentzs-t460s.hsd1.or.comcast.net ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id q7sm7796562pgk.62.2020.02.14.10.08.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 10:08:58 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4] Bluetooth: Add BT_PHY socket option
Date:   Fri, 14 Feb 2020 10:08:57 -0800
Message-Id: <20200214180857.7279-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
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
 include/net/bluetooth/bluetooth.h |  17 +++++
 include/net/bluetooth/hci_core.h  |   2 +
 net/bluetooth/hci_conn.c          | 107 ++++++++++++++++++++++++++++++
 net/bluetooth/l2cap_sock.c        |  13 ++++
 net/bluetooth/sco.c               |  13 ++++
 5 files changed, 152 insertions(+)

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
index 87691404d0c6..65fa44cbe514 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1725,3 +1725,110 @@ struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle)
 
 	return hchan;
 }
+
+u32 hci_conn_get_phy(struct hci_conn *conn)
+{
+	u32 phys = 0;
+
+	hci_dev_lock(conn->hdev);
+
+	/* BLUETOOTH CORE SPECIFICATION Version 5.2 | Vol 2, Part B page 471:
+	 * Table 6.2: Packets defined for synchronous, asynchronous, and
+	 * CSB logical transport types.
+	 */
+	switch (conn->type) {
+	case SCO_LINK:
+		/* SCO logical transport (1 Mb/s):
+		 * HV1, HV2, HV3 and DV.
+		 */
+		phys |= BT_PHY_BR_1M_1SLOT;
+
+		break;
+
+	case ACL_LINK:
+		/* ACL logical transport (1 Mb/s) ptt=0:
+		 * DH1, DM3, DH3, DM5 and DH5.
+		 */
+		phys |= BT_PHY_BR_1M_1SLOT;
+
+		if (conn->pkt_type & (HCI_DM3 | HCI_DH3))
+			phys |= BT_PHY_BR_1M_3SLOT;
+
+		if (conn->pkt_type & (HCI_DM5 | HCI_DH5))
+			phys |= BT_PHY_BR_1M_5SLOT;
+
+		/* ACL logical transport (2 Mb/s) ptt=1:
+		 * 2-DH1, 2-DH3 and 2-DH5.
+		 */
+		if (!(conn->pkt_type & HCI_2DH1))
+			phys |= BT_PHY_EDR_2M_1SLOT;
+
+		if (!(conn->pkt_type & HCI_2DH3))
+			phys |= BT_PHY_EDR_2M_3SLOT;
+
+		if (!(conn->pkt_type & HCI_2DH5))
+			phys |= BT_PHY_EDR_2M_5SLOT;
+
+		/* ACL logical transport (3 Mb/s) ptt=1:
+		 * 3-DH1, 3-DH3 and 3-DH5.
+		 */
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
+		/* eSCO logical transport (1 Mb/s): EV3, EV4 and EV5 */
+		phys |= BT_PHY_BR_1M_1SLOT;
+
+		if (!(conn->pkt_type & (ESCO_EV4 | ESCO_EV5)))
+			phys |= BT_PHY_BR_1M_3SLOT;
+
+		/* eSCO logical transport (2 Mb/s): 2-EV3, 2-EV5 */
+		if (!(conn->pkt_type & ESCO_2EV3))
+			phys |= BT_PHY_EDR_2M_1SLOT;
+
+		if (!(conn->pkt_type & ESCO_2EV5))
+			phys |= BT_PHY_EDR_2M_3SLOT;
+
+		/* eSCO logical transport (3 Mb/s): 3-EV3, 3-EV5 */
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
index 390a9afab647..9fb47b2b13c9 100644
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
+			err = -ENOTCONN;
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
index b91d6b440fdf..29ab3e12fb46 100644
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
+			err = -ENOTCONN;
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
2.21.1

