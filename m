Return-Path: <SRS0=OtJ6=EM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A2CC388F2
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Nov 2020 07:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DCD120825
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Nov 2020 07:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbgKFHLD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Nov 2020 02:11:03 -0500
Received: from mga18.intel.com ([134.134.136.126]:29535 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgKFHLC (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Nov 2020 02:11:02 -0500
IronPort-SDR: koeWyrcn31EDXuzPETp3359AY/E85rtaGize9nTr21uzKXgEylD3cc6up10h5JYuLqfC31IhL9
 gF2B5ldxaWeQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="157291596"
X-IronPort-AV: E=Sophos;i="5.77,455,1596524400"; 
   d="scan'208";a="157291596"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 23:11:02 -0800
IronPort-SDR: yC6L8zXfjXvpHhG8+qkep1OERUFTNc69DipMCrGQMPLV+eYIq10+wbqdgHVuu9mb+Gq/ewxGt1
 GtYV1vvrl8oA==
X-IronPort-AV: E=Sophos;i="5.77,455,1596524400"; 
   d="scan'208";a="471969346"
Received: from phillipn-mobl.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.212.109.190])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 23:11:01 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Fix errors found by static analysis
Date:   Thu,  5 Nov 2020 23:10:53 -0800
Message-Id: <20201106071053.122820-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes a NULL pointer dereference error (cfgmod-server.c)
and miscellaneous issues related to unchecked return status.
---
 mesh/agent.c         | 43 ++++++++++++++++++++++++++++---------------
 mesh/appkey.c        |  6 +++---
 mesh/cfgmod-server.c | 12 +++---------
 mesh/keyring.c       | 38 ++++++++++++++++++++++++--------------
 4 files changed, 58 insertions(+), 41 deletions(-)

diff --git a/mesh/agent.c b/mesh/agent.c
index b0d523d16..5058d0d8d 100644
--- a/mesh/agent.c
+++ b/mesh/agent.c
@@ -95,7 +95,7 @@ static bool simple_match(const void *a, const void *b)
 	return a == b;
 }
 
