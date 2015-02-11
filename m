Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 10/10] android/gatt: Avoid copying pointers in matching functions
Date: Wed, 11 Feb 2015 15:34:08 +0100
Message-Id: <1423665248-5121-10-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1423665248-5121-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1423665248-5121-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This removes casting void* to struct pointers when there is no need to
do so (pointer comparison).
---
 android/gatt.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index cd0825a..3076a02 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -350,9 +350,8 @@ static struct gatt_app *find_app_by_id(int32_t id)
 static bool match_device_by_bdaddr(const void *data, const void *user_data)
 {
 	const struct gatt_device *dev = data;
-	const bdaddr_t *addr = user_data;
 
-	return !bacmp(&dev->bdaddr, addr);
+	return !bacmp(&dev->bdaddr, user_data);
 }
 
 static bool match_device_by_state(const void *data, const void *user_data)
@@ -408,17 +407,15 @@ static struct app_connection *find_connection_by_id(int32_t conn_id)
 static bool match_connection_by_device(const void *data, const void *user_data)
 {
 	const struct app_connection *conn = data;
-	const struct gatt_device *dev = user_data;
 
-	return conn->device == dev;
+	return conn->device == user_data;
 }
 
 static bool match_connection_by_app(const void *data, const void *user_data)
 {
 	const struct app_connection *conn = data;
-	const struct gatt_app *app = user_data;
 
-	return conn->app == app;
+	return conn->app == user_data;
 }
 
 static struct gatt_device *find_device_by_addr(const bdaddr_t *addr)
@@ -469,9 +466,8 @@ static bool match_srvc_by_bt_uuid(const void *data, const void *user_data)
 static bool match_srvc_by_range(const void *data, const void *user_data)
 {
 	const struct service *srvc = data;
-	const struct att_range *range = user_data;
 
-	return !memcmp(&srvc->prim.range, range, sizeof(srvc->prim.range));
+	return !memcmp(&srvc->prim.range, user_data, sizeof(srvc->prim.range));
 }
 
 static bool match_char_by_higher_inst_id(const void *data,
-- 
1.9.1

