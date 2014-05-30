Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] android/gatt: Check for invalid handle errors
Date: Fri, 30 May 2014 07:51:14 +0200
Message-Id: <1401429074-31535-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1401429074-31535-1-git-send-email-marcin.kraglak@tieto.com>
References: <1401429074-31535-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Check if handle or range is valid for server.
---
 android/gatt.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 48a32ec..8ccbad9 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4753,6 +4753,9 @@ static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
 	if (!len)
 		return ATT_ECODE_INVALID_PDU;
 
+	if (start > end || start == 0)
+		return ATT_ECODE_INVALID_HANDLE;
+
 	q = queue_new();
 	if (!q)
 		return ATT_ECODE_INSUFF_RESOURCES;
@@ -4806,7 +4809,7 @@ static uint8_t read_by_type(const uint8_t *cmd, uint16_t cmd_len,
 	if (!len)
 		return ATT_ECODE_INVALID_PDU;
 
-	if (start > end)
+	if (start > end || start == 0)
 		return ATT_ECODE_INVALID_HANDLE;
 
 	q = queue_new();
@@ -4869,6 +4872,9 @@ static uint8_t read_request(const uint8_t *cmd, uint16_t cmd_len,
 		return ATT_ECODE_REQ_NOT_SUPP;
 	}
 
+	if (handle == 0)
+		return ATT_ECODE_INVALID_HANDLE;
+
 	data = new0(struct pending_request, 1);
 	if (!data)
 		return ATT_ECODE_INSUFF_RESOURCES;
@@ -4948,6 +4954,9 @@ static uint8_t find_info_handle(const uint8_t *cmd, uint16_t cmd_len,
 	if (!len)
 		return ATT_ECODE_INVALID_PDU;
 
+	if (start > end || start == 0)
+		return ATT_ECODE_INVALID_HANDLE;
+
 	q = queue_new();
 	if (!q)
 		return ATT_ECODE_UNLIKELY;
@@ -5017,6 +5026,9 @@ static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
 	if (!len)
 		return ATT_ECODE_INVALID_PDU;
 
+	if (start > end || start == 0)
+		return ATT_ECODE_INVALID_HANDLE;
+
 	q = queue_new();
 	if (!q)
 		return ATT_ECODE_UNLIKELY;
@@ -5070,6 +5082,9 @@ static void write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 	if (!len)
 		return;
 
+	if (handle == 0)
+		return;
+
 	if (!gatt_db_has_attribute(gatt_db, handle))
 		return;
 
@@ -5099,6 +5114,9 @@ static void write_signed_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 
 	len = dec_signed_write_cmd(cmd, cmd_len, &handle, value, &vlen, s);
 
+	if (handle == 0)
+		return;
+
 	if (!gatt_db_has_attribute(gatt_db, handle))
 		return;
 
@@ -5142,6 +5160,9 @@ static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,
 	if (!len)
 		return ATT_ECODE_INVALID_PDU;
 
+	if (handle == 0)
+		return ATT_ECODE_INVALID_HANDLE;
+
 	if (!gatt_db_has_attribute(gatt_db, handle))
 		return ATT_ECODE_ATTR_NOT_FOUND;
 
@@ -5193,6 +5214,9 @@ static uint8_t write_prep_request(const uint8_t *cmd, uint16_t cmd_len,
 	if (!len)
 		return ATT_ECODE_INVALID_PDU;
 
+	if (handle == 0)
+		return ATT_ECODE_INVALID_HANDLE;
+
 	if (!gatt_db_has_attribute(gatt_db, handle))
 		return ATT_ECODE_ATTR_NOT_FOUND;
 
-- 
1.9.0

