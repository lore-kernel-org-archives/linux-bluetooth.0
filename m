Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C5AC7EE2D
	for <linux-bluetooth@archiver.kernel.org>; Sat,  3 Jun 2023 00:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236891AbjFCAQi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Jun 2023 20:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236470AbjFCAQg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Jun 2023 20:16:36 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0701B8
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Jun 2023 17:16:35 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64d24136685so2090002b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Jun 2023 17:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685751394; x=1688343394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=waBXCZRqkIP2Ni9P178jVN1m8EIaZmqbA1id3TEbBZY=;
        b=YXKvVw0HTJ/EB4+HfA/lVGnxWrINVoKwaRBBCCtngzVH2F25kh1/2GzuKSWlDeUrZq
         u/j2w5OjMKRfJiGxFbHq/dav7RVX+ROsznOlJyIMIm+GFuGE7/DfVZAKQKaVqnoVJHZk
         9aUl7Mh5j5vF0uvRNu1BQH993HHGJTFWmoWNhX5KVrUlErf+cTUZMTHiX3sOU++IW9mz
         Lv1NHzKhKaM+9e9bsVVXHjSCWOrRO8Wu0HlBywQmTLOeVRqc2Md8E1SNF3F5t4rW4B9T
         GruwuUJirdcDGx/G05s/9hXsqkb8O0/a9mE58hkv+fBAP7drRklMLgXM/zUb2MPjNzyO
         V7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685751394; x=1688343394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=waBXCZRqkIP2Ni9P178jVN1m8EIaZmqbA1id3TEbBZY=;
        b=QL1nutihyPVd5698cAvQuCq6XYWHVEsCkbct6rXdghvEj3Gviz8afiaTFh9QD+Y3l2
         z4Sbg9/3/pYogmMdqE50nZF2wjRw+A6nmjFGCo9xEuoM3eqBIVxuLNr0wrH9VEgiAeM1
         yUG55umk5XvEDtwP60DHiTAtFc40AYOsa+BKIhSR1BOKSFirMeIUPUybrTHZEw1bdnG7
         crnd+UinhyNoU27zpppNy6Uv3sxCAB5ce/vYt++vpJ9PlXbqkZvrPfxgJ+dtjaXxR8jY
         Y891YR39C5bjZaQwSkcnla4Zfux+FE4oH6qY7U1wgrlAjQvTRZ10wRz8rM8hNfRZhFiZ
         dAfQ==
X-Gm-Message-State: AC+VfDx9vw+GJpIwmPw1QjAa3PE1OGetJgQJUnOzI7Qvfspi8bpbGHQO
        adrit/P93kuJOlPUTufQmeQwtZ/Sw/k=
X-Google-Smtp-Source: ACHHUZ70+AugHxZHZ2tlCJa3vjNMzrSipf1iLqdRhJGeDOcC0ASBiSne91Gr6bWaH6Uxvn9vbZlMYQ==
X-Received: by 2002:a05:6a00:1a8b:b0:64f:ad7c:70fb with SMTP id e11-20020a056a001a8b00b0064fad7c70fbmr6384143pfv.17.1685751393832;
        Fri, 02 Jun 2023 17:16:33 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id c19-20020aa78e13000000b0064fde7ae1ffsm1496267pfr.38.2023.06.02.17.16.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 17:16:33 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/3] Bluetooth: hci_sock: Forward credentials to monitor
Date:   Fri,  2 Jun 2023 17:16:28 -0700
Message-Id: <20230603001628.1886596-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230603001628.1886596-1-luiz.dentz@gmail.com>
References: <20230603001628.1886596-1-luiz.dentz@gmail.com>
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

bluetoothd[35]: < ACL Data T.. flags 0x00 dlen 41
      ATT: Write Command (0x52) len 36
        Handle: 0x0043 Type: ASE Control Point (0x2bc6)
          Data: 020203000110270000022800020a00409c0001000110270000022800020a00409c00
            Opcode: QoS Configuration (0x02)
            Number of ASE(s): 2
            ASE: #0
            ASE ID: 0x03
            CIG ID: 0x00
            CIS ID: 0x01
            SDU Interval: 10000 usec
            Framing: Unframed (0x00)
            PHY: 0x02
            LE 2M PHY (0x02)
            Max SDU: 40
            RTN: 2
            Max Transport Latency: 10
            Presentation Delay: 40000 us
            ASE: #1
            ASE ID: 0x01
            CIG ID: 0x00
            CIS ID: 0x01
            SDU Interval: 10000 usec
            Framing: Unframed (0x00)
            PHY: 0x02
            LE 2M PHY (0x02)
            Max SDU: 40
            RTN: 2
            Max Transport Latency: 10
            Presentation Delay: 40000 us

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/bluetooth.h |  1 +
 net/bluetooth/hci_sock.c          | 67 ++++++++++++++++++++++++++++++-
 2 files changed, 66 insertions(+), 2 deletions(-)

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
index 9c45586f5818..5e4f718073b7 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -264,6 +264,53 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
 	kfree_skb(skb_copy);
 }
 
