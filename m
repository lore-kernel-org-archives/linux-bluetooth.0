Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55533C43461
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 18:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D78161353
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 18:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhESSXd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 May 2021 14:23:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:32196 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231349AbhESSXb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 May 2021 14:23:31 -0400
IronPort-SDR: 7opeTBdAjsvC6iogaIvrUOGO5ZmQgMDt3OZIa+3k7UigoA/lQ+oXN7rwAKCiAm/YRU6yoU5xdH
 PVIlYYYw7ROA==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="188175127"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="188175127"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 11:22:10 -0700
IronPort-SDR: L+lgoYgn2WKlzko5HSRYu7I4NIVjMFHEODsXDRNtxk9LE6gUxL+WMz2besUCmUsGAWdA4inb2m
 6wNbzWgYtdIA==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="439838662"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.212.229.7])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 11:22:09 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ v2 5/5] mesh: Add single threading to prov-acp ob messaging
Date:   Wed, 19 May 2021 11:21:50 -0700
Message-Id: <20210519182150.1680987-6-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210519182150.1680987-1-brian.gix@intel.com>
References: <20210519182150.1680987-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Certain IOP and stress testing scenarios can cause additional outbound
messages to be attempted before the prior outbound message completes.
This patch adds queuing if outbpund messages are attempted too quickly
so that the additional message is not sent until the prior message is
ACKed.
---
 mesh/prov-acceptor.c | 88 +++++++++++++++++++++++++++-----------------
 mesh/provision.h     |  1 +
 2 files changed, 56 insertions(+), 33 deletions(-)

