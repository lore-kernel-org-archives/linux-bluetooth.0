Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B014FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AE1961038
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239084AbhIWD25 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Sep 2021 23:28:57 -0400
Received: from mga11.intel.com ([192.55.52.93]:16381 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239071AbhIWD2q (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Sep 2021 23:28:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="220555937"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="220555937"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:27:04 -0700
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="534072414"
Received: from jdudwadk-mobl.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.212.205.211])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:27:04 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 20/20] tools/mesh-cfgclient: Export configuration database
Date:   Wed, 22 Sep 2021 20:26:03 -0700
Message-Id: <20210923032603.50536-21-inga.stotland@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210923032603.50536-1-inga.stotland@intel.com>
References: <20210923032603.50536-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds main menu command "export-db".
When the command is invoked, JSON configuration object is
cloned and trimmed of extraneous properties.
Information about netkeys, appkeys and device keys are obtained
from bluetooth-meshd by calling ExportKeys() method.
The obtained key values are recorded in the export JSON object.
---
 tools/mesh-cfgclient.c | 195 +++++++++++++++++++++++++++++++++++++++++
 tools/mesh/mesh-db.c   | 191 ++++++++++++++++++++++++++++++++++++++++
 tools/mesh/mesh-db.h   |   7 ++
 3 files changed, 393 insertions(+)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index beeb115dc..237afbb5f 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -17,6 +17,7 @@
 #include <ctype.h>
 #include <dbus/dbus.h>
 #include <errno.h>
+#include <libgen.h>
 #include <stdio.h>
 #include <time.h>
 
@@ -51,6 +52,7 @@
 #define MAX_CRPL_SIZE		0x7fff
 
 #define DEFAULT_CFG_FILE	"config_db.json"
+#define DEFAULT_EXPORT_FILE	"export_db.json"
 
 struct meshcfg_el {
 	const char *path;
@@ -835,6 +837,197 @@ static void cmd_scan_unprov(int argc, char *argv[])
 
 }
 
