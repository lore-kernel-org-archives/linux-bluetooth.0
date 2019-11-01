Return-Path: <SRS0=Dn6D=YZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1B8CA9ED1
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Nov 2019 18:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7B8217D9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Nov 2019 18:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfKAS5k (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Nov 2019 14:57:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:29987 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727372AbfKAS5k (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Nov 2019 14:57:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 11:57:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,256,1569308400"; 
   d="scan'208";a="211833782"
Received: from ingas-nuc1.sea.intel.com ([10.255.230.110])
  by fmsmga001.fm.intel.com with ESMTP; 01 Nov 2019 11:57:39 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 08/10 v2] tools/mesh-cfgclient: Command line option for config
Date:   Fri,  1 Nov 2019 11:57:27 -0700
Message-Id: <20191101185729.31661-9-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191101185729.31661-1-inga.stotland@intel.com>
References: <20191101185729.31661-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds "-c" option to specify full path to configuration file.
If the path is not provided, the application will attempt to open
in the following order:
1) $XDG_CONFIG_HOME/meshcfg/config_db.json
2) $HOME/meshcfg/config_db.json

if the file does not exist, it will be generated for a newly created
network, i.e., upon successful completion of "create" command.
---
 tools/mesh-cfgclient.c | 75 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 5 deletions(-)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index c503774c4..65a5356a7 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -25,8 +25,12 @@
 #include <assert.h>
 #include <ctype.h>
 #include <dbus/dbus.h>
+#include <errno.h>
 #include <stdio.h>
 #include <time.h>
+
+#include <sys/stat.h>
+
 #include <ell/ell.h>
 
 #include "src/shared/shell.h"
@@ -52,6 +56,8 @@
 #define DEFAULT_START_ADDRESS	0x00aa
 #define DEFAULT_NET_INDEX	0x0000
 
+#define DEFAULT_CFG_FILE	"config_db.json"
+
 struct meshcfg_el {
 	const char *path;
 	uint8_t index;
@@ -106,6 +112,8 @@ static struct l_queue *devices;
 static bool prov_in_progress;
 static const char *caps[2] = {"out-numeric", "in-numeric"};
 
+static bool have_config;
+
 static struct meshcfg_app app = {
 	.path = "/mesh/cfgclient",
 	.agent_path = "/mesh/cfgclient/agent",
@@ -121,23 +129,28 @@ static struct meshcfg_app app = {
 };
 
 static const struct option options[] = {
-	{ "address",	optional_argument, 0, 'a' },
-	{ "net-index",	optional_argument, 0, 'n' },
+	{ "config",	required_argument, 0, 'c' },
+	{ "address",	required_argument, 0, 'a' },
+	{ "net-index",	required_argument, 0, 'n' },
 	{ 0, 0, 0, 0 }
 };
 
 static const char *address_opt;
 static const char *net_idx_opt;
+static const char *config_opt;
 
 static uint16_t prov_address;
 static uint16_t prov_net_idx;
+static const char *cfg_fname;
 
 static const char **optargs[] = {
+	&config_opt,
 	&address_opt,
 	&net_idx_opt,
 };
 
 static const char *help[] = {
+	"Configuration file",
 	"Starting unicast address for remote nodes",
 	"Net index for provisioning subnet"
 };
@@ -145,7 +158,7 @@ static const char *help[] = {
 static const struct bt_shell_opt opt = {
 	.options = options,
 	.optno = sizeof(options) / sizeof(struct option),
-	.optstr = "a:n:",
+	.optstr = "c:a:n:",
 	.optarg = optargs,
 	.help = help,
 };
@@ -1621,18 +1634,65 @@ static void ready_callback(void *user_data)
 		bt_shell_printf("Failed to register the ObjectManager\n");
 }
 
+static bool setup_cfg_storage(void)
+{
+	struct stat st;
+
+	if (!config_opt) {
+		char *home;
+		char *mesh_dir;
+
+		home = getenv("XDG_CONFIG_HOME");
+
+		if (home) {
+			mesh_dir = l_strdup_printf("%s/meshcfg", home);
+		} else {
+			home = getenv("HOME");
+			if (!home) {
+				l_error("\"HOME\" not set\n");
+				return false;
+			}
+
+			mesh_dir = l_strdup_printf("%s/.config/meshcfg", home);
+		}
+
+		if (!mesh_dir)
+			return false;
+
+		cfg_fname = l_strdup_printf("mesh_dir/%s", DEFAULT_CFG_FILE);
+		l_free(mesh_dir);
+
+	} else {
+		cfg_fname = l_strdup_printf("%s", config_opt);
+	}
+
+	if (stat(cfg_fname, &st) == -1) {
+		if (errno == ENOENT) {
+			l_warn("\nWarning: config file \"%s\" not found",
+								cfg_fname);
+			return true;
+		}
+
+		perror("\nFailed to open config file");
+		return false;
+	}
+
+	have_config = true;
+	return true;
+}
+
 int main(int argc, char *argv[])
 {
 	struct l_dbus_client *client;
 	uint32_t val;
 	int status;
 
-	l_log_set_stderr();
-
 	bt_shell_init(argc, argv, &opt);
 	bt_shell_set_menu(&main_menu);
 	bt_shell_set_prompt(PROMPT_OFF);
 
+	l_log_set_stderr();
+
 	if (address_opt && sscanf(address_opt, "%04x", &val) == 1)
 		prov_address = (uint16_t) val;
 	else
@@ -1643,6 +1703,11 @@ int main(int argc, char *argv[])
 	else
 		prov_net_idx = DEFAULT_NET_INDEX;
 
+	if (!setup_cfg_storage()) {
+		bt_shell_cleanup();
+		return EXIT_FAILURE;
+	}
+
 	dbus = l_dbus_new_default(L_DBUS_SYSTEM_BUS);
 
 	l_dbus_set_ready_handler(dbus, ready_callback, NULL, NULL);
-- 
2.21.0

