Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B665C43461
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 May 2021 05:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A5D86128B
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 May 2021 05:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbhEGF5q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 May 2021 01:57:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:15465 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234382AbhEGF5m (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 May 2021 01:57:42 -0400
IronPort-SDR: 77VsKEZlW0DgcduPTtayplWzF+5++RVDa6qf6rVW/ItUKxBC7Mhm0rNaAz2b9Y7V/+icr2gWlE
 jHSpSUyD/fVg==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="185786439"
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="185786439"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 22:56:42 -0700
IronPort-SDR: VKOqViFtm/y0zP+/RAP12pvv6PpJsA4kScpRTPBoQj+KOU+ZChYIeKDx9M50NEYoOz8Di3Jh8F
 Q2TQh2ZKBizQ==
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="407314562"
Received: from jinhuach-mobl1.ccr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.254.7.101])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 22:56:42 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, Inga Stotland <inga.stotland@intel.com>
Subject: [RFC BlueZ v2 07/11] tools/bnep-tester: Convert to use ELL library
Date:   Thu,  6 May 2021 22:56:25 -0700
Message-Id: <20210507055629.338409-8-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210507055629.338409-1-inga.stotland@intel.com>
References: <20210507055629.338409-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This reworks the source code to use ELL primitives and removes
dependecies on GLib.
---
 Makefile.tools      |   4 +-
 tools/bnep-tester.c | 115 +++++++++++++++++++++-----------------------
 2 files changed, 57 insertions(+), 62 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 77b8d5512..7b3619f16 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -136,12 +136,12 @@ tools_rfcomm_tester_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-glib.la $(GLIB_LIBS)
 
 tools_bnep_tester_SOURCES = tools/bnep-tester.c monitor/bt.h \
-				emulator/hciemu.h emulator/hciemu.c \
+				emulator/hciemu.h emulator/hciemu-ell.c \
 				emulator/btdev.h emulator/btdev.c \
 				emulator/bthost.h emulator/bthost.c \
 				emulator/smp.c
 tools_bnep_tester_LDADD = lib/libbluetooth-internal.la \
-				src/libshared-glib.la $(GLIB_LIBS)
+				src/libshared-ell.la $(ell_ldadd)
 
 tools_smp_tester_SOURCES = tools/smp-tester.c monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu-ell.c \
diff --git a/tools/bnep-tester.c b/tools/bnep-tester.c
index 5e4d7fb6d..8fb21204b 100644
--- a/tools/bnep-tester.c
+++ b/tools/bnep-tester.c
@@ -18,7 +18,7 @@
 #include <errno.h>
 #include <stdbool.h>
 
-#include <glib.h>
+#include <ell/ell.h>
 
 #include "lib/bluetooth.h"
 #include "lib/bnep.h"
@@ -28,7 +28,7 @@
 #include "emulator/bthost.h"
 #include "emulator/hciemu.h"
 
-#include "src/shared/tester.h"
+#include "src/shared/bttester.h"
 #include "src/shared/mgmt.h"
 
 struct test_data {
@@ -37,7 +37,6 @@ struct test_data {
 	struct hciemu *hciemu;
 	enum hciemu_type hciemu_type;
 	const void *test_data;
-	unsigned int io_id;
 	uint16_t conn_handle;
 };
 
@@ -59,27 +58,29 @@ struct rfcomm_server_data {
 	uint16_t data_len;
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
 
@@ -88,31 +89,31 @@ static void read_info_callback(uint8_t status, uint16_t length,
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
 
@@ -123,10 +124,10 @@ static void index_added_callback(uint16_t index, uint16_t length,
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
@@ -136,19 +137,19 @@ static void index_removed_callback(uint16_t index, uint16_t length,
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
 
@@ -160,28 +161,28 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 
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
@@ -190,12 +191,7 @@ static void test_pre_setup(const void *test_data)
 
 static void test_post_teardown(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
-
-	if (data->io_id > 0) {
-		g_source_remove(data->io_id);
-		data->io_id = 0;
-	}
+	struct test_data *data = l_tester_get_data(tester);
 
 	hciemu_unref(data->hciemu);
 	data->hciemu = NULL;
@@ -205,7 +201,7 @@ static void test_data_free(void *test_data)
 {
 	struct test_data *data = test_data;
 
-	free(data);
+	l_free(data);
 }
 
 static void client_connectable_complete(uint16_t opcode, uint8_t status,
@@ -219,26 +215,26 @@ static void client_connectable_complete(uint16_t opcode, uint8_t status,
 		return;
 	}
 
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
@@ -247,10 +243,10 @@ static void setup_powered_client_callback(uint8_t status, uint16_t length,
 
 static void setup_powered_client(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	unsigned char param[] = { 0x01 };
 
-	tester_print("Powering on controller");
+	bttester_print("Powering on controller");
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
 			sizeof(param), param, setup_powered_client_callback,
@@ -263,37 +259,36 @@ static void test_basic(const void *test_data)
 
 	sk = socket(PF_BLUETOOTH, SOCK_RAW, BTPROTO_BNEP);
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
 
 #define test_bnep(name, data, setup, func) \
 	do { \
 		struct test_data *user; \
-		user = malloc(sizeof(struct test_data)); \
+		user = l_new(struct test_data, 1);	\
 		if (!user) \
 			break; \
 		user->hciemu_type = HCIEMU_TYPE_BREDR; \
 		user->test_data = data; \
-		user->io_id = 0; \
-		tester_add_full(name, data, \
+		l_tester_add_full(tester, name, data,		   \
 				test_pre_setup, setup, func, NULL, \
 				test_post_teardown, 2, user, test_data_free); \
 	} while (0)
 
 int main(int argc, char *argv[])
 {
-	tester_init(&argc, &argv);
+	tester = bttester_init(&argc, &argv);
 
 	test_bnep("Basic BNEP Socket - Success", NULL,
 					setup_powered_client, test_basic);
 
-	return tester_run();
+	return bttester_run();
 }
-- 
2.26.3

