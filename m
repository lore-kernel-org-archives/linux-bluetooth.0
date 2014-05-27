Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 6/6] android/gatt: Exchange mtu on connect if acting as client
Date: Tue, 27 May 2014 12:15:34 +0200
Message-Id: <1401185734-23672-6-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1401185734-23672-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1401185734-23672-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When no client apps are registered we basically act as server only and
mtu exchange request handling is enough. When acting as client we send
request.
---
 android/gatt.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index a8f072f..b120834 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -320,11 +320,24 @@ static bool match_app_by_id(const void *data, const void *user_data)
 	return client->id == exp_id;
 }
 
+static bool match_app_by_type(const void *data, const void *user_data)
+{
+	gatt_app_type_t app_type = PTR_TO_INT(user_data);
+	const struct gatt_app *app = data;
+
+	return app->type == app_type;
+}
+
 static struct gatt_app *find_app_by_id(int32_t id)
 {
 	return queue_find(gatt_apps, match_app_by_id, INT_TO_PTR(id));
 }
 
+static struct gatt_app *find_app_by_type(gatt_app_type_t type)
+{
+	return queue_find(gatt_apps, match_app_by_type, INT_TO_PTR(type));
+}
+
 static bool match_by_value(const void *data, const void *user_data)
 {
 	return data == user_data;
@@ -1116,9 +1129,9 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 
 	device_set_state(dev, DEVICE_CONNECTED);
 
-	/* Send exchange mtu request as we assume being client and server */
-	/* TODO: Dont exchange mtu if no client apps */
-	send_exchange_mtu_request(dev);
+	/* Send exchange mtu request if any client app was registered */
+	if (find_app_by_type(APP_CLIENT))
+		send_exchange_mtu_request(dev);
 
 	status = GATT_SUCCESS;
 
-- 
1.9.3

