Return-Path: <SRS0=fWrd=CM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C117C433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Sep 2020 20:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E3BC20709
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Sep 2020 20:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgICUBD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:01:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:2699 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbgICUBB (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Sep 2020 16:01:01 -0400
IronPort-SDR: uMFoPrMrNI3sWUUcul3GdPAVeqHc6fmp27MaccpcZmk4tGIIa5t9tHYBh3sQUKsM71r/l9k5M8
 mKEKqI6bWqUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="219204048"
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="219204048"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 13:00:59 -0700
IronPort-SDR: kpSrKLv33wOUejiIr55KbYdmP5jebuUYB4l2y2RY3tQhJSEELUK+VGalXOa3JaReVEYFDAAqpC
 BmxpOxs0u8Ig==
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="298164616"
Received: from akothalk-mobl.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.254.126.243])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 13:00:59 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Align option names with functionality
Date:   Thu,  3 Sep 2020 13:00:52 -0700
Message-Id: <20200903200052.11005-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Change option "config" ('c') to "storage" ('s) to specify
a custom storage directory for node configuration.

Change option 'f' (long name was missing) to "config" ('c')
to specify a custom mesh configuration file to override the
default mesh-main.conf
---
 mesh/main.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/mesh/main.c b/mesh/main.c
index 1a4e6ba76..5a3cbf290 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -39,14 +39,15 @@
 #include "mesh/mesh-io.h"
 #include "mesh/util.h"
 
-static const char *config_dir;
+static const char *storage_dir;
 static const char *mesh_conf_fname;
 static enum mesh_io_type io_type;
 static void *io_opts;
 
 static const struct option main_options[] = {
 	{ "io",		required_argument,	NULL, 'i' },
-	{ "config",	optional_argument,	NULL, 'c' },
+	{ "storage",	required_argument,	NULL, 's' },
+	{ "config",	required_argument,	NULL, 'c' },
 	{ "nodetach",	no_argument,		NULL, 'n' },
 	{ "debug",	no_argument,		NULL, 'd' },
 	{ "dbus-debug",	no_argument,		NULL, 'b' },
@@ -108,7 +109,7 @@ static void request_name_callback(struct l_dbus *dbus, bool success,
 		return;
 	}
 
-	if (!mesh_init(config_dir, mesh_conf_fname, io_type, io_opts,
+	if (!mesh_init(storage_dir, mesh_conf_fname, io_type, io_opts,
 					mesh_ready_callback, dbus)) {
 		l_error("Failed to initialize mesh");
 		l_main_quit();
@@ -195,7 +196,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "i:c:f:ndbh", main_options, NULL);
+		opt = getopt_long(argc, argv, "i:s:c:ndbh", main_options, NULL);
 		if (opt < 0)
 			break;
 
@@ -213,10 +214,10 @@ int main(int argc, char *argv[])
 		case 'd':
 			enable_debug();
 			break;
-		case 'c':
-			config_dir = optarg;
+		case 's':
+			storage_dir = optarg;
 			break;
-		case 'f':
+		case 'c':
 			mesh_conf_fname = optarg;
 			break;
 		case 'b':
-- 
2.26.2

