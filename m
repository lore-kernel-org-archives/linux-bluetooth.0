Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 3/3] android/gatt: Check for invalid handle errors
Date: Fri, 30 May 2014 11:37:42 +0200
Message-Id: <1401442662-11475-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1401442662-11475-1-git-send-email-marcin.kraglak@tieto.com>
References: <1401442662-11475-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Check if handle or handle range is valid for server. If is invalid,
reply with ATT_ECODE_INVALID_HANDLE.
---
 android/gatt.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 421cae4..ee14968 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4755,6 +4755,9 @@ static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
 	if (!len)
 		return ATT_ECODE_INVALID_PDU;
 
+	if (start > end || start == 0)
+		return ATT_ECODE_INVALID_HANDLE;
+
 	q = queue_new();
 	if (!q)
 		return ATT_ECODE_INSUFF_RESOURCES;
@@ -4808,7 +4811,7 @@ static uint8_t read_by_type(const uint8_t *cmd, uint16_t cmd_len,
 	if (!len)
 		return ATT_ECODE_INVALID_PDU;
 
-	if (start > end)
+	if (start > end || start == 0)
 		return ATT_ECODE_INVALID_HANDLE;
 
 	q = queue_new();
@@ -4871,6 +4874,9 @@ static uint8_t read_request(const uint8_t *cmd, uint16_t cmd_len,
 		return ATT_ECODE_REQ_NOT_SUPP;
 	}
 
+	if (handle == 0)
+		return ATT_ECODE_INVALID_HANDLE;
+
 	data = new0(struct pending_request, 1);
 	if (!data)
 		return ATT_ECODE_INSUFF_RESOURCES;
@@ -4950,6 +4956,9 @@ static uint8_t find_info_handle(const uint8_t *cmd, uint16_t cmd_len,
 	if (!len)
 		return ATT_ECODE_INVALID_PDU;
 
+	if (start > end || start == 0)
+		return ATT_ECODE_INVALID_HANDLE;
+
 	q = queue_new();
 	if (!q)
 		return ATT_ECODE_UNLIKELY;
@@ -5019,6 +5028,9 @@ static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
 	if (!len)
 		return ATT_ECODE_INVALID_PDU;
 
+	if (start > end || start == 0)
+		return ATT_ECODE_INVALID_HANDLE;
+
 	q = queue_new();
 	if (!q)
 		return ATT_ECODE_UNLIKELY;
@@ -5072,6 +5084,9 @@ static void write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 	if (!len)
 		return;
 
+	if (handle == 0)
+		return;
+
 	if (!gatt_db_get_attribute_permissions(gatt_db, handle, &permissions))
 		return;
 
@@ -5100,6 +5115,9 @@ static void write_signed_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 
 	len = dec_signed_write_cmd(cmd, cmd_len, &handle, value, &vlen, s);
 
+	if (handle == 0)
+		return;
+
 	if (!gatt_db_get_attribute_permissions(gatt_db, handle, &permissions))
 		return;
 
@@ -5142,6 +5160,9 @@ static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,
 	if (!len)
 		return ATT_ECODE_INVALID_PDU;
 
+	if (handle == 0)
+		return ATT_ECODE_INVALID_HANDLE;
+
 	if (!gatt_db_get_attribute_permissions(gatt_db, handle, &permissions))
 		return ATT_ECODE_ATTR_NOT_FOUND;
 
@@ -5191,6 +5212,9 @@ static uint8_t write_prep_request(const uint8_t *cmd, uint16_t cmd_len,
 	if (!len)
 		return ATT_ECODE_INVALID_PDU;
 
+	if (handle == 0)
+		return ATT_ECODE_INVALID_HANDLE;
+
 	if (!gatt_db_get_attribute_permissions(gatt_db, handle, &permissions))
 		return ATT_ECODE_ATTR_NOT_FOUND;
 
-- 
1.9.0

