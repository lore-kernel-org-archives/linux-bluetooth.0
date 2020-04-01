Return-Path: <SRS0=i/J9=5R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD328C43331
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 10:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB4520678
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 10:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="EBl+/8Dt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732158AbgDAKZE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:25:04 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:44734 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730720AbgDAKZE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Apr 2020 06:25:04 -0400
Received: by mail-lf1-f46.google.com with SMTP id 131so641467lfh.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Apr 2020 03:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IecFyvJoyjkzMoYy3KC7YwYN0zPf+QMyEtAzUmAo0zQ=;
        b=EBl+/8DtsUyp+9D615N96ACa7KorAmeeb12yAkvVpGta99Sy/xlAx3mJ80z7Q9CwwC
         gKk48hx2LjDfcGmASVEj30EbkC1ypwAkxnZ1XiGNOchSzJmpzv4EJ4Qzjawe+DxqkI9n
         OxqFZpopFPsB9fYHihw2E6u5oK5C/8a9JYmNe6ZbZxawNuyaMppz4o4DMEYjrow1JYHH
         0K/hwGREcUsoEf0Nw7KW5othbuTYvRJu7gXyn1dGVEErGYLmL8sScP/qrGGQIW0k4UY3
         0m2InofZKKKXxcggoq+Ukmhv7/iVDSk6dVHvAeArNZMZLBDMIzwt4HffUNo3wJHIRNFA
         GbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IecFyvJoyjkzMoYy3KC7YwYN0zPf+QMyEtAzUmAo0zQ=;
        b=bAfLRJayhg9M4l/aGL1or+Q5WvSnVWJYbc41bN9U03nNEfekupCSnU70gHJfVSMCCN
         wOstwlbCnAw/07oP5PZbY4UQLNiWHhmqZ63HkQ+6fOBDTejBWVYKOJMjU4O+Y3mU/U7V
         kl4atBFB2hGNB+NutsUwh+hJqabNCldz1PoFFYn5OOD7tVWO56WxMcSXefP07h5C9qfY
         orh6NLhvPyXMq7nfX71cBXYH4Iw+UelA6CfKumm6FkuDnpeLc/3BrG2I7L6eO6VqqItS
         A5TNSqAisLHYQqRb8VUJbhez5HUQv87muPW2uVivFVlk0vdq0oPG61oWqPjBGmilWVr1
         Ei0w==
X-Gm-Message-State: AGi0Puadtk/5z8RIHzSEvZ+thtAwJcRA4VsJjnmMrae25HdPHOuM+mVY
        YapxapEzPqes+Fb4gB/dY6MA0qaKGlY=
X-Google-Smtp-Source: APiQypIhHHllmxxXJ0eIGiFXzwSkV/tlyTTE5sCqvt/wG8DwM5vrEmblVF5Wg8RAxL7thfkXyWoVRQ==
X-Received: by 2002:a19:6749:: with SMTP id e9mr13668122lfj.122.1585736699987;
        Wed, 01 Apr 2020 03:24:59 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id r16sm922217ljj.40.2020.04.01.03.24.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 03:24:59 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/6] mesh: Refresh provisioner's capabilities
Date:   Wed,  1 Apr 2020 12:25:00 +0200
Message-Id: <20200401102502.746-5-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200401102502.746-1-michal.lowas-rzechonek@silvair.com>
References: <20200401102502.746-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

As provisioner's capabilities might change during application lifetime
(e.g. no network link to download OOB key), let's query the agent again
after application calls AddNode().
---
 mesh/agent.c          | 105 +++++++++++++++++++++++++++++++++++-------
 mesh/agent.h          |   2 +
 mesh/manager.c        |  33 +++++++++----
 mesh/prov-initiator.c |  47 +++++++++++++++----
 mesh/provision.h      |   3 ++
 5 files changed, 154 insertions(+), 36 deletions(-)

diff --git a/mesh/agent.c b/mesh/agent.c
index 3ab3893a1..02993738c 100644
--- a/mesh/agent.c
+++ b/mesh/agent.c
@@ -40,7 +40,8 @@ typedef enum {
 	MESH_AGENT_REQUEST_IN_ALPHA,
 	MESH_AGENT_REQUEST_STATIC_OOB,
 	MESH_AGENT_REQUEST_PRIVATE_KEY,
-	MESH_AGENT_REQUEST_PUBLIC_KEY
+	MESH_AGENT_REQUEST_PUBLIC_KEY,
+	MESH_AGENT_REQUEST_CAPABILITIES,
 } agent_request_type_t;
 
 struct agent_request {
@@ -158,6 +159,25 @@ static void parse_oob_info(struct mesh_agent_prov_caps *caps,
 	}
 }
 
