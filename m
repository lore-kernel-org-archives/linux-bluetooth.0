Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BDEC48BCD
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Jun 2021 06:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19EA561107
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Jun 2021 06:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhFFGjT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Jun 2021 02:39:19 -0400
Received: from mga18.intel.com ([134.134.136.126]:34607 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230104AbhFFGjT (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Jun 2021 02:39:19 -0400
IronPort-SDR: TuUPKYNYzjk5Lh0LXjcPfxPTkAVa6LMj5sVHdcKQKdF02GwPfBppQOwCdCKbMNrm/oNHFvKess
 +GstdyOET8sg==
X-IronPort-AV: E=McAfee;i="6200,9189,10006"; a="191815313"
X-IronPort-AV: E=Sophos;i="5.83,252,1616482800"; 
   d="scan'208";a="191815313"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2021 23:37:30 -0700
IronPort-SDR: uhZUJRUEW4q9gMzGodJUWB89vSFUVM1STISfOGhTXAG9Vsaph1z1u+YLg7cUQwJecRB/lpp7Us
 XgY6E9b4yOow==
X-IronPort-AV: E=Sophos;i="5.83,252,1616482800"; 
   d="scan'208";a="481160895"
Received: from skambhat-mobl.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.209.68.161])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2021 23:37:29 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, tedd.an@intel.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 04/11] tools/sco-tester: Convert to use ELL library
Date:   Sat,  5 Jun 2021 23:37:12 -0700
Message-Id: <20210606063719.339794-5-inga.stotland@intel.com>
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
 tools/sco-tester.c | 231 ++++++++++++++++++++++-----------------------
 2 files changed, 116 insertions(+), 119 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 55674ca55..e86a138a7 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -160,12 +160,12 @@ tools_gap_tester_LDADD =  lib/libbluetooth-internal.la \
 				src/libshared-ell.la $(ell_ldadd)
 
 tools_sco_tester_SOURCES = tools/sco-tester.c monitor/bt.h \
-				emulator/hciemu.h emulator/hciemu.c \
+				emulator/hciemu.h emulator/hciemu-ell.c \
 				emulator/btdev.h emulator/btdev.c \
 				emulator/bthost.h emulator/bthost.c \
 				emulator/smp.c
 tools_sco_tester_LDADD = lib/libbluetooth-internal.la \
-				src/libshared-glib.la $(GLIB_LIBS)
+				src/libshared-ell.la $(ell_ldadd)
 
 tools_hci_tester_SOURCES = tools/hci-tester.c monitor/bt.h
 tools_hci_tester_LDADD = src/libshared-glib.la $(GLIB_LIBS)
diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index 2b8dc0d4a..1038fb3dd 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+// spdx-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
@@ -17,7 +17,7 @@
 #include <errno.h>
 #include <stdbool.h>
 
-#include <glib.h>
+#include <ell/ell.h>
 
 #include "lib/bluetooth.h"
 #include "lib/sco.h"
@@ -27,7 +27,7 @@
 #include "emulator/bthost.h"
 #include "emulator/hciemu.h"
 
