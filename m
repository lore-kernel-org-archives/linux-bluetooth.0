Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 09/10] core: Rename services_changed to uuids_changed
Date: Mon, 20 Aug 2012 14:22:54 -0300
Message-Id: <1345483375-27621-10-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345483375-27621-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345483375-27621-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch renames the services_changed function to uuids_changed to
avoid misinterpretation. "Service Changed" expression is used to refer
to a GATT operation used to notify clients that a given attribute range
in the GATT server is not valid anymore.
---
 src/device.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/device.c b/src/device.c
index c4b5554..7b44e27 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1409,7 +1409,7 @@ static void device_remove_drivers(struct btd_device *device, GSList *uuids)
 		sdp_list_free(records, (sdp_free_func_t) sdp_record_free);
 }
 
-static void services_changed(struct btd_device *device)
+static void uuids_changed(struct btd_device *device)
 {
 	DBusConnection *conn = get_dbus_connection();
 	char **uuids;
@@ -1689,7 +1689,7 @@ static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
 		device_remove_drivers(device, req->profiles_removed);
 
 	/* Propagate services changes */
-	services_changed(req->device);
+	uuids_changed(req->device);
 
 send_reply:
 	if (!req->msg)
@@ -1910,7 +1910,7 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 	if (device->attios == NULL && device->attios_offline == NULL)
 		attio_cleanup(device);
 
-	services_changed(device);
+	uuids_changed(device);
 	if (req->msg)
 		create_device_reply(device, req);
 
@@ -2971,7 +2971,7 @@ void btd_device_add_uuid(struct btd_device *device, const char *uuid)
 	g_slist_free(uuid_list);
 
 	store_profiles(device);
-	services_changed(device);
+	uuids_changed(device);
 }
 
 const sdp_record_t *btd_device_get_record(struct btd_device *device,
-- 
1.7.8.6

