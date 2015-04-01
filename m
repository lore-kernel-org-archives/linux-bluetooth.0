Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH 07/28] android/hog: Use bt_gatt_client to write without response
Date: Wed,  1 Apr 2015 18:40:23 +0200
Message-Id: <1427906444-11769-8-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com>
References: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch replaces gatt_write_cmd with
bt_gatt_client_write_without_response.
---
 android/hog.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/android/hog.c b/android/hog.c
index 3f28ecb..bcda1af 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -449,8 +449,9 @@ static void forward_report(struct uhid_event *ev, void *user_data)
 		gatt_write_char(hog->attrib, report->decl->value_handle,
 				data, size, output_written_cb, hog);
 	else if (report->decl->properties & GATT_CHR_PROP_WRITE_WITHOUT_RESP)
-		gatt_write_cmd(hog->attrib, report->decl->value_handle,
-						data, size, NULL, NULL);
+		bt_gatt_client_write_without_response(hog->client,
+						report->decl->value_handle,
+						false, data, size);
 }
 
 static void get_feature(struct uhid_event *ev, void *user_data)
@@ -816,8 +817,9 @@ static void proto_mode_read_cb(bool success, uint8_t att_ecode,
 
 		DBG("HoG is operating in Boot Procotol Mode");
 
-		gatt_write_cmd(hog->attrib, hog->proto_mode_handle, &nval,
-						sizeof(nval), NULL, NULL);
+		bt_gatt_client_write_without_response(hog->client,
+						hog->proto_mode_handle, false,
+						&nval, sizeof(nval));
 	} else if (value[0] == HOG_PROTO_MODE_REPORT)
 		DBG("HoG is operating in Report Protocol Mode");
 }
@@ -1207,14 +1209,14 @@ int bt_hog_set_control_point(struct bt_hog *hog, bool suspend)
 {
 	uint8_t value = suspend ? 0x00 : 0x01;
 
-	if (hog->attrib == NULL)
+	if (hog->client == NULL)
 		return -ENOTCONN;
 
 	if (hog->ctrlpt_handle == 0)
 		return -ENOTSUP;
 
-	gatt_write_cmd(hog->attrib, hog->ctrlpt_handle, &value,
-					sizeof(value), NULL, NULL);
+	bt_gatt_client_write_without_response(hog->client, hog->ctrlpt_handle,
+						false, &value, sizeof(value));
 
 	return 0;
 }
@@ -1227,7 +1229,7 @@ int bt_hog_send_report(struct bt_hog *hog, void *data, size_t size, int type)
 	if (!hog)
 		return -EINVAL;
 
-	if (!hog->attrib)
+	if (!hog->client)
 		return -ENOTCONN;
 
 	report = find_report(hog, type, 0);
@@ -1241,8 +1243,9 @@ int bt_hog_send_report(struct bt_hog *hog, void *data, size_t size, int type)
 				data, size, output_written_cb, hog);
 
 	if (report->decl->properties & GATT_CHR_PROP_WRITE_WITHOUT_RESP)
-		gatt_write_cmd(hog->attrib, report->decl->value_handle,
-						data, size, NULL, NULL);
+		bt_gatt_client_write_without_response(hog->client,
+						report->decl->value_handle,
+						false, data, size);
 
 	for (l = hog->instances; l; l = l->next) {
 		struct bt_hog *instance = l->data;
-- 
1.9.1

