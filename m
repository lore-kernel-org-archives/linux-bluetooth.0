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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F57C3276C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jan 2020 17:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7DF21734
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jan 2020 17:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijstOjc3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgABRYv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jan 2020 12:24:51 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36927 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbgABRYu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jan 2020 12:24:50 -0500
Received: by mail-pg1-f195.google.com with SMTP id q127so22192812pga.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jan 2020 09:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7tKXYKPkHBK162bq0SRMS9f5TMCqjiPhJER2UPdGUm8=;
        b=ijstOjc37s64Qp+Hr6h9dtlayFbOWXk364bTyxWQDLRuRywD0An5o84RtkSyelu1JL
         iaZUhw6KesDqYL54pKxO3Lc9GqUUss54+Egq2RqWtzObYOHkVXRiQHhb7vWvHOZYdlYz
         MToH3AHaTFtply4WWqUjLhDV+gW9+Wr85d2rZH42O0rHyKVp3GHzbVm6i0CzGaMPbFkv
         U3DdsQkHSikTrP8IGnQiDFlnC6K9+raGuiR+hlY6o89AvtqTFpHTOz3gyq496AVxZDWW
         214xGlCHzV/y5Q24JXDcdllBklmzIXIAnv607RggnDTC3kiIawb+lk2iLHRWwpRvBw79
         9zWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7tKXYKPkHBK162bq0SRMS9f5TMCqjiPhJER2UPdGUm8=;
        b=aSWgD6E7lYDXRB+HesQZrLU1wQTPsQkR/yTskV3qtZsAuw1wPRo/pxwXO21ua0KEt/
         Yjrf6S4JRIwecYONI0fAw4AULOxZNuJAvSoKFFSBpXvy6CnMrl0Q6D9QbpS8VFSp3wka
         pAdlAICas6qg8r8J23e17iWYiVj2YWm2pRUO+1s8ZwwezTjc5kGQxidkcaySVvw65Mu1
         2ZNhOLR06cZqo/V3+ncALrnh4SRIBU694/yMRf3Clihsf3Yld9XvfxfbEdf79MEv5yu0
         0jx71mR6wI1s8+S6ShZjwGq9T2B/k+x2v+kFKWU8h0qjMY7rUs5L/6Md0rpKLF4kGezI
         AT4w==
X-Gm-Message-State: APjAAAUjuj2I09jZyc81uZwx/6NZmaGlEnJd/zGIPKWrsom2KzZNEcym
        5yXry7z7r7RBGGOP3roqHJN+ZsD5wLw=
X-Google-Smtp-Source: APXvYqx6mEUouX1U8ssrzx+/dmgYP6FR0a6NgEEmjngXEowfRT13WzdGm645ybtuvfaoXkcSmyMjyQ==
X-Received: by 2002:a63:181:: with SMTP id 123mr89110574pgb.36.1577985889857;
        Thu, 02 Jan 2020 09:24:49 -0800 (PST)
Received: from vudentzs-t460s.hsd1.or.comcast.net ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id o6sm59041087pgg.37.2020.01.02.09.24.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 09:24:49 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC 2/2] Bluetooth: Add BT_PHYS socket option
Date:   Thu,  2 Jan 2020 09:24:47 -0800
Message-Id: <20200102172447.18574-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200102172447.18574-1-luiz.dentz@gmail.com>
References: <20200102172447.18574-1-luiz.dentz@gmail.com>
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

