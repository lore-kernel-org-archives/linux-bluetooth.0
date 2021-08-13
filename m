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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722C9C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AB1B60F00
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240465AbhHMMWh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240480AbhHMMWg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:22:36 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2665FC061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:22:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n200-20020a25d6d10000b02905935ac4154aso8930059ybg.23
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CZqpxQe6u5bb/HMVukOEbGayrQPrXGOR9HJq0rbq8bA=;
        b=ZUb8IcW+rlKD7IKKR5fTNO8BpQ6bKALmgG3TMUFr6czjcjebe5amMGSvJrQBOjaTdm
         qoi7e5CdDSS/6bItIseWyZ3GtuA48gtvOwJ9M6uN8Kj+qANmL1+L2QJpITt05vqJE8j0
         pzPq49rIEI1ebvKdCIxP5qoW3WTwoodhBYijaysdSpWlpE/HtsAEJ/5oHsHGSFvgGtPs
         jUpf4KjvkXfFXgtkUJ4OQXC//RnzzFleBEErlkke1oTmIvF9F38YY3gTeeeamL728Zgq
         bT9aN9iAwa2E013d+LEdaQwQCHil0BckpzGkgcdL0okFfq8/mSG9hM/OJZgBb4THPDB2
         bH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CZqpxQe6u5bb/HMVukOEbGayrQPrXGOR9HJq0rbq8bA=;
        b=f2WwgWKGUDmC1Zpn/Amw5rXUIupkysLr1ncTzG+nZXra0XQX/EYCZzTfy9tPw0Yts7
         g5v0eIWMoPLSZt4yMMiz6mU6aebA8GjZ9D/3jD4Exhc9OxpyYahvKTnqWbEx97K+l3vh
         KfwA9vw7gosNB4kTLjf+jgT+Gza8mvOCoKOYiGqOIj1xYqQEzlYjmbvWS6Muz6dvsW7q
         O1qa51hvnjxNvd9hU87dyGMnqQ+xRq6MSwuxzRVub583lENiFcLf2Su/aNE6WPaHxmvm
         bd/TZFd4HwBnHsndiW2mwJz67z/NbBFUQn9Ttero7A21sgGUFMDU+U/A2klwzwJrqOtJ
         orEg==
X-Gm-Message-State: AOAM5321xRnVK4wgO7P6+UYHDlAQ1PpHZJPgTX3/MELKDC0OBCYRK6dF
        ZNLoI4AdV3fD2iE6r3I3HRzTAC/O/pvB3yB6LjjOHxLjJi0fAQGQVOqQu4ModPLbeq+8kH3azcq
        1VmsKY711Ik8gubDKKVYneyCWG28nrt1elU5q8Y8FjJYuPVifjN1+qvMZfdmGuxbG8Un+biWii8
        N4
X-Google-Smtp-Source: ABdhPJxWfiykgfexTcBHphioJsIksy6Qd1mpEeE5oGW49FAEZqq9QYKAAXVSpk+s2tBlE1/Ij+iF6EfYuKvI
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a25:a163:: with SMTP id
 z90mr2635160ybh.378.1628857329343; Fri, 13 Aug 2021 05:22:09 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:27 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.42.I7f857a7b3ad6c99bef365a7ad645d5e37021ffcd@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 42/62] tools/hcitool: Inclusive language changes, accept list
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

"accept list" is preferred, as reflected in the BT core spec 5.3.
---

 tools/hcitool.c   | 90 +++++++++++++++++++++++------------------------
 tools/hcitool.rst | 20 +++++------
 2 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/tools/hcitool.c b/tools/hcitool.c