+static void parse_properties(struct mesh_agent *agent,
+					struct l_dbus_message_iter *properties)
+{
+	const char *key, *uri_string;
+	struct l_dbus_message_iter variant;
+
+	while (l_dbus_message_iter_next_entry(properties, &key, &variant)) {
+		if (!strcmp(key, "Capabilities")) {
+			parse_prov_caps(&agent->caps, &variant);
+		} else if (!strcmp(key, "URI")) {
+			l_dbus_message_iter_get_variant(&variant, "s",
+								&uri_string);
+			/* TODO: compute hash */
+		} else if (!strcmp(key, "OutOfBandInfo")) {
+			parse_oob_info(&agent->caps, &variant);
+		}
+	}
+}
+
 static void agent_free(void *agent_data)
 {
 	struct mesh_agent *agent = agent_data;
@@ -193,6 +213,7 @@ static void agent_free(void *agent_data)
 		case MESH_AGENT_REQUEST_VIBRATE:
 		case MESH_AGENT_REQUEST_OUT_NUMERIC:
 		case MESH_AGENT_REQUEST_OUT_ALPHA:
+		case MESH_AGENT_REQUEST_CAPABILITIES:
 			simple_cb = agent->req->cb;
 			simple_cb(req->user_data, err);
 		default:
@@ -235,26 +256,13 @@ struct mesh_agent *mesh_agent_create(const char *path, const char *owner,
 					struct l_dbus_message_iter *properties)
 {
 	struct mesh_agent *agent;
-	const char *key, *uri_string;
-	struct l_dbus_message_iter variant;
 
 	agent = l_new(struct mesh_agent, 1);
-
-	while (l_dbus_message_iter_next_entry(properties, &key, &variant)) {
-		if (!strcmp(key, "Capabilities")) {
-			parse_prov_caps(&agent->caps, &variant);
-		} else if (!strcmp(key, "URI")) {
-			l_dbus_message_iter_get_variant(&variant, "s",
-								&uri_string);
-			/* TODO: compute hash */
-		} else if (!strcmp(key, "OutOfBandInfo")) {
-			parse_oob_info(&agent->caps, &variant);
-		}
-	}
-
 	agent->owner = l_strdup(owner);
 	agent->path = l_strdup(path);
 
+	parse_properties(agent, properties);
+
 	l_queue_push_tail(agents, agent);
 
 	return agent;
@@ -289,13 +297,76 @@ static int get_reply_error(struct l_dbus_message *reply)
 	if (l_dbus_message_is_error(reply)) {
 
 		l_dbus_message_get_error(reply, &name, &desc);
-		l_error("Agent failed output action (%s), %s", name, desc);
+		l_error("Agent failed (%s), %s", name, desc);
 		return MESH_ERROR_FAILED;
 	}
 
 	return MESH_ERROR_NONE;
 }
 
+static void properties_reply(struct l_dbus_message *reply, void *user_data)
+{
+	struct mesh_agent *agent = user_data;
+	struct agent_request *req;
+	mesh_agent_cb_t cb;
+	struct l_dbus_message_iter properties;
+	int err;
+
+	if (!l_queue_find(agents, simple_match, agent) || !agent->req)
+		return;
+
+	req = agent->req;
+
+	err = get_reply_error(reply);
+
+	if (err != MESH_ERROR_NONE)
+		goto fail;
+
+	if (!l_dbus_message_get_arguments(reply, "a{sv}", &properties)) {
+		err = MESH_ERROR_FAILED;
+		goto fail;
+	}
+
+	parse_properties(agent, &properties);
+fail:
+	if (req->cb)
+	{
+		cb = req->cb;
+		cb(req->user_data, err);
+	}
+
+	l_dbus_message_unref(req->msg);
+	l_free(req);
+	agent->req = NULL;
+}
+
+void mesh_agent_refresh(struct mesh_agent *agent, mesh_agent_cb_t cb,
+							void *user_data)
+{
+	struct l_dbus *dbus = dbus_get_bus();
+	struct l_dbus_message *msg;
+	struct l_dbus_message_builder *builder;
+
+	agent->req = create_request(MESH_AGENT_REQUEST_CAPABILITIES, (void *)cb,
+								user_data);
+
+	msg = l_dbus_message_new_method_call(dbus, agent->owner, agent->path,
+						L_DBUS_INTERFACE_PROPERTIES,
+						"GetAll");
+
+	builder = l_dbus_message_builder_new(msg);
+	l_dbus_message_builder_append_basic(builder, 's',
+						MESH_PROVISION_AGENT_INTERFACE);
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+
+	l_dbus_send_with_reply(dbus_get_bus(), msg, properties_reply, agent,
+									NULL);
+
+	agent->req->msg = l_dbus_message_ref(msg);
+}
+
+
 static void simple_reply(struct l_dbus_message *reply, void *user_data)
 {
 	struct mesh_agent *agent = user_data;
diff --git a/mesh/agent.h b/mesh/agent.h
index 80333acd5..6cc3d0f71 100644
--- a/mesh/agent.h
+++ b/mesh/agent.h
@@ -42,6 +42,8 @@ void mesh_agent_init(void);
 void mesh_agent_cleanup(void);
 struct mesh_agent *mesh_agent_create(const char *path, const char *owner,
 					struct l_dbus_message_iter *properties);
+void mesh_agent_refresh(struct mesh_agent *agent, mesh_agent_cb_t cb,
+							void *user_data);
 
 void mesh_agent_remove(struct mesh_agent *agent);
 void mesh_agent_cancel(struct mesh_agent *agent);
diff --git a/mesh/manager.c b/mesh/manager.c
index a4c2f2d41..9ec4a1468 100644
--- a/mesh/manager.c
+++ b/mesh/manager.c
@@ -81,6 +81,9 @@ static void free_pending_add_call()
 		l_dbus_remove_watch(dbus_get_bus(),
 						add_pending->disc_watch);
 
+	if (add_pending->msg)
+		l_dbus_message_unref(add_pending->msg);
+
 	l_free(add_pending);
 	add_pending = NULL;
 }
@@ -212,6 +215,23 @@ static bool add_data_get(void *user_data, uint8_t num_ele)
 	return true;
 }
 
