Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v0 2/3] Add device driver support for partial unloading
Date: Mon, 12 Mar 2012 16:56:38 +0100
Message-Id: <1331567799-1247-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1331567799-1247-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1331567799-1247-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

A driver that supports several profiles (uuid) should not necessarily be
completely unloaded just because one of its profiles has been removed.

This patch adds a new callback that a driver can implement, where
partial removals are handled. The return value of this callback will
tell the core if the driver should be entirely removed (in that case, 0
is returned).
---
 src/device.c |   15 ++++++++++++---
 src/device.h |    1 +
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/src/device.c b/src/device.c
index dfc8e59..a38dbe7 100644
--- a/src/device.c
+++ b/src/device.c
@@ -497,6 +497,17 @@ static void driver_remove(struct btd_device_driver *driver,
 	device->drivers = g_slist_remove(device->drivers, driver);
 }
 
+static void driver_partial_remove(struct btd_device_driver *driver,
+						struct btd_device *device,
+						const char *uuid)
+{
+	if (driver->partial_remove != NULL)
+		if (driver->partial_remove(device, uuid) > 0)
+			return;
+
+	driver_remove(driver, device);
+}
+
 static gboolean do_disconnect(gpointer user_data)
 {
 	struct btd_device *device = user_data;
@@ -1349,9 +1360,7 @@ static void device_remove_drivers(struct btd_device *device, GSList *uuids)
 			DBG("UUID %s was removed from device %s",
 							*uuid, dstaddr);
 
-			driver->remove(device);
-			device->drivers = g_slist_remove(device->drivers,
-								driver);
+			driver_partial_remove(driver, device, *uuid);
 			break;
 		}
 	}
diff --git a/src/device.h b/src/device.h
index 7cb9bb2..ef4909b 100644
--- a/src/device.h
+++ b/src/device.h
@@ -107,6 +107,7 @@ struct btd_device_driver {
 	const char *name;
 	const char **uuids;
 	int (*probe) (struct btd_device *device, GSList *uuids);
+	int (*partial_remove) (struct btd_device *device, const char *uuid);
 	void (*remove) (struct btd_device *device);
 };
 
-- 
1.7.7.6

