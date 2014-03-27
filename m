Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 04/11] android/gatt: Add initial implementation of get_included_service
Date: Thu, 27 Mar 2014 22:13:02 +0100
Message-Id: <1395954789-32459-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1395954789-32459-1-git-send-email-marcin.kraglak@tieto.com>
References: <1395954789-32459-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will look for included service in range passed in command.
It call gatt_find_included(), but without result callback now,
as it is initial version.
---
 android/gatt.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 2e93ef7..bf40162 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -955,13 +955,70 @@ reply:
 			HAL_OP_GATT_CLIENT_SEARCH_SERVICE, status);
 }
 
+static bool match_service_by_uuid(const void *data, const void *user_data)
+{
+	const struct service *service = data;
+	const bt_uuid_t *uuid = user_data;
+	bt_uuid_t service_uuid;
+
+	if (bt_string_to_uuid(&service_uuid, service->primary.uuid) < 0)
+		return false;
+
+	return !bt_uuid_cmp(uuid, &service_uuid);
+}
+
+static struct service *find_service_bu_uuid(struct gatt_device *device,
+								bt_uuid_t *uuid)
+{
+	return queue_find(device->services, match_service_by_uuid, uuid);
+}
+
 static void handle_client_get_included_service(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_client_get_included_service *cmd = buf;
+	struct gatt_device *device;
+	struct service *service;
+	uint8_t status;
+
 	DBG("");
 
+	device = find_device_by_conn_id(cmd->conn_id);
+	if (!device) {
+		error("gatt: device with conn_id %d not found", cmd->conn_id);
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	if (queue_isempty(device->services)) {
+		error("gatt: Search primary services first");
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	if (!cmd->number) {
+		service = queue_peek_head(device->services);
+	} else {
+		bt_uuid_t uuid;
+
+		android2uuid(cmd->srvc_id->uuid, &uuid);
+		service = find_service_bu_uuid(device, &uuid);
+	}
+
+	if (!service) {
+		error("gatt: service not found");
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	gatt_find_included(device->attrib, service->primary.range.start,
+					service->primary.range.end, NULL, NULL);
+
+	status = HAL_STATUS_SUCCESS;
+
+failed:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 					HAL_OP_GATT_CLIENT_GET_INCLUDED_SERVICE,
-					HAL_STATUS_FAILED);
+					status);
 }
 
 static void send_client_char_notify(const struct characteristic *ch,
-- 
1.8.3.1

