Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ] attio: Rename att_cleanup to attio_cleanup
Date: Mon, 23 Jul 2012 11:36:02 -0300
Message-Id: <1343054163-19119-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Cosmetic change renaming attio cleanup function. attio prefix is more
suitable since attio implements GIOChannel abstraction in the top of
the GAttrib.
---
 src/device.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/device.c b/src/device.c
index a937fcc..cd571f7 100644
--- a/src/device.c
+++ b/src/device.c
@@ -201,7 +201,7 @@ static void browse_request_free(struct browse_req *req)
 	g_free(req);
 }
 
-static void att_cleanup(struct btd_device *device)
+static void attio_cleanup(struct btd_device *device)
 {
 	if (device->attachid) {
 		attrib_channel_detach(device->attrib, device->attachid);
@@ -238,7 +238,7 @@ static void browse_request_cancel(struct browse_req *req)
 
 	bt_cancel_discovery(&src, &device->bdaddr);
 
-	att_cleanup(device);
+	attio_cleanup(device);
 
 	device->browse = NULL;
 	browse_request_free(req);
@@ -263,7 +263,7 @@ static void device_free(gpointer user_data)
 	g_slist_free_full(device->attios, g_free);
 	g_slist_free_full(device->attios_offline, g_free);
 
-	att_cleanup(device);
+	attio_cleanup(device);
 
 	if (device->tmp_records)
 		sdp_list_free(device->tmp_records,
@@ -1825,7 +1825,7 @@ static gboolean attrib_disconnected_cb(GIOChannel *io, GIOCondition cond,
 						att_connect_dispatched);
 
 done:
-	att_cleanup(device);
+	attio_cleanup(device);
 
 	return FALSE;
 }
@@ -1867,7 +1867,7 @@ static void appearance_cb(guint8 status, const guint8 *pdu, guint16 plen,
 done:
 	att_data_list_free(list);
 	if (device->attios == NULL && device->attios_offline == NULL)
-		att_cleanup(device);
+		attio_cleanup(device);
 }
 
 static void primary_cb(GSList *services, guint8 status, gpointer user_data)
@@ -1910,7 +1910,7 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 		gatt_read_char_by_uuid(device->attrib, gap_prim->range.start,
 			gap_prim->range.end, &uuid, appearance_cb, device);
 	} else if (device->attios == NULL && device->attios_offline == NULL)
-		att_cleanup(device);
+		attio_cleanup(device);
 
 	g_slist_free(uuids);
 
@@ -3127,7 +3127,7 @@ gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
 		device->auto_id = 0;
 	}
 
-	att_cleanup(device);
+	attio_cleanup(device);
 
 	return TRUE;
 }
-- 
1.7.8.6

