Return-Path: <SRS0=aRPM=EN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE41AC55178
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Nov 2020 07:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2EB2206F9
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Nov 2020 07:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgKGHDf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 7 Nov 2020 02:03:35 -0500
Received: from mga17.intel.com ([192.55.52.151]:45630 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727824AbgKGHDe (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 7 Nov 2020 02:03:34 -0500
IronPort-SDR: urSmjum1t11zBYO6G8DDxlA/T0m63eQL3XFgrhGHb49NGu393dayJ8eIx60P+ldzrdrna8fkU9
 cE5YmeAaU49Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9797"; a="149485521"
X-IronPort-AV: E=Sophos;i="5.77,458,1596524400"; 
   d="scan'208";a="149485521"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 23:03:34 -0800
IronPort-SDR: hLDyrWlfXEYFE5gd6ksV2Etb/m7RwOjRWG8O8o6iCuloA6JEEjS7B6GlaY3c2wYn0Ob/kEF0qF
 DMTVwRy58aNA==
X-IronPort-AV: E=Sophos;i="5.77,458,1596524400"; 
   d="scan'208";a="359032059"
Received: from ralassax-mobl.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.209.101.141])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 23:03:33 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [RFC PATCH BlueZ 10/10] tools/rfcomm-tester: Convert to use ELL library
Date:   Fri,  6 Nov 2020 23:03:12 -0800
Message-Id: <20201107070312.8561-11-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201107070312.8561-1-inga.stotland@intel.com>
References: <20201107070312.8561-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This reworks the source code to use ELL primitives and removes
dependecies on GLib.
---
 Makefile.tools        |  4 +-
 tools/rfcomm-tester.c | 92 ++++++++++++++++++++++++-------------------
 2 files changed, 53 insertions(+), 43 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index e65547c3f..2f86c839c 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -122,12 +122,12 @@ tools_l2cap_tester_LDADD = lib/libbluetooth-internal.la \
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
index 9bae5b9d5..516dd3f82 100644
--- a/tools/rfcomm-tester.c
+++ b/tools/rfcomm-tester.c
@@ -18,7 +18,7 @@
 #include <errno.h>
 #include <stdbool.h>
 
-#include <glib.h>
+#include <ell/ell.h>
 
 #include "lib/bluetooth.h"
 #include "lib/rfcomm.h"
@@ -35,9 +35,9 @@ struct test_data {
 	struct mgmt *mgmt;
 	uint16_t mgmt_index;
 	struct hciemu *hciemu;
+	struct l_io *io;
 	enum hciemu_type hciemu_type;
 	const void *test_data;
-	unsigned int io_id;
 	uint16_t conn_handle;
 };
 
