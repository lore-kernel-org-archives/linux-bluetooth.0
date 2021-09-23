Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA7DC4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30E6D61131
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239085AbhIWD2z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Sep 2021 23:28:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:16381 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239045AbhIWD2p (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Sep 2021 23:28:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="220555932"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="220555932"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:27:02 -0700
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="534072404"
Received: from jdudwadk-mobl.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.212.205.211])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:27:02 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 17/20] mesh: Implement ExportKeys() method
Date:   Wed, 22 Sep 2021 20:26:00 -0700
Message-Id: <20210923032603.50536-18-inga.stotland@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210923032603.50536-1-inga.stotland@intel.com>
References: <20210923032603.50536-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add implementation for new method ExportKeys() on
org.bluez.mesh.Management1 interface.
This method is used by the authorized application to export information
about network keys, application keys and device keys present in the
local key database.
---
 mesh/keyring.c | 286 ++++++++++++++++++++++++++++++++++++++++++++++++-
 mesh/keyring.h |   2 +
 mesh/manager.c |  35 ++++++
 3 files changed, 322 insertions(+), 1 deletion(-)

diff --git a/mesh/keyring.c b/mesh/keyring.c
index f27fe4291..4b901643c 100644
--- a/mesh/keyring.c
+++ b/mesh/keyring.c
@@ -26,6 +26,7 @@
 
 #include "mesh/mesh-defs.h"
 
+#include "mesh/dbus.h"
 #include "mesh/node.h"
 #include "mesh/keyring.h"
 
@@ -276,7 +277,6 @@ bool keyring_get_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 
 	snprintf(key_file, PATH_MAX, "%s%s/%4.4x", node_path, dev_key_dir,
 								unicast);
-
 	fd = open(key_file, O_RDONLY);
 	if (fd >= 0) {
 		if (read(fd, dev_key, 16) == 16)
@@ -349,3 +349,287 @@ bool keyring_del_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 
 	return true;
 }
