Return-Path: <SRS0=dcS5=2B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD8FC43603
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Dec 2019 00:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0475D2073D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Dec 2019 00:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfLKA4S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Dec 2019 19:56:18 -0500
Received: from mga07.intel.com ([134.134.136.100]:20891 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbfLKA4S (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Dec 2019 19:56:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 16:56:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600"; 
   d="scan'208";a="207494748"
Received: from ingas-nuc1.sea.intel.com ([10.254.187.166])
  by orsmga008.jf.intel.com with ESMTP; 10 Dec 2019 16:56:17 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Add mesh-main.conf file with general mesh configuration
Date:   Tue, 10 Dec 2019 16:56:16 -0800
Message-Id: <20191211005616.28722-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds key file with default settings for the mesh daemon.
The following settings are included:

    Beacon:          Default setting for to indicate whether
                     secure network beaconing is enabled for a
                     node whose Beacon state hasn't been configured
                     by a configuration client, i.e., this setting
                     apllies to a newly provisioned, created or
                     imported node.

    Relay:           Default setting for supporting relay

    Friendship:      Default setting for supporting Friendship

    CRPL:            Default depth of replay protection list.

    FriendQueueSize: Default size of friend queue: the number
                     of messages that each Friend node can store
                     for the Low Power node.

    ProvTimeout:     Provisioning timeout in seconds.
---
 Makefile.mesh       |   2 +-
 mesh/main.c         |  10 +++--
 mesh/mesh-main.conf |  43 +++++++++++++++++++
 mesh/mesh.c         | 102 +++++++++++++++++++++++++++++++++++++++++---
 mesh/mesh.h         |   8 +++-
 mesh/node.c         |  12 +++---
 6 files changed, 162 insertions(+), 15 deletions(-)
 create mode 100644 mesh/mesh-main.conf

diff --git a/Makefile.mesh b/Makefile.mesh
index 90979cbc0..401122029 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -48,4 +48,4 @@ CLEANFILES += mesh/bluetooth-mesh.service
 endif
 
 EXTRA_DIST += mesh/bluetooth-mesh.conf mesh/bluetooth-mesh.service.in \
-		mesh/org.bluez.mesh.service
+		mesh/org.bluez.mesh.service mesh/mesh-main.conf
diff --git a/mesh/main.c b/mesh/main.c
index 3c41acb75..010edcf85 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -39,6 +39,7 @@
 #include "mesh/mesh-io.h"
 
 static const char *config_dir;
+static const char *mesh_conf_fname;
 static int ctlr_index = MGMT_INDEX_NONE;
 
 static const struct option main_options[] = {
@@ -99,8 +100,8 @@ static void request_name_callback(struct l_dbus *dbus, bool success,
 		return;
 	}
 
-	if (!mesh_init(config_dir, MESH_IO_TYPE_GENERIC, &ctlr_index,
-					mesh_ready_callback, dbus)) {
+	if (!mesh_init(config_dir, mesh_conf_fname, MESH_IO_TYPE_GENERIC,
+				&ctlr_index, mesh_ready_callback, dbus)) {
 		l_error("Failed to initialize mesh");
 		l_main_quit();
 	}
@@ -154,7 +155,7 @@ int main(int argc, char *argv[])
 		int opt;
 		const char *str;
 
-		opt = getopt_long(argc, argv, "i:c:ndbh", main_options, NULL);
+		opt = getopt_long(argc, argv, "i:c:f:ndbh", main_options, NULL);
 		if (opt < 0)
 			break;
 
@@ -182,6 +183,9 @@ int main(int argc, char *argv[])
 		case 'c':
 			config_dir = optarg;
 			break;
+		case 'f':
+			mesh_conf_fname = optarg;
+			break;
 		case 'b':
 			dbus_debug = true;
 			break;
diff --git a/mesh/mesh-main.conf b/mesh/mesh-main.conf
new file mode 100644
index 000000000..aca9e6fa5
--- /dev/null
+++ b/mesh/mesh-main.conf
@@ -0,0 +1,43 @@
+[General]
+
+# Default setting for to indicate whether secure network beaconing
+# is enabled for a node whose Beacon state hasn't been configured
+# by a configuration client, i.e., for a newly provisioned, created
+# or imported node.
+# Defaults to true.
+#Beacon = true
+
+# Default setting for supporting relay. The setting applies
+# to all local nodes.
+# If the value is true, then a configuration client can either enable or disable
+# the relay feature per local node.
+# If the value is false, then the relay feature cannot be configured for
+# any local node.
+# Defaults to true.
+#Relay = true
+
+# Default setting for supporting Friendship. The setting applies
+# to all local nodes.
+# If the value is true, then a configuration client can either enable or disable
+# the Friendship feature per local node.
+# If the value is false, then the Friendship feature cannot be configured for
+# any local node.
+# Defaults to true.
+#Friendship = true
+
+# Default depth of replay protection list. This setting applies to
+# each individual node.
+# Valid range 1-65535.
+# Defaults to 100.
+#CRPL = 100
+
+# Default size of friend queue: the number of messages that each Friend node can
+# store for the Low Power node.
+# Valid range: 0-32.
+# Defaults to 32.
+#FriendQueueSize = 32
+
+# Provisioning timeout in seconds.
+# Setting this value to zero means there's no timeout.
+# Defaults to 60.
+#ProvTimeout = 60
diff --git a/mesh/mesh.c b/mesh/mesh.c
index 68cf0cd12..6d2f86b6d 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -37,12 +37,13 @@
 
 /*
  * The default values for mesh configuration. Can be
- * overwritten by values from mesh.conf
+ * overwritten by values from mesh-main.conf
  */
 #define DEFAULT_PROV_TIMEOUT 60
-#define DEFAULT_ALGORITHMS 0x0001
+#define DEFAULT_CRPL 100
+#define DEFAULT_FRIEND_QUEUE_SZ 32
 
-/* TODO: add more default values */
+#define DEFAULT_ALGORITHMS 0x0001
 
 struct scan_filter {
 	uint8_t id;
@@ -55,8 +56,15 @@ struct bt_mesh {
 	prov_rx_cb_t prov_rx;
 	void *prov_data;
 	uint32_t prov_timeout;
+	bool beacon_enabled;
+	bool friend_support;
+	bool relay_support;
+	bool lpn_support;
+	bool proxy_support;
+	uint16_t crpl;
 	uint16_t algorithms;
 	uint16_t req_index;
+	uint8_t friend_queue_sz;
 	uint8_t max_filters;
 };
 
@@ -75,7 +83,17 @@ struct mesh_init_request {
 	void *user_data;
 };
 
-static struct bt_mesh mesh;
+static struct bt_mesh mesh = {
+	.algorithms = DEFAULT_ALGORITHMS,
+	.prov_timeout = DEFAULT_PROV_TIMEOUT,
+	.beacon_enabled = true,
+	.friend_support = true,
+	.relay_support = true,
+	.lpn_support = false,
+	.proxy_support = false,
+	.crpl = DEFAULT_CRPL,
+	.friend_queue_sz = DEFAULT_FRIEND_QUEUE_SZ
+};
 
 /* We allow only one outstanding Join request */
 static struct join_data *join_pending;
@@ -155,7 +173,76 @@ static void io_ready_callback(void *user_data, bool result)
 	l_free(req);
 }
 
-bool mesh_init(const char *config_dir, enum mesh_io_type type, void *opts,
+bool mesh_beacon_enabled(void)
+{
+	return mesh.beacon_enabled;
+}
+
+bool mesh_relay_supported(void)
+{
+	return mesh.relay_support;
+}
+
+bool mesh_friendship_supported(void)
+{
+	return mesh.friend_support;
+}
+
+uint16_t mesh_get_crpl(void)
+{
+	return mesh.crpl;
+}
+
+uint8_t mesh_get_friend_queue_size(void)
+{
+	return mesh.friend_queue_sz;
+}
+
+static void parse_settings(const char *mesh_conf_fname)
+{
+	struct l_settings *settings;
+	char *str;
+	uint32_t value;
+
+	settings = l_settings_new();
+	if (!l_settings_load_from_file(settings, mesh_conf_fname))
+		return;
+
+	str = l_settings_get_string(settings, "General", "Beacon");
+	if (str) {
+		if (!strcasecmp(str, "true"))
+			mesh.beacon_enabled = true;
+		l_free(str);
+	}
+
+	str = l_settings_get_string(settings, "General", "Relay");
+	if (str) {
+		if (!strcasecmp(str, "false"))
+			mesh.relay_support = false;
+		l_free(str);
+	}
+
+	str = l_settings_get_string(settings, "General", "Friendship");
+	if (str) {
+		if (!strcasecmp(str, "false"))
+			mesh.friend_support = false;
+		l_free(str);
+	}
+
+	if (l_settings_get_uint(settings, "General", "CRPL", &value) &&
+							value <= 65535)
+		mesh.crpl = value;
+
+	if (l_settings_get_uint(settings, "General", "FriendQueueSize", &value)
+								&& value < 127)
+		mesh.friend_queue_sz = value;
+
+	if (l_settings_get_uint(settings, "General", "ProvTimeout", &value))
+		mesh.prov_timeout = value;
+}
+
+bool mesh_init(const char *config_dir, const char *mesh_conf_fname,
+					enum mesh_io_type type, void *opts,
 					mesh_ready_func_t cb, void *user_data)
 {
 	struct mesh_io_caps caps;
@@ -175,6 +262,11 @@ bool mesh_init(const char *config_dir, enum mesh_io_type type, void *opts,
 
 	l_info("Loading node configuration from %s", storage_dir);
 
+	if (!mesh_conf_fname)
+		mesh_conf_fname = CONFIGDIR "/mesh-main.conf";
+
+	parse_settings(mesh_conf_fname);
+
 	if (!node_load_from_storage(storage_dir))
 		return false;
 
diff --git a/mesh/mesh.h b/mesh/mesh.h
index c72632b15..eb887723d 100644
--- a/mesh/mesh.h
+++ b/mesh/mesh.h
@@ -34,7 +34,8 @@ typedef void (*mesh_ready_func_t)(void *user_data, bool success);
 typedef void (*prov_rx_cb_t)(void *user_data, const uint8_t *data,
 								uint16_t len);
 
-bool mesh_init(const char *in_config_name, enum mesh_io_type type, void *opts,
+bool mesh_init(const char *config_dir, const char *mesh_conf_fname,
+					enum mesh_io_type type, void *opts,
 					mesh_ready_func_t cb, void *user_data);
 void mesh_cleanup(void);
 bool mesh_dbus_init(struct l_dbus *dbus);
@@ -46,3 +47,8 @@ bool mesh_reg_prov_rx(prov_rx_cb_t cb, void *user_data);
 void mesh_unreg_prov_rx(prov_rx_cb_t cb);
 const char *mesh_prov_status_str(uint8_t status);
 const char *mesh_get_storage_dir(void);
+bool mesh_beacon_enabled(void);
+bool mesh_relay_supported(void);
+bool mesh_friendship_supported(void);
+uint16_t mesh_get_crpl(void);
+uint8_t mesh_get_friend_queue_size(void);
diff --git a/mesh/node.c b/mesh/node.c
index f8acc78c3..e1d01d9b3 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -265,12 +265,14 @@ static void add_internal_model(struct mesh_node *node, uint32_t mod_id,
 
 static void set_defaults(struct mesh_node *node)
 {
-	/* TODO: these values should come from mesh.conf */
 	node->lpn = MESH_MODE_UNSUPPORTED;
 	node->proxy = MESH_MODE_UNSUPPORTED;
-	node->friend = MESH_MODE_UNSUPPORTED;
-	node->beacon = MESH_MODE_DISABLED;
-	node->relay.mode = MESH_MODE_DISABLED;
+	node->friend = (mesh_friendship_supported()) ? MESH_MODE_DISABLED :
+							MESH_MODE_UNSUPPORTED;
+	node->beacon = (mesh_beacon_enabled()) ? MESH_MODE_ENABLED :
+							MESH_MODE_DISABLED;
+	node->relay.mode = (mesh_relay_supported()) ? MESH_MODE_DISABLED :
+							MESH_MODE_UNSUPPORTED;
 	node->ttl = TTL_MASK;
 	node->seq_number = DEFAULT_SEQUENCE_NUMBER;
 }
@@ -1299,7 +1301,7 @@ static bool get_app_properties(struct mesh_node *node, const char *path,
 	l_debug("path %s", path);
 
 	node->comp = l_new(struct node_composition, 1);
-	node->comp->crpl = DEFAULT_CRPL;
+	node->comp->crpl = mesh_get_crpl();
 
 	while (l_dbus_message_iter_next_entry(properties, &key, &variant)) {
 		if (!cid && !strcmp(key, "CompanyID")) {
-- 
2.21.0

