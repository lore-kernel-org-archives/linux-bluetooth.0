Return-Path: <SRS0=c51M=WD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617E5C433FF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Aug 2019 09:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC1221E6A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Aug 2019 09:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="cE2xEboD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbfHGJ6l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Aug 2019 05:58:41 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33778 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbfHGJ6l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Aug 2019 05:58:41 -0400
Received: by mail-lj1-f195.google.com with SMTP id h10so13419618ljg.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Aug 2019 02:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NXUBeWVSfxqvCGeZIPihMNcHl5jhtnbtgGlCyEVtT1A=;
        b=cE2xEboD7r1wLyH3ziTb1FAfhtzpjo/d7nTXag1wDYpirKDBSm2daZ0op1aQrkYpc2
         VxNlhfyQjd+V/aWwTJfZ42AV/uJA52FHaZI4zAPJGez6Pw0Zr3XDxdQnnNlUAY2Ex9Ib
         NzdMewjTE2UndPs3XAyv55nH5DCCgAgl381V59y8/eBoNyfv/1oalX4TlI/z4PxcNia2
         nsc21VounHzQcD7TX75mB+yd2dGbMC7HmSDlAzzcIsq0Om2GlODVcchWq0gum0DgmHyG
         xHAl6mWE8z0DoYN1DxaseTaJhM587JRXNTJvC38rp4wUO7Atkuf72mXKRUm0Y+Bk4PNd
         drZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NXUBeWVSfxqvCGeZIPihMNcHl5jhtnbtgGlCyEVtT1A=;
        b=jiKCW6X7/pfYb/l8HWI4CZdbwOWp1surVPIFdWC1HH/uNywUnCYG2YT9eluxM0q4ig
         ypAiHIf5PKX/Vy0QDqpUWBGieN3HEq47iUPdOd2RV0bIpZD6en+3BLn4zfLAYPi5hPs+
         NuO2tdSN5FDK+b5GdHm2qKhRxsbzZ7zxXCYpQtuWZ0ZNRVcGwbvo/Hl5QK62tzDDfcWT
         03ba/jrYhNhL5dFHAxVwIG9dxQZ4mRI89+Vt7uC8wfEoBs37KM498smJBQcNy8hJHi4D
         0NWp6FPr8iSDQPY6eQ+SQDZXTs5qW8QVJcsu84AeMIrqCKdwh9ok2uRhi/xQCSbvLRii
         jFVw==
X-Gm-Message-State: APjAAAX986KlrcZv7EI0fbLf6VfQwFKmm0qpl2OCvhpek9q0HcWmtmxp
        dRNf5/RF6jHwi7glFOshEXJF4/pVkrQ=
X-Google-Smtp-Source: APXvYqz/mlCbmHd6NuqiijMIG2L/IltPWJtbtG7aIgfQTDSQ72xq5AiR+wGj8a/4h7sD5dDjJVHALA==
X-Received: by 2002:a2e:9610:: with SMTP id v16mr4280308ljh.229.1565171918073;
        Wed, 07 Aug 2019 02:58:38 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id h1sm16247282lfj.21.2019.08.07.02.58.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 02:58:37 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Move sequence number overcommit to mesh-config-json
Date:   Wed,  7 Aug 2019 11:58:31 +0200
Message-Id: <20190807095831.13229-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This confines sequence overcommit logic in mesh-config-json, as other
storages might use a different mechanism to ensure reliability.

Also, refactored logic to calculate overcommit value to avoid division
by zero when messages are sent too fast.
---
 mesh/mesh-config-json.c | 70 +++++++++++++++++++++++++++++++++++++++--
 mesh/mesh-config.h      |  3 +-
 mesh/net.c              | 18 +++--------
 mesh/node.c             | 56 +++------------------------------
 mesh/node.h             |  6 ----
 5 files changed, 78 insertions(+), 75 deletions(-)

diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index d49f5226a..e3a804d35 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -31,6 +31,8 @@
 #include <string.h>
 #include <unistd.h>
 
