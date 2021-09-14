Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED548C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Sep 2021 22:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D778D6115B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Sep 2021 22:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbhINWgN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Sep 2021 18:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236273AbhINWeQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Sep 2021 18:34:16 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE65C0613A2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Sep 2021 15:32:12 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id f21so384395plb.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Sep 2021 15:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gg7otFjtYtVZ2+qCS265cR1q6KivuSZ/uefc9EpNS9A=;
        b=XO/GkXJ8w2ZBMb7SMNbxWnIGTgKTR5BiFNGw1qsG0NFKBdHcrcxXSUGEBrlDgw1i+9
         7pfT2VjQdTHNR//tMdcGLKA7nU/zV/WqcfS9Ma+rAsXW6nhIRpE4maevQMC/Sh37DyME
         SVhJFuq4k9NjaCM61Pq5ZbFvUF3hEqA0ecbxFkXVFKD78oaX56KmZYyhRt6ZDnUgjxbo
         nG/FDbP1r64fXpEk+BnQVCRAWRhs9hjVpI0j/KGa/2PFsgbkC5zxpANSMGsAjjfNaqH6
         tta4X2WxubK+oeZfoE91+yTpSibDPx15/f9XbQnYlSgZcOaP2MeU/Ei6/u3gOoqvTqLr
         +ttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gg7otFjtYtVZ2+qCS265cR1q6KivuSZ/uefc9EpNS9A=;
        b=I9D2nHTtdyscWf+VIcI6eSEfOmDdhIjIhGy89zFBd7cCfSauyYC9fFxLdwzWDmcO7E
         Rv30THYBxmKlI9EjEzVWjat6j97TEXVicnGQKqtPoEjUJU8gnLINTzWihQHRss8XvUka
         m7Ar3cnjz81s91mNew30lxe2YvKY1zuJ/DqoWcvkRtjGUjRQjboSkVLCqllRoScKxx+b
         vzl5VOvY+Ws4EqVINKvojztfTmABfW1s6RK1mOY6jrXGIXU5bWGaDdqYbjZuVfjZIFqD
         ji/j28UL9fvBgZTC8ww6bP4utdRzOkKLuDIx42CvJpsmgkEgpYTxyC2laSaStLz30Tb+
         49Lw==
X-Gm-Message-State: AOAM533RkR98ZlhuyJaEA1uUcLZoUkgfcFdoNTq/xa/VQ8cpeagw5L/i
        hPrfgMwaD2/KVC2NTbp+ioOIhAG0qoo=
X-Google-Smtp-Source: ABdhPJxYRtDlLtMndPq/83Ux498BRuNh9+13n8WpL7JVFKNNXzeD1l2+LR9bz4FyDQNfhR+vqRmqLA==
X-Received: by 2002:a17:90a:ab94:: with SMTP id n20mr4756818pjq.146.1631658731670;
        Tue, 14 Sep 2021 15:32:11 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h16sm2532650pjt.30.2021.09.14.15.32.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 15:32:11 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: hci_sock: Add support for BT_{SND,RCV}BUF
Date:   Tue, 14 Sep 2021 15:32:10 -0700
Message-Id: <20210914223210.3861385-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for BT_{SND,RCV}BUF so userspace can set MTU based on
the channel usage.

Fixes: https://github.com/bluez/bluez/issues/201

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sock.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 31a2eefede3c..8cebf8a0e85d 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -57,6 +57,7 @@ struct hci_pinfo {
 	unsigned long     flags;
 	__u32             cookie;
 	char              comm[TASK_COMM_LEN];
+	unsigned int      mtu;
 };
 
 static struct hci_dev *hci_hdev_from_sock(struct sock *sk)
@@ -1374,6 +1375,10 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 		break;
 	}
 
+	/* Default MTU to HCI_MAX_FRAME_SIZE if not set */
+	if (!hci_pi(sk)->mtu)
+		hci_pi(sk)->mtu = HCI_MAX_FRAME_SIZE;
+
 	sk->sk_state = BT_BOUND;
 
 done:
@@ -1704,7 +1709,7 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (flags & ~(MSG_DONTWAIT | MSG_NOSIGNAL | MSG_ERRQUEUE | MSG_CMSG_COMPAT))
 		return -EINVAL;
 
-	if (len < 4 || len > HCI_MAX_FRAME_SIZE)
+	if (len < 4 || len > hci_pi(sk)->mtu)
 		return -EINVAL;
 
 	skb = bt_skb_sendmsg(sk, msg, len, len, 0, 0);
@@ -1899,6 +1904,16 @@ static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
 		}
 		break;
 
+	case BT_SNDMTU:
+	case BT_RCVMTU:
+		if (copy_from_sockptr(&opt, optval, sizeof(u16))) {
+			err = -EFAULT;
+			break;
+		}
+
+		hci_pi(sk)->mtu = opt;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -1968,6 +1983,12 @@ static int hci_sock_getsockopt(struct socket *sock, int level, int optname,
 			err = -EFAULT;
 		break;
 
+	case BT_SNDMTU:
+	case BT_RCVMTU:
+		if (put_user(hci_pi(sk)->mtu, (u32 __user *)optval))
+			err = -EFAULT;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
-- 
2.31.1

