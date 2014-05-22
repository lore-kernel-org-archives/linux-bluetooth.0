Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 4/4] android/gatt: Use pending request for write req and prep write
Date: Thu, 22 May 2014 13:17:45 +0200
Message-Id: <1400757465-11522-5-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1400757465-11522-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1400757465-11522-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch add missing pending request for write operations.
Now Android server application can send response to remote device
---
 android/gatt.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 39314a1..26b2300 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4658,6 +4658,7 @@ static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,
 						struct gatt_device *dev)
 {
 	uint8_t value[ATT_DEFAULT_LE_MTU];
+	struct pending_request *data;
 	uint16_t handle;
 	uint16_t len;
 	size_t vlen;
@@ -4666,6 +4667,18 @@ static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,
 	if (!len)
 		return ATT_ECODE_INVALID_PDU;
 
+	data = new0(struct pending_request, 1);
+	if (!data)
+		return ATT_ECODE_INSUFF_RESOURCES;
+
+	data->handle = handle;
+	data->state = REQUEST_INIT;
+
+	if (!queue_push_tail(dev->pending_requests, data)) {
+		free(data);
+		return ATT_ECODE_INSUFF_RESOURCES;
+	}
+
 	if (!gatt_db_write(gatt_db, handle, 0, value, vlen, cmd[0],
 								&dev->bdaddr))
 		return ATT_ECODE_UNLIKELY;
@@ -4677,6 +4690,7 @@ static uint8_t write_prep_request(const uint8_t *cmd, uint16_t cmd_len,
 						struct gatt_device *dev)
 {
 	uint8_t value[ATT_DEFAULT_LE_MTU];
+	struct pending_request *data;
 	uint16_t handle;
 	uint16_t offset;
 	uint16_t len;
@@ -4687,6 +4701,19 @@ static uint8_t write_prep_request(const uint8_t *cmd, uint16_t cmd_len,
 	if (!len)
 		return ATT_ECODE_INVALID_PDU;
 
+	data = new0(struct pending_request, 1);
+	if (!data)
+		return ATT_ECODE_INSUFF_RESOURCES;
+
+	data->handle = handle;
+	data->offset = offset;
+	data->state = REQUEST_INIT;
+
+	if (!queue_push_tail(dev->pending_requests, data)) {
+		free(data);
+		return ATT_ECODE_INSUFF_RESOURCES;
+	}
+
 	if (!gatt_db_write(gatt_db, handle, offset, value, vlen, cmd[0],
 								&dev->bdaddr))
 		return ATT_ECODE_UNLIKELY;
-- 
1.8.4

