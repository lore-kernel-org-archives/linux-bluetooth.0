Return-Path: <SRS0=n6SA=5M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0947DC2D0ED
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 18:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98DE20737
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 18:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Twf8esCz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgC0ScU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Mar 2020 14:32:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43044 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgC0ScU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Mar 2020 14:32:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id u12so4957719pgb.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2020 11:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PeomgFt/4PzAeQvZ3T8Vw2w3OTfvbrlmpk0hsxuwrlQ=;
        b=Twf8esCzJPfilsgCBuNJcbh8Q19algpbvLIOowPZmJC1G3UqQErfzw3Yb2rZNuS+um
         mEsWQ4HlRoPJl6tg0wb6Phz8qu2TfS83A0w7I65asLt3IGkNzffj1f4no9Gu2BuvnVek
         4QJFUvK6O1tMYLegvSSNCdgvqO0hwe7pCFDqzLNH2AlusEuEW2jCCHoBig3+IrM+ro0S
         7guEOCwMYavd5kGPVoaS7iBZYE3LKblqvSC9tb5r+1Yy5Osii0AKxNb5Y1KwynsQBO4y
         J1RNF8V72oSJfxE41ENGsGIDQ24GtJfnnbu6Qy+AlSCYKkwfbtloeZm42DJwuyv7CwXt
         V7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PeomgFt/4PzAeQvZ3T8Vw2w3OTfvbrlmpk0hsxuwrlQ=;
        b=YkHRA9fLZxFit9rAuyv+4+wGkg9+Sz/5SZ9c6QWa+waT9Fpk579ut9Ix8qPUyxhRrV
         iJFLtVZXrr0bEhwUPuIha1/+tYmcnWkKkhGK1C3BmLwIkgLeiJt9X+5sQ2Ka3g68a9/L
         89dhTyRJQ1FFJFSKVXCGhAEy0XXWGIaxSxjTFLFfd//Tuco17xPTDH7lnc6DdUQgX6EC
         yoIkox0umy3sl+C/SttZLiAhRIHH9D0G/W7/dFjSodcd2u5idYrq5bTjJQMuCWVvidP2
         tC+OzzqyY7TH4bcLXX4ThaFj3Rb70E4GEe0pnHqLY/Wi3krcPIf2dwc5Vlsz80zncqvl
         86sg==
X-Gm-Message-State: ANhLgQ3QY5YQd2Ad/ykUTDhNEB5l4jA4goKQsUcuy2jjhGKKZx5GStoc
        c0LVuPC4kvZlCDL1yj7kkfvTjy5e
X-Google-Smtp-Source: ADFU+vswH5Sx0UJPa5Xbtj/1XoJUsaL9o5GzhQgSN9MxjjZBSbR2LMiyhRWMH36iaryE8znLU7naQQ==
X-Received: by 2002:a63:79c2:: with SMTP id u185mr613267pgc.136.1585333938369;
        Fri, 27 Mar 2020 11:32:18 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x71sm4606406pfd.129.2020.03.27.11.32.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 11:32:17 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: Add BT_MODE socket option
Date:   Fri, 27 Mar 2020 11:32:15 -0700
Message-Id: <20200327183215.27201-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200327183215.27201-1-luiz.dentz@gmail.com>
References: <20200327183215.27201-1-luiz.dentz@gmail.com>
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
 include/net/bluetooth/bluetooth.h |   8 +++
 net/bluetooth/l2cap_sock.c        | 113 +++++++++++++++++++++++++++++-
 2 files changed, 120 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 1576353a2773..3fa7b1e3c5d9 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -139,6 +139,14 @@ struct bt_voice {
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
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
 __printf(1, 2)
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index cfb402645c26..1cea42ee1e92 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -395,6 +395,24 @@ static int l2cap_sock_getname(struct socket *sock, struct sockaddr *addr,
 	return sizeof(struct sockaddr_l2);
 }
 
+static int l2cap_get_mode(struct l2cap_chan *chan)
+{
+	switch (chan->mode) {
+	case L2CAP_MODE_BASIC:
+		return BT_MODE_BASIC;
+	case L2CAP_MODE_ERTM:
+		return BT_MODE_ERTM;
+	case L2CAP_MODE_STREAMING:
+		return BT_MODE_STREAMING;
+	case L2CAP_MODE_LE_FLOWCTL:
+		return BT_MODE_LE_FLOWCTL;
+	case L2CAP_MODE_EXT_FLOWCTL:
+		return BT_MODE_EXT_FLOWCTL;
+	}
+
+	return -EINVAL;
+}
+
 static int l2cap_sock_getsockopt_old(struct socket *sock, int optname,
 				     char __user *optval, int __user *optlen)
 {
@@ -522,7 +540,7 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 	struct bt_security sec;
 	struct bt_power pwr;
 	u32 phys;
-	int len, err = 0;
+	int len, mode, err = 0;
 
 	BT_DBG("sk %p", sk);
 
@@ -638,6 +656,27 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
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
+		mode = l2cap_get_mode(chan);
+		if (mode < 0) {
+			err = mode;
+			break;
+		}
+
+		if (put_user(mode, (u8 __user *) optval))
+			err = -EFAULT;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -780,6 +819,45 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
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
@@ -985,6 +1063,39 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 
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
+		BT_DBG("mode 0x%2.2x", chan->mode);
+
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
-- 
2.21.1

