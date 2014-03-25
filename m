Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0] gatt: Move Characteristic properties to attrib/gatt.h
Date: Tue, 25 Mar 2014 11:42:59 -0300
Message-Id: <1395758579-28846-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Properties are defined by GATT specification. This patch moves and
renames the defines related to Characteristic properties bits from
attrib/att.h to attrib/gatt.h
---
 attrib/att.h                       | 10 ----------
 attrib/gatt-service.c              | 12 ++++++------
 attrib/gatt.h                      | 18 ++++++++++++++++++
 plugins/gatt-example.c             | 20 ++++++++++----------
 profiles/alert/server.c            | 20 ++++++++++----------
 profiles/input/hog.c               |  4 ++--
 profiles/proximity/immalert.c      |  2 +-
 profiles/proximity/linkloss.c      |  2 +-
 profiles/proximity/reporter.c      |  2 +-
 profiles/thermometer/thermometer.c |  4 ++--
 profiles/time/server.c             | 10 +++++-----
 src/attrib-server.c                |  4 ++--
 12 files changed, 58 insertions(+), 50 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index 28bc944..800332d 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -75,16 +75,6 @@
 #define ATT_ECODE_TIMEOUT			0x81
 #define ATT_ECODE_ABORTED			0x82
 
-/* Characteristic Property bit field */
-#define ATT_CHAR_PROPER_BROADCAST		0x01
-#define ATT_CHAR_PROPER_READ			0x02
-#define ATT_CHAR_PROPER_WRITE_WITHOUT_RESP	0x04
-#define ATT_CHAR_PROPER_WRITE			0x08
-#define ATT_CHAR_PROPER_NOTIFY			0x10
-#define ATT_CHAR_PROPER_INDICATE		0x20
-#define ATT_CHAR_PROPER_AUTH			0x40
-#define ATT_CHAR_PROPER_EXT_PROPER		0x80
-
 #define ATT_MAX_VALUE_LEN			512
 #define ATT_DEFAULT_L2CAP_MTU			48
 #define ATT_DEFAULT_LE_MTU			23
diff --git a/attrib/gatt-service.c b/attrib/gatt-service.c
index 3e70c50..874552b 100644
--- a/attrib/gatt-service.c
+++ b/attrib/gatt-service.c
@@ -91,8 +91,8 @@ static GSList *parse_opts(gatt_option opt1, va_list args)
 		case GATT_OPT_CHR_PROPS:
 			info->props = va_arg(args, int);
 
-			if (info->props & (ATT_CHAR_PROPER_NOTIFY |
-						ATT_CHAR_PROPER_INDICATE))
+			if (info->props & (GATT_CHR_PROP_NOTIFY |
+						GATT_CHR_PROP_INDICATE))
 				/* client characteristic configuration */
 				info->num_attrs += 1;
 
@@ -156,7 +156,7 @@ static int att_read_req(int authorization, int authentication, uint8_t props)
 	else if (authentication == GATT_CHR_VALUE_READ ||
 				authentication == GATT_CHR_VALUE_BOTH)
 		return ATT_AUTHENTICATION;
-	else if (!(props & ATT_CHAR_PROPER_READ))
+	else if (!(props & GATT_CHR_PROP_READ))
 		return ATT_NOT_PERMITTED;
 
 	return ATT_NONE;
@@ -170,8 +170,8 @@ static int att_write_req(int authorization, int authentication, uint8_t props)
 	else if (authentication == GATT_CHR_VALUE_WRITE ||
 				authentication == GATT_CHR_VALUE_BOTH)
 		return ATT_AUTHENTICATION;
-	else if (!(props & (ATT_CHAR_PROPER_WRITE |
-					ATT_CHAR_PROPER_WRITE_WITHOUT_RESP)))
+	else if (!(props & (GATT_CHR_PROP_WRITE |
+					GATT_CHR_PROP_WRITE_WITHOUT_RESP)))
 		return ATT_NOT_PERMITTED;
 
 	return ATT_NONE;
