Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE3EC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A7B610E9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240145AbhHMMUR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239683AbhHMMUR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:20:17 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6544C0617AE
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:19:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j21-20020a25d2150000b029057ac4b4e78fso8967980ybg.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wf0eyxF5NWE4g86nU1WG74jgOVwEPEElvt764q6iHS0=;
        b=TdycFAHGrabJYIYtAa3qRChuBh1zxoSB9h/Q9032lNXGk2V7cumVRzIJF+wAgvTrwG
         lZdjo5z6I/OCDjg1Doy/9WSzpSZ4xnb4onRa72VgBLr/2LFDGWRMUn7CfBGVh5pSPrt+
         dyRWjrSnmr7or2AD3b2JvClcNSsVLxoo+mnLL3p+w3q5gzRf8oCgOFG+6YWyA0DH+LtQ
         xoEeWhxAqItQSEG77wyLdo34OthSz39CFAQssmxZtSGhitEpdFvDFu3F58yd/Jf+e+r6
         fGvuSpCdFtFQldjVC2P8XKUdNpmm640k5SeJVuyV0n8JdyuzxwndvsOImjYsYGiic4yW
         LnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wf0eyxF5NWE4g86nU1WG74jgOVwEPEElvt764q6iHS0=;
        b=oAwJogPIxg5qlcdjaiX8Aw3GknTTZFTNAnY7csGOVPYcUirfoie1NLT62OfZl5xMHG
         hiTZ9b89ciKolSW3+9FEBcFfrDxQ5C+TcKBf6zxcIfQyzxqV66jNlx14dYcPbwx+aG6s
         HN9XBvlezlDUUy/DDaXk1Ipm1LjYB2LANb8RubUYzlkzg0xMUJryUG2V+Omj7cXTHQ3d
         EO0IV068swyUcM2iILKcEzkIkaHvClXUVNvaz+bFtkq+ELq7jjgOWsBeuY5Af8rF8ybI
         bgIMhKediPXxa/jfPJ1X5Az23HYvUOrwoz4FWOh+yZMQtiwUrlgDkG7d/0okIu+QHfJW
         zZKQ==
X-Gm-Message-State: AOAM532sDyXH9fP6nruKlLLa3Nui7Y6OBVlsbvCRTTbKv0JCeEniaRTL
        0j37OlJtLS1V2uPXpxi715+VPpoAOn7Fe7HDE60BRajwVmSC2LukaTmowhk+gDwCx3Xki+lRg46
        dv8cbS3GXAcPrND22VHr9HVnOyyTMTzjjorFtFFabej0PAT6vwizR3j6DmPy3Ceiaq5SWY8ngZ+
        l8
X-Google-Smtp-Source: ABdhPJxlgwD7fyzZIVCvMg07bpKyjC5NzVTpxUd8UAVyiaHkrxMIg0mcepi5vJGEZVXRlXfevFEqpWAjyQ9c
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a25:c5d4:: with SMTP id
 v203mr2685627ybe.295.1628857190039; Fri, 13 Aug 2021 05:19:50 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:17:49 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.4.I29592c8a1a134f751cfde25e962d389215836cb5@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 04/62] core: Inclusive language for l2cap
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

"central" is preferred, as reflected on the BT core spec 5.3.
---

 btio/btio.c            | 10 +++++-----
 lib/l2cap.h            |  2 +-
 profiles/health/mcap.c |  2 +-
 src/sdpd-server.c      |  2 +-
 tools/l2test.c         |  4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index 1f1c374bca..9c4601e6f8 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -369,13 +369,13 @@ static int l2cap_set_master(int sock, int master)
 		return -errno;
 
 	if (master) {
-		if (flags & L2CAP_LM_MASTER)
+		if (flags & L2CAP_LM_CENTRAL)
 			return 0;
-		flags |= L2CAP_LM_MASTER;
+		flags |= L2CAP_LM_CENTRAL;
 	} else {
-		if (!(flags & L2CAP_LM_MASTER))
+		if (!(flags & L2CAP_LM_CENTRAL))
 			return 0;
-		flags &= ~L2CAP_LM_MASTER;
+		flags &= ~L2CAP_LM_CENTRAL;
 	}
 
 	if (setsockopt(sock, SOL_L2CAP, L2CAP_LM, &flags, sizeof(flags)) < 0)
@@ -1180,7 +1180,7 @@ parse_opts:
 				return FALSE;
 			}
 			*(va_arg(args, gboolean *)) =
-				(flags & L2CAP_LM_MASTER) ? TRUE : FALSE;
+				(flags & L2CAP_LM_CENTRAL) ? TRUE : FALSE;
 			break;
 		case BT_IO_OPT_HANDLE:
 			if (l2cap_get_info(sock, &handle, dev_class) < 0) {
diff --git a/lib/l2cap.h b/lib/l2cap.h
index 9197800df4..a0ea111839 100644
--- a/lib/l2cap.h
+++ b/lib/l2cap.h
@@ -52,7 +52,7 @@ struct l2cap_conninfo {
 };
 
 #define L2CAP_LM	0x03
-#define L2CAP_LM_MASTER		0x0001
+#define L2CAP_LM_CENTRAL	0x0001
 #define L2CAP_LM_AUTH		0x0002
 #define L2CAP_LM_ENCRYPT	0x0004
 #define L2CAP_LM_TRUSTED	0x0008
diff --git a/profiles/health/mcap.c b/profiles/health/mcap.c
index be13af37a0..ab05a2bc24 100644
--- a/profiles/health/mcap.c
+++ b/profiles/health/mcap.c
@@ -2426,7 +2426,7 @@ static gboolean get_btrole(struct mcap_mcl *mcl)
 	if (getsockopt(sock, SOL_L2CAP, L2CAP_LM, &flags, &len))
 		DBG("CSP: could not read role");
 
-	return flags & L2CAP_LM_MASTER;
+	return flags & L2CAP_LM_CENTRAL;
 }
 
 uint64_t mcap_get_timestamp(struct mcap_mcl *mcl,
diff --git a/src/sdpd-server.c b/src/sdpd-server.c
index 306b92a44c..c71e2c22da 100644
--- a/src/sdpd-server.c
+++ b/src/sdpd-server.c
@@ -72,7 +72,7 @@ static int init_server(uint16_t mtu, int master, int compat)
 	}
 
 	if (master) {
-		int opt = L2CAP_LM_MASTER;
+		int opt = L2CAP_LM_CENTRAL;
 		if (setsockopt(l2cap_sock, SOL_L2CAP, L2CAP_LM, &opt, sizeof(opt)) < 0) {
 			error("setsockopt: %s", strerror(errno));
 			return -1;
diff --git a/tools/l2test.c b/tools/l2test.c
index 6e07f7b842..822cdc8cc9 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -484,7 +484,7 @@ static int do_connect(char *svr)
 	if (reliable)
 		opt |= L2CAP_LM_RELIABLE;
 	if (master)
-		opt |= L2CAP_LM_MASTER;
+		opt |= L2CAP_LM_CENTRAL;
 	if (auth)
 		opt |= L2CAP_LM_AUTH;
 	if (encr)
@@ -587,7 +587,7 @@ static void do_listen(void (*handler)(int sk))
 	if (reliable)
 		opt |= L2CAP_LM_RELIABLE;
 	if (master)
-		opt |= L2CAP_LM_MASTER;
+		opt |= L2CAP_LM_CENTRAL;
 	if (auth)
 		opt |= L2CAP_LM_AUTH;
 	if (encr)
-- 
2.33.0.rc1.237.g0d66db33f3-goog

