Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEDBC001DE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jul 2023 22:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbjGMWmu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jul 2023 18:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjGMWmt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jul 2023 18:42:49 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0ED271C
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 15:42:48 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b8b2886364so7523355ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 15:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689288166; x=1691880166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hZ5jFUxC7kcuymhEZZgkHu+5eZSL9vO8wKjtLdEKEPM=;
        b=U5EWXewuguIcSupUCKBQHb0bYzhphY5otIEwCVAjQS3lushS11y0+jxX1W3xCOo1zN
         ryMxJy3Z43ZwjFEbOcR29kqkFibgTn80mGcLveA3M8QtbNdCPPvCkh9XJQTEetvhHeV5
         5aCmOw5L/qb/G3BW79C24kM6nR1PP6XXENnCkpaiok49oMqS2NqB5gRwLPiAVbct52Z4
         6dPJxzj3IFEqYjpMlI80RmhjE1jlSgJ5FXprIBH/OklxbSL6GgDIaHkuA52FEJwWLaFD
         t7hV199c+ZzzOcLYYzVS6G/srwRrhDBa5qzH8ifbapgwlS/t4Y53ELuMOZccIPqTd0Or
         z4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689288166; x=1691880166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZ5jFUxC7kcuymhEZZgkHu+5eZSL9vO8wKjtLdEKEPM=;
        b=W3hiBMAr0tjNYIWWZ4XtSOB2bchRmUB01h0abOD1bnAVXvuxWwGMIc6GFx6xymOPiU
         ufvInV06/o+3Dy5yWVUd4n9kjWk0ad1PE2JFlP2S0zgqTmQU/fyH5KEJUkPP73xIn/We
         VcuYMmKCME6HIxlqVmw0w5HQjYkVK/0czYB6YCD+HnuqKs2+M1D6DakmupfPTFs02pvj
         yG6oA4JpWxPOvSThSB5PuJwgxII1ylGl32T/obxkFw6c0ht/3z+ZIJHvGkB1uaSEGsj6
         TA9yTA+e8hNEtfD5dWON1g1bqttheIXVH5EjxQpyHFqIu/v/Am1oBNGWel1vBHaMAVgj
         MZHg==
X-Gm-Message-State: ABy/qLaz5ItwOcj0BXHaScfJr7XOo300sGf5ALBzoHHZpn3jRwjhvdq3
        NsZmlDbbGI6hirr1X+i5bQGcSE1yCPk=
X-Google-Smtp-Source: APBJJlHpd7CYGC7fn1dppbnKkG1LiCXjOiyW0DtaBOkawLe0ijWMmWDwpUhvXIjIIFIUzM3rYkv/2Q==
X-Received: by 2002:a17:902:aa83:b0:1b8:9002:c9ee with SMTP id d3-20020a170902aa8300b001b89002c9eemr2040150plr.1.1689288166352;
        Thu, 13 Jul 2023 15:42:46 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id bd5-20020a170902830500b001b8b4730355sm6373762plb.287.2023.07.13.15.42.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 15:42:44 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: ISO: Add support for BT_PKT_STATUS
Date:   Thu, 13 Jul 2023 15:42:39 -0700
Message-Id: <20230713224239.2286549-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713224239.2286549-1-luiz.dentz@gmail.com>
References: <20230713224239.2286549-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for BT_PKT_STATUS socketopt by setting
BT_SK_PKT_STATUS. Then upon receiving an ISO packet the code would
attempt to store the Packet_Status_Flag to hci_skb_pkt_status which
is then forward to userspace in the form of BT_SCM_PKT_STATUS whenever
BT_PKT_STATUS has been enabled/set.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index efac284badbc..cbe3299b4a41 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1288,6 +1288,18 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 			clear_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
 		break;
 
+	case BT_PKT_STATUS:
+		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
+			err = -EFAULT;
+			break;
+		}
+
+		if (opt)
+			set_bit(BT_SK_PKT_STATUS, &bt_sk(sk)->flags);
+		else
+			clear_bit(BT_SK_PKT_STATUS, &bt_sk(sk)->flags);
+		break;
+
 	case BT_ISO_QOS:
 		if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND &&
 		    sk->sk_state != BT_CONNECT2) {
@@ -1373,6 +1385,12 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
 
 		break;
 
+	case BT_PKT_STATUS:
+		if (put_user(test_bit(BT_SK_PKT_STATUS, &bt_sk(sk)->flags),
+			     (int __user *)optval))
+			err = -EFAULT;
+		break;
+
 	case BT_ISO_QOS:
 		qos = iso_sock_get_qos(sk);
 
@@ -1767,6 +1785,7 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 
 		if (len == skb->len) {
 			/* Complete frame received */
+			hci_skb_pkt_status(skb) = flags & 0x03;
 			iso_recv_frame(conn, skb);
 			return;
 		}
@@ -1788,6 +1807,7 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 		if (!conn->rx_skb)
 			goto drop;
 
+		hci_skb_pkt_status(conn->rx_skb) = flags & 0x03;
 		skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->len),
 					  skb->len);
 		conn->rx_len = len - skb->len;
-- 
2.40.1