+static uint8_t *parse_key(struct l_dbus_message_iter *iter, uint16_t id,
+							const char *name)
+{
+	uint8_t *val;
+	uint32_t len;
+
+	if (!l_dbus_message_iter_get_fixed_array(iter, &val, &len)
+								|| len != 16) {
+		bt_shell_printf("Failed to parse %s %4.4x\n", name, id);
+		return NULL;
+	}
+
+	return val;
+}
+
+static bool parse_app_keys(struct l_dbus_message_iter *iter, uint16_t net_idx,
+								void *user_data)
+{
+	struct l_dbus_message_iter app_keys, app_key, opts;
+	uint16_t app_idx;
+
+	if (!l_dbus_message_iter_get_variant(iter, "a(qaya{sv})", &app_keys))
+		return false;
+
+	while (l_dbus_message_iter_next_entry(&app_keys, &app_idx, &app_key,
+								&opts)) {
+		struct l_dbus_message_iter var;
+		uint8_t *val, *old_val = NULL;
+		const char *key;
+
+		val = parse_key(&app_key, app_idx, "AppKey");
+		if (!val)
+			return false;
+
+		while (l_dbus_message_iter_next_entry(&opts, &key, &var)) {
+			if (!strcmp(key, "OldKey")) {
+				if (!l_dbus_message_iter_get_variant(&var, "ay",
+								&app_key))
+					return false;
+
+				old_val = parse_key(&app_key, app_idx,
+								"old NetKey");
+
+				if (!old_val)
+					return false;
+			}
+		}
+
+		mesh_db_set_app_key(user_data, net_idx, app_idx, val, old_val);
+	}
+
+	return true;
+}
+
+static bool parse_net_keys(struct l_dbus_message_iter *iter, void *user_data)
+{
+	struct l_dbus_message_iter net_keys, net_key, opts;
+	uint16_t idx;
+
+	if (!l_dbus_message_iter_get_variant(iter, "a(qaya{sv})", &net_keys))
+		return false;
+
+	while (l_dbus_message_iter_next_entry(&net_keys, &idx, &net_key,
+								&opts)) {
+		struct l_dbus_message_iter var;
+		uint8_t *val, *old_val = NULL;
+		uint8_t phase = KEY_REFRESH_PHASE_NONE;
+		const char *key;
+
+		val = parse_key(&net_key, idx, "NetKey");
+		if (!val)
+			return false;
+
+		while (l_dbus_message_iter_next_entry(&opts, &key, &var)) {
+			if (!strcmp(key, "AppKeys")) {
+				if (!parse_app_keys(&var, idx, user_data))
+					return false;
+			} else if (!strcmp(key, "Phase")) {
+				if (!l_dbus_message_iter_get_variant(&var, "y",
+									&phase))
+					return false;
+			} else if (!strcmp(key, "OldKey")) {
+				if (!l_dbus_message_iter_get_variant(&var, "ay",
+								&net_key))
+					return false;
+
+				old_val = parse_key(&net_key, idx,
+								"old NetKey");
+
+				if (!old_val)
+					return false;
+			}
+		}
+
+		mesh_db_set_net_key(user_data, idx, val, old_val, phase);
+	}
+
+	return true;
+}
+
+static bool parse_dev_keys(struct l_dbus_message_iter *iter, void *user_data)
+{
+	struct l_dbus_message_iter keys, dev_key;
+	uint16_t unicast;
+
+	if (!l_dbus_message_iter_get_variant(iter, "a(qay)", &keys))
+		return false;
+
+	while (l_dbus_message_iter_next_entry(&keys, &unicast, &dev_key)) {
+		uint8_t *data;
+
+		data = parse_key(&dev_key, unicast, "Device Key");
+		if (!data)
+			return false;
+
+		mesh_db_set_device_key(user_data, unicast, data);
+	}
+
+	return true;
+}
+
+static void export_keys_reply(struct l_dbus_proxy *proxy,
+				struct l_dbus_message *msg, void *user_data)
+{
+	struct l_dbus_message_iter iter, var;
+	char *cfg_dir = NULL, *fname = NULL;
+	const char *key;
+	bool is_error = true;
+
+	if (l_dbus_message_is_error(msg)) {
+		const char *name;
+
+		l_dbus_message_get_error(msg, &name, NULL);
+		bt_shell_printf("Failed to export keys: %s", name);
+		goto done;
+
+	}
+
+	if (!l_dbus_message_get_arguments(msg, "a{sv}", &iter)) {
+		bt_shell_printf("Malformed ExportKeys reply");
+		goto done;
+	}
+
+	while (l_dbus_message_iter_next_entry(&iter, &key, &var)) {
+		if (!strcmp(key, "NetKeys")) {
+			if (!parse_net_keys(&var, user_data))
+				goto done;
+		} else if (!strcmp(key, "DevKeys")) {
+			if (!parse_dev_keys(&var, user_data))
+				goto done;
+		}
+	}
+
+	is_error = false;
+
+	cfg_dir = l_strdup(cfg_fname);
+	cfg_dir = dirname(cfg_dir);
+
+	fname = l_strdup_printf("%s/%s", cfg_dir, DEFAULT_EXPORT_FILE);
+
+done:
+	if (mesh_db_finish_export(is_error, user_data, fname)) {
+		if (!is_error)
+			bt_shell_printf("Config DB is exported to %s\n", fname);
+	}
+
+	l_free(cfg_dir);
+	l_free(fname);
+}
+
+static void cmd_export_db(int argc, char *argv[])
+{
+	void *cfg_export;
+
+	if (!local || !local->proxy || !local->mgmt_proxy) {
+		bt_shell_printf("Node is not attached\n");
+		return;
+	}
+
+	/* Generate a properly formatted DB from the local config */
+	cfg_export = mesh_db_prepare_export();
+	if (!cfg_export) {
+		bt_shell_printf("Failed to prepare config db\n");
+		return;
+	}
+
+	/* Export the keys from the daemon */
+	l_dbus_proxy_method_call(local->mgmt_proxy, "ExportKeys", NULL,
+					export_keys_reply, cfg_export, NULL);
+}
+
 static void cmd_list_unprov(int argc, char *argv[])
 {
 	bt_shell_printf(COLOR_YELLOW "Unprovisioned devices:\n" COLOR_OFF);
@@ -1395,6 +1588,8 @@ static const struct bt_shell_menu main_menu = {
 			"List remote mesh nodes"},
 	{ "keys", NULL, cmd_keys,
 			"List available keys"},
+	{ "export-db", NULL, cmd_export_db,
+			"Export mesh configuration database"},
 	{ } },
 };
 
diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index 262a274c7..12055c1a9 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -48,6 +48,13 @@ static struct mesh_db *cfg;
 static const char *bak_ext = ".bak";
 static const char *tmp_ext = ".tmp";
 
+static const char *js_schema = "http://json-schema.org/draft-04/schema#";
+static const char *schema_id = "http://www.bluetooth.com/specifications/"
+				"assigned-numbers/mesh-profile/"
+				"cdb-schema.json#";
+const char *schema_version = "1.0.0";
+
+
 static bool add_string(json_object *jobj, const char *desc, const char *str)
 {
 	json_object *jstring = json_object_new_string(str);
@@ -2412,3 +2419,187 @@ fail:
 
 	return false;
 }
+
+bool mesh_db_set_device_key(void *expt_cfg, uint16_t unicast, uint8_t key[16])
+{
+	json_object *jnode;
+
+	if (!expt_cfg)
+		return false;
+
+	jnode = get_node_by_unicast(expt_cfg, unicast);
+	if (!jnode)
+		return false;
+
+	return add_u8_16(jnode, "deviceKey", key);
+}
+
+bool mesh_db_set_net_key(void *expt_cfg, uint16_t idx, uint8_t key[16],
+					uint8_t *old_key, uint8_t phase)
+{
+	json_object *jarray, *jkey;
+
+	if (!expt_cfg)
+		return false;
+
+	json_object_object_get_ex(expt_cfg, "netKeys", &jarray);
+	if (!jarray || json_object_get_type(jarray) != json_type_array)
+		return false;
+
+	jkey = get_key_object(jarray, idx);
+	if (!jkey)
+		return false;
+
+	if (!write_int(jkey, "phase", phase))
+		return false;
+
+	if (!add_u8_16(jkey, "key", key))
+		return false;
+
+	if (old_key && !(!add_u8_16(jkey, "oldKey", old_key)))
+		return false;
+
+	return true;
+}
+
+
+bool mesh_db_set_app_key(void *expt_cfg, uint16_t net_idx, uint16_t app_idx,
+					uint8_t key[16], uint8_t *old_key)
+{
+	json_object *jarray, *jkey;
+
+	if (!expt_cfg)
+		return false;
+
+	json_object_object_get_ex(expt_cfg, "appKeys", &jarray);
+	if (!jarray || json_object_get_type(jarray) != json_type_array)
+		return false;
+
+	jkey = get_key_object(jarray, app_idx);
+	if (!jkey)
+		return false;
+
+	if (!add_u8_16(jkey, "key", key))
+		return false;
+
+	if (old_key && !(!add_u8_16(jkey, "oldKey", old_key)))
+		return false;
+
+	return true;
+}
+
+void *mesh_db_prepare_export(void)
+{
+	json_object *export = NULL, *jarray;
+
+	if (!cfg || !cfg->jcfg)
+		return false;
+
+	if (json_object_deep_copy(cfg->jcfg, &export, NULL) != 0)
+		return NULL;
+
+	/* Delete token */
+	json_object_object_del(export, "token");
+
+	/* Delete IV index */
+	json_object_object_del(export, "ivIndex");
+
+	/* Scenes are not supported. Just add an empty array */
+	jarray = json_object_new_array();
+	json_object_object_add(export, "scenes", jarray);
+
+	write_bool(export, "partial", false);
+
+	return export;
+}
+
+bool mesh_db_finish_export(bool is_error, void *expt_cfg, const char *fname)
+{
+	FILE *outfile = NULL;
+	const char *str, *hdr;
+	json_object *jhdr = NULL;
+	bool result = false;
+	char *pos;
+
+	uint32_t sz;
+
+	if (!expt_cfg)
+		return false;
+
+	if (is_error) {
+		json_object_put(expt_cfg);
+		return true;
+	}
+
+	if (!fname)
+		goto done;
+
+	outfile = fopen(fname, "w");
+	if (!outfile) {
+		l_error("Failed to save configuration to %s", fname);
+		goto done;
+	}
+
+	jhdr = json_object_new_object();
+	if (!add_string(jhdr, "$schema", js_schema))
+		goto done;
+
+	if (!add_string(jhdr, "id", schema_id))
+		goto done;
+
+	if (!add_string(jhdr, "version", schema_version))
+		goto done;
+
+	hdr = json_object_to_json_string_ext(jhdr, JSON_C_TO_STRING_PRETTY |
+						JSON_C_TO_STRING_NOSLASHESCAPE);
+
+	str = json_object_to_json_string_ext(expt_cfg, JSON_C_TO_STRING_PRETTY |
+						JSON_C_TO_STRING_NOSLASHESCAPE);
+
+	if (!hdr || !str)
+		goto done;
+
+	/*
+	 * Write two strings to the output while stripping closing "}" from the
+	 * header string and opening "{" from the config object.
+	 */
+
+	pos = strrchr(hdr, '}');
+	if (!pos)
+		goto done;
+
+	*pos = '\0';
+
+	pos = strrchr(hdr, '"');
+	if (!pos)
+		goto done;
+
+	pos[1] = ',';
+
+	if (fwrite(hdr, sizeof(char), strlen(hdr), outfile) < strlen(hdr))
+		goto done;
+
+	pos = strchr(str, '{');
+	if (!pos || pos[1] == '\0')
+		goto done;
+
+	pos++;
+
+	sz = strlen(pos);
+
+	if (fwrite(pos, sizeof(char), sz, outfile) < sz)
+		goto done;
+
+	result = true;
+
+done:
+	if (outfile)
+		fclose(outfile);
+
+	json_object_put(expt_cfg);
+
+	if (jhdr)
+		json_object_put(jhdr);
+
+	return result;
+}
diff --git a/tools/mesh/mesh-db.h b/tools/mesh/mesh-db.h
index 16c46c046..4b6b2adb3 100644
--- a/tools/mesh/mesh-db.h
+++ b/tools/mesh/mesh-db.h
@@ -82,3 +82,10 @@ struct l_queue *mesh_db_load_groups(void);
 bool mesh_db_add_group(struct mesh_group *grp);
 bool mesh_db_add_rejected_addr(uint16_t unicast, uint32_t iv_index);
 bool mesh_db_clear_rejected(uint32_t iv_index);
+bool mesh_db_set_device_key(void *expt_cfg, uint16_t unicast, uint8_t key[16]);
+bool mesh_db_set_net_key(void *expt_cfg, uint16_t idx, uint8_t key[16],
+					uint8_t *old_key, uint8_t phase);
+bool mesh_db_set_app_key(void *expt_cfg, uint16_t net_idx, uint16_t app_idx,
+					uint8_t key[16], uint8_t *old_key);
+void *mesh_db_prepare_export(void);
+bool mesh_db_finish_export(bool is_error, void *expt_cfg, const char *fname);
-- 
2.31.1

