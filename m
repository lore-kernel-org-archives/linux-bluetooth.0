Return-Path: <SRS0=XQ0Y=TI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C17C04A6B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 May 2019 14:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC4821530
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 May 2019 14:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="DzoF4INi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfEHOYz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 May 2019 10:24:55 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44857 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbfEHOYz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 May 2019 10:24:55 -0400
Received: by mail-lf1-f66.google.com with SMTP id n134so12859266lfn.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 May 2019 07:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nuec9enc1arD8jbqK30nkpQm2U71lsm20rUCd3iwhgs=;
        b=DzoF4INi2+ekox8AhE+MuQ79kaiaymAqm+d33yjAsE4tAaiX+wIvs5+797zOqbAQti
         SQAgLVDDWMUPmzIAhEx6tvIQJ3xYGZaHFMk38D+4OTSIc5DUVz6XzDdgpZHk1QiG54Sc
         7k135C1P4M3ZcOE8nhBk4Uq2ipTd5kH68mHZ8OVh9gkjDUdkPAGzBYGzLLiUblLIZv5h
         s/zDvJyZp3BK1QlBgPQkQeOOAlTHX2XFePI3Q9GxPgrA4i04X4rCvzXoOKDWj1QOtlkw
         3IzwFOBRCyE0s7hiVM72S8oUBWPhxWI8jLzStLTSPxIPWR3InSKpdlxxcHpLc+uwFeuD
         EOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nuec9enc1arD8jbqK30nkpQm2U71lsm20rUCd3iwhgs=;
        b=E6cfdDdHHbekSVWnM4Q9lRGZfKqk+fS3DxPbfMtZO4q09HT7euG8EnLVdwUb6raLG1
         SAi/inARa72Tp5+mLbRU4lR2NqO9bKtjNXPXNuQswfaW5hMYhrjfZZxLax92r97IMjqP
         bzftAeQn0PfWMhOL/FAZP2NZygf0pli0NNrCNjHBewouWN9P9WvFKMEnF13+HT+AE/Ye
         KzZCJwUzBa8/g792thUMeTYEY0wue2P8KOk3jIbXCFUKi8quJ0P0n6Z50bH2Niic3Lgb
         muPTQkC3EiHjQDvIXhqRAxAfRp6S35C3SFjuE6aRYxQi2/JTP+wIg9eytmT3CtPaRaq8
         Ca2g==
X-Gm-Message-State: APjAAAX9GQQCaqSEb9NxiNKkCV9wiqwmyJ0NMcD9BW+3UvAUYdu1FFgW
        Y6UmQvZB1EtPHAjgjUO13Vhn41mp3fo=
X-Google-Smtp-Source: APXvYqxPiXNGZKZXFToL7vF7sIxb5krbLdIajh6d0a7u84l9j5V+5oWrBIyWcxarZbIL9O0QM94lgQ==
X-Received: by 2002:ac2:494f:: with SMTP id o15mr11602418lfi.22.1557325492260;
        Wed, 08 May 2019 07:24:52 -0700 (PDT)
Received: from scytale.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id v26sm2991939ljh.11.2019.05.08.07.24.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 07:24:51 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v3 1/1] mesh: Use node uuids as storage directory names
Date:   Wed,  8 May 2019 16:24:45 +0200
Message-Id: <20190508142445.4508-2-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190508142445.4508-1-michal.lowas-rzechonek@silvair.com>
References: <20190508142445.4508-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Instead of keeping track of unique 16bit node identifiers, reuse their
UUIDs to create both storage directories and dbus objects.

Because of that:
 - UUID is no longer stored in the JSON file, it's inferred from the
   directory name instead
 - Join(), CreateNetwork() and ImportLocalNode() APIs return an error if
   given UUID already registered within the daemon
---
 doc/mesh-api.txt | 26 ++++++++++---
 mesh/README      |  7 ++--
 mesh/mesh-db.c   |  4 --
 mesh/mesh-db.h   |  1 -
 mesh/mesh.c      |  7 ++++
 mesh/node.c      | 38 ++++++-------------
 mesh/node.h      |  2 +-
 mesh/storage.c   | 96 +++++++++++++++---------------------------------
 8 files changed, 72 insertions(+), 109 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index 81d1a3288..112990a5d 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -24,10 +24,14 @@ Methods:
 		DBus.ObjectManager interface must be available on the
 		app_defined_root path.
 