+
+static DIR *open_key_dir(const char *node_path, const char *key_dir_name)
+{
+	char dir_path[PATH_MAX];
+	DIR *key_dir;
+
+	if (strlen(node_path) + strlen(key_dir_name) + 1 >= PATH_MAX)
+		return NULL;
+
+	snprintf(dir_path, PATH_MAX, "%s%s", node_path, key_dir_name);
+
+	key_dir = opendir(dir_path);
+	if (!key_dir) {
+		l_error("Failed to open keyring storage directory: %s",
+								dir_path);
+		return NULL;
+	}
+
+	return key_dir;
+}
+
+static int open_key_dir_entry(int dir_fd, struct dirent *entry,
+							uint8_t fname_len)
+{
+	if (entry->d_type != DT_REG)
+		return -1;
+
+	/* Check the file name length */
+	if (strlen(entry->d_name) != fname_len)
+		return -1;
+
+	return openat(dir_fd, entry->d_name, O_RDONLY);
+}
+
+static void append_old_key(struct l_dbus_message_builder *builder,
+							const uint8_t key[16])
+{
+	l_dbus_message_builder_enter_dict(builder, "sv");
+	l_dbus_message_builder_append_basic(builder, 's', "OldKey");
+	l_dbus_message_builder_enter_variant(builder, "ay");
+	dbus_append_byte_array(builder, key, 16);
+	l_dbus_message_builder_leave_variant(builder);
+	l_dbus_message_builder_leave_dict(builder);
+}
+
+static void build_app_keys_reply(const char *node_path,
+					struct l_dbus_message_builder *builder,
+					uint16_t net_idx, uint8_t phase)
+{
+	DIR *key_dir;
+	int key_dir_fd;
+	struct dirent *entry;
+
+	key_dir = open_key_dir(node_path, app_key_dir);
+	if (!key_dir)
+		return;
+
+	key_dir_fd = dirfd(key_dir);
+
+	l_dbus_message_builder_enter_dict(builder, "sv");
+	l_dbus_message_builder_append_basic(builder, 's', "AppKeys");
+	l_dbus_message_builder_enter_variant(builder, "a(qaya{sv})");
+	l_dbus_message_builder_enter_array(builder, "(qaya{sv})");
+
+	while ((entry = readdir(key_dir)) != NULL) {
+		struct keyring_app_key key;
+		int fd = open_key_dir_entry(key_dir_fd, entry, 3);
+
+		if (fd < 0)
+			continue;
+
+		if (read(fd, &key, sizeof(key)) != sizeof(key) ||
+						key.net_idx != net_idx) {
+			close(fd);
+			continue;
+		}
+
+		close(fd);
+
+		l_dbus_message_builder_enter_struct(builder, "qaya{sv}");
+
+		l_dbus_message_builder_append_basic(builder, 'q', &key.app_idx);
+		dbus_append_byte_array(builder, key.new_key, 16);
+
+		l_dbus_message_builder_enter_array(builder, "{sv}");
+
+		if (phase != KEY_REFRESH_PHASE_NONE)
+			append_old_key(builder, key.old_key);
+
+		l_dbus_message_builder_leave_array(builder);
+		l_dbus_message_builder_leave_struct(builder);
+	}
+
+	l_dbus_message_builder_leave_array(builder);
+	l_dbus_message_builder_leave_variant(builder);
+	l_dbus_message_builder_leave_dict(builder);
+
+	closedir(key_dir);
+}
+
+static bool build_net_keys_reply(const char *node_path,
+					struct l_dbus_message_builder *builder)
+{
+	DIR *key_dir;
+	int key_dir_fd;
+	struct dirent *entry;
+	bool result = false;
+
+	key_dir = open_key_dir(node_path, net_key_dir);
+	if (!key_dir)
+		return false;
+
+	key_dir_fd = dirfd(key_dir);
+
+	l_dbus_message_builder_enter_dict(builder, "sv");
+	l_dbus_message_builder_append_basic(builder, 's', "NetKeys");
+	l_dbus_message_builder_enter_variant(builder, "a(qaya{sv})");
+	l_dbus_message_builder_enter_array(builder, "(qaya{sv})");
+
+	while ((entry = readdir(key_dir)) != NULL) {
+		struct keyring_net_key key;
+		int fd = open_key_dir_entry(key_dir_fd, entry, 3);
+
+		if (fd < 0)
+			continue;
+
+		if (read(fd, &key, sizeof(key)) != sizeof(key)) {
+			close(fd);
+			goto done;
+		}
+
+		close(fd);
+
+		/*
+		 * If network key is stuck in phase 3, keyring
+		 * write failed and this key info is unreliable.
+		 */
+		if (key.phase == KEY_REFRESH_PHASE_THREE)
+			continue;
+
+		l_dbus_message_builder_enter_struct(builder, "qaya{sv}");
+
+		l_dbus_message_builder_append_basic(builder, 'q', &key.net_idx);
+		dbus_append_byte_array(builder, key.new_key, 16);
+
+		l_dbus_message_builder_enter_array(builder, "{sv}");
+
+		if (key.phase != KEY_REFRESH_PHASE_NONE) {
+			dbus_append_dict_entry_basic(builder, "Phase", "y",
+								&key.phase);
+			append_old_key(builder, key.old_key);
+		}
+
+		build_app_keys_reply(node_path, builder, key.net_idx,
+								key.phase);
+
+		l_dbus_message_builder_leave_array(builder);
+		l_dbus_message_builder_leave_struct(builder);
+	}
+
+	l_dbus_message_builder_leave_array(builder);
+	l_dbus_message_builder_leave_variant(builder);
+	l_dbus_message_builder_leave_dict(builder);
+
+	result = true;
+done:
+	closedir(key_dir);
+
+	return result;
+
+}
+
+struct dev_key_entry {
+	uint16_t unicast;
+	uint8_t value[16];
+};
+
+static bool match_key_value(const void *a, const void *b)
+{
+	const struct dev_key_entry *key = a;
+	const uint8_t *value = b;
+
+	return (memcmp(key->value, value, 16) == 0);
+}
+
+static void build_dev_key_entry(void *a, void *b)
+{
+	struct dev_key_entry *key = a;
+	struct l_dbus_message_builder *builder = b;
+
+	l_dbus_message_builder_enter_struct(builder, "qay");
+	l_dbus_message_builder_append_basic(builder, 'q', &key->unicast);
+	dbus_append_byte_array(builder, key->value, 16);
+	l_dbus_message_builder_leave_struct(builder);
+}
+
+static bool build_dev_keys_reply(const char *node_path,
+					struct l_dbus_message_builder *builder)
+{
+	DIR *key_dir;
+	int key_dir_fd;
+	struct dirent *entry;
+	struct l_queue *keys;
+	bool result = false;
+
+	key_dir = open_key_dir(node_path, dev_key_dir);
+	/*
+	 * There is always at least one device key present for a local node.
+	 * Therefore, return false, if the directory does not exist.
+	 */
+	if (!key_dir)
+		return false;
+
+	key_dir_fd = dirfd(key_dir);
+
+	keys = l_queue_new();
+
+	while ((entry = readdir(key_dir)) != NULL) {
+		uint8_t buf[16];
+		uint16_t unicast;
+		struct dev_key_entry *key;
+		int fd = open_key_dir_entry(key_dir_fd, entry, 4);
+
+		if (fd < 0)
+			continue;
+
+		if (read(fd, buf, 16) != 16) {
+			close(fd);
+			goto done;
+		}
+
+		close(fd);
+
+		if (sscanf(entry->d_name, "%04hx", &unicast) != 1)
+			goto done;
+
+		key = l_queue_find(keys, match_key_value, buf);
+
+		if (key) {
+			if (key->unicast > unicast)
+				key->unicast = unicast;
+			continue;
+		}
+
+		key = l_new(struct dev_key_entry, 1);
+		key->unicast = unicast;
+		memcpy(key->value, buf, 16);
+		l_queue_push_tail(keys, key);
+	}
+
+	l_dbus_message_builder_enter_dict(builder, "sv");
+	l_dbus_message_builder_append_basic(builder, 's', "DevKeys");
+	l_dbus_message_builder_enter_variant(builder, "a(qay)");
+	l_dbus_message_builder_enter_array(builder, "(qay)");
+
+	l_queue_foreach(keys, build_dev_key_entry, builder);
+
+	l_dbus_message_builder_leave_array(builder);
+	l_dbus_message_builder_leave_variant(builder);
+	l_dbus_message_builder_leave_dict(builder);
+
+	result = true;
+done:
+	l_queue_destroy(keys, l_free);
+	closedir(key_dir);
+
+	return result;
+}
+
+bool keyring_build_export_keys_reply(struct mesh_node *node,
+					struct l_dbus_message_builder *builder)
+{
+	const char *node_path;
+
+	if (!node)
+		return false;
+
+	node_path = node_get_storage_dir(node);
+
+	if (!build_net_keys_reply(node_path, builder))
+		return false;
+
+	return build_dev_keys_reply(node_path, builder);
+}
diff --git a/mesh/keyring.h b/mesh/keyring.h
index c2d38e9ff..ecf62cbc1 100644
--- a/mesh/keyring.h
+++ b/mesh/keyring.h
@@ -39,3 +39,5 @@ bool keyring_put_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 					uint8_t count, uint8_t dev_key[16]);
 bool keyring_del_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 								uint8_t count);
