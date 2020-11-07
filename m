Return-Path: <SRS0=aRPM=EN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1C6C55178
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Nov 2020 07:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E78E20872
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Nov 2020 07:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgKGHD3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 7 Nov 2020 02:03:29 -0500
Received: from mga17.intel.com ([192.55.52.151]:45622 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbgKGHD2 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 7 Nov 2020 02:03:28 -0500
IronPort-SDR: h+BMa46wmf+ncRkPDCayDGLIvkSlnh2/8oAHGt7+BV9WJtH2WNKjGs3e9WwN5MRyPcNccE4vaQ
 M/uj1ATtkFAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9797"; a="149485513"
X-IronPort-AV: E=Sophos;i="5.77,458,1596524400"; 
   d="scan'208";a="149485513"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 23:03:28 -0800
IronPort-SDR: X/GcUZFNFPBukgvGr5KZPeX5F+4AfwQsr3EceA2LvScOexmdNySccbKx/E4eMwuYa+TKd5mAAU
 kP8/i+gnKUHg==
X-IronPort-AV: E=Sophos;i="5.77,458,1596524400"; 
   d="scan'208";a="359032015"
Received: from ralassax-mobl.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.209.101.141])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 23:03:28 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [RFC PATCH BlueZ 03/10] tools/gap-tester: Convert to use ELL library
Date:   Fri,  6 Nov 2020 23:03:05 -0800
Message-Id: <20201107070312.8561-4-inga.stotland@intel.com>
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
 Makefile.tools     |  6 ++--
 tools/gap-tester.c | 87 ++++++++++++++++++++++++++--------------------
 2 files changed, 51 insertions(+), 42 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index d5fdf2d89..259427443 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -146,14 +146,12 @@ tools_smp_tester_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-glib.la $(GLIB_LIBS)
 
 tools_gap_tester_SOURCES = tools/gap-tester.c monitor/bt.h \
-				emulator/hciemu.h emulator/hciemu.c \
+				emulator/hciemu.h emulator/hciemu-ell.c \
 				emulator/btdev.h emulator/btdev.c \
 				emulator/bthost.h emulator/bthost.c \
 				emulator/smp.c
 tools_gap_tester_LDADD =  lib/libbluetooth-internal.la \
-				gdbus/libgdbus-internal.la \
-				src/libshared-glib.la \
-				$(GLIB_LIBS) $(DBUS_LIBS)
+				src/libshared-ell.la $(ell_ldadd)
 
 tools_sco_tester_SOURCES = tools/sco-tester.c monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu.c \
diff --git a/tools/gap-tester.c b/tools/gap-tester.c
index 942c37d27..2797a60a8 100644
--- a/tools/gap-tester.c
+++ b/tools/gap-tester.c
@@ -12,60 +12,72 @@
 #include <config.h>
 #endif
 
-#include "gdbus/gdbus.h"
+#include <ell/ell.h>
 
 #include "src/shared/tester.h"
 #include "emulator/hciemu.h"
 
-static DBusConnection *dbus_conn = NULL;
-static GDBusClient *dbus_client = NULL;
-static GDBusProxy *adapter_proxy = NULL;
+static struct l_dbus *dbus_conn;
+struct l_dbus_client *dbus_client;
+struct l_dbus_proxy *adapter_proxy;
 
-static struct hciemu *hciemu_stack = NULL;
+static struct hciemu *hciemu_stack;
 
-static void connect_handler(DBusConnection *connection, void *user_data)
+static void connect_handler(struct l_dbus *connection, void *user_data)
 {
 	tester_print("Connected to daemon");
 
 	hciemu_stack = hciemu_new(HCIEMU_TYPE_BREDRLE);
 }
 
-static void disconnect_handler(DBusConnection *connection, void *user_data)
+static void destroy_client(void *data)
 {
-	tester_print("Disconnected from daemon");
+	l_dbus_client_destroy(dbus_client);
+	dbus_client = NULL;
+}
 
