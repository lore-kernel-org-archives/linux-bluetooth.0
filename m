Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/8] hog: Rename hog_device_probe
Date: Tue, 18 Dec 2012 15:49:44 -0300
Message-Id: <1355856590-19222-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1355856590-19222-1-git-send-email-andre.guedes@openbossa.org>
References: <1355856590-19222-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch renames hog_device_probe function to hog_probe.
---
 profiles/input/hog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index e2a3488..1cb580e 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -823,7 +823,7 @@ static void resume_callback(void)
 	g_slist_foreach(devices, set_suspend, GINT_TO_POINTER(suspend));
 }
 
-static int hog_device_probe(struct btd_profile *p, struct btd_device *device,
+static int hog_probe(struct btd_profile *p, struct btd_device *device,
 								GSList *uuids)
 {
 	const char *path = device_get_path(device);
@@ -876,7 +876,7 @@ static void hog_device_remove(struct btd_profile *p, struct btd_device *device)
 static struct btd_profile hog_profile = {
 	.name		= "input-hog",
 	.remote_uuids	= BTD_UUIDS(HOG_UUID),
-	.device_probe	= hog_device_probe,
+	.device_probe	= hog_probe,
 	.device_remove	= hog_device_remove,
 };
 
-- 
1.8.0.1

