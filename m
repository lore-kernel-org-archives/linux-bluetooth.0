Return-Path: <SRS0=qzIG=TC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16021C43219
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 May 2019 13:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A4E2085A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 May 2019 13:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="QAF2aLQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfEBNGk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 May 2019 09:06:40 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:38611 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfEBNGk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 May 2019 09:06:40 -0400
Received: by mail-lj1-f173.google.com with SMTP id e18so2115215lja.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 May 2019 06:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QtfQfZXQBcysn+kAPg+ce9u0WpqXrVVNLk+Y0DXMVO4=;
        b=QAF2aLQFswXbOTSOB4vlgtiiGjCSWkOXmTzG4JPX/mzNiYnCs0OuuBLYH3clrSlU58
         8kfG5ZvRuFHSuqSQIApKplLmrsyvEsei+157kiU+KRF4UcRhUoq2C2EPPEmoUzUfI6Cw
         i+0DcuMuhz5k8jf0ZDcNoN8rLJP1i1BmTm8SQJr1bwq4P5G7P54dWYlgDo/RnWU2DZUp
         sQdMBISBpQ94gqVd1nVbwCx2/A7i1wt0z2FLIyqeBCb5ykgDKO+ZOx1TzpBCsjcYkRIj
         uRYh8sBcHRnwucS6eOhdxLkl5a6ECo4t1RwOKLa5k2MuWnu57nSr6NjDi9RgtC5AqZG4
         i9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QtfQfZXQBcysn+kAPg+ce9u0WpqXrVVNLk+Y0DXMVO4=;
        b=HS0DeTUZpkDoWwD+3H8EWZ5bBLOBVlyXFt7U3AmFyRSGVye6x69vYHmLSS73y3kjjg
         u4sIUWsgLTu1VYrVkd5Qiq1gwL0KM8Al6H2pqxMC86/XngQFYhns8HVM5zH6SrhK036o
         NDqwiDD6jxDI5AbWKm0Tx3z9SAgePIrKn3ngKpF6c+t8GvV2GSnd3ecwMUYR/6t5WuLP
         15uMQTB2enTw7NXt+ESuVJgp9rnSwZ/rbFNZLwQMja2XCaz+qg1/6x7RKuCe4EB3gAVn
         BeHLOHeogZQCik4+jjM1k5mWlWS2LjOrewbYUSCThCakMAwQdhMqej4yko3C8BaC5ccd
         90ZA==
X-Gm-Message-State: APjAAAVDkb1cVmwnGq5koxIPsyJTnjEnvCS61NV51MoDzAqcrToczC8G
        rh/8Awe3zWuQb4Jwn58janHG5Oez3Zo=
X-Google-Smtp-Source: APXvYqwA4IVOl51fgYbCvxHawVYELU0CZpt/6R63OABV+jJlPm7RWLSgaB5yQ0T/XvMmHDeyV15nTw==
X-Received: by 2002:a2e:2d02:: with SMTP id t2mr1720880ljt.148.1556802395949;
        Thu, 02 May 2019 06:06:35 -0700 (PDT)
Received: from scytale.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id i66sm8787933lji.43.2019.05.02.06.06.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 06:06:35 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>,
        Brian Gix <brian.gix@intel.com>
Subject: [PATCH] mesh: Use node uuids as storage directory names
Date:   Thu,  2 May 2019 15:06:29 +0200
Message-Id: <20190502130630.13890-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Instead of keeping track of unique 16bit node identifiers, reuse their
UUIDs to create both storage directories and dbus objects.
---
 mesh/mesh-db.c |  40 +++++++++++-------
 mesh/mesh-db.h |   2 +-
 mesh/node.c    |  36 ++++++-----------
 mesh/storage.c | 107 ++++++++++++++++++-------------------------------
 4 files changed, 78 insertions(+), 107 deletions(-)

diff --git a/mesh/mesh-db.c b/mesh/mesh-db.c
index 64e33cd91..9d4349c29 100644
--- a/mesh/mesh-db.c
+++ b/mesh/mesh-db.c
@@ -51,6 +51,24 @@ static bool get_int(json_object *jobj, const char *keyword, int *value)
 	return true;
 }
 
