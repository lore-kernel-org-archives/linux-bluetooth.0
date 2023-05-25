Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E84C7EE32
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 May 2023 23:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241821AbjEYXqw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 May 2023 19:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241801AbjEYXqv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 May 2023 19:46:51 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AF212F
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 May 2023 16:46:50 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64d2a87b9daso259885b3a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 May 2023 16:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685058409; x=1687650409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5HZPtBtmBmeGKV5ZTkXZ2E4NZTnorrWlKQ+aUP/67lk=;
        b=C3OTznlDdoty9hLf84ddtfVANqED7PbM8muU+AG7xGTxEoBbk+giyEjab9xJT7O0gY
         LL2DHxkV17glGbnhbvmoU1JOfgxhdS7gC5XL0jxBjlFCe05A4wZZUSB/99AImj94XpLD
         r+9VFklazsxOcibM4n6PJ0p5vZEV7p8pBmOpfel+vs0zOyiNrSbABwavnMzsds/IGsrv
         KNgd+QGn/ulufse0WrXPJNf0cdjscKEjaWVmBsbP+r39eA9pY9NWvjIAR9xYMUCl36f+
         UMFj0obNUrXvRC2bpAxKEiwt6BWkub8SBc+CV8AATXP/GBm/1AsRpqlzqJ3i9GDSYeHm
         UPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685058409; x=1687650409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HZPtBtmBmeGKV5ZTkXZ2E4NZTnorrWlKQ+aUP/67lk=;
        b=bHHMerDZ/FD9Gq5sgjxMlkh+cW1AhZS4B+FdzcgyYjmp8oOjJtPVLy+XDWzmEIEVvB
         oI88KyhTwMfezx/faTwp/3tzVGVVYXw8yp7auwgC8H+gV7sMMRXL9nK7vUfd9EmsCte/
         uBzQFX4+PxbgPLh2uD29JMeEodRxJqKQwlj/V/3KCUqQakdATvSy/EySJdMswnb39kNF
         q9hcZQBbw0bG8NU7rS9h0/+Xo14LaVMgWYFdFVjRvNIHHyQiVIBVyQUCicxweiPYgq7C
         azRusdC0mvNckjjzvFfjNsFJYQyHlgZm203Ofkzb2KC8iHYn2TUUZX+ngbDohGYNre17
         rpJQ==
X-Gm-Message-State: AC+VfDxrNPgEHa/PNdAjSv/QtsoiuDjQ/RTaqPwPM2QEfGbf2xCGaOwm
        mLYEymDxIEhN2JjRFW8PQl/29XLKup0=
X-Google-Smtp-Source: ACHHUZ6IOu00fQJpHB0lCzX0Y72XtJr4rY0FAj3rvct5fTJA2xuZyJd5XgFFx2OQtg4c1hHBQYZGuw==
X-Received: by 2002:a05:6a20:8413:b0:10b:cb87:f5e with SMTP id c19-20020a056a20841300b0010bcb870f5emr17599044pzd.45.1685058408790;
        Thu, 25 May 2023 16:46:48 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id n23-20020aa79057000000b0064867dc8719sm1626930pfo.118.2023.05.25.16.46.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 16:46:47 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: hci_sock: Forward credentials to monitor
Date:   Thu, 25 May 2023 16:46:43 -0700
Message-Id: <20230525234643.3597907-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525234643.3597907-1-luiz.dentz@gmail.com>
References: <20230525234643.3597907-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This stores scm_creds into hci_skb_cb so they can be properly forwarded
to the likes of btmon which is then able to print information about the
process who is originating the traffic:

bluetoothd[35]: @ MGMT Command: Rea.. (0x0001) plen 0  {0x0001}
@ MGMT Event: Command Complete (0x0001) plen 6         {0x0001}
      Read Management Version Information (0x0001) plen 3

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/bluetooth.h |  1 +
 net/bluetooth/hci_sock.c          | 60 +++++++++++++++++++++++++++++--
 2 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index b518e5379045..310231e47b3d 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -471,6 +471,7 @@ struct bt_skb_cb {
 		struct sco_ctrl sco;
 		struct hci_ctrl hci;
 		struct mgmt_ctrl mgmt;
+		struct scm_creds creds;
 	};
 };
 #define bt_cb(skb) ((struct bt_skb_cb *)((skb)->cb))
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 9c45586f5818..2cb996e88caf 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -264,6 +264,45 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
 	kfree_skb(skb_copy);
 }
 
