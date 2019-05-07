Return-Path: <SRS0=jYet=TH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A887C004C9
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 May 2019 17:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51397205ED
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 May 2019 17:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfEGR1L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 May 2019 13:27:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:60599 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbfEGR1K (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 May 2019 13:27:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 May 2019 10:27:09 -0700
X-ExtLoop1: 1
Received: from bgix-dell-lap.sea.intel.com ([10.255.87.84])
  by orsmga007.jf.intel.com with ESMTP; 07 May 2019 10:27:08 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ v4] mesh: Add key storage
Date:   Tue,  7 May 2019 10:27:01 -0700
Message-Id: <20190507172701.20726-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This implements internal key storage add/delete/fetch for the three
basic key types managed in Mesh: Network, Application and Device.

This key storage is separate from keys assigned to nodes within the
mesh, and are used to support Configuration Client functionality.
---
 Makefile.mesh  |   1 +
 mesh/README    |  35 ++++++-
 mesh/keyring.c | 315 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mesh/keyring.h |  49 +++++++++
 mesh/node.c    |  17 +++-
 mesh/node.h    |   2 +
 mesh/storage.c |  95 ++++++++++++-----
 mesh/storage.h |   2 +
 8 files changed, 485 insertions(+), 31 deletions(-)
 create mode 100644 mesh/keyring.c
 create mode 100644 mesh/keyring.h

diff --git a/Makefile.mesh b/Makefile.mesh
index 61fb40936..cefb72aed 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -25,6 +25,7 @@ mesh_sources = mesh/mesh.h mesh/mesh.c \
 				mesh/agent.h mesh/agent.c \
 				mesh/prov-acceptor.c mesh/prov-initiator.c \
 				mesh/pb-adv.h mesh/pb-adv.c \
+				mesh/keyring.h mesh/keyring.c \
 				mesh/mesh-defs.h
 libexec_PROGRAMS += mesh/bluetooth-meshd
 
diff --git a/mesh/README b/mesh/README
index 151a1e6a1..029e45068 100644
--- a/mesh/README
+++ b/mesh/README
@@ -37,8 +37,39 @@ Each subdirectory contains the following files:
 		provisioner/configuration client
 	- node.json.bak:
 		a backup that the last known good node configuration.
+	- seq_num:
+		File containing next sequence number to use
+	- seq_num.bak:
+		Backup of the Sequence number. This may be larger than the
+		actual sequence number being used at runtime, to prevent re-use 		of sequence numbers in the event of an unexpected restart.
+	- ./rpl/:
+		Directory to store the sequence numbers of remote nodes, as
+		required by Replay Protection List (RPL) parameters.
+		- xxxx:
+			Files named for remote Unicast addresses, and contain
+			last received iv_index + seq_num from each SRC address.
+	- ./dev_keys/:
+		Directory to store remote Device keys. This is only created/used
+		by Configuration Client (Network administration) nodes.
+		- xxxx:
+			Files named for remote Unicast addresses, and contains
+			16 octet key.
+	- ./net_keys/:
+		Directory to store network subnet keys. This is only
+		created/used by Configuration Client (Network administration)
+		nodes.
+		- xxx:
+			Files named for subnet index, and contains key refresh
+			phase, and old/new versions of the key.
+	- ./app_keys/:
+		Directory to store application keys. This is only created/used
+		by Configuration Client (Network administration) nodes.
+		- xxx:
+			Files named for application index, and contains bound
+			subnet index, and old/new versions of the key.
 
-The files are in JSON format.
+The node.json and node.json.bak are in JSON format. All other files are stored
+in little endian binary format.
 
 Information
 ===========
@@ -47,4 +78,4 @@ Mailing lists:
 	linux-bluetooth@vger.kernel.org
 
 For additional information about the project visit BlueZ web site:
