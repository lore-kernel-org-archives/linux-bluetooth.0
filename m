Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 6/6] Fix disconnecting when primary service discovery is done
Date: Fri, 25 Mar 2011 21:01:13 -0300
Message-Id: <1301097673-5262-7-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1301097673-5262-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1301097673-5262-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We shouldn't disconnect when the primary service discovery is done.
Most LE devices leave advertising mode as soon as the connection is
established, so shouldn't assume that we are able to reconnect to
them again.

For that we rely on the fact that GAttrib will close the connection
when its last reference is dropped.
---
 src/device.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/src/device.c b/src/device.c
index fa5764e..d567952 100644
--- a/src/device.c
+++ b/src/device.c
@@ -94,7 +94,6 @@ struct browse_req {
 	DBusConnection *conn;
 	DBusMessage *msg;
 	GAttrib *attrib;
-	GIOChannel *io;
 	struct btd_device *device;
 	GSList *match_uuids;
 	GSList *profiles_added;
@@ -166,11 +165,8 @@ static void browse_request_free(struct browse_req *req)
 	if (req->records)
 		sdp_list_free(req->records, (sdp_free_func_t) sdp_record_free);
 
-	if (req->io) {
+	if (req->attrib)
 		g_attrib_unref(req->attrib);
-		g_io_channel_unref(req->io);
-		g_io_channel_shutdown(req->io, FALSE, NULL);
-	}
 
 	g_free(req);
 }
@@ -1588,6 +1584,8 @@ static void gatt_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	}
 
 	req->attrib = g_attrib_new(io);
+	g_io_channel_unref(io);
+
 	gatt_discover_primary(req->attrib, NULL, primary_cb, req);
 }
 
@@ -1597,6 +1595,7 @@ int device_browse_primary(struct btd_device *device, DBusConnection *conn,
 	struct btd_adapter *adapter = device->adapter;
 	struct browse_req *req;
 	BtIOSecLevel sec_level;
+	GIOChannel *io;
 	bdaddr_t src;
 
 	if (device->browse)
@@ -1609,14 +1608,14 @@ int device_browse_primary(struct btd_device *device, DBusConnection *conn,
 
 	sec_level = secure ? BT_IO_SEC_HIGH : BT_IO_SEC_LOW;
 
-	req->io = bt_io_connect(BT_IO_L2CAP, gatt_connect_cb, req, NULL, NULL,
+	io = bt_io_connect(BT_IO_L2CAP, gatt_connect_cb, req, NULL, NULL,
 				BT_IO_OPT_SOURCE_BDADDR, &src,
 				BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
 				BT_IO_OPT_CID, GATT_CID,
 				BT_IO_OPT_SEC_LEVEL, sec_level,
 				BT_IO_OPT_INVALID);
 
-	if (req->io == NULL ) {
+	if (io == NULL ) {
 		browse_request_free(req);
 		return -EIO;
 	}
-- 
1.7.4.1

