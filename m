Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A0C274672
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 08:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748422791; cv=none; b=OI1v0Hm8ZebmUPsSrYHePHdVSqqIRMeNDOT13VsINJ1fdjYRmm0uYahRkOdQqpLjaHu63LNU8GU4S9l8uP/x/Tymw85IqQCeXAJuPJznMY0NPPn2wkBpAi4oLfeTdCzskNl5862w8v2NAyy2TXlGlw3TXnkdF6SKfuKox9DynW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748422791; c=relaxed/simple;
	bh=BcwMhf2VkUrR2nZTcMu4BZ04PgYcLt7J+razDrWgfKI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MJfDNF4GNn3MpTESjf+uNvT6pokr/2kGUOoBgCki8cweKSH/DvCuW8hZjfRodkJp6m8zBtYpCC63WNVWTmbn4rHt6cNqwcwe4y/iEFjj80XbDuvWqlBIqrI4c5wjbg150O1ydLMwpIzCrtVsApHtRTQpmf26tiRSw8aiAdvTkpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=N5/m6jWw; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="N5/m6jWw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1748422779;
	bh=BcwMhf2VkUrR2nZTcMu4BZ04PgYcLt7J+razDrWgfKI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=N5/m6jWwY5NR/3B4hCtLUDVD0NLAFmRO45BSCSkDBYyKd20aYdu+bXJUBjQt/L8JT
	 MJDnbxFssm7HyEMQ+gHJbiiGsOG7Wst6v5T1uQAE5a+INAhFq91bbyNpfrHwnuU3Ys
	 bF8Rt6sdxI5pexJqDmkHl0B+eT+AaNC9ECMYKtpTiHvUhXTLI4+iiE6hpLpDsPrwkH
	 LRfuREaaN9YiqZCnGCEu8LCZZ574EO6hCnqhwgMfJStBqZkwErLsEgnmcsswRs4L72
	 vXWbRx3h3YteHkUGqPsMxPNswFh9bQYxcSkuykV8+2gxqRj2W8XTZ33Oms0ZhMrqsn
	 an/27doSAKtYw==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-AF44-1001-C79a-7427-1C18-f6a9.rev.sfr.net [IPv6:2a02:8428:af44:1001:c79a:7427:1c18:f6a9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0DB6417E37BE
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 10:59:39 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 08/10] client/telephony: Add new submenu
Date: Wed, 28 May 2025 10:59:28 +0200
Message-ID: <20250528085930.227816-9-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528085930.227816-1-frederic.danis@collabora.com>
References: <20250528085930.227816-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
 Makefile.tools                    |   9 +-
 client/bluetoothctl-telephony.rst |  95 ++++++
 client/main.c                     |   3 +
 client/telephony.c                | 524 ++++++++++++++++++++++++++++++
 client/telephony.h                |  12 +
 5 files changed, 640 insertions(+), 3 deletions(-)
 create mode 100644 client/bluetoothctl-telephony.rst
 create mode 100644 client/telephony.c
 create mode 100644 client/telephony.h

diff --git a/Makefile.tools b/Makefile.tools
index e60c31b1d..0f4eeb063 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -15,7 +15,8 @@ client_bluetoothctl_SOURCES = client/main.c \
 					client/player.h client/player.c \
 					client/mgmt.h client/mgmt.c \
 					client/assistant.h client/assistant.c \
-					client/hci.h client/hci.c
+					client/hci.h client/hci.c \
+					client/telephony.h client/telephony.c
 client_bluetoothctl_LDADD = lib/libbluetooth-internal.la \
 			gdbus/libgdbus-internal.la src/libshared-glib.la \
 			$(GLIB_LIBS) $(DBUS_LIBS) -lreadline
@@ -351,7 +352,8 @@ man_MANS += tools/rctest.1 tools/l2ping.1 tools/btattach.1 tools/isotest.1 \
 		client/bluetoothctl-advertise.1 client/bluetoothctl-endpoint.1 \
 		client/bluetoothctl-gatt.1 client/bluetoothctl-player.1 \
 		client/bluetoothctl-scan.1 client/bluetoothctl-transport.1 \
