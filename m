Return-Path: <cyrus@holtmann.org>
From: "Dirk-Jan C. Binnema" <djcb.bulk@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: "Dirk-Jan C. Binnema" <djcb@djcbsoftware.nl>
Subject: [PATCH 2/3] Rename GATT_OPT_CHR_UUID into GATT_OPT_CHR_UUID16
Date: Mon, 29 Jul 2013 11:42:49 -0700
Message-Id: <1375123370-20055-2-git-send-email-djcb.bulk@gmail.com>
In-Reply-To: <1375123370-20055-1-git-send-email-djcb.bulk@gmail.com>
References: <1375123370-20055-1-git-send-email-djcb.bulk@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Dirk-Jan C. Binnema" <djcb@djcbsoftware.nl>

Rename the option for all in-tree users. This frees up GATT_OPT_CHR_UUID to be used
for UUIDs of type bt_uuid_t* (in a next patch).
---
 attrib/gatt-service.c         |  4 ++--
 attrib/gatt-service.h         |  2 +-
 plugins/gatt-example.c        |  2 +-
 profiles/alert/server.c       | 16 ++++++++--------
 profiles/proximity/immalert.c |  2 +-
 profiles/proximity/linkloss.c |  2 +-
 profiles/time/server.c        |  8 ++++----
 7 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/attrib/gatt-service.c b/attrib/gatt-service.c
