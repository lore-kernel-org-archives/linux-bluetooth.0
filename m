Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] android/debug: Move debug functions to hal-utils.c
Date: Fri,  8 Nov 2013 17:05:00 +0200
Message-Id: <1383923100-19574-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Debug functions will be used by HALs and haltest.
---
 android/Android.mk        |    2 -
 android/Makefile.am       |    3 -
 android/client/if-av.c    |    1 +
 android/client/if-bt.c    |    1 +
 android/client/if-hf.c    |    1 +
 android/client/if-hh.c    |    1 +
 android/client/if-main.h  |    2 -
 android/client/if-pan.c   |    1 +
 android/client/if-sock.c  |    1 +
 android/client/textconv.c |  300 ---------------------------------------------
 android/client/textconv.h |  120 ------------------
 android/hal-bluetooth.c   |    3 +-
 android/hal-utils.c       |  269 ++++++++++++++++++++++++++++++++++++++++
 android/hal-utils.h       |  103 ++++++++++++++++
 14 files changed, 379 insertions(+), 429 deletions(-)
 delete mode 100644 android/client/textconv.c
 delete mode 100644 android/client/textconv.h

diff --git a/android/Android.mk b/android/Android.mk
index 0bc0e82..53c766b 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -87,7 +87,6 @@ LOCAL_SRC_FILES := \
 	hal-hidhost.c \
 	hal-pan.c \
 	hal-a2dp.c \
-	client/textconv.c \
 	hal-utils.c \
 
 LOCAL_C_INCLUDES += \
@@ -118,7 +117,6 @@ LOCAL_SRC_FILES := \
 	client/pollhandler.c \
 	client/terminal.c \
 	client/history.c \
-	client/textconv.c \
 	client/tabcompletion.c \
 	client/if-av.c \
 	client/if-bt.c \
diff --git a/android/Makefile.am b/android/Makefile.am
index debe7c1..e81d1a5 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -59,7 +59,6 @@ android_haltest_SOURCES = android/client/haltest.c \
 				android/client/pollhandler.c \
 				android/client/terminal.c \
 				android/client/history.c \
-				android/client/textconv.c \
 				android/client/tabcompletion.c \
 				android/client/if-av.c \
 				android/client/if-bt.c \
@@ -102,9 +101,7 @@ EXTRA_DIST += android/client/terminal.c \
 		android/client/if-hh.c \
 		android/client/if-pan.c \
 		android/client/if-sock.c \
-		android/client/textconv.c \
 		android/client/tabcompletion.c \
-		android/client/textconv.h \
 		android/client/if-main.h \
 		android/client/pollhandler.h \
 		android/client/history.h \
diff --git a/android/client/if-av.c b/android/client/if-av.c
index 3f133eb..0470e0d 100644
--- a/android/client/if-av.c
+++ b/android/client/if-av.c
@@ -16,6 +16,7 @@
  */
 
 #include "if-main.h"
+#include "../hal-utils.h"
 
 const btav_interface_t *if_av = NULL;
 
diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 10ae125..0cd43db 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -17,6 +17,7 @@
 
 #include "if-main.h"
 #include "terminal.h"
+#include "../hal-utils.h"
 
 const bt_interface_t *if_bluetooth;
 
diff --git a/android/client/if-hf.c b/android/client/if-hf.c
index c23fb13..d0e7a66 100644
--- a/android/client/if-hf.c
+++ b/android/client/if-hf.c
@@ -16,6 +16,7 @@
  */
 
 #include "if-main.h"
+#include "../hal-utils.h"
 
 const bthf_interface_t *if_hf = NULL;
 
diff --git a/android/client/if-hh.c b/android/client/if-hh.c
index 005b13a..b8ebc8e 100644
--- a/android/client/if-hh.c
+++ b/android/client/if-hh.c
@@ -23,6 +23,7 @@
 
 #include "if-main.h"
 #include "pollhandler.h"
+#include "../hal-utils.h"
 
 const bthh_interface_t *if_hh = NULL;
 
