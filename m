Return-Path: <SRS0=mLwb=T5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFCFC04E84
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 May 2019 01:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3786D20B1F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 May 2019 01:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbfE2Bwy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 May 2019 21:52:54 -0400
Received: from mga04.intel.com ([192.55.52.120]:44549 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfE2Bwy (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 May 2019 21:52:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 18:52:54 -0700
X-ExtLoop1: 1
Received: from ingas-nuc1.sea.intel.com ([10.255.231.189])
  by orsmga007.jf.intel.com with ESMTP; 28 May 2019 18:52:54 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/2] mesh: Do not daemonize, run in foreground or as service
Date:   Tue, 28 May 2019 18:52:51 -0700
Message-Id: <20190529015251.15805-3-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529015251.15805-1-inga.stotland@intel.com>
References: <20190529015251.15805-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This removes call to daemon(). "--node-detach" option is retained
to set umask().

Also, adds description for dbus-debug option.
---
 mesh/main.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/mesh/main.c b/mesh/main.c
index a621300e6..1c7123cc1 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2017-2018  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2017-2019  Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
@@ -41,6 +41,7 @@ static const struct option main_options[] = {
 	{ "config",	optional_argument,	NULL, 'c' },
 	{ "nodetach",	no_argument,		NULL, 'n' },
 	{ "debug",	no_argument,		NULL, 'd' },
+	{ "dbus-debug",	no_argument,		NULL, 'b' },
 	{ "help",	no_argument,		NULL, 'h' },
 	{ }
 };
@@ -55,6 +56,7 @@ static void usage(void)
 	       "\t--config          Configuration directory\n"
 	       "\t--nodetach        Run in foreground\n"
 	       "\t--debug           Enable debug output\n"
+	       "\t--dbus-debug      Enable D-Bus debugging\n"
 	       "\t--help            Show %s information\n", __func__);
 }
 
@@ -170,7 +172,8 @@ int main(int argc, char *argv[])
 		goto done;
 	}
 
-	umask(0077);
+	if (!detached)
+		umask(0077);
 
 	dbus = l_dbus_new_default(L_DBUS_SYSTEM_BUS);
 	if (!dbus) {
@@ -190,14 +193,6 @@ int main(int argc, char *argv[])
 		goto done;
 	}
 
-	if (detached) {
-		if (daemon(0, 0)) {
-			perror("Failed to start meshd daemon");
-			status = EXIT_FAILURE;
-			goto done;
-		}
-	}
-
 	status = l_main_run_with_signal(signal_handler, NULL);
 
 done:
-- 
2.21.0