+static bool get_hexstring(json_object *jobj, const char *keyword, uint8_t *buf, size_t buflen)
+{
+	json_object *jvalue;
+	char *str;
+
+	if (!buf)
+		return false;
+
+	if (!json_object_object_get_ex(jobj, keyword, &jvalue))
+		return false;
+
+	str = (char *)json_object_get_string(jvalue);
+	if (!str2hex(str, strlen(str), buf, buflen))
+		return false;
+
+	return true;
+}
+
 static bool add_u64_value(json_object *jobject, const char *desc,
 					const uint8_t u64[8])
 {
@@ -290,22 +308,9 @@ bool mesh_db_read_token(json_object *jobj, uint8_t token[8])
 	return true;
 }
 
-bool mesh_db_read_device_key(json_object *jobj, uint8_t key_buf[16])
+bool mesh_db_read_device_key(json_object *jobj, uint8_t key[16])
 {
-	json_object *jvalue;
-	char *str;
-
-	if (!key_buf)
-		return false;
-
-	if (!json_object_object_get_ex(jobj, "deviceKey", &jvalue))
-		return false;
-
-	str = (char *)json_object_get_string(jvalue);
-	if (!str2hex(str, strlen(str), key_buf, 16))
-		return false;
-
-	return true;
+	return get_hexstring(jobj, "deviceKey", key, 16);
 }
 
 bool mesh_db_read_app_keys(json_object *jobj, mesh_db_app_key_cb cb,
@@ -1188,6 +1193,11 @@ bool mesh_db_read_node(json_object *jnode, mesh_db_node_cb cb, void *user_data)
 		return false;
 	}
 
