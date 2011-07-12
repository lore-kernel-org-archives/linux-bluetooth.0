Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 01/11] Remove not necessary data from gatt_service
Date: Tue, 12 Jul 2011 17:28:31 -0300
Message-Id: <1310502521-462-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1310502521-462-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1310502521-462-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bluetooth source and destination address can be obtained from the
device object. GATT service doesn't need to keep these addresses.
---
 attrib/client.c |   47 ++++++++++++++++++++++++++++++-----------------
 1 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 1ef2699..0d828c0 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -56,8 +56,6 @@
 struct gatt_service {
 	struct btd_device *dev;
 	DBusConnection *conn;
-	bdaddr_t sba;
-	bdaddr_t dba;
 	char *path;
 	GSList *primary;
 	GAttrib *attrib;
@@ -160,6 +158,17 @@ static void gatt_service_free(void *user_data)
 	g_free(gatt);
 }
 
+static void gatt_get_address(struct gatt_service *gatt,
+				bdaddr_t *sba, bdaddr_t *dba)
+{
+	struct btd_device *device = gatt->dev;
+	struct btd_adapter *adapter;
+
+	adapter = device_get_adapter(device);
+	adapter_get_address(adapter, sba);
+	device_get_address(device, dba);
+}
+
 static int gatt_dev_cmp(gconstpointer a, gconstpointer b)
 {
 	const struct gatt_service *gatt = a;
@@ -368,6 +377,7 @@ fail:
 static int l2cap_connect(struct gatt_service *gatt, GError **gerr,
 								gboolean listen)
 {
+	bdaddr_t sba, dba;
 	GIOChannel *io;
 
 	if (gatt->attrib != NULL) {
@@ -381,17 +391,18 @@ static int l2cap_connect(struct gatt_service *gatt, GError **gerr,
 	 * Configuration it is necessary to poll the server from time
 	 * to time checking for modifications.
 	 */
+	gatt_get_address(gatt, &sba, &dba);
 	if (gatt->psm < 0)
 		io = bt_io_connect(BT_IO_L2CAP, connect_cb, gatt, NULL, gerr,
-			BT_IO_OPT_SOURCE_BDADDR, &gatt->sba,
-			BT_IO_OPT_DEST_BDADDR, &gatt->dba,
+			BT_IO_OPT_SOURCE_BDADDR, &sba,
+			BT_IO_OPT_DEST_BDADDR, &dba,
 			BT_IO_OPT_CID, ATT_CID,
 			BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 			BT_IO_OPT_INVALID);
 	else
 		io = bt_io_connect(BT_IO_L2CAP, connect_cb, gatt, NULL, gerr,
-			BT_IO_OPT_SOURCE_BDADDR, &gatt->sba,
-			BT_IO_OPT_DEST_BDADDR, &gatt->dba,
+			BT_IO_OPT_SOURCE_BDADDR, &sba,
+			BT_IO_OPT_DEST_BDADDR, &dba,
 			BT_IO_OPT_PSM, gatt->psm,
 			BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 			BT_IO_OPT_INVALID);
@@ -579,11 +590,13 @@ static void store_characteristics(struct gatt_service *gatt,
 {
 	char *characteristics;
 	struct att_primary *att = prim->att;
+	bdaddr_t sba, dba;
 
 	characteristics = characteristic_list_to_string(prim->chars);
 
-	write_device_characteristics(&gatt->sba, &gatt->dba, att->start,
-							characteristics);
+	gatt_get_address(gatt, &sba, &dba);
+
+	write_device_characteristics(&sba, &dba, att->start, characteristics);
 
 	g_free(characteristics);
 }
@@ -645,6 +658,7 @@ static void load_characteristics(gpointer data, gpointer user_data)
 	struct primary *prim = data;
 	struct att_primary *att = prim->att;
 	struct gatt_service *gatt = user_data;
+	bdaddr_t sba, dba;
 	GSList *chrs_list;
 	char *str;
 
@@ -653,7 +667,9 @@ static void load_characteristics(gpointer data, gpointer user_data)
 		return;
 	}
 
-	str = read_device_characteristics(&gatt->sba, &gatt->dba, att->start);
+	gatt_get_address(gatt, &sba, &dba);
+
+	str = read_device_characteristics(&sba, &dba, att->start);
 	if (str == NULL)
 		return;
 
@@ -673,6 +689,7 @@ static void load_characteristics(gpointer data, gpointer user_data)
 static void store_attribute(struct gatt_service *gatt, uint16_t handle,
 				uint16_t type, uint8_t *value, gsize len)
 {
+	bdaddr_t sba, dba;
 	bt_uuid_t uuid;
 	char *str, *tmp;
 	guint i;
@@ -687,7 +704,10 @@ static void store_attribute(struct gatt_service *gatt, uint16_t handle,
 	for (i = 0, tmp = str + MAX_LEN_UUID_STR; i < len; i++, tmp += 2)
 		sprintf(tmp, "%02X", value[i]);
 
-	write_device_attribute(&gatt->sba, &gatt->dba, handle, str);
+	gatt_get_address(gatt, &sba, &dba);
+
+	write_device_attribute(&sba, &dba, handle, str);
+
 	g_free(str);
 }
 
@@ -1052,21 +1072,14 @@ GSList *attrib_client_register(DBusConnection *connection,
 					struct btd_device *device, int psm,
 					GAttrib *attrib, GSList *primaries)
 {
-	struct btd_adapter *adapter = device_get_adapter(device);
 	const char *path = device_get_path(device);
 	struct gatt_service *gatt;
-	bdaddr_t sba, dba;
-
-	adapter_get_address(adapter, &sba);
-	device_get_address(device, &dba);
 
 	gatt = g_new0(struct gatt_service, 1);
 	gatt->dev = btd_device_ref(device);
 	gatt->conn = dbus_connection_ref(connection);
 	gatt->listen = FALSE;
 	gatt->path = g_strdup(path);
-	bacpy(&gatt->sba, &sba);
-	bacpy(&gatt->dba, &dba);
 	gatt->psm = psm;
 
 	if (attrib)
-- 
1.7.6

