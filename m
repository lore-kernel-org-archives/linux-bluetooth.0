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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58889C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EB2F610A4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240497AbhHMMWl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240514AbhHMMWk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:22:40 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E216CC061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:22:13 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id h19-20020a170902eed3b029012d3624d993so6005618plb.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QaeCZz/X417V82IwZkxYXDYRX2ARQzxCTvYni7UzYxc=;
        b=LdYZKgt/W63wQ+jQoYQ4NsbjFP3ZA3LZBP7haYDG4466cyVhcYHUvod8MojQ8M2WPq
         lSeBUTsT8F+s3BfRoqzQPJB3Wzioyv58RqSNzeizX1UamE24QKjdD2Dx6xvE2YcF8bky
         gqnBjcqEQJcxcSWFNfMpO+xiG++AiypMPv6Kh339gcPjlXDmrBx5ZwapaE/xvCrEr8Ko
         nlRubEBzqWnCbpiEaA8mqLAbjIQVnnmeShNXSX93GFoJVw9/9MOi6va0eJELDnoU3n8U
         9LaatOhL592zszGpYW5j/gmC5osyx5XGYgID4+PnEgBH9HD/7otN6zab02a8Iri/8sxY
         g2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QaeCZz/X417V82IwZkxYXDYRX2ARQzxCTvYni7UzYxc=;
        b=MLZdub03qKj7HX6zIQaIQP6eTijiBMbwWvYF+fH/3IFt9H/tjI8JaNcRe1XAODcogv
         Imm4+24wkOxGYb44kMICI+WGgiziE5g21wa8+aajw3xatn2RyJ9pG0/6Ga3RZdk5QdAI
         ayGtwEeGj7SRtY+X6B2V3Nr+QaZ7iZ7sZWy34tjVL38CUQFAbVMQxsNvD4vqBepky1mw
         rUXTfpBfeHphnOVSCmxvBmDV9YA/ZCIXRneHK653KHdxvf8mwBYwo7GwgF10P0uNTUA6
         cWRHUzjyY/JNH24BXkhHhDXai/VqxRjGa7BGps0nYyvEkSi9MDnD9CMOXTUhxJ3y1x2n
         5UvA==
X-Gm-Message-State: AOAM5331wqy8H8MQN8Lc5tgfnAn2ZnI1OofOc4qo/oQTQIqNsqMgTRzy
        3v+XWYKHBTK1S7s7SE4qOvSX0Zw0BVaLIAzkc2Qc+qdDlpBCzKiGbGIzg9Y7oYug2M32xRJ/eha
        tlKVE7Mjk2GzgNETv0PlYC5/KzY48jfKAdITmcltoO1Tozde9+mPwVSkEsZvfAm11cAI4prsuir
        OW
X-Google-Smtp-Source: ABdhPJy42Cu9gdnFpKx3qYciEuuPQbN+wvJpAu7GjkZ+rBqTdWpaa9hauT9Hg8uioddsvorUFppQSC3Oakp+
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a17:902:bc84:b029:12c:f9b9:db98 with SMTP
 id bb4-20020a170902bc84b029012cf9b9db98mr1940081plb.19.1628857333349; Fri, 13
 Aug 2021 05:22:13 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:28 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.43.I4fd145f86a01b9370af7bf7750a08090de2b5a03@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 43/62] tools/l2test: Inclusive language changes
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

 tools/l2test.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/l2test.c b/tools/l2test.c
index 822cdc8cc9..ca58a6549b 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -110,7 +110,7 @@ static int seq_start = 0;
 static const char *filename = NULL;
 
 static int rfcmode = 0;
-static int master = 0;
+static int central = 0;
 static int auth = 0;
 static int encr = 0;
 static int secure = 0;
@@ -483,7 +483,7 @@ static int do_connect(char *svr)
 	opt = 0;
 	if (reliable)
 		opt |= L2CAP_LM_RELIABLE;
-	if (master)
+	if (central)
 		opt |= L2CAP_LM_CENTRAL;
 	if (auth)
 		opt |= L2CAP_LM_AUTH;
@@ -586,7 +586,7 @@ static void do_listen(void (*handler)(int sk))
 	opt = 0;
 	if (reliable)
 		opt |= L2CAP_LM_RELIABLE;
-	if (master)
+	if (central)
 		opt |= L2CAP_LM_CENTRAL;
 	if (auth)
 		opt |= L2CAP_LM_AUTH;
@@ -1306,7 +1306,7 @@ static void usage(void)
 		"\t[-W seconds] enable deferred setup\n"
 		"\t[-B filename] use data packets from file\n"
 		"\t[-N num] send num frames (default = infinite)\n"
-		"\t[-C num] send num frames before delay (default = 1)\n"
+		"\t[-M num] send num frames before delay (default = 1)\n"
 		"\t[-D milliseconds] delay after sending num frames (default = 0)\n"
 		"\t[-K milliseconds] delay before receiving (default = 0)\n"
 		"\t[-g milliseconds] delay before disconnecting (default = 0)\n"
@@ -1323,7 +1323,7 @@ static void usage(void)
 		"\t[-A] request authentication\n"
 		"\t[-E] request encryption\n"
 		"\t[-S] secure connection\n"
-		"\t[-M] become master\n"
+		"\t[-C] become central\n"
 		"\t[-T] enable timestamps\n"
 		"\t[-V type] address type (help for list, default = bredr)\n"
 		"\t[-e seq] initial sequence value (default = 0)\n");
@@ -1337,7 +1337,7 @@ int main(int argc, char *argv[])
 	bacpy(&bdaddr, BDADDR_ANY);
 
 	while ((opt = getopt(argc, argv, "a:b:cde:g:i:mnpqrstuwxyz"
-		"AB:C:D:EF:GH:I:J:K:L:MN:O:P:Q:RSTUV:W:X:Y:Z:")) != EOF) {
+		"AB:CD:EF:GH:I:J:K:L:M:N:O:P:Q:RSTUV:W:X:Y:Z:")) != EOF) {
 		switch (opt) {
 		case 'r':
 			mode = RECV;
@@ -1442,7 +1442,7 @@ int main(int argc, char *argv[])
 			num_frames = atoi(optarg);
 			break;
 
-		case 'C':
+		case 'M':
 			count = atoi(optarg);
 			break;
 
@@ -1488,8 +1488,8 @@ int main(int argc, char *argv[])
 			reliable = 1;
 			break;
 
-		case 'M':
-			master = 1;
+		case 'C':
+			central = 1;
 			break;
 
 		case 'A':
-- 
2.33.0.rc1.237.g0d66db33f3-goog

