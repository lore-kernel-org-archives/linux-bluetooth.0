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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065CAC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF7BE610A4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240501AbhHMMWo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240499AbhHMMWo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:22:44 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB89C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:22:17 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id w19-20020ac87e930000b029025a2609eb04so6221473qtj.17
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2dgFyva0821C03h1TFtASoDBUUvCh+kg+Xf8M9Fofg4=;
        b=BBlx3FgMnxq2h/BEqx/I7fSFyMUMcCbjqIdKqyaqT82DtZWv+UgvX1wCswIH+6yVqf
         jIzlxFdAI545e4V+7Tao9uCX815BYiUIBAYT00hsEJ7G2fbOROoCLa8ot+ze9M5x9ncy
         0OuG9stTOO+QkNueW/qOFbhH9buD5tGhvOhZMt+Qt8TopGy89CyfWg7Kzcs0AbFFT6dv
         XTWU2AHDFPg8edGWwAZojrGEG5Jnmng+rOK83njnePampV/uLVWOsynFIloeI730pSqI
         t4qHM02h/Fv6ADcai6uWs0Kw47S0s2WrakCdW36Kdrf9hSZhPBLdnH5Hk9lSzcodlD9j
         MqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2dgFyva0821C03h1TFtASoDBUUvCh+kg+Xf8M9Fofg4=;
        b=bzmJTV3q10cIzDqZsl/l3N/RFRGjIAa4GnJuzqkH7Ot4Kn1elZh0aeoK14yXhzj+V5
         JZkFMsB8MLWV3Pxoe0QMrrsk1ZXYsPyZskLgivsG31R//PTsDFiZCLtBPrYrVl2VqqW9
         RKcJDL1YowT0N2wXtmTVXJQUhw7eOFUDwbAnXcNHd0aJS6XCYJNM7apeLPUcDMoizHuW
         WKRaZR4uuGkK+8Gx7fBkdNm077mBykqHd0IwUmvK1coMpy6JiFW0D24dLx5cjd+5eAGd
         rMlujyA/zgx6e7J8NdPbfCnidvUzO+bZ65BcBJuIbMdoaxqkC+gT9kt4+0sPr3l/4Uvh
         oX0g==
X-Gm-Message-State: AOAM533UnTRd+FmM71Yk6ebytvnop8MS3xjC38fGxZptIeWJzLxTdW9K
        eIGtVS6aIjqh5e5GtlbkDWevQgvRblRJe2ynWjIK8OJX6GwfaBCd8pMCvxO/hketLI4PIrmVT6w
        EwCEGNIDGHK7neq4lYeqNaWsQxO7LS41EoPKYvCfQnpIlM7XME8KZ8wPi1joAn5iQKUnYdyTFvi
        jE
X-Google-Smtp-Source: ABdhPJy025VTaI6tjONxsFlcEznaHjMDXfKRcgUU8tsG58pvKYG5asCzPuh1s6V1vlUcqn9fk+pA9kKvIKsu
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a05:6214:ca2:: with SMTP id
 s2mr2191233qvs.35.1628857336749; Fri, 13 Aug 2021 05:22:16 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:29 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.44.Ie45c8a85e3d5aca1bd93de1c1772ec904528f716@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 44/62] tools/rctest: Inclusive language changes
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

 tools/rctest.c   | 18 +++++++++---------
 tools/rctest.rst |  4 ++--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/rctest.c b/tools/rctest.c
index 034ae167b2..7fd6c355de 100644
--- a/tools/rctest.c
+++ b/tools/rctest.c
@@ -76,7 +76,7 @@ static const char *filename = NULL;
 static const char *savefile = NULL;
 static int save_fd = -1;
 
-static int master = 0;
+static int central = 0;
 static int auth = 0;
 static int encr = 0;
 static int secure = 0;
@@ -202,7 +202,7 @@ static int do_connect(const char *svr)
 
 	/* Set link mode */
 	opt = 0;
-	if (master)
+	if (central)
 		opt |= RFCOMM_LM_CENTRAL;
 	if (auth)
 		opt |= RFCOMM_LM_AUTH;
@@ -293,7 +293,7 @@ static void do_listen(void (*handler)(int sk))
 
 	/* Set link mode */
 	opt = 0;
-	if (master)
+	if (central)
 		opt |= RFCOMM_LM_CENTRAL;
 	if (auth)
 		opt |= RFCOMM_LM_AUTH;
@@ -679,13 +679,13 @@ static void usage(void)
 		"\t[-B filename] use data packets from file\n"
 		"\t[-O filename] save received data to file\n"
 		"\t[-N num] number of frames to send\n"
-		"\t[-C num] send num frames before delay (default = 1)\n"
+		"\t[-M num] send num frames before delay (default = 1)\n"
 		"\t[-D milliseconds] delay after sending num frames (default = 0)\n"
 		"\t[-Y priority] socket priority\n"
 		"\t[-A] request authentication\n"
 		"\t[-E] request encryption\n"
 		"\t[-S] secure connection\n"
-		"\t[-M] become master\n"
+		"\t[-C] become central\n"
 		"\t[-T] enable timestamps\n");
 }
 
@@ -697,7 +697,7 @@ int main(int argc, char *argv[])
 	bacpy(&bdaddr, BDADDR_ANY);
 	bacpy(&auto_bdaddr, BDADDR_ANY);
 
-	while ((opt=getopt(argc,argv,"rdscuwmna:b:i:P:U:B:O:N:MAESL:W:C:D:Y:T")) != EOF) {
+	while ((opt=getopt(argc,argv,"rdscuwmna:b:i:P:U:B:O:N:CAESL:W:M:D:Y:T")) != EOF) {
 		switch (opt) {
 		case 'r':
 			mode = RECV;
@@ -769,8 +769,8 @@ int main(int argc, char *argv[])
 				uuid = atoi(optarg);
 			break;
 
-		case 'M':
-			master = 1;
+		case 'C':
+			central = 1;
 			break;
 
 		case 'A':
@@ -805,7 +805,7 @@ int main(int argc, char *argv[])
 			num_frames = atoi(optarg);
 			break;
 
-		case 'C':
+		case 'M':
 			count = atoi(optarg);
 			break;
 
diff --git a/tools/rctest.rst b/tools/rctest.rst
index 23595112d7..e0982adc3f 100644
--- a/tools/rctest.rst
+++ b/tools/rctest.rst
@@ -56,7 +56,7 @@ OPTIONS
 
 -N num          send num frames
 
--C num          send num frames before delay (default: 1)
+-M num          send num frames before delay (default: 1)
 
 -D milliseconds     delay milliseconds after sending num frames (default: 0)
 
@@ -66,7 +66,7 @@ OPTIONS
 
 -S              secure connection
 
--M              become master
+-C              become central
 
 -T              enable timestamps
 
-- 
2.33.0.rc1.237.g0d66db33f3-goog

