Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 4/5] android: Add text conversion helpers to haltest
Date: Mon, 14 Oct 2013 11:59:53 +0200
Message-ID: <1381744794-17994-5-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1381744794-17994-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1381744794-17994-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Application uses a lot of text in the form of defines found in header
files to represent arguments and output.
Conversion helpers keep functionality of converting string as
bt_status_t or uuid in one place.
---
 android/Android.mk            |    1 +
 android/hal_client/textconv.c |  211 +++++++++++++++++++++++++++++++++++++++++
 android/hal_client/textconv.h |  119 +++++++++++++++++++++++
 3 files changed, 331 insertions(+)
 create mode 100644 android/hal_client/textconv.c
 create mode 100644 android/hal_client/textconv.h

diff --git a/android/Android.mk b/android/Android.mk
index b26a766..a37db38 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -41,6 +41,7 @@ LOCAL_SRC_FILES := \
 	hal_client/pollhandler.c \
 	hal_client/terminal.c \
 	hal_client/history.c \
+	hal_client/textconv.c \
 
 LOCAL_SHARED_LIBRARIES := libhardware
 
diff --git a/android/hal_client/textconv.c b/android/hal_client/textconv.c
new file mode 100644
index 0000000..6b6d0d2
--- /dev/null
+++ b/android/hal_client/textconv.c
@@ -0,0 +1,211 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2013  Intel Corporation
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <string.h>
+#include <stdio.h>
+#include <hardware/bluetooth.h>
+
+#include "textconv.h"
+
+/*
+ * Following are maps of defines found in bluetooth header files to strings
+ *
+ * Those mappings are used to accurately use defines as input parameters in
+ * command line as well as for printing of statuses
+ */
+
+INTMAP(bt_status_t, -1, "(unknown)")
+	DELEMENT(BT_STATUS_SUCCESS),
+	DELEMENT(BT_STATUS_FAIL),
+	DELEMENT(BT_STATUS_NOT_READY),
+	DELEMENT(BT_STATUS_NOMEM),
+	DELEMENT(BT_STATUS_BUSY),
+	DELEMENT(BT_STATUS_DONE),
+	DELEMENT(BT_STATUS_UNSUPPORTED),
+	DELEMENT(BT_STATUS_PARM_INVALID),
+	DELEMENT(BT_STATUS_UNHANDLED),
+	DELEMENT(BT_STATUS_AUTH_FAILURE),
+	DELEMENT(BT_STATUS_RMT_DEV_DOWN),
+ENDMAP
+
+INTMAP(bt_state_t, -1, "(unknown)")
+	DELEMENT(BT_STATE_OFF),
+	DELEMENT(BT_STATE_ON),
+ENDMAP
+
+INTMAP(bt_device_type_t, -1, "(unknown)")
+	DELEMENT(BT_DEVICE_DEVTYPE_BREDR),
+	DELEMENT(BT_DEVICE_DEVTYPE_BLE),
+	DELEMENT(BT_DEVICE_DEVTYPE_DUAL),
+ENDMAP
+
+INTMAP(bt_scan_mode_t, -1, "(unknown)")
+	DELEMENT(BT_SCAN_MODE_NONE),
+	DELEMENT(BT_SCAN_MODE_CONNECTABLE),
+	DELEMENT(BT_SCAN_MODE_CONNECTABLE_DISCOVERABLE),
+ENDMAP
+
+INTMAP(bt_discovery_state_t, -1, "(unknown)")
+	DELEMENT(BT_DISCOVERY_STOPPED),
+	DELEMENT(BT_DISCOVERY_STARTED),
+ENDMAP
+
+INTMAP(bt_acl_state_t, -1, "(unknown)")
+	DELEMENT(BT_ACL_STATE_CONNECTED),
+	DELEMENT(BT_ACL_STATE_DISCONNECTED),
+ENDMAP
+
+INTMAP(bt_bond_state_t, -1, "(unknown)")
+	DELEMENT(BT_BOND_STATE_NONE),
+	DELEMENT(BT_BOND_STATE_BONDING),
+	DELEMENT(BT_BOND_STATE_BONDED),
+ENDMAP
+
+INTMAP(bt_ssp_variant_t, -1, "(unknown)")
+	DELEMENT(BT_SSP_VARIANT_PASSKEY_CONFIRMATION),
+	DELEMENT(BT_SSP_VARIANT_PASSKEY_ENTRY),
+	DELEMENT(BT_SSP_VARIANT_CONSENT),
+	DELEMENT(BT_SSP_VARIANT_PASSKEY_NOTIFICATION),
+ENDMAP
+
+INTMAP(bt_property_type_t, -1, "(unknown)")
+	DELEMENT(BT_PROPERTY_BDNAME),
+	DELEMENT(BT_PROPERTY_BDADDR),
+	DELEMENT(BT_PROPERTY_UUIDS),
+	DELEMENT(BT_PROPERTY_CLASS_OF_DEVICE),
+	DELEMENT(BT_PROPERTY_TYPE_OF_DEVICE),
+	DELEMENT(BT_PROPERTY_SERVICE_RECORD),
+	DELEMENT(BT_PROPERTY_ADAPTER_SCAN_MODE),
+	DELEMENT(BT_PROPERTY_ADAPTER_BONDED_DEVICES),
+	DELEMENT(BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT),
+	DELEMENT(BT_PROPERTY_REMOTE_FRIENDLY_NAME),
+	DELEMENT(BT_PROPERTY_REMOTE_RSSI),
+	DELEMENT(BT_PROPERTY_REMOTE_VERSION_INFO),
+	DELEMENT(BT_PROPERTY_REMOTE_DEVICE_TIMESTAMP),
+ENDMAP
+
+INTMAP(bt_cb_thread_evt, -1, "(unknown)")
+	DELEMENT(ASSOCIATE_JVM),
+	DELEMENT(DISASSOCIATE_JVM),
+ENDMAP
+
+/* Find first index of given value in table m */
+int int2str_findint(int v, const struct int2str m[])
+{
+	int i;
+
+	for (i = 0; m[i].str; ++i) {
+		if (m[i].val == v)
+			return i;
+	}
+	return -1;
+}
+
+/* Find first index of given string in table m */
+int int2str_findstr(const char *str, const struct int2str m[])
+{
+	int i;
+
+	for (i = 0; m[i].str; ++i) {
+		if (strcmp(m[i].str, str) == 0)
+			return i;
+	}
+	return -1;
+}
+
+/*
+ * convert bd_addr to string
+ * buf must be at least 18 char long
+ *
+ * returns buf
+ */
+char *bt_bdaddr_t2str(const bt_bdaddr_t *bd_addr, char *buf)
+{
+	const char *p = (const char *)bd_addr;
+
+	snprintf(buf, 18, "%02x:%02x:%02x:%02x:%02x:%02x",
+					p[0], p[1], p[2], p[3], p[4], p[5]);
+
+	return buf;
+}
+
+/* converts string to bt_bdaddr_t */
+void str2bt_bdaddr_t(const char *str, bt_bdaddr_t *bd_addr)
+{
+	char *p = (char *)bd_addr;
+
+	sscanf(str, "%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx",
+			       &p[0], &p[1], &p[2], &p[3], &p[4], &p[5]);
+}
+
+static const char BT_BASE_UUID[] = {
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,
+	0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb
+};
+
+/*
+ * converts uuid to string
+ * buf should be at least 39 bytes
+ *
+ * returns string representation of uuid
+ */
+char *bt_uuid_t2str(const bt_uuid_t *uuid, char *buf)
+{
+	int shift = 0;
+	int i;
+	int is_bt;
+
+	is_bt = !memcmp(&uuid->uu[4], &BT_BASE_UUID[4], sizeof(bt_uuid_t) - 4);
+
+	for (i = 0; i < (int)sizeof(bt_uuid_t); i++) {
+		if (i == 4 && is_bt)
+			break;
+
+		if (i == 4 || i == 6 || i == 8 || i == 10) {
+			buf[i * 2 + shift] = '-';
+			shift++;
+		}
+		sprintf(buf + i * 2 + shift, "%02x", uuid->uu[i]);
+	}
+
+	return buf;
+}
+
+/* converts string to uuid */
+void str2bt_uuid_t(const char *str, bt_uuid_t *uuid)
+{
+	int i = 0;
+
+	memcpy(uuid, BT_BASE_UUID, sizeof(bt_uuid_t));
+
+	while (*str && i < (int)sizeof(bt_uuid_t)) {
+		while (*str == '-')
+			str++;
+
+		if (sscanf(str, "%02hhx", &uuid->uu[i]) != 1)
+			break;
+
+		i++;
+		str += 2;
+	}
+}
diff --git a/android/hal_client/textconv.h b/android/hal_client/textconv.h
new file mode 100644
index 0000000..6f381b8
--- /dev/null
+++ b/android/hal_client/textconv.h
@@ -0,0 +1,119 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2013  Intel Corporation
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+/**
+ * Begin mapping section
+ *
+ * There are some mappings between integer values (enums) and strings
+ * to be presented to user. To make it easier to convert between those two
+ * set of macros is given. It is specially useful when we want to have
+ * strings that match constants from header files like:
+ *  BT_STATUS_SUCCESS (0) and corresponding "BT_STATUS_SUCCESS"
+ * Example of usage:
+ *
+ * INTMAP(int, -1, "invalid")
+ *   DELEMENT(BT_STATUS_SUCCESS)
+ *   DELEMENT(BT_STATUS_FAIL)
+ *   MELEMENT(123, "Some strange value")
+ * ENDMAP
+ *
+ * Just by doing this we have mapping table plus two functions:
+ *  int str2int(const char *str);
+ *  const char *int2str(int v);
+ *
+ * second argument to INTMAP specifies value to be returned from
+ * str2int function when there is not mapping for such number
+ * third argument specifies default value to be returned from int2str
+ *
+ * If same mapping is to be used in several source files put
+ * INTMAP in c file and DECINTMAP in h file.
+ *
+ * For mappings that are to be used in single file only
+ * use SINTMAP which will create the same but everything will be marked
+ * as static.
+ */
+
+struct int2str {
+	int val;		/* int value */
+	const char *str;	/* corresponding string */
+};
+
+int int2str_findint(int v, const struct int2str m[]);
+int int2str_findstr(const char *str, const struct int2str m[]);
+
+#define DECINTMAP(type) \
+extern struct int2str __##type##2str[]; \
+const char *type##2##str(type v); \
+type str##2##type(const char *str); \
+
+#define INTMAP(type, deft, defs) \
+const char *type##2##str(type v) \
+{ \
+	int i = int2str_findint((int)v, __##type##2str); \
+	return (i < 0) ? defs : __##type##2str[i].str; \
+} \
+type str##2##type(const char *str) \
+{ \
+	int i = int2str_findstr(str, __##type##2str); \
+	return (i < 0) ? (type)deft : (type)(__##type##2str[i].val); \
+} \
+struct int2str __##type##2str[] = {
+
+#define SINTMAP(type, deft, defs) \
+static struct int2str __##type##2str[]; \
+static inline const char *type##2##str(type v) \
+{ \
+	int i = int2str_findint((int)v, __##type##2str); \
+	return (i < 0) ? defs : __##type##2str[i].str; \
+} \
+static inline type str##2##type(const char *str) \
+{ \
+	int i = int2str_findstr(str, __##type##2str); \
+	return (i < 0) ? (type)deft : (type)(__##type##2str[i].val); \
+} \
+static struct int2str __##type##2str[] = {
+
+#define ENDMAP {0, NULL} };
+
+/* use this to generate string from header file constant */
+#define MELEMENT(v, s) {v, s}
+/* use this to have arbitrary mapping from int to string */
+#define DELEMENT(s) {s, #s}
+/* End of mapping section */
+
+char *bt_bdaddr_t2str(const bt_bdaddr_t *bd_addr, char *buf);
+void str2bt_bdaddr_t(const char *str, bt_bdaddr_t *bd_addr);
+
+char *bt_uuid_t2str(const bt_uuid_t *uuid, char *buf);
+void str2bt_uuid_t(const char *str, bt_uuid_t *uuid);
+
+DECINTMAP(bt_status_t);
+DECINTMAP(bt_state_t);
+DECINTMAP(bt_device_type_t);
+DECINTMAP(bt_scan_mode_t);
+DECINTMAP(bt_discovery_state_t);
+DECINTMAP(bt_acl_state_t);
+DECINTMAP(bt_bond_state_t);
+DECINTMAP(bt_ssp_variant_t);
+DECINTMAP(bt_property_type_t);
+DECINTMAP(bt_cb_thread_evt);
-- 
1.7.9.5

