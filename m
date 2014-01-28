Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ 3/3] alert: Only remove attio callback after ATT request was sent
Date: Tue, 28 Jan 2014 11:51:38 -0400
Message-Id: <1390924298-13804-4-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1390924298-13804-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1390924298-13804-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If there is a single registered attio callback, any pending ATT requests
will be dropped as soon as it is removed. This commit makes sure that
the request is sent before removing the callback.

Other places using attio callbacks may need fixing as well.
---
 profiles/alert/server.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index 94e9865..92d4fb6 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -363,6 +363,20 @@ end:
 	return result;
 }
 
+static void destroy_notify_callback(guint8 status, const guint8 *pdu, guint16 len,
+							gpointer user_data)
+{
+	struct notify_callback *cb = user_data;
+
+	DBG("status=%#x", status);
+
+	btd_device_remove_attio_callback(cb->device, cb->id);
+	btd_device_unref(cb->device);
+	g_free(cb->notify_data->value);
+	g_free(cb->notify_data);
+	g_free(cb);
+}
+
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 {
 	struct notify_callback *cb = user_data;
@@ -398,7 +412,9 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 					al_adapter->hnd_value[type],
 					al_adapter->hnd_ccc[type]);
 
-	g_attrib_send(attrib, 0, pdu, len, NULL, NULL, NULL);
+	g_attrib_send(attrib, 0, pdu, len, destroy_notify_callback, cb, NULL);
+
+	return;
 
 end:
 	btd_device_remove_attio_callback(cb->device, cb->id);
-- 
1.8.3.2