-		The uuid parameter is a 16-byte array that contains Device UUID.
+		The uuid parameter is a 16-byte array that contains Device UUID. This
+		UUID must be unique (at least from the daemon perspective), therefore
+		attempting to call this function using already registered UUID results
+		in an error.
 
 		PossibleErrors:
 			org.bluez.mesh.Error.InvalidArguments
+			org.bluez.mesh.Error.AlreadyExists,
 
 	void Cancel(void)
 
@@ -127,7 +131,10 @@ Methods:
 		interface. The standard DBus.ObjectManager interface must be
 		available on the app_root path.
 
-		The uuid parameter is a 16-byte array that contains Device UUID.
+		The uuid parameter is a 16-byte array that contains Device UUID. This
+		UUID must be unique (at least from the daemon perspective), therefore
+		attempting to call this function using already registered UUID results
+		in an error.
 
 		The returned token must be preserved by the application in
 		order to authenticate itself to the mesh daemon and attach to
@@ -142,6 +149,7 @@ Methods:
 
 		PossibleErrors:
 			org.bluez.mesh.Error.InvalidArguments
+			org.bluez.mesh.Error.AlreadyExists,
 
 	 uint64 token ImportLocalNode(string json_data)
 
@@ -160,8 +168,12 @@ Methods:
 		permanently remove the identity of the mesh node by calling
 		Leave() method.
 
+		It is an error to attempt importing a node with already registered
+		Device UUID.
+
 		PossibleErrors:
 			org.bluez.mesh.Error.InvalidArguments,
+			org.bluez.mesh.Error.AlreadyExists
 			org.bluez.mesh.Error.NotFound,
 			org.bluez.mesh.Error.Failed
 
@@ -169,8 +181,9 @@ Mesh Node Hierarchy
 ===================
 Service		org.bluez.mesh
 Interface	org.bluez.mesh.Node1
-Object path	/org/bluez/mesh/node<xxxx>
-		where xxxx is a 4-digit hexadecimal number generated by daemon
+Object path	/org/bluez/mesh/node<uuid>
+		where <uuid> is the Device UUID passed to Join(), CreateNetwork() or
+		ImportLocalNode()
 
 Methods:
 	void Send(object element_path, uint16 destination, uint16 key_index,
@@ -334,8 +347,9 @@ Mesh Provisioning Hierarchy
 ============================
 Service		org.bluez.mesh
 Interface	org.bluez.mesh.Management1
-Object path	/org/bluez/mesh/node<xxxx>
-		where xxxx is a 4-digit hexadecimal number generated by daemon
+Object path	/org/bluez/mesh/node<uuid>
+		where <uuid> is the Device UUID passed to Join(), CreateNetwork() or
+		ImportLocalNode()
 
 Methods:
 	void UnprovisionedScan(uint16 seconds)
diff --git a/mesh/README b/mesh/README
index 151a1e6a1..ca223a6d8 100644
--- a/mesh/README
+++ b/mesh/README
@@ -26,9 +26,8 @@ Storage
 Default storage directory is /var/lib/bluetooth/mesh.
 
 The directory contains the provisioned nodes configurations.
-Each node has its own subdirectory, named with a 4-digit (hexadecimal)
-identificator that is internally generated by the mesh daemon at the time
-of the node provisioning.
+Each node has its own subdirectory, named after node's Device UUID (32-digit
+hexadecimal string) that is generated by the application that created a node.
 
 Each subdirectory contains the following files:
 	- node.json:
@@ -47,4 +46,4 @@ Mailing lists:
 	linux-bluetooth@vger.kernel.org
 
 For additional information about the project visit BlueZ web site:
