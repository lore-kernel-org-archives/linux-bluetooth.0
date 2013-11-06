Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 01/14] android: Add HAL IPC commands sanity check
Date: Wed, 6 Nov 2013 15:09:17 +0100
Message-ID: <1383746970-25906-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383746970-25906-1-git-send-email-szymon.janc@tieto.com>
References: <1383746970-25906-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to check if command received by daemon is properly
formatted. Only common header values sanity is checked. Parameters
values needs to be verified by appropriate command handlers.

This implements core, bluetooth, sock and hidhost services checks.
---
 android/Android.mk      |   2 +
 android/Makefile.am     |   6 +-
 android/hal-msg-check.c | 163 ++++++++++++++++++++++++++++++++++++++++++++++++
 android/hal-msg.h       |   3 +
 android/ipc.c           |   1 +
 5 files changed, 173 insertions(+), 2 deletions(-)
 create mode 100644 android/hal-msg-check.c

diff --git a/android/Android.mk b/android/Android.mk
index d76dfaf..c756aaa 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -27,6 +27,7 @@ LOCAL_SRC_FILES := \
 	ipc.c ipc.h \
 	a2dp.c \
 	pan.c \
+	hal-msg-check.c \
 	../src/log.c \
 	../src/shared/mgmt.c \
 	../src/shared/util.c \
@@ -88,6 +89,7 @@ LOCAL_SRC_FILES := \
 	hal-pan.c \
 	hal-av.c \
 	client/textconv.c \
+	hal-msg-check.c \
 
 LOCAL_C_INCLUDES += \
 	$(call include-path-for, system-core) \
diff --git a/android/Makefile.am b/android/Makefile.am
index 3c51390..b7a7437 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -23,7 +23,8 @@ android_bluetoothd_SOURCES = android/main.c \
 				android/socket.h android/socket.c \
 				android/pan.h android/pan.c \
 				btio/btio.h btio/btio.c \
-				src/sdp-client.h src/sdp-client.c
+				src/sdp-client.h src/sdp-client.c \
+				android/hal-msg-check.c
 
 android_bluetoothd_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
@@ -49,7 +50,8 @@ android_libhal_internal_la_SOURCES = android/hal.h android/hal-bluetooth.c \
 					android/hardware/hardware.h \
 					android/cutils/properties.h \
 					android/hal-log.h \
-					android/hal-ipc.h android/hal-ipc.c
+					android/hal-ipc.h android/hal-ipc.c \
+					android/hal-msg-check.c
 
 android_libhal_internal_la_CPPFLAGS = -I$(srcdir)/android
 
