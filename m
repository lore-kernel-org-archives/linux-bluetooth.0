Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 05/10] gatt: Start Discover Services when handle changes
Date: Mon, 20 Aug 2012 14:22:50 -0300
Message-Id: <1345483375-27621-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345483375-27621-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345483375-27621-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch starts the Discover All Primary services when a Service
Changed indication is received or the Service Changed characteristic
value is read.
---
 profiles/gatt/gas.c |   18 ++++++++++++++++++
 src/device.c        |    8 --------
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index 4bf8090..3e3c3db 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -41,6 +41,7 @@ struct gas {
 	struct btd_device *device;
 	struct att_range gap;	/* GAP Primary service range */
 	struct att_range gatt;	/* GATT Primary service range */
+	struct att_range changed; /* Affected handle range */
 	GAttrib *attrib;
 	guint attioid;
 	guint changed_ind;
@@ -146,11 +147,20 @@ static void indication_cb(const uint8_t *pdu, uint16_t len, gpointer user_data)
 	opdu = g_attrib_get_buffer(gas->attrib, &plen);
 	olen = enc_confirmation(opdu, plen);
 	g_attrib_send(gas->attrib, 0, opdu[0], opdu, olen, NULL, NULL, NULL);
+
+	if (gas->changed.start == start && gas->changed.end == end)
+		return;
+
+	gas->changed.start = start;
+	gas->changed.end = end;
+
+	device_browse_primary(gas->device, NULL, NULL, FALSE);
 }
 
 static void gatt_service_changed_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
+	struct gas *gas = user_data;
 	uint16_t start, end;
 
 	if (status) {
@@ -167,7 +177,15 @@ static void gatt_service_changed_cb(guint8 status, const guint8 *pdu,
 	start = att_get_u16(&pdu[1]);
 	end = att_get_u16(&pdu[3]);
 
+	if (gas->changed.start == start && gas->changed.end == end)
+		return;
+
+	gas->changed.start = start;
+	gas->changed.end = end;
+
 	DBG("GATT Service Changed start: 0x%04X end: 0x%04X", start, end);
+
+	device_browse_primary(gas->device, NULL, NULL, FALSE);
 }
 
 static void gatt_descriptors_cb(guint8 status, const guint8 *pdu, guint16 len,
diff --git a/src/device.c b/src/device.c
index f6161aa..5fee11e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2022,14 +2022,6 @@ int device_browse_primary(struct btd_device *device, DBusConnection *conn,
 	if (device->browse)
 		return -EBUSY;
 
-	/* FIXME: GATT service updates (implemented in update_services() for
-	 * SDP) are not supported yet. It will be supported once client side
-	 * "Services Changed" characteristic handling is implemented. */
-	if (device->primaries) {
-		error("Could not update GATT services");
-		return -ENOSYS;
-	}
-
 	req = g_new0(struct browse_req, 1);
 	req->device = btd_device_ref(device);
 	adapter_get_address(adapter, &src);
-- 
1.7.8.6