-	http://www.bluez.org
\ No newline at end of file
+	http://www.bluez.org
diff --git a/mesh/keyring.c b/mesh/keyring.c
new file mode 100644
index 000000000..6fca047fd
--- /dev/null
+++ b/mesh/keyring.c
@@ -0,0 +1,315 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2019  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <dirent.h>
+#include <libgen.h>
+
+#include <ell/ell.h>
+
+#include "mesh/mesh-defs.h"
+
+#include "mesh/net.h"
+#include "mesh/storage.h"
+#include "mesh/keyring.h"
+#include "mesh/mesh.h"
+#include "mesh/node.h"
+
+const char *dev_key_dir = "dev_keys";
+const char *app_key_dir = "app_keys";
+const char *net_key_dir = "net_keys";
+
+bool keyring_put_net_key(struct mesh_node *node, uint16_t net_idx,
+						struct keyring_net_key *key)
+{
+	char *node_path;
+	char *key_file;
+	size_t len;
+	int fd;
+	bool result = false;
+
+	if (!node || !key)
+		return false;
+
+	node_path = storage_path_get(node);
+	len = strlen(node_path) + strlen(net_key_dir) + 2 + 4;
+	key_file = l_malloc(len);
+	snprintf(key_file, len, "%s/%s", node_path, net_key_dir);
+	storage_create_dir(key_file);
+	snprintf(key_file, len, "%s/%s/%3.3x", node_path, net_key_dir, net_idx);
+	l_debug("Put Net Key %s", key_file);
+
+	fd = open(key_file, O_WRONLY | O_CREAT | O_TRUNC);
+	if (fd) {
+		if (write(fd, key, sizeof(*key)) == sizeof(*key))
+			result = true;
+
+		close(fd);
+	}
+
+	l_free(key_file);
+	return result;
+}
+
+bool keyring_put_app_key(struct mesh_node *node, uint16_t app_idx,
+				uint16_t net_idx, struct keyring_app_key *key)
+{
+	char *node_path;
+	char *key_file;
+	size_t len;
+	int fd;
+	bool result = false;
+
+	if (!node || !key)
+		return false;
+
+	node_path = storage_path_get(node);
+	len = strlen(node_path) + strlen(app_key_dir) + 2 + 4;
+	key_file = l_malloc(len);
+	snprintf(key_file, len, "%s/%s", node_path, app_key_dir);
+	storage_create_dir(key_file);
+	snprintf(key_file, len, "%s/%s/%3.3x", node_path, app_key_dir, app_idx);
+	l_debug("Put App Key %s", key_file);
+
+	fd = open(key_file, O_RDONLY);
+	if (fd) {
+		struct keyring_app_key old_key;
+
+		if (read(fd, &old_key, sizeof(*key)) == sizeof(*key)) {
+			if (old_key.net_idx != net_idx) {
+				close(fd);
+				goto done;
+			}
+		}
+		close(fd);
+	}
+
+	fd = open(key_file, O_WRONLY | O_CREAT | O_TRUNC);
+	if (write(fd, key, sizeof(*key)) == sizeof(*key))
+		result = true;
+
+	close(fd);
+
+done:
+	l_free(key_file);
+	return result;
+}
+
+bool keyring_put_remote_dev_key(struct mesh_node *node, uint16_t unicast,
+					uint8_t count, uint8_t dev_key[16])
+{
+	char *node_path;
+	char *key_file;
+	size_t len;
+	int fd, i;
+	bool result = true;
+
+	if (!node)
+		return false;
+
+	node_path = storage_path_get(node);
+	len = strlen(node_path) + strlen(dev_key_dir) + 2 + 5;
+	key_file = l_malloc(len);
+	snprintf(key_file, len, "%s/%s", node_path, dev_key_dir);
+	storage_create_dir(key_file);
+
+	for (i = 0; i < count; i++) {
+		snprintf(key_file, len, "%s/%s/%4.4x", node_path, dev_key_dir,
+				unicast + i);
+		l_debug("Put Dev Key %s", key_file);
+
+		fd = open(key_file, O_WRONLY | O_CREAT | O_TRUNC);
+		if (fd) {
+			if (write(fd, dev_key, 16) != 16)
+				result = false;
+
+			close(fd);
+		} else
+			result = false;
+	}
+
+	l_free(key_file);
+	return result;
+}
+
+bool keyring_get_net_key(struct mesh_node *node, uint16_t net_idx,
+						struct keyring_net_key *key)
+{
+	char *node_path;
+	char *key_file;
+	size_t len;
+	int fd;
+	bool result = false;
+
+	if (!node || !key)
+		return false;
+
+	node_path = storage_path_get(node);
+	len = strlen(node_path) + strlen(net_key_dir) + 2 + 4;
+	key_file = l_malloc(len);
+	snprintf(key_file, len, "%s/%s/%3.3x", node_path, net_key_dir, net_idx);
+
+	fd = open(key_file, O_RDONLY);
+	if (fd) {
+		if (read(fd, key, sizeof(*key)) == sizeof(*key))
+			result = true;
+
+		close(fd);
+	}
+
+	l_free(key_file);
+	return result;
+}
+
+bool keyring_get_app_key(struct mesh_node *node, uint16_t app_idx,
+						struct keyring_app_key *key)
+{
+	char *node_path;
+	char *key_file;
+	size_t len;
+	int fd;
+	bool result = false;
+
+	if (!node || !key)
+		return false;
+
+	node_path = storage_path_get(node);
+	len = strlen(node_path) + strlen(app_key_dir) + 2 + 4;
+	key_file = l_malloc(len);
+	snprintf(key_file, len, "%s/%s/%3.3x", node_path, app_key_dir, app_idx);
+
+	fd = open(key_file, O_RDONLY);
+	if (fd) {
+		if (read(fd, key, sizeof(*key)) == sizeof(*key))
+			result = true;
+
+		close(fd);
+	}
+
+	l_free(key_file);
+	return result;
+}
+
+bool keyring_get_remote_dev_key(struct mesh_node *node, uint16_t unicast,
+							uint8_t dev_key[16])
+{
+	char *node_path;
+	char *key_file;
+	size_t len;
+	int fd;
+	bool result = false;
+
+	if (!node)
+		return false;
+
+	node_path = storage_path_get(node);
+	len = strlen(node_path) + strlen(dev_key_dir) + 2 + 5;
+	key_file = l_malloc(len);
+	snprintf(key_file, len, "%s/%s/%4.4x", node_path, dev_key_dir, unicast);
+
+	fd = open(key_file, O_RDONLY);
+	if (fd) {
+		if (read(fd, dev_key, 16) == 16)
+			result = true;
+
+		close(fd);
+	}
+
+	l_free(key_file);
+	return result;
+}
+
+bool keyring_del_net_key(struct mesh_node *node, uint16_t net_idx)
+{
+	char *node_path;
+	char *key_file;
+	size_t len;
+
+	if (!node)
+		return false;
+
+	node_path = storage_path_get(node);
+	len = strlen(node_path) + strlen(net_key_dir) + 2 + 4;
+	key_file = l_malloc(len);
+
+	snprintf(key_file, len, "%s/%s/%3.3x", node_path, net_key_dir, net_idx);
+	l_debug("RM Net Key %s", key_file);
+	remove(key_file);
+
+	/* TODO: See if it is easiest to delete all bound App keys here */
+	/* TODO: see nftw() */
+
+	l_free(key_file);
+	return true;
+}
+
+bool keyring_del_app_key(struct mesh_node *node, uint16_t app_idx)
+{
+	char *node_path;
+	char *key_file;
+	size_t len;
+
+	if (!node)
+		return false;
+
+	node_path = storage_path_get(node);
+	len = strlen(node_path) + strlen(app_key_dir) + 2 + 4;
+	key_file = l_malloc(len);
+
+	snprintf(key_file, len, "%s/%s/%3.3x", node_path, app_key_dir, app_idx);
+	l_debug("RM App Key %s", key_file);
+	remove(key_file);
+
+	l_free(key_file);
+	return true;
+}
+
+bool keyring_del_remote_dev_key(struct mesh_node *node, uint16_t unicast,
+								uint8_t count)
+{
+	char *node_path;
+	char *key_file;
+	size_t len;
+	int i;
+
+	if (!node)
+		return false;
+
+	node_path = storage_path_get(node);
+	len = strlen(node_path) + strlen(dev_key_dir) + 2 + 5;
+	key_file = l_malloc(len);
+
+	for (i = 0; i < count; i++) {
+		snprintf(key_file, len, "%s/%s/%4.4x", node_path, dev_key_dir,
+								unicast + i);
+		l_debug("RM Dev Key %s", key_file);
+		remove(key_file);
+	}
+
+	l_free(key_file);
+	return true;
+}
diff --git a/mesh/keyring.h b/mesh/keyring.h
new file mode 100644
index 000000000..167191013
--- /dev/null
+++ b/mesh/keyring.h
@@ -0,0 +1,49 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2019  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ */
+
+struct keyring_net_key {
+	uint16_t net_idx;
+	uint8_t phase;
+	uint8_t old_key[16];
+	uint8_t new_key[16];
+};
+
+struct keyring_app_key {
+	uint16_t app_idx;
+	uint16_t net_idx;
+	uint8_t old_key[16];
+	uint8_t new_key[16];
+};
+
+bool keyring_put_net_key(struct mesh_node *node, uint16_t net_idx,
+						struct keyring_net_key *key);
+bool keyring_get_net_key(struct mesh_node *node, uint16_t net_idx,
+						struct keyring_net_key *key);
+bool keyring_del_net_key(struct mesh_node *node, uint16_t net_idx);
+bool keyring_put_app_key(struct mesh_node *node, uint16_t app_idx,
+				uint16_t net_idx, struct keyring_app_key *key);
+bool keyring_get_app_key(struct mesh_node *node, uint16_t app_idx,
+						struct keyring_app_key *key);
+bool keyring_del_app_key(struct mesh_node *node, uint16_t app_idx);
+bool keyring_get_remote_dev_key(struct mesh_node *node, uint16_t unicast,
+							uint8_t dev_key[16]);
+bool keyring_put_remote_dev_key(struct mesh_node *node, uint16_t unicast,
+					uint8_t count, uint8_t dev_key[16]);
+bool keyring_del_remote_dev_key(struct mesh_node *node, uint16_t unicast,
+								uint8_t count);
diff --git a/mesh/node.c b/mesh/node.c
index 774d03d45..dc09a11f7 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -79,6 +79,7 @@ struct mesh_node {
 	char *path;
 	void *jconfig;
 	char *cfg_file;
+	char *node_path;
 	uint32_t disc_watch;
 	time_t upd_sec;
 	uint32_t seq_number;
@@ -235,6 +236,8 @@ static void free_node_resources(void *data)
 	l_free(node->comp);
 	l_free(node->app_path);
 	l_free(node->owner);
+	l_free(node->cfg_file);
+	l_free(node->node_path);
 
 	if (node->disc_watch)
 		l_dbus_remove_watch(dbus_get_bus(), node->disc_watch);
@@ -1875,7 +1878,8 @@ void *node_jconfig_get(struct mesh_node *node)
 
 void node_cfg_file_set(struct mesh_node *node, char *cfg)
 {
-	node->cfg_file = cfg;
+	l_free(node->cfg_file);
+	node->cfg_file = l_strdup(cfg);
 }
 
 char *node_cfg_file_get(struct mesh_node *node)
@@ -1883,6 +1887,17 @@ char *node_cfg_file_get(struct mesh_node *node)
 	return node->cfg_file;
 }
 
