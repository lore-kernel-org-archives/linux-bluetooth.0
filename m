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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B385C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 08:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D713B611AF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 08:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhIOIec (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Sep 2021 04:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbhIOIea (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Sep 2021 04:34:30 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13D1C061575
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 01:33:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s204-20020a252cd5000000b005a16e62ee63so2641655ybs.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 01:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OzbxN6DLrJLIunFGsm0QpyJ1Qd8kA0Kg39R99IgfHgw=;
        b=NMufUndKG7dwkgJZr/EzXEW9oKrVKHjaaJVbKGr+wNg/HANrgcbTij70291nWTlmJt
         HPewVBMLtVYfNGkF1tVMk2te3JtPnO1+XTIffDGIa/ngkbTDs+SnrSdLVylCpVvrX1ne
         PLqBHxM8cVDBVeSCFJEwxkREgaY7oG/y6/Xhb6TX7ES2UIGGPRV7Ul4QjfCqX2h5rBAe
         oCM0R3rqlWx/wBIcWf+DeKXd0cQP4aOnaBUXwcGEO55fMhzhoQ3WPOu1ZF++IBpdvwEx
         xNhiT7RtjQnPok5Ciqx8HatlE2BwWr6eH2/4XsGAEXnttqbBoRP0BAAGXSn+7pP6bBG5
         r9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OzbxN6DLrJLIunFGsm0QpyJ1Qd8kA0Kg39R99IgfHgw=;
        b=IA6Y1S4+O/V6FTmKCLGagnMeLav3w8RNMZoVQ3F3oC4gTLMKU0uB/4r2yy2Bjm8xI3
         OiH7UCmAjzCa+b4MeetBjqUIIIdROnkIo8NKVN8ZmQltzHuppRa9bLzRQT3SJBh2rMOQ
         siBFr/SgFv2pnvkXyUekn8QaNfR/VKMQ12HytrCt9n7JGmcWXb4hD3HdgrBrCfkuWArs
         ltzZ+BxcKpDSP23QnjfEc8Itiz5U3dUdR9mqrafF3xyj8lVeB9ftSEoO0fsRLdXvgKwa
         OtN2ciTwDTYKCgUe4QHtAEYH5HE/O8QiK4Cxjhed1knfAzhFf/Jc0lvPI3tr3ECmcIJC
         PRnQ==
X-Gm-Message-State: AOAM532ar3u1buKHCDFeGLI3Uu0rMydvy+aU7TlQQ1/5hvuXeY3+IzzQ
        KciGXNvwUxiMdjX/xOPjK+WEBjX0A07YPqJz6wgB+DjRNUv0SL5+/NVp+PzLgZx+mbVHkJn6uaR
        lA5wG+JApA+JtV85RH6JnLlL+gDCvTWEOcSFlUNU3WjLdmBkzLsCC1eYq0FmCZgABk/0dSLmd26
        rH
X-Google-Smtp-Source: ABdhPJwOOR5holT5dq8X7EkI81O+53gO1LELpVu2ZrtIZuyyr3UTFE+Clrr4tsJcKjD6NIn0QlHOLZqz0YUS
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:3c6b:8053:7e45:276b])
 (user=apusaka job=sendgmr) by 2002:a25:7ec4:: with SMTP id
 z187mr4670815ybc.35.1631694789104; Wed, 15 Sep 2021 01:33:09 -0700 (PDT)
Date:   Wed, 15 Sep 2021 16:32:01 +0800
In-Reply-To: <20210915083207.243957-1-apusaka@google.com>
Message-Id: <20210915162843.Bluez.v5.6.I54e53f4730bb370257130361d5f801e23fb4fb76@changeid>
Mime-Version: 1.0
References: <20210915083207.243957-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [Bluez PATCH v5 06/13] tools: Deprecate some input parameters to
 align with inclusive language
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

Some input parameter names are not appropriate and needs to be
updated. However, doing so might cause friction with the current
workflow and documents.

This patch deprecates the inappropriate names and replaces them with
the more appropriate substitutes, while still keeping the old terms
usable to not break the workflow of users.
---

(no changes since v1)

 tools/btiotest.c  |  4 +-
 tools/hcitool.c   | 98 ++++++++++++++++++++++++++---------------------
 tools/hcitool.rst | 30 +++++++--------
 tools/rfcomm.c    | 10 +++--
 4 files changed, 78 insertions(+), 64 deletions(-)