-		client/bluetoothctl-assistant.1 client/bluetoothctl-hci.1
+		client/bluetoothctl-assistant.1 client/bluetoothctl-hci.1 \
+		client/bluetoothctl-telephony.1
 
 endif
 
@@ -484,7 +486,8 @@ manual_pages += tools/hciattach.1 tools/hciconfig.1 \
 			client/bluetoothctl-scan.1 \
 			client/bluetoothctl-transport.1 \
 			client/bluetoothctl-assistant.1 \
-			client/bluetoothctl-hci.1
+			client/bluetoothctl-hci.1 \
+			client/bluetoothctl-telephony.1
 
 if HID2HCI
 udevdir = $(UDEV_DIR)
diff --git a/client/bluetoothctl-telephony.rst b/client/bluetoothctl-telephony.rst
new file mode 100644
index 000000000..a6870e781
--- /dev/null
+++ b/client/bluetoothctl-telephony.rst
@@ -0,0 +1,95 @@
+======================
+bluetoothctl-telephony
+======================
+
+-----------------
+Telephony Submenu
+-----------------
+
+:Version: BlueZ
+:Copyright: Free use of this software is granted under the terms of the GNU
+            Lesser General Public Licenses (LGPL).
+:Date: May 2025
+:Manual section: 1
+:Manual group: Linux System Administration
+
+SYNOPSIS
+========
+
+**bluetoothctl** [--options] [telephony.commands]
+
+Telephony Commands
+==================
+
+list
+----
+
+List available audio gateways.
+
+:Usage: **> list**
+
+show
+----
+
+Show audio gateway information.
+
+:Usage: **> show [audiogw]**
+
+select
+------
+
+Select default audio gateway.
+
+:Usage: **> select <audiogw>**
+
+dial
+----
+
+Dial number.
+
+:Usage: **> dial <number> [audiogw]**
+
+hangup-all
+----------
+
+Hangup all calls.
+
+:Usage: **> hangup-all**
+
+list-calls
+----------
+
+List available calls.
+
+:Usage: **> list-calls**
+
+show-call
+---------
+
+Show call information.
+
+:Usage: **> show-call <call>**
+
+answer
+------
+
+Answer call.
+
+:Usage: **> answer <call>**
+
+hangup
+------
+
+Hangup call.
+
+:Usage: **> hangup <call>**
+
+RESOURCES
+=========
+
+http://www.bluez.org
+
+REPORTING BUGS
+==============
+
+linux-bluetooth@vger.kernel.org
diff --git a/client/main.c b/client/main.c
index c2321952b..93fb434a9 100644
--- a/client/main.c
+++ b/client/main.c
@@ -38,6 +38,7 @@
 #include "mgmt.h"
 #include "assistant.h"
 #include "hci.h"
+#include "telephony.h"
 
 /* String display constants */
 #define COLORED_NEW	COLOR_GREEN "NEW" COLOR_OFF
@@ -3467,6 +3468,7 @@ int main(int argc, char *argv[])
 	mgmt_add_submenu();
 	assistant_add_submenu();
 	hci_add_submenu();
+	telephony_add_submenu();
 	bt_shell_set_prompt(PROMPT_OFF, NULL);
 
 	bt_shell_handle_non_interactive_help();
@@ -3507,6 +3509,7 @@ int main(int argc, char *argv[])
 	mgmt_remove_submenu();
 	assistant_remove_submenu();
 	hci_remove_submenu();
+	telephony_remove_submenu();
 
 	g_dbus_client_unref(client);
 
