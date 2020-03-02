Return-Path: <SRS0=RPtH=4T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1544C3F2D1
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Mar 2020 21:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE11F214DB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Mar 2020 21:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T49ptd1p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgCBVcl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:32:41 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:51922 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCBVcl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Mar 2020 16:32:41 -0500
Received: by mail-pj1-f67.google.com with SMTP id l8so364340pjy.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Mar 2020 13:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PsYqvu4OP5OhY0v0HTAxks1Yq6VOsFTAMVNjMdSYWj4=;
        b=T49ptd1pHjYPNVWkw55M8uCdvaU+JP2tLirXOFS3u3p6ZXUQHrV2v1sGyXCEW3cCPn
         U3ghD6b1RN8A/xezVJ/nrLpHKPAI1YVC2rx5OTRb5FAWdfxKGEGkUh0Qn3HUoNRxaGkw
         vw6E3ilCDlspPZRsKlhX8ZJ223H/7TFGXBg/S6rSugbN8Ze6VOYquoa7fFk6Nv3CT35v
         fpAMEyHNP9tXd8TAAwSAE2NpfKHbcy0rwdrYe7BaFKnT0tp/UtpxISFk+o8PEApzVVlG
         qW6hZNKZV0F38GwRsbRjxI++R/95fk7Eah7YoeLXXi9nioLae71ZXIh/wtUwVE6sXTw9
         SifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PsYqvu4OP5OhY0v0HTAxks1Yq6VOsFTAMVNjMdSYWj4=;
        b=nKNCQ6E6CtV/WRo4OaJFgNaYOPdSVpWk4opQEITZ9cLe8Ws+RnvJZ39MbVau6EDneB
         fxiwFBtDCfy+AXFRYxA6931Fy2DCq7FYYgEMce/ZE81aRBEYKdBsmKn4rd9jZ4/nnS2I
         ymjDmYtcf7BCdVBwwgdxuivzI0k5RVOuQ/52DktcqvOMxBpxlUEqXm1Hy6J7TmrxpxoY
         ZcTn6R1b99kRnA2p9VNiqQbXE9htU7GHJN/nUmD0tVVR7i+nBnBWKMz/ZUwi4DwtpYYp
         aufvDH5WFSN8cKvY+GmaNUtK3Ne8LHNf0ysX8b9J5EJ6dotFNALBHkG/wqSGIezBs/W3
         TKbw==
X-Gm-Message-State: ANhLgQ2N4V6eVO/nLGdqJBHZ19kdcJjQZqwj8KiIhiiGMarY8FmCLWan
        PgXKJjTt7Uu0aTGK/rfOIJz9mwdk4pk=
X-Google-Smtp-Source: ADFU+vuYz+mN/RcHCCWgZhdb9eEZrUlMmrrOYid2hK1kwMdpxp211Y34eIVyVXkZE9q+sEpNZDlmFA==
X-Received: by 2002:a17:902:8d85:: with SMTP id v5mr1099500plo.146.1583184759520;
        Mon, 02 Mar 2020 13:32:39 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id i22sm22183749pgi.69.2020.03.02.13.32.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 13:32:38 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/5] Bluetooth: Add BT_MODE socket option
Date:   Mon,  2 Mar 2020 13:32:33 -0800
Message-Id: <20200302213237.19540-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
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
v2: Make BT_MODE conditional to enable_ecred.

 include/net/bluetooth/bluetooth.h |  2 +
 net/bluetooth/l2cap_sock.c        | 64 ++++++++++++++++++++++++-------
 2 files changed, 53 insertions(+), 13 deletions(-)

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
index 305710446e66..640cb461af9d 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -616,6 +616,16 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 			err = -EFAULT;
 		break;
 
+	case BT_MODE:
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
@@ -641,6 +651,28 @@ static bool l2cap_valid_mtu(struct l2cap_chan *chan, u16 mtu)
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
@@ -690,19 +722,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
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
@@ -952,6 +972,24 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 		chan->imtu = opt;
 		break;
 
+	case BT_MODE:
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

