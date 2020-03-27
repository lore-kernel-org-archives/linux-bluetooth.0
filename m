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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67476C2D0E5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 18:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36CA72073B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 18:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONEe9vWZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgC0ScJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Mar 2020 14:32:09 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42942 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgC0ScJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Mar 2020 14:32:09 -0400
Received: by mail-pl1-f195.google.com with SMTP id e1so3744491plt.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2020 11:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R9TlusWVcZn2L9hX+mfQCzeDFS8UOCkgUkV8/salwRs=;
        b=ONEe9vWZn7m3ZBPQo5LhGPJm4UdJlYbkpUsRdl6VoeQGJ0CCvxQLHFh1papZKVnrmK
         VzW7VX60xxjX1yqJiSOp+Rqw/09jrsbC37de5NKhpGOy4WEmmNbGDvU/s0BfRS8RFIjt
         LfBns8pS1nreg4VD3hn1rjU6D6fGeqsV7Ui7leqKVPd1HQZWfkW86VQ+pwUTiHCfp7oZ
         taDbS8tcOzieq6qSgm4PGJSFrPkDA30EUG1IL445LLh/wKF/2x5st0MQl5PTMPa/HU/e
         YdyJYDgX378GO2KfGwWFZUoMJSEnj5l7s1HrEIOg4rw0ZQ4YANsyOvIeh8amQQddjTSS
         sYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R9TlusWVcZn2L9hX+mfQCzeDFS8UOCkgUkV8/salwRs=;
        b=f/nwjGpocZojFw3wP5NB91OnmKjhCweIywRcv/NZhCbxFnGJXVJXMBJOmAxJtoQ+B1
         WTtf/hM/bj52WR4tP6Lti11fktFRbjPN9LgIvNO8O9ojm67jAzIMDn++YsJSg+h9L9DL
         bxPz6SQKm1jR4ArNGdPdm4NaWMvaWJovJN7eQ7BpS5lsMr9YpvcBXTE3gdgiz6n7/iz7
         jNf/FlDlbl2j26ATPI2CceZGzOaaHiX/Gmq2PTTuwgFWMMY+hXE8c0lnXGzeKnQOZYWV
         nMN/uq2WtWnwuG6RJlz6agdzt/GQG6IMeoWhplxaD6BwNUErIucsaMWx/gmi5tTes18+
         O8dA==
X-Gm-Message-State: ANhLgQ3ImL89xBAc9Ib5lxVAydsVZVrL4ZZdqNUbLVDoQWDsWkU04H9u
        /wVWEX8iqTSjTvT0PD4KASPo2djs
X-Google-Smtp-Source: ADFU+vvZkW/LVbM1EUJge1cqDUgfW9eHDVs1cA5P9CSsOSN0bQyoLzMGXPZ4Sk6NKLtn0NOfJde9jA==
X-Received: by 2002:a17:90b:4d07:: with SMTP id mw7mr793721pjb.103.1585333927742;
        Fri, 27 Mar 2020 11:32:07 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id bt19sm4311890pjb.3.2020.03.27.11.32.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 11:32:06 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add BT_MODE socket option
Date:   Fri, 27 Mar 2020 11:32:03 -0700
Message-Id: <20200327183205.27057-1-luiz.dentz@gmail.com>
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

