Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] client: Make use of bt_shell
Date: Fri, 10 Nov 2017 18:12:53 +0200
Message-Id: <20171110161253.11142-2-luiz.dentz@gmail.com>
In-Reply-To: <20171110161253.11142-1-luiz.dentz@gmail.com>
References: <20171110161253.11142-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Use bt_shell instead of readline directly.
---
 client/advertising.c |  42 +++----
 client/agent.c       |  72 +++++------
 client/gatt.c        | 149 ++++++++++++-----------
 client/main.c        | 333 ++-------------------------------------------------
 4 files changed, 146 insertions(+), 450 deletions(-)

diff --git a/client/advertising.c b/client/advertising.c
index 56093f387..f51f713b5 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -29,11 +29,11 @@
 #include <stdlib.h>
 #include <stdint.h>
 #include <stdbool.h>
-#include <readline/readline.h>
+#include <string.h>
 #include <wordexp.h>
 
 #include "gdbus/gdbus.h"
-#include "display.h"
+#include "src/shared/shell.h"
 #include "advertising.h"
 
 #define AD_PATH "/org/bluez/advertising"
@@ -82,7 +82,7 @@ static void ad_release(DBusConnection *conn)
 static DBusMessage *release_advertising(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
-	rl_printf("Advertising released\n");
+	bt_shell_printf("Advertising released\n");
 
 	ad_release(conn);
 
@@ -117,14 +117,14 @@ static void register_reply(DBusMessage *message, void *user_data)
 
 	if (dbus_set_error_from_message(&error, message) == FALSE) {
 		ad.registered = true;
-		rl_printf("Advertising object registered\n");
+		bt_shell_printf("Advertising object registered\n");
 	} else {
-		rl_printf("Failed to register advertisement: %s\n", error.name);
+		bt_shell_printf("Failed to register advertisement: %s\n", error.name);
 		dbus_error_free(&error);
 
 		if (g_dbus_unregister_interface(conn, AD_PATH,
 						AD_IFACE) == FALSE)
-			rl_printf("Failed to unregister advertising object\n");
+			bt_shell_printf("Failed to unregister advertising object\n");
 	}
 }
 
