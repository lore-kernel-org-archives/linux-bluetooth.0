Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: mcchou@chromium.org
To: linux-bluetooth@vger.kernel.org
Cc: josephsih@chromium.org, sonnysasaka@chromium.org, rkc@chromium.org,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [PATCH] device: Clear GATT DB after disconnection for unpaired device
Date: Tue, 23 May 2017 12:11:12 -0700
Message-Id: <20170523191112.190500-1-mcchou@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Miao-chen Chou <mcchou@chromium.org>

This patch adds gatt_db_cleanup() function to clear client-role GATT DB for the
unpaired device.
---
 src/device.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/src/device.c b/src/device.c
index 1b05561e4..da24a9430 100644
--- a/src/device.c
+++ b/src/device.c
@@ -267,6 +267,7 @@ struct pending_sdp_query {

 static int device_browse_gatt(struct btd_device *device, DBusMessage *msg);
 static int device_browse_sdp(struct btd_device *device, DBusMessage *msg);
+static void store_gatt_db(struct btd_device *device);

 static struct pending_sdp_query *pending_sdp_query_new(DBusConnection *conn,
 				DBusMessage *msg, const struct btd_device *dev)
@@ -546,6 +547,14 @@ static void browse_request_free(struct browse_req *req)
 	g_free(req);
 }

+static void gatt_db_cleanup(struct btd_device* device)
+{
+	if (device->bredr_state.bonded || device->le_state.bonded)
+		return;
+	gatt_db_clear(device->db);
+	store_gatt_db(device);
+}
+
 static void gatt_client_cleanup(struct btd_device *device)
 {
 	if (!device->client)
@@ -578,6 +587,7 @@ static void attio_cleanup(struct btd_device *device)
 		device->att_io = NULL;
 	}

+	gatt_db_cleanup(device);
 	gatt_client_cleanup(device);
 	gatt_server_cleanup(device);

--
2.13.0.219.gdb65acc882-goog

