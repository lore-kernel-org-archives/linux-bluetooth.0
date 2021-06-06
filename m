Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F21C4743E
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Jun 2021 06:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D78861429
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Jun 2021 06:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhFFGjV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Jun 2021 02:39:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:34607 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230104AbhFFGjU (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Jun 2021 02:39:20 -0400
IronPort-SDR: XvpgkO7I6/cgvrxvfA9fV4ofYtFKL3U/VIRaGFDjt9vqWSwr1gRnS2u6O+OeXW4QV+JU7qLZfA
 bwvyP3AQvq2A==
X-IronPort-AV: E=McAfee;i="6200,9189,10006"; a="191815317"
X-IronPort-AV: E=Sophos;i="5.83,252,1616482800"; 
   d="scan'208";a="191815317"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2021 23:37:31 -0700
IronPort-SDR: lUTf8Rdh9D4PDH/Ny7uWVzL0HDuyPAR67ZnUfMp4jm0ajCD0gM4bUamzkNsoj0jjhW0Dy5IWSs
 pWLvn1PJSZqw==
X-IronPort-AV: E=Sophos;i="5.83,252,1616482800"; 
   d="scan'208";a="481160903"
Received: from skambhat-mobl.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.209.68.161])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2021 23:37:31 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, tedd.an@intel.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 06/11] tools/smp-tester: Convert to use ELL library
Date:   Sat,  5 Jun 2021 23:37:14 -0700
Message-Id: <20210606063719.339794-7-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210606063719.339794-1-inga.stotland@intel.com>
References: <20210606063719.339794-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This reworks the source code to use ELL primitives and removes
dependencies on GLib.
---
 Makefile.tools     |   4 +-
 tools/smp-tester.c | 210 +++++++++++++++++++++------------------------
 2 files changed, 102 insertions(+), 112 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 9193beef8..77b8d5512 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -144,12 +144,12 @@ tools_bnep_tester_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-glib.la $(GLIB_LIBS)
 
 tools_smp_tester_SOURCES = tools/smp-tester.c monitor/bt.h \
-				emulator/hciemu.h emulator/hciemu.c \
+				emulator/hciemu.h emulator/hciemu-ell.c \
 				emulator/btdev.h emulator/btdev.c \
 				emulator/bthost.h emulator/bthost.c \
 				emulator/smp.c
 tools_smp_tester_LDADD = lib/libbluetooth-internal.la \
-				src/libshared-glib.la $(GLIB_LIBS)
+				src/libshared-ell.la $(ell_ldadd)
 
 tools_gap_tester_SOURCES = tools/gap-tester.c monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu-ell.c \
diff --git a/tools/smp-tester.c b/tools/smp-tester.c
index 644c451c2..f78ab6fd8 100644
--- a/tools/smp-tester.c
+++ b/tools/smp-tester.c
@@ -18,7 +18,7 @@
 #include <stdbool.h>
 #include <sys/socket.h>
 
-#include <glib.h>
+#include <ell/ell.h>
 
 #include "lib/bluetooth.h"
 #include "lib/hci.h"
@@ -30,7 +30,7 @@
 
 #include "src/shared/crypto.h"
 #include "src/shared/ecc.h"
-#include "src/shared/tester.h"
+#include "src/shared/bttester.h"
 #include "src/shared/mgmt.h"
 
 #define SMP_CID 0x0006
