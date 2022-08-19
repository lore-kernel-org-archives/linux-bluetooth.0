Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FA9C28B2B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Aug 2022 18:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350856AbiHSSqi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Aug 2022 14:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350231AbiHSSqh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Aug 2022 14:46:37 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC7C5A808
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Aug 2022 11:46:36 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id d71so4325597pgc.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Aug 2022 11:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=RY0MEx0c3zHjGr9mFTA3DzqjpOmb+3Xm6UWnhkXTaxY=;
        b=iSOrJet5aHNnQ8RRXC+zU0XbkQcmpzM/5p0oEEWtkoX+kB6PubZuflo79C+EoSqJYk
         6NAY7jCcYVsHLfEpHuS22+X3ZUFhiH7ohS+rWm85mFtn6MdatHNzoYDfXbQ+Quad8yEj
         yThJz98nPs3lflKdvQkosCTZ13NDMNpEoID++v/l5SnCVy/r12Mx00kKg/g/IXGLabVO
         cwzOHt/LsWSbwYAsnzQXPvN8QHrFrX3rQzC3sqi6AvK6Bj+gidR5VLbmHR4E0kCIPUsv
         mQTt+cGq7ZfkUzvR2BMOhDyPSFYykxUa2Lt8RRDBWtr/knJvNZjmh4OkhSz+uL5pOw6x
         xa4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=RY0MEx0c3zHjGr9mFTA3DzqjpOmb+3Xm6UWnhkXTaxY=;
        b=oyUyDvCtP86BX05N8UO7rk6PyAi3Q8zf2HMAMBCyPG7t/ZFYAN293zSO7afnXroJ2H
         eFLy7SYxynIYWjUTSZnLEUHyA499pXjm4Jye2nC4wNBBL+KuDhuI9g21rfmWW0/GSUkN
         8cRdqkKgCL6zyFiYk92b5h7Z7L3USg01dfwEq+m2ZZdFFWpXthqRdu8rQYvxIMs0ZEGP
         LyDDIKlfTmbwligyyJxShd5MD5/wLVvLMBviQmmGYv+kraEBQQ+UjQJaiug8FujqiU5L
         VEX7UyFDd/+HtCHb/AZCdeWV6P1LyWW/QgPJWjWtpcIMllavDOrI+rwrgI4hOhh9X0MK
         kDIQ==
X-Gm-Message-State: ACgBeo0LxCa3hxGh0Z0O9PeLCNAlm59GQhlzKJj7QqZadDcuDgc1neUC
        ddrcSu2SS2278eRvVa3DyI2JU+Qb2Cc=
X-Google-Smtp-Source: AA6agR4TjwJR9NGFGk5kewHCV0b/sGkrHgGdRquZ2nv9zRDi6PuS9RS5VqC0UzBywt5F5vMIwwG99A==
X-Received: by 2002:a05:6a00:188a:b0:536:1401:7f65 with SMTP id x10-20020a056a00188a00b0053614017f65mr3775371pfh.1.1660934795161;
        Fri, 19 Aug 2022 11:46:35 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t28-20020a62d15c000000b0052d82ce65a9sm3869649pfl.143.2022.08.19.11.46.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 11:46:34 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: ISO: Fix not handling shutdown condition
Date:   Fri, 19 Aug 2022 11:46:33 -0700
Message-Id: <20220819184633.19437-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In order to properly handle shutdown syscall the code shall not assume
that the how argument is always SHUT_RDWR resulting in SHUTDOWN_MASK as
that would result in poll to immediatelly report EPOLLHUP instead of
properly waiting for disconnect_cfm (Disconnect Complete) which is
rather important for the likes of BAP as the CIG may need to be
reprogrammed.

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index ced8ad4fed4f..b50a69064fee 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1317,17 +1317,32 @@ static int iso_sock_shutdown(struct socket *sock, int how)
 	sock_hold(sk);
 	lock_sock(sk);
 
-	if (!sk->sk_shutdown) {
-		sk->sk_shutdown = SHUTDOWN_MASK;
-		iso_sock_clear_timer(sk);
-		__iso_sock_close(sk);
-
-		if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime &&
-		    !(current->flags & PF_EXITING))
-			err = bt_sock_wait_state(sk, BT_CLOSED,
-						 sk->sk_lingertime);
+	switch (how) {
+	case SHUT_RD:
+		if (sk->sk_shutdown & RCV_SHUTDOWN)
+			goto unlock;
+		sk->sk_shutdown |= RCV_SHUTDOWN;
+		break;
+	case SHUT_WR:
+		if (sk->sk_shutdown & SEND_SHUTDOWN)
+			goto unlock;
+		sk->sk_shutdown |= SEND_SHUTDOWN;
+		break;
+	case SHUT_RDWR:
+		if (sk->sk_shutdown & SHUTDOWN_MASK)
+			goto unlock;
+		sk->sk_shutdown |= SHUTDOWN_MASK;
+		break;
 	}
 
+	iso_sock_clear_timer(sk);
+	__iso_sock_close(sk);
+
+	if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime &&
+	    !(current->flags & PF_EXITING))
+		err = bt_sock_wait_state(sk, BT_CLOSED, sk->sk_lingertime);
+
+unlock:
 	release_sock(sk);
 	sock_put(sk);
 
-- 
2.37.2

