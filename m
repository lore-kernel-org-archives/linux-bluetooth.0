Return-Path: <SRS0=H/dM=OB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502A0C43441
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Nov 2018 19:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD74120684
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Nov 2018 19:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD74120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389479AbeKWGW0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:22:26 -0500
Received: from mga14.intel.com ([192.55.52.115]:34267 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731412AbeKWGWZ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Nov 2018 01:22:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2018 11:41:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,266,1539673200"; 
   d="scan'208";a="106894543"
Received: from bgix-dell-lap.sea.intel.com ([10.251.136.188])
  by fmsmga002.fm.intel.com with ESMTP; 22 Nov 2018 11:41:38 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     johan.hedberg@gmail.com, inga.stotland@intel.com,
        marcel@holtmann.org, Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ v2] mesh: Up-rev ELL dependancies to >= 0.14
Date:   Thu, 22 Nov 2018 11:41:19 -0800
Message-Id: <20181122194119.24617-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 configure.ac |  4 ++--
 mesh/main.c  | 31 +++++++++----------------------
 2 files changed, 11 insertions(+), 24 deletions(-)

diff --git a/configure.ac b/configure.ac
index ec810fcf4..ee4199f4d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -249,8 +249,8 @@ AC_ARG_ENABLE(btpclient, AC_HELP_STRING([--enable-btpclient],
 AM_CONDITIONAL(BTPCLIENT, test "${enable_btpclient}" = "yes")
 
 if (test "${enable_btpclient}" = "yes" || test "${enable_mesh}" = "yes"); then
-	PKG_CHECK_MODULES(ELL, ell >= 0.3, enable_ell=yes,
-			  AC_MSG_ERROR(ell library >= 0.3 is required))
+	PKG_CHECK_MODULES(ELL, ell >= 0.14, enable_ell=yes,
+			  AC_MSG_ERROR(ell library >= 0.14 is required))
 	AC_SUBST(ELL_CFLAGS)
 	AC_SUBST(ELL_LIBS)
 fi
diff --git a/mesh/main.c b/mesh/main.c
index 289b0582b..97f506a75 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -26,6 +26,7 @@
 #include <stdio.h>
 #include <unistd.h>
 #include <ctype.h>
+#include <signal.h>
 
 #include <sys/stat.h>
 #include <ell/ell.h>
@@ -59,29 +60,22 @@ static void usage(void)
 	       "\t--help            Show %s information\n", __func__);
 }
 
-static void signal_handler(struct l_signal *signal, uint32_t signo,
-							void *user_data)
+static void signal_handler(uint32_t signo, void *user_data)
 {
 	static bool terminated;
 
-	switch (signo) {
-	case SIGINT:
-	case SIGTERM:
-		if (terminated)
-			return;
-		l_info("Terminating");
-		l_main_quit();
-		terminated = true;
-		break;
-	}
+	if (terminated)
+		return;
+
+	l_info("Terminating");
+	l_main_quit();
+	terminated = true;
 }
 
 int main(int argc, char *argv[])
 {
 	int status;
 	bool detached = true;
-	struct l_signal *signal;
-	sigset_t mask;
 	struct bt_mesh *mesh = NULL;
 	const char *config_file = NULL;
 	int index = MGMT_INDEX_NONE;
@@ -140,11 +134,6 @@ int main(int argc, char *argv[])
 		goto done;
 	}
 
-	sigemptyset(&mask);
-	sigaddset(&mask, SIGINT);
-	sigaddset(&mask, SIGTERM);
-	signal = l_signal_create(&mask, signal_handler, NULL, NULL);
-
 	umask(0077);
 
 	if (detached) {
@@ -155,9 +144,7 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	status = l_main_run();
-
-	l_signal_remove(signal);
+	status = l_main_run_with_signal(signal_handler, NULL);
 
 done:
 	mesh_unref(mesh);
-- 
2.14.5

