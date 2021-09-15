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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D69C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 20:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A30D61056
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 20:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbhIOUBv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Sep 2021 16:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbhIOUBu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Sep 2021 16:01:50 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CD6C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 13:00:31 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y17so3654660pfl.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 13:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DVfYbRKT4940dmHM/o+jK4Y/BSpzFdAmlK4bqTraq5k=;
        b=cvUuA0Y5pJZYVCeXTyTKwsxBU2NgR4Vt+fJsxMyA0uOc/WWTCQJlA1/9pnZVWYh6BE
         uSC5zc3oeRhh49aq6qN7/PeFxlaE0JiaPtulNLa1LeJJlRRypUdKE2Mlyf2Njx+f5NW8
         /9mrq61ioBk7FWkycX8dXW6DP/2/lJWtf8dCaS73ANlkA7FGbPsEYUHCZxkgFJf/w065
         wd+TuTevNeipz6PuFHPW210SFmeQrXMRtpBSBKpfsjXVYlO7WZflOqml5tKNSiP0lMdm
         jmDRdhFOwlHJbvphLbebKZGDbCGq30AtvTsfdO5WobGwYBkbSM6xHuc0b/fMdXtOV9Hs
         IqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DVfYbRKT4940dmHM/o+jK4Y/BSpzFdAmlK4bqTraq5k=;
        b=tNqRlQyEcXMdWUK/JqJMWHbv/m8E3//n4IHZHlMKBY3QNWgfNjH0ONZ8YgL6xzBv4Q
         aQaYIX5YprVZQWYMVSXmE+bTtVZSbBVS9PHqwHzjnhOIqcFM//GREUg6mqYia1EZ7Nc/
         QooPRJ4bBGil3Sp+8xbTK0C2Mb6v8vfV9wR3mraXVNYGmbgrmNlYi3i5QHuruxGkB2fx
         /AigA0O0wfmtbzy8INwcwypvGMUG/EU74hstAByI+y+H3Vi7CvhxzXEEEhLejSEkHGg2
         zsSO5gupQ1n8A6HZLV/CGbZLF/43gthqb/4DrlhRBvIAtNzDmm3RA36HRzGSlnYZrPGd
         4Waw==
X-Gm-Message-State: AOAM533omGrYfWGOF9MvKnNesw09EGmkTp6A2phnTL+ryLuL1xyWpHdF
        a0sgAd5VrLwUBTkT/8DBK/nF5PNqyAI=
X-Google-Smtp-Source: ABdhPJy4kxtGN0XNE2Y+1n1KSew+SGB314YD3TdeVISOPQh8r4bodCNaphC/TVPGWJlU0b3+iCeSfQ==
X-Received: by 2002:a63:935e:: with SMTP id w30mr1365729pgm.208.1631736030730;
        Wed, 15 Sep 2021 13:00:30 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h16sm442574pjt.30.2021.09.15.13.00.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 13:00:30 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sock: Add support for BT_{SND,RCV}BUF
Date:   Wed, 15 Sep 2021 13:00:29 -0700
Message-Id: <20210915200029.4006305-1-luiz.dentz@gmail.com>
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
index 31a2eefede3c..3c6a4bcd2924 100644
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
@@ -1823,8 +1828,8 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	goto done;
 }
 
-static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
-			       sockptr_t optval, unsigned int len)
+static int hci_sock_setsockopt_old(struct socket *sock, int level, int optname,
+				   sockptr_t optval, unsigned int len)
 {
 	struct hci_ufilter uf = { .opcode = 0 };
 	struct sock *sk = sock->sk;
@@ -1832,9 +1837,6 @@ static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
 
 	BT_DBG("sk %p, opt %d", sk, optname);
 
-	if (level != SOL_HCI)
-		return -ENOPROTOOPT;
-
 	lock_sock(sk);
 
 	if (hci_pi(sk)->channel != HCI_CHANNEL_RAW) {
@@ -1909,18 +1911,63 @@ static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
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
 
@@ -1978,6 +2025,42 @@ static int hci_sock_getsockopt(struct socket *sock, int level, int optname,
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

