Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 12/20] cyclingspeed: Add support for Request Supported Sensor Locations
Date: Mon, 5 Nov 2012 09:54:57 +0100
Message-ID: <1352105705-13988-13-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1352105705-13988-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1352105705-13988-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/cyclingspeed/cyclingspeed.c | 61 +++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index ffef6ae..3222a9b 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -101,6 +101,8 @@ struct csc {
 	uint16_t		feature;
 	gboolean		has_location;
 	uint8_t			location;
+	uint8_t			num_locations;
+	uint8_t			*locations;
 
 	struct controlpoint_req	*pending_req;
 };
@@ -250,6 +252,7 @@ static void destroy_csc(gpointer user_data)
 
 	btd_device_unref(csc->dev);
 	g_free(csc->svc_range);
+	g_free(csc->locations);
 	g_free(csc);
 }
 
@@ -274,7 +277,6 @@ static gboolean controlpoint_timeout(gpointer user_data)
 	return FALSE;
 }
 
-__attribute__((unused)) /* TODO: remove once controlpoint ops are implemented */
 static void controlpoint_write_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
@@ -293,6 +295,20 @@ static void controlpoint_write_cb(guint8 status, const guint8 *pdu, guint16 len,
 									req);
 }
 
+static void read_supported_locations(struct csc *csc)
+{
+	struct controlpoint_req *req;
+
+	req = g_new0(struct controlpoint_req, 1);
+	req->csc = csc;
+	req->opcode = REQUEST_SUPPORTED_SENSOR_LOC;
+
+	csc->pending_req = req;
+
+	gatt_write_char(csc->attrib, csc->controlpoint_val_handle, &req->opcode,
+			sizeof(req->opcode), controlpoint_write_cb, req);
+}
+
 static void read_feature_cb(guint8 status, const guint8 *pdu,
 						guint16 len, gpointer user_data)
 {
@@ -317,6 +333,10 @@ static void read_feature_cb(guint8 status, const guint8 *pdu,
 	}
 
 	csc->feature = att_get_u16(value);
+
+	if ((csc->feature & MULTI_SENSOR_LOC_SUPPORT)
+						&& (csc->locations == NULL))
+		read_supported_locations(csc);
 }
 
 static void read_location_cb(guint8 status, const guint8 *pdu,
@@ -550,6 +570,7 @@ static void controlpoint_ind_handler(const uint8_t *pdu, uint16_t len,
 	struct controlpoint_req *req = csc->pending_req;
 	uint8_t opcode;
 	uint8_t req_opcode;
+	uint8_t rsp_code;
 	uint8_t *opdu;
 	uint16_t olen;
 	size_t plen;
@@ -583,7 +604,7 @@ static void controlpoint_ind_handler(const uint8_t *pdu, uint16_t len,
 	}
 
 	req_opcode = *pdu;
-	/* skip response code for now */
+	rsp_code = *(pdu + 1);
 	pdu += 2;
 	len -= 2;
 
@@ -592,7 +613,16 @@ static void controlpoint_ind_handler(const uint8_t *pdu, uint16_t len,
 		goto done;
 	}
 
-	/* TODO: handle response */
+	switch (req->opcode) {
+	case REQUEST_SUPPORTED_SENSOR_LOC:
+		if (rsp_code == RSP_SUCCESS) {
+			csc->num_locations = len;
+			csc->locations = g_memdup(pdu, len);
+		} else {
+			error("Failed to read Supported Sendor Locations");
+		}
+		break;
+	}
 
 	csc->pending_req = NULL;
 	g_source_remove(req->timeout);
@@ -866,6 +896,29 @@ static gboolean property_exists_location(const GDBusPropertyTable *property,
 	return csc->has_location;
 }
 
+static gboolean property_get_locations(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct csc *csc = data;
+	DBusMessageIter entry;
+	int i;
+
+	if (!(csc->feature & MULTI_SENSOR_LOC_SUPPORT))
+		return FALSE;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_STRING_AS_STRING, &entry);
+	for (i = 0; i < csc->num_locations; i++) {
+		char *loc = g_strdup(location2str(csc->locations[i]));
+		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &loc);
+		g_free(loc);
+	}
+
+	dbus_message_iter_close_container(iter, &entry);
+
+	return TRUE;
+}
+
 static gboolean property_exists_locations(const GDBusPropertyTable *property,
 								void *data)
 {
@@ -901,7 +954,7 @@ static gboolean property_get_multi_loc_sup(const GDBusPropertyTable *property,
 static const GDBusPropertyTable cyclingspeed_device_properties[] = {
 	{ "Location", "s", property_get_location, NULL,
 						property_exists_location },
-	{ "SupportedLocations", "as", NULL, NULL,
+	{ "SupportedLocations", "as", property_get_locations, NULL,
 						property_exists_locations },
 	{ "WheelRevolutionDataSupported", "b", property_get_wheel_rev_sup },
 	{ "MultipleLocationsSupported", "b", property_get_multi_loc_sup },
-- 
1.8.0

