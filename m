Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8343EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 23:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CC2561242
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 23:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhIOXhY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhIOXhW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Sep 2021 19:37:22 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E025C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 16:36:02 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id w7so4326143pgk.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 16:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Im0DuhBQTNxqq7E8PWjpD2i5rTNvaonLKrPg4mW+Np4=;
        b=Sh6qKBhz3r/IfZlpRKHlBl2apObaylQvRPAm9L1S7uAd5nuGTrvYFBLXQSIf3z/fQ1
         ICEnWJyTdc998H1ZRoyzFIVf0PCIa0I07dYytxtQK/57BJOJ1Vwj6SdoP2xNNp09xClP
         dqOaGuFSs6dNJtL9QHe/omcjl18/HtLDYIUCFbvKXvbnsVHuK47zUEqsE5KludGGWeQ2
         dv+uxeZXWImRr+QUI1Mo5s40py5mqm4l8p07Lj6WJl6faLVIMOruEK4y/xgJ5tLdUbp0
         ll0c+Bdmad8+jiDgKpvNbkKhg7zUYyogUcFS/NmROPWN4TnDlnlEp24sIO4mkaCHNbMW
         4kFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Im0DuhBQTNxqq7E8PWjpD2i5rTNvaonLKrPg4mW+Np4=;
        b=2N5ossjDYELE8SG58u18EOa3b8uwXyQF2hdYtJ2I283qwZ8zVFCVbbrgMBPjQyq1DV
         AILliP11mqoarE/xSsORM4woFZmazqDA0OgGPVe4LfZAdpYB6faRvAKF2LZfTXKUFg/a
         EiIYJ3uHT5JH7k9Vh1fONpIBWFlyXIn7FSi1EnmEN7dGTdc6aPH7AGAQBIK3a8IDXTzA
         BNF+2fBvtJVGZSQtPm0k+NC3ShWyfkW3JPF1ME1xwrW1I05rpavo5zAbrzcmWFOOmZMt
         1O18ATdPrWTrrl6qN++Mx3pde9uG5YXOV/MR2SdkPJsk1yDNuwacMYOrOVelfKqIaZQa
         ziYw==
X-Gm-Message-State: AOAM530YKTzTkvOTsxeLknDPFnFhCZ3BVx4RXg0bkUtVQMgGpeNsRaV/
        3peb19TLGJsil+e4bLMRn1GyVf2wvyg=
X-Google-Smtp-Source: ABdhPJx8NiWJqmKr+jeD984ATAoh3pHuOFeBbrXx+vjUi6wjzeToCLhqoOtCg8tnlhWksjKkPS1+KQ==
X-Received: by 2002:a63:7045:: with SMTP id a5mr2134611pgn.404.1631748961902;
        Wed, 15 Sep 2021 16:36:01 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x13sm890980pff.70.2021.09.15.16.36.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 16:36:01 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 1/4] Bluetooth: hci_sock: Add support for BT_{SND,RCV}BUF
Date:   Wed, 15 Sep 2021 16:35:57 -0700
Message-Id: <20210915233600.4129808-1-luiz.dentz@gmail.com>
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
 net/bluetooth/hci_sock.c | 105 +++++++++++++++++++++++++++++++++++----
 1 file changed, 94 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 55b0d177375b..e481eee8e61e 100644
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
 
@@ -2004,6 +2051,42 @@ static int hci_sock_getsockopt(struct socket *sock, int level, int optname,
 	return err;
 }
 
+static int hci_sock_getsockopt(struct socket *sock, int level, int optname,
+			       char __user *optval, int __user *optlen)
+{
+	struct sock *sk = sock->sk;
+	int len, err = 0;
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
+	if (get_user(len, optlen))
+		return -EFAULT;
+
+	lock_sock(sk);
+
+	switch (optname) {
+	case BT_SNDMTU:
+	case BT_RCVMTU:
+		if (put_user(hci_pi(sk)->mtu, (u32 __user *)optval))
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

