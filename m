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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2A0C34031
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Feb 2020 05:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB8C20801
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Feb 2020 05:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/zeAvve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgBTFb6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Feb 2020 00:31:58 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43230 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgBTFb6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Feb 2020 00:31:58 -0500
Received: by mail-pf1-f196.google.com with SMTP id s1so1314291pfh.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Feb 2020 21:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oDsLetdwSgv1/v3WK4Dyfo4WpXul3BQH1eDz5N8aWxA=;
        b=M/zeAvvesjl/Tp5+ddv7CePrD0FkAttmdNPXYXo5KfrVTVZ/qL8dmPKPbDgfnm4Zj5
         LII/5rrLnNV6FiakVINFAxZhfm6rup3EVPcz3lkrlTiLFVN/M68lwDgfpeGwZi0GIWDV
         kNsjJC9MZDLQMGXzrbzw0v2nKJNQgKLb3KDjjfwgvgHB1EZE4p/V6F+RRyD08C1q0vpO
         RnevIuIsHqg91iX8Sg+0+h9vqBkz4v4vWy3rh25wiPnYkCJvwnDqzYp+MJz+61YeNUf5
         uA5LvgKcIuq3GlCC4fzmXJsh8pA8ylK6IineI97eBoWjKRNxI9v6Gl9p9l5xg/bc9+pC
         cAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oDsLetdwSgv1/v3WK4Dyfo4WpXul3BQH1eDz5N8aWxA=;
        b=hr33yFrUPsVg3wgmqjrpn6r99/psnBkkDGLWL/hqX5T1F9eNS0tgs8LwlWVE65kuOH
         CYjA2/oLckdHehdSLqsD7IKilyl7/u3rT9s4T3rqD5mj1/FtGDS4WK74N/ShcjYJYXLv
         RXNMJCooWyG0FeG3ccAoRW+OBX/uGEPMEYDm3HOYC9MJ2n+aMx4hFo0Es5kJwRlgJhIl
         seqg68jiJfVfIQdvmMcpq3IGfMDDSRznoXVj+L3oSBuccBsM3+bSf9tPkzii62cdFnXZ
         kZIMf304O6mRvILk/+IlRI7ZgCkzbXbf719AU1tUsk7Y338uwsxS6SRItkpno9LBK/Dx
         jniA==
X-Gm-Message-State: APjAAAWWtqqRwyOD00+C1milgmnA743YV9iDl0a2JaUSfrflL6eFqhcz
        JNLZrUSL4G2wgEGTu8+J4YVaM9QJXu8=
X-Google-Smtp-Source: APXvYqzBLTjMOmCGGdB9Htf8yOYAtNvgmcydyv2Fkc41bGfMCw2uQgs+iRwff9IUxnOdUhb6vvwd/g==
X-Received: by 2002:a63:306:: with SMTP id 6mr31198659pgd.337.1582176717401;
        Wed, 19 Feb 2020 21:31:57 -0800 (PST)
Received: from vudentzs-t460s.hsd1.or.comcast.net ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id r8sm1469823pjo.22.2020.02.19.21.31.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 21:31:56 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: RFCOMM: Use MTU auto tune logic
Date:   Wed, 19 Feb 2020 21:31:55 -0800
Message-Id: <20200220053155.27352-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This reuse the L2CAP MTU auto logic to select the MTU used for RFCOMM
channels, this should increase the maximum from 1013 to 1021 when 3-DH5
is supported.

Since it does not set an L2CAP MTU we no longer need a debugfs so that
is removed.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/rfcomm.h |  1 -
 net/bluetooth/rfcomm/core.c    | 10 ++++------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index da4acefe39c8..8d65d2a0b9b4 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -34,7 +34,6 @@
 #define RFCOMM_DEFAULT_MTU	127
 #define RFCOMM_DEFAULT_CREDITS	7
 
-#define RFCOMM_MAX_L2CAP_MTU	1013
 #define RFCOMM_MAX_CREDITS	40
 
 #define RFCOMM_SKB_HEAD_RESERVE	8
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index dcecce087b24..2e20af317cea 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -40,7 +40,6 @@
 static bool disable_cfc;
 static bool l2cap_ertm;
 static int channel_mtu = -1;
-static unsigned int l2cap_mtu = RFCOMM_MAX_L2CAP_MTU;
 
 static struct task_struct *rfcomm_thread;
 
@@ -749,7 +748,8 @@ static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
 	/* Set L2CAP options */
 	sk = sock->sk;
 	lock_sock(sk);
-	l2cap_pi(sk)->chan->imtu = l2cap_mtu;
+	/* Set MTU to 0 so L2CAP can auto select the MTU */
+	l2cap_pi(sk)->chan->imtu = 0;
 	l2cap_pi(sk)->chan->sec_level = sec_level;
 	if (l2cap_ertm)
 		l2cap_pi(sk)->chan->mode = L2CAP_MODE_ERTM;
@@ -2036,7 +2036,8 @@ static int rfcomm_add_listener(bdaddr_t *ba)
 	/* Set L2CAP options */
 	sk = sock->sk;
 	lock_sock(sk);
-	l2cap_pi(sk)->chan->imtu = l2cap_mtu;
+	/* Set MTU to 0 so L2CAP can auto select the MTU */
+	l2cap_pi(sk)->chan->imtu = 0;
 	release_sock(sk);
 
 	/* Start listening on the socket */
@@ -2234,9 +2235,6 @@ MODULE_PARM_DESC(disable_cfc, "Disable credit based flow control");
 module_param(channel_mtu, int, 0644);
 MODULE_PARM_DESC(channel_mtu, "Default MTU for the RFCOMM channel");
 
-module_param(l2cap_mtu, uint, 0644);
-MODULE_PARM_DESC(l2cap_mtu, "Default MTU for the L2CAP connection");
-
 module_param(l2cap_ertm, bool, 0644);
 MODULE_PARM_DESC(l2cap_ertm, "Use L2CAP ERTM mode for connection");
 
-- 
2.21.1