diff --git a/client/telephony.c b/client/telephony.c
new file mode 100644
index 000000000..eb4c032b0
--- /dev/null
+++ b/client/telephony.c
@@ -0,0 +1,524 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright © 2025 Collabora Ltd.
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <stdlib.h>
+
+#include <glib.h>
+
+#include "gdbus/gdbus.h"
+
+#include "src/shared/shell.h"
+#include "print.h"
+#include "telephony.h"
+
+/* String display constants */
+#define COLORED_NEW	COLOR_GREEN "NEW" COLOR_OFF
+#define COLORED_CHG	COLOR_YELLOW "CHG" COLOR_OFF
+#define COLORED_DEL	COLOR_RED "DEL" COLOR_OFF
+
+#define BLUEZ_TELEPHONY_AG_INTERFACE "org.bluez.TelephonyAg1"
+#define BLUEZ_TELEPHONY_CALL_INTERFACE "org.bluez.TelephonyCall1"
+
+static DBusConnection *dbus_conn;
+static GDBusProxy *default_ag;
+static GList *ags;
+static GList *calls;
+
+static GDBusClient *client;
+
+static bool check_default_ag(void)
+{
+	if (!default_ag) {
+		bt_shell_printf("No default audio gateway available\n");
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+static char *generic_generator(const char *text, int state, GList *source)
+{
+	static int index;
+
+	if (!source)
+		return NULL;
+
+	if (!state)
+		index = 0;
+
+	return g_dbus_proxy_path_lookup(source, &index, text);
+}
+
+static char *ag_generator(const char *text, int state)
+{
+	return generic_generator(text, state, ags);
+}
+
+static char *call_generator(const char *text, int state)
+{
+	return generic_generator(text, state, calls);
+}
+
+static char *proxy_description(GDBusProxy *proxy, const char *title,
+						const char *description)
+{
+	const char *path;
+
+	path = g_dbus_proxy_get_path(proxy);
+
+	return g_strdup_printf("%s%s%s%s %s ",
+					description ? "[" : "",
+					description ? : "",
+					description ? "] " : "",
+					title, path);
+}
+
+static void print_ag(void *data, void *user_data)
+{
+	GDBusProxy *proxy = data;
+	const char *description = user_data;
+	char *str;
+
+	str = proxy_description(proxy, "Telephony", description);
+
+	bt_shell_printf("%s%s\n", str,
+			default_ag == proxy ? "[default]" : "");
+
+	g_free(str);
+}
+
+static void print_call(void *data, void *user_data)
+{
+	GDBusProxy *proxy = data;
+	const char *description = user_data;
+	const char *path, *line_id;
+	DBusMessageIter iter;
+
+	path = g_dbus_proxy_get_path(proxy);
+
+	if (g_dbus_proxy_get_property(proxy, "LineIdentification", &iter))
+		dbus_message_iter_get_basic(&iter, &line_id);
+	else
+		line_id = "<unknown>";
+
+	bt_shell_printf("%s%s%sCall %s %s\n", description ? "[" : "",
+					description ? : "",
+					description ? "] " : "",
+					path, line_id);
+}
+
+static void cmd_list(int argc, char *arg[])
+{
+	g_list_foreach(ags, print_ag, NULL);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_show(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+
+	if (argc < 2) {
+		if (check_default_ag() == FALSE)
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+		proxy = default_ag;
+	} else {
+		proxy = g_dbus_proxy_lookup(ags, NULL, argv[1],
+						BLUEZ_TELEPHONY_AG_INTERFACE);
+		if (!proxy) {
+			bt_shell_printf("Audio gateway %s not available\n",
+								argv[1]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+	}
+
+	bt_shell_printf("Audio gateway %s\n", g_dbus_proxy_get_path(proxy));
+
+	print_property(proxy, "State");
+	print_property(proxy, "Service");
+	print_property(proxy, "Signal");
+	print_property(proxy, "Roaming");
+	print_property(proxy, "BattChg");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_select(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+
+	proxy = g_dbus_proxy_lookup(ags, NULL, argv[1],
+						BLUEZ_TELEPHONY_AG_INTERFACE);
+	if (proxy == NULL) {
+		bt_shell_printf("Audio gateway %s not available\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (default_ag == proxy)
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+
+	default_ag = proxy;
+	print_ag(proxy, NULL);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void dial_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		bt_shell_printf("Failed to answer: %s\n", error.name);
+		dbus_error_free(&error);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Dial successful\n");
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
+}
+
+static void dial_setup(DBusMessageIter *iter, void *user_data)
+{
+	const char *number = user_data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &number);
+}
+
+static void cmd_dial(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+
+	if (argc < 3) {
+		if (check_default_ag() == FALSE)
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+		proxy = default_ag;
+	} else {
+		proxy = g_dbus_proxy_lookup(ags, NULL, argv[2],
+						BLUEZ_TELEPHONY_AG_INTERFACE);
+		if (!proxy) {
+			bt_shell_printf("Audio gateway %s not available\n",
+							argv[1]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+	}
+
+	if (g_dbus_proxy_method_call(proxy, "Dial", dial_setup,
+				dial_reply, argv[1], NULL) == FALSE) {
+		bt_shell_printf("Failed to dial\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Attempting to dial\n");
+}
+
+static void hangupall_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		bt_shell_printf("Failed to answer: %s\n", error.name);
+		dbus_error_free(&error);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Hangup all successful\n");
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
+}
+
+static void cmd_hangupall(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+
+	if (argc < 2) {
+		if (check_default_ag() == FALSE)
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+		proxy = default_ag;
+	} else {
+		proxy = g_dbus_proxy_lookup(ags, NULL, argv[1],
+						BLUEZ_TELEPHONY_AG_INTERFACE);
+		if (!proxy) {
+			bt_shell_printf("Audio gateway %s not available\n",
+							argv[1]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+	}
+
+	if (g_dbus_proxy_method_call(proxy, "HangupAll", NULL,
+				hangupall_reply, NULL, NULL) == FALSE) {
+		bt_shell_printf("Failed to hangup all calls\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Attempting to hangup all calls\n");
+}
+
+static void cmd_list_calls(int argc, char *arg[])
+{
+	g_list_foreach(calls, print_call, NULL);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_show_call(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+
+	if (argc < 2)
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	proxy = g_dbus_proxy_lookup(ags, NULL, argv[1],
+				BLUEZ_TELEPHONY_CALL_INTERFACE);
+	if (!proxy) {
+		bt_shell_printf("Call %s not available\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Call %s\n", g_dbus_proxy_get_path(proxy));
+
+	print_property(proxy, "LineIdentification");
+	print_property(proxy, "IncomingLine");
+	print_property(proxy, "Name");
+	print_property(proxy, "Multiparty");
+	print_property(proxy, "State");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void answer_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		bt_shell_printf("Failed to answer: %s\n", error.name);
+		dbus_error_free(&error);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Answer successful\n");
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
+}
+
+static void cmd_answer_call(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+
+	if (argc < 2)
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	proxy = g_dbus_proxy_lookup(calls, NULL, argv[1],
+				BLUEZ_TELEPHONY_CALL_INTERFACE);
+	if (!proxy) {
+		bt_shell_printf("Call %s not available\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (g_dbus_proxy_method_call(proxy, "Answer", NULL,
+				answer_reply, NULL, NULL) == FALSE) {
+		bt_shell_printf("Failed to answer call\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Attempting to answer\n");
+}
+
+static void hangup_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		bt_shell_printf("Failed to answer: %s\n", error.name);
+		dbus_error_free(&error);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Hangup successful\n");
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
+}
+
+static void cmd_hangup_call(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+
+	if (argc < 2)
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	proxy = g_dbus_proxy_lookup(calls, NULL, argv[1],
+			BLUEZ_TELEPHONY_CALL_INTERFACE);
+	if (!proxy) {
+		bt_shell_printf("Call %s not available\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (g_dbus_proxy_method_call(proxy, "Hangup", NULL,
+				hangup_reply, NULL, NULL) == FALSE) {
+		bt_shell_printf("Failed to hangup call\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Attempting to hangup\n");
+}
+
+static void ag_added(GDBusProxy *proxy)
+{
+	ags = g_list_append(ags, proxy);
+
+	if (default_ag == NULL)
+		default_ag = proxy;
+
+	print_ag(proxy, COLORED_NEW);
+}
+
+static void call_added(GDBusProxy *proxy)
+{
+	calls = g_list_append(calls, proxy);
+
+	print_call(proxy, COLORED_NEW);
+}
+
+static void proxy_added(GDBusProxy *proxy, void *user_data)
+{
+	const char *interface;
+
+	interface = g_dbus_proxy_get_interface(proxy);
+
+	if (!strcmp(interface, BLUEZ_TELEPHONY_AG_INTERFACE))
+		ag_added(proxy);
+	else if (!strcmp(interface, BLUEZ_TELEPHONY_CALL_INTERFACE))
+		call_added(proxy);
+}
+
+static void ag_removed(GDBusProxy *proxy)
+{
+	print_ag(proxy, COLORED_DEL);
+
+	if (default_ag == proxy)
+		default_ag = NULL;
+
+	ags = g_list_remove(ags, proxy);
+}
+
+static void call_removed(GDBusProxy *proxy)
+{
+	calls = g_list_remove(calls, proxy);
+
+	print_call(proxy, COLORED_DEL);
+}
+
+static void proxy_removed(GDBusProxy *proxy, void *user_data)
+{
+	const char *interface;
+
+	interface = g_dbus_proxy_get_interface(proxy);
+
+	if (!strcmp(interface, BLUEZ_TELEPHONY_AG_INTERFACE))
+		ag_removed(proxy);
+	else if (!strcmp(interface, BLUEZ_TELEPHONY_CALL_INTERFACE))
+		call_removed(proxy);
+}
+
+static void ag_property_changed(GDBusProxy *proxy, const char *name,
+						DBusMessageIter *iter)
+{
+	char *str;
+
+	str = proxy_description(proxy, "audiogw", COLORED_CHG);
+	print_iter(str, name, iter);
+	g_free(str);
+}
+
+static void call_property_changed(GDBusProxy *proxy, const char *name,
+						DBusMessageIter *iter)
+{
+	char *str;
+
+	str = proxy_description(proxy, "call", COLORED_CHG);
+	print_iter(str, name, iter);
+	g_free(str);
+}
+
+static void property_changed(GDBusProxy *proxy, const char *name,
+					DBusMessageIter *iter, void *user_data)
+{
+	const char *interface;
+
+	interface = g_dbus_proxy_get_interface(proxy);
+
+	if (!strcmp(interface, BLUEZ_TELEPHONY_AG_INTERFACE))
+		ag_property_changed(proxy, name, iter);
+	else if (!strcmp(interface, BLUEZ_TELEPHONY_CALL_INTERFACE))
+		call_property_changed(proxy, name, iter);
+}
+
+static void telephony_menu_pre_run(const struct bt_shell_menu *menu)
+{
+	dbus_conn = bt_shell_get_env("DBUS_CONNECTION");
+	if (!dbus_conn || client)
+		return;
+
+	client = g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez");
+
+	g_dbus_client_set_proxy_handlers(client, proxy_added, proxy_removed,
+							property_changed, NULL);
+}
+
+static const struct bt_shell_menu telephony_menu = {
+	.name = "telephony",
+	.desc = "Telephony Submenu",
+	.pre_run = telephony_menu_pre_run,
+	.entries = {
+	{ "list",         NULL, cmd_list, "List available audio gateway" },
+	{ "show",         "[audiogw]", cmd_show, "Audio gateway information",
+						ag_generator},
+	{ "select",       "<audiogw>", cmd_select,
+						"Select default audio gateway",
+						ag_generator},
+	{ "dial",         "<number> [audiogw]", cmd_dial, "Dial number",
+						ag_generator},
+	{ "hangup-all",   "[audiogw]", cmd_hangupall, "Hangup all calls",
+						ag_generator},
+	{ "list-calls",   NULL, cmd_list_calls, "List calls" },
+	{ "show-call",    "<call>", cmd_show_call, "Show call information",
+						call_generator},
+	{ "answer",       "<call>", cmd_answer_call, "Answer call",
+						call_generator},
+	{ "hangup",       "<call>", cmd_hangup_call, "Hangup call",
+						call_generator},
+	{} },
+};
+
+void telephony_add_submenu(void)
+{
+	bt_shell_add_submenu(&telephony_menu);
+}
+
+void telephony_remove_submenu(void)
+{
+	g_dbus_client_unref(client);
+}
diff --git a/client/telephony.h b/client/telephony.h
new file mode 100644
index 000000000..a869da240
--- /dev/null
+++ b/client/telephony.h
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright © 2025 Collabora Ltd.
+ *
+ *
+ */
+
+void telephony_add_submenu(void);
+void telephony_remove_submenu(void);
-- 
2.43.0

