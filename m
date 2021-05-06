Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC77C433ED
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 May 2021 02:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AFCF613BE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 May 2021 02:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhEFCTk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 May 2021 22:19:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:27114 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231420AbhEFCTj (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 May 2021 22:19:39 -0400
IronPort-SDR: YVoER74ISf7lwLiw56mrUYqN+ipSBbXnrwyhZIXhskqYwYXZnXtI5EbhYOwI3obzn9DkPth7Hr
 P3kw11baCZZA==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="259631563"
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="259631563"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 19:18:42 -0700
IronPort-SDR: tgUQQ2tFU4AoM7Ntkx9hlpo/y5YFVmoaiXChTnrMl79EIsmErLhWQg/McimFJyUJCz1QZWoLKv
 A5z0fsBmjCvQ==
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="469230532"
Received: from zloh1-mobl.gar.corp.intel.com (HELO istotlan-desk.intel.com) ([10.254.6.126])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 19:18:41 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 10/11] tools/rfcomm-tester: Convert to use ELL library
Date:   Wed,  5 May 2021 19:18:16 -0700
Message-Id: <20210506021817.289939-11-inga.stotland@intel.com>
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
 Makefile.tools        |   4 +-
 tools/rfcomm-tester.c | 290 ++++++++++++++++++++++--------------------
 2 files changed, 153 insertions(+), 141 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 3cb3c6e0e..c1fa16e9a 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -128,12 +128,12 @@ tools_l2cap_tester_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-ell.la $(ell_ldadd)
 
 tools_rfcomm_tester_SOURCES = tools/rfcomm-tester.c monitor/bt.h \
-				emulator/hciemu.h emulator/hciemu.c \
+				emulator/hciemu.h emulator/hciemu-ell.c \
 				emulator/btdev.h emulator/btdev.c \
 				emulator/bthost.h emulator/bthost.c \
 				emulator/smp.c
 tools_rfcomm_tester_LDADD = lib/libbluetooth-internal.la \
-				src/libshared-glib.la $(GLIB_LIBS)
+				src/libshared-ell.la $(ell_ldadd)
 
 tools_bnep_tester_SOURCES = tools/bnep-tester.c monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu-ell.c \
diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
index 9bae5b9d5..d6e8c1d9e 100644
--- a/tools/rfcomm-tester.c
+++ b/tools/rfcomm-tester.c
@@ -18,7 +18,7 @@
 #include <errno.h>
 #include <stdbool.h>
 
-#include <glib.h>
+#include <ell/ell.h>
 
 #include "lib/bluetooth.h"
 #include "lib/rfcomm.h"
@@ -28,16 +28,16 @@
 #include "emulator/bthost.h"
 #include "emulator/hciemu.h"
 
-#include "src/shared/tester.h"
+#include "src/shared/bttester.h"
 #include "src/shared/mgmt.h"
 
 struct test_data {
 	struct mgmt *mgmt;
 	uint16_t mgmt_index;
 	struct hciemu *hciemu;
+	struct l_io *io;
 	enum hciemu_type hciemu_type;
 	const void *test_data;
-	unsigned int io_id;
 	uint16_t conn_handle;
 };
 
