Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 2/3] core: Fix connected callback not being called
Date: Fri,  1 Jun 2012 14:48:38 -0300
Message-Id: <1338572919-19071-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1338572919-19071-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1338572919-19071-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ATTIO callbacks are not being added in the list when there is a
connection attempt pending.
---
 src/device.c |   21 +++++++++------------
 1 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/src/device.c b/src/device.c
index 5988d37..5aec0c2 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3093,23 +3093,20 @@ guint btd_device_add_attio_callback(struct btd_device *device,
 	attio->dcfunc = dcfunc;
 	attio->user_data = user_data;
 
-	if (device->attrib) {
-		if (cfunc) {
-			device->attios_offline =
-				g_slist_append(device->attios_offline, attio);
+	if (device->attrib && cfunc) {
+		device->attios_offline = g_slist_append(device->attios_offline,
+									attio);
+		g_idle_add(notify_attios, device);
+		return attio->id;
+	}
 
-			g_idle_add(notify_attios, device);
-		} else {
-			device->attios = g_slist_append(device->attios, attio);
-		}
-	} else if (device->auto_id == 0) {
+	device->attios = g_slist_append(device->attios, attio);
+
+	if (device->auto_id == 0)
 		device->auto_id = g_idle_add_full(G_PRIORITY_DEFAULT_IDLE,
 						att_connect, device,
 						att_connect_dispatched);
 
-		device->attios = g_slist_append(device->attios, attio);
-	}
-
 	return attio->id;
 }
 
-- 
1.7.8.6

