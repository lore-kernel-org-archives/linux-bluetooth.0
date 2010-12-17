Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 4/4] Move local name parsing to parse_eir_data()
Date: Fri, 17 Dec 2010 10:57:24 -0400
Message-Id: <1292597844-17135-4-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1292597844-17135-1-git-send-email-bruna.moreira@openbossa.org>
References: <1292597844-17135-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Lizardo <anderson.lizardo@openbossa.org>

---
 src/adapter.c     |   12 +++++-------
 src/adapter.h     |    3 ++-
 src/event.c       |   34 ++++++++++++++++++++++------------
 src/glib-helper.c |   22 ----------------------
 src/glib-helper.h |    1 -
 5 files changed, 29 insertions(+), 43 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index c74019d..b826d4a 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2805,7 +2805,8 @@ static void remove_same_uuid(gpointer data, gpointer user_data)
 
 void adapter_update_device_from_info(struct btd_adapter *adapter,
 						le_advertising_info *info,
-						GSList *services, uint8_t flags)
+						char *name, GSList *services,
+						uint8_t flags)
 {
 	struct remote_dev_info *dev;
 	bdaddr_t bdaddr;
@@ -2833,12 +2834,9 @@ void adapter_update_device_from_info(struct btd_adapter *adapter,
 
 	dev->flags = flags;
 
-	if (info->length) {
-		char *tmp_name = bt_extract_eir_name(info->data, NULL);
-		if (tmp_name) {
-			g_free(dev->name);
-			dev->name = tmp_name;
-		}
+	if (name) {
+		g_free(dev->name);
+		dev->name = name;
 	}
 
 	/* FIXME: check if other information was changed before emitting the
diff --git a/src/adapter.h b/src/adapter.h
index d5dceb9..52417b6 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -125,7 +125,8 @@ struct remote_dev_info *adapter_search_found_devices(struct btd_adapter *adapter
 						struct remote_dev_info *match);
 void adapter_update_device_from_info(struct btd_adapter *adapter,
 						le_advertising_info *info,
-						GSList *services, uint8_t flags);
+						char *name, GSList *services,
+						uint8_t flags);
 void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 				int8_t rssi, uint32_t class, const char *name,
 				const char *alias, gboolean legacy,
diff --git a/src/event.c b/src/event.c
index 4672106..e138312 100644
--- a/src/event.c
+++ b/src/event.c
@@ -61,6 +61,8 @@
 struct eir_data {
 	GSList *services;
 	uint8_t flags;
+	char *name;
+	gboolean name_complete;
 };
 
 static gboolean get_adapter_and_device(bdaddr_t *src, bdaddr_t *dst,
@@ -350,6 +352,16 @@ static int parse_eir_data(struct eir_data *eir, uint8_t *eir_data,
 		case EIR_FLAGS:
 			eir->flags = eir_data[2];
 			break;
+		case EIR_NAME_SHORT:
+		case EIR_NAME_COMPLETE:
+			if (g_utf8_validate((char *) &eir_data[2],
+							field_len - 1, NULL))
+				eir->name = g_strndup((char *) &eir_data[2],
+								field_len - 1);
+			else
+				eir->name = g_strdup("");
+			eir->name_complete = eir_data[1] == EIR_NAME_COMPLETE;
+			break;
 		}
 
 		len += field_len + 1;
@@ -426,8 +438,8 @@ void btd_event_advertising_report(bdaddr_t *local, le_advertising_info *info)
 		error("Error parsing advertising data: %s (%d)",
 							strerror(-err), -err);
 
-	adapter_update_device_from_info(adapter, info, eir_data.services,
-								eir_data.flags);
+	adapter_update_device_from_info(adapter, info, eir_data.name,
+					eir_data.services, eir_data.flags);
 }
 
 void btd_event_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
@@ -436,9 +448,8 @@ void btd_event_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 	char filename[PATH_MAX + 1];
 	struct btd_adapter *adapter;
 	struct btd_device *device;
-	char local_addr[18], peer_addr[18], *alias, *name, *tmp_name;
+	char local_addr[18], peer_addr[18], *alias, *name;
 	struct remote_dev_info *dev, match;
-	uint8_t name_type = 0x00;
 	name_status_t name_status;
 	struct eir_data eir_data;
 	int state, err;
@@ -513,25 +524,24 @@ void btd_event_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 	} else
 		legacy = TRUE;
 
-	tmp_name = bt_extract_eir_name(data, &name_type);
-	if (tmp_name) {
-		if (name_type == 0x09) {
-			write_device_name(local, peer, tmp_name);
+	if (eir_data.name) {
+		if (eir_data.name_complete) {
+			write_device_name(local, peer, eir_data.name);
 			name_status = NAME_NOT_REQUIRED;
 
 			if (name)
 				g_free(name);
 
-			name = tmp_name;
+			name = eir_data.name;
 		} else {
 			if (name)
-				free(tmp_name);
+				free(eir_data.name);
 			else
-				name = tmp_name;
+				name = eir_data.name;
 		}
 	}
 
-	if (name && name_type != 0x08)
+	if (name && eir_data.name_complete)
 		name_status = NAME_SENT;
 
 	/* add in the list to track name sent/pending */
diff --git a/src/glib-helper.c b/src/glib-helper.c
index 6505249..c440e60 100644
--- a/src/glib-helper.c
+++ b/src/glib-helper.c
@@ -780,25 +780,3 @@ GSList *bt_string2list(const gchar *str)
 
 	return l;
 }
-
-char *bt_extract_eir_name(uint8_t *data, uint8_t *type)
-{
-	if (!data || !type)
-		return NULL;
-
-	if (data[0] == 0)
-		return NULL;
-
-	if (type)
-		*type = data[1];
-
-	switch (data[1]) {
-	case EIR_NAME_SHORT:
-	case EIR_NAME_COMPLETE:
-		if (!g_utf8_validate((char *) (data + 2), data[0] - 1, NULL))
-			return g_strdup("");
-		return g_strndup((char *) (data + 2), data[0] - 1);
-	}
-
-	return NULL;
-}
diff --git a/src/glib-helper.h b/src/glib-helper.h
index 5bb20a6..10718bb 100644
--- a/src/glib-helper.h
+++ b/src/glib-helper.h
@@ -42,4 +42,3 @@ char *bt_name2string(const char *string);
 int bt_string2uuid(uuid_t *uuid, const char *string);
 gchar *bt_list2string(GSList *list);
 GSList *bt_string2list(const gchar *str);
-char *bt_extract_eir_name(uint8_t *data, uint8_t *type);
-- 
1.7.0.4