diff --git a/android/client/if-main.h b/android/client/if-main.h
index dea7237..a83f48b 100644
--- a/android/client/if-main.h
+++ b/android/client/if-main.h
@@ -44,8 +44,6 @@
 #include <hardware/bt_gatt_server.h>
 #endif
 
-#include "textconv.h"
-
 /* Interfaces from hal that can be populated during application lifetime */
 extern const bt_interface_t *if_bluetooth;
 extern const btav_interface_t *if_av;
diff --git a/android/client/if-pan.c b/android/client/if-pan.c
index dcc7e80..a11f2a3 100644
--- a/android/client/if-pan.c
+++ b/android/client/if-pan.c
@@ -18,6 +18,7 @@
 #include <hardware/bluetooth.h>
 
 #include "if-main.h"
+#include "../hal-utils.h"
 
 const btpan_interface_t *if_pan = NULL;
 
diff --git a/android/client/if-sock.c b/android/client/if-sock.c
index dcaf048..2cd06e8 100644
--- a/android/client/if-sock.c
+++ b/android/client/if-sock.c
@@ -21,6 +21,7 @@
 
 #include "if-main.h"
 #include "pollhandler.h"
+#include "../hal-utils.h"
 
 const btsock_interface_t *if_sock = NULL;
 
diff --git a/android/client/textconv.c b/android/client/textconv.c
deleted file mode 100644
index dcbe53e..0000000
--- a/android/client/textconv.c
+++ /dev/null
@@ -1,300 +0,0 @@
-/*
- * Copyright (C) 2013 Intel Corporation
- *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
- */
-
-#include <string.h>
-#include <stdio.h>
-#include <hardware/bluetooth.h>
-
-#include "../hal-utils.h"
-
-#include "textconv.h"
-
-/*
- * Following are maps of defines found in bluetooth header files to strings
- *
- * Those mappings are used to accurately use defines as input parameters in
- * command line as well as for printing of statuses
- */
-
-INTMAP(bt_status_t, -1, "(unknown)")
-	DELEMENT(BT_STATUS_SUCCESS),
-	DELEMENT(BT_STATUS_FAIL),
-	DELEMENT(BT_STATUS_NOT_READY),
-	DELEMENT(BT_STATUS_NOMEM),
-	DELEMENT(BT_STATUS_BUSY),
-	DELEMENT(BT_STATUS_DONE),
-	DELEMENT(BT_STATUS_UNSUPPORTED),
-	DELEMENT(BT_STATUS_PARM_INVALID),
-	DELEMENT(BT_STATUS_UNHANDLED),
-	DELEMENT(BT_STATUS_AUTH_FAILURE),
-	DELEMENT(BT_STATUS_RMT_DEV_DOWN),
-ENDMAP
-
-INTMAP(bt_state_t, -1, "(unknown)")
-	DELEMENT(BT_STATE_OFF),
-	DELEMENT(BT_STATE_ON),
-ENDMAP
-
-INTMAP(bt_device_type_t, -1, "(unknown)")
-	DELEMENT(BT_DEVICE_DEVTYPE_BREDR),
-	DELEMENT(BT_DEVICE_DEVTYPE_BLE),
-	DELEMENT(BT_DEVICE_DEVTYPE_DUAL),
-ENDMAP
-
-INTMAP(bt_scan_mode_t, -1, "(unknown)")
-	DELEMENT(BT_SCAN_MODE_NONE),
-	DELEMENT(BT_SCAN_MODE_CONNECTABLE),
-	DELEMENT(BT_SCAN_MODE_CONNECTABLE_DISCOVERABLE),
-ENDMAP
-
-INTMAP(bt_discovery_state_t, -1, "(unknown)")
-	DELEMENT(BT_DISCOVERY_STOPPED),
-	DELEMENT(BT_DISCOVERY_STARTED),
-ENDMAP
-
-INTMAP(bt_acl_state_t, -1, "(unknown)")
-	DELEMENT(BT_ACL_STATE_CONNECTED),
-	DELEMENT(BT_ACL_STATE_DISCONNECTED),
-ENDMAP
-
-INTMAP(bt_bond_state_t, -1, "(unknown)")
-	DELEMENT(BT_BOND_STATE_NONE),
-	DELEMENT(BT_BOND_STATE_BONDING),
-	DELEMENT(BT_BOND_STATE_BONDED),
-ENDMAP
-
-INTMAP(bt_ssp_variant_t, -1, "(unknown)")
-	DELEMENT(BT_SSP_VARIANT_PASSKEY_CONFIRMATION),
-	DELEMENT(BT_SSP_VARIANT_PASSKEY_ENTRY),
-	DELEMENT(BT_SSP_VARIANT_CONSENT),
-	DELEMENT(BT_SSP_VARIANT_PASSKEY_NOTIFICATION),
-ENDMAP
-
-INTMAP(bt_property_type_t, -1, "(unknown)")
-	DELEMENT(BT_PROPERTY_BDNAME),
-	DELEMENT(BT_PROPERTY_BDADDR),
-	DELEMENT(BT_PROPERTY_UUIDS),
-	DELEMENT(BT_PROPERTY_CLASS_OF_DEVICE),
-	DELEMENT(BT_PROPERTY_TYPE_OF_DEVICE),
-	DELEMENT(BT_PROPERTY_SERVICE_RECORD),
-	DELEMENT(BT_PROPERTY_ADAPTER_SCAN_MODE),
-	DELEMENT(BT_PROPERTY_ADAPTER_BONDED_DEVICES),
-	DELEMENT(BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT),
-	DELEMENT(BT_PROPERTY_REMOTE_FRIENDLY_NAME),
-	DELEMENT(BT_PROPERTY_REMOTE_RSSI),
-#if PLATFORM_SDK_VERSION > 17
-	DELEMENT(BT_PROPERTY_REMOTE_VERSION_INFO),
-#endif
-	DELEMENT(BT_PROPERTY_REMOTE_DEVICE_TIMESTAMP),
-ENDMAP
-
-INTMAP(bt_cb_thread_evt, -1, "(unknown)")
-	DELEMENT(ASSOCIATE_JVM),
-	DELEMENT(DISASSOCIATE_JVM),
-ENDMAP
-
-/* Find first index of given value in table m */
-int int2str_findint(int v, const struct int2str m[])
-{
-	int i;
-
-	for (i = 0; m[i].str; ++i) {
-		if (m[i].val == v)
-			return i;
-	}
-	return -1;
-}
-
-/* Find first index of given string in table m */
-int int2str_findstr(const char *str, const struct int2str m[])
-{
-	int i;
-
-	for (i = 0; m[i].str; ++i) {
-		if (strcmp(m[i].str, str) == 0)
-			return i;
-	}
-	return -1;
-}
-
-/*
- * convert bd_addr to string
- * buf must be at least 18 char long
- *
- * returns buf
- */
-const char *bt_bdaddr_t2str(const bt_bdaddr_t *bd_addr, char *buf)
-{
-	const uint8_t *p = bd_addr->address;
-
-	snprintf(buf, MAX_ADDR_STR_LEN, "%02x:%02x:%02x:%02x:%02x:%02x",
-					p[0], p[1], p[2], p[3], p[4], p[5]);
-
-	return buf;
-}
-
-/* converts string to bt_bdaddr_t */
-void str2bt_bdaddr_t(const char *str, bt_bdaddr_t *bd_addr)
-{
-	uint8_t *p = bd_addr->address;
-
-	sscanf(str, "%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx",
-				&p[0], &p[1], &p[2], &p[3], &p[4], &p[5]);
-}
-
-/* converts string to uuid */
-void str2bt_uuid_t(const char *str, bt_uuid_t *uuid)
-{
-	int i = 0;
-
-	memcpy(uuid, BT_BASE_UUID, sizeof(bt_uuid_t));
-
-	while (*str && i < (int) sizeof(bt_uuid_t)) {
-		while (*str == '-')
-			str++;
-
-		if (sscanf(str, "%02hhx", &uuid->uu[i]) != 1)
-			break;
-
-		i++;
-		str += 2;
-	}
-}
-
-const char *enum_defines(void *v, int i)
-{
-	const struct int2str *m = v;
-
-	return m[i].str != NULL ? m[i].str : NULL;
-}
-
-const char *enum_strings(void *v, int i)
-{
-	const char **m = v;
-
-	return m[i] != NULL ? m[i] : NULL;
-}
-
-const char *enum_one_string(void *v, int i)
-{
-	const char *m = v;
-
-	return (i == 0) && (m[0] != 0) ? m : NULL;
-}
-
-const char *bdaddr2str(const bt_bdaddr_t *bd_addr)
-{
-	static char buf[MAX_ADDR_STR_LEN];
-
-	return bt_bdaddr_t2str(bd_addr, buf);
-}
-
-const char *btproperty2str(const bt_property_t *property)
-{
-	static char buf[4096];
-	char *p;
-
-	p = buf + sprintf(buf, "type=%s len=%d val=",
-					bt_property_type_t2str(property->type),
-					property->len);
-
-	switch (property->type) {
-	case BT_PROPERTY_BDNAME:
-	case BT_PROPERTY_REMOTE_FRIENDLY_NAME:
-		snprintf(p, property->len + 1, "%s",
-					((bt_bdname_t *) property->val)->name);
-		break;
-
-	case BT_PROPERTY_BDADDR:
-		sprintf(p, "%s", bdaddr2str((bt_bdaddr_t *) property->val));
-		break;
-
-	case BT_PROPERTY_CLASS_OF_DEVICE:
-		sprintf(p, "%06x", *((int *) property->val));
-		break;
-
-	case BT_PROPERTY_TYPE_OF_DEVICE:
-		sprintf(p, "%s", bt_device_type_t2str(
-				*((bt_device_type_t *) property->val)));
-		break;
-
-	case BT_PROPERTY_REMOTE_RSSI:
-		sprintf(p, "%d", *((char *) property->val));
-		break;
-
-	case BT_PROPERTY_ADAPTER_SCAN_MODE:
-		sprintf(p, "%s",
-			bt_scan_mode_t2str(*((bt_scan_mode_t *) property->val)));
-		break;
-
-	case BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT:
-		sprintf(p, "%d", *((int *) property->val));
-		break;
-
-	case BT_PROPERTY_ADAPTER_BONDED_DEVICES:
-		{
-			int count = property->len / sizeof(bt_bdaddr_t);
-			char *ptr = property->val;
-
-			strcat(p, "{");
-
-			while (count--) {
-				strcat(p, bdaddr2str((bt_bdaddr_t *) ptr));
-				if (count)
-					strcat(p, ", ");
-				ptr += sizeof(bt_bdaddr_t);
-			}
-
-			strcat(p, "}");
-
-		}
-		break;
-
-	case BT_PROPERTY_UUIDS:
-		{
-			int count = property->len / sizeof(bt_uuid_t);
-			uint8_t *ptr = property->val;
-
-			strcat(p, "{");
-
-			while (count--) {
-				strcat(p, btuuid2str(ptr));
-				if (count)
-					strcat(p, ", ");
-				ptr += sizeof(bt_uuid_t);
-			}
-
-			strcat(p, "}");
-
-		}
-		break;
-
-	case BT_PROPERTY_SERVICE_RECORD:
-		{
-			bt_service_record_t *rec = property->val;
-
-			sprintf(p, "{%s, %d, %s}", btuuid2str(rec->uuid.uu),
-						rec->channel, rec->name);
-		}
-		break;
-
-	default:
-		sprintf(p, "%p", property->val);
-	}
-
-	return buf;
-}
diff --git a/android/client/textconv.h b/android/client/textconv.h
deleted file mode 100644
index 0a72805..0000000
--- a/android/client/textconv.h
+++ /dev/null
@@ -1,120 +0,0 @@
-/*
- * Copyright (C) 2013 Intel Corporation
- *
- * Licensed under the Apache License, Version 2.0 (the "License");
- * you may not use this file except in compliance with the License.
- * You may obtain a copy of the License at
- *
- *      http://www.apache.org/licenses/LICENSE-2.0
- *
- * Unless required by applicable law or agreed to in writing, software
- * distributed under the License is distributed on an "AS IS" BASIS,
- * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
- * See the License for the specific language governing permissions and
- * limitations under the License.
- *
- */
-
-/**
- * Begin mapping section
- *
- * There are some mappings between integer values (enums) and strings
- * to be presented to user. To make it easier to convert between those two
- * set of macros is given. It is specially useful when we want to have
- * strings that match constants from header files like:
- *  BT_STATUS_SUCCESS (0) and corresponding "BT_STATUS_SUCCESS"
- * Example of usage:
- *
- * INTMAP(int, -1, "invalid")
- *   DELEMENT(BT_STATUS_SUCCESS)
- *   DELEMENT(BT_STATUS_FAIL)
- *   MELEMENT(123, "Some strange value")
- * ENDMAP
- *
- * Just by doing this we have mapping table plus two functions:
- *  int str2int(const char *str);
- *  const char *int2str(int v);
- *
- * second argument to INTMAP specifies value to be returned from
- * str2int function when there is not mapping for such number
- * third argument specifies default value to be returned from int2str
- *
- * If same mapping is to be used in several source files put
- * INTMAP in c file and DECINTMAP in h file.
- *
- * For mappings that are to be used in single file only
- * use SINTMAP which will create the same but everything will be marked
- * as static.
- */
-
-struct int2str {
-	int val;		/* int value */
-	const char *str;	/* corresponding string */
-};
-
-int int2str_findint(int v, const struct int2str m[]);
-int int2str_findstr(const char *str, const struct int2str m[]);
-const char *enum_defines(void *v, int i);
-const char *enum_strings(void *v, int i);
-const char *enum_one_string(void *v, int i);
-
-#define TYPE_ENUM(type) ((void *) &__##type##2str[0])
-#define DECINTMAP(type) \
-extern struct int2str __##type##2str[]; \
-const char *type##2##str(type v); \
-type str##2##type(const char *str); \
-
-#define INTMAP(type, deft, defs) \
-const char *type##2##str(type v) \
-{ \
-	int i = int2str_findint((int) v, __##type##2str); \
-	return (i < 0) ? defs : __##type##2str[i].str; \
-} \
-type str##2##type(const char *str) \
-{ \
-	int i = int2str_findstr(str, __##type##2str); \
-	return (i < 0) ? (type) deft : (type) (__##type##2str[i].val); \
-} \
-struct int2str __##type##2str[] = {
-
-#define SINTMAP(type, deft, defs) \
-static struct int2str __##type##2str[]; \
-static inline const char *type##2##str(type v) \
-{ \
-	int i = int2str_findint((int) v, __##type##2str); \
-	return (i < 0) ? defs : __##type##2str[i].str; \
-} \
-static inline type str##2##type(const char *str) \
-{ \
-	int i = int2str_findstr(str, __##type##2str); \
-	return (i < 0) ? (type) deft : (type) (__##type##2str[i].val); \
-} \
-static struct int2str __##type##2str[] = {
-
-#define ENDMAP {0, NULL} };
-
-/* use this to generate string from header file constant */
-#define MELEMENT(v, s) {v, s}
-/* use this to have arbitrary mapping from int to string */
-#define DELEMENT(s) {s, #s}
-/* End of mapping section */
-
-#define MAX_ADDR_STR_LEN 18
-const char *bt_bdaddr_t2str(const bt_bdaddr_t *bd_addr, char *buf);
-void str2bt_bdaddr_t(const char *str, bt_bdaddr_t *bd_addr);
-
-void str2bt_uuid_t(const char *str, bt_uuid_t *uuid);
-
-const char *btproperty2str(const bt_property_t *property);
-const char *bdaddr2str(const bt_bdaddr_t *bd_addr);
-
-DECINTMAP(bt_status_t);
-DECINTMAP(bt_state_t);
-DECINTMAP(bt_device_type_t);
-DECINTMAP(bt_scan_mode_t);
-DECINTMAP(bt_discovery_state_t);
-DECINTMAP(bt_acl_state_t);
-DECINTMAP(bt_bond_state_t);
-DECINTMAP(bt_ssp_variant_t);
-DECINTMAP(bt_property_type_t);
-DECINTMAP(bt_cb_thread_evt);
diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 3e5d41f..5c14649 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -24,8 +24,7 @@
 #include "hal.h"
 #include "hal-msg.h"
 #include "hal-ipc.h"
-
-#include "client/textconv.h"
+#include "hal-utils.h"
 
 static const bt_callbacks_t *bt_hal_cbacks = NULL;
 
diff --git a/android/hal-utils.c b/android/hal-utils.c
index 7ac5047..4f44d98 100644
--- a/android/hal-utils.c
+++ b/android/hal-utils.c
@@ -55,3 +55,272 @@ const char *btuuid2str(const uint8_t *uuid)
 
 	return bt_uuid_t2str(uuid, buf);
 }
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
+#if PLATFORM_SDK_VERSION > 17
+	DELEMENT(BT_PROPERTY_REMOTE_VERSION_INFO),
+#endif
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
+const char *bt_bdaddr_t2str(const bt_bdaddr_t *bd_addr, char *buf)
+{
+	const uint8_t *p = bd_addr->address;
+
+	snprintf(buf, MAX_ADDR_STR_LEN, "%02x:%02x:%02x:%02x:%02x:%02x",
+					p[0], p[1], p[2], p[3], p[4], p[5]);
+
+	return buf;
+}
+
+/* converts string to bt_bdaddr_t */
+void str2bt_bdaddr_t(const char *str, bt_bdaddr_t *bd_addr)
+{
+	uint8_t *p = bd_addr->address;
+
+	sscanf(str, "%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx",
+				&p[0], &p[1], &p[2], &p[3], &p[4], &p[5]);
+}
+
+/* converts string to uuid */
+void str2bt_uuid_t(const char *str, bt_uuid_t *uuid)
+{
+	int i = 0;
+
+	memcpy(uuid, BT_BASE_UUID, sizeof(bt_uuid_t));
+
+	while (*str && i < (int) sizeof(bt_uuid_t)) {
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
+
+const char *enum_defines(void *v, int i)
+{
+	const struct int2str *m = v;
+
+	return m[i].str != NULL ? m[i].str : NULL;
+}
+
+const char *enum_strings(void *v, int i)
+{
+	const char **m = v;
+
+	return m[i] != NULL ? m[i] : NULL;
+}
+
+const char *enum_one_string(void *v, int i)
+{
+	const char *m = v;
+
+	return (i == 0) && (m[0] != 0) ? m : NULL;
+}
+
+const char *bdaddr2str(const bt_bdaddr_t *bd_addr)
+{
+	static char buf[MAX_ADDR_STR_LEN];
+
+	return bt_bdaddr_t2str(bd_addr, buf);
+}
+
+const char *btproperty2str(const bt_property_t *property)
+{
+	static char buf[4096];
+	char *p;
+
+	p = buf + sprintf(buf, "type=%s len=%d val=",
+					bt_property_type_t2str(property->type),
+					property->len);
+
+	switch (property->type) {
+	case BT_PROPERTY_BDNAME:
+	case BT_PROPERTY_REMOTE_FRIENDLY_NAME:
+		snprintf(p, property->len + 1, "%s",
+					((bt_bdname_t *) property->val)->name);
+		break;
+
+	case BT_PROPERTY_BDADDR:
+		sprintf(p, "%s", bdaddr2str((bt_bdaddr_t *) property->val));
+		break;
+
+	case BT_PROPERTY_CLASS_OF_DEVICE:
+		sprintf(p, "%06x", *((int *) property->val));
+		break;
+
+	case BT_PROPERTY_TYPE_OF_DEVICE:
+		sprintf(p, "%s", bt_device_type_t2str(
+				*((bt_device_type_t *) property->val)));
+		break;
+
+	case BT_PROPERTY_REMOTE_RSSI:
+		sprintf(p, "%d", *((char *) property->val));
+		break;
+
+	case BT_PROPERTY_ADAPTER_SCAN_MODE:
+		sprintf(p, "%s",
+			bt_scan_mode_t2str(*((bt_scan_mode_t *) property->val)));
+		break;
+
+	case BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT:
+		sprintf(p, "%d", *((int *) property->val));
+		break;
+
+	case BT_PROPERTY_ADAPTER_BONDED_DEVICES:
+		{
+			int count = property->len / sizeof(bt_bdaddr_t);
+			char *ptr = property->val;
+
+			strcat(p, "{");
+
+			while (count--) {
+				strcat(p, bdaddr2str((bt_bdaddr_t *) ptr));
+				if (count)
+					strcat(p, ", ");
+				ptr += sizeof(bt_bdaddr_t);
+			}
+
+			strcat(p, "}");
+
+		}
+		break;
+
+	case BT_PROPERTY_UUIDS:
+		{
+			int count = property->len / sizeof(bt_uuid_t);
+			uint8_t *ptr = property->val;
+
+			strcat(p, "{");
+
+			while (count--) {
+				strcat(p, btuuid2str(ptr));
+				if (count)
+					strcat(p, ", ");
+				ptr += sizeof(bt_uuid_t);
+			}
+
+			strcat(p, "}");
+
+		}
+		break;
+
+	case BT_PROPERTY_SERVICE_RECORD:
+		{
+			bt_service_record_t *rec = property->val;
+
+			sprintf(p, "{%s, %d, %s}", btuuid2str(rec->uuid.uu),
+						rec->channel, rec->name);
+		}
+		break;
+
+	default:
+		sprintf(p, "%p", property->val);
+	}
+
+	return buf;
+}
diff --git a/android/hal-utils.h b/android/hal-utils.h
index 8c74653..75de7e9 100644
--- a/android/hal-utils.h
+++ b/android/hal-utils.h
@@ -15,8 +15,11 @@
  *
  */
 
+#include <hardware/bluetooth.h>
+
 #define MAX_UUID_STR_LEN	37
 #define HAL_UUID_LEN		16
+#define MAX_ADDR_STR_LEN	18
 
 static const char BT_BASE_UUID[] = {
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,
@@ -25,3 +28,103 @@ static const char BT_BASE_UUID[] = {
 
 const char *bt_uuid_t2str(const uint8_t *uuid, char *buf);
 const char *btuuid2str(const uint8_t *uuid);
+const char *bt_bdaddr_t2str(const bt_bdaddr_t *bd_addr, char *buf);
+void str2bt_bdaddr_t(const char *str, bt_bdaddr_t *bd_addr);
+void str2bt_uuid_t(const char *str, bt_uuid_t *uuid);
+const char *btproperty2str(const bt_property_t *property);
+const char *bdaddr2str(const bt_bdaddr_t *bd_addr);
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
+const char *enum_defines(void *v, int i);
+const char *enum_strings(void *v, int i);
+const char *enum_one_string(void *v, int i);
+
+#define TYPE_ENUM(type) ((void *) &__##type##2str[0])
+#define DECINTMAP(type) \
+extern struct int2str __##type##2str[]; \
+const char *type##2##str(type v); \
+type str##2##type(const char *str); \
+
+#define INTMAP(type, deft, defs) \
+const char *type##2##str(type v) \
+{ \
+	int i = int2str_findint((int) v, __##type##2str); \
+	return (i < 0) ? defs : __##type##2str[i].str; \
+} \
+type str##2##type(const char *str) \
+{ \
+	int i = int2str_findstr(str, __##type##2str); \
+	return (i < 0) ? (type) deft : (type) (__##type##2str[i].val); \
+} \
+struct int2str __##type##2str[] = {
+
+#define SINTMAP(type, deft, defs) \
+static struct int2str __##type##2str[]; \
+static inline const char *type##2##str(type v) \
+{ \
+	int i = int2str_findint((int) v, __##type##2str); \
+	return (i < 0) ? defs : __##type##2str[i].str; \
+} \
+static inline type str##2##type(const char *str) \
+{ \
+	int i = int2str_findstr(str, __##type##2str); \
+	return (i < 0) ? (type) deft : (type) (__##type##2str[i].val); \
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
1.7.10.4

