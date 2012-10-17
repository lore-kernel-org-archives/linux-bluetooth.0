Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH] device: Fix modifying list while iterating
Date: Wed, 17 Oct 2012 12:07:09 +0200
Message-Id: <1350468429-30882-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

A list should not be modified while iterating on it, and in this case
the solution is trivial: the code is just trying to free the whole list
with a previous call to profile->device_remove() per list item.
---
 src/device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index f48faba..bb0f890 100644
--- a/src/device.c
+++ b/src/device.c
@@ -872,8 +872,6 @@ static void profile_remove(struct btd_profile *profile,
 						struct btd_device *device)
 {
 	profile->device_remove(profile, device);
-
-	device->profiles = g_slist_remove(device->profiles, profile);
 }
 
 static gboolean do_disconnect(gpointer user_data)
@@ -899,6 +897,8 @@ int device_block(struct btd_device *device, gboolean update_only)
 		do_disconnect(device);
 
 	g_slist_foreach(device->profiles, (GFunc) profile_remove, device);
+	g_slist_free(device->profiles);
+	device->profiles = NULL;
 
 	if (!update_only)
 		err = btd_adapter_block_address(device->adapter,
-- 
1.7.11.7

