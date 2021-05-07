Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0998C433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 May 2021 05:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C17A4613DD
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 May 2021 05:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbhEGF5t (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 May 2021 01:57:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:57302 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234416AbhEGF5r (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 May 2021 01:57:47 -0400
IronPort-SDR: hIpwfQrrIqxj19+tVemPx3WMiDbPIUCviO0Aio8bvsIFKF5Jv+1swKmFuWnaFZbE6/gSgiSIwR
 xzcAKFy/Tgtg==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="198305481"
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="198305481"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 22:56:47 -0700
IronPort-SDR: n3dtFgqa2xyw6tAeJUFJhBSQXKwG/TqJYlea45H9d1c1/QZObtqHVQNM8jBsvv2M80XPD27OzU
 iY3iJKov3yzQ==
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="407314593"
Received: from jinhuach-mobl1.ccr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.254.7.101])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 22:56:46 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, Inga Stotland <inga.stotland@intel.com>
Subject: [RFC BlueZ v2 11/11] tools/hci-tester: Convert to use ELL library
Date:   Thu,  6 May 2021 22:56:29 -0700
Message-Id: <20210507055629.338409-12-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210507055629.338409-1-inga.stotland@intel.com>
References: <20210507055629.338409-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This reworks the source code to use ELL primitives and removes
dependencies on GLib.
---
 Makefile.tools     |   2 +-
 tools/hci-tester.c | 289 ++++++++++++++++++++++-----------------------
 2 files changed, 143 insertions(+), 148 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index c1fa16e9a..930398cab 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -168,7 +168,7 @@ tools_sco_tester_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-ell.la $(ell_ldadd)
 
 tools_hci_tester_SOURCES = tools/hci-tester.c monitor/bt.h
-tools_hci_tester_LDADD = src/libshared-glib.la $(GLIB_LIBS)
+tools_hci_tester_LDADD = src/libshared-ell.la $(ell_ldadd)
 
 tools_userchan_tester_SOURCES = tools/userchan-tester.c monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu-ell.c \
diff --git a/tools/hci-tester.c b/tools/hci-tester.c
index 0fb74e69c..447ed4a5d 100644
--- a/tools/hci-tester.c
+++ b/tools/hci-tester.c
@@ -15,11 +15,13 @@
 #include <stdlib.h>
 #include <string.h>
 
+#include <ell/ell.h>
+
 #include "monitor/bt.h"
 #include "src/shared/hci.h"
 #include "src/shared/util.h"
 #include "src/shared/ecc.h"
