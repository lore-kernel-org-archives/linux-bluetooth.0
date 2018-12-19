Return-Path: <SRS0=/IWC=O4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547D0C43387
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 04:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B8921871
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 04:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbeLSEVs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Dec 2018 23:21:48 -0500
Received: from mga04.intel.com ([192.55.52.120]:4189 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbeLSEVs (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Dec 2018 23:21:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 20:21:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,371,1539673200"; 
   d="scan'208";a="99820265"
Received: from bgix-dell-lap.sea.intel.com ([10.252.192.41])
  by orsmga007.jf.intel.com with ESMTP; 18 Dec 2018 20:21:47 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     johan.hedberg@gmail.com, inga.stotland@intel.com,
        marcel@holtmann.org, brian.gix@intel.com
Subject: [PATCH BlueZ v5 21/30] mesh: DBUS interface for Provisioning Agent
Date:   Tue, 18 Dec 2018 20:20:07 -0800
Message-Id: <20181219042016.25538-22-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181219042016.25538-1-brian.gix@intel.com>
References: <20181219042016.25538-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Inga Stotland <inga.stotland@intel.com>

---
 mesh/agent.c | 664 ++++++++++++++++++++++++++++++++++++++++++++++++-----------
 mesh/agent.h |  68 ++++--
 2 files changed, 589 insertions(+), 143 deletions(-)

diff --git a/mesh/agent.c b/mesh/agent.c
index 1da10b7bd..0ab06c4eb 100644
--- a/mesh/agent.c
+++ b/mesh/agent.c
@@ -22,208 +22,626 @@
 #include <config.h>
 #endif
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdbool.h>
-#include <string.h>
-#include <inttypes.h>
-
 #include <ell/ell.h>
 
-#include "src/shared/shell.h"
-
-#include "mesh/util.h"
+#include "mesh/mesh.h"
+#include "mesh/provision.h"
+#include "mesh/error.h"
+#include "mesh/dbus.h"
 #include "mesh/agent.h"
 
-struct input_request {
-	enum oob_type type;
-	uint16_t len;
-	agent_input_cb cb;
+typedef enum {
+	MESH_AGENT_REQUEST_BLINK,
+	MESH_AGENT_REQUEST_BEEP,
+	MESH_AGENT_REQUEST_VIBRATE,
+	MESH_AGENT_REQUEST_OUT_NUMERIC,
+	MESH_AGENT_REQUEST_OUT_ALPHA,
+	MESH_AGENT_REQUEST_PUSH,
+	MESH_AGENT_REQUEST_TWIST,
+	MESH_AGENT_REQUEST_IN_NUMERIC,
+	MESH_AGENT_REQUEST_IN_ALPHA,
+	MESH_AGENT_REQUEST_STATIC_OOB,
+	MESH_AGENT_REQUEST_PRIVATE_KEY,
+	MESH_AGENT_REQUEST_PUBLIC_KEY
+} agent_request_type_t;
+
+struct agent_request {
+	agent_request_type_t type;
+	struct l_dbus_message *msg;
+	void *cb;
 	void *user_data;
 };
 
-static struct input_request pending_request = {NONE, 0, NULL, NULL};
+struct mesh_agent {
+	char *path;
+	char *owner;
+	struct mesh_agent_prov_caps caps;
+	struct agent_request *req;
+};
 
-bool agent_completion(void)
-{
-	if (pending_request.type == NONE)
-		return false;
+struct prov_action {
+	const char *action;
+	uint16_t output;
+	uint16_t input;
+	uint8_t size;
+};
+
+struct oob_info {
+	const char *oob;
+	uint16_t mask;
+};
+
+static struct prov_action cap_table[] = {
+	{"blink", 0x0001, 0x0000, 1},
+	{"beep", 0x0002, 0x0000, 1},
+	{"vibrate", 0x0004, 0x0000, 1},
+	{"out-numeric", 0x0008, 0x0000, 8},
+	{"out-alpha", 0x0010, 0x0000, 8},
+	{"push", 0x0000, 0x0001, 1},
+	{"twist", 0x0000, 0x0002, 1},
+	{"in-numeric", 0x0000, 0x0004, 8},
+	{"in-alpha", 0x0000, 0x0008, 8}
+};
 
-	return true;
+static struct oob_info oob_table[] = {
+	{"other", 0x0001},
+	{"uri", 0x0002},
+	{"machine-code-2d", 0x0004},
+	{"barcode", 0x0008},
+	{"nfc", 0x0010},
+	{"number", 0x0020},
+	{"string", 0x0040},
+	{"on-box", 0x0800},
+	{"in-box", 0x1000},
+	{"on-paper", 0x2000},
+	{"in-manual", 0x4000},
+	{"on-device", 0x8000}
+};
+
+static struct l_queue *agents;
+
+static bool simple_match(const void *a, const void *b)
+{
+	return a == b;
 }
 
-static void reset_input_request(void)
+static void parse_prov_caps(struct mesh_agent_prov_caps *caps,
+				struct l_dbus_message_iter *property)
 {
-	pending_request.type = NONE;
-	pending_request.len = 0;
-	pending_request.cb = NULL;
-	pending_request.user_data = NULL;
+	struct l_dbus_message_iter iter_caps;
+	const char *str;
+	uint32_t i;
+
+	if (!l_dbus_message_iter_get_variant(property, "as", &iter_caps))
+		return;
+
+	while (l_dbus_message_iter_next_entry(&iter_caps, &str)) {
+		for (i = 0; i < L_ARRAY_SIZE(cap_table); i++) {
+			if (strcmp(str, cap_table[i].action))
+				continue;
+
+			caps->output_action |= cap_table[i].output;
+			if (cap_table[i].output &&
+					caps->output_size < cap_table[i].size)
+				caps->output_size = cap_table[i].size;
+
+			caps->input_action |= cap_table[i].input;
+			if (cap_table[i].input &&
+					caps->input_size < cap_table[i].size)
+				caps->input_size = cap_table[i].size;
+
+			break;
+		}
+
+		if (!strcmp(str, "PublicOOB"))
+			caps->pub_type = 1;
+		else if (!strcmp(str, "StaticOOB"))
+			caps->static_type = 1;
+	}
+
 }
 
-static void try_again(void)
+static void parse_oob_info(struct mesh_agent_prov_caps *caps,
+				struct l_dbus_message_iter *property)
 {
-	static int try_count;
-	enum oob_type type = pending_request.type;
+	struct l_dbus_message_iter iter_oob;
+	uint32_t i;
+	const char *str;
 
-	if (try_count == 2) {
-		reset_input_request();
-		try_count = 0;
+	if (!l_dbus_message_iter_get_variant(property, "as", &iter_oob))
 		return;
+
+	while (l_dbus_message_iter_next_entry(&iter_oob, &str)) {
+		for (i = 0; i < L_ARRAY_SIZE(oob_table); i++) {
+			if (strcmp(str, oob_table[i].oob))
+				continue;
+			caps->oob_info |= oob_table[i].mask;
+		}
 	}
+}
 
-	pending_request.type = NONE;
-	agent_input_request(type, pending_request.len, pending_request.cb,
-						pending_request.user_data);
+static void agent_free(void *agent_data)
+{
+	struct mesh_agent *agent = agent_data;
+	int err;
+	mesh_agent_cb_t simple_cb;
+	mesh_agent_key_cb_t key_cb;
+	mesh_agent_number_cb_t number_cb;
 
-	try_count++;
+	if (!l_queue_find(agents, simple_match, agent))
+		return;
+
+	err = MESH_ERROR_DOES_NOT_EXIST;
+
+	if (agent->req && agent->req->cb) {
+		struct agent_request *req = agent->req;
+
+		switch (req->type) {
+		case MESH_AGENT_REQUEST_PUSH:
+		case MESH_AGENT_REQUEST_TWIST:
+		case MESH_AGENT_REQUEST_IN_NUMERIC:
+			number_cb = req->cb;
+			number_cb(req->user_data, err, 0);
+			break;
+		case MESH_AGENT_REQUEST_IN_ALPHA:
+		case MESH_AGENT_REQUEST_STATIC_OOB:
+		case MESH_AGENT_REQUEST_PRIVATE_KEY:
+		case MESH_AGENT_REQUEST_PUBLIC_KEY:
+			key_cb = req->cb;
+			key_cb(req->user_data, err, NULL, 0);
+			break;
+		case MESH_AGENT_REQUEST_BLINK:
+		case MESH_AGENT_REQUEST_BEEP:
+		case MESH_AGENT_REQUEST_VIBRATE:
+		case MESH_AGENT_REQUEST_OUT_NUMERIC:
+		case MESH_AGENT_REQUEST_OUT_ALPHA:
+			simple_cb = agent->req->cb;
+			simple_cb(req->user_data, err);
+		default:
+			break;
+		}
+
+		l_dbus_message_unref(req->msg);
+		l_free(req);
+	}
+
+	l_free(agent->path);
+	l_free(agent->owner);
 }
 
-static void response_hexadecimal(const char *input, void *user_data)
+void mesh_agent_remove(struct mesh_agent *agent)
 {
-	uint8_t buf[MAX_HEXADECIMAL_OOB_LEN];
+	if (!l_queue_find(agents, simple_match, agent))
+		return;
 
-	if (!str2hex(input, strlen(input), buf, pending_request.len)) {
-		bt_shell_printf("Incorrect input: expecting %d hex octets\n",
-							pending_request.len);
-		try_again();
+	agent_free(agent);
+	l_queue_remove(agents, agent);
+}
+
+void mesh_agent_cleanup(void)
+{
+	if (!agents)
 		return;
+
+	l_queue_destroy(agents, agent_free);
+
+}
+
+void mesh_agent_init(void)
+{
+	if (!agents)
+		agents = l_queue_new();
+}
+
+struct mesh_agent *mesh_agent_create(const char *path, const char *owner,
+					struct l_dbus_message_iter *properties)
+{
+	struct mesh_agent *agent;
+	const char *key, *uri_string;
+	struct l_dbus_message_iter variant;
+
+	agent = l_new(struct mesh_agent, 1);
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
 	}
 
-	if (pending_request.cb)
-		pending_request.cb(HEXADECIMAL, buf, pending_request.len,
-					pending_request.user_data);
+	agent->owner = l_strdup(owner);
+	agent->path = l_strdup(path);
+
+	l_queue_push_tail(agents, agent);
+
+	return agent;
+}
+
+struct mesh_agent_prov_caps *mesh_agent_get_caps(struct mesh_agent *agent)
+{
+	if (!agent || !l_queue_find(agents, simple_match, agent))
+		return NULL;
+
+	return &agent->caps;
+}
+
+static struct agent_request *create_request(agent_request_type_t type,
+						void *cb, void *data)
+{
+	struct agent_request *req;
+
+	req = l_new(struct agent_request, 1);
 
-	reset_input_request();
+	req->type = type;
+	req->cb = cb;
+	req->user_data = data;
+
+	return req;
 }
 
-static void response_decimal(const char *input, void *user_data)
+static int get_reply_error(struct l_dbus_message *reply)
 {
-	uint8_t buf[DECIMAL_OOB_LEN];
+	const char *name, *desc;
+
+	if (l_dbus_message_is_error(reply)) {
 
-	if (strlen(input) > pending_request.len) {
-		bt_shell_printf("Bad input: expected no more than %d digits\n",
-						pending_request.len);
-		try_again();
+		l_dbus_message_get_error(reply, &name, &desc);
+		l_error("Agent failed output action (%s), %s", name, desc);
+		return MESH_ERROR_FAILED;
+	}
+
+	return MESH_ERROR_NONE;
+}
+
+static void simple_reply(struct l_dbus_message *reply, void *user_data)
+{
+	struct mesh_agent *agent = user_data;
+	struct agent_request *req;
+	mesh_agent_cb_t cb;
+	int err;
+
+	if (!l_queue_find(agents, simple_match, agent) || !agent->req)
 		return;
+
+	req = agent->req;
+
+	err = get_reply_error(reply);
+
+	l_dbus_message_unref(req->msg);
+
+	if (req->cb) {
+		cb = req->cb;
+		cb(req->user_data, err);
 	}
 
-	l_put_be32(atoi(input), buf);
+	l_free(req);
+	agent->req = NULL;
+}
+
+static void numeric_reply(struct l_dbus_message *reply, void *user_data)
+{
+	struct mesh_agent *agent = user_data;
+	struct agent_request *req;
+	mesh_agent_number_cb_t cb;
+	uint32_t count;
+	int err;
+
+	if (!l_queue_find(agents, simple_match, agent) || !agent->req)
+		return;
 
-	if (pending_request.cb)
-		pending_request.cb(DECIMAL, buf, DECIMAL_OOB_LEN,
-					pending_request.user_data);
+	req = agent->req;
 
-	reset_input_request();
+	err = get_reply_error(reply);
+
+	count = 0;
+
+	if (err == MESH_ERROR_NONE) {
+		if (!l_dbus_message_get_arguments(reply, "u", &count)) {
+			l_error("Failed to retrieve numeric input");
+			err = MESH_ERROR_FAILED;
+		}
+	}
+
+	l_dbus_message_unref(req->msg);
+
+	if (req->cb) {
+		cb = req->cb;
+		cb(req->user_data, err, count);
+	}
+
+	l_free(req);
+	agent->req = NULL;
 }
 
-static void response_ascii(const char *input, void *user_data)
+static void key_reply(struct l_dbus_message *reply, void *user_data)
 {
-	if (pending_request.cb)
-		pending_request.cb(ASCII, (uint8_t *) input, strlen(input),
-					pending_request.user_data);
+	struct mesh_agent *agent = user_data;
+	struct agent_request *req;
+	mesh_agent_key_cb_t cb;
+	struct l_dbus_message_iter iter_array;
+	uint32_t n = 0, expected_len = 0;
+	uint8_t buf[64];
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
+		goto done;
+
+	if (!l_dbus_message_get_arguments(reply, "au", &iter_array)) {
+		l_error("Failed to retrieve key input");
+		err = MESH_ERROR_FAILED;
+		goto done;
+	}
+
+	if (!l_dbus_message_iter_get_fixed_array(&iter_array, buf, &n)) {
+		l_error("Failed to retrieve key input");
+		err = MESH_ERROR_FAILED;
+		goto done;
+	}
+
+	if (req->type == MESH_AGENT_REQUEST_PRIVATE_KEY)
+		expected_len = 32;
+	else if (MESH_AGENT_REQUEST_PUBLIC_KEY)
+		expected_len = 64;
+	else
+		expected_len = 16;
+
+	if (n != expected_len) {
+		l_error("Bad response length: %u (need %u)", n, expected_len);
+		err = MESH_ERROR_FAILED;
+		n = 0;
+	}
 
-	reset_input_request();
+done:
+	l_dbus_message_unref(req->msg);
+
+	if (req->cb) {
+		cb = req->cb;
+		cb(req->user_data, err, buf, n);
+	}
+
+	l_free(req);
+	agent->req = NULL;
 }
 
-static bool request_hexadecimal(uint16_t len)
+static int output_request(struct mesh_agent *agent, const char *action,
+					agent_request_type_t type, uint32_t cnt,
+					void *cb, void *user_data)
 {
-	if (len > MAX_HEXADECIMAL_OOB_LEN)
-		return false;
+	struct l_dbus *dbus = dbus_get_bus();
+	struct l_dbus_message *msg;
+	struct l_dbus_message_builder *builder;
+
+	if (!l_queue_find(agents, simple_match, agent))
+		return MESH_ERROR_DOES_NOT_EXIST;
+
+	if (agent->req)
+		return MESH_ERROR_BUSY;
 
-	bt_shell_printf("Request hexadecimal key (hex %d octets)\n", len);
-	bt_shell_prompt_input("mesh", "Enter key (hex number):",
-						response_hexadecimal, NULL);
+	agent->req = create_request(type, cb, user_data);
+	msg = l_dbus_message_new_method_call(dbus, agent->owner, agent->path,
+						MESH_PROVISION_AGENT_INTERFACE,
+						"DisplayNumeric");
+
+	builder = l_dbus_message_builder_new(msg);
+	l_dbus_message_builder_append_basic(builder, 's', action);
+	l_dbus_message_builder_append_basic(builder, 'u', &cnt);
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+
+	l_debug("Send DisplayNumeric request to %s %s",
+						agent->owner, agent->path);
+
+	l_dbus_send_with_reply(dbus_get_bus(), msg, simple_reply, agent,
+									NULL);
 
-	return true;
+	agent->req->msg = l_dbus_message_ref(msg);
+
+	return MESH_ERROR_NONE;
 }
 
-static uint32_t power_ten(uint8_t power)
+static int prompt_input(struct mesh_agent *agent, const char *action,
+					agent_request_type_t type, bool numeric,
+					void *cb, void *user_data)
 {
-	uint32_t ret = 1;
+	struct l_dbus *dbus = dbus_get_bus();
+	struct l_dbus_message *msg;
+	struct l_dbus_message_builder *builder;
+	const char *method_name;
+	l_dbus_message_func_t reply_cb;
+
+	if (!l_queue_find(agents, simple_match, agent))
+		return MESH_ERROR_DOES_NOT_EXIST;
+
+	if (agent->req)
+		return MESH_ERROR_BUSY;
+
+	agent->req = create_request(type, cb, user_data);
+
+	method_name = numeric ? "PromptNumeric" : "PromptStatic";
+
+	msg = l_dbus_message_new_method_call(dbus, agent->owner,
+						agent->path,
+						MESH_PROVISION_AGENT_INTERFACE,
+						method_name);
+
+	builder = l_dbus_message_builder_new(msg);
+	l_dbus_message_builder_append_basic(builder, 's', action);
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+
+	l_debug("Send \"%s\" input request to %s %s", action,
+						agent->owner, agent->path);
 
-	while (power--)
-		ret *= 10;
+	reply_cb = numeric ? numeric_reply : key_reply;
 
-	return ret;
+	l_dbus_send_with_reply(dbus_get_bus(), msg, reply_cb, agent, NULL);
+
+	agent->req->msg = l_dbus_message_ref(msg);
+
+	return MESH_ERROR_NONE;
 }
 
-static bool request_decimal(uint16_t len)
+static int request_key(struct mesh_agent *agent,
+					agent_request_type_t type,
+					void *cb, void *user_data)
 {
-	bt_shell_printf("Request decimal key (0 - %d)\n", power_ten(len) - 1);
-	bt_shell_prompt_input("mesh", "Enter Numeric key:", response_decimal,
+	struct l_dbus *dbus = dbus_get_bus();
+	struct l_dbus_message *msg;
+	const char *method_name;
+
+	if (!l_queue_find(agents, simple_match, agent))
+		return MESH_ERROR_DOES_NOT_EXIST;
+
+	if (agent->req)
+		return MESH_ERROR_BUSY;
+
+	agent->req = create_request(type, cb, user_data);
+
+	method_name = (type == MESH_AGENT_REQUEST_PRIVATE_KEY) ?
+						"PrivateKey" : "PublicKey";
+
+	msg = l_dbus_message_new_method_call(dbus, agent->owner,
+						agent->path,
+						MESH_PROVISION_AGENT_INTERFACE,
+						method_name);
+
+	l_debug("Send key request to %s %s", agent->owner, agent->path);
+
+	l_dbus_send_with_reply(dbus_get_bus(), msg, key_reply, agent, NULL);
+
+	agent->req->msg = l_dbus_message_ref(msg);
+
+	return MESH_ERROR_NONE;
+}
+
+int mesh_agent_display_string(struct mesh_agent *agent, const char *str,
+				mesh_agent_cb_t cb, void *user_data)
+{
+	struct l_dbus *dbus = dbus_get_bus();
+	struct l_dbus_message *msg;
+	struct l_dbus_message_builder *builder;
+
+	if (!l_queue_find(agents, simple_match, agent))
+		return MESH_ERROR_DOES_NOT_EXIST;
+
+	if (agent->req)
+		return MESH_ERROR_BUSY;
+
+	agent->req = create_request(MESH_AGENT_REQUEST_OUT_ALPHA,
+								cb, user_data);
+	msg = l_dbus_message_new_method_call(dbus, agent->owner, agent->path,
+						MESH_PROVISION_AGENT_INTERFACE,
+						"DisplayString");
+
+	builder = l_dbus_message_builder_new(msg);
+	l_dbus_message_builder_append_basic(builder, 's', str);
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+
+	l_debug("Send DisplayString request to %s %s",
+						agent->owner, agent->path);
+
+	l_dbus_send_with_reply(dbus_get_bus(), msg, simple_reply, agent,
 									NULL);
 
-	return true;
+	agent->req->msg = l_dbus_message_ref(msg);
+
+	return MESH_ERROR_NONE;
+
 }
 
-static bool request_ascii(uint16_t len)
+int mesh_agent_display_number(struct mesh_agent *agent, bool initiator,
+					uint8_t action, uint32_t count,
+					mesh_agent_cb_t cb, void *user_data)
 {
-	if (len > MAX_ASCII_OOB_LEN)
-		return false;
+	const char *str_type;
+	agent_request_type_t type;
+
+	type = action;
+
+	if (initiator)
+		type = action + MESH_AGENT_REQUEST_PUSH;
+
+	if (type >= L_ARRAY_SIZE(cap_table))
+		return MESH_ERROR_INVALID_ARGS;
 
-	bt_shell_printf("Request ASCII key (max characters %d)\n", len);
-	bt_shell_prompt_input("mesh", "Enter key (ascii string):",
-							response_ascii, NULL);
+	str_type = cap_table[type].action;
 
-	return true;
+	return output_request(agent, str_type, type, count, cb, user_data);
 }
 
-bool agent_input_request(enum oob_type type, uint16_t max_len,
-					agent_input_cb cb, void *user_data)
+int mesh_agent_prompt_number(struct mesh_agent *agent, bool initiator,
+						uint8_t action,
+						mesh_agent_number_cb_t cb,
+						void *user_data)
 {
-	bool result;
+	const char *str_type;
+	agent_request_type_t type;
 
-	if (pending_request.type != NONE)
-		return false;
+	type = action;
 
-	switch (type) {
-	case HEXADECIMAL:
-		result = request_hexadecimal(max_len);
-		break;
-	case DECIMAL:
-		result = request_decimal(max_len);
-		break;
-	case ASCII:
-		result = request_ascii(max_len);
-		break;
-	case NONE:
-	case OUTPUT:
-	default:
-		return false;
-	};
+	if (!initiator)
+		type = action + MESH_AGENT_REQUEST_PUSH;
 
-	if (result) {
-		pending_request.type = type;
-		pending_request.len = max_len;
-		pending_request.cb = cb;
-		pending_request.user_data = user_data;
+	if (type >= L_ARRAY_SIZE(cap_table))
+		return MESH_ERROR_INVALID_ARGS;
 
-		return true;
-	}
+	str_type = cap_table[type].action;
+
+	return prompt_input(agent, str_type, type, true, cb, user_data);
+}
 
-	return false;
+int mesh_agent_prompt_alpha(struct mesh_agent *agent, mesh_agent_key_cb_t cb,
+								void *user_data)
+{
+	return prompt_input(agent, "in-alpha", MESH_AGENT_REQUEST_IN_ALPHA,
+							false, cb, user_data);
 }
 
-static void response_output(const char *input, void *user_data)
+int mesh_agent_request_static(struct mesh_agent *agent, mesh_agent_key_cb_t cb,
+								void *user_data)
 {
-	reset_input_request();
+	return prompt_input(agent, "static-oob", MESH_AGENT_REQUEST_STATIC_OOB,
+							false, cb, user_data);
 }
 
-bool agent_output_request(const char *str)
+int mesh_agent_request_private_key(struct mesh_agent *agent,
+				mesh_agent_key_cb_t cb, void *user_data)
 {
-	if (pending_request.type != NONE)
-		return false;
+	return request_key(agent, MESH_AGENT_REQUEST_PRIVATE_KEY, cb,
+								user_data);
 
-	pending_request.type = OUTPUT;
-	bt_shell_prompt_input("mesh", str, response_output, NULL);
-	return true;
 }
 
-void agent_output_request_cancel(void)
+int mesh_agent_request_public_key(struct mesh_agent *agent,
+				mesh_agent_key_cb_t cb, void *user_data)
 {
-	if (pending_request.type != OUTPUT)
+	return request_key(agent, MESH_AGENT_REQUEST_PUBLIC_KEY, cb,
+								user_data);
+}
+
+void mesh_agent_cancel(struct mesh_agent *agent)
+{
+	struct l_dbus *dbus = dbus_get_bus();
+	struct l_dbus_message *msg;
+
+	if (!l_queue_find(agents, simple_match, agent))
 		return;
 
-	pending_request.type = NONE;
-	bt_shell_release_prompt("");
+	msg = l_dbus_message_new_method_call(dbus, agent->owner, agent->path,
+						MESH_PROVISION_AGENT_INTERFACE,
+						"Cancel");
+	l_dbus_send(dbus, msg);
 }
diff --git a/mesh/agent.h b/mesh/agent.h
index 6fb475691..29cb297af 100644
--- a/mesh/agent.h
+++ b/mesh/agent.h
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2017  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2018  Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
@@ -18,25 +18,53 @@
  *
  */
 
-#define MAX_HEXADECIMAL_OOB_LEN	128
-#define DECIMAL_OOB_LEN		4
-#define MAX_ASCII_OOB_LEN		16
+struct mesh_agent;
 
-enum oob_type {
-	NONE,
-	HEXADECIMAL,
-	DECIMAL,
-	ASCII,
-	OUTPUT,
-} oob_type_t;
+struct mesh_agent_prov_caps {
+	uint32_t uri_hash;
+	uint16_t oob_info;
+	uint16_t output_action;
+	uint16_t input_action;
+	uint8_t pub_type;
+	uint8_t static_type;
+	uint8_t output_size;
+	uint8_t input_size;
+};
 
-typedef void (*agent_input_cb)(enum oob_type type, void *input, uint16_t len,
+typedef void (*mesh_agent_cb_t) (void *user_data, int err);
+
+typedef void (*mesh_agent_key_cb_t) (void *user_data, int err, uint8_t *key,
+								uint32_t len);
+
+typedef void (*mesh_agent_number_cb_t) (void *user_data, int err,
+							uint32_t number);
+
+void mesh_agent_init(void);
+void mesh_agent_cleanup(void);
+struct mesh_agent *mesh_agent_create(const char *path, const char *owner,
+					struct l_dbus_message_iter *properties);
+
+void mesh_agent_remove(struct mesh_agent *agent);
+void mesh_agent_cancel(struct mesh_agent *agent);
+
+struct mesh_agent_prov_caps *mesh_agent_get_caps(struct mesh_agent *agent);
+
+int mesh_agent_display_number(struct mesh_agent *agent, bool initiator,
+					uint8_t action, uint32_t count,
+					mesh_agent_cb_t cb, void *user_data);
+int mesh_agent_prompt_number(struct mesh_agent *agent, bool initiator,
+				uint8_t action, mesh_agent_number_cb_t cb,
+				void *user_data);
+int mesh_agent_prompt_alpha(struct mesh_agent *agent, mesh_agent_key_cb_t cb,
+							void *user_data);
+int mesh_agent_request_static(struct mesh_agent *agent, mesh_agent_key_cb_t cb,
+							void *user_data);
+int mesh_agent_request_private_key(struct mesh_agent *agent,
+							mesh_agent_key_cb_t cb,
+							void *user_data);
+int mesh_agent_request_public_key(struct mesh_agent *agent,
+							mesh_agent_key_cb_t cb,
+							void *user_data);
+int mesh_agent_display_string(struct mesh_agent *agent, const char *str,
+							mesh_agent_cb_t cb,
 							void *user_data);
-bool agent_input_request(enum oob_type type, uint16_t max_len,
-					agent_input_cb cb, void *user_data);
-
-bool agent_output_request(const char *str);
-void agent_output_request_cancel(void);
-bool agent_completion(void);
-bool agent_input(const char *input);
-void agent_release(void);
-- 
2.14.5

