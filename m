Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv5 2/3] android/gatt: Make att_handler use g_attrib buffer
Date: Mon, 26 May 2014 09:13:15 +0200
Message-Id: <1401088396-2074-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1401088396-2074-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1401088396-2074-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes use of g_attrib buffer for output and removes some unused
read_by_group_type function parameters.
---
 android/gatt.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 2ae3669..5da6ffa 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4402,8 +4402,6 @@ static const struct ipc_handler cmd_handlers[] = {
 };
 
 static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
-						uint8_t *rsp, size_t rsp_size,
-						uint16_t *length,
 						struct gatt_device *device)
 {
 	uint16_t start, end;
@@ -4802,24 +4800,22 @@ static uint8_t write_prep_request(const uint8_t *cmd, uint16_t cmd_len,
 static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
 {
 	struct gatt_device *dev = user_data;
-	uint8_t opdu[ATT_DEFAULT_LE_MTU];
 	uint8_t status;
-	uint16_t length = 0;
-	size_t vlen;
-	uint8_t *value = g_attrib_get_buffer(dev->attrib, &vlen);
+	uint16_t resp_length = 0;
+	size_t length;
+	uint8_t *opdu = g_attrib_get_buffer(dev->attrib, &length);
 
 	DBG("op 0x%02x", ipdu[0]);
 
-	if (len > vlen) {
-		error("gatt: Too much data on ATT socket %p", value);
+	if (len > length) {
+		error("gatt: Too much data on ATT socket %p", opdu);
 		status = ATT_ECODE_INVALID_PDU;
 		goto done;
 	}
 
 	switch (ipdu[0]) {
 	case ATT_OP_READ_BY_GROUP_REQ:
-		status = read_by_group_type(ipdu, len, opdu, sizeof(opdu),
-								&length, dev);
+		status = read_by_group_type(ipdu, len, dev);
 		break;
 	case ATT_OP_READ_BY_TYPE_REQ:
 		status = read_by_type(ipdu, len, dev);
@@ -4829,12 +4825,12 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
 		status = read_request(ipdu, len, dev);
 		break;
 	case ATT_OP_MTU_REQ:
-		status = mtu_att_handle(ipdu, len, opdu, sizeof(opdu), dev,
-								&length);
+		status = mtu_att_handle(ipdu, len, opdu, length, dev,
+								&resp_length);
 		break;
 	case ATT_OP_FIND_INFO_REQ:
-		status = find_info_handle(ipdu, len, opdu, sizeof(opdu),
-								&length);
+		status = find_info_handle(ipdu, len, opdu, length,
+								&resp_length);
 		break;
 	case ATT_OP_WRITE_REQ:
 		status = write_req_request(ipdu, len, dev);
@@ -4877,11 +4873,12 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
 
 done:
 	if (status)
-		length = enc_error_resp(ipdu[0], 0x0000, status, opdu,
-							ATT_DEFAULT_LE_MTU);
+		resp_length = enc_error_resp(ipdu[0], 0x0000, status, opdu,
+									length);
 
-	if (length)
-		g_attrib_send(dev->attrib, 0, opdu, length, NULL, NULL, NULL);
+	if (resp_length)
+		g_attrib_send(dev->attrib, 0, opdu, resp_length, NULL, NULL,
+									NULL);
 }
 
 static void create_listen_connections(void *data, void *user_data)
-- 
1.9.3

