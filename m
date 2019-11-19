Return-Path: <SRS0=5+i7=ZL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BBBC43215
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 21:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DB920730
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 21:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfKSVwp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Nov 2019 16:52:45 -0500
Received: from mga06.intel.com ([134.134.136.31]:30520 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbfKSVwp (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Nov 2019 16:52:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 13:52:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,219,1571727600"; 
   d="scan'208";a="357238388"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.254.179.224])
  by orsmga004.jf.intel.com with ESMTP; 19 Nov 2019 13:52:44 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com, aurelien@aurel32.net
Subject: [PATCH BlueZ v3 1/2] mesh: Fix inOOB and outOOB agent handling on prov initiate
Date:   Tue, 19 Nov 2019 13:52:26 -0800
Message-Id: <20191119215227.27730-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191119215227.27730-1-brian.gix@intel.com>
References: <20191119215227.27730-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This code fixes the Provisioner Initiator role so that the following
Out-of-Band agent calls are made correctly, and their results handled
properly:

"push", "twist", "blink", "beep", "vibrate", "in-numeric",
"out-numeric", "in-alpha", "out-alpha"
---
 mesh/agent.c          | 28 +++++++++++------
 mesh/agent.h          |  4 +--
 mesh/prov-acceptor.c  |  2 +-
 mesh/prov-initiator.c | 71 ++++++++++++++++++++++++++++++++++++-------
 4 files changed, 81 insertions(+), 24 deletions(-)

diff --git a/mesh/agent.c b/mesh/agent.c
index 4f99bad7b..5a5570ae5 100644
--- a/mesh/agent.c
+++ b/mesh/agent.c
@@ -363,7 +363,7 @@ static void key_reply(struct l_dbus_message *reply, void *user_data)
 	mesh_agent_key_cb_t cb;
 	struct l_dbus_message_iter iter_array;
 	uint32_t n = 0, expected_len = 0;
-	uint8_t buf[64];
+	uint8_t *buf;
 	int err;
 
 	if (!l_queue_find(agents, simple_match, agent) || !agent->req)
@@ -376,13 +376,13 @@ static void key_reply(struct l_dbus_message *reply, void *user_data)
 	if (err != MESH_ERROR_NONE)
 		goto done;
 
