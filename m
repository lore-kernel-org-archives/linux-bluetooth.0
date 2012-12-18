Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] hog: Fix removing HoG device bug
Date: Tue, 18 Dec 2012 11:41:21 -0300
Message-Id: <1355841681-2589-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1355841681-2589-1-git-send-email-andre.guedes@openbossa.org>
References: <1355841681-2589-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We should remove only hog_devices from the given btd_device.
Otherwise, all hog_devices will be removed.
---
 profiles/input/hog_device.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/profiles/input/hog_device.c b/profiles/input/hog_device.c
index 47f0e43..2284453 100644
--- a/profiles/input/hog_device.c
+++ b/profiles/input/hog_device.c
@@ -851,8 +851,14 @@ static int hog_device_probe(struct btd_profile *p, struct btd_device *device,
 	return 0;
 }
 
-static void remove_device(gpointer hogdev, gpointer b)
+static void remove_device(gpointer a, gpointer b)
 {
+	struct hog_device *hogdev = a;
+	struct btd_device *device = b;
+
+	if (hogdev->device != device)
+		return;
+
 	devices = g_slist_remove(devices, hogdev);
 	hog_device_unregister(hogdev);
 }
@@ -863,7 +869,7 @@ static void hog_device_remove(struct btd_profile *p, struct btd_device *device)
 
 	DBG("path %s", path);
 
-	g_slist_foreach(devices, remove_device, NULL);
+	g_slist_foreach(devices, remove_device, device);
 }
 
 static struct btd_profile hog_profile = {
-- 
1.8.0.1

