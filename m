Return-Path: <SRS0=cA0y=4I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467FFC7619D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Feb 2020 01:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2E624673
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Feb 2020 01:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2sede6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgBTBDb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Feb 2020 20:03:31 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39942 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgBTBDb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Feb 2020 20:03:31 -0500
Received: by mail-pf1-f193.google.com with SMTP id b185so1007085pfb.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Feb 2020 17:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+5iyro5dL5q833u0D7Sw6LWpoy/E1PZqzaXCOHpKQVQ=;
        b=H2sede6P5YCUH1r9hR+Dg/i+oAEK1VZ2ugOhsMi+wAtKJWx5ed48usKJbz0djGk6gV
         pWQ9vjWYnF4lmYErodDD/eLylbjYFJ7PSdT3kYQczUceC4uHzs5hQXXLCkhhARjGvOtQ
         CpI0DBFSkY72/1+hw2Arc6Rw3zZnpZkwHLajVNzj4fY4QLQtwwzqztTmuHh9PXohjoYt
         om5mJ3tO6r2opvfRAiONorDdU30WDq82Akon6ArF/xs630IAq5zi4edLBHRCYzVHRkXM
         lLq2VMvlQE4OKZBjKdQMckN2idt7auRIhouGm3AS18tni3MuvMSvn3HN3XzQGYLBxHO+
         23UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+5iyro5dL5q833u0D7Sw6LWpoy/E1PZqzaXCOHpKQVQ=;
        b=QTwARSP9n/K6BUikS1zuLHFCTwS+Ppbgq39uZ7+n7KAXnz73gz7TEg3bDUNFlcYsGW
         Pa7EBmQu4r8TmrE4zT4V7fP+kSWXUqU8KjHTnso7lSr0thXecjVOLmueHuveee1rLEKd
         FVJYHQDgTr1zUGImtHbMeWZbL66wB5TYtiwIFRAGc5SGah5K7VrF6FqBE2Yh/D4SVgc/
         A1Czd/XXrmbqrMG0W6AnTF2wrwSCkNO7HpXHnILbyO8aDh0Vd00oCMcrzlLQpW11r4fF
         5ZPBrDfIw/a6poi7uwsQq1LWtrnvvHsFysDD5YbQ8QccIBKL3ZPueZvXxcCzQDCGlNK5
         xpHQ==
X-Gm-Message-State: APjAAAUcI6g7Oa7n5tQzhZplA0FwMOKgt9xAaTAHzwy//GMn1FDJMCr8
        BjBrYIyarQidxw9uW2MHBUT1VOOMc7w=
X-Google-Smtp-Source: APXvYqxkxp1fqW7BjUC9q3+A+w/3v+s8HQ3+O0wEfFjfp9VECD4pUXOWdDeH8769YU11h2kRi4U2ww==
X-Received: by 2002:a65:4b83:: with SMTP id t3mr29943297pgq.195.1582160610466;
        Wed, 19 Feb 2020 17:03:30 -0800 (PST)
Received: from vudentzs-t460s.hsd1.or.comcast.net ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id g18sm828592pfi.80.2020.02.19.17.03.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 17:03:29 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix crash when using new BT_PHY option
Date:   Wed, 19 Feb 2020 17:03:28 -0800
Message-Id: <20200220010328.10132-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the invalid check for connected socket which causes the
following trace due to sco_pi(sk)->conn being NULL:

RIP: 0010:sco_sock_getsockopt+0x2ff/0x800 net/bluetooth/sco.c:966

L2CAP has also been fixed since it has the same problem.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_sock.c | 2 +-
 net/bluetooth/sco.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 9fb47b2b13c9..305710446e66 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -605,7 +605,7 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_PHY:
-		if (sk->sk_state == BT_CONNECTED) {
+		if (sk->sk_state != BT_CONNECTED) {
 			err = -ENOTCONN;
 			break;
 		}
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 29ab3e12fb46..c8c3d38cdc7b 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -958,7 +958,7 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_PHY:
-		if (sk->sk_state == BT_CONNECTED) {
+		if (sk->sk_state != BT_CONNECTED) {
 			err = -ENOTCONN;
 			break;
 		}
-- 
2.21.1

