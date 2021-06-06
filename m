Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D9DC47096
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Jun 2021 06:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18E0461107
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Jun 2021 06:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhFFGjX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Jun 2021 02:39:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:34607 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230139AbhFFGjW (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Jun 2021 02:39:22 -0400
IronPort-SDR: SV7Q6LTQUI5Pc/OudLVrKhd1N5OcHKQ68F9qc3eYf2BMvSYgR5MDF9oCQ7O4MY3M0v9HTjoGhd
 B1HQZmMCofVQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10006"; a="191815322"
X-IronPort-AV: E=Sophos;i="5.83,252,1616482800"; 
   d="scan'208";a="191815322"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2021 23:37:33 -0700
IronPort-SDR: ALQlG23N6DFLJBYKvdra0YoflRFBxXzPCKL6CsUrhQ/DJHYQT1N5StcUdPBVfBh5fi71VcmRqb
 LxSDHBlpofvg==
X-IronPort-AV: E=Sophos;i="5.83,252,1616482800"; 
   d="scan'208";a="481160913"
Received: from skambhat-mobl.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.209.68.161])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2021 23:37:32 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, tedd.an@intel.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 09/11] tools/mgmt-tester: Convert to use ELL library
Date:   Sat,  5 Jun 2021 23:37:17 -0700
Message-Id: <20210606063719.339794-10-inga.stotland@intel.com>
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
 Makefile.tools      |   4 +-
 tools/mgmt-tester.c | 772 ++++++++++++++++++++++----------------------
 2 files changed, 394 insertions(+), 382 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index aaf4532f7..3cb3c6e0e 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -112,12 +112,12 @@ tools_3dsp_SOURCES = tools/3dsp.c monitor/bt.h
 tools_3dsp_LDADD = src/libshared-mainloop.la
 
 tools_mgmt_tester_SOURCES = tools/mgmt-tester.c monitor/bt.h \
-				emulator/hciemu.h emulator/hciemu.c \
+				emulator/hciemu.h emulator/hciemu-ell.c \
 				emulator/btdev.h emulator/btdev.c \
 				emulator/bthost.h emulator/bthost.c \
 				emulator/smp.c
 tools_mgmt_tester_LDADD = lib/libbluetooth-internal.la \
-				src/libshared-glib.la $(GLIB_LIBS)
+				src/libshared-ell.la $(ell_ldadd)
 
 tools_l2cap_tester_SOURCES = tools/l2cap-tester.c monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu-ell.c \
diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 6109883ad..9151bd8de 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -18,7 +18,7 @@
 #include <errno.h>
 #include <unistd.h>
 
-#include <glib.h>
+#include <ell/ell.h>
 
 #include "lib/bluetooth.h"
 #include "lib/hci.h"
@@ -31,11 +31,11 @@
 #include "emulator/hciemu.h"
 
 #include "src/shared/util.h"
-#include "src/shared/tester.h"
+#include "src/shared/bttester.h"
 #include "src/shared/mgmt.h"
 
 struct test_data {
-	tester_data_func_t test_setup;
+	l_tester_data_func_t test_setup;
 	const void *test_data;
 	uint8_t expected_version;
 	uint16_t expected_manufacturer;
@@ -58,16 +58,76 @@ struct test_data {
 	int sk;
 };
 
+struct generic_data {
+	bool setup_le_states;
+	const uint8_t *le_states;
+	const uint16_t *setup_settings;
+	bool setup_nobredr;
+	bool setup_limited_discov;
+	uint16_t setup_expect_hci_command;
+	const void *setup_expect_hci_param;
+	uint8_t setup_expect_hci_len;
+	uint16_t setup_send_opcode;
+	const void *setup_send_param;
+	uint16_t setup_send_len;
+	const struct setup_mgmt_cmd *setup_mgmt_cmd_arr;
+	bool send_index_none;
+	uint16_t send_opcode;
+	const void *send_param;
+	uint16_t send_len;
+	const void * (*send_func)(uint16_t *len);
+	uint8_t expect_status;
+	bool expect_ignore_param;
+	const void *expect_param;
+	uint16_t expect_len;
+	const void * (*expect_func)(uint16_t *len);
+	uint32_t expect_settings_set;
+	uint32_t expect_settings_unset;
+	uint16_t expect_alt_ev;
+	const void *expect_alt_ev_param;
+	bool (*verify_alt_ev_func)(const void *param, uint16_t length);
+	uint16_t expect_alt_ev_len;
+	uint16_t expect_hci_command;
+	const void *expect_hci_param;
+	int (*expect_hci_param_check_func)(const void *param, uint16_t length);
+	uint8_t expect_hci_len;
+	const void * (*expect_hci_func)(uint8_t *len);
+	bool expect_pin;
+	uint8_t pin_len;
+	const void *pin;
+	uint8_t client_pin_len;
+	const void *client_pin;
+	bool client_enable_ssp;
+	uint8_t io_cap;
+	uint8_t client_io_cap;
+	uint8_t client_auth_req;
+	bool reject_confirm;
+	bool client_reject_confirm;
+	bool just_works;
+	bool client_enable_le;
+	bool client_enable_sc;
+	bool client_enable_adv;
+	bool expect_sc_key;
+	bool force_power_off;
+	bool addr_type_avail;
+	uint8_t addr_type;
+	bool set_adv;
+	const uint8_t *adv_data;
+	uint8_t adv_data_len;
+};
+
+static struct l_tester *tester;
+
 static void print_debug(const char *str, void *user_data)
 {
 	const char *prefix = user_data;
 
-	tester_print("%s%s", prefix, str);
+	bttester_print("%s%s", prefix, str);
 }
 
 static void test_post_teardown(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 
 	if (data->sk >= 0)
 		close(data->sk);
@@ -76,43 +136,9 @@ static void test_post_teardown(const void *test_data)
 	data->hciemu = NULL;
 }
 
-static void test_pre_setup_failed(void)
-{
-	test_post_teardown(NULL);
-	tester_pre_setup_failed();
-}
-
-static void read_version_callback(uint8_t status, uint16_t length,
-					const void *param, void *user_data)
-{
-	struct test_data *data = tester_get_data();
-	const struct mgmt_rp_read_version *rp = param;
-
-	tester_print("Read Version callback");
-	tester_print("  Status: %s (0x%02x)", mgmt_errstr(status), status);
-
-	if (status || !param) {
-		test_pre_setup_failed();
-		return;
-	}
-
-	data->mgmt_version = rp->version;
-	data->mgmt_revision = btohs(rp->revision);
-
-	tester_print("  Version %u.%u",
-				data->mgmt_version, data->mgmt_revision);
-}
-
-static void read_commands_callback(uint8_t status, uint16_t length,
-					const void *param, void *user_data)
+static void test_pre_setup_complete(void)
 {
-	tester_print("Read Commands callback");
-	tester_print("  Status: %s (0x%02x)", mgmt_errstr(status), status);
-
-	if (status || !param) {
-		test_pre_setup_failed();
-		return;
-	}
+	l_tester_pre_setup_complete(tester);
 }
 
 static bool check_settings(uint32_t supported, uint32_t expected)
@@ -127,7 +153,7 @@ static bool check_settings(uint32_t supported, uint32_t expected)
 			continue;
 
 		if (expected & BIT(i)) {
-			tester_warn("Expected bit %u not supported", i);
+			bttester_warn("Expected bit %u not supported", i);
 			return false;
 		}
 	}
@@ -138,18 +164,18 @@ static bool check_settings(uint32_t supported, uint32_t expected)
 static void read_info_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct mgmt_rp_read_info *rp = param;
 	char addr[18];
 	uint16_t manufacturer;
 	uint32_t supported_settings, current_settings;
 	struct bthost *bthost;
 
-	tester_print("Read Info callback");
-	tester_print("  Status: %s (0x%02x)", mgmt_errstr(status), status);
+	bttester_print("Read Info callback");
+	bttester_print("  Status: %s (0x%02x)", mgmt_errstr(status), status);
 
 	if (status || !param) {
-		test_pre_setup_failed();
+		test_post_teardown(NULL);
 		return;
 	}
 
