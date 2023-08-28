Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF73C83F12
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Aug 2023 20:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjH1UEc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Aug 2023 16:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjH1UEL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Aug 2023 16:04:11 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E45CCC5
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Aug 2023 13:03:48 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68a529e1974so2508487b3a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Aug 2023 13:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693253027; x=1693857827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fI0Dtbxx0jQ3BkIrft72Otwhh5KsGSoRfb869HY7Ji0=;
        b=PsnruqR4/ImTVTrjWBUsv2gHA7tlVn1wCAp3L30Pv1+57xasp1aYGh5PIcWgvrUPhv
         PLU0CKEUW1ZtsNOS+dDBEHqe9K0GQi2AMytKJvpEkWS63CsrBYRSp7nO8Lhks9TmTLo4
         ig8cDidayfSCb0XnV4HW+zidZLZy/Eku54nSEu5GpSP9wMIFeLEiNIb0U3kgYtnuPddG
         riNQn0wjE9k73NLKa9PL72i81u6jWGclfwqXH2FCa4SJQWZvMz2w/fmuQ8943fp/8n8v
         cvgMNkOSdmLN0O41ppfvrW7tiJOMw5pvYRY36DzHkSdKmh887h98AXPcQ8w6zpIKrI9T
         X4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693253027; x=1693857827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fI0Dtbxx0jQ3BkIrft72Otwhh5KsGSoRfb869HY7Ji0=;
        b=dfdygaGmUAgV1NxjV6jGAwtV8KvhJ7JY/NmfGSoSG2iGGHBPQXdLulFMSYtPcUgadB
         oGnG0IH9aYe/EG0YvPCDOdyP1MHJYivU65WHrIW+lnZ0QzqgmkGTZE4aVne9HAJq2CY9
         Zx75k0KvrpsdzUPcD8sWvytSRBLk3Xbe1LvEHf6D7e9Mt2D7MkwC+Qheuh3gkIX/JRzG
         8M3wj+Yz1G5kLif6jZRyEYMXa3+JQsla0kz6/rTlCrBXmUTQcBMEl0ABrhoTleVWAl43
         eDBBoZheEEEx7+fScIZGsexMqRn7KryniiE7uLpF52PSOk8OZPvS8fOq8GGDL8B2ReVM
         AEcg==
X-Gm-Message-State: AOJu0YxUfDDGpUe7sIBE85eI2g/7sWkutUqToYxQ6IXbU1IFvI02Mino
        sqaO0Onao48HIMyyRoWoQVZFcCaBeKE=
X-Google-Smtp-Source: AGHT+IF2sMvHpxcE0WGrhgaOLLOhianoR3XdTVf5MgmZDLTxUjVwdh0w+e7BbJ3/DCb3VDXde7hFiw==
X-Received: by 2002:a05:6a20:a12c:b0:136:ea0e:d23 with SMTP id q44-20020a056a20a12c00b00136ea0e0d23mr24631276pzk.11.1693253027170;
        Mon, 28 Aug 2023 13:03:47 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id v6-20020aa78506000000b0068a29521df2sm7301065pfn.177.2023.08.28.13.03.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 13:03:46 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: ISO: Fix handling os listen for unicast
Date:   Mon, 28 Aug 2023 13:03:45 -0700
Message-ID: <20230828200345.579455-1-luiz.dentz@gmail.com>
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

