Return-Path: <SRS0=Orb+=UD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16E4C282CE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Jun 2019 06:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C6D24A9A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Jun 2019 06:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfFDGHx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Jun 2019 02:07:53 -0400
Received: from mga12.intel.com ([192.55.52.136]:8052 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726660AbfFDGHx (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Jun 2019 02:07:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 23:07:53 -0700
X-ExtLoop1: 1
Received: from ligangti-mobl3.ccr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.254.84.181])
  by fmsmga008.fm.intel.com with ESMTP; 03 Jun 2019 23:07:52 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, marcel@holtmann.org, johan.hedberg@gmail.com,
        luiz.dentz@gmail.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/2 v3] mesh: Do not daemonize, run in foreground or as service
Date:   Mon,  3 Jun 2019 23:07:48 -0700
Message-Id: <20190604060748.3533-3-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190604060748.3533-1-inga.stotland@intel.com>
References: <20190604060748.3533-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This removes call to daemon(). "--nodetach" option is retained
to set umask().

Also, adds description for dbus-debug option.
---
 mesh/main.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/mesh/main.c b/mesh/main.c
index a621300e6..3cecd8fbf 100644
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
@@ -49,12 +50,13 @@ static void usage(void)
 {
 	l_info("");
 	l_info("Usage:\n"
-	       "\tmeshd [options]\n");
+	       "\tbluetooth-meshd [options]\n");
 	l_info("Options:\n"
 	       "\t--index <hcinum>  Use specified controller\n"
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