@@ -158,68 +184,68 @@ static void read_info_callback(uint8_t status, uint16_t length,
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
-		test_pre_setup_failed();
+		test_post_teardown(NULL);
 		return;
 	}
 
 	if (rp->version != data->expected_version) {
-		tester_warn("Expected version: 0x%02x != 0x%02x",
+		bttester_warn("Expected version: 0x%02x != 0x%02x",
 				rp->version, data->expected_version);
-		test_pre_setup_failed();
+		test_post_teardown(NULL);
 		return;
 	}
 
 	if (manufacturer != data->expected_manufacturer) {
-		tester_warn("Expected manufacturer: 0x%04x != 0x%04x",
+		bttester_warn("Expected manufacturer: 0x%04x != 0x%04x",
 				manufacturer, data->expected_manufacturer);
-		test_pre_setup_failed();
+		test_post_teardown(NULL);
 		return;
 	}
 
 	if (!check_settings(supported_settings,
 				data->expected_supported_settings)) {
-		tester_warn("Expected supported settings: 0x%08x != 0x%08x",
+		bttester_warn("Expected supported settings: 0x%08x != 0x%08x",
 				supported_settings,
 				data->expected_supported_settings);
-		test_pre_setup_failed();
+		test_post_teardown(NULL);
 		return;
 	}
 
 	if (!check_settings(current_settings, data->initial_settings)) {
-		tester_warn("Initial settings: 0x%08x != 0x%08x",
+		bttester_warn("Initial settings: 0x%08x != 0x%08x",
 				current_settings, data->initial_settings);
-		test_pre_setup_failed();
+		test_post_teardown(NULL);
 		return;
 	}
 
 	if (rp->dev_class[0] != 0x00 || rp->dev_class[1] != 0x00 ||
 						rp->dev_class[2] != 0x00) {
-		test_pre_setup_failed();
+		test_post_teardown(NULL);
 		return;
 	}
 
 	bthost = hciemu_client_get_host(data->hciemu);
-	bthost_notify_ready(bthost, tester_pre_setup_complete);
+	bthost_notify_ready(bthost, test_pre_setup_complete);
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
 
@@ -230,10 +256,10 @@ static void index_added_callback(uint16_t index, uint16_t length,
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
@@ -247,78 +273,23 @@ static void index_removed_callback(uint16_t index, uint16_t length,
 	mgmt_unref(data->mgmt_alt);
 	data->mgmt_alt = NULL;
 
-	tester_post_teardown_complete();
+	if (l_tester_get_stage(tester) == L_TESTER_STAGE_PRE_SETUP)
+		l_tester_pre_setup_failed(tester);
+	else
+		l_tester_post_teardown_complete(tester);
 }
 
-struct generic_data {
-	bool setup_le_states;
-	const uint8_t *le_states;
-	const uint16_t *setup_settings;
-	bool setup_nobredr;
-	bool setup_limited_discov;
-	uint16_t setup_expect_hci_command;
-	const void *setup_expect_hci_param;
-	uint8_t setup_expect_hci_len;
-	uint16_t setup_send_opcode;
-	const void *setup_send_param;
-	uint16_t setup_send_len;
-	const struct setup_mgmt_cmd *setup_mgmt_cmd_arr;
-	bool send_index_none;
-	uint16_t send_opcode;
-	const void *send_param;
-	uint16_t send_len;
-	const void * (*send_func)(uint16_t *len);
-	uint8_t expect_status;
-	bool expect_ignore_param;
-	const void *expect_param;
-	uint16_t expect_len;
-	const void * (*expect_func)(uint16_t *len);
-	uint32_t expect_settings_set;
-	uint32_t expect_settings_unset;
-	uint16_t expect_alt_ev;
-	const void *expect_alt_ev_param;
-	bool (*verify_alt_ev_func)(const void *param, uint16_t length);
-	uint16_t expect_alt_ev_len;
-	uint16_t expect_hci_command;
-	const void *expect_hci_param;
-	int (*expect_hci_param_check_func)(const void *param, uint16_t length);
-	uint8_t expect_hci_len;
-	const void * (*expect_hci_func)(uint8_t *len);
-	bool expect_pin;
-	uint8_t pin_len;
-	const void *pin;
-	uint8_t client_pin_len;
-	const void *client_pin;
-	bool client_enable_ssp;
-	uint8_t io_cap;
-	uint8_t client_io_cap;
-	uint8_t client_auth_req;
-	bool reject_confirm;
-	bool client_reject_confirm;
-	bool just_works;
-	bool client_enable_le;
-	bool client_enable_sc;
-	bool client_enable_adv;
-	bool expect_sc_key;
-	bool force_power_off;
-	bool addr_type_avail;
-	uint8_t addr_type;
-	bool set_adv;
-	const uint8_t *adv_data;
-	uint8_t adv_data_len;
-};
-
 static void read_index_list_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct generic_data *test = data->test_data;
 
-	tester_print("Read Index List callback");
-	tester_print("  Status: %s (0x%02x)", mgmt_errstr(status), status);
+	bttester_print("Read Index List callback");
+	bttester_print("  Status: %s (0x%02x)", mgmt_errstr(status), status);
 
 	if (status || !param) {
-		test_pre_setup_failed();
+		l_tester_pre_setup_failed(tester);
 		return;
 	}
 
@@ -330,39 +301,80 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 
 	data->hciemu = hciemu_new(data->hciemu_type);
 	if (!data->hciemu) {
-		tester_warn("Failed to setup HCI emulation");
-		test_pre_setup_failed();
+		bttester_warn("Failed to setup HCI emulation");
+		l_tester_pre_setup_failed(tester);
 	}
 
-	if (tester_use_debug())
+	if (bttester_use_debug())
 		hciemu_set_debug(data->hciemu, print_debug, "hciemu: ", NULL);
 
 	if (test && test->setup_le_states)
 		hciemu_set_master_le_states(data->hciemu, test->le_states);
 }
 
+static void read_commands_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = l_tester_get_data(tester);
+
+	bttester_print("Read Commands callback");
+	bttester_print("  Status: %s (0x%02x)", mgmt_errstr(status), status);
+
+	if (status || !param) {
+		l_tester_pre_setup_failed(tester);
+		return;
+	}
+
+	mgmt_send(data->mgmt, MGMT_OP_READ_INDEX_LIST, MGMT_INDEX_NONE, 0, NULL,
+					read_index_list_callback, NULL, NULL);
+}
+
+static void read_version_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = l_tester_get_data(tester);
+	const struct mgmt_rp_read_version *rp = param;
+
+	bttester_print("Read Version callback");
+	bttester_print("  Status: %s (0x%02x)", mgmt_errstr(status), status);
+
+	if (status || !param) {
+		l_tester_pre_setup_failed(tester);
+		return;
+	}
+
+	data->mgmt_version = rp->version;
+	data->mgmt_revision = btohs(rp->revision);
+
+	bttester_print("  Version %u.%u",
+				data->mgmt_version, data->mgmt_revision);
+
+	mgmt_send(data->mgmt, MGMT_OP_READ_COMMANDS, MGMT_INDEX_NONE, 0, NULL,
+					read_commands_callback, NULL, NULL);
+}
+
 static void test_pre_setup(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 
 	data->mgmt = mgmt_new_default();
 	if (!data->mgmt) {
-		tester_warn("Failed to setup management interface");
-		test_pre_setup_failed();
+		bttester_warn("Failed to setup management interface");
+		test_post_teardown(NULL);
 		return;
 	}
 
 	data->mgmt_alt = mgmt_new_default();
 	if (!data->mgmt_alt) {
-		tester_warn("Failed to setup alternate management interface");
-		test_pre_setup_failed();
+		bttester_warn("Failed to setup alternate management interface");
+		test_post_teardown(NULL);
 
 		mgmt_unref(data->mgmt);
 		data->mgmt = NULL;
 		return;
 	}
 
-	if (tester_use_debug()) {
+	if (bttester_use_debug()) {
 		mgmt_set_debug(data->mgmt, print_debug, "mgmt: ", NULL);
 		mgmt_set_debug(data->mgmt_alt, print_debug, "mgmt-alt: ", NULL);
 	}
@@ -370,12 +382,6 @@ static void test_pre_setup(const void *test_data)
 	mgmt_send(data->mgmt, MGMT_OP_READ_VERSION, MGMT_INDEX_NONE, 0, NULL,
 					read_version_callback, NULL, NULL);
 
-	mgmt_send(data->mgmt, MGMT_OP_READ_COMMANDS, MGMT_INDEX_NONE, 0, NULL,
-					read_commands_callback, NULL, NULL);
-
-	mgmt_send(data->mgmt, MGMT_OP_READ_INDEX_LIST, MGMT_INDEX_NONE, 0, NULL,
-					read_index_list_callback, NULL, NULL);
-
 	data->sk = -1;
 }
 
@@ -383,48 +389,49 @@ static void test_add_condition(struct test_data *data)
 {
 	data->unmet_conditions++;
 
-	tester_print("Test condition added, total %d", data->unmet_conditions);
+	bttester_print("Test condition added, total %d",
+							data->unmet_conditions);
 }
 
 static void test_add_setup_condition(struct test_data *data)
 {
 	data->unmet_setup_conditions++;
 
-	tester_print("Test setup condition added, total %d",
-		     data->unmet_setup_conditions);
+	bttester_print("Test setup condition added, total %d",
+						data->unmet_setup_conditions);
 }
 
 static void test_setup_condition_complete(struct test_data *data)
 {
 	data->unmet_setup_conditions--;
 
-	tester_print("Test setup condition complete, %d left",
-		     data->unmet_setup_conditions);
+	bttester_print("Test setup condition complete, %d left",
+						data->unmet_setup_conditions);
 
 	if (data->unmet_setup_conditions > 0)
 		return;
 
-	tester_setup_complete();
+	l_tester_setup_complete(tester);
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
 
 #define test_full(name, data, setup, func, timeout, type, version, \
 			expected_settings, settings) \
 	do { \
 		struct test_data *user; \
-		user = new0(struct test_data, 1); \
+		user = l_new(struct test_data, 1); \
 		user->hciemu_type = type; \
 		user->test_setup = setup; \
 		user->test_data = data; \
@@ -432,9 +439,9 @@ static void test_condition_complete(struct test_data *data)
 		user->expected_manufacturer = 0x003f; \
 		user->expected_supported_settings = expected_settings; \
 		user->initial_settings = settings; \
-		tester_add_full(name, data, \
+		l_tester_add_full(tester, name, data,			\
 				test_pre_setup, test_setup, func, NULL, \
-				test_post_teardown, timeout, user, free); \
+				test_post_teardown, timeout, user, l_free); \
 	} while (0)
 
 #define test_bredrle_full(name, data, setup, func, timeout) \
@@ -475,7 +482,7 @@ static void test_condition_complete(struct test_data *data)
 
 static void controller_setup(const void *test_data)
 {
-	tester_test_passed();
+	l_tester_test_passed(tester);
 }
 
 struct setup_mgmt_cmd {
@@ -2778,7 +2785,7 @@ static const struct generic_data pair_device_invalid_param_test_2 = {
 
 static const void *pair_device_send_param_func(uint16_t *len)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct generic_data *test = data->test_data;
 	static uint8_t param[8];
 
@@ -2799,7 +2806,7 @@ static const void *pair_device_send_param_func(uint16_t *len)
 
 static const void *pair_device_expect_param_func(uint16_t *len)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct generic_data *test = data->test_data;
 	static uint8_t param[7];
 
@@ -2886,7 +2893,7 @@ static const struct generic_data pair_device_power_off_test_1 = {
 
 static const void *client_bdaddr_param_func(uint8_t *len)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	static uint8_t bdaddr[6];
 
 	memcpy(bdaddr, hciemu_get_client_bdaddr(data->hciemu), 6);
@@ -3017,7 +3024,7 @@ static const struct generic_data pair_device_ssp_test_1 = {
 
 static const void *client_io_cap_param_func(uint8_t *len)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct generic_data *test = data->test_data;
 	static uint8_t param[9];
 
@@ -3200,33 +3207,33 @@ static bool ltk_is_sc(const struct mgmt_ltk_info *ltk)
 
 static bool verify_ltk(const void *param, uint16_t length)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct generic_data *test = data->test_data;
 	const struct mgmt_ev_new_long_term_key *ev = param;
 
 	if (length != sizeof(struct mgmt_ev_new_long_term_key)) {
-		tester_warn("Invalid new ltk length %u != %zu", length,
+		bttester_warn("Invalid new ltk length %u != %zu", length,
 				sizeof(struct mgmt_ev_new_long_term_key));
 		return false;
 	}
 
 	if (test->just_works && ltk_is_authenticated(&ev->key)) {
-		tester_warn("Authenticated key for just-works");
+		bttester_warn("Authenticated key for just-works");
 		return false;
 	}
 
 	if (!test->just_works && !ltk_is_authenticated(&ev->key)) {
-		tester_warn("Unauthenticated key for MITM");
+		bttester_warn("Unauthenticated key for MITM");
 		return false;
 	}
 
 	if (test->expect_sc_key && !ltk_is_sc(&ev->key)) {
-		tester_warn("Non-LE SC key for SC pairing");
+		bttester_warn("Non-LE SC key for SC pairing");
 		return false;
 	}
 
 	if (!test->expect_sc_key && ltk_is_sc(&ev->key)) {
-		tester_warn("SC key for Non-SC pairing");
+		bttester_warn("SC key for Non-SC pairing");
 		return false;
 	}
 
@@ -3382,33 +3389,33 @@ static bool lk_is_sc(const struct mgmt_link_key_info *lk)
 
 static bool verify_link_key(const void *param, uint16_t length)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct generic_data *test = data->test_data;
 	const struct mgmt_ev_new_link_key *ev = param;
 
 	if (length != sizeof(struct mgmt_ev_new_link_key)) {
-		tester_warn("Invalid new Link Key length %u != %zu", length,
+		bttester_warn("Invalid new Link Key length %u != %zu", length,
 				sizeof(struct mgmt_ev_new_link_key));
 		return false;
 	}
 
 	if (test->just_works && lk_is_authenticated(&ev->key)) {
-		tester_warn("Authenticated key for just-works");
+		bttester_warn("Authenticated key for just-works");
 		return false;
 	}
 
 	if (!test->just_works && !lk_is_authenticated(&ev->key)) {
-		tester_warn("Unauthenticated key for MITM");
+		bttester_warn("Unauthenticated key for MITM");
 		return false;
 	}
 
 	if (test->expect_sc_key && !lk_is_sc(&ev->key)) {
-		tester_warn("Non-LE SC key for SC pairing");
+		bttester_warn("Non-LE SC key for SC pairing");
 		return false;
 	}
 
 	if (!test->expect_sc_key && lk_is_sc(&ev->key)) {
-		tester_warn("SC key for Non-SC pairing");
+		bttester_warn("SC key for Non-SC pairing");
 		return false;
 	}
 
@@ -3543,7 +3550,7 @@ static const struct generic_data pairing_acceptor_ssp_3 = {
 
 static const void *client_io_cap_reject_param_func(uint8_t *len)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	static uint8_t param[7];
 
 	memcpy(param, hciemu_get_client_bdaddr(data->hciemu), 6);
@@ -3892,7 +3899,7 @@ static const struct generic_data set_privacy_nval_param_test = {
 
 static const void *get_conn_info_send_param_func(uint16_t *len)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	static uint8_t param[7];
 
 	memcpy(param, hciemu_get_client_bdaddr(data->hciemu), 6);
@@ -3905,7 +3912,7 @@ static const void *get_conn_info_send_param_func(uint16_t *len)
 
 static const void *get_conn_info_expect_param_func(uint16_t *len)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	static uint8_t param[10];
 
 	memcpy(param, hciemu_get_client_bdaddr(data->hciemu), 6);
@@ -3921,7 +3928,7 @@ static const void *get_conn_info_expect_param_func(uint16_t *len)
 
 static const void *get_conn_info_error_expect_param_func(uint16_t *len)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	static uint8_t param[10];
 
 	/* All unset parameters shall be 0 in case of error */
@@ -3953,7 +3960,7 @@ static const struct generic_data get_conn_info_ncon_test = {
 
 static const void *get_conn_info_expect_param_power_off_func(uint16_t *len)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	static uint8_t param[10];
 
 	memcpy(param, hciemu_get_client_bdaddr(data->hciemu), 6);
@@ -5807,7 +5814,7 @@ static void client_cmd_complete(uint16_t opcode, uint8_t status,
 					const void *param, uint8_t len,
 					void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct generic_data *test = data->test_data;
 	struct bthost *bthost;
 
@@ -5817,7 +5824,7 @@ static void client_cmd_complete(uint16_t opcode, uint8_t status,
 	case BT_HCI_CMD_WRITE_SCAN_ENABLE:
 	case BT_HCI_CMD_LE_SET_ADV_ENABLE:
 	case BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE:
-		tester_print("Client set connectable: %s (0x%02x)",
+		bttester_print("Client set connectable: %s (0x%02x)",
 						mgmt_errstr(status), status);
 		if (!status && test->client_enable_ssp) {
 			bthost_write_ssp_mode(bthost, 0x01);
@@ -5825,7 +5832,7 @@ static void client_cmd_complete(uint16_t opcode, uint8_t status,
 		}
 		break;
 	case BT_HCI_CMD_WRITE_SIMPLE_PAIRING_MODE:
-		tester_print("Client enable SSP: %s (0x%02x)",
+		bttester_print("Client enable SSP: %s (0x%02x)",
 						mgmt_errstr(status), status);
 		break;
 	default:
@@ -5833,14 +5840,14 @@ static void client_cmd_complete(uint16_t opcode, uint8_t status,
 	}
 
 	if (status)
-		tester_setup_failed();
+		l_tester_setup_failed(tester);
 	else
 		test_setup_condition_complete(data);
 }
 
 static void setup_bthost(void)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct generic_data *test = data->test_data;
 	struct bthost *bthost;
 
@@ -5860,7 +5867,7 @@ static void setup_bthost(void)
 
 static void setup_pairing_acceptor(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct generic_data *test = data->test_data;
 
 	if (!test->io_cap)
@@ -5877,22 +5884,22 @@ static void setup_powered_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
 	if (status != MGMT_STATUS_SUCCESS) {
-		tester_setup_failed();
+		l_tester_setup_failed(tester);
 		return;
 	}
 
-	tester_print("Controller powered on");
+	bttester_print("Controller powered on");
 
 	setup_bthost();
 }
 
 static void setup_class(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	unsigned char param[] = { 0x01 };
 	unsigned char class_param[] = { 0x01, 0x0c };
 
-	tester_print("Setting device class and powering on");
+	bttester_print("Setting device class and powering on");
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_DEV_CLASS, data->mgmt_index,
 				sizeof(class_param), class_param,
@@ -5906,40 +5913,40 @@ static void setup_class(const void *test_data)
 static void discovering_event(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct mgmt_ev_discovering *ev = param;
 
 	mgmt_unregister(data->mgmt, data->mgmt_discov_ev_id);
 
 	if (length != sizeof(*ev)) {
-		tester_warn("Incorrect discovering event length");
-		tester_setup_failed();
+		bttester_warn("Incorrect discovering event length");
+		l_tester_setup_failed(tester);
 		return;
 	}
 
 	if (!ev->discovering) {
-		tester_warn("Unexpected discovery stopped event");
-		tester_setup_failed();
+		bttester_warn("Unexpected discovery stopped event");
+		l_tester_setup_failed(tester);
 		return;
 	}
 
-	tester_setup_complete();
+	l_tester_setup_complete(tester);
 }
 
 static void setup_discovery_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
 	if (status != MGMT_STATUS_SUCCESS) {
-		tester_setup_failed();
+		l_tester_setup_failed(tester);
 		return;
 	}
 
-	tester_print("Discovery started");
+	bttester_print("Discovery started");
 }
 
 static void setup_start_discovery(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct generic_data *test = data->test_data;
 	const void *send_param = test->setup_send_param;
 	uint16_t send_len = test->setup_send_len;
@@ -5956,10 +5963,10 @@ static void setup_start_discovery(const void *test_data)
 
 static void setup_multi_uuid32(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	unsigned char param[] = { 0x01 };
 
-	tester_print("Powering on controller (with 32-bit UUID)");
+	bttester_print("Powering on controller (with 32-bit UUID)");
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_SSP, data->mgmt_index,
 				sizeof(param), param, NULL, NULL, NULL);
@@ -5981,7 +5988,7 @@ static void setup_multi_uuid32(const void *test_data)
 
 static void setup_multi_uuid32_2(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	unsigned char param[] = { 0x01 };
 	unsigned char uuid_param[] = {
 			0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
@@ -5989,7 +5996,7 @@ static void setup_multi_uuid32_2(const void *test_data)
 			0x00 };
 	int i;
 
-	tester_print("Powering on controller (with many 32-bit UUIDs)");
+	bttester_print("Powering on controller (with many 32-bit UUIDs)");
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_SSP, data->mgmt_index,
 				sizeof(param), param, NULL, NULL, NULL);
@@ -6009,10 +6016,10 @@ static void setup_multi_uuid32_2(const void *test_data)
 
 static void setup_multi_uuid128(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	unsigned char param[] = { 0x01 };
 
-	tester_print("Powering on controller (with 128-bit UUID)");
+	bttester_print("Powering on controller (with 128-bit UUID)");
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_SSP, data->mgmt_index,
 				sizeof(param), param, NULL, NULL, NULL);
@@ -6028,7 +6035,7 @@ static void setup_multi_uuid128(const void *test_data)
 
 static void setup_multi_uuid128_2(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	unsigned char param[] = { 0x01 };
 	unsigned char uuid_param[] = {
 			0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
@@ -6036,7 +6043,7 @@ static void setup_multi_uuid128_2(const void *test_data)
 			0x00 };
 	int i;
 
-	tester_print("Powering on controller (with many 128-bit UUIDs)");
+	bttester_print("Powering on controller (with many 128-bit UUIDs)");
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_SSP, data->mgmt_index,
 				sizeof(param), param, NULL, NULL, NULL);
@@ -6055,10 +6062,10 @@ static void setup_multi_uuid128_2(const void *test_data)
 
 static void setup_multi_uuid16(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	unsigned char param[] = { 0x01 };
 
-	tester_print("Powering on controller (with SPP UUID)");
+	bttester_print("Powering on controller (with SPP UUID)");
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_SSP, data->mgmt_index,
 				sizeof(param), param, NULL, NULL, NULL);
@@ -6080,10 +6087,10 @@ static void setup_multi_uuid16(const void *test_data)
 
 static void setup_multi_uuid16_power_off(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	unsigned char param[] = { 0x01 };
 
-	tester_print("Adding UUIDs without powering on");
+	bttester_print("Adding UUIDs without powering on");
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_SSP, data->mgmt_index,
 				sizeof(param), param, NULL, NULL, NULL);
@@ -6103,10 +6110,10 @@ static void setup_multi_uuid16_power_off(const void *test_data)
 
 static void setup_multi_uuid16_power_off_remove(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	unsigned char param[] = { 0x01 };
 
-	tester_print("Adding UUIDs without powering on and remove UUID");
+	bttester_print("Adding UUIDs without powering on and remove UUID");
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_SSP, data->mgmt_index,
 				sizeof(param), param, NULL, NULL, NULL);
@@ -6130,7 +6137,7 @@ static void setup_multi_uuid16_power_off_remove(const void *test_data)
 
 static void setup_multi_uuid16_2(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	unsigned char param[] = { 0x01 };
 	unsigned char uuid_param[] = {
 			0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
@@ -6138,7 +6145,7 @@ static void setup_multi_uuid16_2(const void *test_data)
 			0x00 };
 	int i;
 
-	tester_print("Powering on controller (with many 16-bit UUIDs)");
+	bttester_print("Powering on controller (with many 16-bit UUIDs)");
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_SSP, data->mgmt_index,
 				sizeof(param), param, NULL, NULL, NULL);
@@ -6158,10 +6165,10 @@ static void setup_multi_uuid16_2(const void *test_data)
 
 static void setup_uuid_mix(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	unsigned char param[] = { 0x01 };
 
-	tester_print("Powering on controller (with mixed UUIDs)");
+	bttester_print("Powering on controller (with mixed UUIDs)");
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_SSP, data->mgmt_index,
 				sizeof(param), param, NULL, NULL, NULL);
@@ -6190,12 +6197,12 @@ static void setup_uuid_mix(const void *test_data)
 
 static void setup_add_device(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	unsigned char param[] = { 0x01 };
 	const unsigned char *add_param;
 	size_t add_param_len;
 
-	tester_print("Powering on controller (with added device)");
+	bttester_print("Powering on controller (with added device)");
 
 	if (data->hciemu_type == HCIEMU_TYPE_LE) {
 		add_param = add_device_success_param_2;
@@ -6220,11 +6227,11 @@ static void setup_add_advertising_callback(uint8_t status, uint16_t length,
 				(struct mgmt_rp_add_advertising *) param;
 
 	if (status != MGMT_STATUS_SUCCESS) {
-		tester_setup_failed();
+		l_tester_setup_failed(tester);
 		return;
 	}
 
-	tester_print("Add Advertising setup complete (instance %d)",
+	bttester_print("Add Advertising setup complete (instance %d)",
 								rp->instance);
 
 	setup_bthost();
@@ -6249,12 +6256,12 @@ static void setup_add_adv_param(struct mgmt_cp_add_advertising *cp,
 
 static void setup_add_advertising_not_powered(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	struct mgmt_cp_add_advertising *cp;
 	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
 	unsigned char param[] = { 0x01 };
 
-	tester_print("Adding advertising instance while unpowered");
+	bttester_print("Adding advertising instance while unpowered");
 
 	cp = (struct mgmt_cp_add_advertising *) adv_param;
 	setup_add_adv_param(cp, 1);
@@ -6271,12 +6278,12 @@ static void setup_add_advertising_not_powered(const void *test_data)
 
 static void setup_add_advertising(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	struct mgmt_cp_add_advertising *cp;
 	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
 	unsigned char param[] = { 0x01 };
 
-	tester_print("Adding advertising instance while powered");
+	bttester_print("Adding advertising instance while powered");
 
 	cp = (struct mgmt_cp_add_advertising *) adv_param;
 	setup_add_adv_param(cp, 1);
@@ -6297,12 +6304,12 @@ static void setup_add_advertising(const void *test_data)
 
 static void setup_add_advertising_connectable(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	struct mgmt_cp_add_advertising *cp;
 	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
 	unsigned char param[] = { 0x01 };
 
-	tester_print("Adding advertising instance while connectable");
+	bttester_print("Adding advertising instance while connectable");
 
 	cp = (struct mgmt_cp_add_advertising *) adv_param;
 	setup_add_adv_param(cp, 1);
@@ -6334,7 +6341,7 @@ static int create_le_att_sock(struct test_data *data)
 							BTPROTO_L2CAP);
 	if (sk < 0) {
 		err = -errno;
-		tester_warn("Can't create socket: %s (%d)", strerror(errno),
+		bttester_warn("Can't create socket: %s (%d)", strerror(errno),
 									errno);
 		return err;
 	}
@@ -6347,7 +6354,7 @@ static int create_le_att_sock(struct test_data *data)
 
 	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
 		err = -errno;
-		tester_warn("Can't bind socket: %s (%d)", strerror(errno),
+		bttester_warn("Can't bind socket: %s (%d)", strerror(errno),
 									errno);
 		close(sk);
 		return err;
@@ -6355,7 +6362,7 @@ static int create_le_att_sock(struct test_data *data)
 
 	if (listen(sk, 1) < 0) {
 		err = -errno;
-		tester_warn("Can't bind socket: %s (%d)", strerror(errno),
+		bttester_warn("Can't bind socket: %s (%d)", strerror(errno),
 									errno);
 		close(sk);
 		return err;
@@ -6368,11 +6375,11 @@ static int create_le_att_sock(struct test_data *data)
 
 static void setup_advertise_while_connected(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	struct mgmt_cp_add_advertising *cp;
 	uint8_t adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
 
-	tester_print("Adding advertising instances");
+	bttester_print("Adding advertising instances");
 
 	cp = (struct mgmt_cp_add_advertising *) adv_param;
 	setup_add_adv_param(cp, 1);
@@ -6394,17 +6401,17 @@ static void setup_advertise_while_connected(const void *test_data)
 	 * connect. Socket is closed in test_post_teardown
 	 */
 	if (create_le_att_sock(data) < 0)
-		tester_test_failed();
+		l_tester_test_failed(tester);
 }
 
 static void setup_add_advertising_timeout(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	struct mgmt_cp_add_advertising *cp;
 	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
 	unsigned char param[] = { 0x01 };
 
-	tester_print("Adding advertising instance with timeout");
+	bttester_print("Adding advertising instance with timeout");
 
 	cp = (struct mgmt_cp_add_advertising *) adv_param;
 	setup_add_adv_param(cp, 1);
@@ -6426,12 +6433,12 @@ static void setup_add_advertising_timeout(const void *test_data)
 
 static void setup_add_advertising_duration(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	struct mgmt_cp_add_advertising *cp;
 	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
 	unsigned char param[] = { 0x01 };
 
-	tester_print("Adding instance with long timeout/short duration");
+	bttester_print("Adding instance with long timeout/short duration");
 
 	cp = (struct mgmt_cp_add_advertising *) adv_param;
 	setup_add_adv_param(cp, 1);
@@ -6455,11 +6462,11 @@ static void setup_add_advertising_duration(const void *test_data)
 static void setup_power_cycle_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	unsigned char param_off[] = { 0x00 };
 
 	if (status != MGMT_STATUS_SUCCESS) {
-		tester_setup_failed();
+		l_tester_setup_failed(tester);
 		return;
 	}
 
@@ -6472,12 +6479,12 @@ static void setup_power_cycle_callback(uint8_t status, uint16_t length,
 
 static void setup_add_advertising_power_cycle(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	struct mgmt_cp_add_advertising *cp;
 	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
 	unsigned char param_on[] = { 0x01 };
 
-	tester_print("Adding instance without timeout and power cycle");
+	bttester_print("Adding instance without timeout and power cycle");
 
 	cp = (struct mgmt_cp_add_advertising *) adv_param;
 	setup_add_adv_param(cp, 1);
@@ -6498,12 +6505,12 @@ static void setup_add_advertising_power_cycle(const void *test_data)
 
 static void setup_set_and_add_advertising(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	struct mgmt_cp_add_advertising *cp;
 	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
 	unsigned char param[] = { 0x01 };
 
-	tester_print("Set and add advertising instance");
+	bttester_print("Set and add advertising instance");
 
 	cp = (struct mgmt_cp_add_advertising *) adv_param;
 	setup_add_adv_param(cp, 1);
@@ -6530,16 +6537,16 @@ static void setup_multi_adv_second_instance(uint8_t status, uint16_t length,
 		const void *param, void *user_data) {
 	struct mgmt_rp_add_advertising *rp =
 				(struct mgmt_rp_add_advertising *) param;
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	struct mgmt_cp_add_advertising *cp;
 	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
 
 	if (status != MGMT_STATUS_SUCCESS) {
-		tester_setup_failed();
+		l_tester_setup_failed(tester);
 		return;
 	}
 
-	tester_print("Add Advertising setup complete (instance %d)",
+	bttester_print("Add Advertising setup complete (instance %d)",
 								rp->instance);
 
 	cp = (struct mgmt_cp_add_advertising *) adv_param;
@@ -6555,12 +6562,12 @@ static void setup_multi_adv_second_instance(uint8_t status, uint16_t length,
 
 static void setup_multi_adv(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	struct mgmt_cp_add_advertising *cp;
 	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
 	unsigned char param[] = { 0x01 };
 
-	tester_print("Adding two instances with timeout 1 and duration 1");
+	bttester_print("Adding two instances with timeout 1 and duration 1");
 
 	cp = (struct mgmt_cp_add_advertising *) adv_param;
 	setup_add_adv_param(cp, 1);
@@ -6584,14 +6591,14 @@ static void setup_multi_adv(const void *test_data)
 static void setup_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 
 	if (status != MGMT_STATUS_SUCCESS) {
-		tester_setup_failed();
+		l_tester_setup_failed(tester);
 		return;
 	}
 
-	tester_print("Initial settings completed");
+	bttester_print("Initial settings completed");
 
 	if (data->test_setup)
 		data->test_setup(data);
@@ -6603,7 +6610,7 @@ static void setup_set_unpowered_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
 	if (status != MGMT_STATUS_SUCCESS) {
-		tester_setup_failed();
+		l_tester_setup_failed(tester);
 		return;
 	}
 
@@ -6613,15 +6620,15 @@ static void setup_set_unpowered_callback(uint8_t status, uint16_t length,
 static void setup_set_le_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	unsigned char power_param[] = { 0x00 };
 
 	if (status != MGMT_STATUS_SUCCESS) {
-		tester_setup_failed();
+		l_tester_setup_failed(tester);
 		return;
 	}
 
-	tester_print("Disabling power");
+	bttester_print("Disabling power");
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
 						sizeof(power_param),
@@ -6632,10 +6639,10 @@ static void setup_set_le_callback(uint8_t status, uint16_t length,
 
 static void setup_ext_adv_not_powered(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	unsigned char param[] = { 0x01 };
 
-	tester_print("Enabling LE");
+	bttester_print("Enabling LE");
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
 						sizeof(param), &param,
@@ -6647,7 +6654,7 @@ static void setup_set_ext_adv_params_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
 	if (status != MGMT_STATUS_SUCCESS) {
-		tester_setup_failed();
+		l_tester_setup_failed(tester);
 		return;
 	}
 
@@ -6656,9 +6663,9 @@ static void setup_set_ext_adv_params_callback(uint8_t status, uint16_t length,
 
 static void setup_ext_adv_params(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 
-	tester_print("Setting Extended Adv Params");
+	bttester_print("Setting Extended Adv Params");
 
 	mgmt_send(data->mgmt, MGMT_OP_ADD_EXT_ADV_PARAMS, data->mgmt_index,
 					sizeof(ext_adv_params_valid),
@@ -6726,8 +6733,8 @@ static void user_passkey_request_callback(uint16_t index, uint16_t length,
 	struct mgmt_cp_user_passkey_reply cp;
 
 	if (test->just_works) {
-		tester_warn("User Passkey Request for just-works case");
-		tester_test_failed();
+		bttester_warn("User Passkey Request for just-works case");
+		l_tester_test_failed(tester);
 		return;
 	}
 
@@ -6747,7 +6754,7 @@ static void user_passkey_request_callback(uint16_t index, uint16_t length,
 
 static void test_setup(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct generic_data *test = data->test_data;
 	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
 	const uint16_t *cmd;
@@ -6796,7 +6803,7 @@ proceed:
 		if (data->test_setup)
 			data->test_setup(data);
 		else
-			tester_setup_complete();
+			l_tester_setup_complete(tester);
 		return;
 	}
 
@@ -6846,31 +6853,31 @@ proceed:
 static void command_generic_new_settings(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 
-	tester_print("New settings event received");
+	bttester_print("New settings event received");
 
 	mgmt_unregister(data->mgmt, data->mgmt_settings_id);
 
-	tester_test_failed();
+	l_tester_test_failed(tester);
 }
 
 static void command_generic_new_settings_alt(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct generic_data *test = data->test_data;
 	uint32_t settings;
 
 	if (length != 4) {
-		tester_warn("Invalid parameter size for new settings event");
-		tester_test_failed();
+		bttester_warn("Invalid parameter size for new settings event");
+		l_tester_test_failed(tester);
 		return;
 	}
 
 	settings = get_le32(param);
 
-	tester_print("New settings 0x%08x received", settings);
+	bttester_print("New settings 0x%08x received", settings);
 
 	if (test->expect_settings_unset) {
 		if ((settings & test->expect_settings_unset) != 0)
@@ -6885,7 +6892,7 @@ static void command_generic_new_settings_alt(uint16_t index, uint16_t length,
 		return;
 
 done:
-	tester_print("Unregistering new settings notification");
+	bttester_print("Unregistering new settings notification");
 
 	mgmt_unregister(data->mgmt_alt, data->mgmt_alt_settings_id);
 
@@ -6894,18 +6901,18 @@ done:
 
 static bool verify_alt_ev(const void *param, uint16_t length)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct generic_data *test = data->test_data;
 
 	if (length != test->expect_alt_ev_len) {
-		tester_warn("Invalid length %u != %u", length,
+		bttester_warn("Invalid length %u != %u", length,
 						test->expect_alt_ev_len);
 		return false;
 	}
 
 	if (test->expect_alt_ev_param &&
 			memcmp(test->expect_alt_ev_param, param, length)) {
-		tester_warn("Event parameters do not match");
+		bttester_warn("Event parameters do not match");
 		util_hexdump('>', param, length, print_debug, "");
 		util_hexdump('!', test->expect_alt_ev_param, length,
 							print_debug, "");
@@ -6919,11 +6926,12 @@ static void command_generic_event_alt(uint16_t index, uint16_t length,
 							const void *param,
 							void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct generic_data *test = data->test_data;
 	bool (*verify)(const void *param, uint16_t length);
 
-	tester_print("New %s event received", mgmt_evstr(test->expect_alt_ev));
+	bttester_print("New %s event received",
+					mgmt_evstr(test->expect_alt_ev));
 
 	mgmt_unregister(data->mgmt_alt, data->mgmt_alt_ev_id);
 
@@ -6933,9 +6941,9 @@ static void command_generic_event_alt(uint16_t index, uint16_t length,
 		verify = verify_alt_ev;
 
 	if (!verify(param, length)) {
-		tester_warn("Incorrect %s event parameters",
+		bttester_warn("Incorrect %s event parameters",
 					mgmt_evstr(test->expect_alt_ev));
-		tester_test_failed();
+		l_tester_test_failed(tester);
 		return;
 	}
 
@@ -6945,16 +6953,17 @@ static void command_generic_event_alt(uint16_t index, uint16_t length,
 static void command_generic_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct generic_data *test = data->test_data;
 	const void *expect_param = test->expect_param;
 	uint16_t expect_len = test->expect_len;
 
-	tester_print("%s (0x%04x): %s (0x%02x)", mgmt_opstr(test->send_opcode),
-			test->send_opcode, mgmt_errstr(status), status);
+	bttester_print("%s (0x%04x): %s (0x%02x)",
+			mgmt_opstr(test->send_opcode), test->send_opcode,
+						mgmt_errstr(status), status);
 
 	if (status != test->expect_status) {
-		tester_test_abort();
+		l_tester_test_abort(tester);
 		return;
 	}
 
@@ -6963,18 +6972,18 @@ static void command_generic_callback(uint8_t status, uint16_t length,
 			expect_param = test->expect_func(&expect_len);
 
 		if (length != expect_len) {
-			tester_warn("Invalid cmd response parameter size");
-			tester_test_failed();
+			bttester_warn("Invalid cmd response parameter size");
+			l_tester_test_failed(tester);
 			return;
 		}
 
 		if (expect_param && expect_len > 0 &&
 					memcmp(param, expect_param, length)) {
-			tester_warn("Unexpected cmd response parameter value");
+			bttester_warn("Unexpected cmd response param value");
 			util_hexdump('>', param, length, print_debug, "");
 			util_hexdump('!', expect_param, length, print_debug,
 								"");
-			tester_test_failed();
+			l_tester_test_failed(tester);
 			return;
 		}
 	}
@@ -6990,20 +6999,20 @@ static void command_setup_hci_callback(uint16_t opcode, const void *param,
 	const void *setup_expect_hci_param = test->setup_expect_hci_param;
 	uint8_t setup_expect_hci_len = test->setup_expect_hci_len;
 
-	tester_print("HCI Command 0x%04x length %u", opcode, length);
+	bttester_print("HCI Command 0x%04x length %u", opcode, length);
 
 	if (opcode != test->setup_expect_hci_command)
 		return;
 
 	if (length != setup_expect_hci_len) {
-		tester_warn("Invalid parameter size for HCI command");
-		tester_test_failed();
+		bttester_warn("Invalid parameter size for HCI command");
+		l_tester_test_failed(tester);
 		return;
 	}
 
 	if (memcmp(param, setup_expect_hci_param, length) != 0) {
-		tester_warn("Unexpected HCI command parameter value");
-		tester_test_failed();
+		bttester_warn("Unexpected HCI command parameter value");
+		l_tester_test_failed(tester);
 		return;
 	}
 
@@ -7020,7 +7029,7 @@ static void command_hci_callback(uint16_t opcode, const void *param,
 	uint8_t expect_hci_len = test->expect_hci_len;
 	int ret;
 
-	tester_print("HCI Command 0x%04x length %u", opcode, length);
+	bttester_print("HCI Command 0x%04x length %u", opcode, length);
 
 	if (opcode != test->expect_hci_command || data->expect_hci_command_done)
 		return;
@@ -7031,8 +7040,8 @@ static void command_hci_callback(uint16_t opcode, const void *param,
 		expect_hci_param = test->expect_hci_func(&expect_hci_len);
 
 	if (length != expect_hci_len) {
-		tester_warn("Invalid parameter size for HCI command");
-		tester_test_failed();
+		bttester_warn("Invalid parameter size for HCI command");
+		l_tester_test_failed(tester);
 		return;
 	}
 
@@ -7040,11 +7049,12 @@ static void command_hci_callback(uint16_t opcode, const void *param,
 		ret = test->expect_hci_param_check_func(param, length);
 	else
 		ret = memcmp(param, expect_hci_param, length);
+
 	if (ret != 0) {
-		tester_warn("Unexpected HCI command parameter value:");
+		bttester_warn("Unexpected HCI command parameter value:");
 		util_hexdump('>', param, length, print_debug, "");
 		util_hexdump('!', expect_hci_param, length, print_debug, "");
-		tester_test_failed();
+		l_tester_test_failed(tester);
 		return;
 	}
 
@@ -7055,7 +7065,7 @@ static void setup_mgmt_cmd_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
 	if (status != MGMT_STATUS_SUCCESS) {
-		tester_setup_failed();
+		l_tester_setup_failed(tester);
 		return;
 	}
 	test_setup_condition_complete(user_data);
@@ -7063,15 +7073,15 @@ static void setup_mgmt_cmd_callback(uint8_t status, uint16_t length,
 
 static void setup_command_generic(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct generic_data *test = data->test_data;
 	const void *send_param = test->setup_send_param;
 	uint16_t send_len = test->setup_send_len;
 	size_t i = 0;
 
 	if (test->setup_expect_hci_command) {
-		tester_print("Registering setup expected HCI command callback");
-		tester_print("Setup expected HCI command 0x%04x",
+		bttester_print("Registering setup expected HCI command cb");
+		bttester_print("Setup expected HCI command 0x%04x",
 					 test->setup_expect_hci_command);
 		hciemu_add_master_post_command_hook(data->hciemu,
 					command_setup_hci_callback, data);
@@ -7079,7 +7089,7 @@ static void setup_command_generic(const void *test_data)
 	}
 
 	if (test->setup_send_opcode) {
-		tester_print("Setup sending %s (0x%04x)",
+		bttester_print("Setup sending %s (0x%04x)",
 				mgmt_opstr(test->setup_send_opcode),
 				test->setup_send_opcode);
 		mgmt_send(data->mgmt, test->setup_send_opcode, data->mgmt_index,
@@ -7090,14 +7100,14 @@ static void setup_command_generic(const void *test_data)
 		return;
 	}
 
-	tester_print("Sending setup opcode array");
+	bttester_print("Sending setup opcode array");
 	for (; test->setup_mgmt_cmd_arr + i; ++i) {
 		const struct setup_mgmt_cmd *cmd = test->setup_mgmt_cmd_arr + i;
 
 		if (cmd->send_opcode == 0x00)
 			break;
 
-		tester_print("Setup sending %s (0x%04x)",
+		bttester_print("Setup sending %s (0x%04x)",
 				mgmt_opstr(cmd->send_opcode),
 				cmd->send_opcode);
 
@@ -8649,12 +8659,12 @@ static void setup_add_adv_param_1m(struct mgmt_cp_add_advertising *cp,
 
 static void setup_add_advertising_1m(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	struct mgmt_cp_add_advertising *cp;
 	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
 	unsigned char param[] = { 0x01 };
 
-	tester_print("Adding advertising instance while powered");
+	bttester_print("Adding advertising instance while powered");
 
 	cp = (struct mgmt_cp_add_advertising *) adv_param;
 	setup_add_adv_param_1m(cp, 1);
@@ -8705,12 +8715,12 @@ static const struct generic_data add_ext_advertising_conn_on_1m = {
 
 static void setup_add_advertising_connectable_1m(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	struct mgmt_cp_add_advertising *cp;
 	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
 	unsigned char param[] = { 0x01 };
 
-	tester_print("Adding advertising instance while connectable");
+	bttester_print("Adding advertising instance while connectable");
 
 	cp = (struct mgmt_cp_add_advertising *) adv_param;
 	setup_add_adv_param_1m(cp, 1);
@@ -9092,18 +9102,18 @@ static void set_phy_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
 	if (status != MGMT_STATUS_SUCCESS) {
-		tester_setup_failed();
+		l_tester_setup_failed(tester);
 		return;
 	}
 
-	tester_print("Set PHY Success");
+	bttester_print("Set PHY Success");
 
-	tester_setup_complete();
+	l_tester_setup_complete(tester);
 }
 
 static void setup_phy_configuration(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct generic_data *test = data->test_data;
 	const void *send_param = test->setup_send_param;
 	uint16_t send_len = test->setup_send_len;
@@ -9152,12 +9162,12 @@ static const struct generic_data get_dev_flags_fail_1 = {
 
 static void setup_get_dev_flags(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	unsigned char param[] = { 0x01 };
 	const unsigned char *add_param;
 	size_t add_param_len;
 
-	tester_print("Powering on controller (with added device)");
+	bttester_print("Powering on controller (with added device)");
 
 	if (data->hciemu_type == HCIEMU_TYPE_LE) {
 		add_param = add_device_success_param_2;
@@ -9356,27 +9366,27 @@ static void setup_load_irks_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
 	if (status != MGMT_STATUS_SUCCESS) {
-		tester_setup_failed();
+		l_tester_setup_failed(tester);
 		return;
 	}
 
-	tester_print("Load IRK completed");
+	bttester_print("Load IRK completed");
 }
 
 static void setup_exp_feat_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
 	if (status != MGMT_STATUS_SUCCESS) {
-		tester_setup_failed();
+		l_tester_setup_failed(tester);
 		return;
 	}
 
-	tester_print("LL Privacy Exp feature is enabled");
+	bttester_print("LL Privacy Exp feature is enabled");
 }
 
 static void setup_ll_privacy(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	unsigned char param[] = { 0x01 };
 	const uint8_t *ext_feat_param;
 	size_t ext_feat_len;
@@ -9386,7 +9396,7 @@ static void setup_ll_privacy(const void *test_data)
 			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
 			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08 };
 
-	tester_print("Enabling LL Privacy feature");
+	bttester_print("Enabling LL Privacy feature");
 
 	ext_feat_param = set_exp_feat_param_ll_privacy;
 	ext_feat_len = sizeof(set_exp_feat_param_ll_privacy);
@@ -9420,16 +9430,16 @@ static void setup_add_device_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
 	if (status != MGMT_STATUS_SUCCESS) {
-		tester_setup_failed();
+		l_tester_setup_failed(tester);
 		return;
 	}
 
-	tester_print("New Device is Added");
+	bttester_print("New Device is Added");
 }
 
 static void setup_ll_privacy_device(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct generic_data *test = data->test_data;
 	unsigned char param[] = { 0x01 };
 	const uint8_t *ext_feat_param;
@@ -9442,13 +9452,13 @@ static void setup_ll_privacy_device(const void *test_data)
 			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
 			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08 };
 
-	tester_print("Setup expected HCI command 0x%04x",
+	bttester_print("Setup expected HCI command 0x%04x",
 					 test->setup_expect_hci_command);
 	hciemu_add_master_post_command_hook(data->hciemu,
 					command_setup_hci_callback, data);
 	test_add_setup_condition(data);
 
-	tester_print("Enabling LL Privacy feature");
+	bttester_print("Enabling LL Privacy feature");
 
 	ext_feat_param = set_exp_feat_param_ll_privacy;
 	ext_feat_len = sizeof(set_exp_feat_param_ll_privacy);
@@ -9493,7 +9503,7 @@ static const uint8_t add_device_success_param_4[] = {
 /* Enable LL Privacy and Add 2 devices */
 static void setup_ll_privacy_device2(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	unsigned char param[] = { 0x01 };
 	const uint8_t *ext_feat_param;
 	size_t ext_feat_len;
@@ -9505,7 +9515,7 @@ static void setup_ll_privacy_device2(const void *test_data)
 			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
 			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08 };
 
-	tester_print("Enabling LL Privacy feature");
+	bttester_print("Enabling LL Privacy feature");
 
 	ext_feat_param = set_exp_feat_param_ll_privacy;
 	ext_feat_len = sizeof(set_exp_feat_param_ll_privacy);
@@ -9568,7 +9578,7 @@ static bool power_off(uint16_t index)
 
 static void test_command_generic(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct generic_data *test = data->test_data;
 	const void *send_param = test->send_param;
 	uint16_t send_len = test->send_len;
@@ -9578,7 +9588,7 @@ static void test_command_generic(const void *test_data)
 	index = test->send_index_none ? MGMT_INDEX_NONE : data->mgmt_index;
 
 	if (test->expect_settings_set || test->expect_settings_unset) {
-		tester_print("Registering new settings notification");
+		bttester_print("Registering new settings notification");
 
 		id = mgmt_register(data->mgmt, MGMT_EV_NEW_SETTINGS, index,
 				command_generic_new_settings, NULL, NULL);
@@ -9591,7 +9601,7 @@ static void test_command_generic(const void *test_data)
 	}
 
 	if (test->expect_alt_ev) {
-		tester_print("Registering %s notification",
+		bttester_print("Registering %s notification",
 					mgmt_evstr(test->expect_alt_ev));
 		id = mgmt_register(data->mgmt_alt, test->expect_alt_ev, index,
 					command_generic_event_alt, NULL, NULL);
@@ -9600,18 +9610,18 @@ static void test_command_generic(const void *test_data)
 	}
 
 	if (test->expect_hci_command) {
-		tester_print("Registering HCI command callback");
+		bttester_print("Registering HCI command callback");
 		hciemu_add_master_post_command_hook(data->hciemu,
 						command_hci_callback, data);
 		test_add_condition(data);
 	}
 
 	if (test->send_opcode == 0x0000) {
-		tester_print("Executing no-op test");
+		bttester_print("Executing no-op test");
 		return;
 	}
 
-	tester_print("Sending %s (0x%04x)", mgmt_opstr(test->send_opcode),
+	bttester_print("Sending %s (0x%04x)", mgmt_opstr(test->send_opcode),
 							test->send_opcode);
 
 	if (test->send_func)
@@ -9633,17 +9643,17 @@ static void test_command_generic(const void *test_data)
 
 static void check_scan(void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 
 	if (hciemu_get_master_le_scan_enable(data->hciemu)) {
-		tester_warn("LE scan still enabled");
-		tester_test_failed();
+		bttester_warn("LE scan still enabled");
+		l_tester_test_failed(tester);
 		return;
 	}
 
 	if (hciemu_get_master_scan_enable(data->hciemu)) {
-		tester_warn("BR/EDR scan still enabled");
-		tester_test_failed();
+		bttester_warn("BR/EDR scan still enabled");
+		l_tester_test_failed(tester);
 		return;
 	}
 
@@ -9652,16 +9662,16 @@ static void check_scan(void *user_data)
 
 static void test_remove_device(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 
 	test_command_generic(test_data);
-	tester_wait(1, check_scan, NULL);
+	l_tester_wait(tester, 1, check_scan, NULL);
 	test_add_condition(data);
 }
 
 static void trigger_device_found(void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct generic_data *test = data->test_data;
 	struct bthost *bthost;
 
@@ -9690,21 +9700,21 @@ static void trigger_device_found(void *user_data)
 
 static void test_device_found(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 
 	test_command_generic(test_data);
 
 	/* Make sure discovery is enabled before enabling advertising. */
-	tester_wait(1, trigger_device_found, NULL);
+	l_tester_wait(tester, 1, trigger_device_found, NULL);
 	test_add_condition(data);
 }
 
 static void pairing_new_conn(uint16_t handle, void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	struct bthost *bthost;
 
-	tester_print("New connection with handle 0x%04x", handle);
+	bttester_print("New connection with handle 0x%04x", handle);
 
 	bthost = hciemu_client_get_host(data->hciemu);
 
@@ -9713,7 +9723,7 @@ static void pairing_new_conn(uint16_t handle, void *user_data)
 
 static void test_pairing_acceptor(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct generic_data *test = data->test_data;
 	const uint8_t *master_bdaddr;
 	struct bthost *bthost;
@@ -9722,7 +9732,7 @@ static void test_pairing_acceptor(const void *test_data)
 	if (test->expect_alt_ev) {
 		unsigned int id;
 
-		tester_print("Registering %s notification",
+		bttester_print("Registering %s notification",
 					mgmt_evstr(test->expect_alt_ev));
 		id = mgmt_register(data->mgmt_alt, test->expect_alt_ev,
 					data->mgmt_index,
@@ -9733,8 +9743,8 @@ static void test_pairing_acceptor(const void *test_data)
 
 	master_bdaddr = hciemu_get_master_bdaddr(data->hciemu);
 	if (!master_bdaddr) {
-		tester_warn("No master bdaddr");
-		tester_test_failed();
+		bttester_warn("No master bdaddr");
+		l_tester_test_failed(tester);
 		return;
 	}
 
@@ -9752,12 +9762,12 @@ static void test_pairing_acceptor(const void *test_data)
 static void connected_event(uint16_t index, uint16_t length, const void *param,
 							void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct generic_data *test = data->test_data;
 	const void *send_param = test->send_param;
 	uint16_t send_len = test->send_len;
 
-	tester_print("Sending %s 0x%04x", mgmt_opstr(test->send_opcode),
+	bttester_print("Sending %s 0x%04x", mgmt_opstr(test->send_opcode),
 							test->send_opcode);
 
 	if (test->send_func)
@@ -9782,13 +9792,13 @@ static void connected_event(uint16_t index, uint16_t length, const void *param,
 
 static void test_command_generic_connect(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	unsigned int id;
 	const uint8_t *master_bdaddr;
 	uint8_t addr_type;
 	struct bthost *bthost;
 
-	tester_print("Registering %s notification",
+	bttester_print("Registering %s notification",
 					mgmt_evstr(MGMT_EV_DEVICE_CONNECTED));
 	id = mgmt_register(data->mgmt_alt, MGMT_EV_DEVICE_CONNECTED,
 				data->mgmt_index, connected_event,
@@ -9798,8 +9808,8 @@ static void test_command_generic_connect(const void *test_data)
 
 	master_bdaddr = hciemu_get_master_bdaddr(data->hciemu);
 	if (!master_bdaddr) {
-		tester_warn("No master bdaddr");
-		tester_test_failed();
+		bttester_warn("No master bdaddr");
+		l_tester_test_failed(tester);
 		return;
 	}
 
@@ -9817,10 +9827,10 @@ static bool test_adv_enable_hook(const void *data, uint16_t len,
 	const uint8_t *status = data;
 
 	if (*status == 0) {
-		tester_print("Advertising enabled");
+		bttester_print("Advertising enabled");
 		test_condition_complete(test_data);
 	} else {
-		tester_print("Advertising enabled error 0x%02x", *status);
+		bttester_print("Advertising enabled error 0x%02x", *status);
 	}
 
 	return true;
@@ -9829,15 +9839,15 @@ static bool test_adv_enable_hook(const void *data, uint16_t len,
 static void disconnected_event(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
-	tester_test_failed();
+	l_tester_test_failed(tester);
 }
 
 static void le_connected_event(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 
-	tester_print("Device connected");
+	bttester_print("Device connected");
 
 	test_add_condition(data);
 
@@ -9868,11 +9878,11 @@ static void add_device_callback(uint8_t status, uint16_t len, const void *param,
 	const uint8_t *master_bdaddr;
 
 	if (status != 0) {
-		tester_test_failed();
+		l_tester_test_failed(tester);
 		return;
 	}
 
-	tester_print("Device added");
+	bttester_print("Device added");
 
 	/* If advertising is enabled on client that means we can stop here and
 	 * just wait for connection
@@ -9882,8 +9892,8 @@ static void add_device_callback(uint8_t status, uint16_t len, const void *param,
 
 	master_bdaddr = hciemu_get_master_bdaddr(data->hciemu);
 	if (!master_bdaddr) {
-		tester_warn("No master bdaddr");
-		tester_test_failed();
+		bttester_warn("No master bdaddr");
+		l_tester_test_failed(tester);
 		return;
 	}
 
@@ -9896,12 +9906,12 @@ static void add_device_callback(uint8_t status, uint16_t len, const void *param,
 
 static void test_connected_and_advertising(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct generic_data *test = data->test_data;
 	const uint8_t *client_bdaddr;
 	struct mgmt_cp_add_device cp;
 
-	tester_print("Registering %s notification",
+	bttester_print("Registering %s notification",
 					mgmt_evstr(MGMT_EV_DEVICE_CONNECTED));
 
 	test_add_condition(data);
@@ -9911,8 +9921,8 @@ static void test_connected_and_advertising(const void *test_data)
 
 	client_bdaddr = hciemu_get_client_bdaddr(data->hciemu);
 	if (!client_bdaddr) {
-		tester_warn("No client bdaddr");
-		tester_test_failed();
+		bttester_warn("No client bdaddr");
+		l_tester_test_failed(tester);
 		return;
 	}
 
@@ -9942,15 +9952,15 @@ static void read_50_controller_cap_complete(uint8_t status, uint16_t length,
 	uint8_t tag_type;
 
 	if (status || !param) {
-		tester_warn("Failed to read advertising features: %s (0x%02x)",
+		bttester_warn("Read advertising features failed: %s (0x%02x)",
 						mgmt_errstr(status), status);
-		tester_test_failed();
+		l_tester_test_failed(tester);
 	}
 
 	if (sizeof(rp->cap_len) + rp->cap_len != length) {
-		tester_warn("Controller capabilities malformed, size %zu != %u",
+		bttester_warn("Controller capabilities malformed, sz %zu != %u",
 				sizeof(rp->cap_len) + rp->cap_len, length);
-		tester_test_failed();
+		l_tester_test_failed(tester);
 	}
 
 	while (offset < rp->cap_len) {
@@ -9960,11 +9970,12 @@ static void read_50_controller_cap_complete(uint8_t status, uint16_t length,
 		switch (tag_type) {
 		case MGMT_CAP_LE_TX_PWR:
 			if ((tag_len - sizeof(tag_type)) != 2) {
-				tester_warn("TX power had unexpected length %d",
-					tag_len);
+				bttester_warn("TX power unexpected length %d",
+								tag_len);
 				break;
 			}
-			tester_print("Expected Tx Power discovered: %d-%d",
+
+			bttester_print("Expected Tx Power discovered: %d-%d",
 					ptr[offset], ptr[offset+1]);
 			test_condition_complete(data);
 		}
@@ -9976,7 +9987,7 @@ static void read_50_controller_cap_complete(uint8_t status, uint16_t length,
 
 static void test_50_controller_cap_response(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 
 	test_add_condition(data);
 
@@ -9988,7 +9999,7 @@ static void test_50_controller_cap_response(const void *test_data)
 
 int main(int argc, char *argv[])
 {
-	tester_init(&argc, &argv);
+	tester = bttester_init(&argc, &argv);
 
 	test_bredrle("Controller setup",
 				NULL, NULL, controller_setup);
@@ -11615,6 +11626,7 @@ int main(int argc, char *argv[])
 				NULL,
 				test_command_generic);
 
+
 	/* MGMT_OP_GET_DEVICE_FLAGS
 	 * Success
 	 */
@@ -11706,5 +11718,5 @@ int main(int argc, char *argv[])
 				NULL, test_command_generic);
 
 
-	return tester_run();
+	return bttester_run();
 }
-- 
2.26.3