@@ -368,7 +368,7 @@ static const GDBusPropertyTable ad_props[] = {
 void ad_register(DBusConnection *conn, GDBusProxy *manager, const char *type)
 {
 	if (ad.registered) {
-		rl_printf("Advertisement is already registered\n");
+		bt_shell_printf("Advertisement is already registered\n");
 		return;
 	}
 
@@ -377,14 +377,14 @@ void ad_register(DBusConnection *conn, GDBusProxy *manager, const char *type)
 
 	if (g_dbus_register_interface(conn, AD_PATH, AD_IFACE, ad_methods,
 					NULL, ad_props, NULL, NULL) == FALSE) {
-		rl_printf("Failed to register advertising object\n");
+		bt_shell_printf("Failed to register advertising object\n");
 		return;
 	}
 
 	if (g_dbus_proxy_method_call(manager, "RegisterAdvertisement",
 					register_setup, register_reply,
 					conn, NULL) == FALSE) {
-		rl_printf("Failed to register advertising\n");
+		bt_shell_printf("Failed to register advertising\n");
 		return;
 	}
 }
@@ -405,12 +405,12 @@ static void unregister_reply(DBusMessage *message, void *user_data)
 
 	if (dbus_set_error_from_message(&error, message) == FALSE) {
 		ad.registered = false;
-		rl_printf("Advertising object unregistered\n");
+		bt_shell_printf("Advertising object unregistered\n");
 		if (g_dbus_unregister_interface(conn, AD_PATH,
 							AD_IFACE) == FALSE)
-			rl_printf("Failed to unregister advertising object\n");
+			bt_shell_printf("Failed to unregister advertising object\n");
 	} else {
-		rl_printf("Failed to unregister advertisement: %s\n",
+		bt_shell_printf("Failed to unregister advertisement: %s\n",
 								error.name);
 		dbus_error_free(&error);
 	}
@@ -430,7 +430,7 @@ void ad_unregister(DBusConnection *conn, GDBusProxy *manager)
 	if (g_dbus_proxy_method_call(manager, "UnregisterAdvertisement",
 					unregister_setup, unregister_reply,
 					conn, NULL) == FALSE) {
-		rl_printf("Failed to unregister advertisement method\n");
+		bt_shell_printf("Failed to unregister advertisement method\n");
 		return;
 	}
 }
@@ -446,7 +446,7 @@ void ad_advertise_uuids(DBusConnection *conn, const char *arg)
 
 	ad.uuids = g_strsplit(arg, " ", -1);
 	if (!ad.uuids) {
-		rl_printf("Failed to parse input\n");
+		bt_shell_printf("Failed to parse input\n");
 		return;
 	}
 
@@ -468,7 +468,7 @@ void ad_advertise_service(DBusConnection *conn, const char *arg)
 	struct ad_data *data;
 
 	if (wordexp(arg, &w, WRDE_NOCMD)) {
-		rl_printf("Invalid argument\n");
+		bt_shell_printf("Invalid argument\n");
 		return;
 	}
 
@@ -485,14 +485,14 @@ void ad_advertise_service(DBusConnection *conn, const char *arg)
 		char *endptr = NULL;
 
 		if (i >= G_N_ELEMENTS(data->data)) {
-			rl_printf("Too much data\n");
+			bt_shell_printf("Too much data\n");
 			ad_clear_service();
 			goto done;
 		}
 
 		val = strtol(w.we_wordv[i], &endptr, 0);
 		if (!endptr || *endptr != '\0' || val > UINT8_MAX) {
-			rl_printf("Invalid value at index %d\n", i);
+			bt_shell_printf("Invalid value at index %d\n", i);
 			ad_clear_service();
 			goto done;
 		}
@@ -521,7 +521,7 @@ void ad_advertise_manufacturer(DBusConnection *conn, const char *arg)
 	struct ad_data *data;
 
 	if (wordexp(arg, &w, WRDE_NOCMD)) {
-		rl_printf("Invalid argument\n");
+		bt_shell_printf("Invalid argument\n");
 		return;
 	}
 
@@ -532,7 +532,7 @@ void ad_advertise_manufacturer(DBusConnection *conn, const char *arg)
 
 	val = strtol(w.we_wordv[0], &endptr, 0);
 	if (!endptr || *endptr != '\0' || val > UINT16_MAX) {
-		rl_printf("Invalid manufacture id\n");
+		bt_shell_printf("Invalid manufacture id\n");
 		goto done;
 	}
 
@@ -541,14 +541,14 @@ void ad_advertise_manufacturer(DBusConnection *conn, const char *arg)
 
 	for (i = 1; i < w.we_wordc; i++) {
 		if (i >= G_N_ELEMENTS(data->data)) {
-			rl_printf("Too much data\n");
+			bt_shell_printf("Too much data\n");
 			ad_clear_manufacturer();
 			goto done;
 		}
 
 		val = strtol(w.we_wordv[i], &endptr, 0);
 		if (!endptr || *endptr != '\0' || val > UINT8_MAX) {
-			rl_printf("Invalid value at index %d\n", i);
+			bt_shell_printf("Invalid value at index %d\n", i);
 			ad_clear_manufacturer();
 			goto done;
 		}
diff --git a/client/agent.c b/client/agent.c
index dedd6abe6..e8ca4dd19 100644
--- a/client/agent.c
+++ b/client/agent.c
@@ -27,10 +27,12 @@
 
 #include <stdio.h>
 #include <stdlib.h>
-#include <readline/readline.h>
+#include <stdbool.h>
+#include <unistd.h>
+#include <string.h>
 
+#include "src/shared/shell.h"
 #include "gdbus/gdbus.h"
-#include "display.h"
 #include "agent.h"
 
 #define AGENT_PATH "/org/bluez/agent"
@@ -47,7 +49,7 @@ static void agent_release_prompt(void)
 	if (!pending_message)
 		return;
 
-	rl_release_prompt("");
+	bt_shell_release_prompt("");
 }
 
 dbus_bool_t agent_completion(void)
@@ -114,7 +116,7 @@ static void agent_release(DBusConnection *conn)
 static DBusMessage *release_agent(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
-	rl_printf("Agent released\n");
+	bt_shell_printf("Agent released\n");
 
 	agent_release(conn);
 
@@ -126,12 +128,13 @@ static DBusMessage *request_pincode(DBusConnection *conn,
 {
 	const char *device;
 
-	rl_printf("Request PIN code\n");
+	bt_shell_printf("Request PIN code\n");
 
 	dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &device,
 							DBUS_TYPE_INVALID);
 
-	rl_prompt_input("agent", "Enter PIN code:", pincode_response, conn);
+	bt_shell_prompt_input("agent", "Enter PIN code:", pincode_response,
+								conn);
 
 	pending_message = dbus_message_ref(msg);
 
@@ -147,7 +150,7 @@ static DBusMessage *display_pincode(DBusConnection *conn,
 	dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &device,
 				DBUS_TYPE_STRING, &pincode, DBUS_TYPE_INVALID);
 
-	rl_printf(AGENT_PROMPT "PIN code: %s\n", pincode);
+	bt_shell_printf(AGENT_PROMPT "PIN code: %s\n", pincode);
 
 	return dbus_message_new_method_return(msg);
 }
@@ -157,13 +160,13 @@ static DBusMessage *request_passkey(DBusConnection *conn,
 {
 	const char *device;
 
-	rl_printf("Request passkey\n");
+	bt_shell_printf("Request passkey\n");
 
 	dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &device,
 							DBUS_TYPE_INVALID);
 
-	rl_prompt_input("agent", "Enter passkey (number in 0-999999):",
-			passkey_response, conn);
+	bt_shell_prompt_input("agent", "Enter passkey (number in 0-999999):",
+						passkey_response, conn);
 
 	pending_message = dbus_message_ref(msg);
 
@@ -188,7 +191,7 @@ static DBusMessage *display_passkey(DBusConnection *conn,
 	if (entered > strlen(passkey_full))
 		entered = strlen(passkey_full);
 
-	rl_printf(AGENT_PROMPT "Passkey: "
+	bt_shell_printf(AGENT_PROMPT "Passkey: "
 			COLOR_BOLDGRAY "%.*s" COLOR_BOLDWHITE "%s\n" COLOR_OFF,
 				entered, passkey_full, passkey_full + entered);
 
@@ -202,13 +205,13 @@ static DBusMessage *request_confirmation(DBusConnection *conn,
 	dbus_uint32_t passkey;
 	char *str;
 
-	rl_printf("Request confirmation\n");
+	bt_shell_printf("Request confirmation\n");
 
 	dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &device,
 				DBUS_TYPE_UINT32, &passkey, DBUS_TYPE_INVALID);
 
 	str = g_strdup_printf("Confirm passkey %06u (yes/no):", passkey);
-	rl_prompt_input("agent", str, confirm_response, conn);
+	bt_shell_prompt_input("agent", str, confirm_response, conn);
 	g_free(str);
 
 	pending_message = dbus_message_ref(msg);
@@ -221,13 +224,13 @@ static DBusMessage *request_authorization(DBusConnection *conn,
 {
 	const char *device;
 
-	rl_printf("Request authorization\n");
+	bt_shell_printf("Request authorization\n");
 
 	dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &device,
 							DBUS_TYPE_INVALID);
 
-	rl_prompt_input("agent", "Accept pairing (yes/no):", confirm_response,
-								conn);
+	bt_shell_prompt_input("agent", "Accept pairing (yes/no):",
+					confirm_response, conn);
 
 	pending_message = dbus_message_ref(msg);
 
@@ -240,13 +243,13 @@ static DBusMessage *authorize_service(DBusConnection *conn,
 	const char *device, *uuid;
 	char *str;
 
-	rl_printf("Authorize service\n");
+	bt_shell_printf("Authorize service\n");
 
 	dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &device,
 				DBUS_TYPE_STRING, &uuid, DBUS_TYPE_INVALID);
 
 	str = g_strdup_printf("Authorize service %s (yes/no):", uuid);
-	rl_prompt_input("agent", str, confirm_response, conn);
+	bt_shell_prompt_input("agent", str, confirm_response, conn);
 	g_free(str);
 
 	pending_message = dbus_message_ref(msg);
@@ -257,7 +260,7 @@ static DBusMessage *authorize_service(DBusConnection *conn,
 static DBusMessage *cancel_request(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
-	rl_printf("Request canceled\n");
+	bt_shell_printf("Request canceled\n");
 
 	agent_release_prompt();
 	dbus_message_unref(pending_message);
@@ -312,14 +315,14 @@ static void register_agent_reply(DBusMessage *message, void *user_data)
 
 	if (dbus_set_error_from_message(&error, message) == FALSE) {
 		agent_registered = TRUE;
-		rl_printf("Agent registered\n");
+		bt_shell_printf("Agent registered\n");
 	} else {
-		rl_printf("Failed to register agent: %s\n", error.name);
+		bt_shell_printf("Failed to register agent: %s\n", error.name);
 		dbus_error_free(&error);
 
 		if (g_dbus_unregister_interface(conn, AGENT_PATH,
 						AGENT_INTERFACE) == FALSE)
-			rl_printf("Failed to unregister agent object\n");
+			bt_shell_printf("Failed to unregister agent object\n");
 	}
 }
 
@@ -328,7 +331,7 @@ void agent_register(DBusConnection *conn, GDBusProxy *manager,
 
 {
 	if (agent_registered == TRUE) {
-		rl_printf("Agent is already registered\n");
+		bt_shell_printf("Agent is already registered\n");
 		return;
 	}
 
@@ -337,7 +340,7 @@ void agent_register(DBusConnection *conn, GDBusProxy *manager,
 	if (g_dbus_register_interface(conn, AGENT_PATH,
 					AGENT_INTERFACE, methods,
 					NULL, NULL, NULL, NULL) == FALSE) {
-		rl_printf("Failed to register agent object\n");
+		bt_shell_printf("Failed to register agent object\n");
 		return;
 	}
 
@@ -345,7 +348,7 @@ void agent_register(DBusConnection *conn, GDBusProxy *manager,
 						register_agent_setup,
 						register_agent_reply,
 						conn, NULL) == FALSE) {
-		rl_printf("Failed to call register agent method\n");
+		bt_shell_printf("Failed to call register agent method\n");
 		return;
 	}
 
@@ -367,10 +370,10 @@ static void unregister_agent_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == FALSE) {
-		rl_printf("Agent unregistered\n");
+		bt_shell_printf("Agent unregistered\n");
 		agent_release(conn);
 	} else {
-		rl_printf("Failed to unregister agent: %s\n", error.name);
+		bt_shell_printf("Failed to unregister agent: %s\n", error.name);
 		dbus_error_free(&error);
 	}
 }
@@ -378,12 +381,12 @@ static void unregister_agent_reply(DBusMessage *message, void *user_data)
 void agent_unregister(DBusConnection *conn, GDBusProxy *manager)
 {
 	if (agent_registered == FALSE) {
-		rl_printf("No agent is registered\n");
+		bt_shell_printf("No agent is registered\n");
 		return;
 	}
 
 	if (!manager) {
-		rl_printf("Agent unregistered\n");
+		bt_shell_printf("Agent unregistered\n");
 		agent_release(conn);
 		return;
 	}
@@ -392,7 +395,7 @@ void agent_unregister(DBusConnection *conn, GDBusProxy *manager)
 						unregister_agent_setup,
 						unregister_agent_reply,
 						conn, NULL) == FALSE) {
-		rl_printf("Failed to call unregister agent method\n");
+		bt_shell_printf("Failed to call unregister agent method\n");
 		return;
 	}
 }
@@ -411,18 +414,19 @@ static void request_default_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to request default agent: %s\n", error.name);
+		bt_shell_printf("Failed to request default agent: %s\n",
+							error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Default agent request successful\n");
+	bt_shell_printf("Default agent request successful\n");
 }
 
 void agent_default(DBusConnection *conn, GDBusProxy *manager)
 {
 	if (agent_registered == FALSE) {
-		rl_printf("No agent is registered\n");
+		bt_shell_printf("No agent is registered\n");
 		return;
 	}
 
@@ -430,7 +434,7 @@ void agent_default(DBusConnection *conn, GDBusProxy *manager)
 						request_default_setup,
 						request_default_reply,
 						NULL, NULL) == FALSE) {
-		rl_printf("Failed to call request default agent method\n");
+		bt_shell_printf("Failed to call RequestDefaultAgent method\n");
 		return;
 	}
 }
diff --git a/client/gatt.c b/client/gatt.c
index 93aec92e7..ed0e71a20 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -33,16 +33,15 @@
 #include <sys/uio.h>
 #include <wordexp.h>
 #include <fcntl.h>
+#include <string.h>
 
-#include <readline/readline.h>
-#include <readline/history.h>
 #include <glib.h>
 
 #include "src/shared/queue.h"
 #include "src/shared/io.h"
+#include "src/shared/shell.h"
 #include "gdbus/gdbus.h"
 #include "monitor/uuid.h"
-#include "display.h"
 #include "gatt.h"
 
 #define APP_PATH "/org/bluez/app"
@@ -109,7 +108,7 @@ static void print_service(struct service *service, const char *description)
 
 	text = uuidstr_to_str(service->uuid);
 	if (!text)
-		rl_printf("%s%s%s%s Service\n\t%s\n\t%s\n",
+		bt_shell_printf("%s%s%s%s Service\n\t%s\n\t%s\n",
 					description ? "[" : "",
 					description ? : "",
 					description ? "] " : "",
@@ -117,7 +116,7 @@ static void print_service(struct service *service, const char *description)
 					"Secondary",
 					service->path, service->uuid);
 	else
-		rl_printf("%s%s%s%s Service\n\t%s\n\t%s\n\t%s\n",
+		bt_shell_printf("%s%s%s%s Service\n\t%s\n\t%s\n\t%s\n",
 					description ? "[" : "",
 					description ? : "",
 					description ? "] " : "",
@@ -176,13 +175,13 @@ static void print_chrc(struct chrc *chrc, const char *description)
 
 	text = uuidstr_to_str(chrc->uuid);
 	if (!text)
-		rl_printf("%s%s%sCharacteristic\n\t%s\n\t%s\n",
+		bt_shell_printf("%s%s%sCharacteristic\n\t%s\n\t%s\n",
 					description ? "[" : "",
 					description ? : "",
 					description ? "] " : "",
 					chrc->path, chrc->uuid);
 	else
-		rl_printf("%s%s%sCharacteristic\n\t%s\n\t%s\n\t%s\n",
+		bt_shell_printf("%s%s%sCharacteristic\n\t%s\n\t%s\n\t%s\n",
 					description ? "[" : "",
 					description ? : "",
 					description ? "] " : "",
@@ -275,13 +274,13 @@ static void print_desc(struct desc *desc, const char *description)
 
 	text = uuidstr_to_str(desc->uuid);
 	if (!text)
-		rl_printf("%s%s%sDescriptor\n\t%s\n\t%s\n",
+		bt_shell_printf("%s%s%sDescriptor\n\t%s\n\t%s\n",
 					description ? "[" : "",
 					description ? : "",
 					description ? "] " : "",
 					desc->path, desc->uuid);
 	else
-		rl_printf("%s%s%sDescriptor\n\t%s\n\t%s\n\t%s\n",
+		bt_shell_printf("%s%s%sDescriptor\n\t%s\n\t%s\n\t%s\n",
 					description ? "[" : "",
 					description ? : "",
 					description ? "] " : "",
@@ -523,7 +522,7 @@ static void read_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to read: %s\n", error.name);
+		bt_shell_printf("Failed to read: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
@@ -531,7 +530,7 @@ static void read_reply(DBusMessage *message, void *user_data)
 	dbus_message_iter_init(message, &iter);
 
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY) {
-		rl_printf("Invalid response to read\n");
+		bt_shell_printf("Invalid response to read\n");
 		return;
 	}
 
@@ -539,11 +538,11 @@ static void read_reply(DBusMessage *message, void *user_data)
 	dbus_message_iter_get_fixed_array(&array, &value, &len);
 
 	if (len < 0) {
-		rl_printf("Unable to parse value\n");
+		bt_shell_printf("Unable to parse value\n");
 		return;
 	}
 
-	rl_hexdump(value, len);
+	bt_shell_hexdump(value, len);
 }
 
 static void read_setup(DBusMessageIter *iter, void *user_data)
@@ -564,11 +563,11 @@ static void read_attribute(GDBusProxy *proxy)
 {
 	if (g_dbus_proxy_method_call(proxy, "ReadValue", read_setup, read_reply,
 							NULL, NULL) == FALSE) {
-		rl_printf("Failed to read\n");
+		bt_shell_printf("Failed to read\n");
 		return;
 	}
 
-	rl_printf("Attempting to read %s\n", g_dbus_proxy_get_path(proxy));
+	bt_shell_printf("Attempting to read %s\n", g_dbus_proxy_get_path(proxy));
 }
 
 void gatt_read_attribute(GDBusProxy *proxy)
@@ -582,7 +581,7 @@ void gatt_read_attribute(GDBusProxy *proxy)
 		return;
 	}
 
-	rl_printf("Unable to read attribute %s\n",
+	bt_shell_printf("Unable to read attribute %s\n",
 						g_dbus_proxy_get_path(proxy));
 }
 
@@ -593,7 +592,7 @@ static void write_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to write: %s\n", error.name);
+		bt_shell_printf("Failed to write: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
@@ -634,13 +633,13 @@ static void write_attribute(GDBusProxy *proxy, char *arg)
 			continue;
 
 		if (i >= G_N_ELEMENTS(value)) {
-			rl_printf("Too much data\n");
+			bt_shell_printf("Too much data\n");
 			return;
 		}
 
 		val = strtol(entry, &endptr, 0);
 		if (!endptr || *endptr != '\0' || val > UINT8_MAX) {
-			rl_printf("Invalid value at index %d\n", i);
+			bt_shell_printf("Invalid value at index %d\n", i);
 			return;
 		}
 
@@ -652,10 +651,10 @@ static void write_attribute(GDBusProxy *proxy, char *arg)
 
 	/* Write using the fd if it has been acquired and fit the MTU */
 	if (proxy == write_io.proxy && (write_io.io && write_io.mtu >= i)) {
-		rl_printf("Attempting to write fd %d\n",
+		bt_shell_printf("Attempting to write fd %d\n",
 						io_get_fd(write_io.io));
 		if (io_send(write_io.io, &iov, 1) < 0) {
-			rl_printf("Failed to write: %s", strerror(errno));
+			bt_shell_printf("Failed to write: %s", strerror(errno));
 			return;
 		}
 		return;
@@ -663,11 +662,11 @@ static void write_attribute(GDBusProxy *proxy, char *arg)
 
 	if (g_dbus_proxy_method_call(proxy, "WriteValue", write_setup,
 					write_reply, &iov, NULL) == FALSE) {
-		rl_printf("Failed to write\n");
+		bt_shell_printf("Failed to write\n");
 		return;
 	}
 
-	rl_printf("Attempting to write %s\n", g_dbus_proxy_get_path(proxy));
+	bt_shell_printf("Attempting to write %s\n", g_dbus_proxy_get_path(proxy));
 }
 
 void gatt_write_attribute(GDBusProxy *proxy, const char *arg)
@@ -681,7 +680,7 @@ void gatt_write_attribute(GDBusProxy *proxy, const char *arg)
 		return;
 	}
 
-	rl_printf("Unable to write attribute %s\n",
+	bt_shell_printf("Unable to write attribute %s\n",
 						g_dbus_proxy_get_path(proxy));
 }
 
@@ -700,13 +699,13 @@ static bool pipe_read(struct io *io, void *user_data)
 		return false;
 
 	if (chrc)
-		rl_printf("[" COLORED_CHG "] Attribute %s written:\n",
+		bt_shell_printf("[" COLORED_CHG "] Attribute %s written:\n",
 							chrc->path);
 	else
-		rl_printf("[" COLORED_CHG "] %s Notification:\n",
+		bt_shell_printf("[" COLORED_CHG "] %s Notification:\n",
 				g_dbus_proxy_get_path(notify_io.proxy));
 
-	rl_hexdump(buf, bytes_read);
+	bt_shell_hexdump(buf, bytes_read);
 
 	return true;
 }
@@ -716,7 +715,7 @@ static bool pipe_hup(struct io *io, void *user_data)
 	struct chrc *chrc = user_data;
 
 	if (chrc) {
-		rl_printf("Attribute %s Write pipe closed\n", chrc->path);
+		bt_shell_printf("Attribute %s Write pipe closed\n", chrc->path);
 		if (chrc->write_io) {
 			io_destroy(chrc->write_io);
 			chrc->write_io = NULL;
@@ -724,7 +723,7 @@ static bool pipe_hup(struct io *io, void *user_data)
 		return false;
 	}
 
-	rl_printf("%s closed\n", io == notify_io.io ? "Notify" : "Write");
+	bt_shell_printf("%s closed\n", io == notify_io.io ? "Notify" : "Write");
 
 	if (io == notify_io.io)
 		notify_io_destroy();
@@ -757,7 +756,7 @@ static void acquire_write_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to acquire write: %s\n", error.name);
+		bt_shell_printf("Failed to acquire write: %s\n", error.name);
 		dbus_error_free(&error);
 		write_io.proxy = NULL;
 		return;
@@ -769,11 +768,11 @@ static void acquire_write_reply(DBusMessage *message, void *user_data)
 	if ((dbus_message_get_args(message, NULL, DBUS_TYPE_UNIX_FD, &fd,
 					DBUS_TYPE_UINT16, &write_io.mtu,
 					DBUS_TYPE_INVALID) == false)) {
-		rl_printf("Invalid AcquireWrite response\n");
+		bt_shell_printf("Invalid AcquireWrite response\n");
 		return;
 	}
 
-	rl_printf("AcquireWrite success: fd %d MTU %u\n", fd, write_io.mtu);
+	bt_shell_printf("AcquireWrite success: fd %d MTU %u\n", fd, write_io.mtu);
 
 	write_io.io = pipe_io_new(fd, NULL);
 }
@@ -798,14 +797,14 @@ void gatt_acquire_write(GDBusProxy *proxy, const char *arg)
 
 	iface = g_dbus_proxy_get_interface(proxy);
 	if (strcmp(iface, "org.bluez.GattCharacteristic1")) {
-		rl_printf("Unable to acquire write: %s not a characteristic\n",
+		bt_shell_printf("Unable to acquire write: %s not a characteristic\n",
 						g_dbus_proxy_get_path(proxy));
 		return;
 	}
 
 	if (g_dbus_proxy_method_call(proxy, "AcquireWrite", acquire_setup,
 				acquire_write_reply, NULL, NULL) == FALSE) {
-		rl_printf("Failed to AcquireWrite\n");
+		bt_shell_printf("Failed to AcquireWrite\n");
 		return;
 	}
 
@@ -815,7 +814,7 @@ void gatt_acquire_write(GDBusProxy *proxy, const char *arg)
 void gatt_release_write(GDBusProxy *proxy, const char *arg)
 {
 	if (proxy != write_io.proxy || !write_io.io) {
-		rl_printf("Write not acquired\n");
+		bt_shell_printf("Write not acquired\n");
 		return;
 	}
 
@@ -830,7 +829,7 @@ static void acquire_notify_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to acquire notify: %s\n", error.name);
+		bt_shell_printf("Failed to acquire notify: %s\n", error.name);
 		dbus_error_free(&error);
 		write_io.proxy = NULL;
 		return;
@@ -846,11 +845,11 @@ static void acquire_notify_reply(DBusMessage *message, void *user_data)
 	if ((dbus_message_get_args(message, NULL, DBUS_TYPE_UNIX_FD, &fd,
 					DBUS_TYPE_UINT16, &notify_io.mtu,
 					DBUS_TYPE_INVALID) == false)) {
-		rl_printf("Invalid AcquireNotify response\n");
+		bt_shell_printf("Invalid AcquireNotify response\n");
 		return;
 	}
 
-	rl_printf("AcquireNotify success: fd %d MTU %u\n", fd, notify_io.mtu);
+	bt_shell_printf("AcquireNotify success: fd %d MTU %u\n", fd, notify_io.mtu);
 
 	notify_io.io = pipe_io_new(fd, NULL);
 }
@@ -861,14 +860,14 @@ void gatt_acquire_notify(GDBusProxy *proxy, const char *arg)
 
 	iface = g_dbus_proxy_get_interface(proxy);
 	if (strcmp(iface, "org.bluez.GattCharacteristic1")) {
-		rl_printf("Unable to acquire notify: %s not a characteristic\n",
+		bt_shell_printf("Unable to acquire notify: %s not a characteristic\n",
 						g_dbus_proxy_get_path(proxy));
 		return;
 	}
 
 	if (g_dbus_proxy_method_call(proxy, "AcquireNotify", acquire_setup,
 				acquire_notify_reply, NULL, NULL) == FALSE) {
-		rl_printf("Failed to AcquireNotify\n");
+		bt_shell_printf("Failed to AcquireNotify\n");
 		return;
 	}
 
@@ -878,7 +877,7 @@ void gatt_acquire_notify(GDBusProxy *proxy, const char *arg)
 void gatt_release_notify(GDBusProxy *proxy, const char *arg)
 {
 	if (proxy != notify_io.proxy || !notify_io.io) {
-		rl_printf("Notify not acquired\n");
+		bt_shell_printf("Notify not acquired\n");
 		return;
 	}
 
@@ -893,13 +892,13 @@ static void notify_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to %s notify: %s\n",
+		bt_shell_printf("Failed to %s notify: %s\n",
 				enable ? "start" : "stop", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Notify %s\n", enable == TRUE ? "started" : "stopped");
+	bt_shell_printf("Notify %s\n", enable == TRUE ? "started" : "stopped");
 }
 
 static void notify_attribute(GDBusProxy *proxy, bool enable)
@@ -913,7 +912,7 @@ static void notify_attribute(GDBusProxy *proxy, bool enable)
 
 	if (g_dbus_proxy_method_call(proxy, method, NULL, notify_reply,
 				GUINT_TO_POINTER(enable), NULL) == FALSE) {
-		rl_printf("Failed to %s notify\n", enable ? "start" : "stop");
+		bt_shell_printf("Failed to %s notify\n", enable ? "start" : "stop");
 		return;
 	}
 }
@@ -928,7 +927,7 @@ void gatt_notify_attribute(GDBusProxy *proxy, bool enable)
 		return;
 	}
 
-	rl_printf("Unable to notify attribute %s\n",
+	bt_shell_printf("Unable to notify attribute %s\n",
 						g_dbus_proxy_get_path(proxy));
 }
 
@@ -956,12 +955,12 @@ static void register_app_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to register application: %s\n", error.name);
+		bt_shell_printf("Failed to register application: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Application registered\n");
+	bt_shell_printf("Application registered\n");
 }
 
 void gatt_add_manager(GDBusProxy *proxy)
@@ -1026,7 +1025,7 @@ void gatt_register_app(DBusConnection *conn, GDBusProxy *proxy, wordexp_t *w)
 
 	l = g_list_find_custom(managers, proxy, match_proxy);
 	if (!l) {
-		rl_printf("Unable to find GattManager proxy\n");
+		bt_shell_printf("Unable to find GattManager proxy\n");
 		return;
 	}
 
@@ -1038,7 +1037,7 @@ void gatt_register_app(DBusConnection *conn, GDBusProxy *proxy, wordexp_t *w)
 						PROFILE_INTERFACE, methods,
 						NULL, properties, NULL,
 						NULL) == FALSE) {
-			rl_printf("Failed to register application object\n");
+			bt_shell_printf("Failed to register application object\n");
 			return;
 		}
 	}
@@ -1047,7 +1046,7 @@ void gatt_register_app(DBusConnection *conn, GDBusProxy *proxy, wordexp_t *w)
 						register_app_setup,
 						register_app_reply, w,
 						NULL) == FALSE) {
-		rl_printf("Failed register application\n");
+		bt_shell_printf("Failed register application\n");
 		g_dbus_unregister_interface(conn, APP_PATH, PROFILE_INTERFACE);
 		return;
 	}
@@ -1061,12 +1060,12 @@ static void unregister_app_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to unregister application: %s\n", error.name);
+		bt_shell_printf("Failed to unregister application: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Application unregistered\n");
+	bt_shell_printf("Application unregistered\n");
 
 	if (!uuids)
 		return;
@@ -1090,7 +1089,7 @@ void gatt_unregister_app(DBusConnection *conn, GDBusProxy *proxy)
 
 	l = g_list_find_custom(managers, proxy, match_proxy);
 	if (!l) {
-		rl_printf("Unable to find GattManager proxy\n");
+		bt_shell_printf("Unable to find GattManager proxy\n");
 		return;
 	}
 
@@ -1098,7 +1097,7 @@ void gatt_unregister_app(DBusConnection *conn, GDBusProxy *proxy)
 						unregister_app_setup,
 						unregister_app_reply, conn,
 						NULL) == FALSE) {
-		rl_printf("Failed unregister profile\n");
+		bt_shell_printf("Failed unregister profile\n");
 		return;
 	}
 }
@@ -1194,7 +1193,7 @@ static void service_set_primary(const char *input, void *user_data)
 	else if (!strcmp(input, "no")) {
 		service->primary = false;
 	} else {
-		rl_printf("Invalid option: %s\n", input);
+		bt_shell_printf("Invalid option: %s\n", input);
 		local_services = g_list_remove(local_services, service);
 		print_service(service, COLORED_DEL);
 		g_dbus_unregister_interface(service->conn, service->path,
@@ -1218,7 +1217,7 @@ void gatt_register_service(DBusConnection *conn, GDBusProxy *proxy,
 					SERVICE_INTERFACE, NULL, NULL,
 					service_properties, service,
 					service_free) == FALSE) {
-		rl_printf("Failed to register service object\n");
+		bt_shell_printf("Failed to register service object\n");
 		service_free(service);
 		return;
 	}
@@ -1227,7 +1226,7 @@ void gatt_register_service(DBusConnection *conn, GDBusProxy *proxy,
 
 	local_services = g_list_append(local_services, service);
 
-	rl_prompt_input(service->path, "Primary (yes/no):", service_set_primary,
+	bt_shell_prompt_input(service->path, "Primary (yes/no):", service_set_primary,
 			service);
 }
 
@@ -1257,7 +1256,7 @@ void gatt_unregister_service(DBusConnection *conn, GDBusProxy *proxy,
 
 	service = service_find(w->we_wordv[0]);
 	if (!service) {
-		rl_printf("Failed to unregister service object\n");
+		bt_shell_printf("Failed to unregister service object\n");
 		return;
 	}
 
@@ -1455,7 +1454,7 @@ static DBusMessage *chrc_write_value(DBusConnection *conn, DBusMessage *msg,
 					"org.bluez.Error.InvalidArguments",
 					NULL);
 
-	rl_printf("[" COLORED_CHG "] Attribute %s written" , chrc->path);
+	bt_shell_printf("[" COLORED_CHG "] Attribute %s written" , chrc->path);
 
 	g_dbus_emit_property_changed(conn, chrc->path, CHRC_INTERFACE, "Value");
 
@@ -1530,7 +1529,7 @@ static DBusMessage *chrc_create_pipe(struct chrc *chrc, DBusMessage *msg)
 	else
 		chrc->notify_io = io;
 
-	rl_printf("[" COLORED_CHG "] Attribute %s %s pipe acquired\n",
+	bt_shell_printf("[" COLORED_CHG "] Attribute %s %s pipe acquired\n",
 					chrc->path, dir ? "Write" : "Notify");
 
 	return reply;
@@ -1601,7 +1600,7 @@ static DBusMessage *chrc_start_notify(DBusConnection *conn, DBusMessage *msg,
 		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 
 	chrc->notifying = true;
-	rl_printf("[" COLORED_CHG "] Attribute %s notifications enabled",
+	bt_shell_printf("[" COLORED_CHG "] Attribute %s notifications enabled",
 							chrc->path);
 	g_dbus_emit_property_changed(conn, chrc->path, CHRC_INTERFACE,
 							"Notifying");
@@ -1618,7 +1617,7 @@ static DBusMessage *chrc_stop_notify(DBusConnection *conn, DBusMessage *msg,
 		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 
 	chrc->notifying = false;
-	rl_printf("[" COLORED_CHG "] Attribute %s notifications disabled",
+	bt_shell_printf("[" COLORED_CHG "] Attribute %s notifications disabled",
 							chrc->path);
 	g_dbus_emit_property_changed(conn, chrc->path, CHRC_INTERFACE,
 							"Notifying");
@@ -1631,7 +1630,7 @@ static DBusMessage *chrc_confirm(DBusConnection *conn, DBusMessage *msg,
 {
 	struct chrc *chrc = user_data;
 
-	rl_printf("Attribute %s indication confirm received", chrc->path);
+	bt_shell_printf("Attribute %s indication confirm received", chrc->path);
 
 	return dbus_message_new_method_return(msg);
 }
@@ -1667,13 +1666,13 @@ static uint8_t *str2bytearray(char *arg, int *val_len)
 			continue;
 
 		if (i >= G_N_ELEMENTS(value)) {
-			rl_printf("Too much data\n");
+			bt_shell_printf("Too much data\n");
 			return NULL;
 		}
 
 		val = strtol(entry, &endptr, 0);
 		if (!endptr || *endptr != '\0' || val > UINT8_MAX) {
-			rl_printf("Invalid value at index %d\n", i);
+			bt_shell_printf("Invalid value at index %d\n", i);
 			return NULL;
 		}
 
@@ -1700,7 +1699,7 @@ void gatt_register_chrc(DBusConnection *conn, GDBusProxy *proxy, wordexp_t *w)
 	struct chrc *chrc;
 
 	if (!local_services) {
-		rl_printf("No service registered\n");
+		bt_shell_printf("No service registered\n");
 		return;
 	}
 
@@ -1715,7 +1714,7 @@ void gatt_register_chrc(DBusConnection *conn, GDBusProxy *proxy, wordexp_t *w)
 	if (g_dbus_register_interface(conn, chrc->path, CHRC_INTERFACE,
 					chrc_methods, NULL, chrc_properties,
 					chrc, chrc_free) == FALSE) {
-		rl_printf("Failed to register characteristic object\n");
+		bt_shell_printf("Failed to register characteristic object\n");
 		chrc_free(chrc);
 		return;
 	}
@@ -1724,7 +1723,7 @@ void gatt_register_chrc(DBusConnection *conn, GDBusProxy *proxy, wordexp_t *w)
 
 	print_chrc(chrc, COLORED_NEW);
 
-	rl_prompt_input(chrc->path, "Enter value:", chrc_set_value, chrc);
+	bt_shell_prompt_input(chrc->path, "Enter value:", chrc_set_value, chrc);
 }
 
 static struct chrc *chrc_find(const char *pattern)
@@ -1759,7 +1758,7 @@ void gatt_unregister_chrc(DBusConnection *conn, GDBusProxy *proxy,
 
 	chrc = chrc_find(w->we_wordv[0]);
 	if (!chrc) {
-		rl_printf("Failed to unregister characteristic object\n");
+		bt_shell_printf("Failed to unregister characteristic object\n");
 		return;
 	}
 
@@ -1789,7 +1788,7 @@ static DBusMessage *desc_write_value(DBusConnection *conn, DBusMessage *msg,
 					"org.bluez.Error.InvalidArguments",
 					NULL);
 
-	rl_printf("[" COLORED_CHG "] Attribute %s written" , desc->path);
+	bt_shell_printf("[" COLORED_CHG "] Attribute %s written" , desc->path);
 
 	g_dbus_emit_property_changed(conn, desc->path, CHRC_INTERFACE, "Value");
 
@@ -1886,14 +1885,14 @@ void gatt_register_desc(DBusConnection *conn, GDBusProxy *proxy, wordexp_t *w)
 	struct desc *desc;
 
 	if (!local_services) {
-		rl_printf("No service registered\n");
+		bt_shell_printf("No service registered\n");
 		return;
 	}
 
 	service = g_list_last(local_services)->data;
 
 	if (!service->chrcs) {
-		rl_printf("No characteristic registered\n");
+		bt_shell_printf("No characteristic registered\n");
 		return;
 	}
 
@@ -1906,7 +1905,7 @@ void gatt_register_desc(DBusConnection *conn, GDBusProxy *proxy, wordexp_t *w)
 	if (g_dbus_register_interface(conn, desc->path, DESC_INTERFACE,
 					desc_methods, NULL, desc_properties,
 					desc, desc_free) == FALSE) {
-		rl_printf("Failed to register descriptor object\n");
+		bt_shell_printf("Failed to register descriptor object\n");
 		desc_free(desc);
 		return;
 	}
@@ -1915,7 +1914,7 @@ void gatt_register_desc(DBusConnection *conn, GDBusProxy *proxy, wordexp_t *w)
 
 	print_desc(desc, COLORED_NEW);
 
-	rl_prompt_input(desc->path, "Enter value:", desc_set_value, desc);
+	bt_shell_prompt_input(desc->path, "Enter value:", desc_set_value, desc);
 }
 
 static struct desc *desc_find(const char *pattern)
@@ -1955,7 +1954,7 @@ void gatt_unregister_desc(DBusConnection *conn, GDBusProxy *proxy,
 
 	desc = desc_find(w->we_wordv[0]);
 	if (!desc) {
-		rl_printf("Failed to unregister descriptor object\n");
+		bt_shell_printf("Failed to unregister descriptor object\n");
 		return;
 	}
 
diff --git a/client/main.c b/client/main.c
index 37a411ba9..bbdd55a98 100644
--- a/client/main.c
+++ b/client/main.c
@@ -30,14 +30,11 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <stdbool.h>
-#include <signal.h>
-#include <sys/signalfd.h>
 #include <wordexp.h>
 
-#include <readline/readline.h>
-#include <readline/history.h>
 #include <glib.h>
 
+#include "src/shared/shell.h"
 #include "src/shared/util.h"
 #include "gdbus/gdbus.h"
 #include "monitor/uuid.h"
@@ -54,7 +51,6 @@
 #define PROMPT_ON	COLOR_BLUE "[bluetooth]" COLOR_OFF "# "
 #define PROMPT_OFF	"Waiting to connect to bluetoothd..."
 
-static GMainLoop *main_loop;
 static DBusConnection *dbus_conn;
 
 static GDBusProxy *agent_manager;
@@ -71,8 +67,6 @@ static GDBusProxy *default_dev;
 static GDBusProxy *default_attr;
 static GList *ctrl_list;
 
-static guint input = 0;
-
 static const char *mode_arguments[] = {
 	"on",
 	"off",
@@ -103,57 +97,21 @@ static void proxy_leak(gpointer data)
 	printf("Leaking proxy %p\n", data);
 }
 
-static gboolean input_handler(GIOChannel *channel, GIOCondition condition,
-							gpointer user_data)
-{
-	if (condition & G_IO_IN) {
-		rl_callback_read_char();
-		return TRUE;
-	}
-
-	if (condition & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
-		g_main_loop_quit(main_loop);
-		return FALSE;
-	}
-
-	return TRUE;
-}
-
-static guint setup_standard_input(void)
+static void setup_standard_input(void)
 {
-	GIOChannel *channel;
-	guint source;
-
-	channel = g_io_channel_unix_new(fileno(stdin));
-
-	source = g_io_add_watch(channel,
-				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-				input_handler, NULL);
-
-	g_io_channel_unref(channel);
-
-	return source;
+	bt_shell_attach(fileno(stdin));
 }
 
 static void connect_handler(DBusConnection *connection, void *user_data)
 {
-	rl_set_prompt(PROMPT_ON);
-	printf("\r");
-	rl_on_new_line();
-	rl_redisplay();
+	bt_shell_set_prompt(PROMPT_ON);
 }
 
 static void disconnect_handler(DBusConnection *connection, void *user_data)
 {
-	if (input > 0) {
-		g_source_remove(input);
-		input = 0;
-	}
+	bt_shell_detach();
 
-	rl_set_prompt(PROMPT_OFF);
-	printf("\r");
-	rl_on_new_line();
-	rl_redisplay();
+	bt_shell_set_prompt(PROMPT_OFF);
 
 	g_list_free_full(ctrl_list, proxy_leak);
 	ctrl_list = NULL;
@@ -493,9 +451,7 @@ static void set_default_device(GDBusProxy *proxy, const char *attribute)
 				attribute ? attribute + strlen(path) : "");
 
 done:
-	rl_set_prompt(desc ? desc : PROMPT_ON);
-	printf("\r");
-	rl_on_new_line();
+	bt_shell_set_prompt(desc ? desc : PROMPT_ON);
 	g_free(desc);
 }
 
@@ -2160,18 +2116,6 @@ done:
 	wordfree(&w);
 }
 
-static void cmd_version(const char *arg)
-{
-	rl_printf("Version %s\n", VERSION);
-}
-
-static void cmd_quit(const char *arg)
-{
-	g_main_loop_quit(main_loop);
-}
-
-static void cmd_help(const char *arg);
-
 static char *generic_generator(const char *text, int state,
 					GList *source, const char *property)
 {
@@ -2414,14 +2358,7 @@ static void cmd_set_advertise_timeout(const char *arg)
 	ad_advertise_timeout(dbus_conn, value);
 }
 
-static const struct {
-	const char *cmd;
-	const char *arg;
-	void (*func) (const char *arg);
-	const char *desc;
-	char * (*gen) (const char *text, int state);
-	void (*disp) (char **matches, int num_matches, int max_length);
-} cmd_table[] = {
+static const struct bt_shell_menu_entry cmd_table[] = {
 	{ "list",         NULL,       cmd_list, "List available controllers" },
 	{ "show",         "[ctrl]",   cmd_show, "Controller information",
 							ctrl_generator },
@@ -2545,230 +2482,9 @@ static const struct {
 	{ "unregister-descriptor", "<UUID/object>",
 					cmd_unregister_descriptor,
 					"Unregister application descriptor" },
-	{ "version",      NULL,       cmd_version, "Display version" },
-	{ "quit",         NULL,       cmd_quit, "Quit program" },
-	{ "exit",         NULL,       cmd_quit, "Quit program" },
-	{ "help",         NULL,       cmd_help,
-					"Display help about this program" },
 	{ }
 };
 
-static char *cmd_generator(const char *text, int state)
-{
-	static int index, len;
-	const char *cmd;
-
-	if (!state) {
-		index = 0;
-		len = strlen(text);
-	}
-
-	while ((cmd = cmd_table[index].cmd)) {
-		index++;
-
-		if (!strncmp(cmd, text, len))
-			return strdup(cmd);
-	}
-
-	return NULL;
-}
-
-static char **cmd_completion(const char *text, int start, int end)
-{
-	char **matches = NULL;
-
-	if (agent_completion() == TRUE) {
-		rl_attempted_completion_over = 1;
-		return NULL;
-	}
-
-	if (start > 0) {
-		int i;
-		char *input_cmd;
-
-		input_cmd = g_strndup(rl_line_buffer, start -1);
-		for (i = 0; cmd_table[i].cmd; i++) {
-			if (strcmp(cmd_table[i].cmd, input_cmd))
-				continue;
-
-			if (!cmd_table[i].gen)
-				continue;
-
-			rl_completion_display_matches_hook = cmd_table[i].disp;
-			matches = rl_completion_matches(text, cmd_table[i].gen);
-			break;
-		}
-		g_free(input_cmd);
-	} else {
-		rl_completion_display_matches_hook = NULL;
-		matches = rl_completion_matches(text, cmd_generator);
-	}
-
-	if (!matches)
-		rl_attempted_completion_over = 1;
-
-	return matches;
-}
-
-static void rl_handler(char *input)
-{
-	char *cmd, *arg;
-	int i;
-
-	if (!input) {
-		rl_insert_text("quit");
-		rl_redisplay();
-		rl_crlf();
-		g_main_loop_quit(main_loop);
-		return;
-	}
-
-	if (!strlen(input))
-		goto done;
-
-	if (!rl_release_prompt(input))
-		goto done;
-
-	if (history_search(input, -1))
-		add_history(input);
-
-	cmd = strtok_r(input, " ", &arg);
-	if (!cmd)
-		goto done;
-
-	if (arg) {
-		int len = strlen(arg);
-		if (len > 0 && arg[len - 1] == ' ')
-			arg[len - 1] = '\0';
-	}
-
-	for (i = 0; cmd_table[i].cmd; i++) {
-		if (strcmp(cmd, cmd_table[i].cmd))
-			continue;
-
-		if (cmd_table[i].func) {
-			cmd_table[i].func(arg);
-			goto done;
-		}
-	}
-
-	printf("Invalid command\n");
-done:
-	free(input);
-}
-
-static void cmd_help(const char *arg)
-{
-	int i;
-
-	printf("Available commands:\n");
-
-	for (i = 0; cmd_table[i].cmd; i++) {
-		if ((int)strlen(cmd_table[i].arg? : "") <=
-					(int)(25 - strlen(cmd_table[i].cmd)))
-			printf("  %s %-*s %s\n", cmd_table[i].cmd,
-					(int)(25 - strlen(cmd_table[i].cmd)),
-					cmd_table[i].arg ? : "",
-					cmd_table[i].desc ? : "");
-		else
-			printf("  %s %-s\n" "  %s %-25s %s\n",
-					cmd_table[i].cmd,
-					cmd_table[i].arg ? : "",
-					"", "",
-					cmd_table[i].desc ? : "");
-	}
-}
-
-static gboolean signal_handler(GIOChannel *channel, GIOCondition condition,
-							gpointer user_data)
-{
-	static bool terminated = false;
-	struct signalfd_siginfo si;
-	ssize_t result;
-	int fd;
-
-	if (condition & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
-		g_main_loop_quit(main_loop);
-		return FALSE;
-	}
-
-	fd = g_io_channel_unix_get_fd(channel);
-
-	result = read(fd, &si, sizeof(si));
-	if (result != sizeof(si))
-		return FALSE;
-
-	switch (si.ssi_signo) {
-	case SIGINT:
-		if (input) {
-			rl_replace_line("", 0);
-			rl_crlf();
-			rl_on_new_line();
-			rl_redisplay();
-			break;
-		}
-
-		/*
-		 * If input was not yet setup up that means signal was received
-		 * while daemon was not yet running. Since user is not able
-		 * to terminate client by CTRL-D or typing exit treat this as
-		 * exit and fall through.
-		 */
-
-		/* fall through */
-	case SIGTERM:
-		if (!terminated) {
-			rl_replace_line("", 0);
-			rl_crlf();
-			g_main_loop_quit(main_loop);
-		}
-
-		terminated = true;
-		break;
-	}
-
-	return TRUE;
-}
-
-static guint setup_signalfd(void)
-{
-	GIOChannel *channel;
-	guint source;
-	sigset_t mask;
-	int fd;
-
-	sigemptyset(&mask);
-	sigaddset(&mask, SIGINT);
-	sigaddset(&mask, SIGTERM);
-
-	if (sigprocmask(SIG_BLOCK, &mask, NULL) < 0) {
-		perror("Failed to set signal mask");
-		return 0;
-	}
-
-	fd = signalfd(-1, &mask, 0);
-	if (fd < 0) {
-		perror("Failed to create signal descriptor");
-		return 0;
-	}
-
-	channel = g_io_channel_unix_new(fd);
-
-	g_io_channel_set_close_on_unref(channel, TRUE);
-	g_io_channel_set_encoding(channel, NULL, NULL);
-	g_io_channel_set_buffered(channel, FALSE);
-
-	source = g_io_add_watch(channel,
-				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-				signal_handler, NULL);
-
-	g_io_channel_unref(channel);
-
-	return source;
-}
-
-static gboolean option_version = FALSE;
-
 static gboolean parse_agent(const char *key, const char *value,
 					gpointer user_data, GError **error)
 {
@@ -2782,8 +2498,6 @@ static gboolean parse_agent(const char *key, const char *value,
 }
 
 static GOptionEntry options[] = {
-	{ "version", 'v', 0, G_OPTION_ARG_NONE, &option_version,
-				"Show version information and exit" },
 	{ "agent", 'a', 0, G_OPTION_ARG_CALLBACK, parse_agent,
 				"Register agent handler", "CAPABILITY" },
 	{ NULL },
@@ -2791,8 +2505,7 @@ static GOptionEntry options[] = {
 
 static void client_ready(GDBusClient *client, void *user_data)
 {
-	if (!input)
-		input = setup_standard_input();
+	setup_standard_input();
 }
 
 int main(int argc, char *argv[])
@@ -2800,7 +2513,6 @@ int main(int argc, char *argv[])
 	GOptionContext *context;
 	GError *error = NULL;
 	GDBusClient *client;
-	guint signal;
 
 	auto_register_agent = g_strdup("");
 
@@ -2818,25 +2530,13 @@ int main(int argc, char *argv[])
 
 	g_option_context_free(context);
 
-	if (option_version == TRUE) {
-		printf("%s\n", VERSION);
-		exit(0);
-	}
+	bt_shell_init(&argc, &argv);
+	bt_shell_set_menu(cmd_table);
+	bt_shell_set_prompt(PROMPT_OFF);
 
-	main_loop = g_main_loop_new(NULL, FALSE);
 	dbus_conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
 	g_dbus_attach_object_manager(dbus_conn);
 
-	setlinebuf(stdout);
-	rl_attempted_completion_function = cmd_completion;
-
-	rl_erase_empty_line = 1;
-	rl_callback_handler_install(NULL, rl_handler);
-
-	rl_set_prompt(PROMPT_OFF);
-	rl_redisplay();
-
-	signal = setup_signalfd();
 	client = g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez");
 
 	g_dbus_client_set_connect_watch(client, connect_handler, NULL);
@@ -2848,18 +2548,11 @@ int main(int argc, char *argv[])
 
 	g_dbus_client_set_ready_watch(client, client_ready, NULL);
 
-	g_main_loop_run(main_loop);
+	bt_shell_run();
 
 	g_dbus_client_unref(client);
-	g_source_remove(signal);
-	if (input > 0)
-		g_source_remove(input);
-
-	rl_message("");
-	rl_callback_handler_remove();
 
 	dbus_connection_unref(dbus_conn);
-	g_main_loop_unref(main_loop);
 
 	g_list_free_full(ctrl_list, proxy_leak);
 
-- 
2.13.6