index f61eae106c..082895bce4 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -2474,7 +2474,7 @@ static struct option lescan_options[] = {
 	{ "static",	0, 0, 's' },
 	{ "privacy",	0, 0, 'p' },
 	{ "passive",	0, 0, 'P' },
-	{ "whitelist",	0, 0, 'w' },
+	{ "acceptlist",	0, 0, 'a' },
 	{ "discovery",	1, 0, 'd' },
 	{ "duplicates",	0, 0, 'D' },
 	{ 0, 0, 0, 0 }
@@ -2484,7 +2484,7 @@ static const char *lescan_help =
 	"Usage:\n"
 	"\tlescan [--privacy] enable privacy\n"
 	"\tlescan [--passive] set scan type passive (default active)\n"
-	"\tlescan [--whitelist] scan for address in the whitelist only\n"
+	"\tlescan [--acceptlist] scan for address in the accept list only\n"
 	"\tlescan [--discovery=g|l] enable general or limited discovery"
 		"procedure\n"
 	"\tlescan [--duplicates] don't filter duplicates\n";
@@ -2511,8 +2511,8 @@ static void cmd_lescan(int dev_id, int argc, char **argv)
 		case 'P':
 			scan_type = 0x00; /* Passive */
 			break;
-		case 'w':
-			filter_policy = 0x01; /* Whitelist */
+		case 'a':
+			filter_policy = 0x01; /* Accept list */
 			break;
 		case 'd':
 			filter_type = optarg[0];
@@ -2678,14 +2678,14 @@ static struct option lecc_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "static",	0, 0, 's' },
 	{ "random",	0, 0, 'r' },
-	{ "whitelist",	0, 0, 'w' },
+	{ "acceptlist",	0, 0, 'a' },
 	{ 0, 0, 0, 0 }
 };
 
 static const char *lecc_help =
 	"Usage:\n"
 	"\tlecc [--static] [--random] <bdaddr>\n"
-	"\tlecc --whitelist\n";
+	"\tlecc --acceptlist\n";
 
 static void cmd_lecc(int dev_id, int argc, char **argv)
 {
@@ -2707,8 +2707,8 @@ static void cmd_lecc(int dev_id, int argc, char **argv)
 		case 'r':
 			peer_bdaddr_type = LE_RANDOM_ADDRESS;
 			break;
-		case 'w':
-			initiator_filter = 0x01; /* Use white list */
+		case 'a':
+			initiator_filter = 0x01; /* Use accept list */
 			break;
 		default:
 			printf("%s", lecc_help);
@@ -2753,34 +2753,34 @@ static void cmd_lecc(int dev_id, int argc, char **argv)
 	hci_close_dev(dd);
 }
 
-static struct option lewladd_options[] = {
+static struct option lealall_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "random",	0, 0, 'r' },
 	{ 0, 0, 0, 0 }
 };
 
-static const char *lewladd_help =
+static const char *lealall_help =
 	"Usage:\n"
-	"\tlewladd [--random] <bdaddr>\n";
+	"\tlealall [--random] <bdaddr>\n";
 