-	http://www.bluez.org
\ No newline at end of file
+	http://www.bluez.org
diff --git a/mesh/mesh-db.c b/mesh/mesh-db.c
index 64e33cd91..01ae63146 100644
--- a/mesh/mesh-db.c
+++ b/mesh/mesh-db.c
@@ -1466,10 +1466,6 @@ bool mesh_db_add_node(json_object *jnode, struct mesh_db_node *node) {
 	if (!mesh_db_write_uint16_hex(jnode, "crpl", node->crpl))
 		return false;
 
-	/* Device UUID */
-	if (!add_key_value(jnode, "UUID", node->uuid))
-		return false;
-
 	/* Features: relay, LPN, friend, proxy*/
 	if (!mesh_db_write_relay_mode(jnode, modes->relay.state,
 						modes->relay.cnt,
diff --git a/mesh/mesh-db.h b/mesh/mesh-db.h
index 06aba1f31..19913148e 100644
--- a/mesh/mesh-db.h
+++ b/mesh/mesh-db.h
@@ -76,7 +76,6 @@ struct mesh_db_node {
 	uint16_t unicast;
 	uint8_t ttl;
 	struct l_queue *elements;
-	uint8_t uuid[16];
 };
 
 struct mesh_db_prov {
diff --git a/mesh/mesh.c b/mesh/mesh.c
index a084f9200..4d65f266a 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -577,6 +577,13 @@ static struct l_dbus_message *join_network_call(struct l_dbus *dbus,
 							"Bad device UUID");
 	}
 
+	if (node_find_by_uuid(join_pending->uuid)) {
+		l_free(join_pending);
+		join_pending = NULL;
+		return dbus_error(msg, MESH_ERROR_ALREADY_EXISTS,
+							"Node already exists");
+	}
+
 	sender = l_dbus_message_get_sender(msg);
 
 	join_pending->sender = l_strdup(sender);
diff --git a/mesh/node.c b/mesh/node.c
index 774d03d45..5904b116c 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -21,6 +21,7 @@
 #include <config.h>
 #endif
 
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <sys/time.h>
 #include <ell/ell.h>
@@ -83,7 +84,6 @@ struct mesh_node {
 	time_t upd_sec;
 	uint32_t seq_number;
 	uint32_t seq_min_cache;
-	uint16_t id;
 	bool provisioner;
 	uint16_t primary;
 	struct node_composition *comp;
@@ -92,7 +92,7 @@ struct mesh_node {
 		uint8_t cnt;
 		uint8_t mode;
 	} relay;
-	uint8_t dev_uuid[16];
+	uint8_t uuid[16];
 	uint8_t dev_key[16];
 	uint8_t token[8];
 	uint8_t num_ele;
@@ -126,7 +126,7 @@ static bool match_device_uuid(const void *a, const void *b)
 	const struct mesh_node *node = a;
 	const uint8_t *uuid = b;
 
-	return (memcmp(node->dev_uuid, uuid, 16) == 0);
+	return (memcmp(node->uuid, uuid, 16) == 0);
 }
 
 static bool match_token(const void *a, const void *b)
@@ -187,15 +187,16 @@ uint8_t *node_uuid_get(struct mesh_node *node)
 {
 	if (!node)
 		return NULL;
-	return node->dev_uuid;
+	return node->uuid;
 }
 
-struct mesh_node *node_new(void)
+struct mesh_node *node_new(const uint8_t uuid[16])
 {
 	struct mesh_node *node;
 
 	node = l_new(struct mesh_node, 1);
 	node->net = mesh_net_new(node);
+	memcpy(node->uuid, uuid, sizeof(node->uuid));
 
 	if (!nodes)
 		nodes = l_queue_new();
@@ -382,8 +383,6 @@ bool node_init_from_storage(struct mesh_node *node, void *data)
 
 	node->primary = db_node->unicast;
 
-	memcpy(node->dev_uuid, db_node->uuid, 16);
-
 	/* Initialize configuration server model */
 	mesh_config_srv_init(node, PRIMARY_ELE_IDX);
 
@@ -973,20 +972,6 @@ fail:
 	return false;
 }
 
-void node_id_set(struct mesh_node *node, uint16_t id)
-{
-	if (node)
-		node->id = id;
-}
-
-uint16_t node_id_get(struct mesh_node *node)
-{
-	if (!node)
-		return 0;
-
-	return node->id;
-}
-
 static void attach_io(void *a, void *b)
 {
 	struct mesh_node *node = a;
@@ -1005,9 +990,12 @@ void node_attach_io(struct mesh_io *io)
 /* Register node object with D-Bus */
 static bool register_node_object(struct mesh_node *node)
 {
-	node->path = l_malloc(strlen(MESH_NODE_PATH_PREFIX) + 5);
+	char uuid[33];
 
-	snprintf(node->path, 10, MESH_NODE_PATH_PREFIX "%4.4x", node->id);
+	if (!hex2str(node->uuid, sizeof(node->uuid), uuid, sizeof(uuid)))
+		return false;
+
+	node->path = l_strdup_printf(MESH_NODE_PATH_PREFIX "%s", uuid);
 
 	if (!l_dbus_object_add_interface(dbus_get_bus(), node->path,
 					MESH_NODE_INTERFACE, node))
@@ -1232,8 +1220,6 @@ static void convert_node_to_storage(struct mesh_node *node,
 	db_node->modes.lpn = node->lpn;
 	db_node->modes.proxy = node->proxy;
 
-	memcpy(db_node->uuid, node->dev_uuid, 16);
-
 	db_node->modes.friend = node->friend;
 	db_node->modes.relay.state = node->relay.mode;
 	db_node->modes.relay.cnt = node->relay.cnt;
@@ -1469,7 +1455,7 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 		}
 		node->num_ele = num_ele;
 		set_defaults(node);
-		memcpy(node->dev_uuid, req->data, 16);
+		memcpy(node->uuid, req->data, 16);
 
 		if (!create_node_config(node))
 			goto fail;
diff --git a/mesh/node.h b/mesh/node.h
index 20b60099e..1be4de1da 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -33,7 +33,7 @@ typedef void (*node_ready_func_t) (void *user_data, int status,
 typedef void (*node_join_ready_func_t) (struct mesh_node *node,
 						struct mesh_agent *agent);
 
-struct mesh_node *node_new(void);
+struct mesh_node *node_new(const uint8_t uuid[16]);
 void node_remove(struct mesh_node *node);
 void node_join(const char *app_path, const char *sender, const uint8_t *uuid,
 						node_join_ready_func_t cb);
diff --git a/mesh/storage.c b/mesh/storage.c
index 8a70b5696..2580cbe7f 100644
--- a/mesh/storage.c
+++ b/mesh/storage.c
@@ -45,6 +45,7 @@
 #include "mesh/model.h"
 #include "mesh/mesh-db.h"
 #include "mesh/storage.h"
+#include "mesh/util.h"
 
 struct write_info {
 	json_object *jnode;
@@ -54,12 +55,6 @@ struct write_info {
 };
 
 static const char *storage_dir;
-static struct l_queue *node_ids;
-
-static bool simple_match(const void *a, const void *b)
-{
-	return a == b;
-}
 
 static bool read_node_cb(struct mesh_db_node *db_node, void *user_data)
 {
@@ -171,7 +166,7 @@ static bool parse_node(struct mesh_node *node, json_object *jnode)
 	return true;
 }
 
-static bool parse_config(char *in_file, char *out_file, uint16_t node_id)
+static bool parse_config(char *in_file, char *out_file, const uint8_t uuid[16])
 {
 	int fd;
 	char *str;
@@ -208,7 +203,7 @@ static bool parse_config(char *in_file, char *out_file, uint16_t node_id)
 	if (!jnode)
 		goto done;
 
-	node = node_new();
+	node = node_new(uuid);
 
 	result = parse_node(node, jnode);
 
@@ -219,7 +214,6 @@ static bool parse_config(char *in_file, char *out_file, uint16_t node_id)
 
 	node_jconfig_set(node, jnode);
 	node_cfg_file_set(node, out_file);
-	node_id_set(node, node_id);
 
 done:
 	close(fd);
@@ -533,44 +527,35 @@ bool storage_load_nodes(const char *dir_name)
 	}
 
 	storage_dir = dir_name;
-	node_ids = l_queue_new();
 
 	while ((entry = readdir(dir)) != NULL) {
-		char name_buf[PATH_MAX];
-		char *filename;
-		uint32_t node_id;
-		size_t len;
+		char *cfg;
+		char *bak;
+		uint8_t uuid[16];
 
 		if (entry->d_type != DT_DIR)
 			continue;
 
-		if (sscanf(entry->d_name, "%04x", &node_id) != 1)
+		if (!str2hex(entry->d_name, strlen(entry->d_name), uuid, sizeof(uuid)))
 			continue;
 
-		snprintf(name_buf, PATH_MAX, "%s/%s/node.json", dir_name,
-								entry->d_name);
-
-		l_queue_push_tail(node_ids, L_UINT_TO_PTR(node_id));
+		cfg = l_strdup_printf("%s/%s/node.json", dir_name, entry->d_name);
 
-		len = strlen(name_buf);
-		filename = l_malloc(len + 1);
-
-		strncpy(filename, name_buf, len + 1);
-
-		if (parse_config(name_buf, filename, node_id))
+		if (parse_config(cfg, cfg, uuid))
 			continue;
 
 		/* Fall-back to Backup version */
-		snprintf(name_buf, PATH_MAX, "%s/%s/node.json.bak", dir_name,
-								entry->d_name);
+		bak = l_strdup_printf("%s/%s/node.json.bak", dir_name, entry->d_name);
 
-		if (parse_config(name_buf, filename, node_id)) {
-			remove(filename);
-			rename(name_buf, filename);
+		if (parse_config(bak, cfg, uuid)) {
+			remove(cfg);
+			rename(bak, cfg);
+			l_free(cfg);
 			continue;
 		}
 
-		l_free(filename);
+		l_free(cfg);
+		l_free(bak);
 	}
 
 	return true;
@@ -579,12 +564,10 @@ bool storage_load_nodes(const char *dir_name)
 bool storage_create_node_config(struct mesh_node *node, void *data)
 {
 	struct mesh_db_node *db_node = data;
-	uint16_t node_id;
-	uint8_t num_tries = 0;
+	char uuid[33];
 	char name_buf[PATH_MAX];
 	char *filename;
 	json_object *jnode;
-	size_t len;
 
 	if (!storage_dir)
 		return false;
@@ -594,28 +577,17 @@ bool storage_create_node_config(struct mesh_node *node, void *data)
 	if (!mesh_db_add_node(jnode, db_node))
 		return false;
 
-	do {
-		l_getrandom(&node_id, 2);
-		if (node_id && !l_queue_find(node_ids, simple_match,
-						L_UINT_TO_PTR(node_id)))
-			break;
-	} while (++num_tries < 10);
-
-	if (num_tries == 10)
-		l_error("Failed to generate unique node ID");
-
-	node_id_set(node, node_id);
+	if (!hex2str(node_uuid_get(node), 16, uuid, sizeof(uuid)))
+		return false;
 
-	snprintf(name_buf, PATH_MAX, "%s/%04x", storage_dir, node_id);
+	snprintf(name_buf, PATH_MAX, "%s/%s", storage_dir, uuid);
 
 	/* Create a new directory and node.json file */
 	if (mkdir(name_buf, 0755) != 0)
 		goto fail;
 
-	len = strlen(name_buf) + strlen("/node.json") + 1;
-	filename = l_malloc(len);
+	filename = l_strdup_printf("%s/node.json", name_buf);
 
-	snprintf(filename, len, "%s/node.json", name_buf);
 	l_debug("New node config %s", filename);
 
 	if (!save_config(jnode, filename)) {
@@ -626,8 +598,6 @@ bool storage_create_node_config(struct mesh_node *node, void *data)
 	node_jconfig_set(node, jnode);
 	node_cfg_file_set(node, filename);
 
-	l_queue_push_tail(node_ids, L_UINT_TO_PTR(node_id));
-
 	return true;
 fail:
 	json_object_put(jnode);
@@ -637,11 +607,9 @@ fail:
 /* Permanently remove node configuration */
 void storage_remove_node_config(struct mesh_node *node)
 {
-	char *cfgname;
+	char *cfg;
 	struct json_object *jnode;
 	const char *dir_name;
-	uint16_t node_id;
-	size_t len;
 	char *bak;
 
 	if (!node)
@@ -654,30 +622,24 @@ void storage_remove_node_config(struct mesh_node *node)
 	node_jconfig_set(node, NULL);
 
 	/* Delete node configuration file */
-	cfgname = (char *) node_cfg_file_get(node);
-	if (!cfgname)
+	cfg = node_cfg_file_get(node);
+	if (!cfg)
 		return;
 
-	l_debug("Delete node config file %s", cfgname);
-	remove(cfgname);
+	l_debug("Delete node config file %s", cfg);
+	remove(cfg);
 
 	/* Delete the backup file */
-	len = strlen(cfgname) + 5;
-	bak = l_malloc(len);
-	strncpy(bak, cfgname, len);
-	bak = strncat(bak, ".bak", 5);
+	bak = l_strdup_printf("%s.bak", cfg);
 	remove(bak);
 	l_free(bak);
 
 	/* Delete the node directory */
-	dir_name = dirname(cfgname);
+	dir_name = dirname(cfg);
 
 	l_debug("Delete directory %s", dir_name);
 	rmdir(dir_name);
 
-	l_free(cfgname);
+	l_free(cfg);
 	node_cfg_file_set(node, NULL);
-
-	node_id = node_id_get(node);
-	l_queue_remove(node_ids, L_UINT_TO_PTR(node_id));
 }
-- 
2.19.1

