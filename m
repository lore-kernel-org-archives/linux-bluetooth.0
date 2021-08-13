Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E21CC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8812B610A4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240496AbhHMMWa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240486AbhHMMW3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:22:29 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D88C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:22:03 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id j3-20020ac85f830000b029029113b02ff5so6260059qta.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YIhqjIy4Z1f9LlWA+2SAnStUjz7UiK1EetcELquEE5g=;
        b=SmXfh+6e7Y/4R+zeA0AdYD035as0P7rRRRiNwnfOJka18jv8bjeEtzJC3hC0Ag0gf+
         vhKHbVonhQUOpSQX16XM4lbRLQm7s6NlcsUj25EEVXAPL/AmxerADWGiEnCaye5Hry+b
         vJJAnXH0YNME6LqYuCJLU9YmaDpNydhkizGKuMjcvUBgNQJt68qtWw+/iQRlsgSgnNdD
         AW5utp8OM58OrZMBqYrmvuIxkkj3ePSYPVAlpws2gnGFpQ9R+yqGOMyCj9ODEUBvG8Vh
         5UZB4MNakWG4GCA1tI36+cbl0oQjYWS+8O1/PGfcsfW/1LlQ1fTYpxk/bJRqwyYFeByc
         0rNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YIhqjIy4Z1f9LlWA+2SAnStUjz7UiK1EetcELquEE5g=;
        b=P3/vpxH6VRadjL0Q39poAifl0seKibOx40/QHJjUUtN76DJ6JGIdnM5wQt8l4aPIsE
         msBdcnUe8rAbbRjQGvIm1OPHqfgfw2NDkIH99yOGFYg2YOFbUgB2wJwbPtZT7vfJ7exX
         wEvCdFj+2iS2xB6d5CGrtLGfjmKPUDB/Dhbjc9WTLW4nXnxK8aVHAHpCMPSEavIEAB0e
         XeMKS+Wg4XHHCZjh8qx0Uw8DcPIsAu57JuX2PIt3czk4JS/XMrC5+FdgNjf1XTk4HjT+
         nZ+Rw+ShdcxIpkLCQs/yMHtpFv2qNOMiPm0ELiz6s0vG0pDQctby41QyJ+I5Kpz5niTB
         esEg==
X-Gm-Message-State: AOAM531cIvRGBc2+T4oFIXJxt5DyCN54pbnTdnlhccII8/nI1DX0iNao
        aUoDrmLp3EHNrF/7k56BC6Cf4ypKR6BakZw57KdJowAWAUG439JLkRduMAQpsxXUJ4f0NwhvIK3
        4xl58JII3zSsP4U2o1ouEjzbcv7petCaGrve3+6FHvSWuAnuMTuMlIKYcC3McIJ35flg9oabOPz
        VI
X-Google-Smtp-Source: ABdhPJxbR2jFoXgcQLyRV8nK/E8Syp/4AoSbcv1lLp/Zk3yRMcu2yeNLMlVY90qNe3KtsIWx0qjyw29X8Ji1
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a05:6214:8c6:: with SMTP id
 da6mr2241634qvb.18.1628857322302; Fri, 13 Aug 2021 05:22:02 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:25 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.40.I08beeb185bf2986116252da72a42983b819413e8@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 40/62] tools/btiotest: Inclusive language changes
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

"central" is preferred, as reflected in the BT core spec 5.3.
---

 tools/btiotest.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/btiotest.c b/tools/btiotest.c
