Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55835C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Jun 2023 23:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbjFAXjK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Jun 2023 19:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjFAXjJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Jun 2023 19:39:09 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52268180
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Jun 2023 16:39:08 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3980c92d8d6so1231549b6e.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Jun 2023 16:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685662747; x=1688254747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=waBXCZRqkIP2Ni9P178jVN1m8EIaZmqbA1id3TEbBZY=;
        b=h37sSYXcogrocmKF2E0oRcocwRPQ4YAH04BpSbv9RdfQHB/khNLg3SffEO2+CeW/kL
         IbHK5J3sEE4sKEN7gif7CQFx8snrC1+7vs/DvCw2jWZqQOvUzBrypHDhOPrL/5MjEX07
         j85hGx00vv70nl9OwFawG9Gzh+/St0l4QEJabbbmWTquBvI7ZQlOcutdk9YRiO6UE1B/
         0xh+GA/nsOOi0gD73DbdOfM8+bjDeVYUp0tTRJzbMWCPntYZEVKxBFGDNBrlamjPLgJ1
         PzHPHGDUa3mt2Hnw+Oq2Gv49QZ5BjFttJLoK13VENdakKZrPl7WqHF26GeacuXy/5o1S
         eHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685662747; x=1688254747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=waBXCZRqkIP2Ni9P178jVN1m8EIaZmqbA1id3TEbBZY=;
        b=bJGlm2e2eaXXGEzVHcUqfT6dYAJvygRDIF4R47B9m0nZIg4QaVXlAYZVcQ02HORq4F
         BM5EPBPf20aJSmAQmJm+/aM33RiCsfnTtiPBulbv1gFOnUuz25A8DoX22djaik1znk+G
         DpKIFBrmx2y3Sw2IOJ/ITd1kBIQyOa8jugvrZxye3AhXJeGITklflTScDnP3NVrutC8g
         N8FFLcAfYKiZa62XY6upifkFY2t/HcAgcLudbioHlNfiuZ3HNgpry3TebFl4vPKU9Bqi
         oUNN0+JYKpvmrbNF9/+WStdrTc4GzS6emVzqrfdYRwWCGlU754nPFaE6CVLJ56gPnRc9
         ZtrQ==
X-Gm-Message-State: AC+VfDxhOK+Piz5R6XYnCvRXmKsC0GL3roIMTd3ejO7+siRmVcTBpkSm
        HoAItF5A/Slzt/hMwSiiSpcLgwmM9ds=
X-Google-Smtp-Source: ACHHUZ7mBLHqkdXQSfUPADvsqHbA5F8L14G53yScj6dP92BaQ0SdFokuwKWq/b7gG89/G5vTWakxBQ==
X-Received: by 2002:aca:1206:0:b0:398:5172:ef31 with SMTP id 6-20020aca1206000000b003985172ef31mr764843ois.32.1685662746838;
        Thu, 01 Jun 2023 16:39:06 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id x25-20020aa79199000000b00652f5bd894esm78459pfa.177.2023.06.01.16.39.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 16:39:05 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/3] Bluetooth: hci_sock: Forward credentials to monitor
Date:   Thu,  1 Jun 2023 16:39:01 -0700
Message-Id: <20230601233901.1448729-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601233901.1448729-1-luiz.dentz@gmail.com>
References: <20230601233901.1448729-1-luiz.dentz@gmail.com>
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

