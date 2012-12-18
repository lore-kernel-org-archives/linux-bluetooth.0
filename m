Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/8] hog: Rename hog_device_free
Date: Tue, 18 Dec 2012 15:49:48 -0300
Message-Id: <1355856590-19222-6-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1355856590-19222-1-git-send-email-andre.guedes@openbossa.org>
References: <1355856590-19222-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch renames hog_device_free function to hog_free_device.
---
 profiles/input/hog.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index c68a089..8d8f804 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -707,7 +707,7 @@ static void report_free(void *data)
 	g_free(report);
 }
 
-static void hog_device_free(struct hog_device *hogdev)
+static void hog_free_device(struct hog_device *hogdev)
 {
 	btd_device_unref(hogdev->device);
 	g_slist_free_full(hogdev->reports, report_free);
@@ -731,7 +731,7 @@ static struct hog_device *hog_device_register(struct btd_device *device,
 	if (hogdev->uhid_fd < 0) {
 		error("Failed to open uHID device: %s(%d)", strerror(errno),
 									errno);
-		hog_device_free(hogdev);
+		hog_free_device(hogdev);
 		return NULL;
 	}
 
@@ -772,7 +772,7 @@ static int hog_device_unregister(struct hog_device *hogdev)
 	close(hogdev->uhid_fd);
 	hogdev->uhid_fd = -1;
 
-	hog_device_free(hogdev);
+	hog_free_device(hogdev);
 
 	return 0;
 }
-- 
1.8.0.1

