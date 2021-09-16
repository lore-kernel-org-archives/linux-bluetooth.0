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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FF6C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 18:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EDC7611EE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 18:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242496AbhIPS4i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Sep 2021 14:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240272AbhIPS4e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Sep 2021 14:56:34 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8D8C043085
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 11:03:37 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id mv7-20020a17090b198700b0019c843e7233so1630042pjb.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 11:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZHQlz26jaEu1gmEy0PeaVKBbbell8in7/qkbLSGDUd8=;
        b=a6RWer4kCKt1fTViElLyvMNQTc9ymWq1nj4GEnoMmrq1HZ5KuTNHiT4tuAGm9S2ZHH
         KwbV/8r5aQxwKeIPfJIhufMPy+U7FvjgQHQchyR5cHVo8vMbBAyzB9aFGQftYqkZU2eU
         FUu0MPpaW5FKf++oniVhUYMzSZ8AbgafGBq/SGv5NcL2AoY4NKHtXsNpE1jMP8cb7AjX
         dU8nbYa0KsdQdIv+sObXnWfyQgMycOhB2dVa/z3t0pgU8loQ6PGLztKoG/fApg50VYJW
         jfLXgFmf6xrxAULDje86i2xxsJ/VXfHH6fM5+OyxeLtxkh0SPzCNylGZ/jb7nks9q1yG
         iJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZHQlz26jaEu1gmEy0PeaVKBbbell8in7/qkbLSGDUd8=;
        b=HHaKSyQNVaZ/6WQfK86BQAkiEGi1J1Fd1/0GuUSTwb0XyLDIXMbGXHEM2UzWDU5SgB
         iy5Sk19Salf27EAO1vWLgoiKY0WS3TT4PvoAz/DWD0t69Alm0IK5AKE2scWtwm37UwZg
         CaP1P/XXKsSSqVTJMC0JyxigCGNHJrBdPbq6gE8XTgqeNFx/dyiZsaZ2Cl2WRHDt2w9Y
         nOa3CI1TaORkXVOPka201p5YlXI0+wBehhYrRI/0U1n394BcRw2rtKbS0vu8GGHmMzhr
         eCR/5T0Pg/VGGCrdWP58pr84JudZvrSo2iZvawT5dlsVXo6zZqLEWxhCNdZDlEevbNTu
         fjkg==
X-Gm-Message-State: AOAM533Mo6hIlglKyOo6aWzIFIz+TeoeJ+RuY0BTTHMUG7DY0o/Uu0w0
        jvGcp0Zih/kx75v/kWTgBAIWwCmz84w=
X-Google-Smtp-Source: ABdhPJyiSI/O4qcM6R/7T72srehYZxXeRBtLNMfqlXE9QZpduspdvAYhtq4xmwdudGggJ1uvu7hXTQ==
X-Received: by 2002:a17:902:8d85:b0:13c:92f9:ac3c with SMTP id v5-20020a1709028d8500b0013c92f9ac3cmr5917679plo.42.1631815416542;
        Thu, 16 Sep 2021 11:03:36 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p24sm3580432pfh.136.2021.09.16.11.03.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 11:03:36 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 1/4] Bluetooth: hci_sock: Add support for BT_{SND,RCV}BUF
Date:   Thu, 16 Sep 2021 11:03:32 -0700
Message-Id: <20210916180335.75976-1-luiz.dentz@gmail.com>
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
 net/bluetooth/hci_sock.c | 102 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 91 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 55b0d177375b..091e819ba40e 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -57,6 +57,7 @@ struct hci_pinfo {
 	unsigned long     flags;
 	__u32             cookie;
 	char              comm[TASK_COMM_LEN];
+	__u16             mtu;
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
@@ -1719,7 +1724,7 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (flags & ~(MSG_DONTWAIT | MSG_NOSIGNAL | MSG_ERRQUEUE | MSG_CMSG_COMPAT))
 		return -EINVAL;
 
-	if (len < 4 || len > HCI_MAX_FRAME_SIZE)
+	if (len < 4 || len > hci_pi(sk)->mtu)
 		return -EINVAL;
 
 	buf = kmalloc(len, GFP_KERNEL);
@@ -1849,8 +1854,8 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	goto done;
 }
 
