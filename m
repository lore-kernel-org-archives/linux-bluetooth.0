Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0368FC00140
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Jul 2022 23:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiG1Xve (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Jul 2022 19:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiG1Xve (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Jul 2022 19:51:34 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4096E2DF
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Jul 2022 16:51:33 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id f7so3445972pjp.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Jul 2022 16:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IWCrW5z2WP1eqXuG9tATReN8ZZMscIwJf4MtedgeAiE=;
        b=kNCNx+vqOZ109JRe1H/JGIJlKuJ0WN8PzWu2pElkWQ+RBsUOWTZ/u05ykhNauLOPAp
         ZQJXVfoSVJhDBKY8V0kw3LIWk6JdPCyPPgXmQGL8FWF5dPPjBu2fc3NrGKPcSCvd2Wtn
         RrKut4kZ9yE50puK57cv/F/Ok005HggZK0tMTVqb6OViWBfB5KJlOsvNAnbIkV/2C+Cg
         APnHj+4n/vjC6VwTwfLE8UfQO35bJQ0++xf8YJOiQIjOmhFQKAgWH2/ciVdcDMnmHPZW
         2zu5dnQIIl/qVUN9pJ/4GvAA2giLKZ3HOgJP1whbnJ+yX+BB06nJeVK0AbDL8HF8P78a
         T3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IWCrW5z2WP1eqXuG9tATReN8ZZMscIwJf4MtedgeAiE=;
        b=OYZMyc+z9vmR5zQkeiamHCdVV2GIe9WEKvk5RFBlCq7GUSv+elE8WS5/hHiPdAEzzn
         YKoEl7Xl2gKxV/IurTSYo0OpCq8vId2l3AAcZR8OHDP7md9ukCW6RXLipstxKJ1mh1Z1
         79Gt34mO3hwwLWPrmf70EGTprJA2dcKLJYIfi+ZzxCONNebDHNlsdbsl+2RcbhZlkdDI
         +iV6ByDEjjbvO0AkDZ3qzzsJMwnRpazfg99UZZvIe2qECn2VWcRioO3J5wWF6v08Jj19
         cuqHy34MzXV5Ug2GPckh01cn7qCCXqJecdub1LfqrILbP3xwDHTmY/G2AX53/MLlbiwc
         GMXA==
X-Gm-Message-State: ACgBeo2hujRu0WQMnsnK0QPKiOxmgJcV5UOSOLGsqlFKUtcZHLYaAZye
        +Ejzz/kxbnjmQKY8V0dyLGtz4pASuAcP7g==
X-Google-Smtp-Source: AA6agR6MrmKOM6YMNO36DQEx3PH24SfMiRMgQD5m6Q5CeGnLfH+M2aEVcln1K18QTsdDeQzlrQbk8Q==
X-Received: by 2002:a17:90a:5d93:b0:1f1:b730:11bd with SMTP id t19-20020a17090a5d9300b001f1b73011bdmr1127651pji.105.1659052292124;
        Thu, 28 Jul 2022 16:51:32 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g28-20020aa79f1c000000b00528a097aeffsm1307697pfr.118.2022.07.28.16.51.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 16:51:31 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: ISO: Fix info leak in iso_sock_getsockopt()
Date:   Thu, 28 Jul 2022 16:51:30 -0700
Message-Id: <20220728235130.1323745-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The C standard rules for when struct holes are zeroed out are slightly
weird.  The existing assignments might initialize everything, but GCC
is allowed to (and does sometimes) leave the struct holes uninitialized,
so instead of using yet another variable and copy the QoS settings just
use a pointer to the stored QoS settings.

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v2: Fix author

 net/bluetooth/iso.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 19d003727b50..dded22cde0d1 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1235,7 +1235,7 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 	int len, err = 0;
-	struct bt_iso_qos qos;
+	struct bt_iso_qos *qos;
 	u8 base_len;
 	u8 *base;
 
@@ -1261,12 +1261,12 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
 
 	case BT_ISO_QOS:
 		if (sk->sk_state == BT_CONNECTED || sk->sk_state == BT_CONNECT2)
-			qos = iso_pi(sk)->conn->hcon->iso_qos;
+			qos = &iso_pi(sk)->conn->hcon->iso_qos;
 		else
-			qos = iso_pi(sk)->qos;
+			qos = &iso_pi(sk)->qos;
 
-		len = min_t(unsigned int, len, sizeof(qos));
-		if (copy_to_user(optval, (char *)&qos, len))
+		len = min_t(unsigned int, len, sizeof(*qos));
+		if (copy_to_user(optval, qos, len))
 			err = -EFAULT;
 
 		break;
-- 
2.37.1

