Return-Path: <SRS0=ssTf=VI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC625C742A2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jul 2019 23:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A419E208E4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jul 2019 23:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbfGKXAm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Jul 2019 19:00:42 -0400
Received: from mga18.intel.com ([134.134.136.126]:38699 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbfGKXAm (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Jul 2019 19:00:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2019 16:00:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,480,1557212400"; 
   d="scan'208";a="166516268"
Received: from bgix-dell-lap.sea.intel.com ([10.255.80.129])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jul 2019 16:00:41 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, michal.lowas-rzechonek@silvair.com,
        brian.gix@intel.com
Subject: [PATCH BlueZ v2 6/9] mesh: Fix implementation of Provisioner Initiator
Date:   Thu, 11 Jul 2019 15:59:49 -0700
Message-Id: <20190711225952.1599-7-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190711225952.1599-1-brian.gix@intel.com>
References: <20190711225952.1599-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This has had testing of baseline functionality that includes
OOB authentication type "3c" from BT Mesh v1.0 specification
---
 mesh/prov-initiator.c | 251 +++++++++++++++++++++++++++++++++++++++-----------
 mesh/provision.h      |  10 +-
 2 files changed, 203 insertions(+), 58 deletions(-)

diff --git a/mesh/prov-initiator.c b/mesh/prov-initiator.c
index b1ed96a60..208225f08 100644
--- a/mesh/prov-initiator.c
+++ b/mesh/prov-initiator.c
@@ -29,6 +29,8 @@
 #include "mesh/util.h"
 #include "mesh/crypto.h"
 #include "mesh/net.h"
+#include "mesh/node.h"
+#include "mesh/keyring.h"
 #include "mesh/prov.h"
 #include "mesh/provision.h"
 #include "mesh/pb-adv.h"
@@ -76,14 +78,18 @@ enum int_state {
 
 struct mesh_prov_initiator {
 	mesh_prov_initiator_complete_func_t cmplt;
+	mesh_prov_initiator_data_req_func_t get_prov_data;
 	prov_trans_tx_t trans_tx;
 	void *agent;
 	void *caller_data;
 	void *trans_data;
+	struct mesh_node *node;
 	struct l_timeout *timeout;
 	uint32_t to_secs;
 	enum int_state	state;
 	enum trans_type transport;
+	uint16_t net_idx;
+	uint16_t unicast;
 	uint8_t material;
 	uint8_t expected;
 	int8_t previous;
@@ -102,7 +108,6 @@ static struct mesh_prov_initiator *prov = NULL;
 
 static void initiator_free(void)
 {
-
 	if (prov)
 		l_timeout_remove(prov->timeout);
 
@@ -116,7 +121,34 @@ static void initiator_free(void)
 
 static void int_prov_close(void *user_data, uint8_t reason)
 {
-	/* TODO: Handle Close */
+	struct mesh_prov_initiator *prov = user_data;
+	struct mesh_prov_node_info info;
+
+	if (reason != PROV_ERR_SUCCESS) {
+		prov->cmplt(prov->caller_data, reason, NULL);
+		initiator_free();
+		return;
+	}
+
+	memcpy(info.device_key, prov->calc_key, 16);
+	info.net_index = prov->net_idx;
+	info.unicast = prov->unicast;
+	info.num_ele = prov->conf_inputs.caps.num_ele;
+
+	prov->cmplt(prov->caller_data, PROV_ERR_SUCCESS, &info);
+	initiator_free();
+}
+
+static void swap_u256_bytes(uint8_t *u256)
+{
+	int i;
+
+	/* End-to-End byte reflection of 32 octet buffer */
+	for (i = 0; i < 16; i++) {
+		u256[i] ^= u256[31 - i];
+		u256[31 - i] ^= u256[i];
+		u256[i] ^= u256[31 - i];
+	}
 }
 
 static void int_prov_open(void *user_data, prov_trans_tx_t trans_tx,
@@ -140,6 +172,8 @@ static void int_prov_open(void *user_data, prov_trans_tx_t trans_tx,
 
 	/* Always use an ephemeral key when Initiator */
 	ecc_make_key(prov->conf_inputs.prv_pub_key, prov->private_key);
+	swap_u256_bytes(prov->conf_inputs.prv_pub_key);
+	swap_u256_bytes(prov->conf_inputs.prv_pub_key + 32);
 	prov->material |= MAT_LOCAL_PRIVATE;
 
 	prov->trans_tx = trans_tx;
@@ -152,18 +186,6 @@ static void int_prov_open(void *user_data, prov_trans_tx_t trans_tx,
 	return;
 }
 
-static void swap_u256_bytes(uint8_t *u256)
-{
-	int i;
-
-	/* End-to-End byte reflection of 32 octet buffer */
-	for (i = 0; i < 16; i++) {
-		u256[i] ^= u256[31 - i];
-		u256[31 - i] ^= u256[i];
-		u256[i] ^= u256[31 - i];
-	}
-}
-
 static void prov_calc_secret(const uint8_t *pub, const uint8_t *priv,
 							uint8_t *secret)
 {
@@ -241,7 +263,6 @@ static void calc_local_material(const uint8_t *random)
 
 	print_packet("SessionKey", prov->s_key, sizeof(prov->s_key));
 	print_packet("Nonce", prov->s_nonce, sizeof(prov->s_nonce));
-	print_packet("RandomDevice", prov->rand_auth_workspace, 16);
 }
 
 static void number_cb(void *user_data, int err, uint32_t number)
@@ -307,6 +328,108 @@ static void pub_key_cb(void *user_data, int err, uint8_t *key, uint32_t len)
 			int_credentials(prov);
 }
 
+static void send_pub_key(struct mesh_prov_initiator *prov)
+{
+	uint8_t out[65];
+
+	out[0] = PROV_PUB_KEY;
+	memcpy(out + 1, prov->conf_inputs.prv_pub_key, 64);
+	prov->trans_tx(prov->trans_data, out, 65);
+	prov->state = INT_PROV_KEY_SENT;
+}
+
+static void send_confirm(struct mesh_prov_initiator *prov)
+{
+	uint8_t out[17];
+
+	out[0] = PROV_CONFIRM;
+	mesh_crypto_aes_cmac(prov->calc_key, prov->rand_auth_workspace,
+			32, out + 1);
+	prov->trans_tx(prov->trans_data, out, 17);
+	prov->state = INT_PROV_CONF_SENT;
+	prov->expected = PROV_CONFIRM;
+}
+
+static void send_random(struct mesh_prov_initiator *prov)
+{
+	uint8_t out[17];
+
+	out[0] = PROV_RANDOM;
+	memcpy(out + 1, prov->rand_auth_workspace, 16);
+	prov->trans_tx(prov->trans_data, out, 17);
+	prov->state = INT_PROV_RAND_SENT;
+	prov->expected = PROV_RANDOM;
+}
+
+void initiator_prov_data(uint16_t net_idx, uint16_t primary, void *caller_data)
+{
+	struct keyring_net_key key;
+	struct mesh_net *net;
+	uint64_t mic;
+	uint32_t iv_index;
+	uint8_t snb_flags;
+	uint8_t out[34];
+
+	if (!prov || caller_data != prov->caller_data)
+		return;
+
+	if (prov->state != INT_PROV_RAND_ACKED)
+		return;
+
+	net = node_get_net(prov->node);
+	prov->expected = PROV_COMPLETE;
+
+	/* Calculate remote device key */
+	mesh_crypto_device_key(prov->secret,
+			prov->salt,
+			prov->calc_key);
+
+	print_packet("DevKey", prov->calc_key, 16);
+
+	/* Fill Prov Data Structure */
+	if (!keyring_get_net_key(prov->node, net_idx, &key)) {
+		out[1] = PROV_ERR_UNEXPECTED_ERR;
+		goto failure;
+	}
+
+	prov->unicast = primary;
+	prov->net_idx = net_idx;
+	mesh_net_get_snb_state(net, &snb_flags, &iv_index);
+
+	out[0] = PROV_DATA;
+
+	if (key.phase == KEY_REFRESH_PHASE_TWO) {
+		memcpy(out + 1, key.new_key, 16);
+		snb_flags |= PROV_FLAG_KR;
+	} else
+		memcpy(out + 1, key.old_key, 16);
+
+	l_put_be16(net_idx, out + 1 + 16);
+	l_put_u8(snb_flags, out + 1 + 16 + 2);
+	l_put_be32(iv_index, out + 1 + 16 + 2 + 1);
+	l_put_be16(primary, out + 1 + 16 + 2 + 1 + 4);
+
+	print_packet("ProvData", out + 1, 25);
+	/* Encrypt Prov Data */
+	mesh_crypto_aes_ccm_encrypt(prov->s_nonce, prov->s_key,
+			NULL, 0,
+			out + 1,
+			25,
+			out + 1,
+			&mic, sizeof(mic));
+	print_packet("EncData", out + 1, 25 + 8);
+	prov->trans_tx(prov->trans_data, out, 34);
+	prov->state = INT_PROV_DATA_SENT;
+	return;
+
+failure:
+	l_debug("Failing... %d", out[1]);
+	out[0] = PROV_FAILED;
+	prov->trans_tx(prov->trans_data, out, 2);
+	/* TODO: Call Complete Callback (Fail)*/
+}
+
+
 static void int_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 {
 	struct mesh_prov_initiator *rx_prov = user_data;
@@ -314,7 +437,6 @@ static void int_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 	uint8_t type = *data++;
 	uint8_t fail_code[2];
 	uint32_t oob_key;
-	uint64_t mic;
 
 	if (rx_prov != prov || !prov->trans_tx)
 		return;
@@ -425,8 +547,7 @@ static void int_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 		int_credentials(prov);
 		prov->state = INT_PROV_KEY_ACKED;
 
-		prov->expected = PROV_CONFIRM;
-
+		l_debug("auth_method: %d", prov->conf_inputs.start.auth_method);
 		memset(prov->rand_auth_workspace + 16, 0, 32);
 		switch (prov->conf_inputs.start.auth_method) {
 		default:
@@ -464,7 +585,6 @@ static void int_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 
 			break;
 
-
 		case 3:
 			/* Auth Type 3b - input OOB */
 			l_getrandom(&oob_key, sizeof(oob_key));
@@ -492,19 +612,16 @@ static void int_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 
 			break;
 
-
 		}
+
+		if (prov->material & MAT_RAND_AUTH)
+			send_confirm(prov);
+
 		break;
 
 	case PROV_INP_CMPLT: /* Provisioning Input Complete */
 		/* TODO: Cancel Agent prompt */
-		prov->expected = PROV_CONFIRM;
-		out = l_malloc(17);
-		out[0] = PROV_CONFIRM;
-		mesh_crypto_aes_cmac(prov->calc_key, prov->rand_auth_workspace,
-								32, out + 1);
-		prov->trans_tx(prov->trans_data, out, 17);
-		l_free(out);
+		send_confirm(prov);
 		break;
 
 	case PROV_CONFIRM: /* Confirmation */
@@ -512,58 +629,46 @@ static void int_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 		/* RXed Device Confirmation */
 		memcpy(prov->confirm, data, 16);
 		print_packet("ConfirmationDevice", prov->confirm, 16);
-		prov->expected = PROV_RANDOM;
-		out = l_malloc(17);
-		out[0] = PROV_RANDOM;
-		memcpy(out + 1, prov->rand_auth_workspace, 16);
-		prov->trans_tx(prov->trans_data, out, 17);
-		l_free(out);
+		send_random(prov);
 		break;
 
 	case PROV_RANDOM: /* Random */
 		prov->state = INT_PROV_RAND_ACKED;
 
 		/* RXed Device Confirmation */
+		calc_local_material(data);
 		memcpy(prov->rand_auth_workspace + 16, data, 16);
 		print_packet("RandomDevice", data, 16);
-		calc_local_material(data);
 
 		mesh_crypto_aes_cmac(prov->calc_key,
 						prov->rand_auth_workspace + 16,
 						32, prov->rand_auth_workspace);
 
+		print_packet("Dev-Conf", prov->rand_auth_workspace, 16);
 		if (memcmp(prov->rand_auth_workspace, prov->confirm, 16)) {
-			l_error("Provisioning Failed-Confirm compare)");
+			l_error("Provisioning Failed-Confirm compare");
 			fail_code[1] = PROV_ERR_CONFIRM_FAILED;
 			goto failure;
 		}
 
-		if (prov->state == INT_PROV_RAND_ACKED) {
-			prov->expected = PROV_COMPLETE;
-			out = l_malloc(34);
-			out[0] = PROV_DATA;
-			/* TODO: Fill Prov Data Structure */
-			/* Encrypt Prov Data */
-			mesh_crypto_aes_ccm_encrypt(prov->s_nonce, prov->s_key,
-					NULL, 0,
-					out + 1,
-					25,
-					out + 1,
-					&mic, sizeof(mic));
-			prov->trans_tx(prov->trans_data, out, 34);
-			l_free(out);
+		if (!prov->get_prov_data(prov->caller_data,
+					prov->conf_inputs.caps.num_ele)) {
+			l_error("Provisioning Failed-Data Get");
+			fail_code[1] = PROV_ERR_CANT_ASSIGN_ADDR;
+			goto failure;
 		}
 		break;
 
 	case PROV_COMPLETE: /* Complete */
 		l_info("Provisioning Complete");
 		prov->state = INT_PROV_IDLE;
-		//mesh_prov_close(prov, 0);
+		int_prov_close(prov, PROV_ERR_SUCCESS);
 		break;
 
 	case PROV_FAILED: /* Failed */
 		l_error("Provisioning Failed (reason: %d)", data[0]);
-		//mesh_prov_close(prov, data[0]);
+		prov->state = INT_PROV_IDLE;
+		int_prov_close(prov, data[0]);
 		break;
 
 	default:
@@ -572,20 +677,51 @@ static void int_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 		goto failure;
 	}
 
-	prov->previous = type;
+	if (prov)
+		prov->previous = type;
+
 	return;
 
 failure:
+	l_debug("Failing... %d", fail_code[1]);
 	fail_code[0] = PROV_FAILED;
 	prov->trans_tx(prov->trans_data, fail_code, 2);
-	/* TODO: Call Complete Callback (Fail)*/
+	int_prov_close(prov, fail_code[1]);
 }
 
 static void int_prov_ack(void *user_data, uint8_t msg_num)
 {
-	/* TODO: Handle PB-ADV Ack */
-}
+	struct mesh_prov_initiator *rx_prov = user_data;
 
+	if (rx_prov != prov || !prov->trans_tx)
+		return;
+
+	switch (prov->state) {
+	case INT_PROV_START_SENT:
+		prov->state = INT_PROV_START_ACKED;
+		if (prov->conf_inputs.caps.pub_type == 0)
+			send_pub_key(prov);
+		break;
+
+	case INT_PROV_DATA_SENT:
+		prov->state = INT_PROV_DATA_ACKED;
+		break;
+
+	case INT_PROV_IDLE:
+	case INT_PROV_INVITE_SENT:
+	case INT_PROV_INVITE_ACKED:
+	case INT_PROV_START_ACKED:
+	case INT_PROV_KEY_SENT:
+	case INT_PROV_KEY_ACKED:
+	case INT_PROV_CONF_SENT:
+	case INT_PROV_CONF_ACKED:
+	case INT_PROV_RAND_SENT:
+	case INT_PROV_RAND_ACKED:
+	case INT_PROV_DATA_ACKED:
+	default:
+		break;
+	}
+}
 
 bool initiator_start(enum trans_type transport,
 		uint8_t uuid[16],
@@ -593,8 +729,9 @@ bool initiator_start(enum trans_type transport,
 		uint16_t server, /* Only valid for PB-Remote */
 		uint32_t timeout, /* in seconds from mesh.conf */
 		struct mesh_agent *agent,
+		mesh_prov_initiator_data_req_func_t get_prov_data,
 		mesh_prov_initiator_complete_func_t complete_cb,
-		void *caller_data)
+		void *node, void *caller_data)
 {
 	bool result;
 
@@ -607,8 +744,10 @@ bool initiator_start(enum trans_type transport,
 
 	prov = l_new(struct mesh_prov_initiator, 1);
 	prov->to_secs = timeout;
+	prov->node = node;
 	prov->agent = agent;
 	prov->cmplt = complete_cb;
+	prov->get_prov_data = get_prov_data;
 	prov->caller_data = caller_data;
 	prov->previous = -1;
 
diff --git a/mesh/provision.h b/mesh/provision.h
index 6b61a45be..755d848a0 100644
--- a/mesh/provision.h
+++ b/mesh/provision.h
@@ -90,6 +90,7 @@ struct mesh_prov_node_info {
 	uint32_t iv_index;
 	uint16_t unicast;
 	uint16_t net_index;
+	uint8_t num_ele;
 	uint8_t net_key[16];
 	uint8_t device_key[16];
 	uint8_t flags; /* IVU and KR bits */
@@ -99,6 +100,9 @@ typedef bool (*mesh_prov_acceptor_complete_func_t)(void *user_data,
 					uint8_t status,
 					struct mesh_prov_node_info *info);
 
+typedef bool (*mesh_prov_initiator_data_req_func_t)(void *user_data,
+							uint8_t num_elem);
+
 typedef bool (*mesh_prov_initiator_complete_func_t)(void *user_data,
 					uint8_t status,
 					struct mesh_prov_node_info *info);
@@ -117,6 +121,8 @@ bool initiator_start(enum trans_type transport,
 		uint16_t server, /* Only valid for PB-Remote */
 		uint32_t timeout, /* in seconds from mesh.conf */
 		struct mesh_agent *agent,
+		mesh_prov_initiator_data_req_func_t get_prov_data,
 		mesh_prov_initiator_complete_func_t complete_cb,
-		void *caller_data);
-void initiator_cancel(void *user_data);
+		void *node, void *caller_data);
+void initiator_prov_data(uint16_t net_idx, uint16_t primary, void *caller_data);
+void initiator_cancel(void *caller_data);
-- 
2.14.5

