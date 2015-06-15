Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Veseli Veseljko <veseljko75@gmail.com>, Alex Gal <a.gal@miip.ca>,
	Laurence Brown <linux-bluetooth@protazoa.com>,
	Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 2/5] core/device: Add support for setting SDP record
Date: Mon, 15 Jun 2015 20:28:27 +0200
Message-Id: <1434392910-31648-3-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1434392910-31648-1-git-send-email-szymon.janc@gmail.com>
References: <1434392910-31648-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to set SDP record for device without resolving services
over SDP. After SDP is provided profiles are probed.
---
 src/device.c | 31 +++++++++++++++++++++++++++++++
 src/device.h |  3 +++
 2 files changed, 34 insertions(+)

diff --git a/src/device.c b/src/device.c
index 3ef0340..859aa3c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5542,6 +5542,37 @@ static sdp_list_t *read_device_records(struct btd_device *device)
 	return recs;
 }
 
+void btd_device_set_record(struct btd_device *device, const char *uuid,
+							sdp_record_t *rec)
+{
+	/* This API is only used for BR/EDR */
+	struct bearer_state *state = &device->bredr_state;
+	struct browse_req *req;
+	sdp_list_t *recs = NULL;
+
+	if (!rec)
+		return;
+
+	req = browse_request_new(device, NULL);
+	if (!req)
+		return;
+
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
+	device_svc_resolved(device, device->bdaddr_type, 0);
+}
+
 const sdp_record_t *btd_device_get_record(struct btd_device *device,
 							const char *uuid)
 {
diff --git a/src/device.h b/src/device.h
index 1955f54..aee677a 100644
--- a/src/device.h
+++ b/src/device.h
@@ -62,6 +62,9 @@ struct device_addr_type {
 int device_addr_type_cmp(gconstpointer a, gconstpointer b);
 GSList *btd_device_get_uuids(struct btd_device *device);
 void device_probe_profiles(struct btd_device *device, GSList *profiles);
+
+void btd_device_set_record(struct btd_device *device, const char *uuid,
+							sdp_record_t *rec);
 const sdp_record_t *btd_device_get_record(struct btd_device *device,
 						const char *uuid);
 struct gatt_primary *btd_device_get_primary(struct btd_device *device,
-- 
2.1.4

