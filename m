Return-Path: <SRS0=ssTf=VI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F717C742A2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jul 2019 23:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20571208E4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jul 2019 23:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbfGKXAv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Jul 2019 19:00:51 -0400
Received: from mga18.intel.com ([134.134.136.126]:38699 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730428AbfGKXAv (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Jul 2019 19:00:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2019 16:00:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,480,1557212400"; 
   d="scan'208";a="166516308"
Received: from bgix-dell-lap.sea.intel.com ([10.255.80.129])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jul 2019 16:00:50 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, michal.lowas-rzechonek@silvair.com,
        brian.gix@intel.com
Subject: [PATCH BlueZ v2 8/9] mesh: Convert provisioning pkts to packed structs
Date:   Thu, 11 Jul 2019 15:59:51 -0700
Message-Id: <20190711225952.1599-9-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190711225952.1599-1-brian.gix@intel.com>
References: <20190711225952.1599-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Provisioning packets are defined in the specification
as packed big endian structures. Instead of specifying
an octet array, we now use struct matching the spec.
---
 mesh/crypto.c         |   8 +--
 mesh/crypto.h         |   8 +--
 mesh/mesh.c           |   2 +-
 mesh/mesh.h           |   3 +-
 mesh/pb-adv.c         |  79 +++++++++++++++++--------
 mesh/prov-acceptor.c  | 156 +++++++++++++++++++++++++++-----------------------
 mesh/prov-initiator.c |  94 +++++++++++++++---------------
 mesh/prov.h           |  51 ++++++++++++++++-
 8 files changed, 247 insertions(+), 154 deletions(-)

diff --git a/mesh/crypto.c b/mesh/crypto.c
index 3fa0df246..a4679d88e 100644
--- a/mesh/crypto.c
+++ b/mesh/crypto.c
@@ -102,8 +102,8 @@ bool mesh_crypto_aes_cmac(const uint8_t key[16], const uint8_t *msg,
 
 bool mesh_crypto_aes_ccm_encrypt(const uint8_t nonce[13], const uint8_t key[16],
 					const uint8_t *aad, uint16_t aad_len,
-					const uint8_t *msg, uint16_t msg_len,
-					uint8_t *out_msg,
+					const void *msg, uint16_t msg_len,
+					void *out_msg,
 					void *out_mic, size_t mic_size)
 {
 	void *cipher;
@@ -128,8 +128,8 @@ bool mesh_crypto_aes_ccm_encrypt(const uint8_t nonce[13], const uint8_t key[16],
 
 bool mesh_crypto_aes_ccm_decrypt(const uint8_t nonce[13], const uint8_t key[16],
 				const uint8_t *aad, uint16_t aad_len,
-				const uint8_t *enc_msg, uint16_t enc_msg_len,
-				uint8_t *out_msg,
+				const void *enc_msg, uint16_t enc_msg_len,
+				void *out_msg,
 				void *out_mic, size_t mic_size)
 {
 	void *cipher;
diff --git a/mesh/crypto.h b/mesh/crypto.h
index ffd312231..3e6815a35 100644
--- a/mesh/crypto.h
+++ b/mesh/crypto.h
@@ -22,13 +22,13 @@
 
 bool mesh_crypto_aes_ccm_encrypt(const uint8_t nonce[13], const uint8_t key[16],
 					const uint8_t *aad, uint16_t aad_len,
-					const uint8_t *msg, uint16_t msg_len,
-					uint8_t *out_msg,
+					const void *msg, uint16_t msg_len,
+					void *out_msg,
 					void *out_mic, size_t mic_size);
 bool mesh_crypto_aes_ccm_decrypt(const uint8_t nonce[13], const uint8_t key[16],
 				const uint8_t *aad, uint16_t aad_len,
-				const uint8_t *enc_msg, uint16_t enc_msg_len,
-				uint8_t *out_msg,
+				const void *enc_msg, uint16_t enc_msg_len,
+				void *out_msg,
 				void *out_mic, size_t mic_size);
 bool mesh_aes_ecb_one(const uint8_t key[16],
 			const uint8_t plaintext[16], uint8_t encrypted[16]);
diff --git a/mesh/mesh.c b/mesh/mesh.c
index 62c80c0f3..b9e3162eb 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -86,7 +86,7 @@ static bool simple_match(const void *a, const void *b)
 /* Used for any outbound traffic that doesn't have Friendship Constraints */
 /* This includes Beacons, Provisioning and unrestricted Network Traffic */
 bool mesh_send_pkt(uint8_t count, uint16_t interval,
-					uint8_t *data, uint16_t len)
+					void *data, uint16_t len)
 {
 	struct mesh_io_send_info info = {
 		.type = MESH_IO_TIMING_TYPE_GENERAL,
diff --git a/mesh/mesh.h b/mesh/mesh.h
index 2ef77b57d..78d4d4926 100644
--- a/mesh/mesh.h
+++ b/mesh/mesh.h
@@ -37,8 +37,7 @@ void mesh_cleanup(void);
 bool mesh_dbus_init(struct l_dbus *dbus);
 
 const char *mesh_status_str(uint8_t err);
-bool mesh_send_pkt(uint8_t count, uint16_t interval, uint8_t *data,
-								uint16_t len);
+bool mesh_send_pkt(uint8_t count, uint16_t interval, void *data, uint16_t len);
 bool mesh_send_cancel(const uint8_t *filter, uint8_t len);
 bool mesh_reg_prov_rx(prov_rx_cb_t cb, void *user_data);
 void mesh_unreg_prov_rx(prov_rx_cb_t cb);
diff --git a/mesh/pb-adv.c b/mesh/pb-adv.c
index 4d85ee72e..6b4a70052 100644
--- a/mesh/pb-adv.c
+++ b/mesh/pb-adv.c
@@ -63,6 +63,36 @@ struct pb_adv_session {
 
 #define PB_ADV_MTU	24
 
+struct pb_ack {
+	uint8_t ad_type;
+	uint32_t link_id;
+	uint8_t trans_num;
+	uint8_t opcode;
+} __packed;
+
+struct pb_open_req{
+	uint8_t ad_type;
+	uint32_t link_id;
+	uint8_t trans_num;
+	uint8_t opcode;
+	uint8_t uuid[16];
+} __packed;
+
+struct pb_open_cfm{
+	uint8_t ad_type;
+	uint32_t link_id;
+	uint8_t trans_num;
+	uint8_t opcode;
+} __packed;
+
+struct pb_close_ind {
+	uint8_t ad_type;
+	uint32_t link_id;
+	uint8_t trans_num;
+	uint8_t opcode;
+	uint8_t reason;
+} __packed;
+
 static struct pb_adv_session *pb_session = NULL;
 
 static const uint8_t filter[1] = { MESH_AD_TYPE_PROVISION };
@@ -150,7 +180,7 @@ static void tx_timeout(struct l_timeout *timeout, void *user_data)
 	cb(user_data, 1);
 }
 
-static void pb_adv_tx(void *user_data, uint8_t *data, uint16_t len)
+static void pb_adv_tx(void *user_data, void *data, uint16_t len)
 {
 	struct pb_adv_session *session = user_data;
 
@@ -165,55 +195,56 @@ static void pb_adv_tx(void *user_data, uint8_t *data, uint16_t len)
 
 static void send_open_req(struct pb_adv_session *session)
 {
-	uint8_t open_req[23] = { MESH_AD_TYPE_PROVISION };
+	struct pb_open_req open_req = { MESH_AD_TYPE_PROVISION };
 
-	l_put_be32(session->link_id, open_req + 1);
-	open_req[1 + 4] = 0;
-	open_req[1 + 4 + 1] = PB_ADV_OPEN_REQ;
-	memcpy(open_req + 7, session->uuid, 16);
+	l_put_be32(session->link_id, &open_req.link_id);
+	open_req.trans_num = 0;
+	open_req.opcode = PB_ADV_OPEN_REQ;
+	memcpy(open_req.uuid, session->uuid, 16);
 
 	mesh_send_cancel(filter, sizeof(filter));
-	mesh_send_pkt(MESH_IO_TX_COUNT_UNLIMITED, 500, open_req,
-						sizeof(open_req));
+	mesh_send_pkt(MESH_IO_TX_COUNT_UNLIMITED, 500, &open_req,
+							sizeof(open_req));
 }
 
 static void send_open_cfm(struct pb_adv_session *session)
 {
-	uint8_t open_cfm[7] = { MESH_AD_TYPE_PROVISION };
+	struct pb_open_cfm open_cfm = { MESH_AD_TYPE_PROVISION };
 
-	l_put_be32(session->link_id, open_cfm + 1);
-	open_cfm[1 + 4] = 0;
-	open_cfm[1 + 4 + 1] = PB_ADV_OPEN_CFM; /* OPEN_CFM */
+	l_put_be32(session->link_id, &open_cfm.link_id);
+	open_cfm.trans_num = 0;
+	open_cfm.opcode = PB_ADV_OPEN_CFM;
 
 	mesh_send_cancel(filter, sizeof(filter));
-	mesh_send_pkt(5, 100, open_cfm, sizeof(open_cfm));
+	mesh_send_pkt(MESH_IO_TX_COUNT_UNLIMITED, 500, &open_cfm,
+							sizeof(open_cfm));
 }
 
 static void send_ack(struct pb_adv_session *session, uint8_t trans_num)
 {
-	uint8_t ack[7] = { MESH_AD_TYPE_PROVISION };
+	struct pb_ack ack = { MESH_AD_TYPE_PROVISION };
 
-	l_put_be32(session->link_id, ack + 1);
-	ack[1 + 4] = trans_num;
-	ack[1 + 4 + 1] = PB_ADV_ACK;
+	l_put_be32(session->link_id, &ack.link_id);
+	ack.trans_num = trans_num;
+	ack.opcode = PB_ADV_ACK;
 
-	mesh_send_pkt(1, 100, ack, sizeof(ack));
+	mesh_send_pkt(1, 100, &ack, sizeof(ack));
 }
 
 static void send_close_ind(struct pb_adv_session *session, uint8_t reason)
 {
-	uint8_t close_ind[8] = { MESH_AD_TYPE_PROVISION };
+	struct pb_close_ind close_ind = { MESH_AD_TYPE_PROVISION };
 
 	if (!pb_session || pb_session != session)
 		return;
 
-	l_put_be32(session->link_id, close_ind + 1);
-	close_ind[5] = 0;
-	close_ind[6] = PB_ADV_CLOSE;
-	close_ind[7] = reason;
+	l_put_be32(session->link_id, &close_ind.link_id);
+	close_ind.trans_num = 0;
+	close_ind.opcode = PB_ADV_CLOSE;
+	close_ind.reason = reason;
 
 	mesh_send_cancel(filter, sizeof(filter));
-	mesh_send_pkt(10, 100, close_ind, sizeof(close_ind));
+	mesh_send_pkt(10, 100, &close_ind, sizeof(close_ind));
 }
 
 static void pb_adv_packet(void *user_data, const uint8_t *pkt, uint16_t len)
diff --git a/mesh/prov-acceptor.c b/mesh/prov-acceptor.c
index 111340db3..57eb1e750 100644
--- a/mesh/prov-acceptor.c
+++ b/mesh/prov-acceptor.c
@@ -232,15 +232,15 @@ static uint32_t digit_mod(uint8_t power)
 static void number_cb(void *user_data, int err, uint32_t number)
 {
 	struct mesh_prov_acceptor *rx_prov = user_data;
-	uint8_t out[2];
+	struct prov_fail_msg msg;
 
 	if (prov != rx_prov)
 		return;
 
 	if (err) {
-		out[0] = PROV_FAILED;
-		out[1] = PROV_ERR_UNEXPECTED_ERR;
-		prov->trans_tx(prov->trans_data, out, 2);
+		msg.opcode = PROV_FAILED;
+		msg.reason = PROV_ERR_UNEXPECTED_ERR;
+		prov->trans_tx(prov->trans_data, &msg, sizeof(msg));
 		return;
 	}
 
@@ -248,22 +248,22 @@ static void number_cb(void *user_data, int err, uint32_t number)
 	l_put_be32(number, prov->rand_auth_workspace + 28);
 	l_put_be32(number, prov->rand_auth_workspace + 44);
 	prov->material |= MAT_RAND_AUTH;
-	out[0] = PROV_INP_CMPLT;
-	prov->trans_tx(prov->trans_data, out, 1);
+	msg.opcode = PROV_INP_CMPLT;
+	prov->trans_tx(prov->trans_data, &msg.opcode, 1);
 }
 
 static void static_cb(void *user_data, int err, uint8_t *key, uint32_t len)
 {
 	struct mesh_prov_acceptor *rx_prov = user_data;
-	uint8_t out[2];
+	struct prov_fail_msg msg;
 
 	if (prov != rx_prov)
 		return;
 
 	if (err || !key || len != 16) {
-		out[0] = PROV_FAILED;
-		out[1] = PROV_ERR_UNEXPECTED_ERR;
-		prov->trans_tx(prov->trans_data, out, 2);
+		msg.opcode = PROV_FAILED;
+		msg.reason = PROV_ERR_UNEXPECTED_ERR;
+		prov->trans_tx(prov->trans_data, &msg, sizeof(msg));
 		return;
 	}
 
@@ -276,15 +276,15 @@ static void static_cb(void *user_data, int err, uint8_t *key, uint32_t len)
 static void priv_key_cb(void *user_data, int err, uint8_t *key, uint32_t len)
 {
 	struct mesh_prov_acceptor *rx_prov = user_data;
-	uint8_t out[2];
+	struct prov_fail_msg msg;
 
 	if (prov != rx_prov)
 		return;
 
 	if (err || !key || len != 32) {
-		out[0] = PROV_FAILED;
-		out[1] = PROV_ERR_UNEXPECTED_ERR;
-		prov->trans_tx(prov->trans_data, out, 2);
+		msg.opcode = PROV_FAILED;
+		msg.reason = PROV_ERR_UNEXPECTED_ERR;
+		prov->trans_tx(prov->trans_data, &msg, sizeof(msg));
 		return;
 	}
 
@@ -301,13 +301,53 @@ static void priv_key_cb(void *user_data, int err, uint8_t *key, uint32_t len)
 		acp_credentials(prov);
 }
 
+static void send_caps(struct mesh_prov_acceptor *prov)
+{
+	struct prov_caps_msg msg;
+
+	msg.opcode = PROV_CAPS;
+	memcpy(&msg.caps, &prov->conf_inputs.caps,
+			sizeof(prov->conf_inputs.caps));
+
+	prov->state = ACP_PROV_CAPS_SENT;
+	prov->expected = PROV_START;
+	prov->trans_tx(prov->trans_data, &msg, sizeof(msg));
+}
+
+static void send_pub_key(struct mesh_prov_acceptor *prov)
+{
+	struct prov_pub_key_msg msg;
+
+	msg.opcode = PROV_PUB_KEY;
+	memcpy(msg.pub_key, prov->conf_inputs.dev_pub_key, sizeof(msg.pub_key));
+	prov->trans_tx(prov->trans_data, &msg, sizeof(msg));
+}
+
+static void send_conf(struct mesh_prov_acceptor *prov)
+{
+	struct prov_conf_msg msg;
+
+	msg.opcode = PROV_CONFIRM;
+	mesh_crypto_aes_cmac(prov->calc_key, prov->rand_auth_workspace, 32,
+								msg.conf);
+	prov->trans_tx(prov->trans_data, &msg, sizeof(msg));
+}
+
+static void send_rand(struct mesh_prov_acceptor *prov)
+{
+	struct prov_rand_msg msg;
+
+	msg.opcode = PROV_RANDOM;
+	memcpy(msg.rand, prov->rand_auth_workspace, sizeof(msg.rand));
+	prov->trans_tx(prov->trans_data, &msg, sizeof(msg));
+}
+
 static void acp_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 {
 	struct mesh_prov_acceptor *rx_prov = user_data;
 	struct mesh_prov_node_info *info;
-	uint8_t *out;
+	struct prov_fail_msg fail;
 	uint8_t type = *data++;
-	uint8_t fail_code[2];
 	uint32_t oob_key;
 	uint64_t decode_mic;
 	bool result;
@@ -323,7 +363,7 @@ static void acp_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 		return;
 	} else if (type > prov->expected || type < prov->previous) {
 		l_error("Expected %2.2x, Got:%2.2x", prov->expected, type);
-		fail_code[1] = PROV_ERR_UNEXPECTED_PDU;
+		fail.reason = PROV_ERR_UNEXPECTED_PDU;
 		goto failure;
 	}
 
@@ -331,25 +371,14 @@ static void acp_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 					len != expected_pdu_size[type]) {
 		l_error("Expected PDU size %d, Got %d (type: %2.2x)",
 			len, expected_pdu_size[type], type);
-		fail_code[1] = PROV_ERR_INVALID_FORMAT;
+		fail.reason = PROV_ERR_INVALID_FORMAT;
 		goto failure;
 	}
 
 	switch (type){
 	case PROV_INVITE: /* Prov Invite */
-		/* Prov Capabilities */
-		out = l_malloc(1 + sizeof(struct mesh_net_prov_caps));
-		out[0] = PROV_CAPS;
-		memcpy(out + 1, &prov->conf_inputs.caps,
-					sizeof(prov->conf_inputs.caps));
-
 		prov->conf_inputs.invite.attention = data[0];
-
-		prov->state = ACP_PROV_CAPS_SENT;
-		prov->expected = PROV_START;
-		prov->trans_tx(prov->trans_data,
-				out, sizeof(prov->conf_inputs.caps) + 1);
-		l_free(out);
+		send_caps(prov);
 		break;
 
 	case PROV_START: /* Prov Start */
@@ -359,7 +388,7 @@ static void acp_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 		if (prov->conf_inputs.start.algorithm ||
 				prov->conf_inputs.start.pub_key > 1 ||
 				prov->conf_inputs.start.auth_method > 3) {
-			fail_code[1] = PROV_ERR_INVALID_FORMAT;
+			fail.reason = PROV_ERR_INVALID_FORMAT;
 			goto failure;
 		}
 
@@ -369,7 +398,7 @@ static void acp_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 				mesh_agent_request_private_key(prov->agent,
 							priv_key_cb, prov);
 			} else {
-				fail_code[1] = PROV_ERR_INVALID_PDU;
+				fail.reason = PROV_ERR_INVALID_PDU;
 				goto failure;
 			}
 		} else {
@@ -395,13 +424,8 @@ static void acp_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 
 		acp_credentials(prov);
 
-		if (!prov->conf_inputs.start.pub_key) {
-			out = l_malloc(65);
-			out[0] = PROV_PUB_KEY;
-			memcpy(out + 1, prov->conf_inputs.dev_pub_key, 64);
-			prov->trans_tx(prov->trans_data, out, 65);
-			l_free(out);
-		}
+		if (!prov->conf_inputs.start.pub_key)
+			send_pub_key(prov);
 
 		/* Start Step 3 */
 		switch (prov->conf_inputs.start.auth_method) {
@@ -413,10 +437,10 @@ static void acp_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 		case 1:
 			/* Auth Type 3c - Static OOB */
 			/* Prompt Agent for Static OOB */
-			fail_code[1] = mesh_agent_request_static(prov->agent,
+			fail.reason = mesh_agent_request_static(prov->agent,
 					static_cb, prov);
 
-			if (fail_code[1])
+			if (fail.reason)
 				goto failure;
 
 			break;
@@ -434,17 +458,17 @@ static void acp_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 			if (prov->conf_inputs.start.auth_action ==
 							PROV_ACTION_OUT_ALPHA) {
 				/* TODO: Construst NUL-term string to pass */
-				fail_code[1] = mesh_agent_display_string(
+				fail.reason = mesh_agent_display_string(
 					prov->agent, NULL, NULL, prov);
 			} else {
 				/* Ask Agent to Display U32 */
-				fail_code[1] = mesh_agent_display_number(
+				fail.reason = mesh_agent_display_number(
 					prov->agent, false,
 					prov->conf_inputs.start.auth_action,
 					oob_key, NULL, prov);
 			}
 
-			if (fail_code[1])
+			if (fail.reason)
 				goto failure;
 
 			break;
@@ -454,17 +478,17 @@ static void acp_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 			/* Prompt Agent for Input OOB */
 			if (prov->conf_inputs.start.auth_action ==
 							PROV_ACTION_IN_ALPHA) {
-				fail_code[1] = mesh_agent_prompt_alpha(
+				fail.reason = mesh_agent_prompt_alpha(
 					prov->agent,
 					static_cb, prov);
 			} else {
-				fail_code[1] = mesh_agent_prompt_number(
+				fail.reason = mesh_agent_prompt_number(
 					prov->agent, false,
 					prov->conf_inputs.start.auth_action,
 					number_cb, prov);
 			}
 
-			if (fail_code[1])
+			if (fail.reason)
 				goto failure;
 
 			break;
@@ -474,22 +498,14 @@ static void acp_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 		break;
 
 	case PROV_CONFIRM: /* Confirmation */
-		out = l_malloc(17);
-		out[0] = PROV_CONFIRM;
-
-		/* Calculate and Send our Confirmation */
-		mesh_crypto_aes_cmac(prov->calc_key, prov->rand_auth_workspace,
-								32, out + 1);
-		prov->trans_tx(prov->trans_data, out, 17);
-		l_free(out);
-
 		/* Save Provisioners confirmation for later compare */
 		memcpy(prov->confirm, data, 16);
 		prov->expected = PROV_RANDOM;
+
+		send_conf(prov);
 		break;
 
 	case PROV_RANDOM: /* Random Value */
-		out = l_malloc(17);
 		/* Calculate Session key (needed later) while data is fresh */
 		mesh_crypto_prov_prov_salt(prov->salt, data,
 						prov->rand_auth_workspace,
@@ -500,20 +516,17 @@ static void acp_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 		/* Calculate expected Provisioner Confirm */
 		memcpy(prov->rand_auth_workspace + 16, data, 16);
 		mesh_crypto_aes_cmac(prov->calc_key,
-				prov->rand_auth_workspace + 16, 32, out);
+					prov->rand_auth_workspace + 16, 32,
+					prov->calc_key);
 
 		/* Compare our calculation with Provisioners */
-		if (memcmp(out, prov->confirm, 16)) {
-			fail_code[1] = PROV_ERR_CONFIRM_FAILED;
-			l_free(out);
+		if (memcmp(prov->calc_key, prov->confirm, 16)) {
+			fail.reason = PROV_ERR_CONFIRM_FAILED;
 			goto failure;
 		}
 
 		/* Send Random value we used */
-		out[0] = PROV_RANDOM;
-		memcpy(out + 1, prov->rand_auth_workspace, 16);
-		prov->trans_tx(prov->trans_data, out, 17);
-		l_free(out);
+		send_rand(prov);
 		prov->expected = PROV_DATA;
 		break;
 
@@ -533,7 +546,7 @@ static void acp_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 		/* Validate that the data hasn't been messed with in transit */
 		if (l_get_be64(data + 25) != decode_mic) {
 			l_error("Provisioning Failed-MIC compare");
-			fail_code[1] = PROV_ERR_DECRYPT_FAILED;
+			fail.reason = PROV_ERR_DECRYPT_FAILED;
 			goto failure;
 		}
 
@@ -556,7 +569,7 @@ static void acp_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 					prov->rand_auth_workspace, 1);
 			goto cleanup;
 		} else {
-			fail_code[1] = PROV_ERR_UNEXPECTED_ERR;
+			fail.reason = PROV_ERR_UNEXPECTED_ERR;
 			goto failure;
 		}
 		break;
@@ -570,14 +583,15 @@ static void acp_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 		goto cleanup;
 	}
 
-	prov->previous = type;
+	if (prov)
+		prov->previous = type;
 	return;
 
 failure:
-	fail_code[0] = PROV_FAILED;
-	prov->trans_tx(prov->trans_data, fail_code, 2);
+	fail.opcode = PROV_FAILED;
+	prov->trans_tx(prov->trans_data, &fail, sizeof(fail));
 	if (prov->cmplt)
-		prov->cmplt(prov->caller_data, fail_code[1], NULL);
+		prov->cmplt(prov->caller_data, fail.reason, NULL);
 	prov->cmplt = NULL;
 
 cleanup:
diff --git a/mesh/prov-initiator.c b/mesh/prov-initiator.c
index 208225f08..eb59f53f1 100644
--- a/mesh/prov-initiator.c
+++ b/mesh/prov-initiator.c
@@ -155,7 +155,7 @@ static void int_prov_open(void *user_data, prov_trans_tx_t trans_tx,
 				void *trans_data, uint8_t transport)
 {
 	struct mesh_prov_initiator *rx_prov = user_data;
-	uint8_t invite[] = { PROV_INVITE, 30 };
+	struct prov_invite_msg msg = { PROV_INVITE, { 30 }};
 
 	/* Only one provisioning session may be open at a time */
 	if (rx_prov != prov)
@@ -181,8 +181,8 @@ static void int_prov_open(void *user_data, prov_trans_tx_t trans_tx,
 	prov->state = INT_PROV_INVITE_SENT;
 	prov->expected = PROV_CAPS;
 
-	prov->conf_inputs.invite.attention = invite[1];
-	prov->trans_tx(prov->trans_data, invite, sizeof(invite));
+	prov->conf_inputs.invite.attention = msg.invite.attention;
+	prov->trans_tx(prov->trans_data, &msg, sizeof(msg));
 	return;
 }
 
@@ -268,15 +268,15 @@ static void calc_local_material(const uint8_t *random)
 static void number_cb(void *user_data, int err, uint32_t number)
 {
 	struct mesh_prov_initiator *rx_prov = user_data;
-	uint8_t out[2];
+	struct prov_fail_msg msg;
 
 	if (prov != rx_prov)
 		return;
 
 	if (err) {
-		out[0] = PROV_FAILED;
-		out[1] = PROV_ERR_UNEXPECTED_ERR;
-		prov->trans_tx(prov->trans_data, out, 2);
+		msg.opcode = PROV_FAILED;
+		msg.reason = PROV_ERR_UNEXPECTED_ERR;
+		prov->trans_tx(prov->trans_data, &msg, sizeof(msg));
 		return;
 	}
 
@@ -289,15 +289,15 @@ static void number_cb(void *user_data, int err, uint32_t number)
 static void static_cb(void *user_data, int err, uint8_t *key, uint32_t len)
 {
 	struct mesh_prov_initiator *rx_prov = user_data;
-	uint8_t out[2];
+	struct prov_fail_msg msg;
 
 	if (prov != rx_prov)
 		return;
 
 	if (err || !key || len != 16) {
-		out[0] = PROV_FAILED;
-		out[1] = PROV_ERR_UNEXPECTED_ERR;
-		prov->trans_tx(prov->trans_data, out, 2);
+		msg.opcode = PROV_FAILED;
+		msg.reason = PROV_ERR_UNEXPECTED_ERR;
+		prov->trans_tx(prov->trans_data, &msg, sizeof(msg));
 		return;
 	}
 
@@ -309,15 +309,15 @@ static void static_cb(void *user_data, int err, uint8_t *key, uint32_t len)
 static void pub_key_cb(void *user_data, int err, uint8_t *key, uint32_t len)
 {
 	struct mesh_prov_initiator *rx_prov = user_data;
-	uint8_t out[2];
+	struct prov_fail_msg msg;
 
 	if (prov != rx_prov)
 		return;
 
 	if (err || !key || len != 64) {
-		out[0] = PROV_FAILED;
-		out[1] = PROV_ERR_UNEXPECTED_ERR;
-		prov->trans_tx(prov->trans_data, out, 2);
+		msg.opcode = PROV_FAILED;
+		msg.reason = PROV_ERR_UNEXPECTED_ERR;
+		prov->trans_tx(prov->trans_data, &msg, sizeof(msg));
 		return;
 	}
 
@@ -330,45 +330,45 @@ static void pub_key_cb(void *user_data, int err, uint8_t *key, uint32_t len)
 
 static void send_pub_key(struct mesh_prov_initiator *prov)
 {
-	uint8_t out[65];
+	struct prov_pub_key_msg msg;
 
-	out[0] = PROV_PUB_KEY;
-	memcpy(out + 1, prov->conf_inputs.prv_pub_key, 64);
-	prov->trans_tx(prov->trans_data, out, 65);
+	msg.opcode = PROV_PUB_KEY;
+	memcpy(msg.pub_key, prov->conf_inputs.prv_pub_key, 64);
+	prov->trans_tx(prov->trans_data, &msg, sizeof(msg));
 	prov->state = INT_PROV_KEY_SENT;
 }
 
 static void send_confirm(struct mesh_prov_initiator *prov)
 {
-	uint8_t out[17];
+	struct prov_conf_msg msg;
 
-	out[0] = PROV_CONFIRM;
+	msg.opcode = PROV_CONFIRM;
 	mesh_crypto_aes_cmac(prov->calc_key, prov->rand_auth_workspace,
-			32, out + 1);
-	prov->trans_tx(prov->trans_data, out, 17);
+			32, msg.conf);
+	prov->trans_tx(prov->trans_data, &msg, sizeof(msg));
 	prov->state = INT_PROV_CONF_SENT;
 	prov->expected = PROV_CONFIRM;
 }
 
 static void send_random(struct mesh_prov_initiator *prov)
 {
-	uint8_t out[17];
+	struct prov_rand_msg msg;
 
-	out[0] = PROV_RANDOM;
-	memcpy(out + 1, prov->rand_auth_workspace, 16);
-	prov->trans_tx(prov->trans_data, out, 17);
+	msg.opcode = PROV_RANDOM;
+	memcpy(msg.rand, prov->rand_auth_workspace, sizeof(msg.rand));
+	prov->trans_tx(prov->trans_data, &msg, sizeof(msg));
 	prov->state = INT_PROV_RAND_SENT;
 	prov->expected = PROV_RANDOM;
 }
 
 void initiator_prov_data(uint16_t net_idx, uint16_t primary, void *caller_data)
 {
+	struct prov_data_msg prov_data;
+	struct prov_fail_msg prov_fail;
 	struct keyring_net_key key;
 	struct mesh_net *net;
-	uint64_t mic;
 	uint32_t iv_index;
 	uint8_t snb_flags;
-	uint8_t out[34];
 
 	if (!prov || caller_data != prov->caller_data)
 		return;
@@ -388,7 +388,7 @@ void initiator_prov_data(uint16_t net_idx, uint16_t primary, void *caller_data)
 
 	/* Fill Prov Data Structure */
 	if (!keyring_get_net_key(prov->node, net_idx, &key)) {
-		out[1] = PROV_ERR_UNEXPECTED_ERR;
+		prov_fail.reason = PROV_ERR_UNEXPECTED_ERR;
 		goto failure;
 	}
 
@@ -396,36 +396,36 @@ void initiator_prov_data(uint16_t net_idx, uint16_t primary, void *caller_data)
 	prov->net_idx = net_idx;
 	mesh_net_get_snb_state(net, &snb_flags, &iv_index);
 
-	out[0] = PROV_DATA;
+	prov_data.opcode = PROV_DATA;
 
 	if (key.phase == KEY_REFRESH_PHASE_TWO) {
-		memcpy(out + 1, key.new_key, 16);
+		memcpy(&prov_data.data.net_key, key.new_key, 16);
 		snb_flags |= PROV_FLAG_KR;
 	} else
-		memcpy(out + 1, key.old_key, 16);
+		memcpy(&prov_data.data.net_key, key.old_key, 16);
 
-	l_put_be16(net_idx, out + 1 + 16);
-	l_put_u8(snb_flags, out + 1 + 16 + 2);
-	l_put_be32(iv_index, out + 1 + 16 + 2 + 1);
-	l_put_be16(primary, out + 1 + 16 + 2 + 1 + 4);
+	l_put_be16(net_idx, &prov_data.data.net_idx);
+	l_put_u8(snb_flags, &prov_data.data.flags);
+	l_put_be32(iv_index, &prov_data.data.iv_index);
+	l_put_be16(primary, &prov_data.data.primary);
 
-	print_packet("ProvData", out + 1, 25);
+	print_packet("ProvData", &prov_data.data, sizeof(prov_data.data));
 	/* Encrypt Prov Data */
 	mesh_crypto_aes_ccm_encrypt(prov->s_nonce, prov->s_key,
 			NULL, 0,
-			out + 1,
-			25,
-			out + 1,
-			&mic, sizeof(mic));
-	print_packet("EncData", out + 1, 25 + 8);
-	prov->trans_tx(prov->trans_data, out, 34);
+			&prov_data.data,
+			sizeof(prov_data.data),
+			&prov_data.data,
+			NULL, sizeof(prov_data.mic));
+	print_packet("EncdData", &prov_data.data, sizeof(prov_data) - 1);
+	prov->trans_tx(prov->trans_data, &prov_data, sizeof(prov_data));
 	prov->state = INT_PROV_DATA_SENT;
 	return;
 
 failure:
-	l_debug("Failing... %d", out[1]);
-	out[0] = PROV_FAILED;
-	prov->trans_tx(prov->trans_data, out, 2);
+	l_debug("Failing... %d", prov_fail.reason);
+	prov_fail.opcode = PROV_FAILED;
+	prov->trans_tx(prov->trans_data, &prov_fail, sizeof(prov_fail));
 	/* TODO: Call Complete Callback (Fail)*/
 }
 
diff --git a/mesh/prov.h b/mesh/prov.h
index 61ec08e10..11b20b31f 100644
--- a/mesh/prov.h
+++ b/mesh/prov.h
@@ -48,7 +48,7 @@ enum mesh_prov_mode {
 
 struct mesh_prov;
 
-typedef void (*prov_trans_tx_t)(void *trans_data, uint8_t *data, uint16_t len);
+typedef void (*prov_trans_tx_t)(void *trans_data, void *data, uint16_t len);
 typedef void (*mesh_prov_open_func_t)(void *user_data, prov_trans_tx_t trans_tx,
 					void *trans_data, uint8_t trans_type);
 
@@ -63,6 +63,11 @@ struct prov_invite {
 	uint8_t attention;
 } __packed;
 
+struct prov_invite_msg {
+	uint8_t opcode;
+	struct prov_invite invite;
+} __packed;
+
 struct prov_start {
 	uint8_t algorithm;
 	uint8_t pub_key;
@@ -71,6 +76,50 @@ struct prov_start {
 	uint8_t auth_size;
 } __packed;
 
+struct prov_caps_msg {
+	uint8_t opcode;
+	struct mesh_net_prov_caps caps;
+} __packed;
+
+struct prov_start_msg {
+	uint8_t opcode;
+	struct prov_start start;
+} __packed;
+
+struct prov_pub_key_msg {
+	uint8_t opcode;
+	uint8_t pub_key[64];
+} __packed;
+
+struct prov_conf_msg {
+	uint8_t opcode;
+	uint8_t conf[16];
+} __packed;
+
+struct prov_rand_msg {
+	uint8_t opcode;
+	uint8_t rand[16];
+} __packed;
+
+struct prov_data {
+	uint8_t net_key[16];
+	uint16_t net_idx;
+	uint8_t flags;
+	uint32_t iv_index;
+	uint16_t primary;
+} __packed;
+
+struct prov_data_msg {
+	uint8_t opcode;
+	struct prov_data data;
+	uint64_t mic;
+} __packed;
+
+struct prov_fail_msg {
+	uint8_t opcode;
+	uint8_t reason;
+} __packed;
+
 struct conf_input {
 	struct prov_invite		invite;
 	struct mesh_net_prov_caps	caps;
-- 
2.14.5

