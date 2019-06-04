Return-Path: <SRS0=Orb+=UD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49ECC28CC6
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Jun 2019 20:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E59520874
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Jun 2019 20:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfFDU30 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Jun 2019 16:29:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:34192 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbfFDU3Z (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Jun 2019 16:29:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 13:29:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,550,1549958400"; 
   d="scan'208";a="181680799"
Received: from bgix-dell-lap.sea.intel.com ([10.254.84.39])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jun 2019 13:29:25 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com,
        ludwig.nussel@suse.de, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com
Subject: [PATCH BlueZ v4 3/3] mesh: Do not daemonize, run in foreground or as service
Date:   Tue,  4 Jun 2019 13:28:52 -0700
Message-Id: <20190604202852.12656-4-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190604202852.12656-1-brian.gix@intel.com>
References: <20190604202852.12656-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Inga Stotland <inga.stotland@intel.com>

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
2.14.5

