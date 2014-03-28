Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 3/8] android/gatt: Add get_included_data struct and callback
Date: Fri, 28 Mar 2014 10:45:54 +0100
Message-Id: <1395999959-2396-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1395999959-2396-1-git-send-email-marcin.kraglak@tieto.com>
References: <1395999959-2396-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Create user data passed to callback get_included_cb.
It will handle included services and pass it to notification.
---
 android/gatt.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index a801525..e2accb7 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -967,9 +967,23 @@ static struct service *find_service_bu_uuid(struct gatt_device *device,
 	return queue_find(device->services, match_service_by_uuid, uuid);
 }
 
+struct get_included_data {
+	struct service *service;
+	struct gatt_device *device;
+};
+
+static void get_included_cb(uint8_t status, GSList *included, void *user_data)
+{
+	struct get_included_data *data = user_data;
+
+	/* TODO pass included services to notification */
+	free(data);
+}
+
 static void handle_client_get_included_service(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_get_included_service *cmd = buf;
+	struct get_included_data *data;
 	struct gatt_device *device;
 	struct service *service;
 	uint8_t status;
@@ -1001,8 +1015,19 @@ static void handle_client_get_included_service(const void *buf, uint16_t len)
 		goto failed;
 	}
 
+	data = new0(struct get_included_data, 1);
+	if (!data) {
+		error("gatt: failed to allocate memory for included_data");
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	data->service = service;
+	data->device = device;
+
 	gatt_find_included(device->attrib, service->primary.range.start,
-					service->primary.range.end, NULL, NULL);
+				service->primary.range.end, get_included_cb,
+				data);
 
 	status = HAL_STATUS_SUCCESS;
 
-- 
1.8.3.1