+bool keyring_build_export_keys_reply(struct mesh_node *node,
+					struct l_dbus_message_builder *builder);
diff --git a/mesh/manager.c b/mesh/manager.c
index d70993e3b..e66b1a45b 100644
--- a/mesh/manager.c
+++ b/mesh/manager.c
@@ -776,6 +776,38 @@ static struct l_dbus_message *set_key_phase_call(struct l_dbus *dbus,
 	return l_dbus_message_new_method_return(msg);
 }
 
+static struct l_dbus_message *export_keys_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	const char *sender = l_dbus_message_get_sender(msg);
+	struct l_dbus_message_builder *builder;
+	struct l_dbus_message *reply;
+	struct mesh_node *node = user_data;
+
+	l_debug("Export Keys");
+
+	if (strcmp(sender, node_get_owner(node)))
+		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED, NULL);
+
+	reply = l_dbus_message_new_method_return(msg);
+	builder = l_dbus_message_builder_new(reply);
+
+	l_dbus_message_builder_enter_array(builder, "{sv}");
+
+	if (!keyring_build_export_keys_reply(node, builder)) {
+		l_dbus_message_builder_destroy(builder);
+		l_dbus_message_unref(reply);
+		return dbus_error(msg, MESH_ERROR_FAILED, NULL);
+	}
+
+	l_dbus_message_builder_leave_array(builder);
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+
+	return reply;
+}
+
 static void setup_management_interface(struct l_dbus_interface *iface)
 {
 	l_dbus_interface_method(iface, "AddNode", 0, add_node_call, "",
@@ -807,6 +839,9 @@ static void setup_management_interface(struct l_dbus_interface *iface)
 							"app_index", "app_key");
 	l_dbus_interface_method(iface, "SetKeyPhase", 0, set_key_phase_call, "",
 						"qy", "net_index", "phase");
+	l_dbus_interface_method(iface, "ExportKeys", 0, export_keys_call,
+							"a(qaya{sv})a(qay)", "",
+							"net_keys", "dev_keys");
 }
 
 bool manager_dbus_init(struct l_dbus *bus)
-- 
2.31.1