-static void cmd_lewladd(int dev_id, int argc, char **argv)
+static void cmd_lealall(int dev_id, int argc, char **argv)
 {
 	int err, opt, dd;
 	bdaddr_t bdaddr;
 	uint8_t bdaddr_type = LE_PUBLIC_ADDRESS;
 
-	for_each_opt(opt, lewladd_options, NULL) {
+	for_each_opt(opt, lealall_options, NULL) {
 		switch (opt) {
 		case 'r':
 			bdaddr_type = LE_RANDOM_ADDRESS;
 			break;
 		default:
-			printf("%s", lewladd_help);
+			printf("%s", lealall_help);
 			return;
 		}
 	}
 
-	helper_arg(1, 1, &argc, &argv, lewladd_help);
+	helper_arg(1, 1, &argc, &argv, lealall_help);
 
 	if (dev_id < 0)
 		dev_id = hci_get_route(NULL);
@@ -2798,35 +2798,35 @@ static void cmd_lewladd(int dev_id, int argc, char **argv)
 
 	if (err < 0) {
 		err = -errno;
-		fprintf(stderr, "Can't add to white list: %s(%d)\n",
+		fprintf(stderr, "Can't add to accept list: %s(%d)\n",
 							strerror(-err), -err);
 		exit(1);
 	}
 }
 
-static struct option lewlrm_options[] = {
+static struct option lealrm_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ 0, 0, 0, 0 }
 };
 
-static const char *lewlrm_help =
+static const char *lealrm_help =
 	"Usage:\n"
-	"\tlewlrm <bdaddr>\n";
+	"\tlealrm <bdaddr>\n";
 
-static void cmd_lewlrm(int dev_id, int argc, char **argv)
+static void cmd_lealrm(int dev_id, int argc, char **argv)
 {
 	int err, opt, dd;
 	bdaddr_t bdaddr;
 
-	for_each_opt(opt, lewlrm_options, NULL) {
+	for_each_opt(opt, lealrm_options, NULL) {
 		switch (opt) {
 		default:
-			printf("%s", lewlrm_help);
+			printf("%s", lealrm_help);
 			return;
 		}
 	}
 
-	helper_arg(1, 1, &argc, &argv, lewlrm_help);
+	helper_arg(1, 1, &argc, &argv, lealrm_help);
 
 	if (dev_id < 0)
 		dev_id = hci_get_route(NULL);
@@ -2844,35 +2844,35 @@ static void cmd_lewlrm(int dev_id, int argc, char **argv)
 
 	if (err < 0) {
 		err = errno;
-		fprintf(stderr, "Can't remove from white list: %s(%d)\n",
+		fprintf(stderr, "Can't remove from accept list: %s(%d)\n",
 							strerror(err), err);
 		exit(1);
 	}
 }
 
-static struct option lewlsz_options[] = {
+static struct option lealsz_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ 0, 0, 0, 0 }
 };
 
-static const char *lewlsz_help =
+static const char *lealsz_help =
 	"Usage:\n"
-	"\tlewlsz\n";
+	"\tlealsz\n";
 
-static void cmd_lewlsz(int dev_id, int argc, char **argv)
+static void cmd_lealsz(int dev_id, int argc, char **argv)
 {
 	int err, dd, opt;
 	uint8_t size;
 
-	for_each_opt(opt, lewlsz_options, NULL) {
+	for_each_opt(opt, lealsz_options, NULL) {
 		switch (opt) {
 		default:
-			printf("%s", lewlsz_help);
+			printf("%s", lealsz_help);
 			return;
 		}
 	}
 
-	helper_arg(0, 0, &argc, &argv, lewlsz_help);
+	helper_arg(0, 0, &argc, &argv, lealsz_help);
 
 	if (dev_id < 0)
 		dev_id = hci_get_route(NULL);
@@ -2888,36 +2888,36 @@ static void cmd_lewlsz(int dev_id, int argc, char **argv)
 
 	if (err < 0) {
 		err = -errno;
-		fprintf(stderr, "Can't read white list size: %s(%d)\n",
+		fprintf(stderr, "Can't read accept list size: %s(%d)\n",
 							strerror(-err), -err);
 		exit(1);
 	}
 
-	printf("White list size: %d\n", size);
+	printf("Accept list size: %d\n", size);
 }
 
-static struct option lewlclr_options[] = {
+static struct option lealclr_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ 0, 0, 0, 0 }
 };
 
-static const char *lewlclr_help =
+static const char *lealclr_help =
 	"Usage:\n"
-	"\tlewlclr\n";
+	"\tlealclr\n";
 
-static void cmd_lewlclr(int dev_id, int argc, char **argv)
+static void cmd_lealclr(int dev_id, int argc, char **argv)
 {
 	int err, dd, opt;
 
-	for_each_opt(opt, lewlclr_options, NULL) {
+	for_each_opt(opt, lealclr_options, NULL) {
 		switch (opt) {
 		default:
-			printf("%s", lewlclr_help);
+			printf("%s", lealclr_help);
 			return;
 		}
 	}
 
-	helper_arg(0, 0, &argc, &argv, lewlclr_help);
+	helper_arg(0, 0, &argc, &argv, lealclr_help);
 
 	if (dev_id < 0)
 		dev_id = hci_get_route(NULL);
@@ -2933,7 +2933,7 @@ static void cmd_lewlclr(int dev_id, int argc, char **argv)
 
 	if (err < 0) {
 		err = -errno;
-		fprintf(stderr, "Can't clear white list: %s(%d)\n",
+		fprintf(stderr, "Can't clear accept list: %s(%d)\n",
 							strerror(-err), -err);
 		exit(1);
 	}
@@ -3394,10 +3394,10 @@ static struct {
 	{ "clock",    cmd_clock,   "Read local or remote clock"           },
 	{ "lescan",   cmd_lescan,  "Start LE scan"                        },
 	{ "leinfo",   cmd_leinfo,  "Get LE remote information"            },
-	{ "lewladd",  cmd_lewladd, "Add device to LE White List"          },
-	{ "lewlrm",   cmd_lewlrm,  "Remove device from LE White List"     },
-	{ "lewlsz",   cmd_lewlsz,  "Read size of LE White List"           },
-	{ "lewlclr",  cmd_lewlclr, "Clear LE White List"                  },
+	{ "lealall",  cmd_lealall, "Add device to LE Accept List"         },
+	{ "lealrm",   cmd_lealrm,  "Remove device from LE Accept List"    },
+	{ "lealsz",   cmd_lealsz,  "Read size of LE Accept List"          },
+	{ "lealclr",  cmd_lealclr, "Clear LE Accept List"                 },
 	{ "lerladd",  cmd_lerladd, "Add device to LE Resolving List"      },
 	{ "lerlrm",   cmd_lerlrm,  "Remove device from LE Resolving List" },
 	{ "lerlclr",  cmd_lerlclr, "Clear LE Resolving List"              },
diff --git a/tools/hcitool.rst b/tools/hcitool.rst
index 80f8c6c22f..36cf4fd66b 100644
--- a/tools/hcitool.rst
+++ b/tools/hcitool.rst
@@ -157,23 +157,23 @@ clock [*bdaddr*] [*clock*]
     The *clock* can be **0** for the local clock or **1** for the piconet
     clock (which is default).
 
-lescan [--*privacy*] [--*passive*] [--*whitelist*] [--*discovery*\=g|l] [--*duplicates*]
+lescan [--*privacy*] [--*passive*] [--*acceptlist*] [--*discovery*\=g|l] [--*duplicates*]
     Start LE scan
 
 leinfo [--*static*] [--*random*] <*bdaddr*>
     Get LE remote information
 
-lewladd [--*random*] <*bdaddr*>
-    Add device to LE White List
+lealall [--*random*] <*bdaddr*>
+    Add device to LE Accept List
 
-lewlrm <*bdaddr*>
-    Remove device from LE White List
+lealrm <*bdaddr*>
+    Remove device from LE Accept List
 
-lewlsz
-    Read size of LE White List
+lealsz
+    Read size of LE Accept List
 
-lewlclr
-    Clear LE White List
+lealclr
+    Clear LE Accept List
 
 lerladd [--*local_irk*] [--*peer_irk*] [--*random*] <*bdaddr*>
     Add device to LE Resolving List
@@ -193,7 +193,7 @@ lerlon
 lerloff
     Disable LE Address Resolution
 
-lecc [--*static*] [--*random*] <*bdaddr*> | [--*whitelist*]
+lecc [--*static*] [--*random*] <*bdaddr*> | [--*acceptlist*]
     Create a LE Connection
 
 ledc <*handle*> [*reason*]
-- 
2.33.0.rc1.237.g0d66db33f3-goog