+#include <sys/time.h>
+
 #include <ell/ell.h>
 #include <json-c/json.h>
 
@@ -38,12 +40,19 @@
 #include "mesh/util.h"
 #include "mesh/mesh-config.h"
 
+/* To prevent local node JSON cache thrashing, minimum update times */
+#define MIN_SEQ_CACHE_TRIGGER	32
+#define MIN_SEQ_CACHE_VALUE	(2 * 32)
+#define MIN_SEQ_CACHE_TIME	(5 * 60)
+
 #define CHECK_KEY_IDX_RANGE(x) (((x) >= 0) && ((x) <= 4095))
 
 struct mesh_config {
 	json_object *jnode;
 	char *node_dir_path;
 	uint8_t uuid[16];
+	uint32_t write_seq;
+	struct timeval write_time;
 };
 
 struct write_info {
@@ -1708,6 +1717,8 @@ static struct mesh_config *create_config(const char *cfg_path,
 	cfg->jnode = jnode;
 	memcpy(cfg->uuid, uuid, 16);
 	cfg->node_dir_path = l_strdup(cfg_path);
+	cfg->write_seq = node->seq_number;
+	gettimeofday(&cfg->write_time, NULL);
 
 	return cfg;
 }
@@ -2020,12 +2031,59 @@ bool mesh_config_model_sub_del_all(struct mesh_config *cfg, uint16_t addr,
 	return save_config(cfg->jnode, cfg->node_dir_path);
 }
 
-bool mesh_config_write_seq_number(struct mesh_config *cfg, uint32_t seq)
+bool mesh_config_write_seq_number(struct mesh_config *cfg, uint32_t seq,
+								bool cache)
 {
-	if (!cfg || !write_int(cfg->jnode, "sequenceNumber", seq))
+	int value;
+	uint32_t cached = 0;
+
+	if (!cfg)
 		return false;
 
-	mesh_config_save(cfg, false, NULL, NULL);
+	if (!cache) {
+		if (!write_int(cfg->jnode, "sequenceNumber", seq))
+		    return false;
+
+		return mesh_config_save(cfg, true, NULL, NULL);
+	}
+
+	if (get_int(cfg->jnode, "sequenceNumber", &value))
+		cached = (uint32_t)value;
+
+	/*
+	 * When sequence number approaches value stored on disk, calculate
+	 * average time between sequence number updates, then overcommit the
+	 * sequence number by MIN_SEQ_CACHE_TIME seconds worth of traffic or
+	 * MIN_SEQ_CACHE_VALUE (whichever is greater) to avoid frequent writes
+	 * to disk and to protect against crashes.
+	 *
+	 * The real value will be saved when daemon shuts down properly.
+	*/
+	if (seq + MIN_SEQ_CACHE_TRIGGER >= cached) {
+		struct timeval now;
+		struct timeval elapsed;
+		uint64_t elapsed_ms;
+
+		gettimeofday(&now, NULL);
+		timersub(&now, &cfg->write_time, &elapsed);
+		elapsed_ms = elapsed.tv_sec * 1000 + elapsed.tv_usec / 1000;
+
+		cached = seq + (seq - cfg->write_seq) *
+					1000 * MIN_SEQ_CACHE_TIME / elapsed_ms;
+
+		if (cached < seq + MIN_SEQ_CACHE_VALUE)
+			cached = seq + MIN_SEQ_CACHE_VALUE;
+
+		l_debug("Seq Cache: %d -> %d", seq, cached);
+
+		cfg->write_seq = seq;
+
+		if (!write_int(cfg->jnode, "sequenceNumber", cached))
+		    return false;
+
+		return mesh_config_save(cfg, false, NULL, NULL);
+	}
+
 	return true;
 }
 
@@ -2089,6 +2147,9 @@ static bool load_node(const char *fname, const uint8_t uuid[16],
 		cfg->jnode = jnode;
 		memcpy(cfg->uuid, uuid, 16);
 		cfg->node_dir_path = l_strdup(fname);
+		cfg->write_seq = node.seq_number;
+		gettimeofday(&cfg->write_time, NULL);
+
 		result = cb(&node, uuid, cfg, user_data);
 
 		if (!result) {
@@ -2147,10 +2208,13 @@ static void idle_save_config(void *user_data)
 	l_free(fname_tmp);
 	l_free(fname_bak);
 
+	gettimeofday(&info->cfg->write_time, NULL);
+
 	if (info->cb)
 		info->cb(info->user_data, result);
 
 	l_free(info);
+
 }
 
 bool mesh_config_save(struct mesh_config *cfg, bool no_wait,
diff --git a/mesh/mesh-config.h b/mesh/mesh-config.h
index 44e3b3ad6..4172e794b 100644
--- a/mesh/mesh-config.h
+++ b/mesh/mesh-config.h
@@ -128,7 +128,8 @@ bool mesh_config_write_network_key(struct mesh_config *cfg, uint16_t idx,
 				uint8_t *key, uint8_t *new_key, int phase);
 bool mesh_config_write_app_key(struct mesh_config *cfg, uint16_t net_idx,
 			uint16_t app_idx, uint8_t *key, uint8_t *new_key);
-bool mesh_config_write_seq_number(struct mesh_config *cfg, uint32_t seq);
+bool mesh_config_write_seq_number(struct mesh_config *cfg, uint32_t seq,
+								bool cache);
 bool mesh_config_write_unicast(struct mesh_config *cfg, uint16_t unicast);
 bool mesh_config_write_relay_mode(struct mesh_config *cfg, uint8_t mode,
 					uint8_t count, uint16_t interval);
diff --git a/mesh/net.c b/mesh/net.c
index 7c92cfd5e..7c4049e0e 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -133,7 +133,6 @@ struct mesh_net {
 	uint32_t instant; /* Controller Instant of recent Rx */
 	uint32_t iv_index;
 	uint32_t seq_num;
-	uint32_t cached_seq_num;
 	uint16_t src_addr;
 	uint16_t last_addr;
 	uint16_t friend_addr;
@@ -503,17 +502,8 @@ void mesh_friend_sub_del(struct mesh_net *net, uint16_t lpn,
 
 uint32_t mesh_net_next_seq_num(struct mesh_net *net)
 {
-	uint32_t seq = net->seq_num;
-
-	net->seq_num++;
-
-	/* Periodically store advanced sequence number */
-	if (net->seq_num + MIN_SEQ_TRIGGER >= net->cached_seq_num) {
-		net->cached_seq_num = net->seq_num +
-					node_seq_cache(net->node);
-		node_set_sequence_number(net->node, net->cached_seq_num);
-	}
-
+	uint32_t seq = net->seq_num++;
+	node_set_sequence_number(net->node, net->seq_num);
 	return seq;
 }
 
@@ -722,12 +712,12 @@ void mesh_net_free(struct mesh_net *net)
 	l_free(net);
 }
 
-bool mesh_net_set_seq_num(struct mesh_net *net, uint32_t number)
+bool mesh_net_set_seq_num(struct mesh_net *net, uint32_t seq)
 {
 	if (!net)
 		return false;
 
-	net->cached_seq_num = net->seq_num = number;
+	net->seq_num = seq;
 
 	return true;
 }
diff --git a/mesh/node.c b/mesh/node.c
index bff73cfc7..e7e58d9a7 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -25,8 +25,6 @@
 #include <dirent.h>
 #include <stdio.h>
 
-#include <sys/time.h>
-
 #include <ell/ell.h>
 
 #include "mesh/mesh-defs.h"
@@ -90,9 +88,7 @@ struct mesh_node {
 	struct mesh_config *cfg;
 	char *storage_dir;
 	uint32_t disc_watch;
-	time_t upd_sec;
 	uint32_t seq_number;
-	uint32_t seq_min_cache;
 	bool provisioner;
 	uint16_t primary;
 	struct node_composition *comp;
@@ -560,15 +556,11 @@ static void cleanup_node(void *data)
 	struct mesh_node *node = data;
 	struct mesh_net *net = node->net;
 
-	/* Save local node configuration */
-	if (node->cfg) {
-
-		/* Preserve the last sequence number */
+	/* Preserve the last sequence number */
+	if (node->cfg)
 		mesh_config_write_seq_number(node->cfg,
-						mesh_net_get_seq_num(net));
-
-		mesh_config_save(node->cfg, true, NULL, NULL);
-	}
+						mesh_net_get_seq_num(net),
+						false);
 
 	free_node_resources(node);
 }
@@ -704,42 +696,12 @@ bool node_default_ttl_set(struct mesh_node *node, uint8_t ttl)
 
 bool node_set_sequence_number(struct mesh_node *node, uint32_t seq)
 {
-	struct timeval write_time;
-
 	if (!node)
 		return false;
 
 	node->seq_number = seq;
 
-	/*
-	 * Holistically determine worst case 5 minute sequence consumption
-	 * so that we typically (once we reach a steady state) rewrite the
-	 * local node file with a new seq cache value no more than once every
-	 * five minutes (or more)
-	 */
-	gettimeofday(&write_time, NULL);
-	if (node->upd_sec) {
-		uint32_t elapsed = write_time.tv_sec - node->upd_sec;
-
-		if (elapsed < MIN_SEQ_CACHE_TIME) {
-			uint32_t ideal = node->seq_min_cache;
-
-			l_debug("Old Seq Cache: %d", node->seq_min_cache);
-
-			ideal *= (MIN_SEQ_CACHE_TIME / elapsed);
-
-			if (ideal > node->seq_min_cache + MIN_SEQ_CACHE)
-				node->seq_min_cache = ideal;
-			else
-				node->seq_min_cache += MIN_SEQ_CACHE;
-
-			l_debug("New Seq Cache: %d", node->seq_min_cache);
-		}
-	}
-
-	node->upd_sec = write_time.tv_sec;
-
-	return mesh_config_write_seq_number(node->cfg, seq);
+	return mesh_config_write_seq_number(node->cfg, node->seq_number, true);
 }
 
 uint32_t node_get_sequence_number(struct mesh_node *node)
@@ -750,14 +712,6 @@ uint32_t node_get_sequence_number(struct mesh_node *node)
 	return node->seq_number;
 }
 
-uint32_t node_seq_cache(struct mesh_node *node)
-{
-	if (node->seq_min_cache < MIN_SEQ_CACHE)
-		node->seq_min_cache = MIN_SEQ_CACHE;
-
-	return node->seq_min_cache;
-}
-
 int node_get_element_idx(struct mesh_node *node, uint16_t ele_addr)
 {
 	uint16_t addr;
diff --git a/mesh/node.h b/mesh/node.h
index a4cac028d..be57d5e67 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -24,11 +24,6 @@ struct mesh_agent;
 struct mesh_config;
 struct mesh_config_node;
 
-/* To prevent local node JSON cache thrashing, minimum update times */
-#define MIN_SEQ_TRIGGER	32
-#define MIN_SEQ_CACHE		(2*MIN_SEQ_TRIGGER)
-#define MIN_SEQ_CACHE_TIME	(5*60)
-
 typedef void (*node_ready_func_t) (void *user_data, int status,
 							struct mesh_node *node);
 
@@ -82,7 +77,6 @@ bool node_beacon_mode_set(struct mesh_node *node, bool enable);
 uint8_t node_beacon_mode_get(struct mesh_node *node);
 bool node_friend_mode_set(struct mesh_node *node, bool enable);
 uint8_t node_friend_mode_get(struct mesh_node *node);
-uint32_t node_seq_cache(struct mesh_node *node);
 const char *node_get_element_path(struct mesh_node *node, uint8_t ele_idx);
 const char *node_get_owner(struct mesh_node *node);
 const char *node_get_app_path(struct mesh_node *node);
-- 
2.19.1

