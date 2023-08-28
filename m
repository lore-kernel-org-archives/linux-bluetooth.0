Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85914C83F14
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Aug 2023 20:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjH1UGJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Aug 2023 16:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjH1UFw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Aug 2023 16:05:52 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0D1C5
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Aug 2023 13:05:49 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68a3e271491so2276847b3a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Aug 2023 13:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693253147; x=1693857947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GSZbEtr9UBb8GVVNwJJJ6RMdhN15UupdB7BWUcEB8cQ=;
        b=RfohDL23yY0Rnxx9UH9SpeL2qSXHm+n6BRSUdOO6yH1He3vtEuv50u8wsRcCmBjd6m
         6ovqAG3rxp2zheFN58mRzQqb97eJURxeSg+199EZrBJi8JwtdGv4TZ7Z34uRyM2Oq+yq
         qGKWzg1M6wQyfKKlpklqHvb6s5rvHB90v/8IveYQ0zq7NkXo5kZ3wkj6NLZojJMhHQfs
         8ID79dlnrb8RD0Z9w2tR31ed17IdRBonQagvI7Ma3SS//9QW3otAS5imv3n7vgM40dEx
         vVaTYDr6qCnByDxP4H1BmngSqLZKvTPvBbJYw8xiHuWVVyhfdbVEArdEfEQR0TP5/bsH
         rD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693253147; x=1693857947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GSZbEtr9UBb8GVVNwJJJ6RMdhN15UupdB7BWUcEB8cQ=;
        b=CC5X1NChPS6MeRr6pgIYAc5nkJCsLvBCyfNuILspR2INljMDWLglzVzCjtL5/ZZrgR
         yXwMs4eohbvAuHFE+l0rzXrt4ihj36R7T1d8YmcYSwBOLewhUiqKMMCcnvlQPxHf8u15
         091yPljL6K0tBNxCNEyWa4Zm+NQPvbtkCEs2/xuhBN3eDpDo8i1i69e1/XnqhLeehPds
         Ii/iForPLtP+i31pTOma8810FvDCKAo39tqALub4S6ULbNBpeuY3+mNbxxMa2YUPbwbe
         DbVfCJNh7cCf7P0/ro5XkaZZ6DVKG5RKXi+Ujk1lTIcTJ/F/1lcdTDoGxXkMRvo5cCwB
         yfnQ==
X-Gm-Message-State: AOJu0YzsjfG/aM64EaPmuu8XwudZCkUD/CU+CsnuLheHuPnI5y/D2WjO
        QspkdOH7LeT/e/ICU7I/FBqqO21msk8=
X-Google-Smtp-Source: AGHT+IE3MwXTs1pSoP+cQTNL6xi+WKqLFBEr+WC09qhLbrCEJiG+3JF+VRYcWsNNm6ZzzbQgcbpGkQ==
X-Received: by 2002:a05:6a20:440e:b0:14d:6309:fc90 with SMTP id ce14-20020a056a20440e00b0014d6309fc90mr4133130pzb.8.1693253147334;
        Mon, 28 Aug 2023 13:05:47 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id fm14-20020a056a002f8e00b006889348ba6dsm7224721pfb.93.2023.08.28.13.05.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 13:05:46 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: ISO: Fix handling of listen for unicast
Date:   Mon, 28 Aug 2023 13:05:45 -0700
Message-ID: <20230828200545.580103-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

iso_listen_cis shall only return -EADDRINUSE if the listening socket has
the destination set to BDADDR_ANY otherwise if the destination is set to
a specific address it is for broadcast which shall be ignored.

Fixes: f764a6c2c1e4 ("Bluetooth: ISO: Add broadcast support")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 16da946f5881..71248163ce9a 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -502,7 +502,7 @@ static void iso_recv_frame(struct iso_conn *conn, struct sk_buff *skb)
 }
 
 /* -------- Socket interface ---------- */
-static struct sock *__iso_get_sock_listen_by_addr(bdaddr_t *ba)
+static struct sock *__iso_get_sock_listen_by_addr(bdaddr_t *src, bdaddr_t *dst)
 {
 	struct sock *sk;
 
@@ -510,7 +510,10 @@ static struct sock *__iso_get_sock_listen_by_addr(bdaddr_t *ba)
 		if (sk->sk_state != BT_LISTEN)
 			continue;
 
-		if (!bacmp(&iso_pi(sk)->src, ba))
+		if (bacmp(&iso_pi(sk)->dst, dst))
+			continue;
+
+		if (!bacmp(&iso_pi(sk)->src, src))
 			return sk;
 	}
 
@@ -952,7 +955,7 @@ static int iso_listen_cis(struct sock *sk)
 
 	write_lock(&iso_sk_list.lock);
 
-	if (__iso_get_sock_listen_by_addr(&iso_pi(sk)->src))
+	if (__iso_get_sock_listen_by_addr(&iso_pi(sk)->src, &iso_pi(sk)->dst))
 		err = -EADDRINUSE;
 
 	write_unlock(&iso_sk_list.lock);
-- 
2.41.0

