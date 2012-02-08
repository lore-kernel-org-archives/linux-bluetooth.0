Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] device: Remove unused function parameter
Date: Wed,  8 Feb 2012 17:35:47 -0300
Message-Id: <1328733349-29731-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1328733349-29731-1-git-send-email-andre.guedes@openbossa.org>
References: <1328733349-29731-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes the unused shutdown parameter from
browse_request_free function.
---
 src/device.c |   17 +++++++----------
 1 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/src/device.c b/src/device.c
index 23ca67b..5bc2d3b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -173,7 +173,7 @@ static uint16_t uuid_list[] = {
 
 static GSList *device_drivers = NULL;
 
-static void browse_request_free(struct browse_req *req, gboolean shutdown)
+static void browse_request_free(struct browse_req *req)
 {
 	if (req->listener_id)
 		g_dbus_remove_watch(req->conn, req->listener_id);
@@ -213,7 +213,7 @@ static void browse_request_cancel(struct browse_req *req)
 	}
 
 	device->browse = NULL;
-	browse_request_free(req, TRUE);
+	browse_request_free(req);
 }
 
 static void device_free(gpointer user_data)
@@ -1623,7 +1623,7 @@ cleanup:
 	}
 
 	device->browse = NULL;
-	browse_request_free(req, FALSE);
+	browse_request_free(req);
 }
 
 static void browse_cb(sdp_list_t *recs, int err, gpointer user_data)
@@ -1774,13 +1774,11 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 	struct browse_req *req = user_data;
 	struct btd_device *device = req->device;
 	GSList *l, *uuids = NULL;
-	gboolean shutdown;
 
 	if (status) {
 		DBusMessage *reply;
 		reply = btd_error_failed(req->msg, att_ecode2str(status));
 		g_dbus_send_message(req->conn, reply);
-		shutdown = TRUE;
 		goto done;
 	}
 
@@ -1816,11 +1814,10 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 	create_device_reply(device, req);
 
 	store_services(device);
-	shutdown = FALSE;
 
 done:
 	device->browse = NULL;
-	browse_request_free(req, shutdown);
+	browse_request_free(req);
 }
 
 static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
@@ -1920,7 +1917,7 @@ static void browse_primary_connect_cb(GIOChannel *io, GError *gerr,
 		g_dbus_send_message(req->conn, reply);
 
 		device->browse = NULL;
-		browse_request_free(req, TRUE);
+		browse_request_free(req);
 
 		return;
 	}
@@ -1961,7 +1958,7 @@ int device_browse_primary(struct btd_device *device, DBusConnection *conn,
 				BT_IO_OPT_INVALID);
 
 	if (device->att_io == NULL) {
-		browse_request_free(req, FALSE);
+		browse_request_free(req);
 		return -EIO;
 	}
 
@@ -2013,7 +2010,7 @@ int device_browse_sdp(struct btd_device *device, DBusConnection *conn,
 
 	err = bt_search_service(&src, &device->bdaddr, &uuid, cb, req, NULL);
 	if (err < 0) {
-		browse_request_free(req, FALSE);
+		browse_request_free(req);
 		return err;
 	}
 
-- 
1.7.9