+static void add_start(void *user_data, int err)
+{
+	struct l_dbus_message *reply;
+
+	l_info("Start callback");
+
+	if (err == MESH_ERROR_NONE)
+		reply = l_dbus_message_new_method_return(add_pending->msg);
+	else
+		reply = dbus_error(add_pending->msg, MESH_ERROR_FAILED,
+				"Failed to start provisioning initiator");
+
+	l_dbus_send(dbus_get_bus(), reply);
+
+	add_pending->msg = NULL;
+}
+
 static struct l_dbus_message *add_node_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
 						void *user_data)
@@ -243,6 +263,7 @@ static struct l_dbus_message *add_node_call(struct l_dbus *dbus,
 	/* Invoke Prov Initiator */
 
 	add_pending = l_new(struct add_data, 1);
+	add_pending->msg = l_dbus_message_ref(msg);
 	memcpy(add_pending->uuid, uuid, 16);
 	add_pending->node = node;
 	add_pending->agent = node_get_agent(node);
@@ -255,20 +276,14 @@ static struct l_dbus_message *add_node_call(struct l_dbus *dbus,
 		goto fail;
 	}
 
-
-	if (!initiator_start(PB_ADV, uuid, 99, 60, add_pending->agent,
-				add_data_get, add_cmplt, node, add_pending)) {
-		reply = dbus_error(msg, MESH_ERROR_FAILED,
-				"Failed to start provisioning initiator");
-		goto fail;
-	}
+	initiator_start(PB_ADV, uuid, 99, 60, add_pending->agent, add_start,
+				add_data_get, add_cmplt, node, add_pending);
 
 	add_pending->disc_watch = l_dbus_add_disconnect_watch(dbus,
 						node_get_owner(node),
 						prov_disc_cb, NULL, NULL);
 
-	return l_dbus_message_new_method_return(msg);
-
+	return NULL;
 fail:
 	l_free(add_pending);
 	add_pending = NULL;
diff --git a/mesh/prov-initiator.c b/mesh/prov-initiator.c
index f2ebff69e..17bda6521 100644
--- a/mesh/prov-initiator.c
+++ b/mesh/prov-initiator.c
@@ -36,6 +36,7 @@
 #include "mesh/pb-adv.h"
 #include "mesh/mesh.h"
 #include "mesh/agent.h"
+#include "mesh/error.h"
 
 /* Quick size sanity check */
 static const uint16_t expected_pdu_size[] = {
@@ -77,6 +78,7 @@ enum int_state {
 #define MAT_SECRET	(MAT_REMOTE_PUBLIC | MAT_LOCAL_PRIVATE)
 
 struct mesh_prov_initiator {
+	mesh_prov_initiator_start_func_t start_cb;
 	mesh_prov_initiator_complete_func_t complete_cb;
 	mesh_prov_initiator_data_req_func_t data_req_cb;
 	prov_trans_tx_t trans_tx;
@@ -102,6 +104,7 @@ struct mesh_prov_initiator {
 	uint8_t private_key[32];
 	uint8_t secret[32];
 	uint8_t rand_auth_workspace[48];
+	uint8_t uuid[16];
 };
 
 static struct mesh_prov_initiator *prov = NULL;
@@ -814,17 +817,45 @@ static void int_prov_ack(void *user_data, uint8_t msg_num)
 	}
 }
 
+static void initiator_open_cb(void *user_data, int err)
+{
+	bool result;
+
+	if (!prov)
+		return;
+
+	if (err != MESH_ERROR_NONE)
+		goto fail;
+
+	/* Always register for PB-ADV */
+	result = pb_adv_reg(true, int_prov_open, int_prov_close, int_prov_rx,
+						int_prov_ack, prov->uuid, prov);
+
+	if (!result) {
+		err = MESH_ERROR_FAILED;
+		goto fail;
+	}
+
+	if (!prov)
+		return;
+
+	prov->start_cb(prov->caller_data, MESH_ERROR_NONE);
+	return;
+fail:
+	prov->start_cb(prov->caller_data, err);
+	initiator_free();
+}
+
 bool initiator_start(enum trans_type transport,
 		uint8_t uuid[16],
 		uint16_t max_ele,
 		uint32_t timeout, /* in seconds from mesh.conf */
 		struct mesh_agent *agent,
+		mesh_prov_initiator_start_func_t start_cb,
 		mesh_prov_initiator_data_req_func_t data_req_cb,
 		mesh_prov_initiator_complete_func_t complete_cb,
 		void *node, void *caller_data)
 {
-	bool result;
-
 	/* Invoked from Add() method in mesh-api.txt, to add a
 	 * remote unprovisioned device network.
 	 */
@@ -837,19 +868,15 @@ bool initiator_start(enum trans_type transport,
 	prov->node = node;
 	prov->agent = agent;
 	prov->complete_cb = complete_cb;
+	prov->start_cb = start_cb;
 	prov->data_req_cb = data_req_cb;
 	prov->caller_data = caller_data;
 	prov->previous = -1;
+	memcpy(prov->uuid, uuid, 16);
 
-	/* Always register for PB-ADV */
-	result = pb_adv_reg(true, int_prov_open, int_prov_close, int_prov_rx,
-						int_prov_ack, uuid, prov);
-
-	if (result)
-		return true;
+	mesh_agent_refresh(prov->agent, initiator_open_cb, prov);
 
-	initiator_free();
-	return false;
+	return true;
 }
 
 void initiator_cancel(void *user_data)
diff --git a/mesh/provision.h b/mesh/provision.h
index 43f53f935..1d78ed8e2 100644
--- a/mesh/provision.h
+++ b/mesh/provision.h
@@ -100,6 +100,8 @@ typedef bool (*mesh_prov_acceptor_complete_func_t)(void *user_data,
 					uint8_t status,
 					struct mesh_prov_node_info *info);
 
+typedef void (*mesh_prov_initiator_start_func_t)(void *user_data, int err);
+
 typedef bool (*mesh_prov_initiator_data_req_func_t)(void *user_data,
 							uint8_t num_elem);
 
@@ -120,6 +122,7 @@ bool initiator_start(enum trans_type transport,
 		uint16_t max_ele,
 		uint32_t timeout, /* in seconds from mesh.conf */
 		struct mesh_agent *agent,
+		mesh_prov_initiator_start_func_t start_cb,
 		mesh_prov_initiator_data_req_func_t data_req_cb,
 		mesh_prov_initiator_complete_func_t complete_cb,
 		void *node, void *caller_data);
-- 
2.20.1