@@ -262,7 +262,7 @@ static gboolean add_characteristic(struct btd_adapter *adapter,
 		*info->value_handle = a->handle;
 
 	/* client characteristic configuration descriptor */
-	if (info->props & (ATT_CHAR_PROPER_NOTIFY | ATT_CHAR_PROPER_INDICATE)) {
+	if (info->props & (GATT_CHR_PROP_NOTIFY | GATT_CHR_PROP_INDICATE)) {
 		uint8_t cfg_val[2];
 
 		bt_uuid16_create(&bt_uuid, GATT_CLIENT_CHARAC_CFG_UUID);
diff --git a/attrib/gatt.h b/attrib/gatt.h
index 4fea3eb..a11e473 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -24,6 +24,24 @@
 
 #include <bluetooth/sdp.h>
 
+/*
+ * GATT Characteristic Property bit field
+ * Reference: Core SPEC 4.1 page 2183 (Table 3.5: Characteristic Properties
+ * bit field) defines how the Characteristic Value can be used, or how the
+ * characteristic descriptors (see Section 3.3.3 - page 2184) can be accessed.
+ * In the core spec, regular properties are included in the characteristic
+ * declaration, and the extended properties are defined as descriptor.
+ */
+
+#define GATT_CHR_PROP_BROADCAST				0x01
+#define GATT_CHR_PROP_READ				0x02
+#define GATT_CHR_PROP_WRITE_WITHOUT_RESP		0x04
+#define GATT_CHR_PROP_WRITE				0x08
+#define GATT_CHR_PROP_NOTIFY				0x10
+#define GATT_CHR_PROP_INDICATE				0x20
+#define GATT_CHR_PROP_AUTH				0x40
+#define GATT_CHR_PROP_EXT_PROP				0x80
+
 /* Client Characteristic Configuration bit field */
 #define GATT_CLIENT_CHARAC_CFG_NOTIF_BIT	0x0001
 #define GATT_CLIENT_CHARAC_CFG_IND_BIT		0x0002
diff --git a/plugins/gatt-example.c b/plugins/gatt-example.c
index 22a6925..1e1483c 100644
--- a/plugins/gatt-example.c
+++ b/plugins/gatt-example.c
@@ -116,8 +116,8 @@ static gboolean register_battery_service(struct btd_adapter *adapter)
 	return gatt_service_add(adapter, GATT_PRIM_SVC_UUID, &uuid,
 			/* battery state characteristic */
 			GATT_OPT_CHR_UUID16, BATTERY_STATE_UUID,
-			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ |
-							ATT_CHAR_PROPER_NOTIFY,
+			GATT_OPT_CHR_PROPS, GATT_CHR_PROP_READ |
+							GATT_CHR_PROP_NOTIFY,
 			GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
 						battery_state_read, adapter,
 
@@ -176,7 +176,7 @@ static void register_termometer_service(struct gatt_example_adapter *adapter,
 
 	/* Thermometer: temperature characteristic */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
-	atval[0] = ATT_CHAR_PROPER_READ;
+	atval[0] = GATT_CHR_PROP_READ;
 	put_le16(h + 1, &atval[1]);
 	put_le16(TEMPERATURE_UUID, &atval[3]);
 	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
@@ -208,7 +208,7 @@ static void register_termometer_service(struct gatt_example_adapter *adapter,
 
 	/* Thermometer: relative humidity characteristic */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
-	atval[0] = ATT_CHAR_PROPER_READ;
+	atval[0] = GATT_CHR_PROP_READ;
 	put_le16(h + 1, &atval[1]);
 	put_le16(RELATIVE_HUMIDITY_UUID, &atval[3]);
 	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
@@ -277,7 +277,7 @@ static void register_manuf1_service(struct gatt_example_adapter *adapter,
 
 	/* Manufacturer name characteristic definition */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
-	atval[0] = ATT_CHAR_PROPER_READ;
+	atval[0] = GATT_CHR_PROP_READ;
 	put_le16(h + 1, &atval[1]);
 	put_le16(MANUFACTURER_NAME_UUID, &atval[3]);
 	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
@@ -292,7 +292,7 @@ static void register_manuf1_service(struct gatt_example_adapter *adapter,
 
 	/* Manufacturer serial number characteristic */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
-	atval[0] = ATT_CHAR_PROPER_READ;
+	atval[0] = GATT_CHR_PROP_READ;
 	put_le16(h + 1, &atval[1]);
 	put_le16(MANUFACTURER_SERIAL_UUID, &atval[3]);
 	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
@@ -341,7 +341,7 @@ static void register_manuf2_service(struct gatt_example_adapter *adapter,
 
 	/* Manufacturer name characteristic definition */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
-	atval[0] = ATT_CHAR_PROPER_READ;
+	atval[0] = GATT_CHR_PROP_READ;
 	put_le16(h + 1, &atval[1]);
 	put_le16(MANUFACTURER_NAME_UUID, &atval[3]);
 	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
@@ -356,7 +356,7 @@ static void register_manuf2_service(struct gatt_example_adapter *adapter,
 
 	/* Characteristic: serial number */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
-	atval[0] = ATT_CHAR_PROPER_READ;
+	atval[0] = GATT_CHR_PROP_READ;
 	put_le16(h + 1, &atval[1]);
 	put_le16(MANUFACTURER_SERIAL_UUID, &atval[3]);
 	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
@@ -402,7 +402,7 @@ static void register_vendor_service(struct gatt_example_adapter *adapter,
 
 	/* Vendor Specific Type characteristic definition */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
-	atval[0] = ATT_CHAR_PROPER_READ;
+	atval[0] = GATT_CHR_PROP_READ;
 	put_le16(h + 1, &atval[1]);
 	put_le16(VENDOR_SPECIFIC_TYPE_UUID, &atval[3]);
 	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
@@ -475,7 +475,7 @@ static void register_weight_service(struct gatt_example_adapter *adapter,
 
 	/* Weight: characteristic */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
-	atval[0] = ATT_CHAR_PROPER_READ;
+	atval[0] = GATT_CHR_PROP_READ;
 	put_le16(h + 1, &atval[1]);
 	memcpy(&atval[3], &char_weight_uuid_btorder, 16);
 	attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index 92d4fb6..1612d6c 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -806,8 +806,8 @@ static void register_phone_alert_service(struct alert_adapter *al_adapter)
 	gatt_service_add(al_adapter->adapter, GATT_PRIM_SVC_UUID, &uuid,
 			/* Alert Status characteristic */
 			GATT_OPT_CHR_UUID16, ALERT_STATUS_CHR_UUID,
-			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ |
-							ATT_CHAR_PROPER_NOTIFY,
+			GATT_OPT_CHR_PROPS, GATT_CHR_PROP_READ |
+							GATT_CHR_PROP_NOTIFY,
 			GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
 			alert_status_read, al_adapter->adapter,
 			GATT_OPT_CCC_GET_HANDLE,
@@ -816,13 +816,13 @@ static void register_phone_alert_service(struct alert_adapter *al_adapter)
 			&al_adapter->hnd_value[NOTIFY_ALERT_STATUS],
 			/* Ringer Control Point characteristic */
 			GATT_OPT_CHR_UUID16, RINGER_CP_CHR_UUID,
-			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_WRITE_WITHOUT_RESP,
+			GATT_OPT_CHR_PROPS, GATT_CHR_PROP_WRITE_WITHOUT_RESP,
 			GATT_OPT_CHR_VALUE_CB, ATTRIB_WRITE,
 			ringer_cp_write, NULL,
 			/* Ringer Setting characteristic */
 			GATT_OPT_CHR_UUID16, RINGER_SETTING_CHR_UUID,
-			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ |
-							ATT_CHAR_PROPER_NOTIFY,
+			GATT_OPT_CHR_PROPS, GATT_CHR_PROP_READ |
+							GATT_CHR_PROP_NOTIFY,
 			GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
 			ringer_setting_read, al_adapter->adapter,
 			GATT_OPT_CCC_GET_HANDLE,
@@ -909,35 +909,35 @@ static void register_alert_notif_service(struct alert_adapter *al_adapter)
 	gatt_service_add(al_adapter->adapter, GATT_PRIM_SVC_UUID, &uuid,
 			/* Supported New Alert Category */
 			GATT_OPT_CHR_UUID16, SUPP_NEW_ALERT_CAT_CHR_UUID,
-			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ,
+			GATT_OPT_CHR_PROPS, GATT_CHR_PROP_READ,
 			GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
 			supp_new_alert_cat_read, al_adapter->adapter,
 			GATT_OPT_CHR_VALUE_GET_HANDLE,
 			&al_adapter->supp_new_alert_cat_handle,
 			/* New Alert */
 			GATT_OPT_CHR_UUID16, NEW_ALERT_CHR_UUID,
-			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_NOTIFY,
+			GATT_OPT_CHR_PROPS, GATT_CHR_PROP_NOTIFY,
 			GATT_OPT_CCC_GET_HANDLE,
 			&al_adapter->hnd_ccc[NOTIFY_NEW_ALERT],
 			GATT_OPT_CHR_VALUE_GET_HANDLE,
 			&al_adapter->hnd_value[NOTIFY_NEW_ALERT],
 			/* Supported Unread Alert Category */
 			GATT_OPT_CHR_UUID16, SUPP_UNREAD_ALERT_CAT_CHR_UUID,
-			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ,
+			GATT_OPT_CHR_PROPS, GATT_CHR_PROP_READ,
 			GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
 			supp_unread_alert_cat_read, al_adapter->adapter,
 			GATT_OPT_CHR_VALUE_GET_HANDLE,
 			&al_adapter->supp_unread_alert_cat_handle,
 			/* Unread Alert Status */
 			GATT_OPT_CHR_UUID16, UNREAD_ALERT_CHR_UUID,
-			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_NOTIFY,
+			GATT_OPT_CHR_PROPS, GATT_CHR_PROP_NOTIFY,
 			GATT_OPT_CCC_GET_HANDLE,
 			&al_adapter->hnd_ccc[NOTIFY_UNREAD_ALERT],
 			GATT_OPT_CHR_VALUE_GET_HANDLE,
 			&al_adapter->hnd_value[NOTIFY_UNREAD_ALERT],
 			/* Alert Notification Control Point */
 			GATT_OPT_CHR_UUID16, ALERT_NOTIF_CP_CHR_UUID,
-			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_WRITE,
+			GATT_OPT_CHR_PROPS, GATT_CHR_PROP_WRITE,
 			GATT_OPT_CHR_VALUE_CB, ATTRIB_WRITE,
 			alert_notif_cp_write, NULL,
 			GATT_OPT_INVALID);
diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 25985ec..a11e04e 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -598,10 +598,10 @@ static void forward_report(struct hog_device *hogdev,
 	if (hogdev->attrib == NULL)
 		return;
 
-	if (report->decl->properties & ATT_CHAR_PROPER_WRITE)
+	if (report->decl->properties & GATT_CHR_PROP_WRITE)
 		gatt_write_char(hogdev->attrib, report->decl->value_handle,
 				data, size, output_written_cb, hogdev);
-	else if (report->decl->properties & ATT_CHAR_PROPER_WRITE_WITHOUT_RESP)
+	else if (report->decl->properties & GATT_CHR_PROP_WRITE_WITHOUT_RESP)
 		gatt_write_cmd(hogdev->attrib, report->decl->value_handle,
 						data, size, NULL, NULL);
 }
diff --git a/profiles/proximity/immalert.c b/profiles/proximity/immalert.c
index 1638cf9..3d50b8d 100644
--- a/profiles/proximity/immalert.c
+++ b/profiles/proximity/immalert.c
@@ -252,7 +252,7 @@ void imm_alert_register(struct btd_adapter *adapter)
 				/* Alert level characteristic */
 				GATT_OPT_CHR_UUID16, ALERT_LEVEL_CHR_UUID,
 				GATT_OPT_CHR_PROPS,
-					ATT_CHAR_PROPER_WRITE_WITHOUT_RESP,
+					GATT_CHR_PROP_WRITE_WITHOUT_RESP,
 				GATT_OPT_CHR_VALUE_CB, ATTRIB_WRITE,
 					imm_alert_alert_lvl_write, imadapter,
 				GATT_OPT_INVALID);
diff --git a/profiles/proximity/linkloss.c b/profiles/proximity/linkloss.c
index db16820..476803a 100644
--- a/profiles/proximity/linkloss.c
+++ b/profiles/proximity/linkloss.c
@@ -294,7 +294,7 @@ void link_loss_register(struct btd_adapter *adapter)
 			/* Alert level characteristic */
 			GATT_OPT_CHR_UUID16, ALERT_LEVEL_CHR_UUID,
 			GATT_OPT_CHR_PROPS,
-				ATT_CHAR_PROPER_READ | ATT_CHAR_PROPER_WRITE,
+				GATT_CHR_PROP_READ | GATT_CHR_PROP_WRITE,
 			GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
 				link_loss_alert_lvl_read, lladapter,
 			GATT_OPT_CHR_VALUE_CB, ATTRIB_WRITE,
diff --git a/profiles/proximity/reporter.c b/profiles/proximity/reporter.c
index 5861923..4beeb7c 100644
--- a/profiles/proximity/reporter.c
+++ b/profiles/proximity/reporter.c
@@ -123,7 +123,7 @@ static void register_tx_power(struct btd_adapter *adapter)
 
 	/* Power level characteristic */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
-	atval[0] = ATT_CHAR_PROPER_READ | ATT_CHAR_PROPER_NOTIFY;
+	atval[0] = GATT_CHR_PROP_READ | GATT_CHR_PROP_NOTIFY;
 	put_le16(h + 1, &atval[1]);
 	put_le16(POWER_LEVEL_CHR_UUID, &atval[3]);
 	attrib_db_add(adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index 9462cc9..20575c0 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -721,12 +721,12 @@ static void process_thermometer_char(struct thermometer *t,
 
 		gatt_read_char(t->attrib, c->value_handle, read_interval_cb, t);
 
-		if (c->properties & ATT_CHAR_PROPER_WRITE) {
+		if (c->properties & GATT_CHR_PROP_WRITE) {
 			t->interval_val_handle = c->value_handle;
 			need_desc = true;
 		}
 
-		if (c->properties & ATT_CHAR_PROPER_INDICATE) {
+		if (c->properties & GATT_CHR_PROP_INDICATE) {
 			t->attio_interval_id = g_attrib_register(t->attrib,
 					ATT_OP_HANDLE_IND, c->value_handle,
 					interval_ind_handler, t, NULL);
diff --git a/profiles/time/server.c b/profiles/time/server.c
index 31ddb06..1716a5e 100644
--- a/profiles/time/server.c
+++ b/profiles/time/server.c
@@ -154,14 +154,14 @@ static gboolean register_current_time_service(struct btd_adapter *adapter)
 	return gatt_service_add(adapter, GATT_PRIM_SVC_UUID, &uuid,
 				/* CT Time characteristic */
 				GATT_OPT_CHR_UUID16, CT_TIME_CHR_UUID,
-				GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ |
-							ATT_CHAR_PROPER_NOTIFY,
+				GATT_OPT_CHR_PROPS, GATT_CHR_PROP_READ |
+							GATT_CHR_PROP_NOTIFY,
 				GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
 						current_time_read, adapter,
 
 				/* Local Time Information characteristic */
 				GATT_OPT_CHR_UUID16, LOCAL_TIME_INFO_CHR_UUID,
-				GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ,
+				GATT_OPT_CHR_PROPS, GATT_CHR_PROP_READ,
 				GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
 						local_time_info_read, adapter,
 
@@ -218,13 +218,13 @@ static gboolean register_ref_time_update_service(struct btd_adapter *adapter)
 				/* Time Update control point */
 				GATT_OPT_CHR_UUID16, TIME_UPDATE_CTRL_CHR_UUID,
 				GATT_OPT_CHR_PROPS,
-					ATT_CHAR_PROPER_WRITE_WITHOUT_RESP,
+					GATT_CHR_PROP_WRITE_WITHOUT_RESP,
 				GATT_OPT_CHR_VALUE_CB, ATTRIB_WRITE,
 						time_update_control, adapter,
 
 				/* Time Update status */
 				GATT_OPT_CHR_UUID16, TIME_UPDATE_STAT_CHR_UUID,
-				GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ,
+				GATT_OPT_CHR_PROPS, GATT_CHR_PROP_READ,
 				GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
 						time_update_status, adapter,
 
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 114c8a1..ed843d0 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -1310,7 +1310,7 @@ static gboolean register_core_services(struct gatt_server *server)
 	/* GAP service: device name characteristic */
 	server->name_handle = 0x0006;
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
-	atval[0] = ATT_CHAR_PROPER_READ;
+	atval[0] = GATT_CHR_PROP_READ;
 	put_le16(server->name_handle, &atval[1]);
 	put_le16(GATT_CHARAC_DEVICE_NAME, &atval[3]);
 	attrib_db_add_new(server, 0x0004, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
@@ -1324,7 +1324,7 @@ static gboolean register_core_services(struct gatt_server *server)
 	/* GAP service: device appearance characteristic */
 	server->appearance_handle = 0x0008;
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
-	atval[0] = ATT_CHAR_PROPER_READ;
+	atval[0] = GATT_CHR_PROP_READ;
 	put_le16(server->appearance_handle, &atval[1]);
 	put_le16(GATT_CHARAC_APPEARANCE, &atval[3]);
 	attrib_db_add_new(server, 0x0007, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
-- 
1.8.3.1

