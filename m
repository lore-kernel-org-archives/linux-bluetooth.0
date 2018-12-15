Return-Path: <SRS0=1Za/=OY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE58C43387
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Dec 2018 00:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFEC1208C3
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Dec 2018 00:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbeLOA0o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Dec 2018 19:26:44 -0500
Received: from mga17.intel.com ([192.55.52.151]:22249 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730039AbeLOA0i (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Dec 2018 19:26:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Dec 2018 16:26:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,355,1539673200"; 
   d="scan'208";a="109640365"
Received: from bgix-dell-lap.sea.intel.com ([10.251.138.67])
  by fmsmga008.fm.intel.com with ESMTP; 14 Dec 2018 16:26:35 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     johan.hedberg@gmail.com, inga.stotland@intel.com,
        marcel@holtmann.org, brian.gix@intel.com
Subject: [PATCH BlueZ v3 24/30] mesh: Update for DBus API and multi-node support
Date:   Fri, 14 Dec 2018 16:26:18 -0800
Message-Id: <20181215002624.9313-25-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181215002624.9313-1-brian.gix@intel.com>
References: <20181215002624.9313-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Inga Stotland <inga.stotland@intel.com>

---
 mesh/main.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 66 insertions(+), 7 deletions(-)

diff --git a/mesh/main.c b/mesh/main.c
index 173f57a8f..95a66cc9d 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -33,11 +33,14 @@
 #include <sys/stat.h>
 #include <ell/ell.h>
 
+#include <dbus/dbus.h>
+
 #include "lib/bluetooth.h"
 #include "lib/mgmt.h"
 
 #include "mesh/mesh.h"
 #include "mesh/net.h"
+#include "mesh/dbus.h"
 #include "mesh/storage.h"
 
 static const struct option main_options[] = {
@@ -56,12 +59,46 @@ static void usage(void)
 	       "\tmeshd [options]\n");
 	l_info("Options:\n"
 	       "\t--index <hcinum>  Use specified controller\n"
-	       "\t--config          Configuration file\n"
+	       "\t--config          Configuration directory\n"
 	       "\t--nodetach        Run in foreground\n"
 	       "\t--debug           Enable debug output\n"
 	       "\t--help            Show %s information\n", __func__);
 }
 
+static void do_debug(const char *str, void *user_data)
+{
+	const char *prefix = user_data;
+
+	l_info("%s%s", prefix, str);
+}
+
+static void request_name_callback(struct l_dbus *dbus, bool success,
+					bool queued, void *user_data)
+{
+	l_info("Request name %s",
+		success ? "success": "failed");
+
+	if (success)
+		dbus_init(dbus);
+	else
+		l_main_quit();
+}
+
+static void ready_callback(void *user_data)
+{
+	struct l_dbus *dbus = user_data;
+
+	l_info("D-Bus ready");
+	l_dbus_name_acquire(dbus, BLUEZ_MESH_NAME, false, false, false,
+						request_name_callback, NULL);
+
+}
+
+static void disconnect_callback(void *user_data)
+{
+	l_main_quit();
+}
+
 static void signal_handler(uint32_t signo, void *user_data)
 {
 	static bool terminated;
@@ -78,8 +115,9 @@ int main(int argc, char *argv[])
 {
 	int status;
 	bool detached = true;
-	struct bt_mesh *mesh = NULL;
-	const char *config_file = NULL;
+	bool dbus_debug = false;
+	struct l_dbus *dbus = NULL;
+	const char *config_dir = NULL;
 	int index = MGMT_INDEX_NONE;
 
 	if (!l_main_init())
@@ -91,7 +129,7 @@ int main(int argc, char *argv[])
 		int opt;
 		const char *str;
 
-		opt = getopt_long(argc, argv, "i:c:ndh", main_options, NULL);
+		opt = getopt_long(argc, argv, "i:c:ndbh", main_options, NULL);
 		if (opt < 0)
 			break;
 
@@ -117,7 +155,10 @@ int main(int argc, char *argv[])
 			l_debug_enable("*");
 			break;
 		case 'c':
-			config_file = optarg;
+			config_dir = optarg;
+			break;
+		case 'b':
+			dbus_debug = true;
 			break;
 		case 'h':
 			usage();
@@ -130,7 +171,7 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	if (!mesh_new(index, config_file)) {
+	if (!mesh_init(index, config_dir)) {
 		l_error("Failed to initialize mesh");
 		status = EXIT_FAILURE;
 		goto done;
@@ -138,6 +179,24 @@ int main(int argc, char *argv[])
 
 	umask(0077);
 
+	dbus = l_dbus_new_default(L_DBUS_SYSTEM_BUS);
+	if (!dbus) {
+		l_error("unable to connect to D-Bus");
+		status = EXIT_FAILURE;
+		goto done;
+	}
+
+	if (dbus_debug)
+		l_dbus_set_debug(dbus, do_debug, "[DBUS] ", NULL);
+	l_dbus_set_ready_handler(dbus, ready_callback, dbus, NULL);
+	l_dbus_set_disconnect_handler(dbus, disconnect_callback, NULL, NULL);
+
+	if (!l_dbus_object_manager_enable(dbus)) {
+		l_error("Failed to enable Object Manager");
+		status = EXIT_FAILURE;
+		goto done;
+	}
+
 	if (detached) {
 		if (daemon(0, 0)) {
 			perror("Failed to start meshd daemon");
@@ -149,8 +208,8 @@ int main(int argc, char *argv[])
 	status = l_main_run_with_signal(signal_handler, NULL);
 
 done:
-	mesh_unref(mesh);
 	mesh_cleanup();
+	l_dbus_destroy(dbus);
 	l_main_exit();
 
 	return status;
-- 
2.14.5

