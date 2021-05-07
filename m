Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C792C43470
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 May 2021 05:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E821B613ED
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 May 2021 05:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbhEGF5m (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 May 2021 01:57:42 -0400
Received: from mga02.intel.com ([134.134.136.20]:15465 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234379AbhEGF5l (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 May 2021 01:57:41 -0400
IronPort-SDR: F4hKZJc7iADY9LVVEFjy5gnza+4Vavi7FJTBL0EZwZGz2y+qoXimOQKpb7i5EdAz7759Qm6WxH
 Gjw21qtNXHsA==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="185786435"
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="185786435"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 22:56:41 -0700
IronPort-SDR: pRuYXlLyvZFx7LVQmPBqi2ipXkd4/qIvRSdF5UUH9iGWZbN/mfIZuw8+v13m/US/+UdIJMotr3
 72WJJAo5qXAg==
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="407314548"
Received: from jinhuach-mobl1.ccr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.254.7.101])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 22:56:41 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, Inga Stotland <inga.stotland@intel.com>
Subject: [RFC BlueZ v2 05/11] tools/userchan-tester: Convert to use ELL library
Date:   Thu,  6 May 2021 22:56:23 -0700
Message-Id: <20210507055629.338409-6-inga.stotland@intel.com>
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
 Makefile.tools          |   4 +-
 tools/userchan-tester.c | 151 ++++++++++++++++++----------------------
 2 files changed, 70 insertions(+), 85 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index e86a138a7..9193beef8 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -171,12 +171,12 @@ tools_hci_tester_SOURCES = tools/hci-tester.c monitor/bt.h
 tools_hci_tester_LDADD = src/libshared-glib.la $(GLIB_LIBS)
 
 tools_userchan_tester_SOURCES = tools/userchan-tester.c monitor/bt.h \
-				emulator/hciemu.h emulator/hciemu.c \
+				emulator/hciemu.h emulator/hciemu-ell.c \
 				emulator/btdev.h emulator/btdev.c \
 				emulator/bthost.h emulator/bthost.c \
 				emulator/smp.c
 tools_userchan_tester_LDADD = lib/libbluetooth-internal.la \
-				src/libshared-glib.la $(GLIB_LIBS)
+				src/libshared-ell.la $(ell_ldadd)
 endif
 
 if TOOLS
diff --git a/tools/userchan-tester.c b/tools/userchan-tester.c
index c17644fb8..abae52a36 100644
--- a/tools/userchan-tester.c
+++ b/tools/userchan-tester.c
@@ -12,26 +12,18 @@
 #include <config.h>
 #endif
 
-#include <stdlib.h>
-#include <stdint.h>
-#include <unistd.h>
-#include <errno.h>
-#include <stdbool.h>
-
-#include <glib.h>
+#include <ell/ell.h>
 
 #include "lib/bluetooth.h"
 #include "lib/hci.h"
 #include "lib/mgmt.h"
 
-#include "monitor/bt.h"
 #include "emulator/bthost.h"
 #include "emulator/hciemu.h"
 
-#include "src/shared/tester.h"
+#include "src/shared/bttester.h"
 #include "src/shared/mgmt.h"
 #include "src/shared/hci.h"
-#include "src/shared/util.h"
 
 struct test_data {
 	struct mgmt *mgmt;
@@ -42,27 +34,29 @@ struct test_data {
 	unsigned int remove_id;
 };
 
+static struct l_tester *tester;
+
 static void mgmt_debug(const char *str, void *user_data)
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
 
@@ -71,31 +65,29 @@ static void read_info_callback(uint8_t status, uint16_t length,
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
-
-	if (strcmp(hciemu_get_address(data->hciemu), addr)) {
-		tester_pre_setup_failed();
-		return;
-	}
+	bttester_print("  Name: %s", rp->name);
+	bttester_print("  Short name: %s", rp->short_name);
 
-	tester_pre_setup_complete();
+	if (strcmp(hciemu_get_address(data->hciemu), addr))
+		l_tester_pre_setup_failed(tester);
+	else
+		l_tester_pre_setup_complete(tester);
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
 
 	if (data->mgmt_index != MGMT_INDEX_NONE)
 		return;
@@ -109,10 +101,10 @@ static void index_added_callback(uint16_t index, uint16_t length,
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
@@ -120,7 +112,7 @@ static void index_removed_callback(uint16_t index, uint16_t length,
 	if (data->remove_id) {
 		mgmt_unregister(data->mgmt, data->remove_id);
 		data->remove_id = 0;
-		tester_test_passed();
+		l_tester_test_passed(tester);
 		return;
 	}
 
@@ -129,19 +121,19 @@ static void index_removed_callback(uint16_t index, uint16_t length,
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
 
@@ -150,25 +142,25 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 
 	data->hciemu = hciemu_new(data->hciemu_type);
 	if (!data->hciemu) {
-		tester_warn("Failed to setup HCI emulation");
-		tester_pre_setup_failed();
+		bttester_warn("Failed to setup HCI emulation");
+		l_tester_pre_setup_failed(tester);
 	}
 
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
 		mgmt_set_debug(data->mgmt, mgmt_debug, "mgmt: ", NULL);
 
 	mgmt_send(data->mgmt, MGMT_OP_READ_INDEX_LIST, MGMT_INDEX_NONE, 0, NULL,
@@ -177,7 +169,7 @@ static void test_pre_setup(const void *test_data)
 
 static void test_post_teardown(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 
 	mgmt_register(data->mgmt, MGMT_EV_INDEX_REMOVED, data->mgmt_index,
 					index_removed_callback,
@@ -187,32 +179,25 @@ static void test_post_teardown(const void *test_data)
 	data->hciemu = NULL;
 }
 
-static void test_data_free(void *test_data)
-{
-	struct test_data *data = test_data;
-
-	free(data);
-}
-
 static void setup_powered_client_callback(uint8_t status, uint16_t length,
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
 
 static void setup_powered(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	unsigned char param[] = { 0x01 };
 
-	tester_print("Powering on controller");
+	bttester_print("Powering on controller");
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
 			sizeof(param), param, setup_powered_client_callback,
@@ -224,39 +209,39 @@ static void toggle_powered(const void *test_data);
 static void toggle_powered_client_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
-	bool power = PTR_TO_INT(user_data);
+	uint32_t power = L_PTR_TO_UINT(user_data);
 
 	if (status != MGMT_STATUS_SUCCESS) {
-		tester_setup_failed();
+		l_tester_setup_failed(tester);
 		return;
 	}
 
-	tester_print("Controller powered %s", power ? "on" : "off");
+	bttester_print("Controller powered %s", power ? "on" : "off");
 
 	if (power)
 		toggle_powered(false);
 	else
-		tester_setup_complete();
+		l_tester_setup_complete(tester);
 }
 
 static void toggle_powered(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
-	bool power = PTR_TO_INT(test_data);
+	struct test_data *data = l_tester_get_data(tester);
+	uint32_t power = L_PTR_TO_UINT(test_data);
 	unsigned char param[1];
 
-	param[0] = power ? 0x01 : 0x00;
+	param[0] = power;
 
-	tester_print("Powering %s controller", power ? "on" : "off");
+	bttester_print("Powering %s controller", power != 0 ? "on" : "off");
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
 			sizeof(param), param, toggle_powered_client_callback,
-			INT_TO_PTR(power), NULL);
+			L_UINT_TO_PTR(power), NULL);
 }
 
 static void test_open_success(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	struct bt_hci *hci;
 
 	data->remove_id = mgmt_register(data->mgmt, MGMT_EV_INDEX_REMOVED,
@@ -273,49 +258,49 @@ static void test_open_success(const void *test_data)
 	mgmt_unregister(data->mgmt, data->remove_id);
 	data->remove_id = 0;
 
-	tester_test_failed();
+	l_tester_test_failed(tester);
 }
 
 static void test_open_failed(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	struct bt_hci *hci;
 
 	hci = bt_hci_new_user_channel(data->mgmt_index);
 	if (!hci) {
-		tester_test_passed();
+		l_tester_test_passed(tester);
 		return;
 	}
 
 	bt_hci_unref(hci);
-	tester_test_failed();
+	l_tester_test_failed(tester);
 }
 
 #define test_user(name, data, setup, func) \
 	do { \
 		struct test_data *user; \
-		user = malloc(sizeof(struct test_data)); \
+		user = l_malloc(sizeof(struct test_data)); \
 		if (!user) \
 			break; \
 		user->hciemu_type = HCIEMU_TYPE_BREDR; \
 		user->mgmt_index = MGMT_INDEX_NONE; \
 		user->test_data = data; \
 		user->remove_id = 0; \
-		tester_add_full(name, data, \
-				test_pre_setup, setup, func, NULL, \
-				test_post_teardown, 2, user, test_data_free); \
+		l_tester_add_full(tester, name, data, test_pre_setup, setup, \
+					func, NULL, test_post_teardown, 2,\
+					user, l_free); \
 	} while (0)
 
 int main(int argc, char *argv[])
 {
-	tester_init(&argc, &argv);
+	tester = bttester_init(&argc, &argv);
 
 	test_user("User channel open - Success", NULL,
 					NULL, test_open_success);
 	test_user("User channel open - Failed", NULL,
 					setup_powered, test_open_failed);
-	test_user("User channel open - Power Toggle Success", INT_TO_PTR(true),
-					toggle_powered, test_open_success);
+	test_user("User channel open - Power Toggle Success",
+			L_UINT_TO_PTR(0x1), toggle_powered, test_open_success);
 
-	return tester_run();
+	return bttester_run();
 }
-- 
2.26.3

