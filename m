Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 8/8] hog: Rename hog_device_unregister
Date: Wed, 19 Dec 2012 10:42:06 -0300
Message-Id: <1355924526-961-1-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1355856590-19222-8-git-send-email-andre.guedes@openbossa.org>
References: <1355856590-19222-8-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch renames hog_device_unregister function to hog_unregister_
device.
---
 profiles/input/hog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index fa8069c..b6ac61d 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -753,7 +753,7 @@ static struct hog_device *hog_register_device(struct btd_device *device,
 	return hogdev;
 }
 
-static int hog_device_unregister(struct hog_device *hogdev)
+static int hog_unregister_device(struct hog_device *hogdev)
 {
 	struct uhid_event ev;
 
@@ -860,7 +860,7 @@ static void remove_device(gpointer a, gpointer b)
 		return;
 
 	devices = g_slist_remove(devices, hogdev);
-	hog_device_unregister(hogdev);
+	hog_unregister_device(hogdev);
 }
 
 static void hog_remove(struct btd_profile *p, struct btd_device *device)
-- 
1.8.0.1

