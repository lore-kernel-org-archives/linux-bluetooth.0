Return-Path: <SRS0=r7wX=SZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6597C10F03
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Apr 2019 23:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73426218D2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Apr 2019 23:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfDWXQk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:16:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:13940 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfDWXQk (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Apr 2019 19:16:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Apr 2019 16:16:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,387,1549958400"; 
   d="scan'208";a="226089325"
Received: from bgix-dell-lap.sea.intel.com ([10.254.62.88])
  by orsmga001.jf.intel.com with ESMTP; 23 Apr 2019 16:16:39 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ] mesh: Add remote dev key support and cleanup
Date:   Tue, 23 Apr 2019 16:16:24 -0700
Message-Id: <20190423231624.19302-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If a local database of remote device keys exist, they will be used in
decryption attempts of received privledged messages. They will also
be cleaned up when local node storgae is deleted.
---
 mesh/model.c   |  13 +++++++-
 mesh/net.h     |   1 +
 mesh/node.c    |  49 ++++++++++++++++++++++++++++
 mesh/node.h    |   1 +
 mesh/storage.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++-----------
 mesh/storage.h |   2 ++
 6 files changed, 147 insertions(+), 20 deletions(-)

diff --git a/mesh/model.c b/mesh/model.c
index a632d80e1..032f25537 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -360,12 +360,23 @@ static int dev_packet_decrypt(struct mesh_node *node, const uint8_t *data,
 
 	dev_key = node_get_device_key(node);
 	if (!dev_key)
-		return false;
+		goto try_remote;
 
+	/* Always attempt decryption with local dev_key first */
 	if (mesh_crypto_payload_decrypt(NULL, 0, data, size, szmict, src,
 					dst, key_id, seq, iv_idx, out, dev_key))
 		return APP_IDX_DEV;
 
+try_remote:
+	/* Try remote device key if available */
+	dev_key = node_get_remote_device_key(node, src);
+	if (!dev_key)
+		return -1;
+
+	if (mesh_crypto_payload_decrypt(NULL, 0, data, size, szmict, src,
+					dst, key_id, seq, iv_idx, out, dev_key))
+		return APP_IDX_DEV_RMT;
+
 	return -1;
 }
 
diff --git a/mesh/net.h b/mesh/net.h
index e040e19fa..46f91f6b5 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -39,6 +39,7 @@ struct mesh_node;
 #define CREDFLAG_MASK	0x1000
 #define APP_IDX_MASK	0x0fff
 #define APP_IDX_DEV	0x7fff
+#define APP_IDX_DEV_RMT	0x6fff
 #define APP_IDX_ANY	0x8000
 #define APP_IDX_NET	0xffff
 
diff --git a/mesh/node.c b/mesh/node.c
index 157991dad..fe0488108 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -54,6 +54,8 @@
 #define DEFAULT_CRPL 10
 #define DEFAULT_SEQUENCE_NUMBER 0
 
