Return-Path: <SRS0=EGLw=5L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C14EC43331
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Mar 2020 20:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048CE20775
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Mar 2020 20:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ST9dT7sF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgCZUWI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Mar 2020 16:22:08 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39998 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbgCZUWI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Mar 2020 16:22:08 -0400
Received: by mail-pj1-f65.google.com with SMTP id kx8so2879494pjb.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2020 13:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R9TlusWVcZn2L9hX+mfQCzeDFS8UOCkgUkV8/salwRs=;
        b=ST9dT7sFPUULhPqP6aJ1OUaWUq0tl+jRQEOu+w45KgXpkQH5N/hns6kaBhmeQbntal
         iSh//DodhFy8eX04sMt5EmM6+vJGnEWbNsh6hLmhgE4JANIIAmri11o8TJO7K4WcdoRM
         bT2SILR7QVlXhAsk1DqFbI4EvgdEzh1LXtDdyzMaSZX17LfDilTOMbRXiyqPCZTCuG3O
         utHSWo8SOThiid4IEKiwiFkikpablQKj75du3kGtRefCRte7WdzvJJsL1H/eGKmHUpva
         7ra0NKKf3hvhDaxoRdkK1c7dk41MwccIM/ITVd/D58Jkf9J7ZpxMGIPQyOmEF6m7OnJv
         Qesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R9TlusWVcZn2L9hX+mfQCzeDFS8UOCkgUkV8/salwRs=;
        b=SEo1maQZvKpYh6Uo6OVW8xIBZMXOMMgGBcG6gCadNkcdbG247FWLXsUeqJCnOygJBE
         4kM28uIqfQIKFFA2/8O/BBynhTS23tVtKuLxVFZOtxcVgpsGtreTogz4jBBKRHfDjKnn
         X2fFB0Ilwwx9b1kvdsGqmIDw1S9FzLPpMCWt2n1hVcn6cKA/t99gJDL5sgeGt8DiqNYS
         6LfdZCOzIdZgd8/Qt8UV6iyu5hn7avwSqH5rK2z95Bc08ttZpBPrPgpXjVu2dFjhvbmv
         NjEUysxKe+bhWZGILoj6vh4axaebmwrnJmjJuXT9FG4lW1QUmqY7N5gWvNhL6DDfpCHt
         hMww==
X-Gm-Message-State: ANhLgQ2UBpSbcXXKILmYpbukWX0PUO8+CXhPgYZmW1GNb+UmFhE4Y5W5
        7RGUbcjnPcx0/XGvr8SppmavmCJW
X-Google-Smtp-Source: ADFU+vstubJJyS9EUvt7hYHnIu9nl+6f5LyF3NhTmMbBjqnNPztjVHlgK6HydeBoDXLUJXd6+5J2DA==
X-Received: by 2002:a17:902:b48b:: with SMTP id y11mr8075465plr.131.1585254124439;
        Thu, 26 Mar 2020 13:22:04 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id u14sm2370377pfh.220.2020.03.26.13.22.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 13:22:03 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add BT_MODE socket option
Date:   Thu, 26 Mar 2020 13:22:02 -0700
Message-Id: <20200326202202.17244-1-luiz.dentz@gmail.com>
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
 include/net/bluetooth/bluetooth.h |   8 ++
 net/bluetooth/l2cap_sock.c        | 120 +++++++++++++++++++++++++++++-
 2 files changed, 127 insertions(+), 1 deletion(-)

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
index 117ba20ea194..7c863dc8fe6d 100644
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
@@ -424,6 +442,13 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname,
 			break;
 		}
 
+		/* L2CAP_MODE_LE_FLOWCTL and L2CAP_MODE_EXT_FLOWCTL are not
+		 * supported by L2CAP_OPTIONS.
+		 */
+		if (chan->mode == L2CAP_MODE_LE_FLOWCTL ||
+		    chan->mode == L2CAP_MODE_EXT_FLOWCTL)
+			return -EINVAL;
+
 		memset(&opts, 0, sizeof(opts));
 		opts.imtu     = chan->imtu;
 		opts.omtu     = chan->omtu;
@@ -508,7 +533,7 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 	struct bt_security sec;
 	struct bt_power pwr;
 	u32 phys;
-	int len, err = 0;
+	int len, mode, err = 0;
 
 	BT_DBG("sk %p", sk);
 
@@ -624,6 +649,27 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
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
@@ -763,6 +809,45 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
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
@@ -968,6 +1053,39 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 
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

