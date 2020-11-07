Return-Path: <SRS0=aRPM=EN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E37C5517A
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Nov 2020 07:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3223D20888
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Nov 2020 07:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgKGHD3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 7 Nov 2020 02:03:29 -0500
Received: from mga17.intel.com ([192.55.52.151]:45622 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbgKGHD3 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 7 Nov 2020 02:03:29 -0500
IronPort-SDR: V/0cWZcYEfSyEEiZaJxycQLTjA4xE/6r2/v2NtNVNC8+8uK6fC3ypirfA9dwvJy9kPPaSEiBSo
 W1XbW/MRu1bg==
X-IronPort-AV: E=McAfee;i="6000,8403,9797"; a="149485514"
X-IronPort-AV: E=Sophos;i="5.77,458,1596524400"; 
   d="scan'208";a="149485514"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 23:03:29 -0800
IronPort-SDR: sV8pnVHdorLtD3X4e9DyGW0njEJ1xe+gu0dlP1uPpxTlvbEoOdvmBD8AT/Mh6Jc2j4VhwSbKJt
 TQZmfYQXthFQ==
X-IronPort-AV: E=Sophos;i="5.77,458,1596524400"; 
   d="scan'208";a="359032019"
Received: from ralassax-mobl.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.209.101.141])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 23:03:29 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [RFC PATCH BlueZ 04/10] tools/sco-tester: Convert to use ELL library
Date:   Fri,  6 Nov 2020 23:03:06 -0800
Message-Id: <20201107070312.8561-5-inga.stotland@intel.com>
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
 Makefile.tools     |  4 ++--
 tools/sco-tester.c | 33 ++++++++++++++-------------------
 2 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 259427443..15613a5c9 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -154,12 +154,12 @@ tools_gap_tester_LDADD =  lib/libbluetooth-internal.la \
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
index 2b8dc0d4a..c3c43a1c3 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -17,7 +17,7 @@
 #include <errno.h>
 #include <stdbool.h>
 
-#include <glib.h>
+#include <ell/ell.h>
 
 #include "lib/bluetooth.h"
 #include "lib/sco.h"
@@ -36,7 +36,7 @@ struct test_data {
 	uint16_t mgmt_index;
 	struct hciemu *hciemu;
 	enum hciemu_type hciemu_type;
-	unsigned int io_id;
+	struct l_io *io;
 	bool disable_esco;
 };
 
@@ -196,20 +196,21 @@ static void test_data_free(void *test_data)
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
 		tester_add_full(name, data, \
@@ -474,17 +475,14 @@ static int connect_sco_sock(struct test_data *data, int sk)
 	return 0;
 }
 
-static gboolean sco_connect_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static bool sco_connect_cb(struct l_io *io, void *user_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct sco_client_data *scodata = data->test_data;
 	int err, sk_err, sk;
 	socklen_t len = sizeof(sk_err);
 
-	data->io_id = 0;
-
-	sk = g_io_channel_unix_get_fd(io);
+	sk = l_io_get_fd(io);
 
 	if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &sk_err, &len) < 0)
 		err = -errno;
@@ -501,13 +499,12 @@ static gboolean sco_connect_cb(GIOChannel *io, GIOCondition cond,
 	else
 		tester_test_passed();
 
-	return FALSE;
+	return false;
 }
 
 static void test_connect(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
-	GIOChannel *io;
 	int sk;
 
 	sk = create_sco_sock(data);
@@ -522,12 +519,10 @@ static void test_connect(const void *test_data)
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
 
 	tester_print("Connect in progress");
 }
-- 
2.26.2

