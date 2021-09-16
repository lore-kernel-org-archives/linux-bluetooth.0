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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1633C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 20:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6E386120C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 20:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237476AbhIPUMP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Sep 2021 16:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbhIPUMN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Sep 2021 16:12:13 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29772C061764
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 13:10:51 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q68so7251070pga.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 13:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RetY05MIkneCHMPX+Zw8LotuCOaCSiTKioQGR2sK31M=;
        b=Mo7ZNvW2w/Ql0ULqC20S2mcQeq3tcR/+9WMaOsZ9lbmguQHyu5Ki/HZSyQcEaLMZbO
         ukUnW+auEytgDZXH4pp1FkhOJOtLKEuBrPc2mMyWVBkKKC7SMrem/+Z56UqwxOAhK+j5
         PbFPwrpetVVNO4yNspschxLlyLCrS7VWsavQvQi9oSd2drGT46x6y6eYxBYWm7EmaOH8
         9afnvcIWymk0RdBKE63BeLWrQONlX4aczRaBZp+ews1JW6+GHdEUvNYeVdLhqjodE6cm
         UD7VMcLMq6UVdcG5RweBzL6R87501urcqcAQdDff6R5k9exQLrvlbHHi9ahv6ke9EgKJ
         7X6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RetY05MIkneCHMPX+Zw8LotuCOaCSiTKioQGR2sK31M=;
        b=TIP/s3njwinDDoAh+i30tHcQKFyFK1u+QBVwLfJXgJJp6t/MxJA3wYPPB/7EJS9Liv
         fQefP/AedZ5Vfbc8z2h6z8HVlKXSbkHDvxj8l3pKxF7dLY7lZZxLtjCCX2pdyZUzJ3Uy
         /B0eVgRvUwmUaEC8VRjvvBKA8ZcvBIc0PaPXJAm+eKDKXc/MDkGablKWjOYVY4fWEGqo
         8b9XmGL1lOJR4RZpYEdJUrriRlLf4fUHnzZZhuLoE3LVEiHcpe0Eso/CjoL+/xaJKvom
         yim3Q5tyerm127TL2mth8m9xBA3YO/DqwPzy6YBEWxqJYIlrLBr1V6sGoMMXC4OJFe4U
         kRAw==
X-Gm-Message-State: AOAM53221W+hEarPJ72XDr6qeYDFHDdbki9FLmmMG/Ct5LLq8apumKci
        lT5dysfHyQo8Sz1sENu/ylpgTHMhL8s=
X-Google-Smtp-Source: ABdhPJwlVH1ZF2qTa26eotm0sxaL4iOSxwaUWSByq536VijsXZjD5dW0BOidelTJiWR0R1m5BQhXwg==
X-Received: by 2002:a65:46cc:: with SMTP id n12mr6602903pgr.274.1631823050265;
        Thu, 16 Sep 2021 13:10:50 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x128sm2500445pfd.203.2021.09.16.13.10.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 13:10:49 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 1/4] Bluetooth: hci_sock: Add support for BT_{SND,RCV}BUF
Date:   Thu, 16 Sep 2021 13:10:46 -0700
Message-Id: <20210916201049.114392-1-luiz.dentz@gmail.com>
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
index 55b0d177375b..99de17922bda 100644
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
+		if (put_user(hci_pi(sk)->mtu, (u16 __user *)optval))
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