+static void hci_sock_copy_creds(struct sock *sk, struct sk_buff *skb)
+{
+	struct scm_creds *creds;
+
+	if (!sk || WARN_ON(!skb))
+		return;
+
+	creds = &bt_cb(skb)->creds;
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
+	/* Check if scm_creds already set */
+	if (creds->pid == pid_vnr(sk->sk_peer_pid))
+		return;
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
+	hci_sock_copy_creds(skb->sk, nskb);
+
+	return nskb;
+}
+
 /* Send frame to sockets with specific channel */
 static void __hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
 				  int flag, struct sock *skip_sk)
@@ -289,7 +336,7 @@ static void __hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
 		if (hci_pi(sk)->channel != channel)
 			continue;
 
-		nskb = skb_clone(skb, GFP_ATOMIC);
+		nskb = hci_skb_clone(skb);
 		if (!nskb)
 			continue;
 
@@ -356,6 +403,8 @@ void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!skb_copy)
 		return;
 
+	hci_sock_copy_creds(skb->sk, skb_copy);
+
 	/* Put header before the data */
 	hdr = skb_push(skb_copy, HCI_MON_HDR_SIZE);
 	hdr->opcode = opcode;
@@ -531,10 +580,12 @@ static struct sk_buff *create_monitor_ctrl_open(struct sock *sk)
 		return NULL;
 	}
 
-	skb = bt_skb_alloc(14 + TASK_COMM_LEN , GFP_ATOMIC);
+	skb = bt_skb_alloc(14 + TASK_COMM_LEN, GFP_ATOMIC);
 	if (!skb)
 		return NULL;
 
+	hci_sock_copy_creds(sk, skb);
+
 	flags = hci_sock_test_flag(sk, HCI_SOCK_TRUSTED) ? 0x1 : 0x0;
 
 	put_unaligned_le32(hci_pi(sk)->cookie, skb_put(skb, 4));
@@ -580,6 +631,8 @@ static struct sk_buff *create_monitor_ctrl_close(struct sock *sk)
 	if (!skb)
 		return NULL;
 
+	hci_sock_copy_creds(sk, skb);
+
 	put_unaligned_le32(hci_pi(sk)->cookie, skb_put(skb, 4));
 
 	__net_timestamp(skb);
@@ -606,6 +659,8 @@ static struct sk_buff *create_monitor_ctrl_command(struct sock *sk, u16 index,
 	if (!skb)
 		return NULL;
 
+	hci_sock_copy_creds(sk, skb);
+
 	put_unaligned_le32(hci_pi(sk)->cookie, skb_put(skb, 4));
 	put_unaligned_le16(opcode, skb_put(skb, 2));
 
@@ -638,6 +693,8 @@ send_monitor_note(struct sock *sk, const char *fmt, ...)
 	if (!skb)
 		return;
 
+	hci_sock_copy_creds(sk, skb);
+
 	va_start(args, fmt);
 	vsprintf(skb_put(skb, len), fmt, args);
 	*(u8 *)skb_put(skb, 1) = 0;
@@ -1494,6 +1551,7 @@ static void hci_sock_cmsg(struct sock *sk, struct msghdr *msg,
 static int hci_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 			    size_t len, int flags)
 {
+	struct scm_cookie scm;
 	struct sock *sk = sock->sk;
 	struct sk_buff *skb;
 	int copied, err;
@@ -1538,11 +1596,16 @@ static int hci_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 		break;
 	}
 
+	memset(&scm, 0, sizeof(scm));
+	scm.creds = bt_cb(skb)->creds;
+
 	skb_free_datagram(sk, skb);
 
 	if (flags & MSG_TRUNC)
 		copied = skblen;
 
+	scm_recv(sock, msg, &scm, flags);
+
 	return err ? : copied;
 }
 
-- 
2.40.1

