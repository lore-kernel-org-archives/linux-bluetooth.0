Return-Path: <SRS0=ag/l=4U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1666AC3F2D7
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Mar 2020 00:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A0621D56
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Mar 2020 00:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoqUky0O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgCCA4b (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Mar 2020 19:56:31 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44217 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgCCA4b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Mar 2020 19:56:31 -0500
Received: by mail-pg1-f196.google.com with SMTP id a14so659027pgb.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Mar 2020 16:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Mx7NI6E/Mm/JogOIl1TWVxVDNVMkeldQPY6r+Z3Yj3I=;
        b=HoqUky0OAx6ih6bs8TpDMMbLKsQPFGSXViS2ovnlNttQIbKaVuK00xyriyIQAv+LPr
         Bme/IDn6UBhn++siZDWhuQHA5Y+q5nu9EbVkHEoq/iOOqThBrI0RWxl8SgZBgttfSKM/
         5ZuwLNUwLK1337Ed65gdMn4TolSY2TMKmnj5mw3jNKmA7uDtCWIbCzNg1eRLdx0NhQOp
         Y227xO7xOoLm2hOO6RUfygx5UBxoEh1HAUumYrcH/b5Z3ARatLfmTN8iF0Z+9Tb0L9w5
         L5u8EEswGt+4IiuiuDQJHCyl9xBWiRQaynteNmuuSZq/tMr9bXq+Gm8/9fJ8cgtIhYbY
         DCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mx7NI6E/Mm/JogOIl1TWVxVDNVMkeldQPY6r+Z3Yj3I=;
        b=WJ+UhZRVVMM4VVZh+Mw7cdAXmX9GQPZ+5gfstOnAMpAEKC6vmZJNE4VtQWigOR1IQq
         S7jzxrcyMZmP/oBcB9mNKkbM304JKhcDDUwmFYwW8NdRUKu1Vscmm5RFrUXSCFCdjJC4
         aLNNak2qMD4xGx/CPA6qYzo5fEn9jJ2O9+PKMZfGZPi053lwKoHUFJ++NvFnckcgrAuZ
         7j6FSmR4hDYNeDwFeNa/5Np6nXwT5MBep+sx3aCz1nD6LKoH4Zku2V/1X7sAGnpzMrLo
         K15ji3otiR88S9VZF2VYNCS0xnStWqbWOXh9L1LQcEHxC/ASlmI2SIMl5N8cWvS9O+Gx
         k+CA==
X-Gm-Message-State: ANhLgQ3A/eFDkw3ht5zKMWjo6PO97bzZ2ungE6T5913JsTPYeDrEHcKq
        uHtkjZvTZ3DL5BvmTfhBf2Fq/+w79wM=
X-Google-Smtp-Source: ADFU+vvLISinJ4QTXuGIN6958ItQkkk/VUYeQLOQHTL+1aniW2Vx3fBMdZ+rzpcAAG2AoD9XYkpvNA==
X-Received: by 2002:aa7:85d8:: with SMTP id z24mr1698643pfn.202.1583196988298;
        Mon, 02 Mar 2020 16:56:28 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b21sm23218500pfp.0.2020.03.02.16.56.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 16:56:27 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 5/5] Bluetooth: Add BT_MODE socket option
Date:   Mon,  2 Mar 2020 16:56:23 -0800
Message-Id: <20200303005623.18917-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200303005623.18917-1-luiz.dentz@gmail.com>
References: <20200303005623.18917-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds BT_MODE socket option which can be used to set L2CAP modes,
including modes only supported over LE which were not supported using
the L2CAP_OPTIONS.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/bluetooth.h |  2 +
 net/bluetooth/l2cap_sock.c        | 74 +++++++++++++++++++++++++------
 2 files changed, 63 insertions(+), 13 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 1576353a2773..c361ec7b06aa 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -139,6 +139,8 @@ struct bt_voice {
 #define BT_PHY_LE_CODED_TX	0x00002000
 #define BT_PHY_LE_CODED_RX	0x00004000
 
+#define BT_MODE			15
+
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
 __printf(1, 2)
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 958c1575d4f2..09f40a75afe8 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -655,6 +655,21 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 			err = -EFAULT;
 		break;
 
+	case BT_MODE:
+		if (!enable_ecred) {
+			err = -ENOPROTOOPT;
+			break;
+		}
+
+		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
+			err = -EINVAL;
+			break;
+		}
+
+		if (put_user(chan->mode, (u8 __user *) optval))
+			err = -EFAULT;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -680,6 +695,28 @@ static bool l2cap_valid_mtu(struct l2cap_chan *chan, u16 mtu)
 	return true;
 }
 
+static int l2cap_set_mode(struct l2cap_chan *chan, u8 mode)
+{
+	switch (chan->mode) {
+	case L2CAP_MODE_LE_FLOWCTL:
+		break;
+	case L2CAP_MODE_BASIC:
+		clear_bit(CONF_STATE2_DEVICE, &chan->conf_state);
+		break;
+	case L2CAP_MODE_ERTM:
+	case L2CAP_MODE_STREAMING:
+		if (!disable_ertm)
+			break;
+		/* fall through */
+	default:
+		return -EINVAL;
+	}
+
+	chan->mode = mode;
+
+	return 0;
+}
+
 static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 				     char __user *optval, unsigned int optlen)
 {
@@ -729,19 +766,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 			break;
 		}
 
-		chan->mode = opts.mode;
-		switch (chan->mode) {
-		case L2CAP_MODE_LE_FLOWCTL:
-			break;
-		case L2CAP_MODE_BASIC:
-			clear_bit(CONF_STATE2_DEVICE, &chan->conf_state);
-			break;
-		case L2CAP_MODE_ERTM:
-		case L2CAP_MODE_STREAMING:
-			if (!disable_ertm)
-				break;
-			/* fall through */
-		default:
+		if (l2cap_set_mode(chan, opts.mode)) {
 			err = -EINVAL;
 			break;
 		}
@@ -999,6 +1024,29 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		break;
 
+	case BT_MODE:
+		if (!enable_ecred) {
+			err = -ENOPROTOOPT;
+			break;
+		}
+
+		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
+			err = -EINVAL;
+			break;
+		}
+
+		if (get_user(opt, (u8 __user *) optval)) {
+			err = -EFAULT;
+			break;
+		}
+
+		if (l2cap_set_mode(chan, opt)) {
+			err = -EINVAL;
+			break;
+		}
+
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
-- 
2.21.1

