Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ 08/22] alert: Initial Alert Notification
Date: Mon, 27 Aug 2012 13:11:52 -0400
Message-Id: <1346087526-15107-9-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1346087526-15107-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1346087526-15107-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/alert/server.c |  113 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index 332ffa0..419c7fd 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -41,11 +41,27 @@
 #include "server.h"
 
 #define PHONE_ALERT_STATUS_SVC_UUID		0x180E
+#define ALERT_NOTIF_SVC_UUID			0x1811
 
 #define ALERT_STATUS_CHR_UUID		0x2A3F
 #define RINGER_CP_CHR_UUID		0x2A40
 #define RINGER_SETTING_CHR_UUID		0x2A41
 
+#define ALERT_NOTIF_CP_CHR_UUID		0x2A44
+#define UNREAD_ALERT_CHR_UUID		0x2A45
+#define NEW_ALERT_CHR_UUID		0x2A46
+#define SUPP_NEW_ALERT_CAT_CHR_UUID	0x2A47
+#define SUPP_UNREAD_ALERT_CAT_CHR_UUID	0x2A48
+
+enum {
+	ENABLE_NEW_INCOMING,
+	ENABLE_UNREAD_CAT,
+	DISABLE_NEW_INCOMING,
+	DISABLE_UNREAD_CAT,
+	NOTIFY_NEW_INCOMING,
+	NOTIFY_UNREAD_CAT,
+};
+
 /* Ringer Setting characteristic values */
 enum {
 	RINGER_SILENT,
@@ -122,9 +138,106 @@ static void register_phone_alert_service(struct btd_adapter *adapter)
 			GATT_OPT_INVALID);
 }
 
+static uint8_t supp_new_alert_cat_read(struct attribute *a,
+						struct btd_device *device,
+						gpointer user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	uint8_t value[] = {0x00, 0x00};
+
+	DBG("a = %p", a);
+
+	if (a->data == NULL)
+		attrib_db_update(adapter, a->handle, NULL, value, sizeof(value),
+									NULL);
+
+	return 0;
+}
+
+static uint8_t supp_unread_alert_cat_read(struct attribute *a,
+						struct btd_device *device,
+						gpointer user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	uint8_t value[] = {0x00, 0x00};
+
+	DBG("a = %p", a);
+
+	if (a->data == NULL)
+		attrib_db_update(adapter, a->handle, NULL, value, sizeof(value),
+									NULL);
+
+	return 0;
+}
+
+static uint8_t alert_notif_cp_write(struct attribute *a,
+						struct btd_device *device,
+						gpointer user_data)
+{
+	DBG("a = %p", a);
+
+	switch (a->data[0]) {
+	case ENABLE_NEW_INCOMING:
+		DBG("ENABLE_NEW_INCOMING: 0x%02x", a->data[1]);
+		break;
+	case ENABLE_UNREAD_CAT:
+		DBG("ENABLE_UNREAD_CAT: 0x%02x", a->data[1]);
+		break;
+	case DISABLE_NEW_INCOMING:
+		DBG("DISABLE_NEW_INCOMING: 0x%02x", a->data[1]);
+		break;
+	case DISABLE_UNREAD_CAT:
+		DBG("DISABLE_UNREAD_CAT: 0x%02x", a->data[1]);
+		break;
+	case NOTIFY_NEW_INCOMING:
+		DBG("NOTIFY_NEW_INCOMING: 0x%02x", a->data[1]);
+		break;
+	case NOTIFY_UNREAD_CAT:
+		DBG("NOTIFY_UNREAD_CAT: 0x%02x", a->data[1]);
+		break;
+	default:
+		DBG("0x%02x 0x%02x", a->data[0], a->data[1]);
+	}
+
+	return 0;
+}
+
+static void register_alert_notif_service(struct btd_adapter *adapter)
+{
+	bt_uuid_t uuid;
+
+	bt_uuid16_create(&uuid, ALERT_NOTIF_SVC_UUID);
+
+	/* Alert Notification Service */
+	gatt_service_add(adapter, GATT_PRIM_SVC_UUID, &uuid,
+			/* Supported New Alert Category */
+			GATT_OPT_CHR_UUID, SUPP_NEW_ALERT_CAT_CHR_UUID,
+			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ,
+			GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
+			supp_new_alert_cat_read, adapter,
+			/* New Alert */
+			GATT_OPT_CHR_UUID, NEW_ALERT_CHR_UUID,
+			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_NOTIFY,
+			/* Supported Unread Alert Category */
+			GATT_OPT_CHR_UUID, SUPP_UNREAD_ALERT_CAT_CHR_UUID,
+			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ,
+			GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
+			supp_unread_alert_cat_read, adapter,
+			/* Unread Alert Status */
+			GATT_OPT_CHR_UUID, UNREAD_ALERT_CHR_UUID,
+			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_NOTIFY,
+			/* Alert Notification Control Point */
+			GATT_OPT_CHR_UUID, ALERT_NOTIF_CP_CHR_UUID,
+			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_WRITE,
+			GATT_OPT_CHR_VALUE_CB, ATTRIB_WRITE,
+			alert_notif_cp_write, NULL,
+			GATT_OPT_INVALID);
+}
+
 static int alert_server_probe(struct btd_adapter *adapter)
 {
 	register_phone_alert_service(adapter);
+	register_alert_notif_service(adapter);
 
 	return 0;
 }
-- 
1.7.9.5

