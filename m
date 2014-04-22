Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 07/11] android/client: Add register_application support to haltest
Date: Tue, 22 Apr 2014 15:06:06 +0300
Message-Id: <1398168371-29685-8-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1398168371-29685-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1398168371-29685-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Input parameters contains many optional strings, so treating
'-' as empty input. It makes input handling simpler.
---
 android/client/if-hl.c | 136 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/android/client/if-hl.c b/android/client/if-hl.c
index 5ea29f8..7c15a76 100644
--- a/android/client/if-hl.c
+++ b/android/client/if-hl.c
@@ -25,6 +25,17 @@
 #include "pollhandler.h"
 #include "../hal-utils.h"
 
+SINTMAP(bthl_mdep_role_t, -1, "(unknown)")
+	DELEMENT(BTHL_MDEP_ROLE_SOURCE),
+	DELEMENT(BTHL_MDEP_ROLE_SINK),
+ENDMAP
+
+SINTMAP(bthl_channel_type_t, -1, "(unknown)")
+	DELEMENT(BTHL_CHANNEL_TYPE_RELIABLE),
+	DELEMENT(BTHL_CHANNEL_TYPE_STREAMING),
+	DELEMENT(BTHL_CHANNEL_TYPE_ANY),
+ENDMAP
+
 const bthl_interface_t *if_hl = NULL;
 
 static bthl_callbacks_t hl_cbacks = {
@@ -42,6 +53,126 @@ static void init_p(int argc, const char **argv)
 	EXEC(if_hl->init, &hl_cbacks);
 }
 
+/* register_application */
+
+static void register_application_p(int argc, const char **argv)
+{
+	bthl_reg_param_t *reg;
+	char *app_name, *provider_name, *srv_name, *srv_descr, *descr;
+	uint16_t len, i, mdep_argc_init, mdep_argc_off;
+	int app_id = -1;
+
+	RETURN_IF_NULL(if_hl);
+
+	if (argc <= 2) {
+		haltest_error("No app name is specified\n");
+		return;
+	}
+
+	if (argc <= 3) {
+		haltest_error("No provider is specified\n");
+		return;
+	}
+
+	if (argc <= 4) {
+		haltest_error("No service name is specified\n");
+		return;
+	}
+
+	if (argc <= 5) {
+		haltest_error("No service description is specified\n");
+		return;
+	}
+
+	if (argc <= 6) {
+		haltest_error("No num of mdeps is specified\n");
+		return;
+	}
+
+
+	if (argc != ((atoi(argv[6]) * 4) + 6)) {
+		haltest_error("mdep cfg argumetns are not proper\n");
+		return;
+	}
+
+	reg = (bthl_reg_param_t *) malloc(sizeof(bthl_reg_param_t));
+
+	len = strlen(argv[2]) + 1;
+	app_name = (char *) malloc(len);
+	strcpy(app_name, argv[2]);
+	app_name[len] = '\0';
+	reg->application_name = app_name;
+
+	if (strcmp("-", argv[3])) {
+		len = strlen(argv[3]) + 1;
+		provider_name = (char *) malloc(len);
+		strcpy(provider_name, argv[3]);
+		provider_name[len] = '\0';
+		reg->provider_name = provider_name;
+	} else {
+		reg->provider_name = NULL;
+	}
+
+	if (strcmp("-", argv[4])) {
+		len = strlen(argv[4]) + 1;
+		srv_name = (char *) malloc(len);
+		strcpy(srv_name, argv[4]);
+		srv_name[len] = '\0';
+		reg->srv_name = srv_name;
+	} else {
+		reg->srv_name = NULL;
+	}
+
+	if (strcmp("-", argv[5])) {
+		len = strlen(argv[5]) + 1;
+		srv_descr = (char *) malloc(len);
+		strcpy(srv_descr, argv[5]);
+		srv_descr[len] = '\0';
+		reg->srv_desp = srv_descr;
+	} else {
+		reg->srv_desp = NULL;
+	}
+
+	reg->number_of_mdeps = atoi(argv[6]);
+
+	reg->mdep_cfg = (bthl_mdep_cfg_t *) malloc(reg->number_of_mdeps
+						* sizeof(bthl_mdep_cfg_t));
+	mdep_argc_init = 7;
+
+	for (i = 0; i < reg->number_of_mdeps; i++) {
+		mdep_argc_off = mdep_argc_init + (4 * i);
+		reg->mdep_cfg[i].mdep_role =
+				str2bthl_mdep_role_t(argv[mdep_argc_off]);
+		reg->mdep_cfg[i].data_type = atoi(argv[mdep_argc_off + 1]);
+		reg->mdep_cfg[i].channel_type =
+			str2bthl_channel_type_t(argv[mdep_argc_off + 2]);
+
+		if (strcmp("-", argv[mdep_argc_off + 3])) {
+			reg->mdep_cfg[i].mdep_description = NULL;
+			continue;
+		}
+
+		len = strlen(argv[mdep_argc_off + 3]) + 1;
+		descr = (char *) malloc(len);
+		strcpy(descr, argv[mdep_argc_off + 3]);
+		descr[len] = '\0';
+		reg->mdep_cfg[i].mdep_description = descr;
+	}
+
+	EXEC(if_hl->register_application, reg, &app_id);
+
+	/* free memory */
+	for (i = 0; i < reg->number_of_mdeps; i++)
+		free((void *) reg->mdep_cfg[i].mdep_description);
+
+	free(reg->mdep_cfg);
+	free((void *) reg->application_name);
+	free((void *) reg->provider_name);
+	free((void *) reg->srv_name);
+	free((void *) reg->srv_desp);
+	free(reg);
+}
+
 /* cleanup */
 
 static void cleanup_p(int argc, const char **argv)
@@ -54,6 +185,11 @@ static void cleanup_p(int argc, const char **argv)
 
 static struct method methods[] = {
 	STD_METHOD(init),
+	STD_METHODH(register_application,
+		"[input optional string paramerts like -]\n"
+		"<app_name> <provider_name> <srv_name> <srv_descr>\n"
+		"<num_of_mdeps>\n"
+		"[<mdep_role> <data_type> <channel_type> <mdep_descr>] ..."),
 	STD_METHOD(cleanup),
 	END_METHOD
 };
-- 
1.8.3.2

