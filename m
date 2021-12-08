Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3215EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Dec 2021 23:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbhLHXjX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Dec 2021 18:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbhLHXjX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Dec 2021 18:39:23 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2BEC061746
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Dec 2021 15:35:50 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id o14so2605976plg.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Dec 2021 15:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2FvceD/oqA7/mIKwKIa8xREQSqhE0Tmb9R0rKTZdAuw=;
        b=Jvws3Zt+LPsxW+VspYV+mge0AcLH30+0F+Sh9frWkA2SeoqB7m43lFIFLx0pva+l8S
         RrUJWRepEo3wV3v0rLCEKWoG4iqYxKLGQktKWb7Y1ZBDqr8frcmkk738wGmXPyufDCA4
         7b+2jGYOH6IkdeTDVj+0UrUpdZSW2wWytSuOI96BGhDnIxDF61XDpjwXv8Ook9mZ53RD
         4pg3XSH5XOVf6aexiYqwAuM68mwajGvxEPPSnM035N1UIQQvMiMjiis1lrvgvGy2GXyZ
         SDARhetTilP3htb6bdhZ2nPKfgMRd34KsTsM9DSZNZ3TjS3WNdRyb9kQSaMr7P/orneh
         w8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2FvceD/oqA7/mIKwKIa8xREQSqhE0Tmb9R0rKTZdAuw=;
        b=BqJB7DElcjP8nV+0YCnaMbYBzUGFBLjnIGkYXtM05DCL3XJ1EOBa4D4Ng7TedO2r0y
         zMeAhUiGSn5XpwGwK6mUEnnr+2k5v8j/iboAWfLTm42yadVFOz3Qvz1xBRwC9mtQhtTP
         YiZMd7ErCx8AA9CEuZwzr8UuvLjofsB4vh4xN6sg55nMbsfUN80t3720Kk0rw6OFre9d
         Oidw0AYDBFdh4VPNYcOa4eM7SPA0feFVd8RM3NHoNWaeIm99gEMhNpqC46B0IiE0tOpw
         s31KaI0Gv3MIBgn/KSS5I7DcvQVo/HcYIAcAIl+70pkXkSYRRSLPVA26x3m9PP1Rjzsm
         ODrA==
X-Gm-Message-State: AOAM530PEWmMOUvJytLmpeByPKDPhZsd7FMJgaRY+wzmN9luaIPRhck8
        j35u1LpbsXEqF6N+4TWGbEM6TCmx+0c=
X-Google-Smtp-Source: ABdhPJwMRtr8kGzIXc7ilIOl3m2K5JTj5kD6raHWhK116rGDJEuo9t570rYCo3WuMxXQf8Ji0ZBJ7g==
X-Received: by 2002:a17:90b:4f4c:: with SMTP id pj12mr10978492pjb.217.1639006550154;
        Wed, 08 Dec 2021 15:35:50 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b1sm3612209pgk.37.2021.12.08.15.35.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 15:35:49 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: Fix using wrong mode
Date:   Wed,  8 Dec 2021 15:35:48 -0800
Message-Id: <20211208233548.515899-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If user has a set to use SOCK_STREAM the socket would default to
L2CAP_MODE_ERTM which later needs to be adjusted if the destination
address is LE which doesn't support such mode.

Fixes: 15f02b9105625 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_sock.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 4574c5cb1b59..251017c69ab7 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -161,7 +161,11 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 		break;
 	}
 
-	if (chan->psm && bdaddr_type_is_le(chan->src_type))
+	/* Use L2CAP_MODE_LE_FLOWCTL (CoC) in case of LE address and
+	 * L2CAP_MODE_EXT_FLOWCTL (ECRED) has not been set.
+	 */
+	if (chan->psm && bdaddr_type_is_le(chan->src_type) &&
+	    chan->mode != L2CAP_MODE_EXT_FLOWCTL)
 		chan->mode = L2CAP_MODE_LE_FLOWCTL;
 
 	chan->state = BT_BOUND;
@@ -255,7 +259,11 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr,
 			return -EINVAL;
 	}
 
-	if (chan->psm && bdaddr_type_is_le(chan->src_type) && !chan->mode)
+	/* Use L2CAP_MODE_LE_FLOWCTL (CoC) in case of LE address and
+	 * L2CAP_MODE_EXT_FLOWCTL (ECRED) has not been set.
+	 */
+	if (chan->psm && bdaddr_type_is_le(chan->src_type) &&
+	    chan->mode != L2CAP_MODE_EXT_FLOWCTL)
 		chan->mode = L2CAP_MODE_LE_FLOWCTL;
 
 	l2cap_sock_init_pid(sk);
-- 
2.33.1