-#include "src/shared/tester.h"
+#include "src/shared/bttester.h"
 #include "src/shared/mgmt.h"
 
 struct test_data {
@@ -36,7 +36,7 @@ struct test_data {
 	uint16_t mgmt_index;
 	struct hciemu *hciemu;
 	enum hciemu_type hciemu_type;
-	unsigned int io_id;
+	struct l_io *io;
 	bool disable_esco;
 };
 
@@ -44,27 +44,29 @@ struct sco_client_data {
 	int expect_err;
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
 
@@ -73,31 +75,31 @@ static void read_info_callback(uint8_t status, uint16_t length,
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
 
@@ -108,10 +110,10 @@ static void index_added_callback(uint16_t index, uint16_t length,
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
@@ -121,19 +123,19 @@ static void index_removed_callback(uint16_t index, uint16_t length,
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
 
@@ -145,20 +147,20 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 
 	data->hciemu = hciemu_new(HCIEMU_TYPE_BREDRLE);
 	if (!data->hciemu) {
-		tester_warn("Failed to setup HCI emulation");
-		tester_pre_setup_failed();
+		bttester_warn("Failed to setup HCI emulation");
+		l_tester_pre_setup_failed(tester);
 		return;
 	}
 
-	if (tester_use_debug())
+	if (bttester_use_debug())
 		hciemu_set_debug(data->hciemu, print_debug, "hciemu: ", NULL);
 
-	tester_print("New hciemu instance created");
+	bttester_print("New hciemu instance created");
 
 	if (data->disable_esco) {
 		uint8_t *features;
 
-		tester_print("Disabling eSCO packet type support");
+		bttester_print("Disabling eSCO packet type support");
 
 		features = hciemu_get_features(data->hciemu);
 		if (features)
@@ -168,16 +170,16 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 
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
@@ -186,7 +188,7 @@ static void test_pre_setup(const void *test_data)
 
 static void test_post_teardown(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 
 	hciemu_unref(data->hciemu);
 	data->hciemu = NULL;
@@ -196,25 +198,26 @@ static void test_data_free(void *test_data)
 {
 	struct test_data *data = test_data;
 
-	if (data->io_id > 0)
-		g_source_remove(data->io_id);
+	if (data->io) {
+		l_io_destroy(data->io);
+		data->io = NULL;
+	}
 
-	free(data);
+	l_free(data);
 }
 
 #define test_sco_full(name, data, setup, func, _disable_esco) \
 	do { \
 		struct test_data *user; \
-		user = malloc(sizeof(struct test_data)); \
+		user = l_new(struct test_data, 1); \
 		if (!user) \
 			break; \
 		user->hciemu_type = HCIEMU_TYPE_BREDRLE; \
-		user->io_id = 0; \
 		user->test_data = data; \
 		user->disable_esco = _disable_esco; \
-		tester_add_full(name, data, \
-				test_pre_setup, setup, func, NULL, \
-				test_post_teardown, 2, user, test_data_free); \
+		l_tester_add_full(tester, name, data, test_pre_setup, setup, \
+					func, NULL, test_post_teardown, 2, \
+					user, test_data_free); \
 	} while (0)
 
 #define test_sco(name, data, setup, func) \
@@ -238,26 +241,26 @@ static void client_connectable_complete(uint16_t opcode, uint8_t status,
 	if (opcode != BT_HCI_CMD_WRITE_SCAN_ENABLE)
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
 
 static void setup_powered_callback(uint8_t status, uint16_t length,
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
@@ -266,10 +269,10 @@ static void setup_powered_callback(uint8_t status, uint16_t length,
 
 static void setup_powered(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	unsigned char param[] = { 0x01 };
 
-	tester_print("Powering on controller");
+	bttester_print("Powering on controller");
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_CONNECTABLE, data->mgmt_index,
 					sizeof(param), param,
@@ -288,7 +291,7 @@ static void setup_powered(const void *test_data)
 
 static void test_framework(const void *test_data)
 {
-	tester_test_passed();
+	l_tester_test_passed(tester);
 }
 
 static void test_socket(const void *test_data)
@@ -297,15 +300,15 @@ static void test_socket(const void *test_data)
 
 	sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_SCO);
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
 
 static void test_getsockopt(const void *test_data)
@@ -316,9 +319,9 @@ static void test_getsockopt(const void *test_data)
 
 	sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_SCO);
 	if (sk < 0) {
-		tester_warn("Can't create socket: %s (%d)", strerror(errno),
+		bttester_warn("Can't create socket: %s (%d)", strerror(errno),
 									errno);
-		tester_test_failed();
+		l_tester_test_failed(tester);
 		return;
 	}
 
@@ -327,19 +330,19 @@ static void test_getsockopt(const void *test_data)
 
 	err = getsockopt(sk, SOL_BLUETOOTH, BT_VOICE, &voice, &len);
 	if (err < 0) {
-		tester_warn("Can't get socket option : %s (%d)",
+		bttester_warn("Can't get socket option : %s (%d)",
 							strerror(errno), errno);
-		tester_test_failed();
+		l_tester_test_failed(tester);
 		goto end;
 	}
 
 	if (voice.setting != BT_VOICE_CVSD_16BIT) {
-		tester_warn("Invalid voice setting");
-		tester_test_failed();
+		bttester_warn("Invalid voice setting");
+		l_tester_test_failed(tester);
 		goto end;
 	}
 
-	tester_test_passed();
+	l_tester_test_passed(tester);
 
 end:
 	close(sk);
@@ -353,9 +356,9 @@ static void test_setsockopt(const void *test_data)
 
 	sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_SCO);
 	if (sk < 0) {
-		tester_warn("Can't create socket: %s (%d)", strerror(errno),
+		bttester_warn("Can't create socket: %s (%d)", strerror(errno),
 									errno);
-		tester_test_failed();
+		l_tester_test_failed(tester);
 		goto end;
 	}
 
@@ -365,15 +368,15 @@ static void test_setsockopt(const void *test_data)
 
 	err = getsockopt(sk, SOL_BLUETOOTH, BT_VOICE, &voice, &len);
 	if (err < 0) {
-		tester_warn("Can't get socket option : %s (%d)",
+		bttester_warn("Can't get socket option : %s (%d)",
 							strerror(errno), errno);
-		tester_test_failed();
+		l_tester_test_failed(tester);
 		goto end;
 	}
 
 	if (voice.setting != BT_VOICE_CVSD_16BIT) {
-		tester_warn("Invalid voice setting");
-		tester_test_failed();
+		bttester_warn("Invalid voice setting");
+		l_tester_test_failed(tester);
 		goto end;
 	}
 
@@ -382,9 +385,9 @@ static void test_setsockopt(const void *test_data)
 
 	err = setsockopt(sk, SOL_BLUETOOTH, BT_VOICE, &voice, sizeof(voice));
 	if (err < 0) {
-		tester_warn("Can't set socket option : %s (%d)",
+		bttester_warn("Can't set socket option : %s (%d)",
 							strerror(errno), errno);
-		tester_test_failed();
+		l_tester_test_failed(tester);
 		goto end;
 	}
 
@@ -393,19 +396,19 @@ static void test_setsockopt(const void *test_data)
 
 	err = getsockopt(sk, SOL_BLUETOOTH, BT_VOICE, &voice, &len);
 	if (err < 0) {
-		tester_warn("Can't get socket option : %s (%d)",
+		bttester_warn("Can't get socket option : %s (%d)",
 							strerror(errno), errno);
-		tester_test_failed();
+		l_tester_test_failed(tester);
 		goto end;
 	}
 
 	if (voice.setting != BT_VOICE_TRANSPARENT) {
-		tester_warn("Invalid voice setting");
-		tester_test_failed();
+		bttester_warn("Invalid voice setting");
+		l_tester_test_failed(tester);
 		goto end;
 	}
 
-	tester_test_passed();
+	l_tester_test_passed(tester);
 
 end:
 	close(sk);
@@ -421,14 +424,14 @@ static int create_sco_sock(struct test_data *data)
 								BTPROTO_SCO);
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
 		return -ENODEV;
 	}
 
@@ -438,7 +441,7 @@ static int create_sco_sock(struct test_data *data)
 
 	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
 		err = -errno;
-		tester_warn("Can't bind socket: %s (%d)", strerror(errno),
+		bttester_warn("Can't bind socket: %s (%d)", strerror(errno),
 									errno);
 		close(sk);
 		return err;
@@ -455,7 +458,7 @@ static int connect_sco_sock(struct test_data *data, int sk)
 
 	client_bdaddr = hciemu_get_client_bdaddr(data->hciemu);
 	if (!client_bdaddr) {
-		tester_warn("No client bdaddr");
+		bttester_warn("No client bdaddr");
 		return -ENODEV;
 	}
 
@@ -466,7 +469,7 @@ static int connect_sco_sock(struct test_data *data, int sk)
 	err = connect(sk, (struct sockaddr *) &addr, sizeof(addr));
 	if (err < 0 && !(errno == EAGAIN || errno == EINPROGRESS)) {
 		err = -errno;
-		tester_warn("Can't connect socket: %s (%d)", strerror(errno),
+		bttester_warn("Can't connect socket: %s (%d)", strerror(errno),
 									errno);
 		return err;
 	}
@@ -474,17 +477,14 @@ static int connect_sco_sock(struct test_data *data, int sk)
 	return 0;
 }
 
-static gboolean sco_connect_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool sco_connect_cb(struct l_io *io, void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct sco_client_data *scodata = data->test_data;
 	int err, sk_err, sk;
 	socklen_t len = sizeof(sk_err);
 
-	data->io_id = 0;
-
-	sk = g_io_channel_unix_get_fd(io);
+	sk = l_io_get_fd(io);
 
 	if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &sk_err, &len) < 0)
 		err = -errno;
@@ -492,56 +492,53 @@ static gboolean sco_connect_cb(GIOChannel *io, GIOCondition cond,
 		err = -sk_err;
 
 	if (err < 0)
-		tester_warn("Connect failed: %s (%d)", strerror(-err), -err);
+		bttester_warn("Connect failed: %s (%d)", strerror(-err), -err);
 	else
-		tester_print("Successfully connected");
+		bttester_print("Successfully connected");
 
 	if (-err != scodata->expect_err)
-		tester_test_failed();
+		l_tester_test_failed(tester);
 	else
-		tester_test_passed();
+		l_tester_test_passed(tester);
 
-	return FALSE;
+	return false;
 }
 
 static void test_connect(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
-	GIOChannel *io;
+	struct test_data *data = l_tester_get_data(tester);
 	int sk;
 
 	sk = create_sco_sock(data);
 	if (sk < 0) {
-		tester_test_failed();
+		l_tester_test_failed(tester);
 		return;
 	}
 
 	if (connect_sco_sock(data, sk) < 0) {
 		close(sk);
-		tester_test_failed();
+		l_tester_test_failed(tester);
 		return;
 	}
 
-	io = g_io_channel_unix_new(sk);
-	g_io_channel_set_close_on_unref(io, TRUE);
-
-	data->io_id = g_io_add_watch(io, G_IO_OUT, sco_connect_cb, NULL);
+	data->io = l_io_new(sk);
+	l_io_set_close_on_destroy(data->io, true);
 
-	g_io_channel_unref(io);
+	l_io_set_write_handler(data->io, sco_connect_cb, NULL, NULL);
 
-	tester_print("Connect in progress");
+	bttester_print("Connect in progress");
 }
 
 static void test_connect_transp(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct sco_client_data *scodata = data->test_data;
 	int sk, err;
 	struct bt_voice voice;
 
 	sk = create_sco_sock(data);
 	if (sk < 0) {
-		tester_test_failed();
+		l_tester_test_failed(tester);
 		return;
 	}
 
@@ -550,22 +547,22 @@ static void test_connect_transp(const void *test_data)
 
 	err = setsockopt(sk, SOL_BLUETOOTH, BT_VOICE, &voice, sizeof(voice));
 	if (err < 0) {
-		tester_warn("Can't set socket option : %s (%d)",
+		bttester_warn("Can't set socket option : %s (%d)",
 							strerror(errno), errno);
-		tester_test_failed();
+		l_tester_test_failed(tester);
 		goto end;
 	}
 
 	err = connect_sco_sock(data, sk);
 
-	tester_warn("Connect returned %s (%d), expected %s (%d)",
-			strerror(-err), -err,
-			strerror(scodata->expect_err), scodata->expect_err);
+	bttester_warn("Connect returned %s (%d), expected %s (%d)",
+								strerror(-err),
+		-err, strerror(scodata->expect_err), scodata->expect_err);
 
 	if (-err != scodata->expect_err)
-		tester_test_failed();
+		l_tester_test_failed(tester);
 	else
-		tester_test_passed();
+		l_tester_test_passed(tester);
 
 end:
 	close(sk);
@@ -573,7 +570,7 @@ end:
 
 int main(int argc, char *argv[])
 {
-	tester_init(&argc, &argv);
+	tester = bttester_init(&argc, &argv);
 
 	test_sco("Basic Framework - Success", NULL, setup_powered,
 							test_framework);
@@ -599,5 +596,5 @@ int main(int argc, char *argv[])
 	test_sco_11("SCO mSBC 1.1 - Failure", &connect_failure, setup_powered,
 							test_connect_transp);
 
-	return tester_run();
+	return bttester_run();
 }
-- 
2.26.3