@@ -192,9 +192,9 @@ static void test_post_teardown(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 
-	if (data->io_id > 0) {
-		g_source_remove(data->io_id);
-		data->io_id = 0;
+	if (data->io) {
+		l_io_destroy(data->io);
+		data->io = NULL;
 	}
 
 	hciemu_unref(data->hciemu);
@@ -395,8 +395,7 @@ static int connect_rfcomm_sock(int sk, const bdaddr_t *bdaddr, uint8_t channel)
 	return 0;
 }
 
-static gboolean client_received_data(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool client_received_data(struct l_io *io, void *user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct rfcomm_client_data *cli = data->test_data;
@@ -404,7 +403,7 @@ static gboolean client_received_data(GIOChannel *io, GIOCondition cond,
 	ssize_t ret;
 	char buf[248];
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = l_io_get_fd(io);
 
 	ret = read(sk, buf, cli->data_len);
 	if (cli->data_len != ret) {
@@ -420,19 +419,38 @@ static gboolean client_received_data(GIOChannel *io, GIOCondition cond,
 	return false;
 }
 
-static gboolean rc_connect_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static void rc_disconnect_cb(struct l_io *io, void *user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct rfcomm_client_data *cli = data->test_data;
 	socklen_t len = sizeof(int);
 	int sk, err, sk_err;
 
-	tester_print("Connected");
+	tester_print("Disconnected");
+
+	sk = l_io_get_fd(io);
+
+	if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &sk_err, &len) < 0)
+		err = -errno;
+	else
+		err = -sk_err;
+
+	if (cli->expected_connect_err && err == cli->expected_connect_err)
+		tester_test_passed();
+	else
+		tester_test_failed();
+}
 
-	data->io_id = 0;
+static bool rc_connect_cb(struct l_io *io, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct rfcomm_client_data *cli = data->test_data;
+	socklen_t len = sizeof(int);
+	int sk, err, sk_err;
+
+	tester_print("Connected");
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = l_io_get_fd(io);
 
 	if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &sk_err, &len) < 0)
 		err = -errno;
@@ -458,7 +476,7 @@ static gboolean rc_connect_cb(GIOChannel *io, GIOCondition cond,
 
 		return false;
 	} else if (cli->read_data) {
-		g_io_add_watch(io, G_IO_IN, client_received_data, NULL);
+		l_io_set_read_handler(io, client_received_data, NULL, NULL);
 		bthost_send_rfcomm_data(hciemu_client_get_host(data->hciemu),
 						data->conn_handle,
 						cli->client_channel,
@@ -535,7 +553,6 @@ static void test_connect(const void *test_data)
 	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
 	const struct rfcomm_client_data *cli = data->test_data;
 	const uint8_t *client_addr, *master_addr;
-	GIOChannel *io;
 	int sk;
 
 	bthost_add_l2cap_server(bthost, 0x0003, NULL, NULL, NULL);
@@ -554,18 +571,19 @@ static void test_connect(const void *test_data)
 		return;
 	}
 
-	io = g_io_channel_unix_new(sk);
-	g_io_channel_set_close_on_unref(io, TRUE);
-
-	data->io_id = g_io_add_watch(io, G_IO_OUT, rc_connect_cb, NULL);
+	data->io = l_io_new(sk);
+	l_io_set_close_on_destroy(data->io, true);
+	l_io_set_disconnect_handler(data->io, rc_disconnect_cb, NULL, NULL);
 
-	g_io_channel_unref(io);
+	if (!l_io_set_write_handler(data->io, rc_connect_cb, NULL, NULL)) {
+		tester_test_failed();
+		return;
+	}
 
 	tester_print("Connect in progress %d", sk);
 }
 
-static gboolean server_received_data(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool server_received_data(struct l_io *io, void *user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct rfcomm_server_data *srv = data->test_data;
@@ -573,7 +591,7 @@ static gboolean server_received_data(GIOChannel *io, GIOCondition cond,
 	ssize_t ret;
 	int sk;
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = l_io_get_fd(io);
 
 	ret = read(sk, buf, srv->data_len);
 	if (ret != srv->data_len) {
@@ -589,16 +607,14 @@ static gboolean server_received_data(GIOChannel *io, GIOCondition cond,
 	return false;
 }
 
-static gboolean rfcomm_listen_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool rfcomm_listen_cb(struct l_io *io, void *user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct rfcomm_server_data *srv = data->test_data;
 	int sk, new_sk;
 
-	data->io_id = 0;
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = l_io_get_fd(io);
 
 	new_sk = accept(sk, NULL, NULL);
 	if (new_sk < 0) {
@@ -616,15 +632,12 @@ static gboolean rfcomm_listen_cb(GIOChannel *io, GIOCondition cond,
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
 
@@ -677,7 +690,6 @@ static void test_server(const void *test_data)
 	const struct rfcomm_server_data *srv = data->test_data;
 	const uint8_t *master_addr;
 	struct bthost *bthost;
-	GIOChannel *io;
 	int sk;
 
 	master_addr = hciemu_get_master_bdaddr(data->hciemu);
@@ -696,11 +708,10 @@ static void test_server(const void *test_data)
 		return;
 	}
 
-	io = g_io_channel_unix_new(sk);
-	g_io_channel_set_close_on_unref(io, TRUE);
+	data->io = l_io_new(sk);
+	l_io_set_close_on_destroy(data->io, true);
 
-	data->io_id = g_io_add_watch(io, G_IO_IN, rfcomm_listen_cb, NULL);
-	g_io_channel_unref(io);
+	l_io_set_read_handler(data->io, rfcomm_listen_cb, NULL, NULL);
 
 	tester_print("Listening for connections");
 
@@ -713,12 +724,11 @@ static void test_server(const void *test_data)
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
 		tester_add_full(name, data, \
 				test_pre_setup, setup, func, NULL, \
 				test_post_teardown, 2, user, test_data_free); \
-- 
2.26.2

