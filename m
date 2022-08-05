Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B482C00140
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Aug 2022 21:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241797AbiHEV6q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Aug 2022 17:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241795AbiHEV63 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Aug 2022 17:58:29 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B107D7B8
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Aug 2022 14:56:15 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id 13so2307778plo.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Aug 2022 14:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BrZCVXfqfi3oOXZsNJc8r9QljeSz92b3tE/eqB5fI4Y=;
        b=nTwoeLQtj6EdVs823gaC9uvh83kXM/G7ycYY3Y1jYZGFY8iom5uFVZ58x/idlzfALM
         V6NHq33xYT2yybCBrgqF9ehtwvbyWUmG5zEUBynUjYeOSz3aa3LYBQkeYUMSRCmdPRZY
         bJgmBcQLpsiDcgjcCJyzjEAC6hJER2IM/xkaSQ5tcZkb4Wcbq3m/MRJFs3YxxscgHR1h
         u7iUopO/5Y7XxMfqocHYqTcT+yb5Zrp/SUu9wWQU+SdSEXYBDF8NRVst1Y91rZRr+7Jv
         cuw4bhKYNdlp0tY9fFykdj17O9VhGmB1EUIH1LR1O5R4nCd8+xntbuacjbSzaahr/mBZ
         +Ggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BrZCVXfqfi3oOXZsNJc8r9QljeSz92b3tE/eqB5fI4Y=;
        b=n/98UOUgt2H/fyO27TF8oU8eaGKwF3aSUzc5uWr589GFSBg0KS7dTTzhG5U4jIxgHp
         ojGh8yeUAUSQqs+aUZIv2lfITwVQKoREKiLnZl+3Jxu45XbSd02uQUvwUpDtz5jrDMVz
         HgymJjidgAUvmJtm4jPiuDv29jLPq2UqNJfbrfdZie2Z69ndjt41CFj2Eaq6h2HQjTKy
         Nq1xL4gemefVkTqFsD3IYVJh7zQ2/xVy+xDmw3aI2w7v4uLQzFGoiV76jiTzbMRup4Th
         /ZFM3qam2tLAY40zgib4nDDju9XpNPNjsAp67lOuUFJMkNCrjFrPaqIeYth8zrV3P49Y
         nVug==
X-Gm-Message-State: ACgBeo24uvJAo+p8rWEOGnUAIHPCAmb9RqpFHHOCSJ7MCTzmjf6hNPjr
        3nNHQoG/GpaWMaOOWxtHMbMNODplRxdxOQ==
X-Google-Smtp-Source: AA6agR4B/3jp9EQgTH+l95hw0UjuqCsvYoXdhztfc2n23O11qNTEbRAyGQ4Suv52U2cGWdW/CCyWzw==
X-Received: by 2002:a17:902:ccc4:b0:16c:5766:51f9 with SMTP id z4-20020a170902ccc400b0016c576651f9mr8625416ple.84.1659736574373;
        Fri, 05 Aug 2022 14:56:14 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m26-20020a62a21a000000b0052e988c1630sm2918153pff.138.2022.08.05.14.56.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 14:56:12 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: ISO: Fix not using the correct QoS
Date:   Fri,  5 Aug 2022 14:56:01 -0700
Message-Id: <20220805215601.3958596-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes using wrong QoS settings when attempting to send frames while
acting as peripheral since the QoS settings in use are stored in
hconn->iso_qos not in sk->qos, this is actually properly handled on
getsockopt(BT_ISO_QOS) but not on iso_send_frame.

Fixes: ccf74f2390d60 ("Bluetooth: Add BTPROTO_ISO socket type")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 015d1b41bc32..ced8ad4fed4f 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -373,15 +373,24 @@ static int iso_connect_cis(struct sock *sk)
 	return err;
 }
 
+static struct bt_iso_qos *iso_sock_get_qos(struct sock *sk)
+{
+	if (sk->sk_state == BT_CONNECTED || sk->sk_state == BT_CONNECT2)
+		return &iso_pi(sk)->conn->hcon->iso_qos;
+
+	return &iso_pi(sk)->qos;
+}
+
 static int iso_send_frame(struct sock *sk, struct sk_buff *skb)
 {
 	struct iso_conn *conn = iso_pi(sk)->conn;
+	struct bt_iso_qos *qos = iso_sock_get_qos(sk);
 	struct hci_iso_data_hdr *hdr;
 	int len = 0;
 
 	BT_DBG("sk %p len %d", sk, skb->len);
 
-	if (skb->len > iso_pi(sk)->qos.out.sdu)
+	if (skb->len > qos->out.sdu)
 		return -EMSGSIZE;
 
 	len = skb->len;
@@ -1263,10 +1272,7 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_ISO_QOS:
-		if (sk->sk_state == BT_CONNECTED || sk->sk_state == BT_CONNECT2)
-			qos = &iso_pi(sk)->conn->hcon->iso_qos;
-		else
-			qos = &iso_pi(sk)->qos;
+		qos = iso_sock_get_qos(sk);
 
 		len = min_t(unsigned int, len, sizeof(*qos));
 		if (copy_to_user(optval, qos, len))
-- 
2.37.1

