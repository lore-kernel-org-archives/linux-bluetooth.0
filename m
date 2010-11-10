Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH 5/7] Advertising data: extract local name
Date: Wed, 10 Nov 2010 13:51:25 -0400
Message-Id: <1289411487-6113-5-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1289411487-6113-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1289411487-6113-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

Move extract_eir_name() to glib-helper.c file and rename function to
bt_extract_eir_name(). The local name is extracted from the advertising
data.
---
 src/adapter.c     |    7 +++++++
 src/event.c       |   23 +----------------------
 src/glib-helper.c |   22 ++++++++++++++++++++++
 src/glib-helper.h |    1 +
 4 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 6b94a43..95fcbda 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3142,6 +3142,7 @@ void adapter_update_adv(struct btd_adapter *adapter, le_advertising_info *info)
 	struct remote_dev_info *dev;
 	bdaddr_t bdaddr;
 	int8_t rssi = 0;
+	uint8_t type = 0x00;
 
 	rssi = *(info->data + info->length);
 	bdaddr = info->bdaddr;
@@ -3157,6 +3158,12 @@ void adapter_update_adv(struct btd_adapter *adapter, le_advertising_info *info)
 
 	adapter->found_devices = g_slist_sort(adapter->found_devices,
 						(GCompareFunc) dev_rssi_cmp);
+
+	if (info->length) {
+		char *tmp_name = bt_extract_eir_name(info->data, &type);
+		if (tmp_name)
+			dev->name = tmp_name;
+	}
 }
 
 void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
diff --git a/src/event.c b/src/event.c
index 8b03bc3..57bdf60 100644
--- a/src/event.c
+++ b/src/event.c
@@ -301,27 +301,6 @@ void btd_event_simple_pairing_complete(bdaddr_t *local, bdaddr_t *peer,
 	device_simple_pairing_complete(device, status);
 }
 
-static char *extract_eir_name(uint8_t *data, uint8_t *type)
-{
-	if (!data || !type)
-		return NULL;
-
-	if (data[0] == 0)
-		return NULL;
-
-	*type = data[1];
-
-	switch (*type) {
-	case 0x08:
-	case 0x09:
-		if (!g_utf8_validate((char *) (data + 2), data[0] - 1, NULL))
-			return strdup("");
-		return strndup((char *) (data + 2), data[0] - 1);
-	}
-
-	return NULL;
-}
-
 void btd_event_adv(bdaddr_t *local, le_advertising_info *info)
 {
 	struct btd_adapter *adapter;
@@ -410,7 +389,7 @@ void btd_event_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 	} else
 		legacy = TRUE;
 
-	tmp_name = extract_eir_name(data, &name_type);
+	tmp_name = bt_extract_eir_name(data, &name_type);
 	if (tmp_name) {
 		if (name_type == 0x09) {
 			write_device_name(local, peer, tmp_name);
diff --git a/src/glib-helper.c b/src/glib-helper.c
index 9d76626..33668d7 100644
--- a/src/glib-helper.c
+++ b/src/glib-helper.c
@@ -43,6 +43,7 @@
 #include <glib.h>
 
 #include "glib-helper.h"
+#include "sdpd.h"
 
 /* Number of seconds to keep a sdp_session_t in the cache */
 #define CACHE_TIMEOUT 2
@@ -576,3 +577,24 @@ GSList *bt_string2list(const gchar *str)
 
 	return l;
 }
+
+char *bt_extract_eir_name(uint8_t *data, uint8_t *type)
+{
+	if (!data || !type)
+		return NULL;
+
+	if (data[0] == 0)
+		return NULL;
+
+	*type = data[1];
+
+	switch (*type) {
+	case EIR_NAME_SHORT:
+	case EIR_NAME_COMPLETE:
+		if (!g_utf8_validate((char *) (data + 2), data[0] - 1, NULL))
+			return strdup("");
+		return strndup((char *) (data + 2), data[0] - 1);
+	}
+
+	return NULL;
+}
diff --git a/src/glib-helper.h b/src/glib-helper.h
index e89c2c6..dfe4123 100644
--- a/src/glib-helper.h
+++ b/src/glib-helper.h
@@ -38,3 +38,4 @@ char *bt_name2string(const char *string);
 int bt_string2uuid(uuid_t *uuid, const char *string);
 gchar *bt_list2string(GSList *list);
 GSList *bt_string2list(const gchar *str);
+char *bt_extract_eir_name(uint8_t *data, uint8_t *type);
-- 
1.7.0.4

