Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 01/10] android/client: Add skeleton for GATT interface
Date: Thu, 31 Oct 2013 11:45:06 +0100
Message-ID: <1383216315-30627-2-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1383216315-30627-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1383216315-30627-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds empty functions for all gatt methods
and callbacks.
---
 android/Android.mk       |    7 +
 android/Makefile.am      |    2 +
 android/client/haltest.c |    5 +
 android/client/if-bt.c   |    2 +
 android/client/if-gatt.c |  561 ++++++++++++++++++++++++++++++++++++++++++++++
 android/client/if-main.h |   14 ++
 6 files changed, 591 insertions(+)
 create mode 100644 android/client/if-gatt.c

diff --git a/android/Android.mk b/android/Android.mk
index e47f4a9..72ea8b8 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -121,6 +121,13 @@ LOCAL_SRC_FILES := \
 	client/if-pan.c \
 	client/if-sock.c \
 
+ANDROID_4_3_OR_ABOVE := $(shell echo 0 | awk -v v=$(PLATFORM_SDK_VERSION) 'END {print (v > 17) ? 1 : 0}')
+
+ifeq ($(ANDROID_4_3_OR_ABOVE), 1)
+LOCAL_SRC_FILES += \
+	client/if-gatt.c
+endif
+
 LOCAL_C_INCLUDES += \
 	$(call include-path-for, system-core) \
 	$(call include-path-for, libhardware) \
diff --git a/android/Makefile.am b/android/Makefile.am
index 05a124e..c5b70ab 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -53,6 +53,7 @@ android_haltest_SOURCES = android/client/haltest.c \
 				android/client/tabcompletion.c \
 				android/client/if-av.c \
 				android/client/if-bt.c \
+				android/client/if-gatt.c \
 				android/client/if-hf.c \
 				android/client/if-hh.c \
 				android/client/if-pan.c \
@@ -85,6 +86,7 @@ EXTRA_DIST += android/client/terminal.c \
 		android/client/history.c \
 		android/client/if-av.c \
 		android/client/if-bt.c \
+		android/client/if-gatt.c \
 		android/client/if-hf.c \
 		android/client/if-hh.c \
 		android/client/if-pan.c \
