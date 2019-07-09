Return-Path: <SRS0=Cqm8=VG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F5DC606D7
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jul 2019 10:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382AE20645
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jul 2019 10:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="oof/BJlM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfGIKPj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Jul 2019 06:15:39 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:45174 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfGIKPj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Jul 2019 06:15:39 -0400
Received: by mail-lf1-f42.google.com with SMTP id u10so12995486lfm.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jul 2019 03:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qAQDm5FOmgwqxSAh5NfoytG7+02e8neejYklvrQr9k0=;
        b=oof/BJlM/5fhxGj84HCINh1ZtTCyBW51/Tq0wEIdBoncbciDsk/X+UKe5o5KXeQEtT
         tSJwfz9Xq5XIrCRX2TKKfn93OiVNBzNUoDi2tsIWq++J0gFM5X7TZhx8hgTP2qKP5Xst
         6BMj5rmFj539MRl8WbYdcMI5+Ad7o16QGY5/y5zyQH0WrhJx1a8EHl8DPKJEkUI0EO//
         LYkIpxOcIGvFqzGlM532ulcHb7p0bbXM/Qo7ARhURFBKsZTX/YzstxPjng4xfhOMMyFJ
         ksvLL6uJOo5sb3iducpBuOc8FVcorFV+WZOYmYCRy51shvl6LMUlAubzlhKGnB83pEp9
         2kRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qAQDm5FOmgwqxSAh5NfoytG7+02e8neejYklvrQr9k0=;
        b=KoWueLI6I7FMBWHKP6+tXFqdqKdWSq4Z+RnJ33alS14JCwPgqivfh1OFgg4gWjdZEq
         qwjrpVuqO7njdkf+fMXeoaEWqpmX4UaD0XUoHwj6mx/5W26hOw5FpH1TRDGV94qUpTEX
         SDpF8R16pd01DhNpRtzgXizhihu7x1ZPtNZ52zrUepErq3029YCusP1JbVpO6kNVbzbE
         /OypZw6KWD6fqpH3Uu3p69H8dJd58Nck3DPtREcFVxiDJDzvMWsK0B6CFusY7TDW/Ie3
         0F5CFqSZAdyoTFAl8tisPPD9CQZiXUTdbcKWB+QPIs72gdqvtld7VmM9XnR7R5OTveQI
         zylQ==
X-Gm-Message-State: APjAAAUq5B3cuJVibg/WUUN91gZtRRVWraadsB/D7Nz+HvOkFHLcAOLv
        PRVZlRcEWh7gkE/ZIC3wwz/JXfVf6KYtAw==
X-Google-Smtp-Source: APXvYqzx9syNBEE5FvKKFyOzm7zD488EZ47YPlgIJrNpu7MVO0y/NAtIev6bucJGGgIXN7QrtlFq7w==
X-Received: by 2002:a19:f703:: with SMTP id z3mr11182468lfe.171.1562667335178;
        Tue, 09 Jul 2019 03:15:35 -0700 (PDT)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id d15sm3168364lfq.76.2019.07.09.03.15.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 03:15:34 -0700 (PDT)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v4 4/4] mesh: Added ImportLocalNode call with its API
Date:   Tue,  9 Jul 2019 12:15:22 +0200
Message-Id: <20190709101522.10623-4-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190709101522.10623-1-jakub.witowski@silvair.com>
References: <20190709101522.10623-1-jakub.witowski@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This implements ImportLocalNode() method on org.bluez.mesh.Network1
interface. Invoking this method creates a self-provisioned node based on
passed JSON definition.
---
 mesh/cfgmod-server.c |   2 +-
 mesh/mesh-db.c       | 162 ++++++++++++++++++++++++++++++++++---------
 mesh/mesh-db.h       |  62 +++++++++++------
 mesh/mesh-defs.h     |   1 +
 mesh/mesh.c          |  91 +++++++++++++++++++++++-
 mesh/model.c         |   5 +-
 mesh/node.c          | 128 ++++++++++++++++++++++++++++------
 mesh/node.h          |   6 ++
 8 files changed, 377 insertions(+), 80 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index baf707222..eae53e076 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -1214,7 +1214,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 		gettimeofday(&time_now, NULL);
 		time_now.tv_sec -= hb->sub_start;
 
-		if (time_now.tv_sec >= (long int) hb->sub_period)
+		if (time_now.tv_sec >= (long) hb->sub_period)
 			time_now.tv_sec = 0;
 		else
 			time_now.tv_sec = hb->sub_period - time_now.tv_sec;
diff --git a/mesh/mesh-db.c b/mesh/mesh-db.c
index f50c68120..1c2b1d019 100644
--- a/mesh/mesh-db.c
+++ b/mesh/mesh-db.c
@@ -31,6 +31,7 @@
 
 #include "mesh/mesh-defs.h"
 #include "mesh/util.h"
+#include "mesh/net.h"
 
 #include "mesh/mesh-db.h"
 
@@ -104,8 +105,8 @@ static int get_element_index(struct json_object *jnode, uint16_t ele_addr)
 	return ele_addr - addr;
 }
 
