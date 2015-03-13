Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] core/device: Remove call to g_attrib_set_mtu
Date: Fri, 13 Mar 2015 10:54:12 +0200
Message-Id: <1426236852-10501-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1426236852-10501-1-git-send-email-luiz.dentz@gmail.com>
References: <1426236852-10501-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The call to g_attrib_set_mtu is no longer needed since
g_attrib_get_buffer has learned to check bt_att MTU.
---
 src/device.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/src/device.c b/src/device.c
index 0dc8c86..97c0523 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3975,11 +3975,6 @@ static void gatt_client_ready_cb(bool success, uint8_t att_ecode,
 		return;
 	}
 
-	device->att_mtu = bt_att_get_mtu(device->att);
-	g_attrib_set_mtu(device->attrib, device->att_mtu);
-
-	DBG("MTU: %u", device->att_mtu);
-
 	register_gatt_services(device);
 
 	device_accept_gatt_profiles(device);
-- 
2.1.0

