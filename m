Return-Path: <SRS0=jOg2=5D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1F5C4332B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 21:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47BE2076C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 21:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ofja3qwT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgCRVu0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Mar 2020 17:50:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33479 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgCRVu0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Mar 2020 17:50:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id n7so221559pfn.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2020 14:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZAyGOugfIgw0cKIX3yXfkJNq+sqpEzA47kWp1D5i46E=;
        b=Ofja3qwTAHWaUzxM2VN2QMR8N8fhLJtDycTxUCi/4cehDzkd8USgX2sqAJEsmIzrCx
         ZcBN9RtGK3qOSWqwXzCMmXfdtk9wKn4Gl/7nBwIhZoJYmHxAFzKjcGkdZNUXWlkM414U
         YbczF9eHvwvejIG3Os33wx5mn2Zzg1/NwhhtKqJiz/7XUnNKFmslhhlRuliXs16e6Tn3
         vqlMlw+QFC4R3KsoRzqPH4rbJDOHlGWea6QvCXGHGw7HwafTWWokgAcI4aCZzlaB+kab
         WxSIVhtEcuKC606P1gkPlRx6JGPUSXl8IbUlUVIZrdrBN1h0Tv9EjSnqDFzUx96Zs39V
         xfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZAyGOugfIgw0cKIX3yXfkJNq+sqpEzA47kWp1D5i46E=;
        b=PAaSvUGtMgKfBj7UyoAg6i8iwb4d1mi/Zw4C8hAfkOQDDhApPcZ29PYPtYr4Qah2uZ
         8XTBppQmYhtV5DXADuizp/7Dwv43lKzuij54jC0P5gRlSP5/VSR89Vv80/q4EaGxAbDa
         o/+ds13e4bEPq4l/TUcHe+zx0unMzai8fxrO540lOrSoziqpXOSAUAGfEs6WxK82ukpK
         HqOr1Iv9Md0TJ6QFMX1i4IcQntdS/91+/yLdfabIRmaLIpRPlMaPENFOsoFls05sPKBY
         n18vi0Bpvb4PjATvuo3ZxzyHvnqvfA1JxRuz2zd743mcz1XlNYFGmQeuuK1+D/KmdNEg
         nTUw==
X-Gm-Message-State: ANhLgQ18+BifilSw4W6Uk6bxpYqEI5sXQj6T9Z00t3ZejHB9DZNQv7FW
        ttuBKTk2/8yGaNZfZ7pDjpJxJPtv
X-Google-Smtp-Source: ADFU+vtOd3cqkMoOUghvH5eJ11ArEd0HG7fJSk5fPJIdozUGFiwJCgqvHJ5Bhv+gm5JXQdg8OumKXA==
X-Received: by 2002:aa7:9511:: with SMTP id b17mr370890pfp.243.1584568224441;
        Wed, 18 Mar 2020 14:50:24 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id l11sm3273191pjy.44.2020.03.18.14.50.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 14:50:23 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/3] Bluetooth: Add BT_MODE socket option
Date:   Wed, 18 Mar 2020 14:50:19 -0700
Message-Id: <20200318215019.21494-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200318215019.21494-1-luiz.dentz@gmail.com>
References: <20200318215019.21494-1-luiz.dentz@gmail.com>
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
 net/bluetooth/l2cap_sock.c        | 96 +++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 1576353a2773..34191e34bfdc 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -139,6 +139,17 @@ struct bt_voice {
 #define BT_PHY_LE_CODED_TX	0x00002000
 #define BT_PHY_LE_CODED_RX	0x00004000
 
+#define BT_MODE			15
+
+#define BT_MODE_BASIC		0x00
+#define BT_MODE_RETRANS		0x01
+#define BT_MODE_FLOWCTL		0x02
+#define BT_MODE_ERTM		0x03
+#define BT_MODE_STREAMING	0x04
+#define BT_MODE_EXT_FLOWCTL	0x05
+
+#define BT_MODE_LE_FLOWCTL	0x80
+
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
 __printf(1, 2)
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 117ba20ea194..f2bb376c699f 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -500,6 +500,25 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname,
 	return err;
 }
 
+static u8 l2cap_get_mode(struct l2cap_chan *chan)
+{
+	switch (chan->mode) {
+	case L2CAP_MODE_BASIC:
+	case L2CAP_MODE_RETRANS:
+	case L2CAP_MODE_FLOWCTL:
+	case L2CAP_MODE_ERTM:
+	case L2CAP_MODE_STREAMING:
+		/* Mode above are the same on both old and new sockopt */
+		return chan->mode;
+	case L2CAP_MODE_LE_FLOWCTL:
+		return BT_MODE_FLOWCTL;
+	case L2CAP_MODE_EXT_FLOWCTL:
+		return BT_MODE_EXT_FLOWCTL;
+	}
+
+	return chan->mode;
+}
+
 static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 				 char __user *optval, int __user *optlen)
 {
@@ -508,6 +527,7 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 	struct bt_security sec;
 	struct bt_power pwr;
 	u32 phys;
+	u8 mode;
 	int len, err = 0;
 
 	BT_DBG("sk %p", sk);
@@ -624,6 +644,23 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
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
+
+		if (put_user(mode, (u8 __user *) optval))
+			err = -EFAULT;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -763,6 +800,36 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 	return err;
 }
 
+static int l2cap_set_mode(struct l2cap_chan *chan, u8 mode)
+{
+	switch (mode) {
+	case BT_MODE_BASIC:
+		clear_bit(CONF_STATE2_DEVICE, &chan->conf_state);
+		break;
+	case BT_MODE_FLOWCTL:
+		if (bdaddr_type_is_le(chan->src_type))
+			mode = L2CAP_MODE_LE_FLOWCTL;
+		break;
+	case BT_MODE_EXT_FLOWCTL:
+		/* TODO: Add support for ECRED PDUs to BR/EDR */
+		if (!bdaddr_type_is_le(chan->src_type))
+			return -EINVAL;
+		mode = L2CAP_MODE_EXT_FLOWCTL;
+		break;
+	case BT_MODE_ERTM:
+	case BT_MODE_STREAMING:
+		if (!disable_ertm || bdaddr_type_is_le(chan->src_type))
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
 static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 				 char __user *optval, unsigned int optlen)
 {
@@ -968,6 +1035,35 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		break;
 
+	case BT_MODE:
+		if (!enable_ecred) {
+			err = -ENOPROTOOPT;
+			break;
+		}
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

