Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Veseli Veseljko <veseljko75@gmail.com>,
	Szymon Janc <szymon.janc@gmail.com>
Subject: [RFC 1/2] core/device: Add support for setting SDP record
Date: Sun,  8 Mar 2015 17:08:29 +0100
Message-Id: <1425830910-9549-2-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1425830910-9549-1-git-send-email-szymon.janc@gmail.com>
References: <1425830910-9549-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to set SDP record for device without resolving services
over SDP.
---
 src/device.c | 37 +++++++++++++++++++++++++++++++++++++
 src/device.h |  3 +++
 2 files changed, 40 insertions(+)

diff --git a/src/device.c b/src/device.c
index 9e23c19..6e896ba 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5272,6 +5272,43 @@ static sdp_list_t *read_device_records(struct btd_device *device)
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
+	if (device->tmp_records) {
+		if (find_record_in_list(device->tmp_records, uuid))
+			return;
+
+		sdp_list_free(device->tmp_records,
+					(sdp_free_func_t) sdp_record_free);
+	}
+
+	device->tmp_records = sdp_list_append(NULL, rec);
+
+	device->svc_refreshed = true;
+	state->svc_resolved = true;
+
+	btd_device_add_uuid(device, uuid);
+
+	device_svc_resolved(device, device->bdaddr_type, 0);
+}
+
 const sdp_record_t *btd_device_get_record(struct btd_device *device,
 							const char *uuid)
 {
diff --git a/src/device.h b/src/device.h
index 8edd0df..f42b3f4 100644
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