diff --git a/android/hal-msg-check.c b/android/hal-msg-check.c
new file mode 100644
index 0000000..208d8a5
--- /dev/null
+++ b/android/hal-msg-check.c
@@ -0,0 +1,163 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2013  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <sys/types.h>
+#include <stdint.h>
+#include <stdbool.h>
+
+#include "hal-msg.h"
+
+#define check_no_p(opcode) \
+	case opcode: \
+		return len == 0;
+
+#define check_fix_p(opcode, msg) \
+	case opcode: \
+		return len == sizeof(struct msg);
+
+#define check_var_p(opcode, msg, mp_len_name) \
+	case opcode: \
+	{ \
+		const struct msg *mp = (const struct msg *) payload; \
+		return len == (sizeof(*mp) + mp->mp_len_name); \
+	}
+
+#define check_props_p(opcode, msg) \
+	case opcode: \
+	{ \
+		const struct msg *mp = (const struct msg *) payload; \
+		const struct hal_property *hp = mp->props; \
+		const void *p = mp->props; \
+		int i; \
+		for (i = 0; i < mp->num_props; i++) { \
+			if ((void *) (p + sizeof(*hp) + hp->len) > \
+					(void *) (payload + len)) \
+				return false; \
+			p += sizeof(*hp) + hp->len; \
+			hp = p; \
+		} \
+		return p == payload + len; \
+	}
+
+static bool check_cmd_core(uint8_t opcode, const void *payload,
+								uint16_t len)
+{
+	switch (opcode) {
+	check_fix_p(HAL_OP_REGISTER_MODULE, hal_cmd_register_module);
+	check_fix_p(HAL_OP_UNREGISTER_MODULE, hal_cmd_unregister_module);
+	default:
+		return false;
+	}
+}
+
+static bool check_cmd_bluetooth(uint8_t opcode, const void *payload,
+								uint16_t len)
+{
+	switch (opcode) {
+	check_no_p(HAL_OP_ENABLE);
+	check_no_p(HAL_OP_DISABLE);
+	check_no_p(HAL_OP_GET_ADAPTER_PROPS);
+	check_fix_p(HAL_OP_GET_ADAPTER_PROP, hal_cmd_get_adapter_prop);
+	check_var_p(HAL_OP_SET_ADAPTER_PROP, hal_cmd_set_adapter_prop, len);
+	check_fix_p(HAL_OP_GET_REMOTE_DEVICE_PROPS,
+					hal_cmd_get_remote_device_props);
+	check_fix_p(HAL_OP_GET_REMOTE_DEVICE_PROP,
+					hal_cmd_get_remote_device_prop);
+	check_var_p(HAL_OP_SET_REMOTE_DEVICE_PROP,
+					hal_cmd_set_remote_device_prop, len);
+	check_fix_p(HAL_OP_GET_REMOTE_SERVICE_REC,
+					hal_cmd_get_remote_service_rec);
+	check_fix_p(HAL_OP_GET_REMOTE_SERVICES, hal_cmd_get_remote_services);
+	check_no_p(HAL_OP_START_DISCOVERY);
+	check_no_p(HAL_OP_CANCEL_DISCOVERY);
+	check_fix_p(HAL_OP_CREATE_BOND, hal_cmd_create_bond);
+	check_fix_p(HAL_OP_REMOVE_BOND, hal_cmd_remove_bond);
+	check_fix_p(HAL_OP_CANCEL_BOND, hal_cmd_cancel_bond)
+	check_fix_p(HAL_OP_PIN_REPLY, hal_cmd_pin_reply);
+	check_fix_p(HAL_OP_SSP_REPLY, hal_cmd_ssp_reply)
+	check_fix_p(HAL_OP_DUT_MODE_CONF, hal_cmd_dut_mode_conf);
+	check_var_p(HAL_OP_DUT_MODE_SEND, hal_cmd_dut_mode_send, len);
+	check_var_p(HAL_OP_LE_TEST_MODE, hal_cmd_le_test_mode, len);
+	default:
+		return false;
+	}
+}
+
+static bool check_cmd_sock(uint8_t opcode, const void *payload,
+								uint16_t len)
+{
+	switch (opcode) {
+	check_fix_p(HAL_OP_SOCK_LISTEN, hal_op_sock_listen);
+	check_fix_p(HAL_OP_SOCK_CONNECT, hal_op_sock_connect);
+	default:
+		return false;
+	}
+}
+
+static bool check_cmd_hidhost(uint8_t opcode, const void *payload,
+								uint16_t len)
+{
+	switch (opcode) {
+	check_fix_p(HAL_OP_HID_CONNECT, hal_cmd_hid_connect);
+	check_fix_p(HAL_OP_HID_DISCONNECT, hal_cmd_hid_disconnect);
+	check_fix_p(HAL_OP_HID_VP, hal_cmd_hid_vp);
+	check_var_p(HAL_OP_HID_SET_INFO, hal_cmd_hid_set_info, descr_len);
+	check_fix_p(HAL_OP_HID_GET_PROTOCOL, hal_cmd_hid_get_protocol);
+	check_fix_p(HAL_OP_HID_SET_PROTOCOL, hal_cmd_hid_set_protocol);
+	check_fix_p(HAL_OP_HID_GET_REPORT, hal_cmd_hid_get_report);
+	check_fix_p(HAL_OP_HID_SET_REPORT, hal_cmd_hid_set_report);
+	check_fix_p(HAL_OP_HID_SEND_DATA, hal_cmd_hid_send_data);
+	default:
+		return false;
+	}
+}
+
+bool hal_cmd_check(const struct hal_hdr *msg, const void *payload, ssize_t len)
+{
+	if (len < (ssize_t) sizeof(*msg))
+		return false;
+
+	if (len != (ssize_t) (sizeof(*msg) + msg->len))
+		return false;
+
+	switch (msg->service_id) {
+	case HAL_SERVICE_ID_CORE:
+		return check_cmd_core(msg->opcode, payload, msg->len);
+	case HAL_SERVICE_ID_BLUETOOTH:
+		return check_cmd_bluetooth(msg->opcode, payload, msg->len);
+	case HAL_SERVICE_ID_SOCK:
+		return check_cmd_sock(msg->opcode, payload, msg->len);
+	case HAL_SERVICE_ID_HIDHOST:
+		return check_cmd_hidhost(msg->opcode, payload, msg->len);
+	case HAL_SERVICE_ID_PAN:
+	case HAL_SERVICE_ID_HANDSFREE:
+	case HAL_SERVICE_ID_A2DP:
+	case HAL_SERVICE_ID_HEALTH:
+	case HAL_SERVICE_ID_AVRCP:
+	case HAL_SERVICE_ID_GATT:
+		/*TODO implement */
+		return false;
+	default:
+		return false;
+	}
+}
diff --git a/android/hal-msg.h b/android/hal-msg.h
index f0cc800..e7587bf 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -486,3 +486,6 @@ struct hal_ev_av_audio_state {
 	uint8_t state;
 	uint8_t bdaddr[6];
 } __attribute__((packed));
+
+bool hal_cmd_check(const struct hal_hdr *msg, const void *payload,
+								ssize_t len);
diff --git a/android/ipc.c b/android/ipc.c
index e672bf8..57aa56d 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -28,6 +28,7 @@
 #include <stddef.h>
 #include <errno.h>
 #include <stdint.h>
+#include <stdbool.h>
 #include <string.h>
 #include <signal.h>
 #include <sys/socket.h>
-- 
1.8.4.2

