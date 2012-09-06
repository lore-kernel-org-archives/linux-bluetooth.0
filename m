Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0] gatt: Exchange MTU needs to be executed first
Date: Thu,  6 Sep 2012 17:37:40 -0300
Message-Id: <1346963860-25094-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to Bluetooth SPEC the ATT Exchange MTU sub-procedure needs to
be execute before any ATT command. This patch moves the Exchange MTU
sub-procedure from GATT plugin to device ATTIO core.
---

*** Apply after "LE General Connection Establishment procedure" patches

 profiles/gatt/gas.c | 34 ------------------------------
 src/device.c        | 60 ++++++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 52 insertions(+), 42 deletions(-)

diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index ddd4e70..2a3a1b3 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -254,46 +254,12 @@ static void gatt_characteristic_cb(GSList *characteristics, guint8 status,
 	gatt_find_info(gas->attrib, start, end, gatt_descriptors_cb, gas);
 }
 
-static void exchange_mtu_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
-{
-	struct gas *gas = user_data;
-	uint16_t rmtu;
-
-	if (status) {
-		error("MTU exchange: %s", att_ecode2str(status));
-		return;
-	}
-
-	if (!dec_mtu_resp(pdu, plen, &rmtu)) {
-		error("MTU exchange: protocol error");
-		return;
-	}
-
-	gas->mtu = MIN(rmtu, gas->mtu);
-	if (g_attrib_set_mtu(gas->attrib, gas->mtu))
-		DBG("MTU exchange succeeded: %d", gas->mtu);
-	else
-		DBG("MTU exchange failed");
-}
-
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 {
 	struct gas *gas = user_data;
-	GIOChannel *io;
-	GError *gerr = NULL;
-	uint16_t cid, imtu;
 	uint16_t app;
 
 	gas->attrib = g_attrib_ref(attrib);
-	io = g_attrib_get_channel(attrib);
-
-	if (bt_io_get(io, &gerr, BT_IO_OPT_IMTU, &imtu,
-				BT_IO_OPT_CID, &cid, BT_IO_OPT_INVALID)) {
-		gatt_exchange_mtu(gas->attrib, imtu, exchange_mtu_cb, gas);
-		gas->mtu = imtu;
-		DBG("MTU Exchange: Requesting %d", imtu);
-	}
 
 	gas->changed_ind = g_attrib_register(gas->attrib, ATT_OP_HANDLE_IND,
 						indication_cb, gas, NULL);
diff --git a/src/device.c b/src/device.c
index 81cd3b1..26ab891 100644
--- a/src/device.c
+++ b/src/device.c
@@ -167,6 +167,7 @@ struct btd_device {
 
 	GIOChannel      *att_io;
 	guint		cleanup_id;
+	uint16_t	att_mtu;
 };
 
 static GSList *profiles = NULL;
@@ -1962,7 +1963,8 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 		if (attcb->error)
 			attcb->error(gerr, user_data);
 
-		goto done;
+		g_free(attcb);
+		return;
 	}
 
 	attrib = g_attrib_new(io);
@@ -1990,9 +1992,6 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 			bonding_request_free(device->bonding);
 		}
 	}
-
-done:
-	g_free(attcb);
 }
 
 static void att_error_cb(const GError *gerr, gpointer user_data)
@@ -2010,15 +2009,60 @@ static void att_error_cb(const GError *gerr, gpointer user_data)
 	DBG("Enabling automatic connections");
 }
 
-static void att_success_cb(gpointer user_data)
+static void exchange_mtu_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
 {
 	struct att_callbacks *attcb = user_data;
 	struct btd_device *device = attcb->user_data;
+	uint16_t rmtu;
 
-	if (device->attios == NULL)
-		return;
+	if (status) {
+		error("MTU exchange: %s", att_ecode2str(status));
+		goto done;
+	}
+
+	if (!dec_mtu_resp(pdu, plen, &rmtu)) {
+		error("MTU exchange: protocol error");
+		goto done;
+	}
+
+	device->att_mtu = MIN(rmtu, device->att_mtu);
+	if (g_attrib_set_mtu(device->attrib, device->att_mtu))
+		DBG("MTU exchange succeeded: %d", device->att_mtu);
+	else
+		DBG("MTU exchange failed");
 
 	g_slist_foreach(device->attios, attio_connected, device->attrib);
+
+done:
+	g_free(attcb);
+}
+
+static void exchange_mtu(gpointer user_data)
+{
+	struct att_callbacks *attcb = user_data;
+	struct btd_device *device = attcb->user_data;
+	GIOChannel *io;
+	uint16_t cid, imtu;
+
+	if (device->attios == NULL) {
+		g_free(attcb);
+		return;
+	}
+
+	/* Starting ATT MTU Exchange */
+	io = g_attrib_get_channel(device->attrib);
+	if (bt_io_get(io, NULL, BT_IO_OPT_IMTU, &imtu,
+			BT_IO_OPT_CID, &cid, BT_IO_OPT_INVALID)) {
+		gatt_exchange_mtu(device->attrib, imtu, exchange_mtu_cb,
+								attcb);
+		device->att_mtu = imtu;
+		DBG("MTU Exchange: Requesting %d", imtu);
+	} else {
+		g_slist_foreach(device->attios, attio_connected,
+							device->attrib);
+		g_free(attcb);
+	}
 }
 
 GIOChannel *device_att_connect(gpointer user_data)
@@ -2038,7 +2082,7 @@ GIOChannel *device_att_connect(gpointer user_data)
 
 	attcb = g_new0(struct att_callbacks, 1);
 	attcb->error = att_error_cb;
-	attcb->success = att_success_cb;
+	attcb->success = exchange_mtu;
 	attcb->user_data = device;
 
 	if (device_is_bredr(device)) {
-- 
1.7.12

