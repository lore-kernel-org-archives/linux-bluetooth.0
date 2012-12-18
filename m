Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/8] hog: Rename hog_device_remove
Date: Tue, 18 Dec 2012 15:49:45 -0300
Message-Id: <1355856590-19222-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1355856590-19222-1-git-send-email-andre.guedes@openbossa.org>
References: <1355856590-19222-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch renames hog_device_remove function to hog_remove.
---
 profiles/input/hog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 1cb580e..00ec151 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -864,7 +864,7 @@ static void remove_device(gpointer a, gpointer b)
 	hog_device_unregister(hogdev);
 }
 
-static void hog_device_remove(struct btd_profile *p, struct btd_device *device)
+static void hog_remove(struct btd_profile *p, struct btd_device *device)
 {
 	const gchar *path = device_get_path(device);
 
@@ -877,7 +877,7 @@ static struct btd_profile hog_profile = {
 	.name		= "input-hog",
 	.remote_uuids	= BTD_UUIDS(HOG_UUID),
 	.device_probe	= hog_probe,
-	.device_remove	= hog_device_remove,
+	.device_remove	= hog_remove,
 };
 
 static int hog_init(void)
-- 
1.8.0.1