diff --git a/android/client/haltest.c b/android/client/haltest.c
index 7fe0436..bbe8693 100644
--- a/android/client/haltest.c
+++ b/android/client/haltest.c
@@ -32,6 +32,11 @@
 const struct interface *interfaces[] = {
 	&bluetooth_if,
 	&av_if,
+#if PLATFORM_SDK_VERSION > 17
+	&gatt_if,
+	&gatt_client_if,
+	&gatt_server_if,
+#endif
 	&hf_if,
 	&hh_if,
 	&pan_if,
diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 680738e..a3d6286 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -825,6 +825,8 @@ static void get_profile_interface_p(int argc, const char **argv)
 #if PLATFORM_SDK_VERSION > 17
 	else if (strcmp(BT_PROFILE_AV_RC_ID, id) == 0)
 		pif = &dummy; /* TODO: change when if_rc is there */
+	else if (strcmp(BT_PROFILE_GATT_ID, id) == 0)
+		pif = (const void **) &if_gatt;
 #endif
 	else
 		haltest_error("%s is not correct for get_profile_interface\n",
diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
new file mode 100644
index 0000000..09e2a49
--- /dev/null
+++ b/android/client/if-gatt.c
@@ -0,0 +1,561 @@
+/*
+ * Copyright (C) 2013 Intel Corporation
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ *
+ */
+
+#include <hardware/bluetooth.h>
+
+#include "if-main.h"
+
+const btgatt_interface_t *if_gatt = NULL;
+
+/* BT-GATT Client callbacks. */
+
+/* Callback invoked in response to register_client */
+static void gattc_register_client_cb(int status, int client_if,
+							bt_uuid_t *app_uuid)
+{
+}
+
+/* Callback for scan results */
+static void gattc_scan_result_cb(bt_bdaddr_t *bda, int rssi, uint8_t *adv_data)
+{
+}
+
+/* GATT open callback invoked in response to open */
+static void gattc_connect_cb(int conn_id, int status, int client_if,
+							bt_bdaddr_t *bda)
+{
+}
+
+/* Callback invoked in response to close */
+static void gattc_disconnect_cb(int conn_id, int status, int client_if,
+							bt_bdaddr_t *bda)
+{
+}
+
+/*
+ * Invoked in response to search_service when the GATT service search
+ * has been completed.
+ */
+static void gattc_search_complete_cb(int conn_id, int status)
+{
+}
+
+/* Reports GATT services on a remote device */
+static void gattc_search_result_cb(int conn_id, btgatt_srvc_id_t *srvc_id)
+{
+}
+
+/* GATT characteristic enumeration result callback */
+static void gattc_get_characteristic_cb(int conn_id, int status,
+					btgatt_srvc_id_t *srvc_id,
+					btgatt_char_id_t *char_id,
+					int char_prop)
+{
+}
+
+/* GATT descriptor enumeration result callback */
+static void gattc_get_descriptor_cb(int conn_id, int status,
+		btgatt_srvc_id_t *srvc_id, btgatt_char_id_t *char_id,
+		bt_uuid_t *descr_id)
+{
+}
+
+/* GATT included service enumeration result callback */
+static void gattc_get_included_service_cb(int conn_id, int status,
+						btgatt_srvc_id_t *srvc_id,
+						btgatt_srvc_id_t *incl_srvc_id)
+{
+}
+
+/* Callback invoked in response to [de]register_for_notification */
+static void gattc_register_for_notification_cb(int conn_id, int registered,
+						int status,
+						btgatt_srvc_id_t *srvc_id,
+						btgatt_char_id_t *char_id)
+{
+}
+
+/*
+ * Remote device notification callback, invoked when a remote device sends
+ * a notification or indication that a client has registered for.
+ */
+static void gattc_notify_cb(int conn_id, btgatt_notify_params_t *p_data)
+{
+}
+
+/* Reports result of a GATT read operation */
+static void gattc_read_characteristic_cb(int conn_id, int status,
+						btgatt_read_params_t *p_data)
+{
+}
+
+/* GATT write characteristic operation callback */
+static void gattc_write_characteristic_cb(int conn_id, int status,
+						btgatt_write_params_t *p_data)
+{
+}
+
+/* GATT execute prepared write callback */
+static void gattc_execute_write_cb(int conn_id, int status)
+{
+}
+
+/* Callback invoked in response to read_descriptor */
+static void gattc_read_descriptor_cb(int conn_id, int status,
+						btgatt_read_params_t *p_data)
+{
+}
+
+/* Callback invoked in response to write_descriptor */
+static void gattc_write_descriptor_cb(int conn_id, int status,
+						btgatt_write_params_t *p_data)
+{
+}
+
+/* Callback triggered in response to read_remote_rssi */
+static void gattc_read_remote_rssi_cb(int client_if, bt_bdaddr_t *bda, int rssi,
+								int status)
+{
+}
+
+static const btgatt_client_callbacks_t btgatt_client_callbacks = {
+	.register_client_cb = gattc_register_client_cb,
+	.scan_result_cb = gattc_scan_result_cb,
+	.open_cb = gattc_connect_cb,
+	.close_cb = gattc_disconnect_cb,
+	.search_complete_cb = gattc_search_complete_cb,
+	.search_result_cb = gattc_search_result_cb,
+	.get_characteristic_cb = gattc_get_characteristic_cb,
+	.get_descriptor_cb = gattc_get_descriptor_cb,
+	.get_included_service_cb = gattc_get_included_service_cb,
+	.register_for_notification_cb = gattc_register_for_notification_cb,
+	.notify_cb = gattc_notify_cb,
+	.read_characteristic_cb = gattc_read_characteristic_cb,
+	.write_characteristic_cb = gattc_write_characteristic_cb,
+	.read_descriptor_cb = gattc_read_descriptor_cb,
+	.write_descriptor_cb = gattc_write_descriptor_cb,
+	.execute_write_cb = gattc_execute_write_cb,
+	.read_remote_rssi_cb = gattc_read_remote_rssi_cb
+};
+
+/* BT-GATT Server callbacks */
+
+/* Callback invoked in response to register_server */
+static void gatts_register_server_cb(int status, int server_if,
+							bt_uuid_t *app_uuid)
+{
+}
+
+/*
+ * Callback indicating that a remote device has connected
+ * or been disconnected
+ */
+static void gatts_connection_cb(int conn_id, int server_if, int connected,
+							bt_bdaddr_t *bda)
+{
+}
+
+/* Callback invoked in response to create_service */
+static void gatts_service_added_cb(int status, int server_if,
+				btgatt_srvc_id_t *srvc_id, int srvc_handle)
+{
+}
+
+/* Callback indicating that an included service has been added to a service */
+static void gatts_included_service_added_cb(int status, int server_if,
+							int srvc_handle,
+							int incl_srvc_handle)
+{
+}
+
+/* Callback invoked when a characteristic has been added to a service */
+static void gatts_characteristic_added_cb(int status, int server_if,
+								bt_uuid_t *uuid,
+								int srvc_handle,
+								int char_handle)
+{
+}
+
+/* Callback invoked when a descriptor has been added to a characteristic */
+static void gatts_descriptor_added_cb(int status, int server_if,
+					bt_uuid_t *uuid, int srvc_handle,
+							int descr_handle)
+{
+}
+
+/* Callback invoked in response to start_service */
+static void gatts_service_started_cb(int status, int server_if, int srvc_handle)
+{
+}
+
+/* Callback invoked in response to stop_service */
+static void gatts_service_stopped_cb(int status, int server_if, int srvc_handle)
+{
+}
+
+/* Callback triggered when a service has been deleted */
+static void gatts_service_deleted_cb(int status, int server_if, int srvc_handle)
+{
+}
+
+/*
+ * Callback invoked when a remote device has requested to read a characteristic
+ * or descriptor. The application must respond by calling send_response
+ */
+static void gatts_request_read_cb(int conn_id, int trans_id, bt_bdaddr_t *bda,
+						int attr_handle, int offset,
+						bool is_long)
+{
+}
+
+/*
+ * Callback invoked when a remote device has requested to write to a
+ * characteristic or descriptor.
+ */
+static void gatts_request_write_cb(int conn_id, int trans_id, bt_bdaddr_t *bda,
+					int attr_handle, int offset, int length,
+					bool need_rsp, bool is_prep,
+					uint8_t *value)
+{
+}
+
+/* Callback invoked when a previously prepared write is to be executed */
+static void gatts_request_exec_write_cb(int conn_id, int trans_id,
+					bt_bdaddr_t *bda, int exec_write)
+{
+}
+
+/*
+ * Callback triggered in response to send_response if the remote device
+ * sends a confirmation.
+ */
+static void gatts_response_confirmation_cb(int status, int handle)
+{
+}
+
+static const btgatt_server_callbacks_t btgatt_server_callbacks = {
+	.register_server_cb = gatts_register_server_cb,
+	.connection_cb = gatts_connection_cb,
+	.service_added_cb = gatts_service_added_cb,
+	.included_service_added_cb = gatts_included_service_added_cb,
+	.characteristic_added_cb = gatts_characteristic_added_cb,
+	.descriptor_added_cb = gatts_descriptor_added_cb,
+	.service_started_cb = gatts_service_started_cb,
+	.service_stopped_cb = gatts_service_stopped_cb,
+	.service_deleted_cb = gatts_service_deleted_cb,
+	.request_read_cb = gatts_request_read_cb,
+	.request_write_cb = gatts_request_write_cb,
+	.request_exec_write_cb = gatts_request_exec_write_cb,
+	.response_confirmation_cb = gatts_response_confirmation_cb
+};
+
+static const btgatt_callbacks_t gatt_cbacks = {
+	.size = sizeof(gatt_cbacks),
+	.client = &btgatt_client_callbacks,
+	.server = &btgatt_server_callbacks
+};
+
+/* gatt client methods */
+
+/* init */
+
+static void init_p(int argc, const char **argv)
+{
+}
+
+/* cleanup */
+
+static void cleanup_p(int argc, const char **argv)
+{
+}
+
+static struct method methods[] = {
+	STD_METHOD(init),
+	STD_METHOD(cleanup),
+	END_METHOD
+};
+
+const struct interface gatt_if = {
+	.name = "gatt",
+	.methods = methods
+};
+
+/* register_client */
+
+static void register_client_p(int argc, const char **argv)
+{
+}
+
+/* unregister_client */
+
+static void unregister_client_p(int argc, const char **argv)
+{
+}
+
+/* scan */
+
+static void scan_p(int argc, const char **argv)
+{
+}
+
+/* connect */
+
+static void connect_p(int argc, const char **argv)
+{
+}
+
+/* disconnect */
+
+static void disconnect_p(int argc, const char **argv)
+{
+}
+
+/* refresh */
+
+static void refresh_p(int argc, const char **argv)
+{
+}
+
+/* search_service */
+
+static void search_service_p(int argc, const char **argv)
+{
+}
+
+/* get_included_service */
+
+static void get_included_service_p(int argc, const char **argv)
+{
+}
+
+/* get_characteristic */
+
+static void get_characteristic_p(int argc, const char **argv)
+{
+}
+
+/* get_descriptor */
+
+static void get_descriptor_p(int argc, const char **argv)
+{
+}
+
+/* read_characteristic */
+
+static void read_characteristic_p(int argc, const char **argv)
+{
+}
+
+/* write_characteristic */
+
+static void write_characteristic_p(int argc, const char **argv)
+{
+}
+
+/* read_descriptor */
+
+static void read_descriptor_p(int argc, const char **argv)
+{
+}
+
+/* write_descriptor */
+
+static void write_descriptor_p(int argc, const char **argv)
+{
+}
+
+/* execute_write */
+
+static void execute_write_p(int argc, const char **argv)
+{
+}
+
+/* register_for_notification */
+
+static void register_for_notification_p(int argc, const char **argv)
+{
+}
+
+/* deregister_for_notification */
+
+static void deregister_for_notification_p(int argc, const char **argv)
+{
+}
+
+/* read_remote_rssi */
+
+static void read_remote_rssi_p(int argc, const char **argv)
+{
+}
+
+/* get_device_type */
+
+static void get_device_type_p(int argc, const char **argv)
+{
+}
+
+/* test_command */
+
+static void test_command_p(int argc, const char **argv)
+{
+}
+
+static struct method client_methods[] = {
+	STD_METHODH(register_client, "[<uuid>]"),
+	STD_METHODH(unregister_client, "<client_if>"),
+	STD_METHODH(scan, "<client_if> [1|0]"),
+	STD_METHODH(connect, "<client_if> <addr> [<is_direct>]"),
+	STD_METHODH(disconnect, "<client_if> <addr> <conn_id>"),
+	STD_METHODH(refresh, "<client_if> <addr>"),
+	STD_METHODH(search_service, "<conn_id> [<uuid>]"),
+	STD_METHODH(get_included_service, "<conn_id> <srvc_id>"),
+	STD_METHODH(get_characteristic, "<conn_id> <srvc_id>"),
+	STD_METHODH(get_descriptor, "<conn_id> <srvc_id> <char_id>"),
+	STD_METHODH(read_characteristic,
+			"<conn_id> <srvc_id> <char_id> [<auth_req>]"),
+	STD_METHODH(write_characteristic,
+			"<conn_id> <srvc_id> <char_id> <write_type> <hex_value> [<auth_req>]"),
+	STD_METHODH(read_descriptor,
+			"<conn_id> <srvc_id> <char_id> <descr_id> [<auth_req>]"),
+	STD_METHODH(write_descriptor,
+			"<conn_id> <srvc_id> <char_id> <descr_id> <write_type> <hex_value> [<auth_req>]"),
+	STD_METHODH(execute_write, "<conn_id> <execute>"),
+	STD_METHODH(register_for_notification,
+			"<client_if> <addr> <srvc_id> <char_id>"),
+	STD_METHODH(deregister_for_notification,
+			"<client_if> <addr> <srvc_id> <char_id>"),
+	STD_METHODH(read_remote_rssi, "<client_if> <addr>"),
+	STD_METHODH(get_device_type, "<addr>"),
+	STD_METHODH(test_command,
+			"<cmd> <addr> <uuid> [u1] [u2] [u3] [u4] [u5]"),
+	END_METHOD
+};
+
+const struct interface gatt_client_if = {
+	.name = "gattc",
+	.methods = client_methods
+};
+
+/* gatt server methods */
+
+/* register_server */
+
+static void gatts_register_server_p(int argc, const char *argv[])
+{
+}
+
+/* unregister_server */
+
+static void gatts_unregister_server_p(int argc, const char *argv[])
+{
+}
+
+/* connect */
+
+static void gatts_connect_p(int argc, const char *argv[])
+{
+}
+
+/* disconnect */
+
+static void gatts_disconnect_p(int argc, const char *argv[])
+{
+}
+
+/* add_service */
+
+static void gatts_add_service_p(int argc, const char *argv[])
+{
+}
+
+/* add_included_service */
+
+static void gatts_add_included_service_p(int argc, const char *argv[])
+{
+}
+
+/* add_characteristic */
+
+static void gatts_add_characteristic_p(int argc, const char *argv[])
+{
+}
+
+/* add_descriptor */
+
+static void gatts_add_descriptor_p(int argc, const char *argv[])
+{
+}
+
+/* start_service */
+
+static void gatts_start_service_p(int argc, const char *argv[])
+{
+}
+
+/* stop_service */
+
+static void gatts_stop_service_p(int argc, const char *argv[])
+{
+}
+
+/* delete_service */
+
+static void gatts_delete_service_p(int argc, const char *argv[])
+{
+}
+
+/* send_indication */
+
+static void gatts_send_indication_p(int argc, const char *argv[])
+{
+}
+
+/* send_response */
+
+static void gatts_send_response_p(int argc, const char *argv[])
+{
+}
+
+#define GATTS_METHODH(n, h) METHOD(#n, gatts_##n##_p, NULL, h)
+#define GATTS_METHODCH(n, h) METHOD(#n, gatts_##n##_p, gatts_##n##_c, h)
+
+static struct method server_methods[] = {
+	GATTS_METHODH(register_server, "[<uuid>]"),
+	GATTS_METHODH(unregister_server, "<server_if>"),
+	GATTS_METHODH(connect, "<server_if> <addr> [<is_direct>]"),
+	GATTS_METHODH(disconnect, "<server_if> <addr> <conn_id>"),
+	GATTS_METHODH(add_service, "<server_if> <srvc_id> <num_handles>"),
+	GATTS_METHODH(add_included_service,
+			"<server_if> <service_handle> <included_handle>"),
+	GATTS_METHODH(add_characteristic,
+		"<server_if> <service_handle> <uuid> <properites> <permissions>"),
+	GATTS_METHODH(add_descriptor, "<server_if> <uuid> <permissions>"),
+	GATTS_METHODH(start_service,
+				"<server_if> <service_handle> <transport>"),
+	GATTS_METHODH(stop_service, "<server_if> <service_handle>"),
+	GATTS_METHODH(delete_service, "<server_if> <service_handle>"),
+	GATTS_METHODH(send_indication,
+			"<server_if> <attr_handle> <conn_id> <confirm> [<data>]"),
+	GATTS_METHODH(send_response, "<conn_id> <trans_id> <status>"),
+	END_METHOD
+};
+
+const struct interface gatt_server_if = {
+	.name = "gatts",
+	.methods = server_methods
+};
+
diff --git a/android/client/if-main.h b/android/client/if-main.h
index 37086dd..0c59054 100644
--- a/android/client/if-main.h
+++ b/android/client/if-main.h
@@ -38,6 +38,10 @@
 
 #if PLATFORM_SDK_VERSION > 17
 #include <hardware/bt_rc.h>
+#include <hardware/bt_gatt.h>
+#include <hardware/bt_gatt_types.h>
+#include <hardware/bt_gatt_client.h>
+#include <hardware/bt_gatt_server.h>
 #endif
 
 #include "textconv.h"
@@ -49,6 +53,11 @@ extern const bthf_interface_t *if_hf;
 extern const bthh_interface_t *if_hh;
 extern const btpan_interface_t *if_pan;
 extern const btsock_interface_t *if_sock;
+#if PLATFORM_SDK_VERSION > 17
+extern const btgatt_interface_t *if_gatt;
+extern const btgatt_server_interface_t *if_gatt_server;
+extern const btgatt_client_interface_t *if_gatt_client;
+#endif
 
 /*
  * Structure defines top level interfaces that can be used in test tool
@@ -61,6 +70,11 @@ struct interface {
 
 extern const struct interface bluetooth_if;
 extern const struct interface av_if;
+#if PLATFORM_SDK_VERSION > 17
+extern const struct interface gatt_if;
+extern const struct interface gatt_client_if;
+extern const struct interface gatt_server_if;
+#endif
 extern const struct interface pan_if;
 extern const struct interface sock_if;
 extern const struct interface hf_if;
-- 
1.7.9.5