diff --git a/mesh/prov-acceptor.c b/mesh/prov-acceptor.c
index 0dbb84f50..f579a143b 100644
--- a/mesh/prov-acceptor.c
+++ b/mesh/prov-acceptor.c
@@ -42,26 +42,15 @@ static const uint16_t expected_pdu_size[] = {
 
 #define BEACON_TYPE_UNPROVISIONED		0x00
 
+struct deferred_cmd {
+	uint16_t len;
+	uint8_t cmd[];
+};
+
 static const uint8_t pkt_filter = MESH_AD_TYPE_PROVISION;
 static const uint8_t bec_filter[] = {MESH_AD_TYPE_BEACON,
 						BEACON_TYPE_UNPROVISIONED};
 
-enum acp_state {
-	ACP_PROV_IDLE = 0,
-	ACP_PROV_CAPS_SENT,
-	ACP_PROV_CAPS_ACKED,
-	ACP_PROV_KEY_SENT,
-	ACP_PROV_KEY_ACKED,
-	ACP_PROV_INP_CMPLT_SENT,
-	ACP_PROV_INP_CMPLT_ACKED,
-	ACP_PROV_CONF_SENT,
-	ACP_PROV_CONF_ACKED,
-	ACP_PROV_RAND_SENT,
-	ACP_PROV_RAND_ACKED,
-	ACP_PROV_CMPLT_SENT,
-	ACP_PROV_FAIL_SENT,
-};
-
 #define MAT_REMOTE_PUBLIC	0x01
 #define MAT_LOCAL_PRIVATE	0x02
 #define MAT_RAND_AUTH		0x04
@@ -70,12 +59,13 @@ enum acp_state {
 struct mesh_prov_acceptor {
 	mesh_prov_acceptor_complete_func_t cmplt;
 	prov_trans_tx_t trans_tx;
+	struct l_queue *ob;
 	void *agent;
 	void *caller_data;
 	void *trans_data;
 	struct l_timeout *timeout;
 	uint32_t to_secs;
-	enum acp_state	state;
+	uint8_t out_opcode;
 	uint8_t transport;
 	uint8_t material;
 	uint8_t expected;
@@ -99,6 +89,7 @@ static void acceptor_free(void)
 		return;
 
 	l_timeout_remove(prov->timeout);
+	l_queue_destroy(prov->ob, l_free);
 
 	mesh_send_cancel(bec_filter, sizeof(bec_filter));
 	mesh_send_cancel(&pkt_filter, sizeof(pkt_filter));
@@ -126,6 +117,21 @@ static void acp_prov_close(void *user_data, uint8_t reason)
 	acceptor_free();
 }
 
+static void prov_send(struct mesh_prov_acceptor *prov, void *cmd, uint16_t len)
+{
+	struct deferred_cmd *defer;
+
+	if (prov->out_opcode == PROV_NONE) {
+		prov->out_opcode = *(uint8_t *) cmd;
+		prov->trans_tx(prov->trans_data, cmd, len);
+	} else {
+		defer = l_malloc(len + sizeof(struct deferred_cmd));
+		defer->len = len;
+		memcpy(defer->cmd, cmd, len);
+		l_queue_push_tail(prov->ob, defer);
+	}
+}
+
 static void prov_to(struct l_timeout *timeout, void *user_data)
 {
 	struct mesh_prov_acceptor *rx_prov = user_data;
@@ -140,7 +146,7 @@ static void prov_to(struct l_timeout *timeout, void *user_data)
 	if (prov->cmplt && prov->trans_tx) {
 		prov->cmplt(prov->caller_data, PROV_ERR_TIMEOUT, NULL);
 		prov->cmplt = NULL;
-		prov->trans_tx(prov->trans_data, fail_code, 2);
+		prov_send(prov, fail_code, 2);
 		prov->timeout = l_timeout_create(1, prov_to, prov, NULL);
 		return;
 	}
@@ -258,7 +264,7 @@ static void number_cb(void *user_data, int err, uint32_t number)
 	if (err) {
 		msg.opcode = PROV_FAILED;
 		msg.reason = PROV_ERR_UNEXPECTED_ERR;
-		prov->trans_tx(prov->trans_data, &msg, sizeof(msg));
+		prov_send(prov, &msg, sizeof(msg));
 		return;
 	}
 
@@ -267,7 +273,7 @@ static void number_cb(void *user_data, int err, uint32_t number)
 	l_put_be32(number, prov->rand_auth_workspace + 44);
 	prov->material |= MAT_RAND_AUTH;
 	msg.opcode = PROV_INP_CMPLT;
-	prov->trans_tx(prov->trans_data, &msg.opcode, 1);
+	prov_send(prov, &msg.opcode, 1);
 }
 
 static void static_cb(void *user_data, int err, uint8_t *key, uint32_t len)
@@ -281,7 +287,7 @@ static void static_cb(void *user_data, int err, uint8_t *key, uint32_t len)
 	if (err || !key || len != 16) {
 		msg.opcode = PROV_FAILED;
 		msg.reason = PROV_ERR_UNEXPECTED_ERR;
-		prov->trans_tx(prov->trans_data, &msg, sizeof(msg));
+		prov_send(prov, &msg, sizeof(msg));
 		return;
 	}
 
@@ -292,7 +298,7 @@ static void static_cb(void *user_data, int err, uint8_t *key, uint32_t len)
 
 	if (prov->conf_inputs.start.auth_action == PROV_ACTION_IN_ALPHA) {
 		msg.opcode = PROV_INP_CMPLT;
-		prov->trans_tx(prov->trans_data, &msg.opcode, 1);
+		prov_send(prov, &msg.opcode, 1);
 	}
 }
 
@@ -307,7 +313,7 @@ static void priv_key_cb(void *user_data, int err, uint8_t *key, uint32_t len)
 	if (err || !key || len != 32) {
 		msg.opcode = PROV_FAILED;
 		msg.reason = PROV_ERR_UNEXPECTED_ERR;
-		prov->trans_tx(prov->trans_data, &msg, sizeof(msg));
+		prov_send(prov, &msg, sizeof(msg));
 		return;
 	}
 
@@ -326,7 +332,7 @@ static void priv_key_cb(void *user_data, int err, uint8_t *key, uint32_t len)
 		if (!acp_credentials(prov)) {
 			msg.opcode = PROV_FAILED;
 			msg.reason = PROV_ERR_UNEXPECTED_ERR;
-			prov->trans_tx(prov->trans_data, &msg, sizeof(msg));
+			prov_send(prov, &msg, sizeof(msg));
 		}
 	}
 }
@@ -339,9 +345,8 @@ static void send_caps(struct mesh_prov_acceptor *prov)
 	memcpy(&msg.caps, &prov->conf_inputs.caps,
 			sizeof(prov->conf_inputs.caps));
 
