Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F34C43600
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 May 2021 02:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0227A613C0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 May 2021 02:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhEFCTf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 May 2021 22:19:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:27114 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231407AbhEFCTe (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 May 2021 22:19:34 -0400
IronPort-SDR: YTyisrhyuAecgFlRADSdY9/I2j2AweTf9mQw4OvHQ5oDi8g8I8mgizsfoANg/qSRAwbaB1HTIn
 CIoBzIUjQmIg==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="259631510"
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="259631510"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 19:18:37 -0700
IronPort-SDR: sat2F5BBxX2k17DkjbZJd4DroLFpxJtld9EjGfWHzzC9eMsT3MWW5FFQaPGTZCJ3t01iqljJdP
 SE4JNE7izefA==
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="469230484"
Received: from zloh1-mobl.gar.corp.intel.com (HELO istotlan-desk.intel.com) ([10.254.6.126])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 19:18:36 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 08/11] tools/l2cap-tester: Convert to use ELL library
Date:   Wed,  5 May 2021 19:18:14 -0700
Message-Id: <20210506021817.289939-9-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210506021817.289939-1-inga.stotland@intel.com>
References: <20210506021817.289939-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This reworks the source code to use ELL primitives and removes
dependencies on GLib.
---
 Makefile.tools       |   4 +-
 tools/l2cap-tester.c | 680 +++++++++++++++++++++----------------------
 2 files changed, 340 insertions(+), 344 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 7b3619f16..aaf4532f7 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -120,12 +120,12 @@ tools_mgmt_tester_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-glib.la $(GLIB_LIBS)
 
 tools_l2cap_tester_SOURCES = tools/l2cap-tester.c monitor/bt.h \
-				emulator/hciemu.h emulator/hciemu.c \
+				emulator/hciemu.h emulator/hciemu-ell.c \
 				emulator/btdev.h emulator/btdev.c \
 				emulator/bthost.h emulator/bthost.c \
 				emulator/smp.c
 tools_l2cap_tester_LDADD = lib/libbluetooth-internal.la \
-				src/libshared-glib.la $(GLIB_LIBS)
+				src/libshared-ell.la $(ell_ldadd)
 
 tools_rfcomm_tester_SOURCES = tools/rfcomm-tester.c monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu.c \
diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 11d549f22..b700f1b4e 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -4,6 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2013  Intel Corporation. All rights reserved.
+
  *
  *
  */
@@ -17,7 +18,7 @@
 #include <errno.h>
 #include <stdbool.h>
 
-#include <glib.h>
+#include <ell/ell.h>
 
 #include "lib/bluetooth.h"
 #include "lib/l2cap.h"
@@ -27,7 +28,7 @@
 #include "emulator/bthost.h"
 #include "emulator/hciemu.h"
 
