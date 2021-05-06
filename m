Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D070C43461
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 May 2021 02:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 004C4613BC
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 May 2021 02:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhEFCTc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 May 2021 22:19:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:27097 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231349AbhEFCTa (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 May 2021 22:19:30 -0400
IronPort-SDR: drTc5KnWW6puvEnvIwiYi8iiXHRO3H2K/jTN1Dw8Wj1u2mkfk1kKlHGyoR7hTJpW/7VUDe9aCJ
 1HelJ4Gw6inA==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="259631499"
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="259631499"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 19:18:32 -0700
IronPort-SDR: yRJCGG+7Cua4cIuj5lA/iF+0pEYbaUNqHOWy5XrmlAGdooVfKh/7XG6XRCoR6y0isc5P4CQvjK
 5AYPDkhFP7nw==
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="469230424"
Received: from zloh1-mobl.gar.corp.intel.com (HELO istotlan-desk.intel.com) ([10.254.6.126])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 19:18:31 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 03/11] tools/gap-tester: Convert to use ELL library
Date:   Wed,  5 May 2021 19:18:09 -0700
Message-Id: <20210506021817.289939-4-inga.stotland@intel.com>
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
 Makefile.tools     |   6 +--
 tools/gap-tester.c | 107 +++++++++++++++++++++++++--------------------
 2 files changed, 62 insertions(+), 51 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index c836b5984..55674ca55 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -152,14 +152,12 @@ tools_smp_tester_LDADD = lib/libbluetooth-internal.la \
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
index 942c37d27..c60cf9beb 100644
--- a/tools/gap-tester.c
+++ b/tools/gap-tester.c
@@ -12,102 +12,114 @@
 #include <config.h>
 #endif
 
-#include "gdbus/gdbus.h"
+#include <ell/ell.h>
 
-#include "src/shared/tester.h"
 #include "emulator/hciemu.h"
+#include "src/shared/bttester.h"
 
-static DBusConnection *dbus_conn = NULL;
-static GDBusClient *dbus_client = NULL;
-static GDBusProxy *adapter_proxy = NULL;
+static struct l_dbus *dbus_conn;
+struct l_dbus_client *dbus_client;
+struct l_dbus_proxy *adapter_proxy;
 
-static struct hciemu *hciemu_stack = NULL;
+static struct hciemu *hciemu_stack;
+static struct l_tester *tester;
 
-static void connect_handler(DBusConnection *connection, void *user_data)
+static void connect_handler(struct l_dbus *connection, void *user_data)
 {
-	tester_print("Connected to daemon");
+	bttester_print("Connected to daemon");
 
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
+	bttester_print("Daemon disconnected");
 }
 
-static gboolean compare_string_property(GDBusProxy *proxy, const char *name,
-							const char *value)
+static void client_destroy_handler(void *user_data)
 {
-	DBusMessageIter iter;
-	const char *str;
+	bttester_print("Disconnected from daemon");
 
-	if (g_dbus_proxy_get_property(proxy, name, &iter) == FALSE)
-		return FALSE;
+	if (dbus_conn)
+		l_idle_oneshot(destroy_conn, NULL, NULL);
 
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
-		return FALSE;
+	l_tester_teardown_complete(tester);
+}
 
-	dbus_message_iter_get_basic(&iter, &str);
+static bool compare_string_property(struct l_dbus_proxy *proxy,
+					const char *name, const char *value)
+{
+	const char *str;
+
+	if (!l_dbus_proxy_get_property(proxy, name, "s", &str))
+		return false;
 
-	return g_str_equal(str, value);
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
-			tester_print("Found adapter");
+			bttester_print("Found adapter");
 
-			tester_setup_complete();
+			l_tester_setup_complete(tester);
 		}
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
-			tester_print("Adapter removed");
-
-			g_dbus_client_unref(dbus_client);
-			dbus_client = NULL;
+			bttester_print("Adapter removed");
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
 {
-	tester_test_passed();
+	l_tester_test_passed(tester);
 }
 
 static void test_teardown(const void *test_data)
@@ -118,9 +130,10 @@ static void test_teardown(const void *test_data)
 
 int main(int argc, char *argv[])
 {
-	tester_init(&argc, &argv);
+	tester = bttester_init(&argc, &argv);
 
-	tester_add("Adapter setup", NULL, test_setup, test_run, test_teardown);
+	l_tester_add(tester, "Adapter setup", NULL, test_setup, test_run,
+								test_teardown);
 
-	return tester_run();
+	return bttester_run();
 }
-- 
2.26.3