diff --git a/tools/btiotest.c b/tools/btiotest.c
index 4bbe088bc3..70d74ffbe4 100644
--- a/tools/btiotest.c
+++ b/tools/btiotest.c
@@ -576,8 +576,10 @@ static GOptionEntry options[] = {
 				"Disconnect connection after N seconds" },
 	{ "accept", 'a', 0, G_OPTION_ARG_INT, &opt_accept,
 				"Accept connection after N seconds" },
+	{ "central", 'C', 0, G_OPTION_ARG_NONE, &opt_central,
+				"Central role switch (incoming connections)" },
 	{ "master", 'm', 0, G_OPTION_ARG_NONE, &opt_central,
-				"Master role switch (incoming connections)" },
+				"Deprecated. Use central instead." },
 	{ "priority", 'P', 0, G_OPTION_ARG_INT, &opt_priority,
 				"Transmission priority: Setting a priority "
 				"outside the range 0 to 6 requires the"
diff --git a/tools/hcitool.c b/tools/hcitool.c
index ab8246e13c..b6f4a4e665 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -1210,10 +1210,10 @@ static struct option cc_options[] = {
 
 static const char *cc_help =
 	"Usage:\n"
-	"\tcc [--role=m|s] [--ptype=pkt_types] <bdaddr>\n"
+	"\tcc [--role=c|p] [--ptype=pkt_types] <bdaddr>\n"
 	"Example:\n"
 	"\tcc --ptype=dm1,dh3,dh5 01:02:03:04:05:06\n"
-	"\tcc --role=m 01:02:03:04:05:06\n";
+	"\tcc --role=c 01:02:03:04:05:06\n";
 
 static void cmd_cc(int dev_id, int argc, char **argv)
 {
@@ -1233,7 +1233,7 @@ static void cmd_cc(int dev_id, int argc, char **argv)
 			break;
 
 		case 'r':
-			role = optarg[0] == 'm' ? 0 : 1;
+			role = optarg[0] == 'm' || optarg[0] == 'c' ? 0 : 1;
 			break;
 
 		default:
@@ -1360,10 +1360,12 @@ static void cmd_sr(int dev_id, int argc, char **argv)
 
 	str2ba(argv[0], &bdaddr);
 	switch (argv[1][0]) {
-	case 'm':
+	case 'm': /* Deprecated. Kept for compatibility. */
+	case 'c':
 		role = 0;
 		break;
-	case 's':
+	case 's': /* Deprecated. Kept for compatibility. */
+	case 'p':
 		role = 1;
 		break;
 	default:
@@ -2474,7 +2476,8 @@ static struct option lescan_options[] = {
 	{ "static",	0, 0, 's' },
 	{ "privacy",	0, 0, 'p' },
 	{ "passive",	0, 0, 'P' },
-	{ "whitelist",	0, 0, 'w' },
+	{ "whitelist",	0, 0, 'w' }, /* Deprecated. Kept for compatibility. */
+	{ "acceptlist",	0, 0, 'a' },
 	{ "discovery",	1, 0, 'd' },
 	{ "duplicates",	0, 0, 'D' },
 	{ 0, 0, 0, 0 }
@@ -2484,7 +2487,7 @@ static const char *lescan_help =
 	"Usage:\n"
 	"\tlescan [--privacy] enable privacy\n"
 	"\tlescan [--passive] set scan type passive (default active)\n"
-	"\tlescan [--whitelist] scan for address in the whitelist only\n"
+	"\tlescan [--acceptlist] scan for address in the accept list only\n"
 	"\tlescan [--discovery=g|l] enable general or limited discovery"
 		"procedure\n"
 	"\tlescan [--duplicates] don't filter duplicates\n";
@@ -2511,7 +2514,8 @@ static void cmd_lescan(int dev_id, int argc, char **argv)
 		case 'P':
 			scan_type = 0x00; /* Passive */
 			break;
-		case 'w':
+		case 'w': /* Deprecated. Kept for compatibility. */
+		case 'a':
 			filter_policy = 0x01; /* Accept list */
 			break;
 		case 'd':
@@ -2678,14 +2682,15 @@ static struct option lecc_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "static",	0, 0, 's' },
 	{ "random",	0, 0, 'r' },
-	{ "whitelist",	0, 0, 'w' },
+	{ "whitelist",	0, 0, 'w' }, /* Deprecated. Kept for compatibility. */
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
@@ -2707,7 +2712,8 @@ static void cmd_lecc(int dev_id, int argc, char **argv)
 		case 'r':
 			peer_bdaddr_type = LE_RANDOM_ADDRESS;
 			break;
-		case 'w':
+		case 'w': /* Deprecated. Kept for compatibility. */
+		case 'a':
 			initiator_filter = 0x01; /* Use accept list */
 			break;
 		default:
@@ -2753,34 +2759,34 @@ static void cmd_lecc(int dev_id, int argc, char **argv)
 	hci_close_dev(dd);
 }
 
-static struct option lewladd_options[] = {
+static struct option lealadd_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "random",	0, 0, 'r' },
 	{ 0, 0, 0, 0 }
 };
 
-static const char *lewladd_help =
+static const char *lealadd_help =
 	"Usage:\n"
-	"\tlewladd [--random] <bdaddr>\n";
+	"\tlealadd [--random] <bdaddr>\n";
 
-static void cmd_lewladd(int dev_id, int argc, char **argv)
+static void cmd_lealadd(int dev_id, int argc, char **argv)
 {
 	int err, opt, dd;
 	bdaddr_t bdaddr;
 	uint8_t bdaddr_type = LE_PUBLIC_ADDRESS;
 
-	for_each_opt(opt, lewladd_options, NULL) {
+	for_each_opt(opt, lealadd_options, NULL) {
 		switch (opt) {
 		case 'r':
 			bdaddr_type = LE_RANDOM_ADDRESS;
 			break;
 		default:
-			printf("%s", lewladd_help);
+			printf("%s", lealadd_help);
 			return;
 		}
 	}
 
-	helper_arg(1, 1, &argc, &argv, lewladd_help);
+	helper_arg(1, 1, &argc, &argv, lealadd_help);
 
 	if (dev_id < 0)
 		dev_id = hci_get_route(NULL);
@@ -2804,29 +2810,29 @@ static void cmd_lewladd(int dev_id, int argc, char **argv)
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
@@ -2850,29 +2856,29 @@ static void cmd_lewlrm(int dev_id, int argc, char **argv)
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
@@ -2896,28 +2902,28 @@ static void cmd_lewlsz(int dev_id, int argc, char **argv)
 	printf("Accept list size: %d\n", size);
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
@@ -3379,7 +3385,7 @@ static struct {
 	{ "con",      cmd_con,     "Display active connections"           },
 	{ "cc",       cmd_cc,      "Create connection to remote device"   },
 	{ "dc",       cmd_dc,      "Disconnect from remote device"        },
-	{ "sr",       cmd_sr,      "Switch master/slave role"             },
+	{ "sr",       cmd_sr,      "Switch central/peripheral role"       },
 	{ "cpt",      cmd_cpt,     "Change connection packet type"        },
 	{ "rssi",     cmd_rssi,    "Display connection RSSI"              },
 	{ "lq",       cmd_lq,      "Display link quality"                 },
@@ -3394,10 +3400,14 @@ static struct {
 	{ "clock",    cmd_clock,   "Read local or remote clock"           },
 	{ "lescan",   cmd_lescan,  "Start LE scan"                        },
 	{ "leinfo",   cmd_leinfo,  "Get LE remote information"            },
-	{ "lewladd",  cmd_lewladd, "Add device to LE White List"          },
-	{ "lewlrm",   cmd_lewlrm,  "Remove device from LE White List"     },
-	{ "lewlsz",   cmd_lewlsz,  "Read size of LE White List"           },
-	{ "lewlclr",  cmd_lewlclr, "Clear LE White List"                  },
+	{ "lealadd",  cmd_lealadd, "Add device to LE White List"          },
+	{ "lealrm",   cmd_lealrm,  "Remove device from LE White List"     },
+	{ "lealsz",   cmd_lealsz,  "Read size of LE White List"           },
+	{ "lealclr",  cmd_lealclr, "Clear LE White List"                  },
+	{ "lewladd",  cmd_lealadd, "Deprecated. Use lealadd instead."     },
+	{ "lewlrm",   cmd_lealrm,  "Deprecated. Use lealrm instead."      },
+	{ "lewlsz",   cmd_lealsz,  "Deprecated. Use lealsz instead."      },
+	{ "lewlclr",  cmd_lealclr, "Deprecated. Use lealclr instead."     },
 	{ "lerladd",  cmd_lerladd, "Add device to LE Resolving List"      },
 	{ "lerlrm",   cmd_lerlrm,  "Remove device from LE Resolving List" },
 	{ "lerlclr",  cmd_lerlclr, "Clear LE Resolving List"              },
diff --git a/tools/hcitool.rst b/tools/hcitool.rst
index f59d694078..88b1263c54 100644
--- a/tools/hcitool.rst
+++ b/tools/hcitool.rst
@@ -74,7 +74,7 @@ cmd <*ogf*> <*ocf*> [*parameters*]
 con
     Display active baseband connections
 
-cc [--*role*\=m|s] [--*pkt-type*\=<*ptype*>] <*bdaddr*>
+cc [--*role*\=c|p] [--*pkt-type*\=<*ptype*>] <*bdaddr*>
     Create baseband connection to remote device with Bluetooth address *bdaddr*.
 
     Option **--pkt-type** specifies a list  of  allowed packet types.
@@ -82,9 +82,9 @@ cc [--*role*\=m|s] [--*pkt-type*\=<*ptype*>] <*bdaddr*>
     packet types are **DM1**, **DM3**, **DM5**, **DH1**, **DH3**, **DH5**,
     **HV1**, **HV2**, **HV3**. Default is to allow all packet types.
 
-    Option  **--role** can have value **m** (do not allow role switch, stay
-    master) or **s** (allow role switch, become slave if the peer asks to become
-    master). Default is **m**.
+    Option  **--role** can have value **c** (do not allow role switch, stay
+    central) or **p** (allow role switch, become peripheral if the peer asks to
+    become central). Default is **c**.
 
 dc <*bdaddr*> [*reason*]
     Delete baseband connection from remote device with Bluetooth address
@@ -96,7 +96,7 @@ dc <*bdaddr*> [*reason*]
 
 sr <*bdaddr*> <*role*>
     Switch role for the baseband connection from the remote device to
-    **master** or **slave**.
+    **central** or **peripheral**.
 
 cpt <*bdaddr*> <*ptypes*>
     Change packet types for baseband connection to device with Bluetooth
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
+lealadd [--*random*] <*bdaddr*>
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
diff --git a/tools/rfcomm.c b/tools/rfcomm.c
index d7d9713271..cd520aa44f 100644
--- a/tools/rfcomm.c
+++ b/tools/rfcomm.c
@@ -646,7 +646,7 @@ static void usage(void)
 		"\t-A, --auth                     Enable authentication\n"
 		"\t-E, --encrypt                  Enable encryption\n"
 		"\t-S, --secure                   Secure connection\n"
-		"\t-M, --master                   Become the master of a piconet\n"
+		"\t-C, --central                  Become the central of a piconet\n"
 		"\t-L, --linger [seconds]         Set linger timeout\n"
 		"\t-a                             Show all devices (default)\n"
 		"\n");
@@ -668,7 +668,8 @@ static struct option main_options[] = {
 	{ "auth",	0, 0, 'A' },
 	{ "encrypt",	0, 0, 'E' },
 	{ "secure",	0, 0, 'S' },
-	{ "master",	0, 0, 'M' },
+	{ "master",	0, 0, 'M' }, /* Deprecated. Kept for compatibility. */
+	{ "central",	0, 0, 'C' },
 	{ "linger",	1, 0, 'L' },
 	{ 0, 0, 0, 0 }
 };
@@ -680,7 +681,7 @@ int main(int argc, char *argv[])
 
 	bacpy(&bdaddr, BDADDR_ANY);
 
-	while ((opt = getopt_long(argc, argv, "+i:rahAESML:", main_options,
+	while ((opt = getopt_long(argc, argv, "+i:rahAESMCL:", main_options,
 								NULL)) != -1) {
 		switch(opt) {
 		case 'i':
@@ -714,7 +715,8 @@ int main(int argc, char *argv[])
 			secure = 1;
 			break;
 
-		case 'M':
+		case 'M': /* Deprecated. Kept for compatibility. */
+		case 'C':
 			central = 1;
 			break;
 
-- 
2.33.0.464.g1972c5931b-goog

