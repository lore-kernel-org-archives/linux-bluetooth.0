Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 3/4] gatt-service: Add missing user_data parameter for callbacks
Date: Fri, 30 Dec 2011 12:45:08 +0100
Message-Id: <1325245509-14359-3-git-send-email-sancane@gmail.com>
In-Reply-To: <1325245509-14359-2-git-send-email-sancane@gmail.com>
References: <1325245509-14359-1-git-send-email-sancane@gmail.com>
 <1325245509-14359-2-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gatt-service.c  |    4 ++++
 plugins/gatt-example.c |    7 ++++---
 time/server.c          |    4 ++--
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/attrib/gatt-service.c b/attrib/gatt-service.c
index 93cbf74..bfefdee 100644
--- a/attrib/gatt-service.c
+++ b/attrib/gatt-service.c
@@ -52,6 +52,7 @@ struct gatt_info {
 struct attrib_cb {
 	attrib_event_t event;
 	void *fn;
+	void *user_data;
 };
 
 static GSList *parse_opts(gatt_option opt1, va_list args)
@@ -86,6 +87,7 @@ static GSList *parse_opts(gatt_option opt1, va_list args)
 			cb = g_new0(struct attrib_cb, 1);
 			cb->event = va_arg(args, attrib_event_t);
 			cb->fn = va_arg(args, void *);
+			cb->user_data = va_arg(args, void *);
 			info->callbacks = g_slist_append(info->callbacks, cb);
 			break;
 		case GATT_OPT_CHR_VALUE_GET_HANDLE:
@@ -219,6 +221,8 @@ static gboolean add_characteristic(struct btd_adapter *adapter,
 			a->write_cb = cb->fn;
 			break;
 		}
+
+		a->cb_user_data = cb->user_data;
 	}
 
 	if (info->value_handle != NULL)
diff --git a/plugins/gatt-example.c b/plugins/gatt-example.c
index ae9d41d..5af07ea 100644
--- a/plugins/gatt-example.c
+++ b/plugins/gatt-example.c
@@ -94,11 +94,11 @@ static gint adapter_cmp(gconstpointer a, gconstpointer b)
 
 static uint8_t battery_state_read(struct attribute *a, gpointer user_data)
 {
+	struct btd_adapter *adapter = user_data;
 	uint8_t value;
 
 	value = 0x04;
-	/* FIXME: Provide the adapter in next function */
-	attrib_db_update(NULL, a->handle, NULL, &value, sizeof(value), NULL);
+	attrib_db_update(adapter, a->handle, NULL, &value, sizeof(value), NULL);
 
 	return 0;
 }
@@ -111,7 +111,8 @@ static gboolean register_battery_service(struct btd_adapter *adapter)
 			GATT_OPT_CHR_UUID, BATTERY_STATE_UUID,
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ |
 							ATT_CHAR_PROPER_NOTIFY,
-			GATT_OPT_CHR_VALUE_CB, ATTRIB_READ, battery_state_read,
+			GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
+						battery_state_read, adapter,
 
 			GATT_OPT_INVALID);
 }
diff --git a/time/server.c b/time/server.c
index 4ed9cf2..0730fbb 100644
--- a/time/server.c
+++ b/time/server.c
@@ -123,13 +123,13 @@ static void register_current_time_service(void)
 				GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ |
 							ATT_CHAR_PROPER_NOTIFY,
 				GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
-							current_time_read,
+						current_time_read, NULL,
 
 				/* Local Time Information characteristic */
 				GATT_OPT_CHR_UUID, LOCAL_TIME_INFO_CHR_UUID,
 				GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ,
 				GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
-							local_time_info_read,
+						local_time_info_read, NULL,
 
 				GATT_OPT_INVALID);
 }
-- 
1.7.8.1

