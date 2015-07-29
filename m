Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] core/device: Fix not emitting Paired property
Date: Wed, 29 Jul 2015 10:58:53 +0300
Message-Id: <1438156733-3258-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1438156733-3258-1-git-send-email-luiz.dentz@gmail.com>
References: <1438156733-3258-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Even if bt_gatt_client fails to discover services it should still call
device_svc_resolved so the Paired propery is updated if pending and the
device is properly stored, and at the end it still calls
browse_request_complete to free up the resources.
---
 src/device.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/src/device.c b/src/device.c
index debe201..3dde8b8 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4188,13 +4188,7 @@ static void gatt_client_ready_cb(bool success, uint8_t att_ecode,
 	DBG("status: %s, error: %u", success ? "success" : "failed", att_ecode);
 
 	if (!success) {
-		if (device->browse) {
-			struct browse_req *req = device->browse;
-
-			device->browse = NULL;
-			browse_request_complete(req, device->bdaddr_type, -EIO);
-		}
-
+		device_svc_resolved(device, device->bdaddr_type, -EIO);
 		return;
 	}
 
-- 
2.1.0