-static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
-			       sockptr_t optval, unsigned int len)
+static int hci_sock_setsockopt_old(struct socket *sock, int level, int optname,
+				   sockptr_t optval, unsigned int len)
 {
 	struct hci_ufilter uf = { .opcode = 0 };
 	struct sock *sk = sock->sk;
@@ -1858,9 +1863,6 @@ static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
 
 	BT_DBG("sk %p, opt %d", sk, optname);
 
-	if (level != SOL_HCI)
-		return -ENOPROTOOPT;
-
 	lock_sock(sk);
 
 	if (hci_pi(sk)->channel != HCI_CHANNEL_RAW) {
@@ -1935,18 +1937,63 @@ static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
 	return err;
 }
 
-static int hci_sock_getsockopt(struct socket *sock, int level, int optname,
-			       char __user *optval, int __user *optlen)
+static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
+			       sockptr_t optval, unsigned int len)
 {
-	struct hci_ufilter uf;
 	struct sock *sk = sock->sk;
-	int len, opt, err = 0;
+	int err = 0, opt = 0;
 
 	BT_DBG("sk %p, opt %d", sk, optname);
 
-	if (level != SOL_HCI)
+	if (level == SOL_HCI)
+		return hci_sock_setsockopt_old(sock, level, optname, optval,
+					       len);
+
+	if (level != SOL_BLUETOOTH)
 		return -ENOPROTOOPT;
 
+	lock_sock(sk);
+
+	switch (optname) {
+	case BT_SNDMTU:
+	case BT_RCVMTU:
+		switch (hci_pi(sk)->channel) {
+		/* Don't allow changing MTU for channels that are meant for HCI
+		 * traffic only.
+		 */
+		case HCI_CHANNEL_RAW:
+		case HCI_CHANNEL_USER:
+			err = -ENOPROTOOPT;
+			goto done;
+		}
+
+		if (copy_from_sockptr(&opt, optval, sizeof(u16))) {
+			err = -EFAULT;
+			break;
+		}
+
+		hci_pi(sk)->mtu = opt;
+		break;
+
+	default:
+		err = -ENOPROTOOPT;
+		break;
+	}
+
+done:
+	release_sock(sk);
+	return err;
+}
+
+static int hci_sock_getsockopt_old(struct socket *sock, int level, int optname,
+				   char __user *optval, int __user *optlen)
+{
+	struct hci_ufilter uf;
+	struct sock *sk = sock->sk;
+	int len, opt, err = 0;
+
+	BT_DBG("sk %p, opt %d", sk, optname);
+
 	if (get_user(len, optlen))
 		return -EFAULT;
 
@@ -2004,6 +2051,39 @@ static int hci_sock_getsockopt(struct socket *sock, int level, int optname,
 	return err;
 }
 
+static int hci_sock_getsockopt(struct socket *sock, int level, int optname,
+			       char __user *optval, int __user *optlen)
+{
+	struct sock *sk = sock->sk;
+	int err = 0;
+
+	BT_DBG("sk %p, opt %d", sk, optname);
+
+	if (level == SOL_HCI)
+		return hci_sock_getsockopt_old(sock, level, optname, optval,
+					       optlen);
+
+	if (level != SOL_BLUETOOTH)
+		return -ENOPROTOOPT;
+
+	lock_sock(sk);
+
+	switch (optname) {
+	case BT_SNDMTU:
+	case BT_RCVMTU:
+		if (put_user(hci_pi(sk)->mtu, (u16 __user *) optval))
+			err = -EFAULT;
+		break;
+
+	default:
+		err = -ENOPROTOOPT;
+		break;
+	}
+
+	release_sock(sk);
+	return err;
+}
+
 static const struct proto_ops hci_sock_ops = {
 	.family		= PF_BLUETOOTH,
 	.owner		= THIS_MODULE,
-- 
2.31.1

