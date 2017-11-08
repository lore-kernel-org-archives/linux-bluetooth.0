Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH v2 1/2] core/device: Add support for setting SDP record
Date: Wed,  8 Nov 2017 20:38:27 +0100
Message-Id: <20171108193828.5471-1-hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@codecoup.pl>

This allows to set SDP record for device without resolving services
over SDP. After SDP is provided profiles are probed.
---
 src/device.c | 33 +++++++++++++++++++++++++++++++++
 src/device.h |  3 +++
 2 files changed, 36 insertions(+)

diff --git a/src/device.c b/src/device.c
index c12407a73..e8118112e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -6073,6 +6073,39 @@ static sdp_list_t *read_device_records(struct btd_device *device)
 	return recs;
 }
 
+void btd_device_set_record(struct btd_device *device, const char *uuid,
+							const char *record)
+{
+	/* This API is only used for BR/EDR */
+	struct bearer_state *state = &device->bredr_state;
+	struct browse_req *req;
+	sdp_list_t *recs = NULL;
+	sdp_record_t *rec;
+
+	if (!record)
+		return;
+
+	req = browse_request_new(device, BROWSE_SDP, NULL);
+	if (!req)
+		return;
+
+	rec = record_from_string(record);
+	recs = sdp_list_append(recs, rec);
+	update_bredr_services(req, recs);
+	sdp_list_free(recs, NULL);
+
+	device->svc_refreshed = true;
+	state->svc_resolved = true;
+
+	device_probe_profiles(device, req->profiles_added);
+
+	/* Propagate services changes */
+	g_dbus_emit_property_changed(dbus_conn, req->device->path,
+						DEVICE_INTERFACE, "UUIDs");
+
+	device_svc_resolved(device, BROWSE_SDP, device->bdaddr_type, 0);
+}
+
 const sdp_record_t *btd_device_get_record(struct btd_device *device,
 							const char *uuid)
 {
diff --git a/src/device.h b/src/device.h
index 850561729..32f8edce5 100644
--- a/src/device.h
+++ b/src/device.h
@@ -62,6 +62,9 @@ struct device_addr_type {
 int device_addr_type_cmp(gconstpointer a, gconstpointer b);
 GSList *btd_device_get_uuids(struct btd_device *device);
 void device_probe_profiles(struct btd_device *device, GSList *profiles);
+
+void btd_device_set_record(struct btd_device *device, const char *uuid,
+							const char *record);
 const sdp_record_t *btd_device_get_record(struct btd_device *device,
 						const char *uuid);
 struct gatt_primary *btd_device_get_primary(struct btd_device *device,
-- 
2.14.3

