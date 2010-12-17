Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 3/4] Move AD flags parsing to parse_eir_data()
Date: Fri, 17 Dec 2010 10:57:23 -0400
Message-Id: <1292597844-17135-3-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1292597844-17135-1-git-send-email-bruna.moreira@openbossa.org>
References: <1292597844-17135-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Lizardo <anderson.lizardo@openbossa.org>

---
 src/adapter.c |   22 ++++------------------
 src/adapter.h |    3 ++-
 src/event.c   |    7 ++++++-
 3 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 34bf24a..c74019d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2786,21 +2786,6 @@ static struct remote_dev_info *get_found_dev(struct btd_adapter *adapter,
 	return dev;
 }
 
-static gboolean extract_eir_flags(uint8_t *flags, uint8_t *eir_data)
-{
-	if (eir_data[0] == 0)
-		return FALSE;
-
-	if (eir_data[1] != EIR_FLAGS)
-		return FALSE;
-
-	/* For now, only one octet is used for flags */
-	if (flags)
-		*flags = eir_data[2];
-
-	return TRUE;
-}
-
 static void remove_same_uuid(gpointer data, gpointer user_data)
 {
 	struct remote_dev_info *dev = user_data;
@@ -2819,7 +2804,8 @@ static void remove_same_uuid(gpointer data, gpointer user_data)
 }
 
 void adapter_update_device_from_info(struct btd_adapter *adapter,
-				le_advertising_info *info, GSList *services)
+						le_advertising_info *info,
+						GSList *services, uint8_t flags)
 {
 	struct remote_dev_info *dev;
 	bdaddr_t bdaddr;
@@ -2845,14 +2831,14 @@ void adapter_update_device_from_info(struct btd_adapter *adapter,
 	g_slist_foreach(services, remove_same_uuid, dev);
 	dev->services = g_slist_concat(dev->services, services);
 
+	dev->flags = flags;
+
 	if (info->length) {
 		char *tmp_name = bt_extract_eir_name(info->data, NULL);
 		if (tmp_name) {
 			g_free(dev->name);
 			dev->name = tmp_name;
 		}
-
-		extract_eir_flags(info->data, &dev->flags);
 	}
 
 	/* FIXME: check if other information was changed before emitting the
diff --git a/src/adapter.h b/src/adapter.h
index efcf5b8..d5dceb9 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -124,7 +124,8 @@ gboolean adapter_is_ready(struct btd_adapter *adapter);
 struct remote_dev_info *adapter_search_found_devices(struct btd_adapter *adapter,
 						struct remote_dev_info *match);
 void adapter_update_device_from_info(struct btd_adapter *adapter,
-				le_advertising_info *info, GSList *services);
+						le_advertising_info *info,
+						GSList *services, uint8_t flags);
 void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 				int8_t rssi, uint32_t class, const char *name,
 				const char *alias, gboolean legacy,
diff --git a/src/event.c b/src/event.c
index 3352717..4672106 100644
--- a/src/event.c
+++ b/src/event.c
@@ -60,6 +60,7 @@
 
 struct eir_data {
 	GSList *services;
+	uint8_t flags;
 };
 
 static gboolean get_adapter_and_device(bdaddr_t *src, bdaddr_t *dst,
@@ -346,6 +347,9 @@ static int parse_eir_data(struct eir_data *eir, uint8_t *eir_data,
 			uuid128_count = field_len / 16;
 			uuid128 = &eir_data[2];
 			break;
+		case EIR_FLAGS:
+			eir->flags = eir_data[2];
+			break;
 		}
 
 		len += field_len + 1;
@@ -422,7 +426,8 @@ void btd_event_advertising_report(bdaddr_t *local, le_advertising_info *info)
 		error("Error parsing advertising data: %s (%d)",
 							strerror(-err), -err);
 
-	adapter_update_device_from_info(adapter, info, eir_data.services);
+	adapter_update_device_from_info(adapter, info, eir_data.services,
+								eir_data.flags);
 }
 
 void btd_event_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
-- 
1.7.0.4

