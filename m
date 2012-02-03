Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ] device: Fix doing sdp discovery for LE devices
Date: Fri,  3 Feb 2012 20:06:45 -0300
Message-Id: <1328310405-16329-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If ReverseServiceDiscovery is enabled and we are connected to a LE
device, we should do a Primary Service Discovery, not a SDP discovery
(which doesn't even make sense).
---

This patch assumes that it makes sense to reuse the ReverseServiceDiscovery
functionality for LE devices.


 src/device.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index 46f26d1..c7c741c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1933,7 +1933,9 @@ int device_browse_primary(struct btd_device *device, DBusConnection *conn,
 		return -EIO;
 	}

-	req->conn = dbus_connection_ref(conn);
+	if (conn)
+		req->conn = dbus_connection_ref(conn);
+
 	device->browse = req;

 	if (msg) {
@@ -2118,7 +2120,10 @@ static gboolean start_discovery(gpointer user_data)
 {
 	struct btd_device *device = user_data;

-	device_browse_sdp(device, NULL, NULL, NULL, TRUE);
+	if (device_is_bredr(device))
+		device_browse_sdp(device, NULL, NULL, NULL, FALSE);
+	else
+		device_browse_primary(device, NULL, NULL, FALSE);

 	device->discov_timer = 0;

--
1.7.8.1

