Return-Path: <SRS0=41cZ=45=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B5DC4CECE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 22:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C32206CD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 22:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiwjsbFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgCLWZA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:25:00 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:51245 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgCLWZA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Mar 2020 18:25:00 -0400
Received: by mail-pj1-f65.google.com with SMTP id y7so3129197pjn.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2020 15:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Kg0x0dz+SacJF75cgIcqz+u2Ra2gW+cK0VSXXQAL0Lk=;
        b=YiwjsbFU2pLvMcUkatMu+bJL0gUSWG61w8Jo/qqpFKI0tDMQrGhceO0rUFNUeDujE+
         8VUIexjG96eqSjWWhN8QS6hMD/wjk89hJGUhkKxqio9xIb2gBG5ydujGaIxdCEoj3eyx
         L9Y3axrgv1Cpa8qcIQyBWv4ZP5DnE30e9k/J3dU2Not10bCBwEATwX/4cDh7sa8b4xT0
         wdBaWr1qJUF27B1lWx+EjuBdtUljQiFV3ncIIyApSvpotU4KNIUZqvYLlr/jHPRUXoTC
         l3gHCJNYOtfgz38ZunUA3yRr8LpP4uo2elqrJEzv+DlMzIDjPAY+KZWgOeG6+gi6FFEP
         yINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kg0x0dz+SacJF75cgIcqz+u2Ra2gW+cK0VSXXQAL0Lk=;
        b=jZ8+X1rIdYMmG1Z+LuSICUvGKl5xTm5uu7Pjb8KptfaSvx2Mzez3ZHegRs5yhRHM6l
         NfGD3PFljxiSFBUXFI3oNkXoYlrNIR/Pz+ZX5wxV/IHTS5XZerx5hD5uGYXt4fEkNOVm
         4Lzu0z/uFukxSPuVKdIYZsmWhwKrS5iZpRcSA6dZhjAwOltM28/mnDgj57p071RZzN/M
         ljhH9E/W8ju02YDmOC3dbLj+ih0LQTHPzM0RjjZW8ltdTX7KHn8oxWA0FaFUEE1PfiaL
         C6YN1R5yk6gygMbR4p/m7G/CV/TtJl9KuKnqB0WiomxHyncuJ2TZEt7JFUiBF3eIJ+PC
         L9sg==
X-Gm-Message-State: ANhLgQ0kawfZi3JUE6wUzkfGSMWHUN5txwAtOXPHrK8BYwK6yXJY3H99
        Qo3G8gzWD6f7E7+ZmOVrrfTFovGvdH4=
X-Google-Smtp-Source: ADFU+vv3c3IliduJ8vvaK1GFSHbqSQ35k82hKnKw45dqjKRnJscv8yuNkSnd87r1A7EnvBfXDX+vfg==
X-Received: by 2002:a17:902:8608:: with SMTP id f8mr10172515plo.110.1584051899170;
        Thu, 12 Mar 2020 15:24:59 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x190sm56827659pfb.96.2020.03.12.15.24.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 15:24:58 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Add BT_MODE socket option
Date:   Thu, 12 Mar 2020 15:24:54 -0700
Message-Id: <20200312222454.5079-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200312222454.5079-1-luiz.dentz@gmail.com>
References: <20200312222454.5079-1-luiz.dentz@gmail.com>
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
 net/bluetooth/l2cap_sock.c        | 79 +++++++++++++++++++++++++------
 2 files changed, 66 insertions(+), 15 deletions(-)

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
index e43a90e05972..7a8a199c373d 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -619,6 +619,21 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
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
@@ -644,6 +659,29 @@ static bool l2cap_valid_mtu(struct l2cap_chan *chan, u16 mtu)
 	return true;
 }
 
+static int l2cap_set_mode(struct l2cap_chan *chan, u8 mode)
+{
+	switch (chan->mode) {
+	case L2CAP_MODE_LE_FLOWCTL:
+	case L2CAP_MODE_EXT_FLOWCTL:
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
@@ -693,22 +731,9 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
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
-			err = -EINVAL;
+		err = l2cap_set_mode(chan, opts.mode);
+		if (err)
 			break;
-		}
 
 		BT_DBG("mode 0x%2.2x", chan->mode);
 
@@ -963,6 +988,30 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 
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