-#include "src/shared/tester.h"
+#include "src/shared/bttester.h"
 
 struct user_data {
 	const void *test_data;
@@ -38,6 +40,8 @@ struct le_keys {
 	uint8_t local_pk[64];
 } key_test_data;
 
+static struct l_tester *tester;
+
 static void swap_buf(const uint8_t *src, uint8_t *dst, uint16_t len)
 {
 	int i;
@@ -48,43 +52,43 @@ static void swap_buf(const uint8_t *src, uint8_t *dst, uint16_t len)
 
 static void test_debug(const char *str, void *user_data)
 {
-	tester_debug("%s", str);
+	bttester_debug("%s", str);
 }
 
 static void test_pre_setup_lt_address(const void *data, uint8_t size,
 							void *user_data)
 {
-	struct user_data *user = tester_get_data();
+	struct user_data *user = l_tester_get_data(tester);
 	const struct bt_hci_rsp_read_bd_addr *rsp = data;
 
 	if (rsp->status) {
-		tester_warn("Read lower tester address failed (0x%02x)",
+		bttester_warn("Read lower tester address failed (0x%02x)",
 								rsp->status);
-		tester_pre_setup_failed();
+		l_tester_pre_setup_failed(tester);
 		return;
 	}
 
 	memcpy(user->bdaddr_lt, rsp->bdaddr, 6);
 
-	tester_pre_setup_complete();
+	l_tester_pre_setup_complete(tester);
 }
 
 static void test_pre_setup_lt_complete(const void *data, uint8_t size,
 							void *user_data)
 {
-	struct user_data *user = tester_get_data();
+	struct user_data *user = l_tester_get_data(tester);
 	uint8_t status = *((uint8_t *) data);
 
 	if (status) {
-		tester_warn("Reset lower tester failed (0x%02x)", status);
-		tester_pre_setup_failed();
+		bttester_warn("Reset lower tester failed (0x%02x)", status);
+		l_tester_pre_setup_failed(tester);
 		return;
 	}
 
 	if (!bt_hci_send(user->hci_lt, BT_HCI_CMD_READ_BD_ADDR, NULL, 0,
 				test_pre_setup_lt_address, NULL, NULL)) {
-		tester_warn("Failed to read lower tester address");
-		tester_pre_setup_failed();
+		bttester_warn("Failed to read lower tester address");
+		l_tester_pre_setup_failed(tester);
 		return;
 	}
 }
@@ -92,13 +96,13 @@ static void test_pre_setup_lt_complete(const void *data, uint8_t size,
 static void test_pre_setup_ut_address(const void *data, uint8_t size,
 							void *user_data)
 {
-	struct user_data *user = tester_get_data();
+	struct user_data *user = l_tester_get_data(tester);
 	const struct bt_hci_rsp_read_bd_addr *rsp = data;
 
 	if (rsp->status) {
-		tester_warn("Read upper tester address failed (0x%02x)",
+		bttester_warn("Read upper tester address failed (0x%02x)",
 								rsp->status);
-		tester_pre_setup_failed();
+		l_tester_pre_setup_failed(tester);
 		return;
 	}
 
@@ -106,15 +110,15 @@ static void test_pre_setup_ut_address(const void *data, uint8_t size,
 
 	user->hci_lt = bt_hci_new_user_channel(user->index_lt);
 	if (!user->hci_lt) {
-		tester_warn("Failed to setup lower tester user channel");
-		tester_pre_setup_failed();
+		bttester_warn("Failed to setup lower tester user channel");
+		l_tester_pre_setup_failed(tester);
 		return;
 	}
 
 	if (!bt_hci_send(user->hci_lt, BT_HCI_CMD_RESET, NULL, 0,
 				test_pre_setup_lt_complete, NULL, NULL)) {
-		tester_warn("Failed to reset lower tester");
-		tester_pre_setup_failed();
+		bttester_warn("Failed to reset lower tester");
+		l_tester_pre_setup_failed(tester);
 		return;
 	}
 }
@@ -122,50 +126,50 @@ static void test_pre_setup_ut_address(const void *data, uint8_t size,
 static void test_pre_setup_ut_complete(const void *data, uint8_t size,
 							void *user_data)
 {
-	struct user_data *user = tester_get_data();
+	struct user_data *user = l_tester_get_data(tester);
 	uint8_t status = *((uint8_t *) data);
 
 	if (status) {
-		tester_warn("Reset upper tester failed (0x%02x)", status);
-		tester_pre_setup_failed();
+		bttester_warn("Reset upper tester failed (0x%02x)", status);
+		l_tester_pre_setup_failed(tester);
 		return;
 	}
 
 	if (user->index_lt == 0xffff) {
-		tester_pre_setup_complete();
+		l_tester_pre_setup_complete(tester);
 		return;
 	}
 
 	if (!bt_hci_send(user->hci_ut, BT_HCI_CMD_READ_BD_ADDR, NULL, 0,
 				test_pre_setup_ut_address, NULL, NULL)) {
-		tester_warn("Failed to read upper tester address");
-		tester_pre_setup_failed();
+		bttester_warn("Failed to read upper tester address");
+		l_tester_pre_setup_failed(tester);
 		return;
 	}
 }
 
 static void test_pre_setup(const void *test_data)
 {
-	struct user_data *user = tester_get_data();
+	struct user_data *user = l_tester_get_data(tester);
 
 	user->hci_ut = bt_hci_new_user_channel(user->index_ut);
 	if (!user->hci_ut) {
-		tester_warn("Failed to setup upper tester user channel");
-		tester_pre_setup_failed();
+		bttester_warn("Failed to setup upper tester user channel");
+		l_tester_pre_setup_failed(tester);
 		return;
 	}
 
 	if (!bt_hci_send(user->hci_ut, BT_HCI_CMD_RESET, NULL, 0,
 				test_pre_setup_ut_complete, NULL, NULL)) {
-		tester_warn("Failed to reset upper tester");
-		tester_pre_setup_failed();
+		bttester_warn("Failed to reset upper tester");
+		l_tester_pre_setup_failed(tester);
 		return;
 	}
 }
 
 static void test_post_teardown(const void *test_data)
 {
-	struct user_data *user = tester_get_data();
+	struct user_data *user = l_tester_get_data(tester);
 
 	bt_hci_unref(user->hci_lt);
 	user->hci_lt = NULL;
@@ -173,42 +177,31 @@ static void test_post_teardown(const void *test_data)
 	bt_hci_unref(user->hci_ut);
 	user->hci_ut = NULL;
 
-	tester_post_teardown_complete();
-}
-
-static void user_data_free(void *data)
-{
-	struct user_data *user = data;
-
-	free(user);
+	l_tester_post_teardown_complete(tester);
 }
 
 #define test_hci(name, data, setup, func, teardown) \
 	do { \
 		struct user_data *user; \
-		user = calloc(1, sizeof(struct user_data)); \
-		if (!user) \
-			break; \
+		user = l_new(struct user_data, 1);	\
 		user->test_data = data; \
 		user->index_ut = 0; \
 		user->index_lt = 1; \
-		tester_add_full(name, data, \
+		l_tester_add_full(tester, name, data,		       \
 				test_pre_setup, setup, func, teardown, \
-				test_post_teardown, 30, user, user_data_free); \
+				test_post_teardown, 30, user, l_free); \
 	} while (0)
 
 #define test_hci_local(name, data, setup, func) \
 	do { \
 		struct user_data *user; \
-		user = calloc(1, sizeof(struct user_data)); \
-		if (!user) \
-			break; \
+		user = l_new(struct user_data, 1);	\
 		user->test_data = data; \
 		user->index_ut = 0; \
 		user->index_lt = 0xffff; \
-		tester_add_full(name, data, \
+		l_tester_add_full(tester, name, data,		   \
 				test_pre_setup, setup, func, NULL, \
-				test_post_teardown, 30, user, user_data_free); \
+				test_post_teardown, 30, user, l_free); \
 	} while (0)
 
 static void setup_features_complete(const void *data, uint8_t size,
@@ -217,29 +210,30 @@ static void setup_features_complete(const void *data, uint8_t size,
 	const struct bt_hci_rsp_read_local_features *rsp = data;
 
 	if (rsp->status) {
-		tester_warn("Failed to get HCI features (0x%02x)", rsp->status);
-		tester_setup_failed();
+		bttester_warn("Failed to get HCI features (0x%02x)",
+								rsp->status);
+		l_tester_setup_failed(tester);
 		return;
 	}
 
-	tester_setup_complete();
+	l_tester_setup_complete(tester);
 }
 
 static void setup_features(const void *test_data)
 {
-	struct user_data *user = tester_get_data();
+	struct user_data *user = l_tester_get_data(tester);
 
 	if (!bt_hci_send(user->hci_ut, BT_HCI_CMD_READ_LOCAL_FEATURES, NULL, 0,
 					setup_features_complete, NULL, NULL)) {
-		tester_warn("Failed to send HCI features command");
-		tester_setup_failed();
+		bttester_warn("Failed to send HCI features command");
+		l_tester_setup_failed(tester);
 		return;
 	}
 }
 
 static void test_reset(const void *test_data)
 {
-	tester_test_passed();
+	l_tester_test_passed(tester);
 }
 
 static void test_command_complete(const void *data, uint8_t size,
@@ -248,22 +242,22 @@ static void test_command_complete(const void *data, uint8_t size,
 	uint8_t status = *((uint8_t *) data);
 
 	if (status) {
-		tester_warn("HCI command failed (0x%02x)", status);
-		tester_test_failed();
+		bttester_warn("HCI command failed (0x%02x)", status);
+		l_tester_test_failed(tester);
 		return;
 	}
 
-	tester_test_passed();
+	l_tester_test_passed(tester);
 }
 
 static void test_command(uint16_t opcode)
 {
-	struct user_data *user = tester_get_data();
+	struct user_data *user = l_tester_get_data(tester);
 
 	if (!bt_hci_send(user->hci_ut, opcode, NULL, 0,
 					test_command_complete, NULL, NULL)) {
-		tester_warn("Failed to send HCI command 0x%04x", opcode);
-		tester_test_failed();
+		bttester_warn("Failed to send HCI command 0x%04x", opcode);
+		l_tester_test_failed(tester);
 		return;
 	}
 }
@@ -289,18 +283,18 @@ static void test_local_extended_features_complete(const void *data,
 	const struct bt_hci_rsp_read_local_ext_features *rsp = data;
 
 	if (rsp->status) {
-		tester_warn("Failed to get HCI extended features (0x%02x)",
+		bttester_warn("Failed to get HCI extended features (0x%02x)",
 								rsp->status);
-		tester_test_failed();
+		l_tester_test_failed(tester);
 		return;
 	}
 
-	tester_test_passed();
+	l_tester_test_passed(tester);
 }
 
 static void test_read_local_extended_features(const void *test_data)
 {
-	struct user_data *user = tester_get_data();
+	struct user_data *user = l_tester_get_data(tester);
 	struct bt_hci_cmd_read_local_ext_features cmd;
 
 	cmd.page = 0x00;
@@ -309,8 +303,8 @@ static void test_read_local_extended_features(const void *test_data)
 					&cmd, sizeof(cmd),
 					test_local_extended_features_complete,
 								NULL, NULL)) {
-		tester_warn("Failed to send HCI extended features command");
-		tester_test_failed();
+		bttester_warn("Failed to send HCI extended features command");
+		l_tester_test_failed(tester);
 		return;
 	}
 }
@@ -356,8 +350,8 @@ static void test_le_encrypt_complete(const void *data, uint8_t size,
 	uint8_t enc_data[16];
 
 	if (rsp->status) {
-		tester_warn("Failed HCI LE Encrypt (0x%02x)", rsp->status);
-		tester_test_failed();
+		bttester_warn("Failed HCI LE Encrypt (0x%02x)", rsp->status);
+		l_tester_test_failed(tester);
 		return;
 	}
 
@@ -365,15 +359,15 @@ static void test_le_encrypt_complete(const void *data, uint8_t size,
 	util_hexdump('>', enc_data, 16, test_debug, NULL);
 
 	if (!memcmp(sample, enc_data, 16))
-		tester_test_passed();
+		l_tester_test_passed(tester);
 	else
-		tester_test_failed();
+		l_tester_test_failed(tester);
 }
 
 /* Data are taken from RFC 4493 Test Vectors */
 static void test_le_encrypt(const void *test_data)
 {
-	struct user_data *user = tester_get_data();
+	struct user_data *user = l_tester_get_data(tester);
 	struct bt_hci_cmd_le_encrypt cmd;
 	uint8_t key[16] = {
 		0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6,
@@ -392,8 +386,8 @@ static void test_le_encrypt(const void *test_data)
 
 	if (!bt_hci_send(user->hci_ut, BT_HCI_CMD_LE_ENCRYPT, &cmd, sizeof(cmd),
 					test_le_encrypt_complete, NULL, NULL)) {
-		tester_warn("Failed to send HCI LE Encrypt command");
-		tester_test_failed();
+		bttester_warn("Failed to send HCI LE Encrypt command");
+		l_tester_test_failed(tester);
 		return;
 	}
 
@@ -412,16 +406,16 @@ static void test_le_read_local_pk_complete(const void *data, uint8_t size,
 	struct le_keys *keys = user_data;
 
 	if (*event != BT_HCI_EVT_LE_READ_LOCAL_PK256_COMPLETE) {
-		tester_warn("Failed Read Local PK256 command");
-		tester_test_failed();
+		bttester_warn("Failed Read Local PK256 command");
+		l_tester_test_failed(tester);
 		return;
 	}
 
 	evt = (void *)(event + 1);
 	if (evt->status) {
-		tester_warn("HCI Read Local PK complete failed (0x%02x)",
+		bttester_warn("HCI Read Local PK complete failed (0x%02x)",
 								evt->status);
-		tester_test_failed();
+		l_tester_test_failed(tester);
 		return;
 	}
 
@@ -429,7 +423,7 @@ static void test_le_read_local_pk_complete(const void *data, uint8_t size,
 
 	util_hexdump('>', evt->local_pk256, 64, test_debug, NULL);
 
-	tester_test_passed();
+	l_tester_test_passed(tester);
 }
 
 static void test_le_read_local_pk_status(const void *data, uint8_t size,
@@ -438,15 +432,16 @@ static void test_le_read_local_pk_status(const void *data, uint8_t size,
 	uint8_t status = *((uint8_t *) data);
 
 	if (status) {
-		tester_warn("Failed to send Read Local PK256 cmd (0x%02x)", status);
-		tester_test_failed();
+		bttester_warn("Failed to send Read Local PK256 cmd (0x%02x)",
+									status);
+		l_tester_test_failed(tester);
 		return;
 	}
 }
 
 static void test_le_read_local_pk(const void *test_data)
 {
-	struct user_data *user = tester_get_data();
+	struct user_data *user = l_tester_get_data(tester);
 	struct bt_hci_cmd_set_event_mask sem;
 	struct bt_hci_cmd_le_set_event_mask lsem;
 
@@ -471,8 +466,8 @@ static void test_le_read_local_pk(const void *test_data)
 	if (!bt_hci_send(user->hci_ut, BT_HCI_CMD_LE_READ_LOCAL_PK256, NULL,
 				0, test_le_read_local_pk_status,
 				NULL, NULL)) {
-		tester_warn("Failed to send HCI LE Read Local PK256 command");
-		tester_test_failed();
+		bttester_warn("Failed to send HCI LE Read Local PK256 command");
+		l_tester_test_failed(tester);
 		return;
 	}
 }
@@ -485,16 +480,16 @@ static void setup_le_read_local_pk_complete(const void *data, uint8_t size,
 	struct le_keys *keys = user_data;
 
 	if (*event != BT_HCI_EVT_LE_READ_LOCAL_PK256_COMPLETE) {
-		tester_warn("Failed Read Local PK256 command");
-		tester_setup_failed();
+		bttester_warn("Failed Read Local PK256 command");
+		l_tester_setup_failed(tester);
 		return;
 	}
 
 	evt = (void *)(event + 1);
 	if (evt->status) {
-		tester_warn("HCI Read Local PK complete failed (0x%02x)",
+		bttester_warn("HCI Read Local PK complete failed (0x%02x)",
 								evt->status);
-		tester_setup_failed();
+		l_tester_setup_failed(tester);
 		return;
 	}
 
@@ -502,7 +497,7 @@ static void setup_le_read_local_pk_complete(const void *data, uint8_t size,
 
 	util_hexdump('>', evt->local_pk256, 64, test_debug, NULL);
 
-	tester_setup_complete();
+	l_tester_setup_complete(tester);
 }
 
 static void setup_le_read_local_pk_status(const void *data, uint8_t size,
@@ -511,15 +506,15 @@ static void setup_le_read_local_pk_status(const void *data, uint8_t size,
 	uint8_t status = *((uint8_t *) data);
 
 	if (status) {
-		tester_warn("Failed to send DHKey gen cmd (0x%02x)", status);
-		tester_setup_failed();
+		bttester_warn("Failed to send DHKey gen cmd (0x%02x)", status);
+		l_tester_setup_failed(tester);
 		return;
 	}
 }
 
 static void setup_le_generate_dhkey(const void *test_data)
 {
-	struct user_data *user = tester_get_data();
+	struct user_data *user = l_tester_get_data(tester);
 	struct bt_hci_cmd_set_event_mask sem;
 	struct bt_hci_cmd_le_set_event_mask lsem;
 
@@ -545,8 +540,8 @@ static void setup_le_generate_dhkey(const void *test_data)
 	if (!bt_hci_send(user->hci_ut, BT_HCI_CMD_LE_READ_LOCAL_PK256, NULL,
 				0, setup_le_read_local_pk_status,
 				NULL, NULL)) {
-		tester_warn("Failed to send HCI LE Read Local PK256 command");
-		tester_setup_failed();
+		bttester_warn("Failed to send HCI LE Read Local PK256 command");
+		l_tester_setup_failed(tester);
 		return;
 	}
 }
@@ -560,16 +555,16 @@ static void test_le_generate_dhkey_complete(const void *data, uint8_t size,
 	uint8_t dhkey[32];
 
 	if (*event != BT_HCI_EVT_LE_GENERATE_DHKEY_COMPLETE) {
-		tester_warn("Failed DHKey generation command");
-		tester_test_failed();
+		bttester_warn("Failed DHKey generation command");
+		l_tester_test_failed(tester);
 		return;
 	}
 
 	evt = (void *)(event + 1);
 	if (evt->status) {
-		tester_warn("HCI Generate DHKey complete failed (0x%02x)",
+		bttester_warn("HCI Generate DHKey complete failed (0x%02x)",
 								evt->status);
-		tester_test_failed();
+		l_tester_test_failed(tester);
 		return;
 	}
 
@@ -588,9 +583,9 @@ static void test_le_generate_dhkey_complete(const void *data, uint8_t size,
 	util_hexdump('D', dhkey, 32, test_debug, NULL);
 
 	if (!memcmp(dhkey, evt->dhkey, 32))
-		tester_test_passed();
+		l_tester_test_passed(tester);
 	else
-		tester_test_failed();
+		l_tester_test_failed(tester);
 }
 
 static void test_le_generate_dhkey_status(const void *data, uint8_t size,
@@ -599,15 +594,15 @@ static void test_le_generate_dhkey_status(const void *data, uint8_t size,
 	uint8_t status = *((uint8_t *) data);
 
 	if (status) {
-		tester_warn("Failed to send DHKey gen cmd (0x%02x)", status);
-		tester_test_failed();
+		bttester_warn("Failed to send DHKey gen cmd (0x%02x)", status);
+		l_tester_test_failed(tester);
 		return;
 	}
 }
 
 static void test_le_generate_dhkey(const void *test_data)
 {
-	struct user_data *user = tester_get_data();
+	struct user_data *user = l_tester_get_data(tester);
 	struct bt_hci_cmd_le_generate_dhkey cmd;
 	struct le_keys *keys = (void *)test_data;
 
@@ -623,8 +618,8 @@ static void test_le_generate_dhkey(const void *test_data)
 	if (!bt_hci_send(user->hci_ut, BT_HCI_CMD_LE_GENERATE_DHKEY, &cmd,
 				sizeof(cmd), test_le_generate_dhkey_status,
 				NULL, NULL)) {
-		tester_warn("Failed to send HCI LE Encrypt command");
-		tester_test_failed();
+		bttester_warn("Failed to send HCI LE Encrypt command");
+		l_tester_test_failed(tester);
 		return;
 	}
 
@@ -636,13 +631,13 @@ static void test_inquiry_complete(const void *data, uint8_t size,
 	const struct bt_hci_evt_inquiry_complete *evt = data;
 
 	if (evt->status) {
-		tester_warn("HCI inquiry complete failed (0x%02x)",
+		bttester_warn("HCI inquiry complete failed (0x%02x)",
 							evt->status);
-		tester_test_failed();
+		l_tester_test_failed(tester);
 		return;
 	}
 
-	tester_test_passed();
+	l_tester_test_passed(tester);
 }
 
 static void test_inquiry_status(const void *data, uint8_t size,
@@ -651,15 +646,15 @@ static void test_inquiry_status(const void *data, uint8_t size,
 	uint8_t status = *((uint8_t *) data);
 
 	if (status) {
-		tester_warn("HCI inquiry command failed (0x%02x)", status);
-		tester_test_failed();
+		bttester_warn("HCI inquiry command failed (0x%02x)", status);
+		l_tester_test_failed(tester);
 		return;
 	}
 }
 
 static void test_inquiry_liac(const void *test_data)
 {
-	struct user_data *user = tester_get_data();
+	struct user_data *user = l_tester_get_data(tester);
 	struct bt_hci_cmd_inquiry cmd;
 
 	bt_hci_register(user->hci_ut, BT_HCI_EVT_INQUIRY_COMPLETE,
@@ -673,8 +668,8 @@ static void test_inquiry_liac(const void *test_data)
 
 	if (!bt_hci_send(user->hci_ut, BT_HCI_CMD_INQUIRY, &cmd, sizeof(cmd),
 					test_inquiry_status, NULL, NULL)) {
-		tester_warn("Failed to send HCI inquiry command");
-		tester_test_failed();
+		bttester_warn("Failed to send HCI inquiry command");
+		l_tester_test_failed(tester);
 		return;
 	}
 }
@@ -685,18 +680,18 @@ static void setup_lt_connectable_complete(const void *data, uint8_t size,
 	uint8_t status = *((uint8_t *) data);
 
 	if (status) {
-		tester_warn("Failed to set HCI scan enable (0x%02x)", status);
-		tester_setup_failed();
+		bttester_warn("Failed to set HCI scan enable (0x%02x)", status);
+		l_tester_setup_failed(tester);
 		return;
 	}
 
-	tester_setup_complete();
+	l_tester_setup_complete(tester);
 }
 
 static void setup_lt_connect_request_accept(const void *data, uint8_t size,
 							void *user_data)
 {
-	struct user_data *user = tester_get_data();
+	struct user_data *user = l_tester_get_data(tester);
 	const struct bt_hci_evt_conn_request *evt = data;
 	struct bt_hci_cmd_accept_conn_request cmd;
 
@@ -705,14 +700,14 @@ static void setup_lt_connect_request_accept(const void *data, uint8_t size,
 
 	if (!bt_hci_send(user->hci_lt, BT_HCI_CMD_ACCEPT_CONN_REQUEST,
 					&cmd, sizeof(cmd), NULL, NULL, NULL)) {
-		tester_warn("Failed to send HCI accept connection command");
+		bttester_warn("Failed to send HCI accept connection command");
 		return;
 	}
 }
 
 static void setup_lt_connectable(const void *test_data)
 {
-	struct user_data *user = tester_get_data();
+	struct user_data *user = l_tester_get_data(tester);
 	struct bt_hci_cmd_write_scan_enable cmd;
 
 	bt_hci_register(user->hci_lt, BT_HCI_EVT_CONN_REQUEST,
@@ -723,33 +718,33 @@ static void setup_lt_connectable(const void *test_data)
 	if (!bt_hci_send(user->hci_lt, BT_HCI_CMD_WRITE_SCAN_ENABLE,
 				&cmd, sizeof(cmd),
 				setup_lt_connectable_complete, NULL, NULL)) {
-		tester_warn("Failed to send HCI scan enable command");
-		tester_setup_failed();
+		bttester_warn("Failed to send HCI scan enable command");
+		l_tester_setup_failed(tester);
 		return;
 	}
 }
 
 static void test_create_connection_disconnect(void *user_data)
 {
-	tester_test_passed();
+	l_tester_test_passed(tester);
 }
 
 static void test_create_connection_complete(const void *data, uint8_t size,
 							void *user_data)
 {
-	struct user_data *user = tester_get_data();
+	struct user_data *user = l_tester_get_data(tester);
 	const struct bt_hci_evt_conn_complete *evt = data;
 
 	if (evt->status) {
-		tester_warn("HCI create connection complete failed (0x%02x)",
+		bttester_warn("HCI create connection complete failed (0x%02x)",
 								evt->status);
-		tester_test_failed();
+		l_tester_test_failed(tester);
 		return;
 	}
 
 	user->handle_ut = le16_to_cpu(evt->handle);
 
-	tester_wait(2, test_create_connection_disconnect, NULL);
+	l_tester_wait(tester, 2, test_create_connection_disconnect, NULL);
 }
 
 static void test_create_connection_status(const void *data, uint8_t size,
@@ -758,16 +753,16 @@ static void test_create_connection_status(const void *data, uint8_t size,
 	uint8_t status = *((uint8_t *) data);
 
 	if (status) {
-		tester_warn("HCI create connection command failed (0x%02x)",
+		bttester_warn("HCI create connection command failed (0x%02x)",
 								status);
-		tester_test_failed();
+		l_tester_test_failed(tester);
 		return;
 	}
 }
 
 static void test_create_connection(const void *test_data)
 {
-	struct user_data *user = tester_get_data();
+	struct user_data *user = l_tester_get_data(tester);
 	struct bt_hci_cmd_create_conn cmd;
 
 	bt_hci_register(user->hci_ut, BT_HCI_EVT_CONN_COMPLETE,
@@ -784,15 +779,15 @@ static void test_create_connection(const void *test_data)
 						&cmd, sizeof(cmd),
 						test_create_connection_status,
 								NULL, NULL)) {
-		tester_warn("Failed to send HCI create connection command");
-		tester_test_failed();
+		bttester_warn("Failed to send HCI create connection command");
+		l_tester_test_failed(tester);
 		return;
 	}
 }
 
 static void teardown_timeout(void *user_data)
 {
-	tester_teardown_complete();
+	l_tester_teardown_complete(tester);
 }
 
 static void teardown_disconnect_status(const void *data, uint8_t size,
@@ -801,17 +796,17 @@ static void teardown_disconnect_status(const void *data, uint8_t size,
 	uint8_t status = *((uint8_t *) data);
 
 	if (status) {
-		tester_warn("HCI disconnect failed (0x%02x)", status);
-		tester_teardown_failed();
+		bttester_warn("HCI disconnect failed (0x%02x)", status);
+		l_tester_teardown_failed(tester);
 		return;
 	}
 
-	tester_wait(1, teardown_timeout, NULL);
+	l_tester_wait(tester, 1, teardown_timeout, NULL);
 }
 
 static void teardown_connection(const void *test_data)
 {
-	struct user_data *user = tester_get_data();
+	struct user_data *user = l_tester_get_data(tester);
 	struct bt_hci_cmd_disconnect cmd;
 
 	cmd.handle = cpu_to_le16(user->handle_ut);
@@ -821,29 +816,29 @@ static void teardown_connection(const void *test_data)
 						&cmd, sizeof(cmd),
 						teardown_disconnect_status,
 								NULL, NULL)) {
-		tester_warn("Failed to send HCI disconnect command");
-		tester_test_failed();
+		bttester_warn("Failed to send HCI disconnect command");
+		l_tester_test_failed(tester);
 		return;
 	}
 }
 
 static void test_adv_report(const void *data, uint8_t size, void *user_data)
 {
-	struct user_data *user = tester_get_data();
+	struct user_data *user = l_tester_get_data(tester);
 	uint8_t subevent = *((uint8_t *) data);
 	const struct bt_hci_evt_le_adv_report *lar = data + 1;
 
 	switch (subevent) {
 	case BT_HCI_EVT_LE_ADV_REPORT:
 		if (!memcmp(lar->addr, user->bdaddr_ut, 6))
-			tester_setup_complete();
+			l_tester_setup_complete(tester);
 		break;
 	}
 }
 
 static void setup_advertising_initiated(const void *test_data)
 {
-	struct user_data *user = tester_get_data();
+	struct user_data *user = l_tester_get_data(tester);
 	struct bt_hci_cmd_set_event_mask sem;
 	struct bt_hci_cmd_le_set_event_mask lsem;
 	struct bt_hci_cmd_le_set_scan_enable lsse;
@@ -893,7 +888,7 @@ static void setup_advertising_initiated(const void *test_data)
 
 static void test_reset_in_advertising_state_timeout(void *user_data)
 {
-	struct user_data *user = tester_get_data();
+	struct user_data *user = l_tester_get_data(tester);
 	struct bt_hci_cmd_le_set_adv_enable lsae;
 	struct bt_hci_cmd_le_set_scan_enable lsse;
 
@@ -908,21 +903,21 @@ static void test_reset_in_advertising_state_timeout(void *user_data)
 	bt_hci_send(user->hci_lt, BT_HCI_CMD_LE_SET_SCAN_ENABLE,
 					&lsse, sizeof(lsse), NULL, NULL, NULL);
 
-	tester_test_passed();
+	l_tester_test_passed(tester);
 }
 
 static void test_reset_in_advertising_state(const void *test_data)
 {
-	struct user_data *user = tester_get_data();
+	struct user_data *user = l_tester_get_data(tester);
 
 	bt_hci_send(user->hci_ut, BT_HCI_CMD_RESET, NULL, 0, NULL, NULL, NULL);
 
-	tester_wait(5, test_reset_in_advertising_state_timeout, NULL);
+	l_tester_wait(tester, 5, test_reset_in_advertising_state_timeout, NULL);
 }
 
 int main(int argc, char *argv[])
 {
-	tester_init(&argc, &argv);
+	tester = bttester_init(&argc, &argv);
 
 	test_hci_local("Reset", NULL, NULL, test_reset);
 
@@ -969,5 +964,5 @@ int main(int argc, char *argv[])
 				setup_advertising_initiated,
 				test_reset_in_advertising_state, NULL);
 
-	return tester_run();
+	return bttester_run();
 }
-- 
2.26.3