-static void parse_prov_caps(struct mesh_agent_prov_caps *caps,
+static bool parse_prov_caps(struct mesh_agent_prov_caps *caps,
 				struct l_dbus_message_iter *property)
 {
 	struct l_dbus_message_iter iter_caps;
@@ -103,7 +103,7 @@ static void parse_prov_caps(struct mesh_agent_prov_caps *caps,
 	uint32_t i;
 
 	if (!l_dbus_message_iter_get_variant(property, "as", &iter_caps))
-		return;
+		return false;
 
 	while (l_dbus_message_iter_next_entry(&iter_caps, &str)) {
 		for (i = 0; i < L_ARRAY_SIZE(cap_table); i++) {
@@ -129,9 +129,10 @@ static void parse_prov_caps(struct mesh_agent_prov_caps *caps,
 			caps->static_type = 1;
 	}
 
+	return true;
 }
 
-static void parse_oob_info(struct mesh_agent_prov_caps *caps,
+static bool parse_oob_info(struct mesh_agent_prov_caps *caps,
 				struct l_dbus_message_iter *property)
 {
 	struct l_dbus_message_iter iter_oob;
@@ -139,7 +140,7 @@ static void parse_oob_info(struct mesh_agent_prov_caps *caps,
 	const char *str;
 
 	if (!l_dbus_message_iter_get_variant(property, "as", &iter_oob))
-		return;
+		return false;
 
 	while (l_dbus_message_iter_next_entry(&iter_oob, &str)) {
 		for (i = 0; i < L_ARRAY_SIZE(oob_table); i++) {
@@ -148,9 +149,11 @@ static void parse_oob_info(struct mesh_agent_prov_caps *caps,
 			caps->oob_info |= oob_table[i].mask;
 		}
 	}
+
+	return true;
 }
 
-static void parse_properties(struct mesh_agent *agent,
+static bool parse_properties(struct mesh_agent *agent,
 					struct l_dbus_message_iter *properties)
 {
 	const char *key, *uri_string;
@@ -160,15 +163,20 @@ static void parse_properties(struct mesh_agent *agent,
 
 	while (l_dbus_message_iter_next_entry(properties, &key, &variant)) {
 		if (!strcmp(key, "Capabilities")) {
-			parse_prov_caps(&agent->caps, &variant);
+			if (!parse_prov_caps(&agent->caps, &variant))
+				return false;
 		} else if (!strcmp(key, "URI")) {
-			l_dbus_message_iter_get_variant(&variant, "s",
-								&uri_string);
+			if (!l_dbus_message_iter_get_variant(&variant, "s",
+								&uri_string))
+				return false;
 			/* TODO: compute hash */
 		} else if (!strcmp(key, "OutOfBandInfo")) {
-			parse_oob_info(&agent->caps, &variant);
+			if (!parse_oob_info(&agent->caps, &variant))
+				return false;
 		}
 	}
+
+	return true;
 }
 
 static void agent_free(void *agent_data)
@@ -253,7 +261,10 @@ struct mesh_agent *mesh_agent_create(const char *path, const char *owner,
 	agent->owner = l_strdup(owner);
 	agent->path = l_strdup(path);
 
-	parse_properties(agent, properties);
+	if (!parse_properties(agent, properties)) {
+		l_free(agent);
+		return NULL;
+	}
 
 	l_queue_push_tail(agents, agent);
 
@@ -312,15 +323,17 @@ static void properties_reply(struct l_dbus_message *reply, void *user_data)
 	err = get_reply_error(reply);
 
 	if (err != MESH_ERROR_NONE)
-		goto fail;
+		goto done;
 
 	if (!l_dbus_message_get_arguments(reply, "a{sv}", &properties)) {
 		err = MESH_ERROR_FAILED;
-		goto fail;
+		goto done;
 	}
 
-	parse_properties(agent, &properties);
-fail:
+	if (!parse_properties(agent, &properties))
+		err = MESH_ERROR_FAILED;
+
+done:
 	if (req->cb) {
 		cb = req->cb;
 		cb(req->user_data, err);
@@ -425,7 +438,7 @@ static void key_reply(struct l_dbus_message *reply, void *user_data)
 	mesh_agent_key_cb_t cb;
 	struct l_dbus_message_iter iter_array;
 	uint32_t n = 0, expected_len = 0;
-	uint8_t *buf;
+	uint8_t *buf = NULL;
 	int err;
 
 	if (!l_queue_find(agents, simple_match, agent) || !agent->req)
diff --git a/mesh/appkey.c b/mesh/appkey.c
index 7efb8f5c4..549f5a80d 100644
--- a/mesh/appkey.c
+++ b/mesh/appkey.c
@@ -100,11 +100,11 @@ bool appkey_key_init(struct mesh_net *net, uint16_t net_idx, uint16_t app_idx,
 	if (!app_keys)
 		return NULL;
 
-	key = app_key_new();
-	if (!key)
+	if (!mesh_net_have_key(net, net_idx))
 		return false;
 
-	if (!mesh_net_have_key(net, net_idx))
+	key = app_key_new();
+	if (!key)
 		return false;
 
 	key->net_idx = net_idx;
diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 0009a1bee..5eefedc4d 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -80,13 +80,12 @@ static uint16_t config_pub_get(struct mesh_node *node, const uint8_t *pkt,
 
 	pub = mesh_model_pub_get(node, ele_addr, id, &status);
 
-	rtx = pub->rtx.cnt + (((pub->rtx.interval / 50) - 1) << 3);
-
-	if (pub && status == MESH_STATUS_SUCCESS)
+	if (pub && status == MESH_STATUS_SUCCESS) {
+		rtx = pub->rtx.cnt + (((pub->rtx.interval / 50) - 1) << 3);
 		return set_pub_status(status, ele_addr, id, pub->addr, pub->idx,
 					pub->credential, pub->ttl, pub->period,
 					rtx);
-	else
+	} else
 		return set_pub_status(status, ele_addr, id, 0, 0, 0, 0, 0, 0);
 }
 
@@ -592,12 +591,7 @@ static uint16_t cfg_appkey_msg(struct mesh_node *node, const uint8_t *pkt,
 	struct mesh_net *net = node_get_net(node);
 
 	n_idx = l_get_le16(pkt) & 0xfff;
-	if (n_idx > NET_IDX_MAX)
-		return 0;
-
 	a_idx = l_get_le16(pkt + 1) >> 4;
-	if (a_idx > APP_IDX_MAX)
-		return 0;
 
 	n = mesh_model_opcode_set(OP_APPKEY_STATUS, msg);
 
diff --git a/mesh/keyring.c b/mesh/keyring.c
index bbe501063..1ef4fc3ef 100644
--- a/mesh/keyring.c
+++ b/mesh/keyring.c
@@ -50,18 +50,22 @@ bool keyring_put_net_key(struct mesh_node *node, uint16_t net_idx,
 		return false;
 
 	snprintf(key_file, PATH_MAX, "%s%s", node_path, net_key_dir);
-	mkdir(key_file, 0755);
+
+	if (!mkdir(key_file, 0755))
+		return false;
+
 	snprintf(key_file, PATH_MAX, "%s%s/%3.3x", node_path, net_key_dir,
 								net_idx);
 	l_debug("Put Net Key %s", key_file);
 
 	fd = open(key_file, O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR);
-	if (fd >= 0) {
-		if (write(fd, key, sizeof(*key)) == sizeof(*key))
-			result = true;
+	if (fd < 0)
+		return false;
 
-		close(fd);
-	}
+	if (write(fd, key, sizeof(*key)) == sizeof(*key))
+		result = true;
+
+	close(fd);
 
 	return result;
 }
@@ -83,7 +87,10 @@ bool keyring_put_app_key(struct mesh_node *node, uint16_t app_idx,
 		return false;
 
 	snprintf(key_file, PATH_MAX, "%s%s", node_path, app_key_dir);
-	mkdir(key_file, 0755);
+
+	if (!mkdir(key_file, 0755))
+		return false;
+
 	snprintf(key_file, PATH_MAX, "%s%s/%3.3x", node_path, app_key_dir,
 								app_idx);
 	l_debug("Put App Key %s", key_file);
@@ -100,16 +107,17 @@ bool keyring_put_app_key(struct mesh_node *node, uint16_t app_idx,
 		}
 
 		lseek(fd, 0, SEEK_SET);
-	} else
+	} else {
 		fd = open(key_file, O_WRONLY | O_CREAT | O_TRUNC,
 							S_IRUSR | S_IWUSR);
+		if (fd < 0)
+			return false;
+	}
 
-	if (fd >= 0) {
-		if (write(fd, key, sizeof(*key)) == sizeof(*key))
-			result = true;
+	if (write(fd, key, sizeof(*key)) == sizeof(*key))
+		result = true;
 
-		close(fd);
-	}
+	close(fd);
 
 	return result;
 }
@@ -198,7 +206,9 @@ bool keyring_put_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 		return false;
 
 	snprintf(key_file, PATH_MAX, "%s%s", node_path, dev_key_dir);
-	mkdir(key_file, 0755);
+
+	if (!mkdir(key_file, 0755))
+		return false;
 
 	for (i = 0; i < count; i++) {
 		snprintf(key_file, PATH_MAX, "%s%s/%4.4x", node_path,
-- 
2.26.2

