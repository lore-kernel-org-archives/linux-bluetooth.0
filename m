Return-Path: <SRS0=apyX=5I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A38C54FCE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Mar 2020 20:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D19212070A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Mar 2020 20:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pho5lJu6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgCWUfF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Mar 2020 16:35:05 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:33655 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgCWUfE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Mar 2020 16:35:04 -0400
Received: by mail-pj1-f68.google.com with SMTP id jz1so357994pjb.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Mar 2020 13:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JAYcqduz0KauwTZzTXsWerkhLl9bWjMX8JBZdT37+xY=;
        b=pho5lJu6S0DvmrspzXa4hYQskUTL2gH3D6MtlL+rOYkxKSnxbuEwr0GA826TKZSI79
         YGdboOSAQ7xzQHEPBlcOlaEvO6h5vNrrdcWxXbor4DlTR+74qq/zLTtlzeaB5odaN21D
         F9WtWUHExDWHTMRDxyX1gyilLXlC5Gs+PEWzGyHMz3M3jSPbhaQ2nd75RmRemA396eqy
         9xayd78iRXybgjCd7DTAVzzwj9G+DQPpfF/ttxAXRtNuI2ebgDa6qyb2d1xibP4GtzWh
         o9n8jtVkvSFP0xO/Pc621oMRNMAeYqcdEgngLCyu5Ub5k0vDO5ocvrXNziZ4EQ1jE79Q
         nOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JAYcqduz0KauwTZzTXsWerkhLl9bWjMX8JBZdT37+xY=;
        b=LJPRgigbrmgVDz+ZcRwvWKKtexAbxzv9yILJUCrkdQ8Ew8lnzcNGLYjvXWbhqC+A1p
         ZSojQrdrPldb4rNm2zko3l3ru4gCZxuHTd7/5yq61CAiBokXVbM84BBFck+XpuVhMnTc
         eE3CE5O6HFQnG/X9y+JbCjSUVNg59oLOwVnbeq3vaA8+MNfFvOzPGcNDYOqhbhh7x6vp
         fy5WaNXl79VCeI1cKWdrJlI68rhy2onapttZFKMpM/llAYwgkyfZaRCvbvoOPkSgoR+l
         lGs1Ubc4cAXNtTfHRidrnnAVwRPGX/fFPfGb9kHXvjgmmPwR0gaUGBc0weGPMShr9DGa
         +OGw==
X-Gm-Message-State: ANhLgQ0tYzSqgnW2OGkF0Z0DZ/Tjvnea3gGujcGUu7bkaUv6W49r23sp
        fQVNpZelFw/1k3rQKEF2U2CiGtcW
X-Google-Smtp-Source: ADFU+vtFzx0qKWQZdBu4XPMCE1lWuG15Xoae2+nSWxT7zenI/FiRMtCknYwJYNAglHRlr6dh6Z+tlw==
X-Received: by 2002:a17:902:6191:: with SMTP id u17mr12423581plj.113.1584995703408;
        Mon, 23 Mar 2020 13:35:03 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q71sm440469pjb.5.2020.03.23.13.35.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 13:35:02 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 3/3] Bluetooth: Add BT_MODE socket option
Date:   Mon, 23 Mar 2020 13:34:58 -0700
Message-Id: <20200323203458.24733-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200323203458.24733-1-luiz.dentz@gmail.com>
References: <20200323203458.24733-1-luiz.dentz@gmail.com>
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
 include/net/bluetooth/l2cap.h     |   6 ++
 net/bluetooth/l2cap_sock.c        | 124 ++++++++++++++++++++++++++++++
 3 files changed, 138 insertions(+)

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
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index dada14d0622c..56f727ba23bd 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -720,9 +720,15 @@ struct l2cap_user {
 /* ----- L2CAP socket info ----- */
 #define l2cap_pi(sk) ((struct l2cap_pinfo *) sk)
 
+#define L2CAP_PI_OPTION_UNSET		0x00
+#define L2CAP_PI_OPTION_LEGACY		0x01
+#define L2CAP_PI_OPTION_BT_MODE		0x02
+
 struct l2cap_pinfo {
 	struct bt_sock		bt;
 	struct l2cap_chan	*chan;
+	u8			option;
+	u8			bt_mode;
 	struct sk_buff		*rx_busy_skb;
 };
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 117ba20ea194..0a57101fe273 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -424,6 +424,14 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname,
 			break;
 		}
 
+		/* Check if BT_MODE was used which is not compatible with
+		 * L2CAP_OPTIONS.
+		 */
+		if (l2cap_pi(sk)->option == L2CAP_PI_OPTION_BT_MODE) {
+			err = -EINVAL;
+			break;
+		}
+
 		memset(&opts, 0, sizeof(opts));
 		opts.imtu     = chan->imtu;
 		opts.omtu     = chan->omtu;
@@ -624,6 +632,29 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
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
+		/* Check if L2CAP_OPTIONS was used which is not compatible with
+		 * BT_MODE.
+		 */
+		if (l2cap_pi(sk)->option == L2CAP_PI_OPTION_LEGACY) {
+			err = -EINVAL;
+			break;
+		}
+
+		if (put_user(l2cap_pi(sk)->bt_mode, (u8 __user *) optval))
+			err = -EFAULT;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -674,6 +705,14 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 			break;
 		}
 
+		/* Check if BT_MODE was used which is not compatible with
+		 * L2CAP_OPTIONS.
+		 */
+		if (l2cap_pi(sk)->option == L2CAP_PI_OPTION_BT_MODE) {
+			err = -EINVAL;
+			break;
+		}
+
 		opts.imtu     = chan->imtu;
 		opts.omtu     = chan->omtu;
 		opts.flush_to = chan->flush_to;
@@ -715,6 +754,8 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 			break;
 		}
 
+		l2cap_pi(sk)->option = L2CAP_PI_OPTION_LEGACY;
+
 		BT_DBG("mode 0x%2.2x", chan->mode);
 
 		chan->imtu = opts.imtu;
@@ -763,6 +804,45 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
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
@@ -968,6 +1048,50 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 
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
+		/* Check if L2CAP_OPTIONS was used which is not compatible with
+		 * BT_MODE.
+		 */
+		if (l2cap_pi(sk)->option == L2CAP_PI_OPTION_LEGACY) {
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
+		l2cap_pi(sk)->option = L2CAP_PI_OPTION_BT_MODE;
+		l2cap_pi(sk)->bt_mode = opt;
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