-	dbus_connection_unref(dbus_conn);
+static void destroy_conn(void *data)
+{
+	l_dbus_destroy(dbus_conn);
 	dbus_conn = NULL;
+}
 
-	tester_teardown_complete();
+static void service_disconnect_handler(struct l_dbus *connection,
+							void *user_data)
+{
+	tester_print("Daemon disconnected");
 }
 
-static gboolean compare_string_property(GDBusProxy *proxy, const char *name,
-							const char *value)
+static void client_destroy_handler(void *user_data)
 {
-	DBusMessageIter iter;
-	const char *str;
+	tester_print("Disconnected from daemon");
 
-	if (g_dbus_proxy_get_property(proxy, name, &iter) == FALSE)
-		return FALSE;
+	if (dbus_conn)
+		l_idle_oneshot(destroy_conn, NULL, NULL);
 
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
-		return FALSE;
+	tester_teardown_complete();
+}
 
-	dbus_message_iter_get_basic(&iter, &str);
+static bool compare_string_property(struct l_dbus_proxy *proxy,
+					const char *name, const char *value)
+{
+	const char *str;
 
-	return g_str_equal(str, value);
+	if (!l_dbus_proxy_get_property(proxy, name, "s", &str))
+		return false;
+
+	return !strcmp(str, value);
 }
 
-static void proxy_added(GDBusProxy *proxy, void *user_data)
+static void proxy_added(struct l_dbus_proxy *proxy, void *user_data)
 {
 	const char *interface;
 
-	interface = g_dbus_proxy_get_interface(proxy);
+	interface = l_dbus_proxy_get_interface(proxy);
 
-	if (g_str_equal(interface, "org.bluez.Adapter1") == TRUE) {
+	if (!strcmp(interface, "org.bluez.Adapter1")) {
 		if (compare_string_property(proxy, "Address",
-				hciemu_get_address(hciemu_stack)) == TRUE) {
+				hciemu_get_address(hciemu_stack))) {
 			adapter_proxy = proxy;
 			tester_print("Found adapter");
 
@@ -74,35 +86,34 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 	}
 }
 
-static void proxy_removed(GDBusProxy *proxy, void *user_data)
+static void proxy_removed(struct l_dbus_proxy *proxy, void *user_data)
 {
 	const char *interface;
 
-	interface = g_dbus_proxy_get_interface(proxy);
+	interface = l_dbus_proxy_get_interface(proxy);
 
-	if (g_str_equal(interface, "org.bluez.Adapter1") == TRUE) {
+	if (!strcmp(interface, "org.bluez.Adapter1")) {
 		if (adapter_proxy == proxy) {
 			adapter_proxy = NULL;
 			tester_print("Adapter removed");
-
-			g_dbus_client_unref(dbus_client);
-			dbus_client = NULL;
+			l_idle_oneshot(destroy_client, NULL, NULL);
 		}
 	}
 }
 
 static void test_setup(const void *test_data)
 {
-	dbus_conn = g_dbus_setup_private(DBUS_BUS_SYSTEM, NULL, NULL);
-
-	dbus_client = g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez");
+	dbus_conn = l_dbus_new_default(L_DBUS_SYSTEM_BUS);
 
-	g_dbus_client_set_connect_watch(dbus_client, connect_handler, NULL);
-	g_dbus_client_set_disconnect_watch(dbus_client,
-						disconnect_handler, NULL);
+	dbus_client = l_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez");
+	l_dbus_client_set_connect_handler(dbus_client, connect_handler, NULL,
+									NULL);
+	l_dbus_client_set_disconnect_handler(dbus_client,
+						service_disconnect_handler,
+						NULL, client_destroy_handler);
 
-	g_dbus_client_set_proxy_handlers(dbus_client, proxy_added,
-						proxy_removed, NULL, NULL);
+	l_dbus_client_set_proxy_handlers(dbus_client, proxy_added,
+					proxy_removed, NULL, NULL, NULL);
 }
 
 static void test_run(const void *test_data)
-- 
2.26.2