@@ -41,7 +41,6 @@ struct test_data {
 	uint16_t mgmt_index;
 	struct hciemu *hciemu;
 	enum hciemu_type hciemu_type;
-	unsigned int io_id;
 	uint8_t ia[6];
 	uint8_t ia_type;
 	uint8_t ra[6];
@@ -82,27 +81,29 @@ struct smp_data {
 	bool sc;
 };
 
+static struct l_tester *tester;
+
 static void print_debug(const char *str, void *user_data)
 {
 	const char *prefix = user_data;
 
-	tester_print("%s%s", prefix, str);
+	bttester_print("%s%s", prefix, str);
 }
 
 static void read_info_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct mgmt_rp_read_info *rp = param;
 	char addr[18];
 	uint16_t manufacturer;
 	uint32_t supported_settings, current_settings;
 
-	tester_print("Read Info callback");
-	tester_print("  Status: 0x%02x", status);
+	bttester_print("Read Info callback");
+	bttester_print("  Status: 0x%02x", status);
 
 	if (status || !param) {
-		tester_pre_setup_failed();
+		l_tester_pre_setup_failed(tester);
 		return;
 	}
 
@@ -111,31 +112,31 @@ static void read_info_callback(uint8_t status, uint16_t length,
 	supported_settings = btohl(rp->supported_settings);
 	current_settings = btohl(rp->current_settings);
 
-	tester_print("  Address: %s", addr);
-	tester_print("  Version: 0x%02x", rp->version);
-	tester_print("  Manufacturer: 0x%04x", manufacturer);
-	tester_print("  Supported settings: 0x%08x", supported_settings);
-	tester_print("  Current settings: 0x%08x", current_settings);
-	tester_print("  Class: 0x%02x%02x%02x",
+	bttester_print("  Address: %s", addr);
+	bttester_print("  Version: 0x%02x", rp->version);
+	bttester_print("  Manufacturer: 0x%04x", manufacturer);
+	bttester_print("  Supported settings: 0x%08x", supported_settings);
+	bttester_print("  Current settings: 0x%08x", current_settings);
+	bttester_print("  Class: 0x%02x%02x%02x",
 			rp->dev_class[2], rp->dev_class[1], rp->dev_class[0]);
-	tester_print("  Name: %s", rp->name);
-	tester_print("  Short name: %s", rp->short_name);
+	bttester_print("  Name: %s", rp->name);
+	bttester_print("  Short name: %s", rp->short_name);
 
 	if (strcmp(hciemu_get_address(data->hciemu), addr)) {
-		tester_pre_setup_failed();
+		l_tester_pre_setup_failed(tester);
 		return;
 	}
 
-	tester_pre_setup_complete();
+	l_tester_pre_setup_complete(tester);
 }
 
 static void index_added_callback(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 
-	tester_print("Index Added callback");
-	tester_print("  Index: 0x%04x", index);
+	bttester_print("Index Added callback");
+	bttester_print("  Index: 0x%04x", index);
 
 	data->mgmt_index = index;
 
@@ -146,10 +147,10 @@ static void index_added_callback(uint16_t index, uint16_t length,
 static void index_removed_callback(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 
-	tester_print("Index Removed callback");
-	tester_print("  Index: 0x%04x", index);
+	bttester_print("Index Removed callback");
+	bttester_print("  Index: 0x%04x", index);
 
 	if (index != data->mgmt_index)
 		return;
@@ -159,19 +160,19 @@ static void index_removed_callback(uint16_t index, uint16_t length,
 	mgmt_unref(data->mgmt);
 	data->mgmt = NULL;
 
-	tester_post_teardown_complete();
+	l_tester_post_teardown_complete(tester);
 }
 
 static void read_index_list_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 
-	tester_print("Read Index List callback");
-	tester_print("  Status: 0x%02x", status);
+	bttester_print("Read Index List callback");
+	bttester_print("  Status: 0x%02x", status);
 
 	if (status || !param) {
-		tester_pre_setup_failed();
+		l_tester_pre_setup_failed(tester);
 		return;
 	}
 
@@ -183,36 +184,36 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 
 	data->hciemu = hciemu_new(data->hciemu_type);
 	if (!data->hciemu) {
-		tester_warn("Failed to setup HCI emulation");
-		tester_pre_setup_failed();
+		bttester_warn("Failed to setup HCI emulation");
+		l_tester_pre_setup_failed(tester);
 	}
 
-	if (tester_use_debug())
+	if (bttester_use_debug())
 		hciemu_set_debug(data->hciemu, print_debug, "hciemu: ", NULL);
 
-	tester_print("New hciemu instance created");
+	bttester_print("New hciemu instance created");
 }
 
 static void test_pre_setup(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 
 	data->crypto = bt_crypto_new();
 	if (!data->crypto) {
-		tester_warn("Failed to setup crypto");
-		tester_pre_setup_failed();
+		bttester_warn("Failed to setup crypto");
+		l_tester_pre_setup_failed(tester);
 		return;
 	}
 
 	data->mgmt = mgmt_new_default();
 	if (!data->mgmt) {
-		tester_warn("Failed to setup management interface");
+		bttester_warn("Failed to setup management interface");
 		bt_crypto_unref(data->crypto);
-		tester_pre_setup_failed();
+		l_tester_pre_setup_failed(tester);
 		return;
 	}
 
-	if (tester_use_debug())
+	if (bttester_use_debug())
 		mgmt_set_debug(data->mgmt, print_debug, "mgmt: ", NULL);
 
 	mgmt_send(data->mgmt, MGMT_OP_READ_INDEX_LIST, MGMT_INDEX_NONE, 0, NULL,
@@ -221,12 +222,7 @@ static void test_pre_setup(const void *test_data)
 
 static void test_post_teardown(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
-
-	if (data->io_id > 0) {
-		g_source_remove(data->io_id);
-		data->io_id = 0;
-	}
+	struct test_data *data = l_tester_get_data(tester);
 
 	if (data->crypto) {
 		bt_crypto_unref(data->crypto);
@@ -237,44 +233,38 @@ static void test_post_teardown(const void *test_data)
 	data->hciemu = NULL;
 }
 
-static void test_data_free(void *test_data)
-{
-	struct test_data *data = test_data;
-
-	free(data);
-}
-
 static void test_add_condition(struct test_data *data)
 {
 	data->unmet_conditions++;
 
-	tester_print("Test condition added, total %d", data->unmet_conditions);
+	bttester_print("Test condition added, total %d",
+						data->unmet_conditions);
 }
 
 static void test_condition_complete(struct test_data *data)
 {
 	data->unmet_conditions--;
 
-	tester_print("Test condition complete, %d left",
+	bttester_print("Test condition complete, %d left",
 						data->unmet_conditions);
 
 	if (data->unmet_conditions > 0)
 		return;
 
-	tester_test_passed();
+	l_tester_test_passed(tester);
 }
 
 #define test_smp(name, data, setup, func) \
 	do { \
 		struct test_data *user; \
-		user = calloc(1, sizeof(struct test_data)); \
+		user = l_new(struct test_data, 1);	\
 		if (!user) \
 			break; \
 		user->hciemu_type = HCIEMU_TYPE_BREDRLE; \
 		user->test_data = data; \
-		tester_add_full(name, data, \
+		l_tester_add_full(tester, name, data, \
 				test_pre_setup, setup, func, NULL, \
-				test_post_teardown, 2, user, test_data_free); \
+				test_post_teardown, 2, user, l_free); \
 	} while (0)
 
 static const uint8_t smp_nval_req_1[] = { 0x0b, 0x00 };
@@ -287,7 +277,7 @@ static const struct smp_req_rsp nval_req_1[] = {
 
 static const struct smp_data smp_server_nval_req_1_test = {
 	.req = nval_req_1,
-	.req_count = G_N_ELEMENTS(nval_req_1),
+	.req_count = L_ARRAY_SIZE(nval_req_1),
 };
 
 static const uint8_t smp_nval_req_2[7] = { 0x01 };
@@ -300,7 +290,7 @@ static const struct smp_req_rsp srv_nval_req_1[] = {
 
 static const struct smp_data smp_server_nval_req_2_test = {
 	.req = srv_nval_req_1,
-	.req_count = G_N_ELEMENTS(srv_nval_req_1),
+	.req_count = L_ARRAY_SIZE(srv_nval_req_1),
 };
 
 static const uint8_t smp_nval_req_3[] = { 0x01, 0xff };
@@ -313,7 +303,7 @@ static const struct smp_req_rsp srv_nval_req_2[] = {
 
 static const struct smp_data smp_server_nval_req_3_test = {
 	.req = srv_nval_req_2,
-	.req_count = G_N_ELEMENTS(srv_nval_req_2),
+	.req_count = L_ARRAY_SIZE(srv_nval_req_2),
 };
 
 static const uint8_t smp_basic_req_1[] = {	0x01,	/* Pairing Request */
@@ -347,7 +337,7 @@ static const struct smp_req_rsp srv_basic_req_1[] = {
 
 static const struct smp_data smp_server_basic_req_1_test = {
 	.req = srv_basic_req_1,
-	.req_count = G_N_ELEMENTS(srv_basic_req_1),
+	.req_count = L_ARRAY_SIZE(srv_basic_req_1),
 };
 
 static const struct smp_req_rsp cli_basic_req_1[] = {
@@ -361,7 +351,7 @@ static const struct smp_req_rsp cli_basic_req_1[] = {
 
 static const struct smp_data smp_client_basic_req_1_test = {
 	.req = cli_basic_req_1,
-	.req_count = G_N_ELEMENTS(cli_basic_req_1),
+	.req_count = L_ARRAY_SIZE(cli_basic_req_1),
 };
 
 static const uint8_t smp_basic_req_2[] = {	0x01,	/* Pairing Request */
@@ -384,7 +374,7 @@ static const struct smp_req_rsp cli_basic_req_2[] = {
 
 static const struct smp_data smp_client_basic_req_2_test = {
 	.req = cli_basic_req_2,
-	.req_count = G_N_ELEMENTS(cli_basic_req_1),
+	.req_count = L_ARRAY_SIZE(cli_basic_req_1),
 	.mitm = true,
 };
 
@@ -393,7 +383,7 @@ static void user_confirm_request_callback(uint16_t index, uint16_t length,
 							void *user_data)
 {
 	const struct mgmt_ev_user_confirm_request *ev = param;
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	struct mgmt_cp_user_confirm_reply cp;
 
 	memset(&cp, 0, sizeof(cp));
@@ -423,7 +413,7 @@ static const struct smp_req_rsp cli_sc_req_1[] = {
 
 static const struct smp_data smp_client_sc_req_1_test = {
 	.req = cli_sc_req_1,
-	.req_count = G_N_ELEMENTS(cli_sc_req_1),
+	.req_count = L_ARRAY_SIZE(cli_sc_req_1),
 	.sc = true,
 };
 
@@ -449,7 +439,7 @@ static const struct smp_req_rsp cli_sc_req_2[] = {
 
 static const struct smp_data smp_client_sc_req_2_test = {
 	.req = cli_sc_req_2,
-	.req_count = G_N_ELEMENTS(cli_sc_req_2),
+	.req_count = L_ARRAY_SIZE(cli_sc_req_2),
 	.sc = true,
 };
 
@@ -460,26 +450,26 @@ static void client_connectable_complete(uint16_t opcode, uint8_t status,
 	if (opcode != BT_HCI_CMD_LE_SET_ADV_ENABLE)
 		return;
 
-	tester_print("Client set connectable status 0x%02x", status);
+	bttester_print("Client set connectable status 0x%02x", status);
 
 	if (status)
-		tester_setup_failed();
+		l_tester_setup_failed(tester);
 	else
-		tester_setup_complete();
+		l_tester_setup_complete(tester);
 }
 
 static void setup_powered_client_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	struct bthost *bthost;
 
 	if (status != MGMT_STATUS_SUCCESS) {
-		tester_setup_failed();
+		l_tester_setup_failed(tester);
 		return;
 	}
 
-	tester_print("Controller powered on");
+	bttester_print("Controller powered on");
 
 	bthost = hciemu_client_get_host(data->hciemu);
 	bthost_set_cmd_complete_cb(bthost, client_connectable_complete, data);
@@ -489,15 +479,15 @@ static void setup_powered_client_callback(uint8_t status, uint16_t length,
 static void make_pk(struct test_data *data)
 {
 	if (!ecc_make_key(data->local_pk, data->local_sk)) {
-		tester_print("Failed to general local ECDH keypair");
-		tester_setup_failed();
+		bttester_print("Failed to general local ECDH keypair");
+		l_tester_setup_failed(tester);
 		return;
 	}
 }
 
 static void setup_powered_client(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct smp_data *smp = data->test_data;
 	unsigned char param[] = { 0x01 };
 
@@ -505,7 +495,7 @@ static void setup_powered_client(const void *test_data)
 			data->mgmt_index, user_confirm_request_callback,
 			data, NULL);
 
-	tester_print("Powering on controller");
+	bttester_print("Powering on controller");
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
 				sizeof(param), param, NULL, NULL, NULL);
@@ -529,16 +519,16 @@ static void pair_device_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
 	if (status != MGMT_STATUS_SUCCESS) {
-		tester_warn("Pairing failed: %s", mgmt_errstr(status));
+		bttester_warn("Pairing failed: %s", mgmt_errstr(status));
 		return;
 	}
 
-	tester_print("Pairing succeedded");
+	bttester_print("Pairing succeedded");
 }
 
 static const void *get_pdu(const uint8_t *pdu)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct smp_data *smp = data->test_data;
 	uint8_t opcode = pdu[0];
 	static uint8_t buf[65];
@@ -579,7 +569,7 @@ static const void *get_pdu(const uint8_t *pdu)
 
 static bool verify_random(const uint8_t rnd[16])
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	uint8_t confirm[16];
 
 	if (!bt_crypto_c1(data->crypto, data->tk, data->rrnd, data->prsp,
@@ -588,7 +578,7 @@ static bool verify_random(const uint8_t rnd[16])
 		return false;
 
 	if (memcmp(data->pcnf, confirm, sizeof(data->pcnf)) != 0) {
-		tester_warn("Confirmation values don't match");
+		bttester_warn("Confirmation values don't match");
 		return false;
 	}
 
@@ -620,13 +610,13 @@ static void smp_server(const void *data, uint16_t len, void *user_data)
 	const void *pdu;
 
 	if (len < 1) {
-		tester_warn("Received too small SMP PDU");
+		bttester_warn("Received too small SMP PDU");
 		goto failed;
 	}
 
 	opcode = *((const uint8_t *) data);
 
-	tester_print("Received SMP opcode 0x%02x", opcode);
+	bttester_print("Received SMP opcode 0x%02x", opcode);
 
 	if (test_data->counter >= smp->req_count) {
 		test_condition_complete(test_data);
@@ -638,7 +628,7 @@ static void smp_server(const void *data, uint16_t len, void *user_data)
 		goto next;
 
 	if (req->expect_len != len) {
-		tester_warn("Unexpected SMP PDU length (%u != %u)",
+		bttester_warn("Unexpected SMP PDU length (%u != %u)",
 							len, req->expect_len);
 		goto failed;
 	}
@@ -673,7 +663,7 @@ static void smp_server(const void *data, uint16_t len, void *user_data)
 	}
 
 	if (memcmp(req->expect, data, len) != 0) {
-		tester_warn("Unexpected SMP PDU");
+		bttester_warn("Unexpected SMP PDU");
 		goto failed;
 	}
 
@@ -698,7 +688,7 @@ next:
 	return;
 
 failed:
-	tester_test_failed();
+	l_tester_test_failed(tester);
 }
 
 static void command_hci_callback(uint16_t opcode, const void *param,
@@ -709,7 +699,7 @@ static void command_hci_callback(uint16_t opcode, const void *param,
 	const void *expect_hci_param = smp->expect_hci_param;
 	uint8_t expect_hci_len = smp->expect_hci_len;
 
-	tester_print("HCI Command 0x%04x length %u", opcode, length);
+	bttester_print("HCI Command 0x%04x length %u", opcode, length);
 
 	if (opcode != smp->expect_hci_command)
 		return;
@@ -718,14 +708,14 @@ static void command_hci_callback(uint16_t opcode, const void *param,
 		expect_hci_param = smp->expect_hci_func(&expect_hci_len);
 
 	if (length != expect_hci_len) {
-		tester_warn("Invalid parameter size for HCI command");
-		tester_test_failed();
+		bttester_warn("Invalid parameter size for HCI command");
+		l_tester_test_failed(tester);
 		return;
 	}
 
 	if (memcmp(param, expect_hci_param, length) != 0) {
-		tester_warn("Unexpected HCI command parameter value");
-		tester_test_failed();
+		bttester_warn("Unexpected HCI command parameter value");
+		l_tester_test_failed(tester);
 		return;
 	}
 
@@ -740,7 +730,7 @@ static void smp_new_conn(uint16_t handle, void *user_data)
 	const struct smp_req_rsp *req;
 	const void *pdu;
 
-	tester_print("New SMP client connection with handle 0x%04x", handle);
+	bttester_print("New SMP client connection with handle 0x%04x", handle);
 
 	data->handle = handle;
 
@@ -754,7 +744,7 @@ static void smp_new_conn(uint16_t handle, void *user_data)
 	if (!req->send)
 		return;
 
-	tester_print("Sending SMP PDU");
+	bttester_print("Sending SMP PDU");
 
 	pdu = get_pdu(req->send);
 	bthost_send_cid(bthost, handle, SMP_CID, pdu, req->send_len);
@@ -769,15 +759,15 @@ static void init_bdaddr(struct test_data *data)
 
 	master_bdaddr = hciemu_get_master_bdaddr(data->hciemu);
 	if (!master_bdaddr) {
-		tester_warn("No master bdaddr");
-		tester_test_failed();
+		bttester_warn("No master bdaddr");
+		l_tester_test_failed(tester);
 		return;
 	}
 
 	client_bdaddr = hciemu_get_client_bdaddr(data->hciemu);
 	if (!client_bdaddr) {
-		tester_warn("No client bdaddr");
-		tester_test_failed();
+		bttester_warn("No client bdaddr");
+		l_tester_test_failed(tester);
 		return;
 	}
 
@@ -795,7 +785,7 @@ static void init_bdaddr(struct test_data *data)
 
 static void test_client(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct smp_data *smp = data->test_data;
 	struct mgmt_cp_pair_device cp;
 	struct bthost *bthost;
@@ -807,7 +797,7 @@ static void test_client(const void *test_data)
 	test_add_condition(data);
 
 	if (smp->expect_hci_command) {
-		tester_print("Registering HCI command callback");
+		bttester_print("Registering HCI command callback");
 		hciemu_add_master_post_command_hook(data->hciemu,
 						command_hci_callback, data);
 		test_add_condition(data);
@@ -823,25 +813,25 @@ static void test_client(const void *test_data)
 	mgmt_send(data->mgmt, MGMT_OP_PAIR_DEVICE, data->mgmt_index,
 			sizeof(cp), &cp, pair_device_complete, NULL, NULL);
 
-	tester_print("Pairing in progress");
+	bttester_print("Pairing in progress");
 }
 
 static void setup_powered_server_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
 	if (status != MGMT_STATUS_SUCCESS) {
-		tester_setup_failed();
+		l_tester_setup_failed(tester);
 		return;
 	}
 
-	tester_print("Controller powered on");
+	bttester_print("Controller powered on");
 
-	tester_setup_complete();
+	l_tester_setup_complete(tester);
 }
 
 static void setup_powered_server(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct smp_data *smp = data->test_data;
 	unsigned char param[] = { 0x01 };
 
@@ -849,7 +839,7 @@ static void setup_powered_server(const void *test_data)
 			data->mgmt_index, user_confirm_request_callback,
 			data, NULL);
 
-	tester_print("Powering on controller");
+	bttester_print("Powering on controller");
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
 				sizeof(param), param, NULL, NULL, NULL);
@@ -873,7 +863,7 @@ static void setup_powered_server(const void *test_data)
 
 static void test_server(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct smp_data *smp = data->test_data;
 	struct bthost *bthost;
 
@@ -888,7 +878,7 @@ static void test_server(const void *test_data)
 	bthost_hci_connect(bthost, data->ra, BDADDR_LE_PUBLIC);
 
 	if (smp->expect_hci_command) {
-		tester_print("Registering HCI command callback");
+		bttester_print("Registering HCI command callback");
 		hciemu_add_master_post_command_hook(data->hciemu,
 						command_hci_callback, data);
 		test_add_condition(data);
@@ -897,7 +887,7 @@ static void test_server(const void *test_data)
 
 int main(int argc, char *argv[])
 {
-	tester_init(&argc, &argv);
+	tester = bttester_init(&argc, &argv);
 
 	test_smp("SMP Server - Basic Request 1",
 					&smp_server_basic_req_1_test,
@@ -926,5 +916,5 @@ int main(int argc, char *argv[])
 					&smp_client_sc_req_2_test,
 					setup_powered_client, test_client);
 
-	return tester_run();
+	return bttester_run();
 }
-- 
2.26.3

