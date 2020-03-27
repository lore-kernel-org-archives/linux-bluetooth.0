Return-Path: <SRS0=n6SA=5M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A2BC43331
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 18:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C6420737
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 18:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BS+3CmGl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgC0ScS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Mar 2020 14:32:18 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36630 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgC0ScS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Mar 2020 14:32:18 -0400
Received: by mail-pj1-f68.google.com with SMTP id nu11so4114433pjb.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2020 11:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KBpriZqFlQAsdzISIe1ER5eiwYwTzaQJWbf0JLOfdzc=;
        b=BS+3CmGlV36CIJgz91XwEwPuMXp1bAOi0AGoS7tm45cmW7HyGK0aRwIB73UQitpdnB
         thPD0KkgjT+YlT2RrTa1LihOVj/0ljEMdPqYfa5oFoEZs6ZOux+k2HLM1H7kaaL6DddD
         QpLav27aoVkTWiqFz4S56WagqMpJ+Lknnd+jKblD0eSHN52WKMCIhol7WI+Vx7LlYcF5
         ZyNKhWN5e4ntTijk5orIJTvCwKlSYt3uyRD8gJcteGytp7UgSRzLiiK4KzDpyKJdXL19
         zEZFYXT3gPbXwGL/pY4gw1LVzi5urZ6mx4FMgYsQSVN8knajnUFXtYqMT2lNE3Kjo+fN
         5roA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KBpriZqFlQAsdzISIe1ER5eiwYwTzaQJWbf0JLOfdzc=;
        b=WVs5QtwwYALUWM+OGo71RphjeszidR2KAdxUFcFdnM3u4HLPnuu1DSc06IvnUiq08y
         +hM+JUJEPzQna5eCBG5yqdDwYMR6b1m+6AhEo1FIknLUqoEUQRjVf3l40T/qH+f68eDn
         QwVouU5oV/wEP3IYWDlJJe8/Ek4BuY8zwFtf2V+y+0PKNpzmfnPSAlNeGahqUtoNdIXx
         VR4zBksWhxPW5GuFLefCucwwGIBcsF4v1Z0mLOUxJKIqfQWytynAyJhMeyx5T6q+vRwX
         2M+N8x5PfQJDkKjZj+G5Dwg8YNPyL4PpTVmioOCmtm7J4NebMeCunwgxdCNrUAwJBrEL
         kp7g==
X-Gm-Message-State: ANhLgQ0dO9oUekZ9ueYLlAN4uOsJfYFCmrnRZqKYYU1uO3MlWFwi90Dd
        VMr/1/FilHi3cGwk/Z0MZaucQtl4
X-Google-Smtp-Source: ADFU+vuFtbUSfj70OfLjPBpaRTZVAAnBS5hyM11LFX467smzp7cyP6kc7DgvSRuxiiY8lFJgtLVabQ==
X-Received: by 2002:a17:90a:e382:: with SMTP id b2mr729948pjz.83.1585333937241;
        Fri, 27 Mar 2020 11:32:17 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x71sm4606406pfd.129.2020.03.27.11.32.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 11:32:16 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: L2CAP: Fix handling LE modes by L2CAP_OPTIONS
Date:   Fri, 27 Mar 2020 11:32:14 -0700
Message-Id: <20200327183215.27201-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

L2CAP_OPTIONS shall only be used with BR/EDR modes.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_sock.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 117ba20ea194..cfb402645c26 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -424,6 +424,20 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname,
 			break;
 		}
 
+		/* Only BR/EDR modes are supported here */
+		switch (chan->mode) {
+		case L2CAP_MODE_BASIC:
+		case L2CAP_MODE_ERTM:
+		case L2CAP_MODE_STREAMING:
+			break;
+		default:
+			err = -EINVAL;
+			break;
+		}
+
+		if (err < 0)
+			break;
+
 		memset(&opts, 0, sizeof(opts));
 		opts.imtu     = chan->imtu;
 		opts.omtu     = chan->omtu;
@@ -698,10 +712,8 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 			break;
 		}
 
-		chan->mode = opts.mode;
-		switch (chan->mode) {
-		case L2CAP_MODE_LE_FLOWCTL:
-			break;
+		/* Only BR/EDR modes are supported here */
+		switch (opts.mode) {
 		case L2CAP_MODE_BASIC:
 			clear_bit(CONF_STATE2_DEVICE, &chan->conf_state);
 			break;
@@ -715,6 +727,11 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 			break;
 		}
 
+		if (err < 0)
+			break;
+
+		chan->mode = opts.mode;
+
 		BT_DBG("mode 0x%2.2x", chan->mode);
 
 		chan->imtu = opts.imtu;
-- 
2.21.1