-	if (!l_dbus_message_get_arguments(reply, "au", &iter_array)) {
+	if (!l_dbus_message_get_arguments(reply, "ay", &iter_array)) {
 		l_error("Failed to retrieve key input");
 		err = MESH_ERROR_FAILED;
 		goto done;
 	}
 
-	if (!l_dbus_message_iter_get_fixed_array(&iter_array, buf, &n)) {
+	if (!l_dbus_message_iter_get_fixed_array(&iter_array, &buf, &n)) {
 		l_error("Failed to retrieve key input");
 		err = MESH_ERROR_FAILED;
 		goto done;
@@ -390,7 +390,7 @@ static void key_reply(struct l_dbus_message *reply, void *user_data)
 
 	if (req->type == MESH_AGENT_REQUEST_PRIVATE_KEY)
 		expected_len = 32;
-	else if (MESH_AGENT_REQUEST_PUBLIC_KEY)
+	else if (req->type == MESH_AGENT_REQUEST_PUBLIC_KEY)
 		expected_len = 64;
 	else
 		expected_len = 16;
@@ -402,13 +402,13 @@ static void key_reply(struct l_dbus_message *reply, void *user_data)
 	}
 
 done:
-	l_dbus_message_unref(req->msg);
-
 	if (req->cb) {
 		cb = req->cb;
 		cb(req->user_data, err, buf, n);
 	}
 
+	l_dbus_message_unref(req->msg);
+
 	l_free(req);
 	agent->req = NULL;
 }
@@ -601,11 +601,19 @@ int mesh_agent_prompt_number(struct mesh_agent *agent, bool initiator,
 	return prompt_input(agent, str_type, type, true, cb, user_data);
 }
 
-int mesh_agent_prompt_alpha(struct mesh_agent *agent, mesh_agent_key_cb_t cb,
-								void *user_data)
+int mesh_agent_prompt_alpha(struct mesh_agent *agent, bool initiator,
+					mesh_agent_key_cb_t cb, void *user_data)
 {
-	return prompt_input(agent, "in-alpha", MESH_AGENT_REQUEST_IN_ALPHA,
-							false, cb, user_data);
+	if (initiator)
+		return prompt_input(agent,
+				cap_table[MESH_AGENT_REQUEST_OUT_ALPHA].action,
+				MESH_AGENT_REQUEST_OUT_ALPHA, false, cb,
+				user_data);
+	else
+		return prompt_input(agent,
+				cap_table[MESH_AGENT_REQUEST_IN_ALPHA].action,
+				MESH_AGENT_REQUEST_IN_ALPHA, false, cb,
+				user_data);
 }
 
 int mesh_agent_request_static(struct mesh_agent *agent, mesh_agent_key_cb_t cb,
diff --git a/mesh/agent.h b/mesh/agent.h
index 0a499d2d5..80333acd5 100644
--- a/mesh/agent.h
+++ b/mesh/agent.h
@@ -54,8 +54,8 @@ int mesh_agent_display_number(struct mesh_agent *agent, bool initiator,
 int mesh_agent_prompt_number(struct mesh_agent *agent, bool initiator,
 				uint8_t action, mesh_agent_number_cb_t cb,
 				void *user_data);
-int mesh_agent_prompt_alpha(struct mesh_agent *agent, mesh_agent_key_cb_t cb,
-							void *user_data);
+int mesh_agent_prompt_alpha(struct mesh_agent *agent, bool initiator,
+				mesh_agent_key_cb_t cb, void *user_data);
 int mesh_agent_request_static(struct mesh_agent *agent, mesh_agent_key_cb_t cb,
 							void *user_data);
 int mesh_agent_request_private_key(struct mesh_agent *agent,
diff --git a/mesh/prov-acceptor.c b/mesh/prov-acceptor.c
index 57eb1e750..bca019358 100644
--- a/mesh/prov-acceptor.c
+++ b/mesh/prov-acceptor.c
@@ -479,7 +479,7 @@ static void acp_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 			if (prov->conf_inputs.start.auth_action ==
 							PROV_ACTION_IN_ALPHA) {
 				fail.reason = mesh_agent_prompt_alpha(
-					prov->agent,
+					prov->agent, false,
 					static_cb, prov);
 			} else {
 				fail.reason = mesh_agent_prompt_number(
diff --git a/mesh/prov-initiator.c b/mesh/prov-initiator.c
index 5e45d6813..7efd5b349 100644
--- a/mesh/prov-initiator.c
+++ b/mesh/prov-initiator.c
@@ -433,6 +433,54 @@ failure:
 	/* TODO: Call Complete Callback (Fail)*/
 }
 
+static void get_random_key(struct mesh_prov_initiator *prov, uint8_t action,
+								uint8_t size)
+{
+	uint32_t oob_key;
+	int i;
+
+	if (action >= PROV_ACTION_IN_ALPHA) {
+		uint8_t alpha;
+		char tmp[17];
+
+		memset(tmp, 0, sizeof(tmp));
+
+		if (size > 16)
+			size = 16;
+
+		/* Create random alphanumeric string made of 0-9, a-z, A-Z */
+		for (i = 0; i < size; i++) {
+			l_getrandom(&alpha, sizeof(alpha));
+			alpha %= (10 + 26 + 26);
+
+			if (alpha < 10)
+				alpha += '0';
+			else if (alpha < 10 + 26)
+				alpha += 'a' - 10;
+			else
+				alpha += 'A' - 10 - 26;
+
+			tmp[i] = (char) alpha;
+		}
+		memcpy(prov->rand_auth_workspace + 16, tmp, size);
+		memcpy(prov->rand_auth_workspace + 32, tmp, size);
+		return;
+	}
+
+	l_getrandom(&oob_key, sizeof(oob_key));
+
+	if (action <= PROV_ACTION_TWIST)
+		oob_key %= size;
+	else
+		oob_key %= digit_mod(size);
+
+	if (!oob_key)
+		oob_key = size;
+
+	/* Save two copies, for two confirmation values */
+	l_put_be32(oob_key, prov->rand_auth_workspace + 28);
+	l_put_be32(oob_key, prov->rand_auth_workspace + 44);
+}
 
 static void int_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 {
@@ -575,7 +623,7 @@ static void int_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 			if (prov->conf_inputs.start.auth_action ==
 							PROV_ACTION_OUT_ALPHA) {
 				fail_code[1] = mesh_agent_prompt_alpha(
-					prov->agent,
+					prov->agent, true,
 					static_cb, prov);
 			} else {
 				fail_code[1] = mesh_agent_prompt_number(
@@ -591,22 +639,22 @@ static void int_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 
 		case 3:
 			/* Auth Type 3b - input OOB */
-			l_getrandom(&oob_key, sizeof(oob_key));
-			oob_key %= digit_mod(prov->conf_inputs.start.auth_size);
+			get_random_key(prov,
+					prov->conf_inputs.start.auth_action,
+					prov->conf_inputs.start.auth_size);
+			oob_key = l_get_be32(prov->rand_auth_workspace + 28);
 
-			/* Save two copies, for two confirmation values */
-			l_put_be32(oob_key, prov->rand_auth_workspace + 28);
-			l_put_be32(oob_key, prov->rand_auth_workspace + 44);
-			prov->material |= MAT_RAND_AUTH;
-			/* Ask Agent to Display U32 */
+			/* Ask Agent to Display random key */
 			if (prov->conf_inputs.start.auth_action ==
 							PROV_ACTION_IN_ALPHA) {
-				/* TODO: Construst NUL-term string to pass */
+
 				fail_code[1] = mesh_agent_display_string(
-					prov->agent, NULL, NULL, prov);
+					prov->agent,
+					(char *) prov->rand_auth_workspace + 16,
+					NULL, prov);
 			} else {
 				fail_code[1] = mesh_agent_display_number(
-					prov->agent, false,
+					prov->agent, true,
 					prov->conf_inputs.start.auth_action,
 					oob_key, NULL, prov);
 			}
@@ -625,6 +673,7 @@ static void int_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 
 	case PROV_INP_CMPLT: /* Provisioning Input Complete */
 		/* TODO: Cancel Agent prompt */
+		prov->material |= MAT_RAND_AUTH;
 		send_confirm(prov);
 		break;
 
-- 
2.21.0