+void node_path_set(struct mesh_node *node, char *path)
+{
+	l_free(node->node_path);
+	node->node_path = l_strdup(path);
+}
+
+char *node_path_get(struct mesh_node *node)
+{
+	return node->node_path;
+}
+
 struct mesh_net *node_get_net(struct mesh_node *node)
 {
 	return node->net;
diff --git a/mesh/node.h b/mesh/node.h
index 20b60099e..d6a4cd96c 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -97,3 +97,5 @@ void node_jconfig_set(struct mesh_node *node, void *jconfig);
 void *node_jconfig_get(struct mesh_node *node);
 void node_cfg_file_set(struct mesh_node *node, char *cfg);
 char *node_cfg_file_get(struct mesh_node *node);
+void node_path_set(struct mesh_node *node, char *path);
+char *node_path_get(struct mesh_node *node);
diff --git a/mesh/storage.c b/mesh/storage.c
index 8a70b5696..799ed4734 100644
--- a/mesh/storage.c
+++ b/mesh/storage.c
@@ -28,6 +28,7 @@
 #include <unistd.h>
 #include <dirent.h>
 #include <libgen.h>
+#include <ftw.h>
 
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -61,6 +62,20 @@ static bool simple_match(const void *a, const void *b)
 	return a == b;
 }
 
