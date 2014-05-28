Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] input: Do not send UHID_DESTROY
Date: Wed, 28 May 2014 14:27:55 +0300
Message-Id: <1401276475-20978-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1401276475-20978-1-git-send-email-luiz.dentz@gmail.com>
References: <1401276475-20978-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Accourding to uHID documentation when diconnecting the kernel will take
care of cleaning up any device created:

  "If you close() the fd, the device is automatically unregistered and
   destroyed internally."
---
 profiles/input/device.c | 17 +----------------
 profiles/input/hog.c    | 10 ----------
 2 files changed, 1 insertion(+), 26 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 785b1e9..a61b2c7 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -108,22 +108,7 @@ static int connection_disconnect(struct input_device *idev, uint32_t flags);
 
 static void input_device_free(struct input_device *idev)
 {
-	if (idev->uhid) {
-		if (idev->uhid_created) {
-			int err;
-			struct uhid_event ev;
-
-			memset(&ev, 0, sizeof(ev));
-			ev.type = UHID_DESTROY;
-			err = bt_uhid_send(idev->uhid, &ev);
-			if (err < 0)
-				error("bt_uhid_send: %s (%d)", strerror(-err),
-									-err);
-		}
-
-		bt_uhid_unref(idev->uhid);
-	}
-
+	bt_uhid_unref(idev->uhid);
 	btd_service_unref(idev->service);
 	btd_device_unref(idev->device);
 	g_free(idev->path);
diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 47a4fb1..3753343 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -750,17 +750,7 @@ static struct hog_device *hog_register_device(struct btd_device *device,
 
 static int hog_unregister_device(struct hog_device *hogdev)
 {
-	struct uhid_event ev;
-	int err;
-
 	btd_device_remove_attio_callback(hogdev->device, hogdev->attioid);
-
-	memset(&ev, 0, sizeof(ev));
-	ev.type = UHID_DESTROY;
-	err = bt_uhid_send(hogdev->uhid, &ev);
-	if (err < 0)
-		error("bt_uhid_send: %s (%d)", strerror(-err), -err);
-
 	bt_uhid_unref(hogdev->uhid);
 	hog_free_device(hogdev);
 
-- 
1.9.0

