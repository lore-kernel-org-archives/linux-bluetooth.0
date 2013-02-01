Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ] device: Fix not marking svc_resolved when loaded from storage
Date: Fri,  1 Feb 2013 14:37:16 -0300
Message-Id: <1359740236-16095-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the device is loaded from storage, we should mark it as it
services were resolved.
---
 src/device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/device.c b/src/device.c
index 452ccfe..49f8957 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1849,6 +1849,9 @@ next:
 								bt_uuid_strcmp);
 		}
 		g_strfreev(uuids);
+
+		/* Discovered services restored from storage */
+		device->svc_resolved = true;
 	}
 
 	/* Load device id */
-- 
1.8.1.1