+/* This is a thread-safe always malloced version of dirname which will work
+ * regardless of which underlying dirname() implementation is used.
+ */
+static char *alloc_dirname(const char *path)
+{
+	char *tmp = l_strdup(path);
+	char *dir;
+
+	dir = dirname(tmp);
+	strncpy(tmp, dir, strlen(path) + 1);
+
+	return tmp;
+}
+
 static bool read_node_cb(struct mesh_db_node *db_node, void *user_data)
 {
 	struct mesh_node *node = user_data;
@@ -483,7 +498,7 @@ void storage_save_config(struct mesh_node *node, bool no_wait,
 		l_idle_oneshot(idle_save_config, info, NULL);
 }
 
-static int create_dir(const char *dirname)
+int storage_create_dir(const char *dirname)
 {
 	struct stat st;
 	char dir[PATH_MAX + 1], *prev, *next;
@@ -524,7 +539,7 @@ bool storage_load_nodes(const char *dir_name)
 	DIR *dir;
 	struct dirent *entry;
 
-	create_dir(dir_name);
+	storage_create_dir(dir_name);
 	dir = opendir(dir_name);
 	if (!dir) {
 		l_error("Failed to open mesh node storage directory: %s",
@@ -634,15 +649,50 @@ fail:
 	return false;
 }
 
+char *storage_path_get(struct mesh_node *node)
+{
+	char *node_path = node_path_get(node);
+
+	if (!node_path) {
+		char *cfgname = (char *) node_cfg_file_get(node);
+
+		if (!cfgname)
+			return NULL;
+
+		node_path = alloc_dirname(cfgname);
+		node_path_set(node, node_path);
+		l_free(node_path);
+
+		return node_path_get(node);
+	}
+
+	return node_path;
+}
+
+static int del_fobject(const char *fpath, const struct stat *sb, int typeflag,
+						struct FTW *ftwbuf)
+{
+	switch (typeflag) {
+	case FTW_DP:
+		rmdir(fpath);
+		l_debug("RMDIR %s", fpath);
+		break;
+
+	case FTW_SL:
+	default:
+		remove(fpath);
+		l_debug("RM %s", fpath);
+		break;
+	}
+	return 0;
+}
+
 /* Permanently remove node configuration */
 void storage_remove_node_config(struct mesh_node *node)
 {
-	char *cfgname;
+	char *node_path, *mesh_path, *mesh_name;
 	struct json_object *jnode;
-	const char *dir_name;
 	uint16_t node_id;
-	size_t len;
-	char *bak;
 
 	if (!node)
 		return;
@@ -653,31 +703,20 @@ void storage_remove_node_config(struct mesh_node *node)
 		json_object_put(jnode);
 	node_jconfig_set(node, NULL);
 
-	/* Delete node configuration file */
-	cfgname = (char *) node_cfg_file_get(node);
-	if (!cfgname)
-		return;
-
-	l_debug("Delete node config file %s", cfgname);
-	remove(cfgname);
+	node_path = storage_path_get(node);
+	l_debug("Delete node config %s", node_path);
 
-	/* Delete the backup file */
-	len = strlen(cfgname) + 5;
-	bak = l_malloc(len);
-	strncpy(bak, cfgname, len);
-	bak = strncat(bak, ".bak", 5);
-	remove(bak);
-	l_free(bak);
-
-	/* Delete the node directory */
-	dir_name = dirname(cfgname);
-
-	l_debug("Delete directory %s", dir_name);
-	rmdir(dir_name);
+	/* Make sure path name of node follows expected guidelines */
+	mesh_path = alloc_dirname(node_path);
+	mesh_name = basename(mesh_path);
+	if (strcmp(mesh_name, "mesh"))
+		goto done;
 
-	l_free(cfgname);
-	node_cfg_file_set(node, NULL);
+	nftw(node_path, del_fobject, 5, FTW_DEPTH | FTW_PHYS);
 
 	node_id = node_id_get(node);
 	l_queue_remove(node_ids, L_UINT_TO_PTR(node_id));
+
+done:
+	l_free(mesh_path);
 }
diff --git a/mesh/storage.h b/mesh/storage.h
index d71d11b8e..4cfeaa7f4 100644
--- a/mesh/storage.h
+++ b/mesh/storage.h
@@ -49,3 +49,5 @@ bool storage_set_device_key(struct mesh_node *node, uint8_t dev_key[16]);
 bool storage_set_unicast(struct mesh_node *node, uint16_t unicast);
 bool storage_set_key_refresh_phase(struct mesh_net *net, uint16_t net_idx,
 								uint8_t phase);
+int storage_create_dir(const char *dirname);
+char *storage_path_get(struct mesh_node *node);
-- 
2.14.5