+static void hci_sock_copy_creds(struct sock *sk, struct scm_creds *creds)
+{
+	if (!sk || !creds)
+		return;
+
+	/* Check if peer credentials is set */
+	if (!sk->sk_peer_pid) {
+		/* Check if parent peer credentials is set */
+		if (bt_sk(sk)->parent && bt_sk(sk)->parent->sk_peer_pid)
+			sk = bt_sk(sk)->parent;
+		else
+			return;
+	}
+
+	memset(creds, 0, sizeof(*creds));
+
+	creds->pid = pid_vnr(sk->sk_peer_pid);
+	if (sk->sk_peer_cred) {
+		creds->uid = sk->sk_peer_cred->uid;
+		creds->gid = sk->sk_peer_cred->gid;
+	}
+}
+
+static struct sk_buff *hci_skb_clone(struct sk_buff *skb)
+{
+	struct sk_buff *nskb;
+
+	if (!skb)
+		return NULL;
+
+	nskb = skb_clone(skb, GFP_ATOMIC);
+	if (!nskb)
+		return NULL;
+
+	hci_sock_copy_creds(skb->sk, &bt_cb(nskb)->creds);
+
+	return nskb;
+}
+
 /* Send frame to sockets with specific channel */
 static void __hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
 				  int flag, struct sock *skip_sk)
@@ -289,7 +328,7 @@ static void __hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
 		if (hci_pi(sk)->channel != channel)
 			continue;
 
-		nskb = skb_clone(skb, GFP_ATOMIC);
+		nskb = hci_skb_clone(skb);
 		if (!nskb)
 			continue;
 
@@ -356,6 +395,8 @@ void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!skb_copy)
 		return;
 
+	hci_sock_copy_creds(skb->sk, &bt_cb(skb_copy)->creds);
+
 	/* Put header before the data */
 	hdr = skb_push(skb_copy, HCI_MON_HDR_SIZE);
 	hdr->opcode = opcode;
@@ -531,10 +572,12 @@ static struct sk_buff *create_monitor_ctrl_open(struct sock *sk)
 		return NULL;
 	}
 
-	skb = bt_skb_alloc(14 + TASK_COMM_LEN , GFP_ATOMIC);
+	skb = bt_skb_alloc(14 + TASK_COMM_LEN, GFP_ATOMIC);
 	if (!skb)
 		return NULL;
 
+	hci_sock_copy_creds(sk, &bt_cb(skb)->creds);
+
 	flags = hci_sock_test_flag(sk, HCI_SOCK_TRUSTED) ? 0x1 : 0x0;
 
 	put_unaligned_le32(hci_pi(sk)->cookie, skb_put(skb, 4));
@@ -580,6 +623,8 @@ static struct sk_buff *create_monitor_ctrl_close(struct sock *sk)
 	if (!skb)
 		return NULL;
 
+	hci_sock_copy_creds(sk, &bt_cb(skb)->creds);
+
 	put_unaligned_le32(hci_pi(sk)->cookie, skb_put(skb, 4));
 
 	__net_timestamp(skb);
@@ -606,6 +651,8 @@ static struct sk_buff *create_monitor_ctrl_command(struct sock *sk, u16 index,
 	if (!skb)
 		return NULL;
 
+	hci_sock_copy_creds(sk, &bt_cb(skb)->creds);
+
 	put_unaligned_le32(hci_pi(sk)->cookie, skb_put(skb, 4));
 	put_unaligned_le16(opcode, skb_put(skb, 2));
 
@@ -638,6 +685,8 @@ send_monitor_note(struct sock *sk, const char *fmt, ...)
 	if (!skb)
 		return;
 
+	hci_sock_copy_creds(sk, &bt_cb(skb)->creds);
+
 	va_start(args, fmt);
 	vsprintf(skb_put(skb, len), fmt, args);
 	*(u8 *)skb_put(skb, 1) = 0;
@@ -1494,6 +1543,7 @@ static void hci_sock_cmsg(struct sock *sk, struct msghdr *msg,
 static int hci_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 			    size_t len, int flags)
 {
+	struct scm_cookie scm;
 	struct sock *sk = sock->sk;
 	struct sk_buff *skb;
 	int copied, err;
@@ -1538,11 +1588,17 @@ static int hci_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 		break;
 	}
 
+	memset(&scm, 0, sizeof(scm));
+	scm.creds = bt_cb(skb)->creds;
+
 	skb_free_datagram(sk, skb);
 
 	if (flags & MSG_TRUNC)
 		copied = skblen;
 
+	if (scm.creds.pid)
+		scm_recv(sock, msg, &scm, flags);
+
 	return err ? : copied;
 }
 
-- 
2.40.1

