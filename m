Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] device: Remove bogus line from device_create_bonding
Date: Fri, 5 Oct 2012 13:08:37 +0200
Message-ID: <1349435317-10736-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a typo from 899e6561d284806007b7e57e1ab3b65e54be3d22.

---
 src/device.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 1c65b68..0d25631 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2549,7 +2549,6 @@ DBusMessage *device_create_bonding(struct btd_device *device,
 	if (device_is_bonded(device))
 		return btd_error_already_exists(msg);
 
-				adapter_get_address(adapter),
 	bonding = bonding_request_new(msg, device, agent_path,
 					capability);
 
-- 
1.7.9.5

