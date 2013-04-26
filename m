Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v3 06/27] input: Fix ignored profile shutdown
Date: Fri, 26 Apr 2013 08:17:02 +0200
Message-Id: <1366957043-2383-7-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Unprobing the profile should never fail which means neither should
input_device_unregister(). This requires shutting everything down
regardless of possible pending connection requests.
---
 profiles/input/device.c | 11 ++---------
 profiles/input/device.h |  2 +-
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 4af95d8..161d8af 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -903,7 +903,7 @@ static struct input_device *find_device(const bdaddr_t *src,
 	return NULL;
 }
 
-int input_device_unregister(const char *path, const char *uuid)
+void input_device_unregister(const char *path, const char *uuid)
 {
 	struct input_device *idev;
 
@@ -911,20 +911,13 @@ int input_device_unregister(const char *path, const char *uuid)
 
 	idev = find_device_by_path(devices, path);
 	if (idev == NULL)
-		return -EINVAL;
-
-	if (idev->ctrl_io) {
-		/* Pending connection running */
-		return -EBUSY;
-	}
+		return;
 
 	g_dbus_unregister_interface(btd_get_dbus_connection(),
 						idev->path, INPUT_INTERFACE);
 
 	devices = g_slist_remove(devices, idev);
 	input_device_free(idev);
-
-	return 0;
 }
 
 static int input_device_connadd(struct input_device *idev)
diff --git a/profiles/input/device.h b/profiles/input/device.h
index aabc79c..db69053 100644
--- a/profiles/input/device.h
+++ b/profiles/input/device.h
@@ -30,7 +30,7 @@ struct input_conn;
 int input_device_register(struct btd_device *device, const char *path,
 				const char *uuid, const sdp_record_t *rec,
 				int timeout);
-int input_device_unregister(const char *path, const char *uuid);
+void input_device_unregister(const char *path, const char *uuid);
 
 int input_device_set_channel(const bdaddr_t *src, const bdaddr_t *dst, int psm,
 							GIOChannel *io);
-- 
1.8.1.4