-	prov->state = ACP_PROV_CAPS_SENT;
 	prov->expected = PROV_START;
-	prov->trans_tx(prov->trans_data, &msg, sizeof(msg));
+	prov_send(prov, &msg, sizeof(msg));
 }
 
 static void send_pub_key(struct mesh_prov_acceptor *prov)
@@ -350,7 +355,7 @@ static void send_pub_key(struct mesh_prov_acceptor *prov)
 
 	msg.opcode = PROV_PUB_KEY;
 	memcpy(msg.pub_key, prov->conf_inputs.dev_pub_key, sizeof(msg.pub_key));
-	prov->trans_tx(prov->trans_data, &msg, sizeof(msg));
+	prov_send(prov, &msg, sizeof(msg));
 }
 
 static bool send_conf(struct mesh_prov_acceptor *prov)
@@ -365,7 +370,7 @@ static bool send_conf(struct mesh_prov_acceptor *prov)
 	if (!memcmp(msg.conf, prov->confirm, sizeof(msg.conf)))
 		return false;
 
-	prov->trans_tx(prov->trans_data, &msg, sizeof(msg));
+	prov_send(prov, &msg, sizeof(msg));
 	return true;
 }
 
@@ -375,7 +380,7 @@ static void send_rand(struct mesh_prov_acceptor *prov)
 
 	msg.opcode = PROV_RANDOM;
 	memcpy(msg.rand, prov->rand_auth_workspace, sizeof(msg.rand));
-	prov->trans_tx(prov->trans_data, &msg, sizeof(msg));
+	prov_send(prov, &msg, sizeof(msg));
 }
 
 static void acp_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
@@ -614,8 +619,7 @@ static void acp_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 
 		if (result) {
 			prov->rand_auth_workspace[0] = PROV_COMPLETE;
-			prov->trans_tx(prov->trans_data,
-					prov->rand_auth_workspace, 1);
+			prov_send(prov, prov->rand_auth_workspace, 1);
 			goto cleanup;
 		} else {
 			fail.reason = PROV_ERR_UNEXPECTED_ERR;
@@ -638,7 +642,7 @@ static void acp_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 
 failure:
 	fail.opcode = PROV_FAILED;
-	prov->trans_tx(prov->trans_data, &fail, sizeof(fail));
+	prov_send(prov, &fail, sizeof(fail));
 	if (prov->cmplt)
 		prov->cmplt(prov->caller_data, fail.reason, NULL);
 	prov->cmplt = NULL;
@@ -652,7 +656,23 @@ cleanup:
 
 static void acp_prov_ack(void *user_data, uint8_t msg_num)
 {
-	/* TODO: Handle PB-ADV Ack */
+	struct mesh_prov_acceptor *rx_prov = user_data;
+	struct deferred_cmd *deferred;
+
+	if (rx_prov != prov)
+		return;
+
+	if (prov->out_opcode == PROV_NONE)
+		return;
+
+	prov->out_opcode = PROV_NONE;
+
+	deferred = l_queue_pop_head(prov->ob);
+	if (!deferred)
+		return;
+
+	prov_send(prov, deferred->cmd, deferred->len);
+	l_free(deferred);
 }
 
 
@@ -680,7 +700,9 @@ bool acceptor_start(uint8_t num_ele, uint8_t uuid[16],
 	prov->to_secs = timeout;
 	prov->agent = agent;
 	prov->cmplt = complete_cb;
+	prov->ob = l_queue_new();
 	prov->previous = -1;
+	prov->out_opcode = PROV_NONE;
 	prov->caller_data = caller_data;
 
 	caps = mesh_agent_get_caps(agent);
diff --git a/mesh/provision.h b/mesh/provision.h
index 1a11b691b..1634c4d40 100644
--- a/mesh/provision.h
+++ b/mesh/provision.h
@@ -38,6 +38,7 @@ struct mesh_agent;
 #define PROV_DATA	0x07
 #define PROV_COMPLETE	0x08
 #define PROV_FAILED	0x09
+#define PROV_NONE	0xFF
 
 /* Spec defined Error Codes */
 #define PROV_ERR_SUCCESS		0x00
-- 
2.25.4