+#define REMOTE_CACHE_LEN 5
+
 struct node_element {
 	char *path;
 	struct l_queue *models;
@@ -76,6 +78,7 @@ struct mesh_node {
 	char *path;
 	void *jconfig;
 	char *cfg_file;
+	struct l_queue *remotes;
 	uint32_t disc_watch;
 	time_t upd_sec;
 	uint32_t seq_number;
@@ -100,6 +103,11 @@ struct mesh_node {
 	uint8_t beacon;
 };
 
+struct remote_node {
+	uint16_t unicast;
+	uint8_t dev_key[16];
+};
+
 struct attach_obj_request {
 	node_attach_ready_func_t cb;
 	struct mesh_node *node;
@@ -112,6 +120,14 @@ struct join_obj_request {
 
 static struct l_queue *nodes;
 
+static bool match_remote_unicast(const void *a, const void *b)
+{
+	const struct remote_node *remote = a;
+	uint16_t unicast = L_PTR_TO_UINT(b);
+
+	return remote->unicast == unicast;
+}
+
 static bool match_node_unicast(const void *a, const void *b)
 {
 	const struct mesh_node *node = a;
@@ -454,6 +470,39 @@ const uint8_t *node_get_device_key(struct mesh_node *node)
 		return node->dev_key;
 }
 
+const uint8_t *node_get_remote_device_key(struct mesh_node *node, uint16_t src)
+{
+	struct remote_node *remote;
+
+	if (!node)
+		return NULL;
+
+	if (!node->remotes)
+		node->remotes = l_queue_new();
+
+	remote = l_queue_remove_if(node->remotes, match_remote_unicast,
+							L_UINT_TO_PTR(src));
+	if (remote) {
+		/* Keep most recently used at head */
+		l_queue_push_head(node->remotes, remote);
+		return remote->dev_key;
+	}
+
+	if (l_queue_length(node->remotes) >= REMOTE_CACHE_LEN) {
+		remote = l_queue_peek_tail(node->remotes);
+		l_queue_remove(node->remotes, remote);
+	} else
+		remote = l_new(struct remote_node, 1);
+
+	if (storage_get_remote_dev_key(node, src, remote->dev_key)) {
+		l_queue_push_head(node->remotes, remote);
+		return remote->dev_key;
+	}
+
+	l_free(remote);
+	return NULL;
+}
+
 void node_set_token(struct mesh_node *node, uint8_t token[8])
 {
 	memcpy(node->token, token, 8);
diff --git a/mesh/node.h b/mesh/node.h
index ebc82ffb8..8dc30855f 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -51,6 +51,7 @@ void node_set_token(struct mesh_node *node, uint8_t token[8]);
 const uint8_t *node_get_token(struct mesh_node *node);
 void node_set_device_key(struct mesh_node *node, uint8_t key[16]);
 const uint8_t *node_get_device_key(struct mesh_node *node);
+const uint8_t *node_get_remote_device_key(struct mesh_node *node, uint16_t src);
 void node_set_num_elements(struct mesh_node *node, uint8_t num_ele);
 uint8_t node_get_num_elements(struct mesh_node *node);
 bool node_parse_composition(struct mesh_node *node, uint8_t *buf, uint16_t len);
diff --git a/mesh/storage.c b/mesh/storage.c
index 8a70b5696..8aca12ee0 100644
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
+ * regardless of which underlying dirname implimentation is used
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
@@ -634,15 +649,65 @@ fail:
 	return false;
 }
 
+bool storage_get_remote_dev_key(struct mesh_node *node, uint16_t unicast,
+							uint8_t dev_key[16])
+{
+	char *cfgname, *dir_name;
+	char *key_file;
+	size_t len;
+	int fd;
+	bool result = false;
+
+	if (!node)
+		return false;
+
+	cfgname = (char *) node_cfg_file_get(node);
+	if (!cfgname)
+		return false;
+
+	dir_name = alloc_dirname(cfgname);
+
+	len = strlen(dir_name) + 9 + 5;
+	key_file = l_malloc(len);
+	snprintf(key_file, len, "%s%s%4.4x", dir_name, "/remotes/", unicast);
+	l_free(dir_name);
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
+	char *cfgname, *dir_name, *mesh_path, *mesh_name;
 	struct json_object *jnode;
-	const char *dir_name;
 	uint16_t node_id;
-	size_t len;
-	char *bak;
 
 	if (!node)
 		return;
@@ -658,26 +723,24 @@ void storage_remove_node_config(struct mesh_node *node)
 	if (!cfgname)
 		return;
 
-	l_debug("Delete node config file %s", cfgname);
-	remove(cfgname);
-
-	/* Delete the backup file */
-	len = strlen(cfgname) + 5;
-	bak = l_malloc(len);
-	strncpy(bak, cfgname, len);
-	bak = strncat(bak, ".bak", 5);
-	remove(bak);
-	l_free(bak);
+	dir_name = alloc_dirname(cfgname);
+	l_debug("Delete node config %s", dir_name);
 
-	/* Delete the node directory */
-	dir_name = dirname(cfgname);
+	/* Make sure path name of node follows expected guidelines */
+	mesh_path = alloc_dirname(dir_name);
+	mesh_name = basename(mesh_path);
+	if (strcmp(mesh_name, "mesh"))
+		goto done;
 
-	l_debug("Delete directory %s", dir_name);
-	rmdir(dir_name);
+	nftw(dir_name, del_fobject, 5, FTW_DEPTH | FTW_PHYS);
 
-	l_free(cfgname);
 	node_cfg_file_set(node, NULL);
 
 	node_id = node_id_get(node);
 	l_queue_remove(node_ids, L_UINT_TO_PTR(node_id));
+	l_free(cfgname);
+
+done:
+	l_free(dir_name);
+	l_free(mesh_path);
 }
diff --git a/mesh/storage.h b/mesh/storage.h
index d71d11b8e..6ed758b6e 100644
--- a/mesh/storage.h
+++ b/mesh/storage.h
@@ -49,3 +49,5 @@ bool storage_set_device_key(struct mesh_node *node, uint8_t dev_key[16]);
 bool storage_set_unicast(struct mesh_node *node, uint16_t unicast);
 bool storage_set_key_refresh_phase(struct mesh_net *net, uint16_t net_idx,
 								uint8_t phase);
+bool storage_get_remote_dev_key(struct mesh_node *node, uint16_t unicast,
+							uint8_t dev_key[16]);
-- 
2.14.5

