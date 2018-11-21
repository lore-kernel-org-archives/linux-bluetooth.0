Return-Path: <SRS0=IL+U=OA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CE0C43441
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Nov 2018 20:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5B02145D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Nov 2018 20:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F5B02145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732530AbeKVHWr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:22:47 -0500
Received: from mga18.intel.com ([134.134.136.126]:2776 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730074AbeKVHWr (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Nov 2018 02:22:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2018 12:46:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,262,1539673200"; 
   d="scan'208";a="251599882"
Received: from bgix-dell-lap.sea.intel.com ([10.251.136.188])
  by orsmga004.jf.intel.com with ESMTP; 21 Nov 2018 12:46:46 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     johan.hedberg@gmail.com, inga.stotland@intel.com,
        Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ] mesh: Up-rev ELL dependancies to >= 0.14
Date:   Wed, 21 Nov 2018 12:46:41 -0800
Message-Id: <20181121204641.10841-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 configure.ac |  4 ++--
 mesh/dbus.c  |  4 ++--
 mesh/main.c  | 27 ++++++++++-----------------
 3 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/configure.ac b/configure.ac
index cbc854d62..d22f9d539 100644
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
diff --git a/mesh/dbus.c b/mesh/dbus.c
index a94ba067d..0df664f2b 100644
--- a/mesh/dbus.c
+++ b/mesh/dbus.c
@@ -76,11 +76,11 @@ struct l_dbus_message *dbus_error(struct l_dbus_message *msg, int err,
 	if (description)
 		return l_dbus_message_new_error(msg,
 				error_table[err].dbus_err,
-				description);
+				"%s", description);
 	else
 		return l_dbus_message_new_error(msg,
 				error_table[err].dbus_err,
-				error_table[err].default_desc);
+				"%s", error_table[err].default_desc);
 }
 
 struct l_dbus *dbus_get_bus(void)
diff --git a/mesh/main.c b/mesh/main.c
index 0722f3af8..96a013510 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -26,6 +26,7 @@
 #include <stdio.h>
 #include <unistd.h>
 #include <ctype.h>
+#include <signal.h>
 
 #include <sys/stat.h>
 #include <ell/ell.h>
@@ -96,21 +97,16 @@ static void disconnect_callback(void *user_data)
 	l_main_quit();
 }
 
-static void signal_handler(struct l_signal *signal, uint32_t signo,
-							void *user_data)
+static void signal_handler(void *user_data)
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
@@ -120,7 +116,6 @@ int main(int argc, char *argv[])
 	bool dbus_debug = false;
 	struct l_dbus *dbus = NULL;
 	struct l_signal *signal = NULL;
-	sigset_t mask;
 	const char *config_dir = NULL;
 	int index = MGMT_INDEX_NONE;
 
@@ -181,10 +176,8 @@ int main(int argc, char *argv[])
 		goto done;
 	}
 
-	sigemptyset(&mask);
-	sigaddset(&mask, SIGINT);
-	sigaddset(&mask, SIGTERM);
-	signal = l_signal_create(&mask, signal_handler, NULL, NULL);
+	signal = l_signal_create(SIGINT, signal_handler, NULL, NULL);
+	signal = l_signal_create(SIGTERM, signal_handler, NULL, NULL);
 
 	umask(0077);
 
-- 
2.14.5

