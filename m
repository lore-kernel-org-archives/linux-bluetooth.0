Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 12/14] shared/gatt-db: Fix crash in gatt_db_find_by_type
Date: Wed,  7 Jan 2015 21:48:26 -0800
Message-Id: <1420696108-29699-13-git-send-email-armansito@chromium.org>
In-Reply-To: <1420696108-29699-1-git-send-email-armansito@chromium.org>
References: <1420696108-29699-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fixed a crash due to an invalid access in the find_by_type foreach
callback by correctly initializing the data fields to 0. The crash
happened because the same callback is used for find_by_type and
find_by_type_value and however find_by_type didn't correctly set the
value pointer to NULL.
---
 src/shared/gatt-db.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 9a9cadc..157d859 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -880,6 +880,8 @@ void gatt_db_find_by_type(struct gatt_db *db, uint16_t start_handle,
 {
 	struct find_by_type_value_data data;
 
+	memset(&data, 0, sizeof(data));
+
 	data.uuid = *type;
 	data.start_handle = start_handle;
 	data.end_handle = end_handle;
@@ -899,6 +901,8 @@ void gatt_db_find_by_type_value(struct gatt_db *db, uint16_t start_handle,
 {
 	struct find_by_type_value_data data;
 
+	memset(&data, 0, sizeof(data));
+
 	data.uuid = *type;
 	data.start_handle = start_handle;
 	data.end_handle = end_handle;
-- 
2.2.0.rc0.207.ga3a616c

