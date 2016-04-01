Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] input/hog: Fix crash if uhid is not enabled
Date: Fri,  1 Apr 2016 21:58:29 +0200
Message-Id: <1459540709-2058-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If /dev/uhid is not present bt_hog_new_default() returns NULL.
This was resulting in NULL pointer dereference in attio_connected_cb.
---
 profiles/input/hog.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 4dba83f..a934c62 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -107,8 +107,13 @@ static struct hog_device *hog_device_new(struct btd_device *device,
 							product, version);
 
 	dev = new0(struct hog_device, 1);
-	dev->device = btd_device_ref(device);
 	dev->hog = bt_hog_new_default(name, vendor, product, version, prim);
+	if (!dev->hog) {
+		free(dev);
+		return NULL;
+	}
+
+	dev->device = btd_device_ref(device);
 
 	/*
 	 * TODO: Remove attio callback and use .accept once using
@@ -189,6 +194,9 @@ static int hog_probe(struct btd_service *service)
 			continue;
 
 		dev = hog_device_new(device, prim);
+		if (!dev)
+			break;
+
 		btd_service_set_user_data(service, dev);
 		return 0;
 	}
-- 
2.6.2