@@ -59,27 +59,29 @@ struct rfcomm_server_data {
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
 
@@ -88,31 +90,31 @@ static void read_info_callback(uint8_t status, uint16_t length,
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
 
@@ -123,10 +125,10 @@ static void index_added_callback(uint16_t index, uint16_t length,
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
@@ -136,19 +138,19 @@ static void index_removed_callback(uint16_t index, uint16_t length,
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
 
@@ -160,28 +162,28 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 
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
@@ -190,11 +192,11 @@ static void test_pre_setup(const void *test_data)
 
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
 	}
 
 	hciemu_unref(data->hciemu);
@@ -205,7 +207,7 @@ static void test_data_free(void *test_data)
 {
 	struct test_data *data = test_data;
 
-	free(data);
+	l_free(data);
 }
 
 static void client_connectable_complete(uint16_t opcode, uint8_t status,
@@ -219,26 +221,26 @@ static void client_connectable_complete(uint16_t opcode, uint8_t status,
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
@@ -247,10 +249,10 @@ static void setup_powered_client_callback(uint8_t status, uint16_t length,
 
 static void setup_powered_client(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	unsigned char param[] = { 0x01 };
 
-	tester_print("Powering on controller");
+	bttester_print("Powering on controller");
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
 			sizeof(param), param, setup_powered_client_callback,
@@ -261,21 +263,21 @@ static void setup_powered_server_callback(uint8_t status, uint16_t length,
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
 	unsigned char param[] = { 0x01 };
 
-	tester_print("Powering on controller");
+	bttester_print("Powering on controller");
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_CONNECTABLE, data->mgmt_index,
 				sizeof(param), param,
@@ -347,15 +349,15 @@ static void test_basic(const void *test_data)
 
 	sk = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
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
 
 static int create_rfcomm_sock(bdaddr_t *address, uint8_t channel)
@@ -395,44 +397,62 @@ static int connect_rfcomm_sock(int sk, const bdaddr_t *bdaddr, uint8_t channel)
 	return 0;
 }
 
-static gboolean client_received_data(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool client_received_data(struct l_io *io, void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct rfcomm_client_data *cli = data->test_data;
 	int sk;
 	ssize_t ret;
 	char buf[248];
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = l_io_get_fd(io);
 
 	ret = read(sk, buf, cli->data_len);
 	if (cli->data_len != ret) {
-		tester_test_failed();
+		l_tester_test_failed(tester);
 		return false;
 	}
 
 	if (memcmp(cli->read_data, buf, cli->data_len))
-		tester_test_failed();
+		l_tester_test_failed(tester);
 	else
-		tester_test_passed();
+		l_tester_test_passed(tester);
 
 	return false;
 }
 
-static gboolean rc_connect_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static void rc_disconnect_cb(struct l_io *io, void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct rfcomm_client_data *cli = data->test_data;
 	socklen_t len = sizeof(int);
 	int sk, err, sk_err;
 
-	tester_print("Connected");
+	bttester_print("Disconnected");
+
+	sk = l_io_get_fd(io);
 
-	data->io_id = 0;
+	if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &sk_err, &len) < 0)
+		err = -errno;
+	else
+		err = -sk_err;
 
-	sk = g_io_channel_unix_get_fd(io);
+	if (cli->expected_connect_err && err == cli->expected_connect_err)
+		l_tester_test_passed(tester);
+	else
+		l_tester_test_failed(tester);
+}
+
+static bool rc_connect_cb(struct l_io *io, void *user_data)
+{
+	struct test_data *data = l_tester_get_data(tester);
+	const struct rfcomm_client_data *cli = data->test_data;
+	socklen_t len = sizeof(int);
+	int sk, err, sk_err;
+
+	bttester_print("Connected");
+
+	sk = l_io_get_fd(io);
 
 	if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &sk_err, &len) < 0)
 		err = -errno;
@@ -440,25 +460,25 @@ static gboolean rc_connect_cb(GIOChannel *io, GIOCondition cond,
 		err = -sk_err;
 
 	if (cli->expected_connect_err && err == cli->expected_connect_err) {
-		tester_test_passed();
+		l_tester_test_passed(tester);
 		return false;
 	}
 
 	if (cli->send_data) {
 		ssize_t ret;
 
-		tester_print("Writing %u bytes of data", cli->data_len);
+		bttester_print("Writing %u bytes of data", cli->data_len);
 
 		ret = write(sk, cli->send_data, cli->data_len);
 		if (cli->data_len != ret) {
-			tester_warn("Failed to write %u bytes: %s (%d)",
+			bttester_warn("Failed to write %u bytes: %s (%d)",
 					cli->data_len, strerror(errno), errno);
-			tester_test_failed();
+			l_tester_test_failed(tester);
 		}
 
 		return false;
 	} else if (cli->read_data) {
-		g_io_add_watch(io, G_IO_IN, client_received_data, NULL);
+		l_io_set_read_handler(io, client_received_data, NULL, NULL);
 		bthost_send_rfcomm_data(hciemu_client_get_host(data->hciemu),
 						data->conn_handle,
 						cli->client_channel,
@@ -467,9 +487,9 @@ static gboolean rc_connect_cb(GIOChannel *io, GIOCondition cond,
 	}
 
 	if (err < 0)
-		tester_test_failed();
+		l_tester_test_failed(tester);
 	else
-		tester_test_passed();
+		l_tester_test_passed(tester);
 
 	return false;
 }
@@ -477,47 +497,47 @@ static gboolean rc_connect_cb(GIOChannel *io, GIOCondition cond,
 static void client_hook_func(const void *data, uint16_t len,
 							void *user_data)
 {
-	struct test_data *test_data = tester_get_data();
+	struct test_data *test_data = l_tester_get_data(tester);
 	const struct rfcomm_client_data *cli = test_data->test_data;
 	ssize_t ret;
 
-	tester_print("bthost received %u bytes of data", len);
+	bttester_print("bthost received %u bytes of data", len);
 
 	if (cli->data_len != len) {
-		tester_test_failed();
+		l_tester_test_failed(tester);
 		return;
 	}
 
 	ret = memcmp(cli->send_data, data, len);
 	if (ret)
-		tester_test_failed();
+		l_tester_test_failed(tester);
 	else
-		tester_test_passed();
+		l_tester_test_passed(tester);
 }
 
 static void server_hook_func(const void *data, uint16_t len,
 							void *user_data)
 {
-	struct test_data *test_data = tester_get_data();
+	struct test_data *test_data = l_tester_get_data(tester);
 	const struct rfcomm_server_data *srv = test_data->test_data;
 	ssize_t ret;
 
 	if (srv->data_len != len) {
-		tester_test_failed();
+		l_tester_test_failed(tester);
 		return;
 	}
 
 	ret = memcmp(srv->send_data, data, len);
 	if (ret)
-		tester_test_failed();
+		l_tester_test_failed(tester);
 	else
-		tester_test_passed();
+		l_tester_test_passed(tester);
 }
 
 static void rfcomm_connect_cb(uint16_t handle, uint16_t cid,
 						void *user_data, bool status)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct rfcomm_client_data *cli = data->test_data;
 	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
 
@@ -531,11 +551,10 @@ static void rfcomm_connect_cb(uint16_t handle, uint16_t cid,
 
 static void test_connect(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
 	const struct rfcomm_client_data *cli = data->test_data;
 	const uint8_t *client_addr, *master_addr;
-	GIOChannel *io;
 	int sk;
 
 	bthost_add_l2cap_server(bthost, 0x0003, NULL, NULL, NULL);
@@ -550,59 +569,58 @@ static void test_connect(const void *test_data)
 	if (connect_rfcomm_sock(sk, (const bdaddr_t *) client_addr,
 					cli->client_channel) < 0) {
 		close(sk);
-		tester_test_failed();
+		l_tester_test_failed(tester);
 		return;
 	}
 
-	io = g_io_channel_unix_new(sk);
-	g_io_channel_set_close_on_unref(io, TRUE);
+	data->io = l_io_new(sk);
+	l_io_set_close_on_destroy(data->io, true);
+	l_io_set_disconnect_handler(data->io, rc_disconnect_cb, NULL, NULL);
 
-	data->io_id = g_io_add_watch(io, G_IO_OUT, rc_connect_cb, NULL);
-
-	g_io_channel_unref(io);
+	if (!l_io_set_write_handler(data->io, rc_connect_cb, NULL, NULL)) {
+		l_tester_test_failed(tester);
+		return;
+	}
 
-	tester_print("Connect in progress %d", sk);
+	bttester_print("Connect in progress %d", sk);
 }
 
-static gboolean server_received_data(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool server_received_data(struct l_io *io, void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct rfcomm_server_data *srv = data->test_data;
 	char buf[1024];
 	ssize_t ret;
 	int sk;
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = l_io_get_fd(io);
 
 	ret = read(sk, buf, srv->data_len);
 	if (ret != srv->data_len) {
-		tester_test_failed();
+		l_tester_test_failed(tester);
 		return false;
 	}
 
 	if (memcmp(buf, srv->read_data, srv->data_len))
-		tester_test_failed();
+		l_tester_test_failed(tester);
 	else
-		tester_test_passed();
+		l_tester_test_passed(tester);
 
 	return false;
 }
 
-static gboolean rfcomm_listen_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool rfcomm_listen_cb(struct l_io *io, void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct rfcomm_server_data *srv = data->test_data;
 	int sk, new_sk;
 
-	data->io_id = 0;
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = l_io_get_fd(io);
 
 	new_sk = accept(sk, NULL, NULL);
 	if (new_sk < 0) {
-		tester_test_failed();
+		l_tester_test_failed(tester);
 		return false;
 	}
 
@@ -611,26 +629,23 @@ static gboolean rfcomm_listen_cb(GIOChannel *io, GIOCondition cond,
 
 		ret = write(new_sk, srv->send_data, srv->data_len);
 		if (ret != srv->data_len)
-			tester_test_failed();
+			l_tester_test_failed(tester);
 
 		close(new_sk);
 		return false;
 	} else if (srv->read_data) {
-		GIOChannel *new_io;
-
-		new_io = g_io_channel_unix_new(new_sk);
-		g_io_channel_set_close_on_unref(new_io, TRUE);
+		struct l_io *new_io;
 
-		data->io_id = g_io_add_watch(new_io, G_IO_IN,
-						server_received_data, NULL);
+		new_io = l_io_new(new_sk);
+		l_io_set_close_on_destroy(new_io, true);
+		l_io_set_read_handler(new_io, server_received_data, NULL, NULL);
 
-		g_io_channel_unref(new_io);
 		return false;
 	}
 
 	close(new_sk);
 
-	tester_test_passed();
+	l_tester_test_passed(tester);
 
 	return false;
 }
@@ -638,7 +653,7 @@ static gboolean rfcomm_listen_cb(GIOChannel *io, GIOCondition cond,
 static void connection_cb(uint16_t handle, uint16_t cid, void *user_data,
 								bool status)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct rfcomm_server_data *srv = data->test_data;
 	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
 
@@ -653,14 +668,14 @@ static void connection_cb(uint16_t handle, uint16_t cid, void *user_data,
 	}
 
 	if (srv->expected_status == status)
-		tester_test_passed();
+		l_tester_test_passed(tester);
 	else
-		tester_test_failed();
+		l_tester_test_failed(tester);
 }
 
 static void client_new_conn(uint16_t handle, void *user_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct rfcomm_server_data *srv = data->test_data;
 	struct bthost *bthost;
 
@@ -673,36 +688,34 @@ static void client_new_conn(uint16_t handle, void *user_data)
 
 static void test_server(const void *test_data)
 {
-	struct test_data *data = tester_get_data();
+	struct test_data *data = l_tester_get_data(tester);
 	const struct rfcomm_server_data *srv = data->test_data;
 	const uint8_t *master_addr;
 	struct bthost *bthost;
-	GIOChannel *io;
 	int sk;
 
 	master_addr = hciemu_get_master_bdaddr(data->hciemu);
 
 	sk = create_rfcomm_sock((bdaddr_t *) master_addr, srv->server_channel);
 	if (sk < 0) {
-		tester_test_failed();
+		l_tester_test_failed(tester);
 		return;
 	}
 
 	if (listen(sk, 5) < 0) {
-		tester_warn("listening on socket failed: %s (%u)",
-				strerror(errno), errno);
-		tester_test_failed();
+		bttester_warn("listening on socket failed: %s (%u)",
+							strerror(errno), errno);
+		l_tester_test_failed(tester);
 		close(sk);
 		return;
 	}
 
-	io = g_io_channel_unix_new(sk);
-	g_io_channel_set_close_on_unref(io, TRUE);
+	data->io = l_io_new(sk);
+	l_io_set_close_on_destroy(data->io, true);
 
-	data->io_id = g_io_add_watch(io, G_IO_IN, rfcomm_listen_cb, NULL);
-	g_io_channel_unref(io);
+	l_io_set_read_handler(data->io, rfcomm_listen_cb, NULL, NULL);
 
-	tester_print("Listening for connections");
+	bttester_print("Listening for connections");
 
 	bthost = hciemu_client_get_host(data->hciemu);
 	bthost_set_connect_cb(bthost, client_new_conn, data);
@@ -713,20 +726,19 @@ static void test_server(const void *test_data)
 #define test_rfcomm(name, data, setup, func) \
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
 
 	test_rfcomm("Basic RFCOMM Socket - Success", NULL,
 					setup_powered_client, test_basic);
@@ -751,5 +763,5 @@ int main(int argc, char *argv[])
 	test_rfcomm("Basic RFCOMM Socket Server - Conn Refused", &listen_nval,
 					setup_powered_server, test_server);
 
-	return tester_run();
+	return bttester_run();
 }
-- 
2.26.3

