Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ] core: Do not attempt to connect if adapter is not powered
Date: Tue, 12 Nov 2013 16:32:29 +0200
Message-Id: <1384266749-309-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the adapter is not yet powered do not attempt to connect, also
abort any connection attempt in case of error -EHOSTUNREACH is returned
by the kernel which also means the adapter is not up or in case of
-ECONNABORTED which means the adapter was powered down during the
connection attempt.
---
v2: Add better description, add comments what each error code means and
treat -ECONNABORTED.

 src/device.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index 60efd62..662ba26 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1156,8 +1156,15 @@ static void device_profile_connected(struct btd_device *dev,
 	if (dev->pending == NULL)
 		return;
 
-	if (!dev->connected && err == -EHOSTDOWN)
-		goto done;
+	if (!dev->connected) {
+		switch (-err) {
+		case EHOSTDOWN: /* page timeout */
+		case EHOSTUNREACH: /* adapter not powered */
+		case ECONNABORTED: /* adapter powered down */
+			goto done;
+		}
+	}
+
 
 	pending = dev->pending->data;
 	l = find_service_with_profile(dev->pending, profile);
@@ -1322,6 +1329,9 @@ static DBusMessage *connect_profiles(struct btd_device *dev, DBusMessage *msg,
 	if (dev->pending || dev->connect || dev->browse)
 		return btd_error_in_progress(msg);
 
+	if (!btd_adapter_get_powered(dev->adapter))
+		return btd_error_not_ready(msg);
+
 	device_set_temporary(dev, FALSE);
 
 	if (!dev->svc_resolved)
-- 
1.8.3.1

