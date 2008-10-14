Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Better debug when failing to probe a device
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-NOpqaFhj4YYSAYGQXNAb"
Date: Tue, 14 Oct 2008 22:01:07 +0100
Message-Id: <1224018067.5268.854.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-NOpqaFhj4YYSAYGQXNAb
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The previous error message was a bit terse.

--=-NOpqaFhj4YYSAYGQXNAb
Content-Disposition: attachment; filename="0002-Better-debug-when-failing-to-probe-a-device.patch"
Content-Type: text/x-patch; name="0002-Better-debug-when-failing-to-probe-a-device.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 5c71324238e5380530a298bb63ec9d79b7a1f219 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Tue, 14 Oct 2008 21:58:51 +0100
Subject: [PATCH] Better debug when failing to probe a device

The previous error message was a bit terse.
---
 src/device.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index 7294d3c..2a48406 100644
--- a/src/device.c
+++ b/src/device.c
@@ -646,8 +646,8 @@ void device_probe_drivers(struct btd_device *device, GSList *uuids)
 
 			err = driver->probe(device, probe_uuids);
 			if (err < 0) {
-				error("probe failed for driver %s",
-							driver->name);
+				error("probe failed with driver %s for device %s",
+							driver->name, device->path);
 
 				g_free(driver_data);
 				g_slist_free(probe_uuids);
-- 
1.5.5.2


--=-NOpqaFhj4YYSAYGQXNAb--