index 3f4900a5a5..1da8c20caf 100644
--- a/tools/btiotest.c
+++ b/tools/btiotest.c
@@ -310,7 +310,7 @@ static void l2cap_connect(const char *src, const char *dst, uint8_t addr_type,
 static void l2cap_listen(const char *src, uint8_t addr_type, uint16_t psm,
 				uint16_t cid, int defer, int reject,
 				int disconn, int accept, int sec,
-				gboolean master)
+				gboolean central)
 {
 	struct io_data *data;
 	BtIOConnect conn;
@@ -343,7 +343,7 @@ static void l2cap_listen(const char *src, uint8_t addr_type, uint16_t psm,
 					BT_IO_OPT_PSM, psm,
 					BT_IO_OPT_CID, cid,
 					BT_IO_OPT_SEC_LEVEL, sec,
-					BT_IO_OPT_CENTRAL, master,
+					BT_IO_OPT_CENTRAL, central,
 					BT_IO_OPT_INVALID);
 	else
 		l2_srv = bt_io_listen(conn, cfm, data,
@@ -353,7 +353,7 @@ static void l2cap_listen(const char *src, uint8_t addr_type, uint16_t psm,
 					BT_IO_OPT_PSM, psm,
 					BT_IO_OPT_CID, cid,
 					BT_IO_OPT_SEC_LEVEL, sec,
-					BT_IO_OPT_CENTRAL, master,
+					BT_IO_OPT_CENTRAL, central,
 					BT_IO_OPT_INVALID);
 
 	if (!l2_srv) {
@@ -402,7 +402,7 @@ static void rfcomm_connect(const char *src, const char *dst, uint8_t ch,
 
 static void rfcomm_listen(const char *src, uint8_t ch, gboolean defer,
 				int reject, int disconn, int accept,
-				int sec, gboolean master)
+				int sec, gboolean central)
 {
 	struct io_data *data;
 	BtIOConnect conn;
@@ -427,7 +427,7 @@ static void rfcomm_listen(const char *src, uint8_t ch, gboolean defer,
 					BT_IO_OPT_SOURCE, src,
 					BT_IO_OPT_CHANNEL, ch,
 					BT_IO_OPT_SEC_LEVEL, sec,
-					BT_IO_OPT_CENTRAL, master,
+					BT_IO_OPT_CENTRAL, central,
 					BT_IO_OPT_INVALID);
 	else
 		rc_srv = bt_io_listen(conn, cfm,
@@ -435,7 +435,7 @@ static void rfcomm_listen(const char *src, uint8_t ch, gboolean defer,
 					&err,
 					BT_IO_OPT_CHANNEL, ch,
 					BT_IO_OPT_SEC_LEVEL, sec,
-					BT_IO_OPT_CENTRAL, master,
+					BT_IO_OPT_CENTRAL, central,
 					BT_IO_OPT_INVALID);
 
 	if (!rc_srv) {
@@ -540,7 +540,7 @@ static int opt_reject = -1;
 static int opt_disconn = -1;
 static int opt_accept = DEFAULT_ACCEPT_TIMEOUT;
 static int opt_sec = 0;
-static gboolean opt_master = FALSE;
+static gboolean opt_central = FALSE;
 static int opt_priority = 0;
 static int opt_cid = 0;
 static guint8 opt_addr_type = 0;
@@ -576,8 +576,8 @@ static GOptionEntry options[] = {
 				"Disconnect connection after N seconds" },
 	{ "accept", 'a', 0, G_OPTION_ARG_INT, &opt_accept,
 				"Accept connection after N seconds" },
-	{ "master", 'm', 0, G_OPTION_ARG_NONE, &opt_master,
-				"Master role switch (incoming connections)" },
+	{ "central", 'C', 0, G_OPTION_ARG_NONE, &opt_central,
+				"Central role switch (incoming connections)" },
 	{ "priority", 'P', 0, G_OPTION_ARG_INT, &opt_priority,
 				"Transmission priority: Setting a priority "
 				"outside the range 0 to 6 requires the"
@@ -614,7 +614,7 @@ int main(int argc, char *argv[])
 		else
 			l2cap_listen(opt_dev, opt_addr_type, opt_psm, opt_cid,
 					opt_defer, opt_reject, opt_disconn,
-					opt_accept, opt_sec, opt_master);
+					opt_accept, opt_sec, opt_central);
 	}
 
 	if (opt_channel != -1) {
@@ -624,7 +624,7 @@ int main(int argc, char *argv[])
 		else
 			rfcomm_listen(opt_dev, opt_channel, opt_defer,
 					opt_reject, opt_disconn, opt_accept,
-					opt_sec, opt_master);
+					opt_sec, opt_central);
 	}
 
 	if (opt_sco) {
-- 
2.33.0.rc1.237.g0d66db33f3-goog

