Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/8] hog: Rename hog_device_register
Date: Tue, 18 Dec 2012 15:49:49 -0300
Message-Id: <1355856590-19222-7-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1355856590-19222-1-git-send-email-andre.guedes@openbossa.org>
References: <1355856590-19222-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch renames hog_device_register function to hog_register_device.
---
 profiles/input/hog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 8d8f804..fa8069c 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -716,7 +716,7 @@ static void hog_free_device(struct hog_device *hogdev)
 	g_free(hogdev);
 }
 
-static struct hog_device *hog_device_register(struct btd_device *device,
+static struct hog_device *hog_register_device(struct btd_device *device,
 						struct gatt_primary *prim)
 {
 	struct hog_device *hogdev;
@@ -841,7 +841,7 @@ static int hog_probe(struct btd_profile *p, struct btd_device *device,
 		if (strcmp(prim->uuid, HOG_UUID) != 0)
 			continue;
 
-		hogdev = hog_device_register(device, prim);
+		hogdev = hog_register_device(device, prim);
 		if (hogdev == NULL)
 			continue;
 
-- 
1.8.0.1

