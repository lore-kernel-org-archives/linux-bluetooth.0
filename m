Return-Path: <SRS0=m/C2=4G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88597C34026
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Feb 2020 18:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DBA021D56
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Feb 2020 18:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUUMtRnj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgBRSdY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:33:24 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38721 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgBRSdX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Feb 2020 13:33:23 -0500
Received: by mail-pl1-f196.google.com with SMTP id t6so8406601plj.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2020 10:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+5iyro5dL5q833u0D7Sw6LWpoy/E1PZqzaXCOHpKQVQ=;
        b=dUUMtRnjCNggb6cZ7EeYhNQ1XzY5TNVMIbAhmTMHPAWqQRZwRu8D7r602QNH2pTvPg
         t3ErAqrRyeWQo3GgZ59NNGMjXxAuKP7YTb682k7dn9g0NpB36zFowHDfh+uuWYbkWzuo
         P7NgqtPO+BYNhnSF4J9SV2F2SYGbjGmDkLW0twl2nlYromIpfI9tfa9S66bCp+oClkIC
         SCuj+ztldFE0O9RplvXecaOGqvQoS2cxfnIjjH5t0T0TcdrVYg2C2gUI5t7ck7qDchGL
         UA+S8l1DJ0aJIiOC0cc2dXuhgKOiTodwdZZqiOAsYGDKbY/8z2jyehpyjliD+lQINDg+
         uvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+5iyro5dL5q833u0D7Sw6LWpoy/E1PZqzaXCOHpKQVQ=;
        b=ecaD9xTqRo384L9Yh9MmYPSkrHba1PMY8PWPefQiP3jvi8ATqCMyc4AZfrKCWbdgVX
         bXDNeSS4vLOlpTD1vgjAJh7PoBF79DpK3t1e6B7foX+bM7y1hm3RvTVuT26JNoTJzgrV
         lPQflcUhIhD2Eu4CaA64Nk52zxx/zIFuTIzRPPidQ/m7fIt6FfTw0eztTrrgufkkG0Sy
         1wapPvfFLZ35jWv+x6dHGwPayCPiSm0eVJjDO9kIjxwL5bdk7mDHy4Fkh5Q1cGI30G8j
         acwy2Y2wa+Mmd86WzTBw6YmPJGtjg9sJ+ryf7o8tk8F1rqtmlzD499qLfuFj+GMKV+fm
         K5AQ==
X-Gm-Message-State: APjAAAVz0vWB0Sb6CD5Zaoiv9Xd6ND0L/G3xo0f/js7FHBOMm0pnR8Ey
        pvalfz6Q8P9j/jI7AdG4kD0RDszJ72I=
X-Google-Smtp-Source: APXvYqzFD7JOZay9Eb8cBY5EZ3D8TMM+hkxew1G4XFxzl8FHkpDLUN4ceHvpLQoB90fzxjh5qSGAdA==
X-Received: by 2002:a17:902:7046:: with SMTP id h6mr20587582plt.231.1582050802851;
        Tue, 18 Feb 2020 10:33:22 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.42])
        by smtp.gmail.com with ESMTPSA id s130sm5246683pfc.62.2020.02.18.10.33.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 10:33:21 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix crash when using new BT_PHY option
Date:   Tue, 18 Feb 2020 10:33:20 -0800
Message-Id: <20200218183320.22706-1-luiz.dentz@gmail.com>
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