-static struct json_object *get_element_model(struct json_object *jnode, int ele_idx,
-						uint32_t mod_id, bool vendor)
+static struct json_object *get_element_model(struct json_object *jnode,
+				int ele_idx, uint32_t mod_id, bool vendor)
 {
 	struct json_object *jelements, *jelement, *jmodels;
 	int i, num_mods;
@@ -178,8 +179,8 @@ static bool jarray_has_string(struct json_object *jarray, char *str, size_t len)
 	return false;
 }
 
-static struct json_object *jarray_string_del(struct json_object *jarray, char *str,
-								size_t len)
+static struct json_object *jarray_string_del(struct json_object *jarray,
+							char *str, size_t len)
 {
 	int i, sz = json_object_array_length(jarray);
 	struct json_object *jarray_new;
@@ -204,7 +205,8 @@ static struct json_object *jarray_string_del(struct json_object *jarray, char *s
 	return jarray_new;
 }
 
-static struct json_object *get_key_object(struct json_object *jarray, uint16_t idx)
+static struct json_object *get_key_object(struct json_object *jarray,
+								uint16_t idx)
 {
 	int i, sz = json_object_array_length(jarray);
 
@@ -225,7 +227,8 @@ static struct json_object *get_key_object(struct json_object *jarray, uint16_t i
 	return NULL;
 }
 
-static struct json_object *jarray_key_del(struct json_object *jarray, int16_t idx)
+static struct json_object *jarray_key_del(struct json_object *jarray,
+								int16_t idx)
 {
 	struct json_object *jarray_new;
 	int i, sz = json_object_array_length(jarray);
@@ -270,7 +273,8 @@ static bool mesh_db_read_unicast_address(struct json_object *jobj,
 }
 
 
-static bool mesh_db_read_seq_number(struct json_object *jobj, uint32_t *seq_number)
+static bool mesh_db_read_seq_number(struct json_object *jobj,
+							uint32_t *seq_number)
 {
 	struct json_object *jvalue;
 
@@ -281,7 +285,8 @@ static bool mesh_db_read_seq_number(struct json_object *jobj, uint32_t *seq_numb
 	return true;
 }
 
-bool mesh_db_read_iv_index(struct json_object *jobj, uint32_t *idx, bool *update)
+bool mesh_db_read_iv_index(struct json_object *jobj, uint32_t *idx,
+								bool *update)
 {
 	int tmp;
 
@@ -580,8 +585,8 @@ bool mesh_db_write_token(struct json_object *jnode, uint8_t *token)
 	return add_u64_value(jnode, "token", token);
 }
 
-bool mesh_db_app_key_add(struct json_object *jobj, uint16_t net_idx, uint16_t app_idx,
-							const uint8_t key[16])
+bool mesh_db_app_key_add(struct json_object *jobj, uint16_t net_idx,
+					uint16_t app_idx, const uint8_t key[16])
 {
 	struct json_object *jarray = NULL, *jentry = NULL, *jstring = NULL;
 	char buf[5];
@@ -658,7 +663,8 @@ bool mesh_db_app_key_update(struct json_object *jobj, uint16_t app_idx,
 	return add_key_value(jentry, "key", key);
 }
 
-bool mesh_db_app_key_del(struct json_object *jobj, uint16_t net_idx, uint16_t idx)
+bool mesh_db_app_key_del(struct json_object *jobj, uint16_t net_idx,
+								uint16_t idx)
 {
 	struct json_object *jarray, *jarray_new;
 
@@ -689,8 +695,8 @@ bool mesh_db_app_key_del(struct json_object *jobj, uint16_t net_idx, uint16_t id
 	return true;
 }
 
-bool mesh_db_model_binding_add(struct json_object *jnode, uint8_t ele_idx, bool vendor,
-				uint32_t mod_id, uint16_t app_idx)
+bool mesh_db_model_binding_add(struct json_object *jnode, uint8_t ele_idx,
+				bool vendor, uint32_t mod_id, uint16_t app_idx)
 {
 	struct json_object *jmodel, *jstring, *jarray = NULL;
 	char buf[5];
@@ -723,8 +729,8 @@ bool mesh_db_model_binding_add(struct json_object *jnode, uint8_t ele_idx, bool
 	return true;
 }
 
-bool mesh_db_model_binding_del(struct json_object *jnode, uint8_t ele_idx, bool vendor,
-				uint32_t mod_id, uint16_t app_idx)
+bool mesh_db_model_binding_del(struct json_object *jnode, uint8_t ele_idx,
+				bool vendor, uint32_t mod_id, uint16_t app_idx)
 {
 	struct json_object *jmodel, *jarray, *jarray_new;
 	char buf[5];
@@ -779,7 +785,8 @@ static void free_element(void *data)
 	l_free(ele);
 }
 
-static bool parse_bindings(struct json_object *jbindings, struct mesh_db_model *mod)
+static bool parse_bindings(struct json_object *jbindings,
+						struct mesh_db_model *mod)
 {
 	int cnt;
 	int i;
@@ -942,7 +949,8 @@ fail:
 	return false;
 }
 
-static bool parse_models(struct json_object *jmodels, struct mesh_db_element *ele)
+static bool parse_models(struct json_object *jmodels,
+						struct mesh_db_element *ele)
 {
 	int i, num_models;
 
@@ -1016,7 +1024,8 @@ fail:
 	return false;
 }
 
-static bool parse_elements(struct json_object *jelements, struct mesh_db_node *node)
+static bool parse_elements(struct json_object *jelements,
+						struct mesh_db_node *node)
 {
 	int i, num_ele;
 
@@ -1095,7 +1104,8 @@ static int get_mode(struct json_object *jvalue)
 	return 0xffffffff;
 }
 
-static void parse_features(struct json_object *jconfig, struct mesh_db_node *node)
+static void parse_features(struct json_object *jconfig,
+						struct mesh_db_node *node)
 {
 	struct json_object *jvalue, *jrelay;
 	int mode, count;
@@ -1152,7 +1162,8 @@ static void parse_features(struct json_object *jconfig, struct mesh_db_node *nod
 	node->modes.relay.interval = interval;
 }
 
-static bool parse_composition(struct json_object *jcomp, struct mesh_db_node *node)
+static bool parse_composition(struct json_object *jcomp,
+						struct mesh_db_node *node)
 {
 	struct json_object *jvalue;
 	char *str;
@@ -1189,7 +1200,8 @@ static bool parse_composition(struct json_object *jcomp, struct mesh_db_node *no
 	return true;
 }
 
-bool mesh_db_read_node(struct json_object *jnode, mesh_db_node_cb cb, void *user_data)
+bool mesh_db_read_node(struct json_object *jnode, mesh_db_node_cb cb,
+								void *user_data)
 {
 	struct mesh_db_node node;
 	struct json_object *jvalue;
@@ -1286,7 +1298,8 @@ bool mesh_db_write_int(struct json_object *jobj, const char *keyword, int value)
 	return true;
 }
 
-bool mesh_db_write_bool(struct json_object *jobj, const char *keyword, bool value)
+bool mesh_db_write_bool(struct json_object *jobj, const char *keyword,
+								bool value)
 {
 	struct json_object *jvalue;
 
@@ -1315,7 +1328,8 @@ static const char *mode_to_string(int mode)
 	}
 }
 
-bool mesh_db_write_mode(struct json_object *jobj, const char *keyword, int value)
+bool mesh_db_write_mode(struct json_object *jobj, const char *keyword,
+								int value)
 {
 	struct json_object *jstring;
 
@@ -1332,8 +1346,8 @@ bool mesh_db_write_mode(struct json_object *jobj, const char *keyword, int value
 	return true;
 }
 
-bool mesh_db_write_relay_mode(struct json_object *jnode, uint8_t mode, uint8_t count,
-							uint16_t interval)
+bool mesh_db_write_relay_mode(struct json_object *jnode, uint8_t mode,
+					uint8_t count, uint16_t interval)
 {
 	struct json_object *jrelay;
 
@@ -1579,7 +1593,8 @@ static void finish_key_refresh(struct json_object *jobj, uint16_t net_idx)
 
 }
 
-bool mesh_db_net_key_set_phase(struct json_object *jobj, uint16_t idx, uint8_t phase)
+bool mesh_db_net_key_set_phase(struct json_object *jobj, uint16_t idx,
+								uint8_t phase)
 {
 	struct json_object *jarray, *jentry = NULL;
 
@@ -1604,8 +1619,8 @@ bool mesh_db_net_key_set_phase(struct json_object *jobj, uint16_t idx, uint8_t p
 	return true;
 }
 
-bool mesh_db_model_pub_add(struct json_object *jnode, uint16_t addr, uint32_t mod_id,
-					bool vendor, struct mesh_db_pub *pub)
+bool mesh_db_model_pub_add(struct json_object *jnode, uint16_t addr,
+			uint32_t mod_id, bool vendor, struct mesh_db_pub *pub)
 {
 	struct json_object *jmodel, *jpub, *jretransmit;
 	bool res;
@@ -1686,8 +1701,8 @@ static bool delete_model_property(struct json_object *jnode, uint16_t addr,
 	return true;
 }
 
-bool mesh_db_model_pub_del(struct json_object *jnode, uint16_t addr, uint32_t mod_id,
-								bool vendor)
+bool mesh_db_model_pub_del(struct json_object *jnode, uint16_t addr,
+						uint32_t mod_id, bool vendor)
 {
 	if (!jnode)
 		return false;
@@ -1695,8 +1710,8 @@ bool mesh_db_model_pub_del(struct json_object *jnode, uint16_t addr, uint32_t mo
 	return delete_model_property(jnode, addr, mod_id, vendor, "publish");
 }
 
-bool mesh_db_model_sub_add(struct json_object *jnode, uint16_t addr, uint32_t mod_id,
-					bool vendor, struct mesh_db_sub *sub)
+bool mesh_db_model_sub_add(struct json_object *jnode, uint16_t addr,
+			uint32_t mod_id, bool vendor, struct mesh_db_sub *sub)
 {
 	struct json_object *jmodel, *jstring, *jarray = NULL;
 	int ele_idx, len;
@@ -1803,3 +1818,86 @@ bool mesh_db_model_sub_del_all(struct json_object *jnode, uint16_t addr,
 
 	return delete_model_property(jnode, addr, mod_id, vendor, "subscribe");
 }
+
+
+static bool import_net_key_cb(uint16_t idx, uint8_t *key, uint8_t *new_key,
+						int phase, void *user_data)
+{
+	struct mesh_db_import *import = user_data;
+
+	if (import->net_idx != UNUSED_KEY_IDX)
+		return false;
+
+	if (new_key || phase != KEY_REFRESH_PHASE_NONE)
+		return false;
+
+	import->net_idx = idx;
+	memcpy(import->net_key, key, sizeof(import->net_key));
+
+	return true;
+}
+
+struct mesh_db_import *mesh_db_import_new(const char *import_data)
+{
+	json_object *jobj = json_tokener_parse(import_data);
+	struct mesh_db_import *import = NULL;
+
+	if (!jobj || json_object_get_type(jobj) != json_type_object)
+		goto fail;
+
+	import = l_new(struct mesh_db_import, 1);
+	import->node = l_new(struct mesh_db_node, 1);
+	import->net_idx = UNUSED_KEY_IDX;
+
+	if (!mesh_db_read_device_key(jobj, import->dev_key)) {
+		l_error("Failed to parse imported device key");
+		goto fail;
+	}
+
+	json_object_object_del(jobj, "deviceKey");
+
+	if (!mesh_db_read_unicast_address(jobj, &import->node->unicast)) {
+		l_error("Failed to parse imported unicast");
+		goto fail;
+	}
+
+	json_object_object_del(jobj, "unicastAddress");
+
+	if (!mesh_db_read_iv_index(jobj, &import->iv_index,
+							&import->iv_update)) {
+		l_error("Failed to parse iv_index");
+		goto fail;
+	}
+
+	json_object_object_del(jobj, "IVindex");
+	json_object_object_del(jobj, "IVupdate");
+
+	if (!mesh_db_read_net_keys(jobj, import_net_key_cb, import)) {
+		l_error("Failed to parse imported network key");
+		goto fail;
+	}
+
+	json_object_object_del(jobj, "netKeys");
+
+	if (!mesh_db_read_seq_number(jobj, &import->node->seq_number))
+		import->node->seq_number = DEFAULT_SEQUENCE_NUMBER;
+
+	json_object_object_del(jobj, "sequenceNumber");
+
+	if (json_object_object_length(jobj) != 0) {
+		l_error("Unexpected keys in import data");
+		goto fail;
+	}
+
+	return import;
+fail:
+	if (jobj)
+		json_object_put(jobj);
+
+	if (import) {
+		l_free(import->node);
+		l_free(import);
+	}
+
+	return NULL;
+}
diff --git a/mesh/mesh-db.h b/mesh/mesh-db.h
index 0c09238ed..187f75459 100644
--- a/mesh/mesh-db.h
+++ b/mesh/mesh-db.h
@@ -95,15 +95,26 @@ struct mesh_db_prov {
 	uint8_t priv_key[32];
 };
 
+struct mesh_db_import {
+	struct mesh_db_node *node;
+	uint8_t dev_key[16];
+	uint8_t net_key[16];
+	uint16_t net_idx;
+	uint32_t iv_index;
+	bool iv_update;
+};
+
 typedef bool (*mesh_db_net_key_cb)(uint16_t idx, uint8_t key[16],
 			uint8_t new_key[16], int phase, void *user_data);
 typedef bool (*mesh_db_app_key_cb)(uint16_t idx, uint16_t net_idx,
 			uint8_t key[16], uint8_t new_key[16], void *user_data);
 typedef bool (*mesh_db_node_cb)(struct mesh_db_node *node, void *user_data);
 
-bool mesh_db_read_node(struct json_object *jobj, mesh_db_node_cb cb, void *user_data);
+bool mesh_db_read_node(struct json_object *jobj, mesh_db_node_cb cb,
+							void *user_data);
 bool mesh_db_add_node(struct json_object *jnode, struct mesh_db_node *node);
-bool mesh_db_read_iv_index(struct json_object *jobj, uint32_t *idx, bool *update);
+bool mesh_db_read_iv_index(struct json_object *jobj, uint32_t *idx,
+								bool *update);
 bool mesh_db_read_device_key(struct json_object *jobj, uint8_t key_buf[16]);
 bool mesh_db_read_token(struct json_object *jobj, uint8_t token[8]);
 bool mesh_db_read_net_transmit(struct json_object *jobj, uint8_t *cnt,
@@ -116,44 +127,51 @@ bool mesh_db_read_app_keys(struct json_object *jobj, mesh_db_app_key_cb cb,
 							void *user_data);
 bool mesh_db_write_device_key(struct json_object *jobj, uint8_t *key);
 bool mesh_db_write_token(struct json_object *jobj, uint8_t *token);
-bool mesh_db_write_network_key(struct json_object *jobj, uint16_t idx, uint8_t *key,
-						uint8_t *new_key, int phase);
+bool mesh_db_write_network_key(struct json_object *jobj, uint16_t idx,
+				uint8_t *key, uint8_t *new_key, int phase);
 bool mesh_db_write_app_key(struct json_object *jobj, uint16_t net_idx,
 			uint16_t app_idx, uint8_t *key, uint8_t *new_key);
-bool mesh_db_write_int(struct json_object *jobj, const char *keyword, int value);
+bool mesh_db_write_int(struct json_object *jobj, const char *keyword,
+								int value);
 bool mesh_db_write_uint16_hex(struct json_object *jobj, const char *desc,
 								uint16_t value);
 bool mesh_db_write_uint32_hex(struct json_object *jobj, const char *desc,
 								uint32_t value);
-bool mesh_db_write_bool(struct json_object *jobj, const char *keyword, bool value);
-bool mesh_db_write_relay_mode(struct json_object *jnode, uint8_t mode, uint8_t count,
-							uint16_t interval);
-bool mesh_db_write_mode(struct json_object *jobj, const char *keyword, int value);
-bool mesh_db_model_binding_add(struct json_object *jnode, uint8_t ele_idx, bool vendor,
-					uint32_t mod_id, uint16_t app_idx);
-bool mesh_db_model_binding_del(struct json_object *jnode, uint8_t ele_idx, bool vendor,
-					uint32_t mod_id, uint16_t app_idx);
+bool mesh_db_write_bool(struct json_object *jobj, const char *keyword,
+								bool value);
+bool mesh_db_write_relay_mode(struct json_object *jnode, uint8_t mode,
+					uint8_t count, uint16_t interval);
+bool mesh_db_write_mode(struct json_object *jobj, const char *keyword,
+								int value);
+bool mesh_db_model_binding_add(struct json_object *jnode, uint8_t ele_idx,
+				bool vendor, uint32_t mod_id, uint16_t app_idx);
+bool mesh_db_model_binding_del(struct json_object *jnode, uint8_t ele_idx,
+				bool vendor, uint32_t mod_id, uint16_t app_idx);
 bool mesh_db_model_pub_add(struct json_object *jnode, uint16_t ele_addr,
 			uint32_t mod_id, bool vendor, struct mesh_db_pub *pub);
 bool mesh_db_model_pub_del(struct json_object *jnode, uint16_t ele_addr,
 						uint32_t mod_id, bool vendor);
-bool mesh_db_model_sub_add(struct json_object *jnode, uint16_t addr, uint32_t mod_id,
-					bool vendor, struct mesh_db_sub *sub);
-bool mesh_db_model_sub_del(struct json_object *jnode, uint16_t addr, uint32_t mod_id,
-					bool vendor, struct mesh_db_sub *sub);
+bool mesh_db_model_sub_add(struct json_object *jnode, uint16_t addr,
+			uint32_t mod_id, bool vendor, struct mesh_db_sub *sub);
+bool mesh_db_model_sub_del(struct json_object *jnode, uint16_t addr,
+			uint32_t mod_id, bool vendor, struct mesh_db_sub *sub);
 bool mesh_db_model_sub_del_all(struct json_object *jnode, uint16_t addr,
 						uint32_t mod_id, bool vendor);
-bool mesh_db_app_key_add(struct json_object *jnode, uint16_t net_idx, uint16_t app_idx,
-							const uint8_t key[16]);
+bool mesh_db_app_key_add(struct json_object *jnode, uint16_t net_idx,
+				uint16_t app_idx, const uint8_t key[16]);
 bool mesh_db_app_key_update(struct json_object *jobj, uint16_t app_idx,
 							const uint8_t key[16]);
-bool mesh_db_app_key_del(struct json_object *jobj, uint16_t net_idx, uint16_t idx);
+bool mesh_db_app_key_del(struct json_object *jobj, uint16_t net_idx,
+								uint16_t idx);
 bool mesh_db_net_key_add(struct json_object *jobj, uint16_t net_idx,
 							const uint8_t key[16]);
 bool mesh_db_net_key_update(struct json_object *jobj, uint16_t idx,
 							const uint8_t key[16]);
 bool mesh_db_net_key_del(struct json_object *jobj, uint16_t net_idx);
-bool mesh_db_net_key_set_phase(struct json_object *jobj, uint16_t idx, uint8_t phase);
+bool mesh_db_net_key_set_phase(struct json_object *jobj, uint16_t idx,
+								uint8_t phase);
 bool mesh_db_write_address(struct json_object *jobj, uint16_t address);
-bool mesh_db_write_iv_index(struct json_object *jobj, uint32_t idx, bool update);
+bool mesh_db_write_iv_index(struct json_object *jobj, uint32_t idx,
+								bool update);
 void mesh_db_remove_property(struct json_object *jobj, const char *desc);
+struct mesh_db_import *mesh_db_import_new(const char *import_data);
diff --git a/mesh/mesh-defs.h b/mesh/mesh-defs.h
index 1a199f156..d6ef22362 100644
--- a/mesh/mesh-defs.h
+++ b/mesh/mesh-defs.h
@@ -37,6 +37,7 @@
 #define KEY_REFRESH_PHASE_THREE	0x03
 
 #define DEFAULT_TTL		0xff
+#define DEFAULT_SEQUENCE_NUMBER	0
 
 /* Supported algorithms for provisioning */
 #define ALG_FIPS_256_ECC	0x0001
diff --git a/mesh/mesh.c b/mesh/mesh.c
index 98e6d87b2..f6280e12d 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -22,6 +22,7 @@
 #endif
 
 #define _GNU_SOURCE
+#include <string.h>
 #include <ell/ell.h>
 
 #include "mesh/mesh-io.h"
@@ -34,6 +35,7 @@
 #include "mesh/error.h"
 #include "mesh/agent.h"
 #include "mesh/mesh.h"
+#include "mesh/mesh-db.h"
 
 /*
  * The default values for mesh configuration. Can be
@@ -70,6 +72,10 @@ struct join_data {
 	uint8_t *uuid;
 };
 
+static const char * const supported_import_data_types[] = {
+	"json"
+};
+
 static struct bt_mesh mesh;
 
 /* We allow only one outstanding Join request */
@@ -383,6 +389,18 @@ fail:
 	free_pending_join_call(true);
 }
 
+static bool validate_data_type(const char *data_type)
+{
+	uint8_t idx = 0;
+	uint8_t len = L_ARRAY_SIZE(supported_import_data_types);
+
+	for (idx = 0; idx < len; idx++) {
+		if (strcmp(data_type, supported_import_data_types[idx]) == 0)
+			return true;
+	}
+	return false;
+}
+
 static struct l_dbus_message *join_network_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
 						void *user_data)
@@ -536,7 +554,7 @@ static struct l_dbus_message *leave_call(struct l_dbus *dbus,
 	return l_dbus_message_new_method_return(msg);
 }
 
-static void create_network_ready_cb(void *user_data, int status,
+static void create_node_ready_cb(void *user_data, int status,
 							struct mesh_node *node)
 {
 	struct l_dbus_message *reply;
@@ -593,12 +611,74 @@ static struct l_dbus_message *create_network_call(struct l_dbus *dbus,
 
 	l_queue_push_tail(pending_queue, pending_msg);
 
-	node_create(app_path, sender, uuid, create_network_ready_cb,
+	node_create(app_path, sender, uuid, create_node_ready_cb,
 								pending_msg);
 
 	return NULL;
 }
 
+static struct l_dbus_message *import_local_node_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	const char *app_path, *sender;
+	struct l_dbus_message *pending_msg;
+	struct l_dbus_message_iter iter_uuid, iter_import_data;
+	struct mesh_db_import *import;
+	const char *data_type, *import_data;
+	uint8_t *uuid;
+	uint32_t n;
+
+	l_debug("Import local node request");
+
+	if (!l_dbus_message_get_arguments(msg, "oaysay", &app_path, &iter_uuid,
+						&data_type, &iter_import_data))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
+	if (!validate_data_type(data_type))
+		return dbus_error(msg, MESH_ERROR_NOT_IMPLEMENTED,
+						"Unsupported data type");
+
+	if (!l_dbus_message_iter_get_fixed_array(&iter_uuid, &uuid, &n) ||
+									n != 16)
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, "Bad dev UUID");
+
+	if (node_find_by_uuid(uuid))
+		return dbus_error(msg, MESH_ERROR_ALREADY_EXISTS,
+							"Node already exists");
+
+	if (!l_dbus_message_iter_get_fixed_array(&iter_import_data,
+							&import_data, &n))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
+							"Bad import_data");
+
+	import = mesh_db_import_new(import_data);
+
+	if (!import)
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
+						"Failed to parse import_data");
+
+	sender = l_dbus_message_get_sender(msg);
+	pending_msg = l_dbus_message_ref(msg);
+
+	if (!pending_queue)
+		pending_queue = l_queue_new();
+
+	l_queue_push_tail(pending_queue, pending_msg);
+
+	if (!node_import(app_path, sender, import, uuid, create_node_ready_cb,
+								pending_msg))
+		goto fail;
+
+	return NULL;
+
+fail:
+	l_free(import);
+	l_dbus_message_unref(msg);
+	l_queue_remove(pending_queue, pending_msg);
+	return dbus_error(msg, MESH_ERROR_INVALID_ARGS, "Node import failed");
+}
+
 static void setup_network_interface(struct l_dbus_interface *iface)
 {
 	l_dbus_interface_method(iface, "Join", 0, join_network_call, "",
@@ -612,8 +692,15 @@ static void setup_network_interface(struct l_dbus_interface *iface)
 
 	l_dbus_interface_method(iface, "Leave", 0, leave_call, "", "t",
 								"token");
+
 	l_dbus_interface_method(iface, "CreateNetwork", 0, create_network_call,
 					"t", "oay", "token", "app", "uuid");
+
+	l_dbus_interface_method(iface, "ImportLocalNode", 0,
+					import_local_node_call,
+					"t", "oaysay", "token",
+					"app", "uuid", "data_type",
+					"import_data");
 }
 
 bool mesh_dbus_init(struct l_dbus *dbus)
diff --git a/mesh/model.c b/mesh/model.c
index f59d709d5..c320a7594 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -227,6 +227,7 @@ static struct l_dbus_message *create_config_update_msg(struct mesh_node *node,
 
 	if ((id & VENDOR_ID_MASK) != VENDOR_ID_MASK) {
 		uint16_t vendor = id >> 16;
+
 		dbus_append_dict_entry_basic(*builder, "Vendor", "q", &vendor);
 	}
 
@@ -267,7 +268,7 @@ static void append_dict_uint16_array(struct l_dbus_message_builder *builder,
 	for (entry = l_queue_get_entries(q); entry; entry = entry->next) {
 		uint16_t value = (uint16_t) L_PTR_TO_UINT(entry->data);
 
-		l_dbus_message_builder_append_basic(builder,'q', &value);
+		l_dbus_message_builder_append_basic(builder, 'q', &value);
 	}
 
 	l_dbus_message_builder_leave_array(builder);
@@ -1579,6 +1580,7 @@ void model_build_config(void *model, void *msg_builder)
 	/* For vendor models, add vendor id */
 	if ((mod->id & VENDOR_ID_MASK) != VENDOR_ID_MASK) {
 		uint16_t vendor = mod->id >> 16;
+
 		dbus_append_dict_entry_basic(builder, "Vendor", "q", &vendor);
 	}
 
@@ -1589,6 +1591,7 @@ void model_build_config(void *model, void *msg_builder)
 	/* Model periodic publication interval, if present */
 	if (mod->pub) {
 		uint32_t period = pub_period_to_ms(mod->pub->period);
+
 		dbus_append_dict_entry_basic(builder, "PublicationPeriod", "u",
 								&period);
 	}
diff --git a/mesh/node.c b/mesh/node.c
index 8533aaa1e..646e23a32 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -54,11 +54,13 @@
 #define DEFAULT_LOCATION 0x0000
 
 #define DEFAULT_CRPL 10
-#define DEFAULT_SEQUENCE_NUMBER 0
 
-#define REQUEST_TYPE_JOIN 0
-#define REQUEST_TYPE_ATTACH 1
-#define REQUEST_TYPE_CREATE 2
+enum request_type {
+	REQUEST_TYPE_JOIN = 0,
+	REQUEST_TYPE_ATTACH,
+	REQUEST_TYPE_CREATE,
+	REQUEST_TYPE_IMPORT,
+};
 
 struct node_element {
 	char *path;
@@ -108,8 +110,16 @@ struct mesh_node {
 struct managed_obj_request {
 	void *data;
 	void *cb;
-	void *user_data;
-	uint8_t type;
+	union {
+		struct l_dbus_message *pending_msg;
+		struct node_import_request *import_req;
+	};
+	enum request_type type;
+};
+
+struct node_import_request {
+	struct mesh_db_import *import;
+	struct l_dbus_message *pending_msg;
 };
 
 static struct l_queue *nodes;
@@ -1388,13 +1398,6 @@ static bool add_local_node(struct mesh_node *node, uint16_t unicast, bool kr,
 				bool ivu, uint32_t iv_idx, uint8_t dev_key[16],
 				uint16_t net_key_idx, uint8_t net_key[16])
 {
-	node->net = mesh_net_new(node);
-
-	if (!nodes)
-		nodes = l_queue_new();
-
-	l_queue_push_tail(nodes, node);
-
 	if (!storage_set_iv_index(node->net, iv_idx, ivu))
 		return false;
 
@@ -1462,14 +1465,13 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 	}
 
 	if (is_new) {
-		node = l_new(struct mesh_node, 1);
+		node = node_new(req->data);
 		node->elements = l_queue_new();
 	} else {
 		node = req->data;
 	}
 
 	num_ele = 0;
-
 	while (l_dbus_message_iter_next_entry(&objects, &path, &interfaces)) {
 		struct l_dbus_message_iter properties;
 		const char *interface;
@@ -1543,7 +1545,7 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 
 			node->disc_watch = l_dbus_add_disconnect_watch(bus,
 					node->owner, app_disc_cb, node, NULL);
-			cb(req->user_data, MESH_ERROR_NONE, node);
+			cb(req->pending_msg, MESH_ERROR_NONE, node);
 		} else
 			goto fail;
 
@@ -1565,6 +1567,49 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 
 		cb(node, agent);
 
+	} else if (req->type == REQUEST_TYPE_IMPORT) {
+
+		node_ready_func_t cb = req->cb;
+		struct node_import_request *import_req = req->import_req;
+		struct mesh_db_import *import = import_req->import;
+		struct keyring_net_key net_key;
+
+		if (!agent) {
+			l_error("Interface %s not found",
+						MESH_PROVISION_AGENT_INTERFACE);
+			goto fail;
+		}
+
+		node->num_ele = num_ele;
+		set_defaults(node);
+
+		if (node->seq_number != import->node->seq_number)
+			node->seq_number = import->node->seq_number;
+
+		memcpy(node->uuid, req->data, 16);
+
+		if (!create_node_config(node))
+			goto fail;
+
+		if (!add_local_node(node, import->node->unicast, false,
+					import->iv_update, import->iv_index,
+					import->dev_key, import->net_idx,
+					import->net_key))
+			goto fail;
+
+		memcpy(net_key.old_key, import->net_key, 16);
+		net_key.net_idx = import->net_idx;
+		net_key.phase = KEY_REFRESH_PHASE_NONE;
+
+		if (!keyring_put_remote_dev_key(node, import->node->unicast,
+						num_ele, import->dev_key))
+			goto fail;
+
+		if (!keyring_put_net_key(node, PRIMARY_NET_IDX, &net_key))
+			goto fail;
+
+		cb(import_req->pending_msg, MESH_ERROR_NONE, node);
+
 	} else {
 		/* Callback for create node request */
 		node_ready_func_t cb = req->cb;
@@ -1597,7 +1642,7 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 		if (!keyring_put_net_key(node, PRIMARY_NET_IDX, &net_key))
 			goto fail;
 
-		cb(req->user_data, MESH_ERROR_NONE, node);
+		cb(req->pending_msg, MESH_ERROR_NONE, node);
 	}
 
 	return;
@@ -1611,9 +1656,9 @@ fail:
 
 		free_node_dbus_resources(node);
 
-		cb(req->user_data, MESH_ERROR_FAILED, node);
+		cb(req->pending_msg, MESH_ERROR_FAILED, node);
 	} else {
-		/* Handle failed Join and Create requests */
+		/* Handle failed Join, Create and Import requests */
 		if (node)
 			node_remove(node);
 
@@ -1621,10 +1666,16 @@ fail:
 			node_join_ready_func_t cb = req->cb;
 
 			cb(NULL, NULL);
+		} else if (req->type == REQUEST_TYPE_IMPORT) {
+			node_ready_func_t cb = req->cb;
+
+			cb(req->import_req->pending_msg, MESH_ERROR_FAILED,
+									NULL);
+
 		} else {
 			node_ready_func_t cb = req->cb;
 
-			cb(req->user_data, MESH_ERROR_FAILED, NULL);
+			cb(req->pending_msg, MESH_ERROR_FAILED, NULL);
 		}
 	}
 }
@@ -1652,7 +1703,7 @@ int node_attach(const char *app_path, const char *sender, uint64_t token,
 	req = l_new(struct managed_obj_request, 1);
 	req->data = node;
 	req->cb = cb;
-	req->user_data = user_data;
+	req->pending_msg = user_data;
 	req->type = REQUEST_TYPE_ATTACH;
 
 	l_dbus_method_call(dbus_get_bus(), sender, app_path,
@@ -1685,6 +1736,39 @@ void node_join(const char *app_path, const char *sender, const uint8_t *uuid,
 					req, l_free);
 }
 
+bool node_import(const char *app_path, const char *sender,
+				struct mesh_db_import *import,
+				const uint8_t *uuid, node_ready_func_t cb,
+				void *user_data)
+{
+	struct managed_obj_request *req;
+	struct node_import_request *import_req;
+
+	l_debug("");
+
+	/* TODO: implement full import */
+	if (import->node->elements)
+		return false;
+
+	req = l_new(struct managed_obj_request, 1);
+	import_req = l_new(struct node_import_request, 1);
+
+	import_req->pending_msg = user_data;
+	import_req->import = import;
+
+	req->data = (void *) uuid;
+	req->import_req = import_req;
+	req->cb = cb;
+	req->type = REQUEST_TYPE_IMPORT;
+
+	l_dbus_method_call(dbus_get_bus(), sender, app_path,
+						L_DBUS_INTERFACE_OBJECT_MANAGER,
+						"GetManagedObjects", NULL,
+						get_managed_objects_cb,
+						req, l_free);
+	return true;
+}
+
 void node_create(const char *app_path, const char *sender, const uint8_t *uuid,
 					node_ready_func_t cb, void *user_data)
 {
@@ -1695,7 +1779,7 @@ void node_create(const char *app_path, const char *sender, const uint8_t *uuid,
 	req = l_new(struct managed_obj_request, 1);
 	req->data = (void *) uuid;
 	req->cb = cb;
-	req->user_data = user_data;
+	req->pending_msg = user_data;
 	req->type = REQUEST_TYPE_CREATE;
 
 	l_dbus_method_call(dbus_get_bus(), sender, app_path,
diff --git a/mesh/node.h b/mesh/node.h
index 142527b30..c87e2c683 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -33,6 +33,8 @@ typedef void (*node_ready_func_t) (void *user_data, int status,
 typedef void (*node_join_ready_func_t) (struct mesh_node *node,
 						struct mesh_agent *agent);
 
+struct mesh_db_import;
+
 struct mesh_node *node_new(const uint8_t uuid[16]);
 void node_remove(struct mesh_node *node);
 void node_join(const char *app_path, const char *sender, const uint8_t *uuid,
@@ -91,6 +93,10 @@ void node_build_attach_reply(struct mesh_node *node,
 						struct l_dbus_message *reply);
 void node_create(const char *app_path, const char *sender, const uint8_t *uuid,
 					node_ready_func_t cb, void *user_data);
+bool node_import(const char *app_path, const char *sender,
+				struct mesh_db_import *import,
+				const uint8_t *uuid, node_ready_func_t cb,
+				void *user_data);
 void node_id_set(struct mesh_node *node, uint16_t node_id);
 uint16_t node_id_get(struct mesh_node *node);
 bool node_dbus_init(struct l_dbus *bus);
-- 
2.20.1

