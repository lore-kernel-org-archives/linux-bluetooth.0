Return-Path: <SRS0=aRPM=EN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF97C388F9
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Nov 2020 07:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C03C206F9
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Nov 2020 07:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgKGHDd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 7 Nov 2020 02:03:33 -0500
Received: from mga17.intel.com ([192.55.52.151]:45630 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727824AbgKGHDd (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 7 Nov 2020 02:03:33 -0500
IronPort-SDR: Tz0jnWBf2nfLC+eRgZVnEqoeHHf4oCmR/wn6v6D/m1A10ErZnKH44gzGlrEMBeNIaMw+S2g9eM
 OHhTw/01iNdQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9797"; a="149485519"
X-IronPort-AV: E=Sophos;i="5.77,458,1596524400"; 
   d="scan'208";a="149485519"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 23:03:32 -0800
IronPort-SDR: 5b/2SMd6848e64ieRgIrVRuCGN/c6C2+uLv4Ropb1f9inZRyir5TJP/+cMJDzez0kMk3ZkTXij
 dOHCjETtfb1w==
X-IronPort-AV: E=Sophos;i="5.77,458,1596524400"; 
   d="scan'208";a="359032050"
Received: from ralassax-mobl.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.209.101.141])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 23:03:32 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [RFC PATCH BlueZ 08/10] tools/l2cap-tester: Convert to use ELL library
Date:   Fri,  6 Nov 2020 23:03:10 -0800
Message-Id: <20201107070312.8561-9-inga.stotland@intel.com>
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
 Makefile.tools       |   4 +-
 tools/l2cap-tester.c | 256 +++++++++++++++++++++----------------------
 2 files changed, 130 insertions(+), 130 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 8c79a528d..03264cff9 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -114,12 +114,12 @@ tools_mgmt_tester_LDADD = lib/libbluetooth-internal.la \
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
index ff641ba1d..6f55cf6f2 100644
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
@@ -218,9 +220,14 @@ static void test_post_teardown(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 
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
@@ -230,18 +237,16 @@ static void test_post_teardown(const void *test_data)
 static void test_data_free(void *test_data)
 {
 	struct test_data *data = test_data;
-
-	free(data);
+	l_free(data);
 }
 
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
 		tester_add_full(name, data, \
 				test_pre_setup, setup, func, NULL, \
@@ -251,11 +256,10 @@ static void test_data_free(void *test_data)
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
 		tester_add_full(name, data, \
 				test_pre_setup, setup, func, NULL, \
@@ -886,19 +890,18 @@ static void test_basic(const void *test_data)
 	tester_test_passed();
 }
 
-static gboolean client_received_data(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool client_received_data(struct l_io *io, void *user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct l2cap_data *l2data = data->test_data;
 	char buf[1024];
 	int sk;
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = l_io_get_fd(io);
 	if (read(sk, buf, l2data->data_len) != l2data->data_len) {
 		tester_warn("Unable to read %u bytes", l2data->data_len);
 		tester_test_failed();
-		return FALSE;
+		return false;
 	}
 
 	if (memcmp(buf, l2data->read_data, l2data->data_len))
@@ -906,22 +909,22 @@ static gboolean client_received_data(GIOChannel *io, GIOCondition cond,
 	else
 		tester_test_passed();
 
-	return FALSE;
+	return true;
 }
 
-static gboolean server_received_data(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool server_received_data(struct l_io *io, void *user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct l2cap_data *l2data = data->test_data;
 	char buf[1024];
 	int sk;
 
-	sk = g_io_channel_unix_get_fd(io);
+	sk = l_io_get_fd(io);
 	if (read(sk, buf, l2data->data_len) != l2data->data_len) {
 		tester_warn("Unable to read %u bytes", l2data->data_len);
 		tester_test_failed();
-		return FALSE;
+		l_io_destroy(io);
+		return false;
 	}
 
 	if (memcmp(buf, l2data->read_data, l2data->data_len))
@@ -929,7 +932,9 @@ static gboolean server_received_data(GIOChannel *io, GIOCondition cond,
 	else
 		tester_test_passed();
 
-	return FALSE;
+	l_io_destroy(io);
+
+	return true;
 }
 
 static void bthost_received_data(const void *buf, uint16_t len,
@@ -966,27 +971,6 @@ static void server_bthost_received_data(const void *buf, uint16_t len,
 		tester_test_passed();
 }
 
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
-}
-
 static bool check_mtu(struct test_data *data, int sk)
 {
 	const struct l2cap_data *l2data = data->test_data;
@@ -1029,17 +1013,52 @@ static bool check_mtu(struct test_data *data, int sk)
 	return true;
 }
 
-static gboolean l2cap_connect_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static void l2cap_disconnect_cb(struct l_io *io, void *user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct l2cap_data *l2data = data->test_data;
 	int err, sk_err, sk;
 	socklen_t len = sizeof(sk_err);
 
-	data->io_id = 0;
+	tester_print("Disconnect callback");
+	if (l2data->shut_sock_wr) {
+		/* if socket is closed using SHUT_WR, L2CAP disconnection
+		 * response must be received first before EPOLLHUP event.
+		 */
+		if (data->host_disconnected)
+			tester_test_passed();
+		else {
+			tester_warn("HUP received before L2CAP disconnection");
+			tester_test_failed();
+		}
+
+		return;
+	}
+
+	sk = l_io_get_fd(io);
 
-	sk = g_io_channel_unix_get_fd(io);
+	if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &sk_err, &len) < 0)
+		err = -errno;
+	else
+		err = -sk_err;
+
+	if (l2data->expect_err) {
+
+		if (-err == l2data->expect_err)
+			tester_test_passed();
+		else
+			tester_test_failed();
+	}
+}
+
+static bool l2cap_connect_cb(struct l_io *io, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct l2cap_data *l2data = data->test_data;
+	int err, sk_err, sk;
+	socklen_t len = sizeof(sk_err);
+
+	sk = l_io_get_fd(io);
 
 	if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &sk_err, &len) < 0)
 		err = -errno;
@@ -1055,19 +1074,19 @@ static gboolean l2cap_connect_cb(GIOChannel *io, GIOCondition cond,
 
 	if (!check_mtu(data, sk)) {
 		tester_test_failed();
-		return FALSE;
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
@@ -1082,12 +1101,11 @@ static gboolean l2cap_connect_cb(GIOChannel *io, GIOCondition cond,
 			tester_test_failed();
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
@@ -1096,7 +1114,7 @@ failed:
 	else
 		tester_test_passed();
 
-	return FALSE;
+	return false;
 }
 
 static int create_l2cap_sock(struct test_data *data, uint16_t psm,
@@ -1281,7 +1299,6 @@ static void test_connect(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct l2cap_data *l2data = data->test_data;
-	GIOChannel *io;
 	int sk;
 
 	if (l2data->server_psm) {
@@ -1321,12 +1338,12 @@ static void test_connect(const void *test_data)
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
 
 	tester_print("Connect in progress");
 }
@@ -1353,12 +1370,12 @@ static void test_connect_reject(const void *test_data)
 	close(sk);
 }
 
-static int connect_socket(const uint8_t *client_bdaddr, GIOFunc connect_cb,
-								bool defer)
+static struct l_io *connect_socket(const uint8_t *client_bdaddr,
+					l_io_write_cb_t connect_cb, bool defer)
 {
 	struct test_data *data = tester_get_data();
 	const struct l2cap_data *l2data = data->test_data;
-	GIOChannel *io;
+	struct l_io *io;
 	int sk;
 
 	sk = create_l2cap_sock(data, 0, l2data->cid, l2data->sec_level,
@@ -1369,7 +1386,7 @@ static int connect_socket(const uint8_t *client_bdaddr, GIOFunc connect_cb,
 			tester_test_abort();
 		else
 			tester_test_failed();
-		return -1;
+		return NULL;
 	}
 
 	if (defer) {
@@ -1380,7 +1397,7 @@ static int connect_socket(const uint8_t *client_bdaddr, GIOFunc connect_cb,
 			tester_print("Can't enable deferred setup: %s (%d)",
 						strerror(errno), errno);
 			tester_test_failed();
-			return -1;
+			return NULL;
 		}
 	}
 
@@ -1389,25 +1406,20 @@ static int connect_socket(const uint8_t *client_bdaddr, GIOFunc connect_cb,
 		tester_print("Error in connect_l2cap_sock");
 		close(sk);
 		tester_test_failed();
-		return -1;
+		return NULL;
 	}
 
-	if (connect_cb) {
-		io = g_io_channel_unix_new(sk);
-		g_io_channel_set_close_on_unref(io, TRUE);
-
-		data->io_id = g_io_add_watch(io, G_IO_OUT, connect_cb, NULL);
-
-		g_io_channel_unref(io);
-	}
+	io = l_io_new(sk);
+	l_io_set_close_on_destroy(io, true);
+	l_io_set_write_handler(io, connect_cb, NULL, NULL);
 
 	tester_print("Connect in progress, sk = %d %s", sk,
 				defer ? "(deferred)" : "");
 
-	return sk;
+	return io;
 }
 
-static gboolean test_close_socket_1_part_3(gpointer arg)
+static void test_close_socket_1_part_3(void *arg)
 {
 	struct test_data *data = tester_get_data();
 
@@ -1416,20 +1428,19 @@ static gboolean test_close_socket_1_part_3(gpointer arg)
 	if (data->sk != -1) {
 		tester_print("Error - scan was not enabled yet");
 		tester_test_failed();
-		return FALSE;
+		return;
 	}
 
 	if (hciemu_get_master_le_scan_enable(data->hciemu)) {
 		tester_print("Delayed check whether scann is off failed");
 		tester_test_failed();
-		return FALSE;
+		return;
 	}
 
 	tester_test_passed();
-	return FALSE;
 }
 
-static gboolean test_close_socket_1_part_2(gpointer args)
+static void test_close_socket_1_part_2(void *args)
 {
 	struct test_data *data = tester_get_data();
 	int sk = data->sk;
@@ -1443,7 +1454,7 @@ static gboolean test_close_socket_1_part_2(gpointer args)
 	if (!hciemu_get_master_le_scan_enable(data->hciemu)) {
 		tester_print("Error - should be still scanning");
 		tester_test_failed();
-		return FALSE;
+		return;
 	}
 
 	/* Calling close() should remove device from  whitelist, and stop
@@ -1452,15 +1463,14 @@ static gboolean test_close_socket_1_part_2(gpointer args)
 	if (close(sk) < 0) {
 		tester_print("Error when closing socket");
 		tester_test_failed();
-		return FALSE;
+		return;
 	}
 
 	data->sk = -1;
 	/* tester_test_passed will be called when scan is stopped. */
-	return FALSE;
 }
 
-static gboolean test_close_socket_2_part_3(gpointer arg)
+static void test_close_socket_2_part_3(void *arg)
 {
 	struct test_data *data = tester_get_data();
 	int sk = data->sk;
@@ -1470,7 +1480,7 @@ static gboolean test_close_socket_2_part_3(gpointer arg)
 	if (hciemu_get_master_le_scan_enable(data->hciemu)) {
 		tester_print("Error - should no longer scan");
 		tester_test_failed();
-		return FALSE;
+		return;
 	}
 
 	/* Calling close() should eventually cause CMD_LE_CREATE_CONN_CANCEL */
@@ -1478,11 +1488,10 @@ static gboolean test_close_socket_2_part_3(gpointer arg)
 	if (err < 0) {
 		tester_print("Error when closing socket");
 		tester_test_failed();
-		return FALSE;
+		return;
 	}
 
 	/* CMD_LE_CREATE_CONN_CANCEL will trigger test pass. */
-	return FALSE;
 }
 
 static bool test_close_socket_cc_hook(const void *data, uint16_t len,
@@ -1491,7 +1500,7 @@ static bool test_close_socket_cc_hook(const void *data, uint16_t len,
 	return false;
 }
 
-static gboolean test_close_socket_2_part_2(gpointer arg)
+static void test_close_socket_2_part_2(void *arg)
 {
 	struct test_data *data = tester_get_data();
 	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
@@ -1507,7 +1516,6 @@ static gboolean test_close_socket_2_part_2(gpointer arg)
 	 */
 	bthost_set_adv_enable(bthost, 0x01);
 	bthost_set_adv_enable(bthost, 0x00);
-	return FALSE;
 }
 
 static void test_close_socket_scan_enabled(void)
@@ -1516,9 +1524,9 @@ static void test_close_socket_scan_enabled(void)
 	const struct l2cap_data *l2data = data->test_data;
 
 	if (l2data == &le_client_close_socket_test_1)
-		g_idle_add(test_close_socket_1_part_2, NULL);
+		l_idle_oneshot(test_close_socket_1_part_2, NULL, NULL);
 	else if (l2data == &le_client_close_socket_test_2)
-		g_idle_add(test_close_socket_2_part_2, NULL);
+		l_idle_oneshot(test_close_socket_2_part_2, NULL, NULL);
 }
 
 static void test_close_socket_scan_disabled(void)
@@ -1527,9 +1535,9 @@ static void test_close_socket_scan_disabled(void)
 	const struct l2cap_data *l2data = data->test_data;
 
 	if (l2data == &le_client_close_socket_test_1)
-		g_idle_add(test_close_socket_1_part_3, NULL);
+		l_idle_oneshot(test_close_socket_1_part_3, NULL, NULL);
 	else if (l2data == &le_client_close_socket_test_2)
-		g_idle_add(test_close_socket_2_part_3, NULL);
+		l_idle_oneshot(test_close_socket_2_part_3, NULL, NULL);
 }
 
 static void test_close_socket_conn_cancel(void)
@@ -1571,21 +1579,19 @@ static void test_close_socket(const void *test_data)
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
 	struct test_data *data = tester_get_data();
 	const struct l2cap_data *l2data = data->test_data;
 	int err, sk_err, sk;
 	socklen_t len = sizeof(sk_err);
 
-	data->io_id = 0;
-
-	sk = g_io_channel_unix_get_fd(io);
+	sk = l_io_get_fd(io);
 
 	if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &sk_err, &len) < 0)
 		err = -errno;
@@ -1595,7 +1601,7 @@ static gboolean test_2_connect_cb(GIOChannel *io, GIOCondition cond,
 	if (err < 0) {
 		tester_warn("Connect failed: %s (%d)", strerror(-err), -err);
 		tester_test_failed();
-		return FALSE;
+		return false;
 	}
 
 	tester_print("Successfully connected");
@@ -1612,16 +1618,15 @@ static gboolean test_2_connect_cb(GIOChannel *io, GIOCondition cond,
 		tester_test_passed();
 	}
 
-	return FALSE;
+	return true;
 }
 
-static gboolean enable_advertising(gpointer args)
+static void enable_advertising(void *args)
 {
 	struct test_data *data = tester_get_data();
 	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
 
 	bthost_set_adv_enable(bthost, 0x01);
-	return FALSE;
 }
 
 static void test_connect_2_part_2(void)
@@ -1631,14 +1636,15 @@ static void test_connect_2_part_2(void)
 	const uint8_t *client_bdaddr;
 
 	client_bdaddr = hciemu_get_client_bdaddr(data->hciemu);
-	data->sk2 = connect_socket(client_bdaddr, test_2_connect_cb, false);
+	data->io2 = connect_socket(client_bdaddr, test_2_connect_cb, false);
+	data->sk2 = l_io_get_fd(data->io2);
 
 	if (l2data->close_1) {
 		tester_print("Closing first socket! %d", data->sk);
 		close(data->sk);
 	}
 
-	g_idle_add(enable_advertising, NULL);
+	l_idle_oneshot(enable_advertising, NULL, NULL);
 }
 
 static uint8_t test_scan_enable_counter;
@@ -1654,7 +1660,7 @@ static void test_connect_2_router(uint16_t opcode, const void *param,
 		if (test_scan_enable_counter == 1)
 			test_connect_2_part_2();
 		else if (test_scan_enable_counter == 2)
-			g_idle_add(enable_advertising, NULL);
+			l_idle_oneshot(enable_advertising, NULL, NULL);
 	}
 }
 
@@ -1683,50 +1689,47 @@ static void test_connect_2(const void *test_data)
 
 	client_bdaddr = hciemu_get_client_bdaddr(data->hciemu);
 	if (l2data->close_1)
-		data->sk = connect_socket(client_bdaddr, NULL, defer);
+		data->io = connect_socket(client_bdaddr, NULL, defer);
 	else
-		data->sk = connect_socket(client_bdaddr, test_2_connect_cb,
+		data->io = connect_socket(client_bdaddr, test_2_connect_cb,
 								defer);
+	data->sk = l_io_get_fd(data->io);
 }
 
-static gboolean l2cap_listen_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool l2cap_listen_cb(struct l_io *io, void *user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct l2cap_data *l2data = data->test_data;
 	int sk, new_sk;
 
-	data->io_id = 0;
-
-	sk = g_io_channel_unix_get_fd(io);
+	sk = l_io_get_fd(io);
 
 	new_sk = accept(sk, NULL, NULL);
 	if (new_sk < 0) {
 		tester_warn("accept failed: %s (%u)", strerror(errno), errno);
 		tester_test_failed();
-		return FALSE;
+		return false;
 	}
 
 	if (!check_mtu(data, new_sk)) {
 		tester_test_failed();
-		return FALSE;
+		return false;
 	}
 
 	if (l2data->read_data) {
 		struct bthost *bthost;
-		GIOChannel *new_io;
+		struct l_io *new_io;
+
+		new_io = l_io_new(new_sk);
 
-		new_io = g_io_channel_unix_new(new_sk);
-		g_io_channel_set_close_on_unref(new_io, TRUE);
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
@@ -1743,7 +1746,7 @@ static gboolean l2cap_listen_cb(GIOChannel *io, GIOCondition cond,
 			tester_test_failed();
 		}
 
-		return FALSE;
+		return false;
 	}
 
 	tester_print("Successfully connected");
@@ -1752,7 +1755,7 @@ static gboolean l2cap_listen_cb(GIOChannel *io, GIOCondition cond,
 
 	tester_test_passed();
 
-	return FALSE;
+	return false;
 }
 
 static void client_l2cap_rsp(uint8_t code, const void *data, uint16_t len,
@@ -1839,7 +1842,6 @@ static void test_server(const void *test_data)
 	const uint8_t *master_bdaddr;
 	uint8_t addr_type;
 	struct bthost *bthost;
-	GIOChannel *io;
 	int sk;
 
 	if (l2data->server_psm || l2data->cid) {
@@ -1859,12 +1861,10 @@ static void test_server(const void *test_data)
 			return;
 		}
 
-		io = g_io_channel_unix_new(sk);
-		g_io_channel_set_close_on_unref(io, TRUE);
+		data->io = l_io_new(sk);
 
-		data->io_id = g_io_add_watch(io, G_IO_IN, l2cap_listen_cb,
-									NULL);
-		g_io_channel_unref(io);
+		l_io_set_close_on_destroy(data->io, true);
+		l_io_set_read_handler(data->io, l2cap_listen_cb, NULL, NULL);
 
 		tester_print("Listening for connections");
 	}
-- 
2.26.2