index 1b84c89..6ae3902 100644
--- a/attrib/gatt-service.c
+++ b/attrib/gatt-service.c
@@ -68,7 +68,7 @@ static GSList *parse_opts(gatt_option opt1, va_list args)
 
 	while (opt != GATT_OPT_INVALID) {
 		switch (opt) {
-		case GATT_OPT_CHR_UUID:
+		case GATT_OPT_CHR_UUID16:
 			bt_uuid16_create(&info->uuid, va_arg(args, int));
 			/* characteristic declaration and value */
 			info->num_attrs += 2;
@@ -108,7 +108,7 @@ static GSList *parse_opts(gatt_option opt1, va_list args)
 		}
 
 		opt = va_arg(args, gatt_option);
-		if (opt == GATT_OPT_CHR_UUID) {
+		if (opt == GATT_OPT_CHR_UUID16) {
 			info = g_new0(struct gatt_info, 1);
 			l = g_slist_append(l, info);
 		}
diff --git a/attrib/gatt-service.h b/attrib/gatt-service.h
index b810e2e..3964c2b 100644
--- a/attrib/gatt-service.h
+++ b/attrib/gatt-service.h
@@ -24,7 +24,7 @@
 
 typedef enum {
 	GATT_OPT_INVALID = 0,
-	GATT_OPT_CHR_UUID,
+	GATT_OPT_CHR_UUID16,
 	GATT_OPT_CHR_PROPS,
 	GATT_OPT_CHR_VALUE_CB,
 	GATT_OPT_CHR_AUTHENTICATION,
diff --git a/plugins/gatt-example.c b/plugins/gatt-example.c
index 37972e8..b926947 100644
--- a/plugins/gatt-example.c
+++ b/plugins/gatt-example.c
@@ -114,7 +114,7 @@ static gboolean register_battery_service(struct btd_adapter *adapter)
 
 	return gatt_service_add(adapter, GATT_PRIM_SVC_UUID, &uuid,
 			/* battery state characteristic */
-			GATT_OPT_CHR_UUID, BATTERY_STATE_UUID,
+			GATT_OPT_CHR_UUID16, BATTERY_STATE_UUID,
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ |
 							ATT_CHAR_PROPER_NOTIFY,
 			GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index 8da1928..4565470 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -789,7 +789,7 @@ static void register_phone_alert_service(struct alert_adapter *al_adapter)
 	/* Phone Alert Status Service */
 	gatt_service_add(al_adapter->adapter, GATT_PRIM_SVC_UUID, &uuid,
 			/* Alert Status characteristic */
-			GATT_OPT_CHR_UUID, ALERT_STATUS_CHR_UUID,
+			GATT_OPT_CHR_UUID16, ALERT_STATUS_CHR_UUID,
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ |
 							ATT_CHAR_PROPER_NOTIFY,
 			GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
@@ -799,12 +799,12 @@ static void register_phone_alert_service(struct alert_adapter *al_adapter)
 			GATT_OPT_CHR_VALUE_GET_HANDLE,
 			&al_adapter->hnd_value[NOTIFY_ALERT_STATUS],
 			/* Ringer Control Point characteristic */
-			GATT_OPT_CHR_UUID, RINGER_CP_CHR_UUID,
+			GATT_OPT_CHR_UUID16, RINGER_CP_CHR_UUID,
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_WRITE_WITHOUT_RESP,
 			GATT_OPT_CHR_VALUE_CB, ATTRIB_WRITE,
 			ringer_cp_write, NULL,
 			/* Ringer Setting characteristic */
-			GATT_OPT_CHR_UUID, RINGER_SETTING_CHR_UUID,
+			GATT_OPT_CHR_UUID16, RINGER_SETTING_CHR_UUID,
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ |
 							ATT_CHAR_PROPER_NOTIFY,
 			GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
@@ -892,35 +892,35 @@ static void register_alert_notif_service(struct alert_adapter *al_adapter)
 	/* Alert Notification Service */
 	gatt_service_add(al_adapter->adapter, GATT_PRIM_SVC_UUID, &uuid,
 			/* Supported New Alert Category */
-			GATT_OPT_CHR_UUID, SUPP_NEW_ALERT_CAT_CHR_UUID,
+			GATT_OPT_CHR_UUID16, SUPP_NEW_ALERT_CAT_CHR_UUID,
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ,
 			GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
 			supp_new_alert_cat_read, al_adapter->adapter,
 			GATT_OPT_CHR_VALUE_GET_HANDLE,
 			&al_adapter->supp_new_alert_cat_handle,
 			/* New Alert */
-			GATT_OPT_CHR_UUID, NEW_ALERT_CHR_UUID,
+			GATT_OPT_CHR_UUID16, NEW_ALERT_CHR_UUID,
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_NOTIFY,
 			GATT_OPT_CCC_GET_HANDLE,
 			&al_adapter->hnd_ccc[NOTIFY_NEW_ALERT],
 			GATT_OPT_CHR_VALUE_GET_HANDLE,
 			&al_adapter->hnd_value[NOTIFY_NEW_ALERT],
 			/* Supported Unread Alert Category */
-			GATT_OPT_CHR_UUID, SUPP_UNREAD_ALERT_CAT_CHR_UUID,
+			GATT_OPT_CHR_UUID16, SUPP_UNREAD_ALERT_CAT_CHR_UUID,
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ,
 			GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
 			supp_unread_alert_cat_read, al_adapter->adapter,
 			GATT_OPT_CHR_VALUE_GET_HANDLE,
 			&al_adapter->supp_unread_alert_cat_handle,
 			/* Unread Alert Status */
-			GATT_OPT_CHR_UUID, UNREAD_ALERT_CHR_UUID,
+			GATT_OPT_CHR_UUID16, UNREAD_ALERT_CHR_UUID,
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_NOTIFY,
 			GATT_OPT_CCC_GET_HANDLE,
 			&al_adapter->hnd_ccc[NOTIFY_UNREAD_ALERT],
 			GATT_OPT_CHR_VALUE_GET_HANDLE,
 			&al_adapter->hnd_value[NOTIFY_UNREAD_ALERT],
 			/* Alert Notification Control Point */
-			GATT_OPT_CHR_UUID, ALERT_NOTIF_CP_CHR_UUID,
+			GATT_OPT_CHR_UUID16, ALERT_NOTIF_CP_CHR_UUID,
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_WRITE,
 			GATT_OPT_CHR_VALUE_CB, ATTRIB_WRITE,
 			alert_notif_cp_write, NULL,
diff --git a/profiles/proximity/immalert.c b/profiles/proximity/immalert.c
index 06e8eb8..2f8d4e7 100644
--- a/profiles/proximity/immalert.c
+++ b/profiles/proximity/immalert.c
@@ -249,7 +249,7 @@ void imm_alert_register(struct btd_adapter *adapter)
 	svc_added = gatt_service_add(adapter,
 				GATT_PRIM_SVC_UUID, &uuid,
 				/* Alert level characteristic */
-				GATT_OPT_CHR_UUID, ALERT_LEVEL_CHR_UUID,
+				GATT_OPT_CHR_UUID16, ALERT_LEVEL_CHR_UUID,
 				GATT_OPT_CHR_PROPS,
 					ATT_CHAR_PROPER_WRITE_WITHOUT_RESP,
 				GATT_OPT_CHR_VALUE_CB, ATTRIB_WRITE,
diff --git a/profiles/proximity/linkloss.c b/profiles/proximity/linkloss.c
index cb87b12..a7ed96c 100644
--- a/profiles/proximity/linkloss.c
+++ b/profiles/proximity/linkloss.c
@@ -290,7 +290,7 @@ void link_loss_register(struct btd_adapter *adapter)
 	svc_added = gatt_service_add(adapter,
 			GATT_PRIM_SVC_UUID, &uuid,
 			/* Alert level characteristic */
-			GATT_OPT_CHR_UUID, ALERT_LEVEL_CHR_UUID,
+			GATT_OPT_CHR_UUID16, ALERT_LEVEL_CHR_UUID,
 			GATT_OPT_CHR_PROPS,
 				ATT_CHAR_PROPER_READ | ATT_CHAR_PROPER_WRITE,
 			GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
diff --git a/profiles/time/server.c b/profiles/time/server.c
index 518a29f..178d4d2 100644
--- a/profiles/time/server.c
+++ b/profiles/time/server.c
@@ -152,14 +152,14 @@ static gboolean register_current_time_service(struct btd_adapter *adapter)
 	/* Current Time service */
 	return gatt_service_add(adapter, GATT_PRIM_SVC_UUID, &uuid,
 				/* CT Time characteristic */
-				GATT_OPT_CHR_UUID, CT_TIME_CHR_UUID,
+				GATT_OPT_CHR_UUID16, CT_TIME_CHR_UUID,
 				GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ |
 							ATT_CHAR_PROPER_NOTIFY,
 				GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
 						current_time_read, adapter,
 
 				/* Local Time Information characteristic */
-				GATT_OPT_CHR_UUID, LOCAL_TIME_INFO_CHR_UUID,
+				GATT_OPT_CHR_UUID16, LOCAL_TIME_INFO_CHR_UUID,
 				GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ,
 				GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
 						local_time_info_read, adapter,
@@ -215,14 +215,14 @@ static gboolean register_ref_time_update_service(struct btd_adapter *adapter)
 	/* Reference Time Update service */
 	return gatt_service_add(adapter, GATT_PRIM_SVC_UUID, &uuid,
 				/* Time Update control point */
-				GATT_OPT_CHR_UUID, TIME_UPDATE_CTRL_CHR_UUID,
+				GATT_OPT_CHR_UUID16, TIME_UPDATE_CTRL_CHR_UUID,
 				GATT_OPT_CHR_PROPS,
 					ATT_CHAR_PROPER_WRITE_WITHOUT_RESP,
 				GATT_OPT_CHR_VALUE_CB, ATTRIB_WRITE,
 						time_update_control, adapter,
 
 				/* Time Update status */
-				GATT_OPT_CHR_UUID, TIME_UPDATE_STAT_CHR_UUID,
+				GATT_OPT_CHR_UUID16, TIME_UPDATE_STAT_CHR_UUID,
 				GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ,
 				GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
 						time_update_status, adapter,
-- 
1.8.1.4

