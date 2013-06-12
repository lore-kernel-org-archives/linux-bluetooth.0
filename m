Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core: Only page device once per connect attempt
Date: Wed, 12 Jun 2013 15:13:36 +0300
Message-Id: <1371039216-15944-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In case of EHOSTDOWN/page timeout the code should not proceed with the
next profile as it is very likely it will fail again, moreover the page
timeout is configurable and should be enough for getting a response from
the remote device in a reasonable time.
---
 src/device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/device.c b/src/device.c
index 5cb5460..0f75c60 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1164,6 +1164,9 @@ static void device_profile_connected(struct btd_device *dev,
 	if (dev->pending == NULL)
 		return;
 
+	if (!dev->connected && err == -EHOSTDOWN)
+		goto done;
+
 	pending = dev->pending->data;
 	l = find_service_with_profile(dev->pending, profile);
 	if (l != NULL)
@@ -1179,6 +1182,7 @@ static void device_profile_connected(struct btd_device *dev,
 	if (connect_next(dev) == 0)
 		return;
 
+done:
 	if (!dev->connect)
 		return;
 
-- 
1.8.1.4

