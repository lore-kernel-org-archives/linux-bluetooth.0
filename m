Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 1/3] core: Fix repeated connection attempt
Date: Fri,  1 Jun 2012 14:48:37 -0300
Message-Id: <1338572919-19071-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes possible repeated connections attempt to the same
remote device when there is an attempt pending, since device drivers
can request independently ATT connections.
---
 src/device.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/device.c b/src/device.c
index 7ff09aa..5988d37 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3102,7 +3102,7 @@ guint btd_device_add_attio_callback(struct btd_device *device,
 		} else {
 			device->attios = g_slist_append(device->attios, attio);
 		}
-	} else {
+	} else if (device->auto_id == 0) {
 		device->auto_id = g_idle_add_full(G_PRIORITY_DEFAULT_IDLE,
 						att_connect, device,
 						att_connect_dispatched);
-- 
1.7.8.6

