Return-Path: <SRS0=7F+K=5F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7178AC43332
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 20:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A0B20724
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 20:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pbwy+ehT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgCTUkc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Mar 2020 16:40:32 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38115 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgCTUkc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Mar 2020 16:40:32 -0400
Received: by mail-pj1-f68.google.com with SMTP id m15so2992695pje.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2020 13:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GkNcLk5if4krhXBmuI6AKGR91mSf4kdJ65783r5tpkE=;
        b=Pbwy+ehTubqCEWox6ekNmHhGwam9JzO9zOXRJ6Nd1dZ/SnDypubuslgrwnREoaXYpQ
         /kUfLYh92NCmVCwEzivFfYv4Y+NYuKr0T7XjJVkbYQqznGf6rKPxoleZ0GxYg8p+S7rl
         717T9nRfXr7zlf3r5EZo2/md3XOvEqpeKpTXfgT2nkZH7YVIM6Ih/vYJvh1rNerHaTvz
         Cdb5mNCYr9NDSeQfYX2yISvMGDZSwXUrrf5GSXDzSmAwwONYX23z5GI5S9jEL/Uc8nc0
         HtDxGakUS0x516a65ew6VSKwORxR5cM8O+YBPE/f7CK8vlFQSzyyO8nPP0uCBwg3nR8p
         ez1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GkNcLk5if4krhXBmuI6AKGR91mSf4kdJ65783r5tpkE=;
        b=kKO4X4TGTUXUWSP975Y8jzyEB1icOSvHCwUVobNJpr5+7deQPc/Gxfr0k6xv9Gpx4l
         teXK2FM9+MMRJ0/bry3qPZGKPCTmzx6yoUzGkQk8Mr2QY9I9Ascb99ux62GYop+4sH5S
         adnRa0KxQuABvK/Bxk7mG0cfRHIl6iCsDL+ABnR2S4ZdMqSWBkt9MwCciVCN5y+DsMkN
         wGbH1e95arIujW6YXsJTHgkYuw/G4F0DLpuotGxnT292R+pJZ1Bv0yND83qnAtZYCizI
         1hczZUR3oLflsQVeCyD7JDRNEdmu0r15F7WbTYIGazh3LGwYkEECL/vdvfcic1sdzYW2
         xPCg==
X-Gm-Message-State: ANhLgQ15lz7B4rCVpNf0ZM4LeLpejjorr+3oCHL76WAtmELNci97l0KC
        qMBRafrDUv1ySAKvDX3b9WDvEEJC
X-Google-Smtp-Source: ADFU+vse0e+qdbk1s3UgUTmIidWUq8QgEqHC4Y5hZs5GctV00jIIBhkBIxF/cZvn39ev9aRJRqMKaw==
X-Received: by 2002:a17:902:b713:: with SMTP id d19mr10543796pls.270.1584736830914;
        Fri, 20 Mar 2020 13:40:30 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e187sm6048744pfe.143.2020.03.20.13.40.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 13:40:30 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 3/3] Bluetooth: Add BT_MODE socket option
Date:   Fri, 20 Mar 2020 13:40:26 -0700
Message-Id: <20200320204026.11680-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200320204026.11680-1-luiz.dentz@gmail.com>
References: <20200320204026.11680-1-luiz.dentz@gmail.com>
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
 include/net/bluetooth/bluetooth.h | 11 ++++
 include/net/bluetooth/l2cap.h     |  1 +
 net/bluetooth/l2cap_sock.c        | 99 +++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 1576353a2773..61694be4ade5 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -139,6 +139,17 @@ struct bt_voice {
 #define BT_PHY_LE_CODED_TX	0x00002000
 #define BT_PHY_LE_CODED_RX	0x00004000
 
+#define BT_MODE			15
+
+#define BT_MODE_BASIC		0x00
+#define BT_MODE_ERTM		0x01
+#define BT_MODE_STREAMING	0x02
+#define BT_MODE_LE_FLOWCTL	0x03
+#define BT_MODE_EXT_FLOWCTL	0x04
+
+/* Only used internally to detect if L2CAP_OPTIONS was used */
+#define BT_MODE_L2CAP_OPTIONS	0xff
+
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
 __printf(1, 2)
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index dada14d0622c..27a398f7a28d 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -723,6 +723,7 @@ struct l2cap_user {
 struct l2cap_pinfo {
 	struct bt_sock		bt;
 	struct l2cap_chan	*chan;
+	u8			mode;
 	struct sk_buff		*rx_busy_skb;
 };
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 117ba20ea194..d687392812a0 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -624,6 +624,29 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
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
+		/* Check if old sockopt was used which is not allowed since
+		 * not all modes are not compatible.
+		 */
+		if (l2cap_pi(sk)->mode == BT_MODE_L2CAP_OPTIONS) {
+			err = -EINVAL;
+			break;
+		}
+
+		if (put_user(l2cap_pi(sk)->mode, (u8 __user *) optval))
+			err = -EFAULT;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -715,6 +738,8 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 			break;
 		}
 
+		l2cap_pi(sk)->mode = BT_MODE_L2CAP_OPTIONS;
+
 		BT_DBG("mode 0x%2.2x", chan->mode);
 
 		chan->imtu = opts.imtu;
@@ -763,6 +788,45 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 	return err;
 }
 
+static int l2cap_set_mode(struct l2cap_chan *chan, u8 mode)
+{
+	switch (mode) {
+	case BT_MODE_BASIC:
+		if (bdaddr_type_is_le(chan->src_type))
+			return -EINVAL;
+		mode = L2CAP_MODE_BASIC;
+		clear_bit(CONF_STATE2_DEVICE, &chan->conf_state);
+		break;
+	case BT_MODE_ERTM:
+		if (!disable_ertm || bdaddr_type_is_le(chan->src_type))
+			return -EINVAL;
+		mode = L2CAP_MODE_ERTM;
+		break;
+	case BT_MODE_STREAMING:
+		if (!disable_ertm || bdaddr_type_is_le(chan->src_type))
+			return -EINVAL;
+		mode = L2CAP_MODE_STREAMING;
+		break;
+	case BT_MODE_LE_FLOWCTL:
+		if (!bdaddr_type_is_le(chan->src_type))
+			return -EINVAL;
+		mode = L2CAP_MODE_LE_FLOWCTL;
+		break;
+	case BT_MODE_EXT_FLOWCTL:
+		/* TODO: Add support for ECRED PDUs to BR/EDR */
+		if (!bdaddr_type_is_le(chan->src_type))
+			return -EINVAL;
+		mode = L2CAP_MODE_EXT_FLOWCTL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	chan->mode = mode;
+
+	return 0;
+}
+
 static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 				 char __user *optval, unsigned int optlen)
 {
@@ -968,6 +1032,41 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		break;
 
+	case BT_MODE:
+		if (!enable_ecred) {
+			err = -ENOPROTOOPT;
+			break;
+		}
+
+		BT_DBG("sk->sk_state %u", sk->sk_state);
+
+		if (sk->sk_state != BT_BOUND) {
+			err = -EINVAL;
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
+		BT_DBG("opt %u", opt);
+
+		err = l2cap_set_mode(chan, opt);
+		if (err)
+			break;
+
+		l2cap_pi(sk)->mode = opt;
+
+		BT_DBG("mode 0x%2.2x", chan->mode);
+
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
-- 
2.21.1

