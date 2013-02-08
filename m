Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core: Fix calling profile .connect multiple times
Date: Fri,  8 Feb 2013 11:51:28 +0200
Message-Id: <1360317088-18852-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Sometimes profiles may complete the connection in different order
than expected so the code has to check if it was actually the
current pending profile to proceed to the next.
---
 src/device.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/src/device.c b/src/device.c
index 49f8957..8ee7659 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1085,8 +1085,14 @@ static int connect_next(struct btd_device *dev)
 void device_profile_connected(struct btd_device *dev,
 					struct btd_profile *profile, int err)
 {
+	struct btd_profile *pending;
+
 	DBG("%s %s (%d)", profile->name, strerror(-err), -err);
 
+	if (dev->pending == NULL)
+		return;
+
+	pending = dev->pending->data;
 	dev->pending = g_slist_remove(dev->pending, profile);
 
 	if (!err)
@@ -1094,6 +1100,13 @@ void device_profile_connected(struct btd_device *dev,
 				g_slist_append(dev->connected_profiles,
 								profile);
 
+	/* Only continue connecting the next profile if it matches the first
+	 * pending, otherwise it will trigger another connect to the same
+	 * profile
+	 */
+	if (profile != pending)
+		return;
+
 	if (connect_next(dev) == 0)
 		return;
 
-- 
1.8.1

