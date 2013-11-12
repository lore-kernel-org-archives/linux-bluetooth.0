Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core: Do not attempt to connect if adapter is not powered
Date: Tue, 12 Nov 2013 15:26:34 +0200
Message-Id: <1384262794-27381-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the adapter is not yet powered do not attempt to connect, the same
applies if the error -EHOSTUNREACH is returned by the kernel.
---
 src/device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 60efd62..e58c16c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1156,7 +1156,7 @@ static void device_profile_connected(struct btd_device *dev,
 	if (dev->pending == NULL)
 		return;
 
-	if (!dev->connected && err == -EHOSTDOWN)
+	if (!dev->connected && (err == -EHOSTDOWN || err == -EHOSTUNREACH))
 		goto done;
 
 	pending = dev->pending->data;
@@ -1322,6 +1322,9 @@ static DBusMessage *connect_profiles(struct btd_device *dev, DBusMessage *msg,
 	if (dev->pending || dev->connect || dev->browse)
 		return btd_error_in_progress(msg);
 
+	if (!btd_adapter_get_powered(dev->adapter))
+		return btd_error_not_ready(msg);
+
 	device_set_temporary(dev, FALSE);
 
 	if (!dev->svc_resolved)
-- 
1.8.3.1