-#include "src/shared/tester.h"
+#include "src/shared/bttester.h"
 #include "src/shared/mgmt.h"
 
 struct test_data {
@@ -35,8 +36,9 @@ struct test_data {
 	struct mgmt *mgmt;
 	uint16_t mgmt_index;
 	struct hciemu *hciemu;
+	struct l_io *io;
+	struct l_io *io2;
 	enum hciemu_type hciemu_type;
-	unsigned int io_id;
 	uint16_t handle;
 	uint16_t scid;
 	uint16_t dcid;
@@ -85,27 +87,29 @@ struct l2cap_data {
 	bool shut_sock_wr;
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
 
@@ -114,31 +118,31 @@ static void read_info_callback(uint8_t status, uint16_t length,
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
 
@@ -149,10 +153,10 @@ static void index_added_callback(uint16_t index, uint16_t length,
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
@@ -162,19 +166,19 @@ static void index_removed_callback(uint16_t index, uint16_t length,
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
 
@@ -186,28 +190,28 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 
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
 
 	data->mgmt = mgmt_new_default();
 	if (!data->mgmt) {
-		tester_warn("Failed to setup management interface");
-		tester_pre_setup_failed();
+		bttester_warn("Failed to setup management interface");
+		l_tester_pre_setup_failed(tester);
 		return;
 	}
 
-	if (tester_use_debug())
+	if (bttester_use_debug())
 		mgmt_set_debug(data->mgmt, print_debug, "mgmt: ", NULL);
 
 	mgmt_send(data->mgmt, MGMT_OP_READ_INDEX_LIST, MGMT_INDEX_NONE, 0, NULL,
@@ -216,50 +220,46 @@ static void test_pre_setup(const void *test_data)
 
 static void test_post_teardown(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 
-	if (data->io_id > 0) {
-		g_source_remove(data->io_id);
-		data->io_id = 0;
+	if (data->io) {
+		l_io_destroy(data->io);
+		data->io = NULL;
+	}
+
+	if (data->io2) {
+		l_io_destroy(data->io2);
+		data->io2 = NULL;
 	}
 
 	hciemu_unref(data->hciemu);
 	data->hciemu = NULL;
 }
 
-static void test_data_free(void *test_data)
-{
-	struct test_data *data = test_data;
-
-	free(data);
-}
-
 #define test_l2cap_bredr(name, data, setup, func) \
 	do { \
 		struct test_data *user; \
-		user = malloc(sizeof(struct test_data)); \
+		user = l_new(struct test_data, 1);	\
 		if (!user) \
 			break; \
 		user->hciemu_type = HCIEMU_TYPE_BREDR; \
-		user->io_id = 0; \
 		user->test_data = data; \
-		tester_add_full(name, data, \
+		l_tester_add_full(tester, name, data, \
 				test_pre_setup, setup, func, NULL, \
-				test_post_teardown, 2, user, test_data_free); \
+				test_post_teardown, 2, user, l_free); \
 	} while (0)
 
 #define test_l2cap_le(name, data, setup, func) \
 	do { \
 		struct test_data *user; \
-		user = malloc(sizeof(struct test_data)); \
+		user = l_new(struct test_data, 1);	\
 		if (!user) \
 			break; \
 		user->hciemu_type = HCIEMU_TYPE_LE; \
-		user->io_id = 0; \
 		user->test_data = data; \
-		tester_add_full(name, data, \
+		l_tester_add_full(tester, name, data,		   \
 				test_pre_setup, setup, func, NULL, \
-				test_post_teardown, 2, user, test_data_free); \
+				test_post_teardown, 2, user, l_free); \
 	} while (0)
 
 static uint8_t pair_device_pin[] = { 0x30, 0x30, 0x30, 0x30 }; /* "0000" */
@@ -596,7 +596,7 @@ static void client_cmd_complete(uint16_t opcode, uint8_t status,
 					const void *param, uint8_t len,
 					void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct l2cap_data *test = data->test_data;
 	struct bthost *bthost;
 
@@ -605,14 +605,14 @@ static void client_cmd_complete(uint16_t opcode, uint8_t status,
 	switch (opcode) {
 	case BT_HCI_CMD_WRITE_SCAN_ENABLE:
 	case BT_HCI_CMD_LE_SET_ADV_ENABLE:
-		tester_print("Client set connectable status 0x%02x", status);
+		bttester_print("Client set connectable status 0x%02x", status);
 		if (!status && test && test->enable_ssp) {
 			bthost_write_ssp_mode(bthost, 0x01);
 			return;
 		}
 		break;
 	case BT_HCI_CMD_WRITE_SIMPLE_PAIRING_MODE:
-		tester_print("Client enable SSP status 0x%02x", status);
+		bttester_print("Client enable SSP status 0x%02x", status);
 		break;
 	default:
 		return;
@@ -620,9 +620,9 @@ static void client_cmd_complete(uint16_t opcode, uint8_t status,
 
 
 	if (status)
-		tester_setup_failed();
+		l_tester_setup_failed(tester);
 	else
-		tester_setup_complete();
+		l_tester_setup_complete(tester);
 }
 
 static void server_cmd_complete(uint16_t opcode, uint8_t status,
@@ -631,31 +631,31 @@ static void server_cmd_complete(uint16_t opcode, uint8_t status,
 {
 	switch (opcode) {
 	case BT_HCI_CMD_WRITE_SIMPLE_PAIRING_MODE:
-		tester_print("Server enable SSP status 0x%02x", status);
+		bttester_print("Server enable SSP status 0x%02x", status);
 		break;
 	default:
 		return;
 	}
 
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
 	const struct l2cap_data *l2data = data->test_data;
 	struct bthost *bthost;
 
 	if (status != MGMT_STATUS_SUCCESS) {
-		tester_setup_failed();
+		l_tester_setup_failed(tester);
 		return;
 	}
 
-	tester_print("Controller powered on");
+	bttester_print("Controller powered on");
 
 	bthost = hciemu_client_get_host(data->hciemu);
 	bthost_set_cmd_complete_cb(bthost, client_cmd_complete, user_data);
@@ -664,7 +664,7 @@ static void setup_powered_client_callback(uint8_t status, uint16_t length,
 		if (!l2data || !l2data->server_not_advertising)
 			bthost_set_adv_enable(bthost, 0x01);
 		else
-			tester_setup_complete();
+			l_tester_setup_complete(tester);
 	} else {
 		bthost_write_scan_enable(bthost, 0x03);
 	}
@@ -673,19 +673,19 @@ static void setup_powered_client_callback(uint8_t status, uint16_t length,
 static void setup_powered_server_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct l2cap_data *test = data->test_data;
 	struct bthost *bthost;
 
 	if (status != MGMT_STATUS_SUCCESS) {
-		tester_setup_failed();
+		l_tester_setup_failed(tester);
 		return;
 	}
 
-	tester_print("Controller powered on");
+	bttester_print("Controller powered on");
 
 	if (!test->enable_ssp) {
-		tester_setup_complete();
+		l_tester_setup_complete(tester);
 		return;
 	}
 
@@ -699,7 +699,7 @@ static void user_confirm_request_callback(uint16_t index, uint16_t length,
 							void *user_data)
 {
 	const struct mgmt_ev_user_confirm_request *ev = param;
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct l2cap_data *test = data->test_data;
 	struct mgmt_cp_user_confirm_reply cp;
 	uint16_t opcode;
@@ -743,18 +743,18 @@ static void pin_code_request_callback(uint16_t index, uint16_t length,
 
 static void bthost_send_rsp(const void *buf, uint16_t len, void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct l2cap_data *l2data = data->test_data;
 	struct bthost *bthost;
 
 	if (l2data->expect_cmd_len && len != l2data->expect_cmd_len) {
-		tester_test_failed();
+		l_tester_test_failed(tester);
 		return;
 	}
 
 	if (l2data->expect_cmd && memcmp(buf, l2data->expect_cmd,
 						l2data->expect_cmd_len)) {
-		tester_test_failed();
+		l_tester_test_failed(tester);
 		return;
 	}
 
@@ -771,7 +771,7 @@ static void send_rsp_new_conn(uint16_t handle, void *user_data)
 	struct test_data *data = user_data;
 	struct bthost *bthost;
 
-	tester_print("New connection with handle 0x%04x", handle);
+	bttester_print("New connection with handle 0x%04x", handle);
 
 	data->handle = handle;
 
@@ -787,7 +787,7 @@ static void send_rsp_new_conn(uint16_t handle, void *user_data)
 
 static void setup_powered_common(void)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct l2cap_data *test = data->test_data;
 	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
 	unsigned char param[] = { 0x01 };
@@ -824,13 +824,13 @@ static void setup_powered_common(void)
 
 static void setup_powered_client(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct l2cap_data *test = data->test_data;
 	unsigned char param[] = { 0x01 };
 
 	setup_powered_common();
 
-	tester_print("Powering on controller");
+	bttester_print("Powering on controller");
 
 	if (test && (test->expect_cmd || test->send_cmd)) {
 		struct bthost *bthost = hciemu_client_get_host(data->hciemu);
@@ -849,12 +849,12 @@ static void setup_powered_client(const void *test_data)
 
 static void setup_powered_server(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	unsigned char param[] = { 0x01 };
 
 	setup_powered_common();
 
-	tester_print("Powering on controller");
+	bttester_print("Powering on controller");
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_CONNECTABLE, data->mgmt_index,
 				sizeof(param), param, NULL, NULL, NULL);
@@ -875,116 +875,97 @@ static void test_basic(const void *test_data)
 
 	sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
 	if (sk < 0) {
-		tester_warn("Can't create socket: %s (%d)", strerror(errno),
+		bttester_warn("Can't create socket: %s (%d)", strerror(errno),
 									errno);
-		tester_test_failed();
+		l_tester_test_failed(tester);
 		return;
 	}
 
 	close(sk);
 
-	tester_test_passed();
+	l_tester_test_passed(tester);
 }
 
-static gboolean client_received_data(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool client_received_data(struct l_io *io, void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct l2cap_data *l2data = data->test_data;
 	char buf[1024];
 	int sk;
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = l_io_get_fd(io);
 	if (read(sk, buf, l2data->data_len) != l2data->data_len) {
-		tester_warn("Unable to read %u bytes", l2data->data_len);
-		tester_test_failed();
-		return FALSE;
+		bttester_warn("Unable to read %u bytes", l2data->data_len);
+		l_tester_test_failed(tester);
+		return false;
 	}
 
 	if (memcmp(buf, l2data->read_data, l2data->data_len))
-		tester_test_failed();
+		l_tester_test_failed(tester);
 	else
-		tester_test_passed();
+		l_tester_test_passed(tester);
 
-	return FALSE;
+	return true;
 }
 
-static gboolean server_received_data(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool server_received_data(struct l_io *io, void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct l2cap_data *l2data = data->test_data;
 	char buf[1024];
 	int sk;
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = l_io_get_fd(io);
 	if (read(sk, buf, l2data->data_len) != l2data->data_len) {
-		tester_warn("Unable to read %u bytes", l2data->data_len);
-		tester_test_failed();
-		return FALSE;
+		bttester_warn("Unable to read %u bytes", l2data->data_len);
+		l_tester_test_failed(tester);
+
+		l_io_destroy(io);
+		return false;
 	}
 
 	if (memcmp(buf, l2data->read_data, l2data->data_len))
-		tester_test_failed();
+		l_tester_test_failed(tester);
 	else
-		tester_test_passed();
+		l_tester_test_passed(tester);
+
+	l_io_destroy(io);
 
-	return FALSE;
+	return true;
 }
 
 static void bthost_received_data(const void *buf, uint16_t len,
 							void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct l2cap_data *l2data = data->test_data;
 
 	if (len != l2data->data_len) {
-		tester_test_failed();
+		l_tester_test_failed(tester);
 		return;
 	}
 
 	if (memcmp(buf, l2data->write_data, l2data->data_len))
-		tester_test_failed();
+		l_tester_test_failed(tester);
 	else
-		tester_test_passed();
+		l_tester_test_passed(tester);
 }
 
 static void server_bthost_received_data(const void *buf, uint16_t len,
 							void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct l2cap_data *l2data = data->test_data;
 
 	if (len != l2data->data_len) {
-		tester_test_failed();
+		l_tester_test_failed(tester);
 		return;
 	}
 
 	if (memcmp(buf, l2data->write_data, l2data->data_len))
-		tester_test_failed();
+		l_tester_test_failed(tester);
 	else
-		tester_test_passed();
-}
-
-static gboolean socket_closed_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
-{
-	struct test_data *data = tester_get_data();
-	const struct l2cap_data *l2data = data->test_data;
-
-	if (l2data->shut_sock_wr) {
-		/* if socket is closed using SHUT_WR, L2CAP disconnection
-		 * response must be received first before G_IO_HUP event.
-		 */
-		if (data->host_disconnected)
-			tester_test_passed();
-		else {
-			tester_warn("G_IO_HUP received before receiving L2CAP disconnection");
-			tester_test_failed();
-		}
-	}
-
-	return FALSE;
+		l_tester_test_passed(tester);
 }
 
 static bool check_mtu(struct test_data *data, int sk)
@@ -1003,16 +984,16 @@ static bool check_mtu(struct test_data *data, int sk)
 		len = sizeof(l2o.imtu);
 		if (getsockopt(sk, SOL_BLUETOOTH, BT_RCVMTU,
 							&l2o.imtu, &len) < 0) {
-			tester_warn("getsockopt(BT_RCVMTU): %s (%d)",
-					strerror(errno), errno);
+			bttester_warn("getsockopt(BT_RCVMTU): %s (%d)",
+							strerror(errno), errno);
 			return false;
 		}
 
 		len = sizeof(l2o.omtu);
 		if (getsockopt(sk, SOL_BLUETOOTH, BT_SNDMTU,
 							&l2o.omtu, &len) < 0) {
-			tester_warn("getsockopt(BT_SNDMTU): %s (%d)",
-					strerror(errno), errno);
+			bttester_warn("getsockopt(BT_SNDMTU): %s (%d)",
+							strerror(errno), errno);
 			return false;
 		}
 	} else {
@@ -1020,26 +1001,61 @@ static bool check_mtu(struct test_data *data, int sk)
 		 * L2CAP_OPTIONS, so test support for it as well */
 		len = sizeof(l2o);
 		if (getsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &l2o, &len) < 0) {
-			 tester_warn("getsockopt(L2CAP_OPTIONS): %s (%d)",
-						strerror(errno), errno);
-			 return false;
+			bttester_warn("getsockopt(L2CAP_OPTIONS): %s (%d)",
+							strerror(errno), errno);
+			return false;
 		 }
 	}
 
 	return true;
 }
 
-static gboolean l2cap_connect_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static void l2cap_disconnect_cb(struct l_io *io, void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct l2cap_data *l2data = data->test_data;
 	int err, sk_err, sk;
 	socklen_t len = sizeof(sk_err);
 
-	data->io_id = 0;
+	bttester_print("Disconnect callback");
+	if (l2data->shut_sock_wr) {
+		/* if socket is closed using SHUT_WR, L2CAP disconnection
+		 * response must be received first before EPOLLHUP event.
+		 */
+		if (data->host_disconnected)
+			l_tester_test_passed(tester);
+		else {
+			bttester_warn("HUP received before L2CAP disconnect");
+			l_tester_test_failed(tester);
+		}
+
+		return;
+	}
+
+	sk = l_io_get_fd(io);
+
+	if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &sk_err, &len) < 0)
+		err = -errno;
+	else
+		err = -sk_err;
+
+	if (l2data->expect_err) {
+
+		if (-err == l2data->expect_err)
+			l_tester_test_passed(tester);
+		else
+			l_tester_test_failed(tester);
+	}
+}
+
+static bool l2cap_connect_cb(struct l_io *io, void *user_data)
+{
+	struct test_data *data = l_tester_get_data(tester);
+	const struct l2cap_data *l2data = data->test_data;
+	int err, sk_err, sk;
+	socklen_t len = sizeof(sk_err);
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = l_io_get_fd(io);
 
 	if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &sk_err, &len) < 0)
 		err = -errno;
@@ -1047,27 +1063,27 @@ static gboolean l2cap_connect_cb(GIOChannel *io, GIOCondition cond,
 		err = -sk_err;
 
 	if (err < 0) {
-		tester_warn("Connect failed: %s (%d)", strerror(-err), -err);
+		bttester_warn("Connect failed: %s (%d)", strerror(-err), -err);
 		goto failed;
 	}
 
-	tester_print("Successfully connected");
+	bttester_print("Successfully connected");
 
 	if (!check_mtu(data, sk)) {
-		tester_test_failed();
-		return FALSE;
+		l_tester_test_failed(tester);
+		return false;
 	}
 
 	if (l2data->read_data) {
 		struct bthost *bthost;
 
 		bthost = hciemu_client_get_host(data->hciemu);
-		g_io_add_watch(io, G_IO_IN, client_received_data, NULL);
+		l_io_set_read_handler(io, client_received_data, NULL, NULL);
 
 		bthost_send_cid(bthost, data->handle, data->dcid,
 					l2data->read_data, l2data->data_len);
 
-		return FALSE;
+		return false;
 	} else if (l2data->write_data) {
 		struct bthost *bthost;
 		ssize_t ret;
@@ -1078,25 +1094,24 @@ static gboolean l2cap_connect_cb(GIOChannel *io, GIOCondition cond,
 
 		ret = write(sk, l2data->write_data, l2data->data_len);
 		if (ret != l2data->data_len) {
-			tester_warn("Unable to write all data");
-			tester_test_failed();
+			bttester_warn("Unable to write all data");
+			l_tester_test_failed(tester);
 		}
 
-		return FALSE;
+		return false;
 	} else if (l2data->shut_sock_wr) {
-		g_io_add_watch(io, G_IO_HUP, socket_closed_cb, NULL);
 		shutdown(sk, SHUT_WR);
 
-		return FALSE;
+		return false;
 	}
 
 failed:
 	if (-err != l2data->expect_err)
-		tester_test_failed();
+		l_tester_test_failed(tester);
 	else
-		tester_test_passed();
+		l_tester_test_passed(tester);
 
-	return FALSE;
+	return false;
 }
 
 static int create_l2cap_sock(struct test_data *data, uint16_t psm,
@@ -1111,14 +1126,14 @@ static int create_l2cap_sock(struct test_data *data, uint16_t psm,
 							BTPROTO_L2CAP);
 	if (sk < 0) {
 		err = -errno;
-		tester_warn("Can't create socket: %s (%d)", strerror(errno),
+		bttester_warn("Can't create socket: %s (%d)", strerror(errno),
 									errno);
 		return err;
 	}
 
 	master_bdaddr = hciemu_get_master_bdaddr(data->hciemu);
 	if (!master_bdaddr) {
-		tester_warn("No master bdaddr");
+		bttester_warn("No master bdaddr");
 		close(sk);
 		return -ENODEV;
 	}
@@ -1138,7 +1153,7 @@ static int create_l2cap_sock(struct test_data *data, uint16_t psm,
 
 	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
 		err = -errno;
-		tester_warn("Can't bind socket: %s (%d)", strerror(errno),
+		bttester_warn("Can't bind socket: %s (%d)", strerror(errno),
 									errno);
 		close(sk);
 		return err;
@@ -1153,8 +1168,8 @@ static int create_l2cap_sock(struct test_data *data, uint16_t psm,
 		if (setsockopt(sk, SOL_BLUETOOTH, BT_SECURITY, &sec,
 							sizeof(sec)) < 0) {
 			err = -errno;
-			tester_warn("Can't set security level: %s (%d)",
-						strerror(errno), errno);
+			bttester_warn("Can't set security level: %s (%d)",
+							strerror(errno), errno);
 			close(sk);
 			return err;
 		}
@@ -1164,8 +1179,8 @@ static int create_l2cap_sock(struct test_data *data, uint16_t psm,
 		if (setsockopt(sk, SOL_BLUETOOTH, BT_MODE, &mode,
 							sizeof(mode)) < 0) {
 			err = -errno;
-			tester_warn("Can't set mode: %s (%d)", strerror(errno),
-									errno);
+			bttester_warn("Can't set mode: %s (%d)",
+							strerror(errno), errno);
 			close(sk);
 			return err;
 		}
@@ -1181,7 +1196,7 @@ static int connect_l2cap_impl(int sk, const uint8_t *bdaddr,
 	int err;
 
 	if (!bdaddr) {
-		tester_warn("No client bdaddr");
+		bttester_warn("No client bdaddr");
 		return -ENODEV;
 	}
 
@@ -1195,7 +1210,7 @@ static int connect_l2cap_impl(int sk, const uint8_t *bdaddr,
 	err = connect(sk, (struct sockaddr *) &addr, sizeof(addr));
 	if (err < 0 && !(errno == EAGAIN || errno == EINPROGRESS)) {
 		err = -errno;
-		tester_warn("Can't connect socket: %s (%d)", strerror(errno),
+		bttester_warn("Can't connect socket: %s (%d)", strerror(errno),
 									errno);
 		return err;
 	}
@@ -1216,7 +1231,7 @@ static int connect_l2cap_sock(struct test_data *data, int sk, uint16_t psm,
 		client_bdaddr = hciemu_get_client_bdaddr(data->hciemu);
 
 	if (!client_bdaddr) {
-		tester_warn("No client bdaddr");
+		bttester_warn("No client bdaddr");
 		return -ENODEV;
 	}
 
@@ -1249,39 +1264,38 @@ static void client_l2cap_disconnect_cb(void *user_data)
 static void direct_adv_cmd_complete(uint16_t opcode, const void *param,
 						uint8_t len, void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct bt_hci_cmd_le_set_adv_parameters *cp;
 	const uint8_t *expect_bdaddr;
 
 	if (opcode != BT_HCI_CMD_LE_SET_ADV_PARAMETERS)
 		return;
 
-	tester_print("Received advertising parameters HCI command");
+	bttester_print("Received advertising parameters HCI command");
 
 	cp = param;
 
 	/* Advertising as client should be direct advertising */
 	if (cp->type != 0x01) {
-		tester_warn("Invalid advertising type");
-		tester_test_failed();
+		bttester_warn("Invalid advertising type");
+		l_tester_test_failed(tester);
 		return;
 	}
 
 	expect_bdaddr = hciemu_get_client_bdaddr(data->hciemu);
 	if (memcmp(expect_bdaddr, cp->direct_addr, 6)) {
-		tester_warn("Invalid direct address in adv params");
-		tester_test_failed();
+		bttester_warn("Invalid direct address in adv params");
+		l_tester_test_failed(tester);
 		return;
 	}
 
-	tester_test_passed();
+	l_tester_test_passed(tester);
 }
 
 static void test_connect(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct l2cap_data *l2data = data->test_data;
-	GIOChannel *io;
 	int sk;
 
 	if (l2data->server_psm) {
@@ -1308,68 +1322,68 @@ static void test_connect(const void *test_data)
 							l2data->mode);
 	if (sk < 0) {
 		if (sk == -ENOPROTOOPT)
-			tester_test_abort();
+			l_tester_test_abort(tester);
 		else
-			tester_test_failed();
+			l_tester_test_failed(tester);
 		return;
 	}
 
 	if (connect_l2cap_sock(data, sk, l2data->client_psm,
 							l2data->cid) < 0) {
 		close(sk);
-		tester_test_failed();
+		l_tester_test_failed(tester);
 		return;
 	}
 
-	io = g_io_channel_unix_new(sk);
-	g_io_channel_set_close_on_unref(io, TRUE);
+	data->io = l_io_new(sk);
 
-	data->io_id = g_io_add_watch(io, G_IO_OUT, l2cap_connect_cb, NULL);
+	l_io_set_close_on_destroy(data->io, true);
 
-	g_io_channel_unref(io);
+	l_io_set_disconnect_handler(data->io, l2cap_disconnect_cb, NULL, NULL);
+	l_io_set_write_handler(data->io, l2cap_connect_cb, NULL, NULL);
 
-	tester_print("Connect in progress");
+	bttester_print("Connect in progress");
 }
 
 static void test_connect_reject(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct l2cap_data *l2data = data->test_data;
 	int sk;
 
 	sk = create_l2cap_sock(data, 0, l2data->cid, l2data->sec_level,
 							l2data->mode);
 	if (sk < 0) {
-		tester_test_failed();
+		l_tester_test_failed(tester);
 		return;
 	}
 
 	if (connect_l2cap_sock(data, sk, l2data->client_psm,
 							l2data->cid) < 0)
-		tester_test_passed();
+		l_tester_test_passed(tester);
 	else
-		tester_test_failed();
+		l_tester_test_failed(tester);
 
 	close(sk);
 }
 
-static int connect_socket(const uint8_t *client_bdaddr, GIOFunc connect_cb,
-								bool defer)
+static struct l_io *connect_socket(const uint8_t *client_bdaddr,
+					l_io_write_cb_t connect_cb, bool defer)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct l2cap_data *l2data = data->test_data;
-	GIOChannel *io;
+	struct l_io *io;
 	int sk;
 
 	sk = create_l2cap_sock(data, 0, l2data->cid, l2data->sec_level,
 							l2data->mode);
 	if (sk < 0) {
-		tester_print("Error in create_l2cap_sock");
+		bttester_print("Error in create_l2cap_sock");
 		if (sk == -ENOPROTOOPT)
-			tester_test_abort();
+			l_tester_test_abort(tester);
 		else
-			tester_test_failed();
-		return -1;
+			l_tester_test_failed(tester);
+		return NULL;
 	}
 
 	if (defer) {
@@ -1377,112 +1391,104 @@ static int connect_socket(const uint8_t *client_bdaddr, GIOFunc connect_cb,
 
 		if (setsockopt(sk, SOL_BLUETOOTH, BT_DEFER_SETUP, &opt,
 							sizeof(opt)) < 0) {
-			tester_print("Can't enable deferred setup: %s (%d)",
+			bttester_print("Can't enable deferred setup: %s (%d)",
 						strerror(errno), errno);
-			tester_test_failed();
-			return -1;
+			l_tester_test_failed(tester);
+			return NULL;
 		}
 	}
 
 	if (connect_l2cap_impl(sk, client_bdaddr, BDADDR_LE_PUBLIC,
 			l2data->client_psm, l2data->cid) < 0) {
-		tester_print("Error in connect_l2cap_sock");
+		bttester_print("Error in connect_l2cap_sock");
 		close(sk);
-		tester_test_failed();
-		return -1;
+		l_tester_test_failed(tester);
+		return NULL;
 	}
 
-	if (connect_cb) {
-		io = g_io_channel_unix_new(sk);
-		g_io_channel_set_close_on_unref(io, TRUE);
-
-		data->io_id = g_io_add_watch(io, G_IO_OUT, connect_cb, NULL);
+	io = l_io_new(sk);
+	l_io_set_close_on_destroy(io, true);
+	l_io_set_write_handler(io, connect_cb, NULL, NULL);
 
-		g_io_channel_unref(io);
-	}
+	bttester_print("Connect in progress, sk = %d %s", sk,
+						defer ? "(deferred)" : "");
 
-	tester_print("Connect in progress, sk = %d %s", sk,
-				defer ? "(deferred)" : "");
-
-	return sk;
+	return io;
 }
 
-static gboolean test_close_socket_1_part_3(gpointer arg)
+static void test_close_socket_1_part_3(void *arg)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 
-	tester_print("Checking whether scan was properly stopped...");
+	bttester_print("Checking whether scan was properly stopped...");
 
 	if (data->sk != -1) {
-		tester_print("Error - scan was not enabled yet");
-		tester_test_failed();
-		return FALSE;
+		bttester_print("Error - scan was not enabled yet");
+		l_tester_test_failed(tester);
+		return;
 	}
 
 	if (hciemu_get_master_le_scan_enable(data->hciemu)) {
-		tester_print("Delayed check whether scann is off failed");
-		tester_test_failed();
-		return FALSE;
+		bttester_print("Delayed check whether scann is off failed");
+		l_tester_test_failed(tester);
+		return;
 	}
 
-	tester_test_passed();
-	return FALSE;
+	l_tester_test_passed(tester);
 }
 
-static gboolean test_close_socket_1_part_2(gpointer args)
+static void test_close_socket_1_part_2(void *args)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	int sk = data->sk;
 
-	tester_print("Will close socket during scan phase...");
+	bttester_print("Will close socket during scan phase...");
 
 	/* We tried to conect to LE device that is not advertising. It
 	 * was added to kernel whitelist, and scan was started. We
 	 * should be still scanning.
 	 */
 	if (!hciemu_get_master_le_scan_enable(data->hciemu)) {
-		tester_print("Error - should be still scanning");
-		tester_test_failed();
-		return FALSE;
+		bttester_print("Error - should be still scanning");
+		l_tester_test_failed(tester);
+		return;
 	}
 
 	/* Calling close() should remove device from  whitelist, and stop
 	 * the scan.
 	 */
 	if (close(sk) < 0) {
-		tester_print("Error when closing socket");
-		tester_test_failed();
-		return FALSE;
+		bttester_print("Error when closing socket");
+		l_tester_test_failed(tester);
+		return;
 	}
 
 	data->sk = -1;
 	/* tester_test_passed will be called when scan is stopped. */
-	return FALSE;
 }
 
-static gboolean test_close_socket_2_part_3(gpointer arg)
+static void test_close_socket_2_part_3(void *arg)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	int sk = data->sk;
 	int err;
 
 	/* Scan should be already over, we're trying to create connection */
 	if (hciemu_get_master_le_scan_enable(data->hciemu)) {
-		tester_print("Error - should no longer scan");
-		tester_test_failed();
-		return FALSE;
+		bttester_print("Error - should no longer scan");
+		l_tester_test_failed(tester);
+		return;
 	}
 
 	/* Calling close() should eventually cause CMD_LE_CREATE_CONN_CANCEL */
 	err = close(sk);
 	if (err < 0) {
-		tester_print("Error when closing socket");
-		tester_test_failed();
-		return FALSE;
+		bttester_print("Error when closing socket");
+		l_tester_test_failed(tester);
+		return;
 	}
 
 	/* CMD_LE_CREATE_CONN_CANCEL will trigger test pass. */
-	return FALSE;
 }
 
 static bool test_close_socket_cc_hook(const void *data, uint16_t len,
@@ -1491,9 +1497,9 @@ static bool test_close_socket_cc_hook(const void *data, uint16_t len,
 	return false;
 }
 
-static gboolean test_close_socket_2_part_2(gpointer arg)
+static void test_close_socket_2_part_2(void *arg)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
 
 	/* Make sure CMD_LE_CREATE_CONN will not immediately result in
@@ -1507,44 +1513,43 @@ static gboolean test_close_socket_2_part_2(gpointer arg)
 	 */
 	bthost_set_adv_enable(bthost, 0x01);
 	bthost_set_adv_enable(bthost, 0x00);
-	return FALSE;
 }
 
 static void test_close_socket_scan_enabled(void)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct l2cap_data *l2data = data->test_data;
 
 	if (l2data == &le_client_close_socket_test_1)
-		g_idle_add(test_close_socket_1_part_2, NULL);
+		l_idle_oneshot(test_close_socket_1_part_2, NULL, NULL);
 	else if (l2data == &le_client_close_socket_test_2)
-		g_idle_add(test_close_socket_2_part_2, NULL);
+		l_idle_oneshot(test_close_socket_2_part_2, NULL, NULL);
 }
 
 static void test_close_socket_scan_disabled(void)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct l2cap_data *l2data = data->test_data;
 
 	if (l2data == &le_client_close_socket_test_1)
-		g_idle_add(test_close_socket_1_part_3, NULL);
+		l_idle_oneshot(test_close_socket_1_part_3, NULL, NULL);
 	else if (l2data == &le_client_close_socket_test_2)
-		g_idle_add(test_close_socket_2_part_3, NULL);
+		l_idle_oneshot(test_close_socket_2_part_3, NULL, NULL);
 }
 
 static void test_close_socket_conn_cancel(void)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct l2cap_data *l2data = data->test_data;
 
 	if (l2data == &le_client_close_socket_test_2)
-		tester_test_passed();
+		l_tester_test_passed(tester);
 }
 
 static void test_close_socket_router(uint16_t opcode, const void *param,
 					uint8_t length, void *user_data)
 {
-	/* tester_print("HCI Command 0x%04x length %u", opcode, length); */
+	/* bttester_print("HCI Command 0x%04x length %u", opcode, length); */
 	if (opcode == BT_HCI_CMD_LE_SET_SCAN_ENABLE) {
 		const struct bt_hci_cmd_le_set_scan_enable *scan_params = param;
 
@@ -1559,7 +1564,7 @@ static void test_close_socket_router(uint16_t opcode, const void *param,
 
 static void test_close_socket(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct l2cap_data *l2data = data->test_data;
 	const uint8_t *client_bdaddr;
 
@@ -1571,21 +1576,19 @@ static void test_close_socket(const void *test_data)
 	else
 		client_bdaddr = hciemu_get_client_bdaddr(data->hciemu);
 
-	data->sk = connect_socket(client_bdaddr, NULL, false);
+	data->io = connect_socket(client_bdaddr, NULL, false);
+	data->sk = l_io_get_fd(data->io);
 }
 
 static uint8_t test_2_connect_cb_cnt;
-static gboolean test_2_connect_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool test_2_connect_cb(struct l_io *io, void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct l2cap_data *l2data = data->test_data;
 	int err, sk_err, sk;
 	socklen_t len = sizeof(sk_err);
 
-	data->io_id = 0;
-
-	sk = g_io_channel_unix_get_fd(io);
+	sk = l_io_get_fd(io);
 
 	if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &sk_err, &len) < 0)
 		err = -errno;
@@ -1593,52 +1596,52 @@ static gboolean test_2_connect_cb(GIOChannel *io, GIOCondition cond,
 		err = -sk_err;
 
 	if (err < 0) {
-		tester_warn("Connect failed: %s (%d)", strerror(-err), -err);
-		tester_test_failed();
-		return FALSE;
+		bttester_warn("Connect failed: %s (%d)", strerror(-err), -err);
+		l_tester_test_failed(tester);
+		return false;
 	}
 
-	tester_print("Successfully connected");
+	bttester_print("Successfully connected");
 	test_2_connect_cb_cnt++;
 
 	if (test_2_connect_cb_cnt == 2) {
 		close(data->sk);
 		close(data->sk2);
-		tester_test_passed();
+		l_tester_test_passed(tester);
 	}
 
 	if (l2data->close_1 && test_2_connect_cb_cnt == 1) {
 		close(data->sk2);
-		tester_test_passed();
+		l_tester_test_passed(tester);
 	}
 
-	return FALSE;
+	return false;
 }
 
-static gboolean enable_advertising(gpointer args)
+static void enable_advertising(void *args)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
 
 	bthost_set_adv_enable(bthost, 0x01);
-	return FALSE;
 }
 
 static void test_connect_2_part_2(void)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct l2cap_data *l2data = data->test_data;
 	const uint8_t *client_bdaddr;
 
 	client_bdaddr = hciemu_get_client_bdaddr(data->hciemu);
-	data->sk2 = connect_socket(client_bdaddr, test_2_connect_cb, false);
+	data->io2 = connect_socket(client_bdaddr, test_2_connect_cb, false);
+	data->sk2 = l_io_get_fd(data->io2);
 
 	if (l2data->close_1) {
-		tester_print("Closing first socket! %d", data->sk);
+		bttester_print("Closing first socket! %d", data->sk);
 		close(data->sk);
 	}
 
-	g_idle_add(enable_advertising, NULL);
+	l_idle_oneshot(enable_advertising, NULL, NULL);
 }
 
 static uint8_t test_scan_enable_counter;
@@ -1647,20 +1650,20 @@ static void test_connect_2_router(uint16_t opcode, const void *param,
 {
 	const struct bt_hci_cmd_le_set_scan_enable *scan_params = param;
 
-	tester_print("HCI Command 0x%04x length %u", opcode, length);
+	bttester_print("HCI Command 0x%04x length %u", opcode, length);
 	if (opcode == BT_HCI_CMD_LE_SET_SCAN_ENABLE &&
 						scan_params->enable == true) {
 		test_scan_enable_counter++;
 		if (test_scan_enable_counter == 1)
 			test_connect_2_part_2();
 		else if (test_scan_enable_counter == 2)
-			g_idle_add(enable_advertising, NULL);
+			l_idle_oneshot(enable_advertising, NULL, NULL);
 	}
 }
 
 static void test_connect_2(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct l2cap_data *l2data = data->test_data;
 	const uint8_t *client_bdaddr;
 	bool defer;
@@ -1683,50 +1686,47 @@ static void test_connect_2(const void *test_data)
 
 	client_bdaddr = hciemu_get_client_bdaddr(data->hciemu);
 	if (l2data->close_1)
-		data->sk = connect_socket(client_bdaddr, NULL, defer);
+		data->io = connect_socket(client_bdaddr, NULL, defer);
 	else
-		data->sk = connect_socket(client_bdaddr, test_2_connect_cb,
+		data->io = connect_socket(client_bdaddr, test_2_connect_cb,
 								defer);
+
+	data->sk = l_io_get_fd(data->io);
 }
 
-static gboolean l2cap_listen_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool l2cap_listen_cb(struct l_io *io, void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct l2cap_data *l2data = data->test_data;
 	int sk, new_sk;
 
-	data->io_id = 0;
-
-	sk = g_io_channel_unix_get_fd(io);
+	sk = l_io_get_fd(io);
 
 	new_sk = accept(sk, NULL, NULL);
 	if (new_sk < 0) {
-		tester_warn("accept failed: %s (%u)", strerror(errno), errno);
-		tester_test_failed();
-		return FALSE;
+		bttester_warn("accept failed: %s (%u)", strerror(errno), errno);
+		l_tester_test_failed(tester);
+		return false;
 	}
 
 	if (!check_mtu(data, new_sk)) {
-		tester_test_failed();
-		return FALSE;
+		l_tester_test_failed(tester);
+		return false;
 	}
 
 	if (l2data->read_data) {
 		struct bthost *bthost;
-		GIOChannel *new_io;
+		struct l_io *new_io;
 
-		new_io = g_io_channel_unix_new(new_sk);
-		g_io_channel_set_close_on_unref(new_io, TRUE);
+		new_io = l_io_new(new_sk);
+		l_io_set_close_on_destroy(new_io, true);
 
 		bthost = hciemu_client_get_host(data->hciemu);
-		g_io_add_watch(new_io, G_IO_IN, server_received_data, NULL);
+		l_io_set_read_handler(new_io, server_received_data, NULL, NULL);
 		bthost_send_cid(bthost, data->handle, data->dcid,
 					l2data->read_data, l2data->data_len);
 
-		g_io_channel_unref(new_io);
-
-		return FALSE;
+		return false;
 	} else if (l2data->write_data) {
 		struct bthost *bthost;
 		ssize_t ret;
@@ -1739,20 +1739,20 @@ static gboolean l2cap_listen_cb(GIOChannel *io, GIOCondition cond,
 		close(new_sk);
 
 		if (ret != l2data->data_len) {
-			tester_warn("Unable to write all data");
-			tester_test_failed();
+			bttester_warn("Unable to write all data");
+			l_tester_test_failed(tester);
 		}
 
-		return FALSE;
+		return false;
 	}
 
-	tester_print("Successfully connected");
+	bttester_print("Successfully connected");
 
 	close(new_sk);
 
-	tester_test_passed();
+	l_tester_test_passed(tester);
 
-	return FALSE;
+	return false;
 }
 
 static void client_l2cap_rsp(uint8_t code, const void *data, uint16_t len,
@@ -1761,10 +1761,10 @@ static void client_l2cap_rsp(uint8_t code, const void *data, uint16_t len,
 	struct test_data *test_data = user_data;
 	const struct l2cap_data *l2data = test_data->test_data;
 
-	tester_print("Client received response code 0x%02x", code);
+	bttester_print("Client received response code 0x%02x", code);
 
 	if (code != l2data->expect_cmd_code) {
-		tester_warn("Unexpected L2CAP response code (expected 0x%02x)",
+		bttester_warn("Unexpected L2CAP response code (expect 0x%02x)",
 						l2data->expect_cmd_code);
 		return;
 	}
@@ -1783,26 +1783,26 @@ static void client_l2cap_rsp(uint8_t code, const void *data, uint16_t len,
 	}
 
 	if (!l2data->expect_cmd) {
-		tester_test_passed();
+		l_tester_test_passed(tester);
 		return;
 	}
 
 	if (l2data->expect_cmd_len != len) {
-		tester_warn("Unexpected L2CAP response length (%u != %u)",
+		bttester_warn("Unexpected L2CAP response length (%u != %u)",
 						len, l2data->expect_cmd_len);
 		goto failed;
 	}
 
 	if (memcmp(l2data->expect_cmd, data, len) != 0) {
-		tester_warn("Unexpected L2CAP response");
+		bttester_warn("Unexpected L2CAP response");
 		goto failed;
 	}
 
-	tester_test_passed();
+	l_tester_test_passed(tester);
 	return;
 
 failed:
-	tester_test_failed();
+	l_tester_test_failed(tester);
 }
 
 static void send_req_new_conn(uint16_t handle, void *user_data)
@@ -1811,7 +1811,7 @@ static void send_req_new_conn(uint16_t handle, void *user_data)
 	const struct l2cap_data *l2data = data->test_data;
 	struct bthost *bthost;
 
-	tester_print("New client connection with handle 0x%04x", handle);
+	bttester_print("New client connection with handle 0x%04x", handle);
 
 	data->handle = handle;
 
@@ -1823,7 +1823,7 @@ static void send_req_new_conn(uint16_t handle, void *user_data)
 		else
 			cb = NULL;
 
-		tester_print("Sending L2CAP Request from client");
+		bttester_print("Sending L2CAP Request from client");
 
 		bthost = hciemu_client_get_host(data->hciemu);
 		bthost_l2cap_req(bthost, handle, l2data->send_cmd_code,
@@ -1834,12 +1834,11 @@ static void send_req_new_conn(uint16_t handle, void *user_data)
 
 static void test_server(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct l2cap_data *l2data = data->test_data;
 	const uint8_t *master_bdaddr;
 	uint8_t addr_type;
 	struct bthost *bthost;
-	GIOChannel *io;
 	int sk;
 
 	if (l2data->server_psm || l2data->cid) {
@@ -1847,32 +1846,29 @@ static void test_server(const void *test_data)
 					l2data->cid, l2data->sec_level,
 					l2data->mode);
 		if (sk < 0) {
-			tester_test_failed();
+			l_tester_test_failed(tester);
 			return;
 		}
 
 		if (listen(sk, 5) < 0) {
-			tester_warn("listening on socket failed: %s (%u)",
-					strerror(errno), errno);
-			tester_test_failed();
+			bttester_warn("listening on socket failed: %s (%u)",
+							strerror(errno), errno);
+			l_tester_test_failed(tester);
 			close(sk);
 			return;
 		}
 
-		io = g_io_channel_unix_new(sk);
-		g_io_channel_set_close_on_unref(io, TRUE);
-
-		data->io_id = g_io_add_watch(io, G_IO_IN, l2cap_listen_cb,
-									NULL);
-		g_io_channel_unref(io);
+		data->io = l_io_new(sk);
+		l_io_set_close_on_destroy(data->io, true);
+		l_io_set_read_handler(data->io, l2cap_listen_cb, NULL, NULL);
 
-		tester_print("Listening for connections");
+		bttester_print("Listening for connections");
 	}
 
 	master_bdaddr = hciemu_get_master_bdaddr(data->hciemu);
 	if (!master_bdaddr) {
-		tester_warn("No master bdaddr");
-		tester_test_failed();
+		bttester_warn("No master bdaddr");
+		l_tester_test_failed(tester);
 		return;
 	}
 
@@ -1889,32 +1885,32 @@ static void test_server(const void *test_data)
 
 static void test_getpeername_not_connected(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	struct sockaddr_l2 addr;
 	socklen_t len;
 	int sk;
 
 	sk = create_l2cap_sock(data, 0, 0, 0, 0);
 	if (sk < 0) {
-		tester_test_failed();
+		l_tester_test_failed(tester);
 		return;
 	}
 
 	len = sizeof(addr);
 	if (getpeername(sk, (struct sockaddr *) &addr, &len) == 0) {
-		tester_warn("getpeername succeeded on non-connected socket");
-		tester_test_failed();
+		bttester_warn("getpeername succeeded on non-connected socket");
+		l_tester_test_failed(tester);
 		goto done;
 	}
 
 	if (errno != ENOTCONN) {
-		tester_warn("Unexpexted getpeername error: %s (%d)",
+		bttester_warn("Unexpected getpeername error: %s (%d)",
 						strerror(errno), errno);
-		tester_test_failed();
+		l_tester_test_failed(tester);
 		goto done;
 	}
 
-	tester_test_passed();
+	l_tester_test_passed(tester);
 
 done:
 	close(sk);
@@ -1922,7 +1918,7 @@ done:
 
 int main(int argc, char *argv[])
 {
-	tester_init(&argc, &argv);
+	tester = bttester_init(&argc, &argv);
 
 	test_l2cap_bredr("Basic L2CAP Socket - Success", NULL,
 					setup_powered_client, test_basic);
@@ -2072,5 +2068,5 @@ int main(int argc, char *argv[])
 				&le_att_server_success_test_1,
 				setup_powered_server, test_server);
 
-	return tester_run();
+	return bttester_run();
 }
-- 
2.26.3