+	if (!get_hexstring(jnode, "UUID", node.uuid, sizeof(node.uuid))) {
+		l_info("Failed to parse UUID");
+		return false;
+	}
+
 	parse_features(jnode, &node);
 
 	if (!json_object_object_get_ex(jnode, "unicastAddress", &jvalue)) {
diff --git a/mesh/mesh-db.h b/mesh/mesh-db.h
index 06aba1f31..c4956717b 100644
--- a/mesh/mesh-db.h
+++ b/mesh/mesh-db.h
@@ -103,7 +103,7 @@ typedef bool (*mesh_db_node_cb)(struct mesh_db_node *node, void *user_data);
 bool mesh_db_read_node(json_object *jobj, mesh_db_node_cb cb, void *user_data);
 bool mesh_db_add_node(json_object *jnode, struct mesh_db_node *node);
 bool mesh_db_read_iv_index(json_object *jobj, uint32_t *idx, bool *update);
-bool mesh_db_read_device_key(json_object *jobj, uint8_t key_buf[16]);
+bool mesh_db_read_device_key(json_object *jobj, uint8_t key[16]);
 bool mesh_db_read_token(json_object *jobj, uint8_t token[8]);
 bool mesh_db_read_net_transmit(json_object *jobj, uint8_t *cnt,
 							uint16_t *interval);
diff --git a/mesh/node.c b/mesh/node.c
index 157991dad..60c5d386c 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -21,6 +21,7 @@
 #include <config.h>
 #endif
 
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <sys/time.h>
 #include <ell/ell.h>
@@ -80,7 +81,6 @@ struct mesh_node {
 	time_t upd_sec;
 	uint32_t seq_number;
 	uint32_t seq_min_cache;
-	uint16_t id;
 	bool provisioner;
 	uint16_t primary;
 	struct node_composition *comp;
@@ -89,7 +89,7 @@ struct mesh_node {
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
@@ -179,7 +179,7 @@ uint8_t *node_uuid_get(struct mesh_node *node)
 {
 	if (!node)
 		return NULL;
-	return node->dev_uuid;
+	return node->uuid;
 }
 
 struct mesh_node *node_new(void)
@@ -374,7 +374,7 @@ bool node_init_from_storage(struct mesh_node *node, void *data)
 
 	node->primary = db_node->unicast;
 
-	memcpy(node->dev_uuid, db_node->uuid, 16);
+	memcpy(node->uuid, db_node->uuid, 16);
 
 	/* Initialize configuration server model */
 	mesh_config_srv_init(node, PRIMARY_ELE_IDX);
@@ -965,20 +965,6 @@ fail:
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
@@ -996,9 +982,13 @@ void node_attach_io(struct mesh_io *io)
 
 static bool register_node_object(struct mesh_node *node)
 {
-	node->path = l_malloc(strlen(MESH_NODE_PATH_PREFIX) + 5);
+	char uuid[33];
 
-	snprintf(node->path, 10, MESH_NODE_PATH_PREFIX "%4.4x", node->id);
+	if (!hex2str(node->uuid, sizeof(node->uuid), uuid, sizeof(uuid)))
+		return false;
+
+	if (asprintf(&node->path, MESH_NODE_PATH_PREFIX "%s", uuid) < 0)
+		return false;
 
 	if (!l_dbus_object_add_interface(dbus_get_bus(), node->path,
 					MESH_NODE_INTERFACE, node))
@@ -1295,7 +1285,7 @@ static void convert_node_to_storage(struct mesh_node *node,
 	db_node->modes.lpn = node->lpn;
 	db_node->modes.proxy = node->proxy;
 
-	memcpy(db_node->uuid, node->dev_uuid, 16);
+	memcpy(db_node->uuid, node->uuid, 16);
 
 	db_node->modes.friend = node->friend;
 	db_node->modes.relay.state = node->relay.mode;
@@ -1468,7 +1458,7 @@ static void get_managed_objects_join_cb(struct l_dbus_message *msg,
 	}
 
 	set_defaults(node);
-	memcpy(node->dev_uuid, req->uuid, 16);
+	memcpy(node->uuid, req->uuid, 16);
 
 	if (!create_node_config(node))
 		goto fail;
diff --git a/mesh/storage.c b/mesh/storage.c
index 8a70b5696..c96d5a772 100644
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
+static bool parse_config(char *in_file, char *out_file)
 {
 	int fd;
 	char *str;
@@ -219,7 +214,6 @@ static bool parse_config(char *in_file, char *out_file, uint16_t node_id)
 
 	node_jconfig_set(node, jnode);
 	node_cfg_file_set(node, out_file);
-	node_id_set(node, node_id);
 
 done:
 	close(fd);
@@ -533,44 +527,41 @@ bool storage_load_nodes(const char *dir_name)
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
-
-		len = strlen(name_buf);
-		filename = l_malloc(len + 1);
-
-		strncpy(filename, name_buf, len + 1);
+		if (asprintf(&cfg, "%s/%s/node.json", dir_name,
+						entry->d_name) < 0)
+			continue;
 
-		if (parse_config(name_buf, filename, node_id))
+		if (parse_config(cfg, cfg))
 			continue;
 
 		/* Fall-back to Backup version */
-		snprintf(name_buf, PATH_MAX, "%s/%s/node.json.bak", dir_name,
-								entry->d_name);
+		if (asprintf(&bak, "%s/%s/node.json.bak", dir_name,
+						entry->d_name) < 0) {
+			l_free(cfg);
+			continue;
+		}
 
-		if (parse_config(name_buf, filename, node_id)) {
-			remove(filename);
-			rename(name_buf, filename);
+		if (parse_config(bak, cfg)) {
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
@@ -579,12 +570,10 @@ bool storage_load_nodes(const char *dir_name)
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
@@ -594,28 +583,18 @@ bool storage_create_node_config(struct mesh_node *node, void *data)
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
+	if (asprintf(&filename, "%s/node.json", name_buf) < 0)
+		goto fail;
 
-	snprintf(filename, len, "%s/node.json", name_buf);
 	l_debug("New node config %s", filename);
 
 	if (!save_config(jnode, filename)) {
@@ -626,8 +605,6 @@ bool storage_create_node_config(struct mesh_node *node, void *data)
 	node_jconfig_set(node, jnode);
 	node_cfg_file_set(node, filename);
 
-	l_queue_push_tail(node_ids, L_UINT_TO_PTR(node_id));
-
 	return true;
 fail:
 	json_object_put(jnode);
@@ -637,11 +614,9 @@ fail:
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
@@ -654,30 +629,26 @@ void storage_remove_node_config(struct mesh_node *node)
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
-	remove(bak);
-	l_free(bak);
+	if (asprintf(&bak, "%s.bak", cfg))
+	{
+		remove(bak);
+		l_free(bak);
+	}
 
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

