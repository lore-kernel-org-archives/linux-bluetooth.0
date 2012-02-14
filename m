Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 4/4] device: Fix memory leak during GATT service update
Date: Tue, 14 Feb 2012 12:06:04 -0400
Message-Id: <1329235564-12471-5-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1329235564-12471-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1329235564-12471-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

GATT service updates are not supported yet. This patch avoids a memory
leak and GATT service storage corruption due to trying to register GATT
services twice.

After adding support for Services Changed characteristic notification
(which is mandatory for GATT clients), this check can be removed.
---
 src/device.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/src/device.c b/src/device.c
index b410a63..dfc8e59 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1982,6 +1982,14 @@ int device_browse_primary(struct btd_device *device, DBusConnection *conn,
 	if (device->browse)
 		return -EBUSY;
 
+	/* FIXME: GATT service updates (implemented in update_services() for
+	 * SDP) are not supported yet. It will be supported once client side
+	 * "Services Changed" characteristic handling is implemented. */
+	if (device->primaries) {
+		error("Could not update GATT services");
+		return -ENOSYS;
+	}
+
 	req = g_new0(struct browse_req, 1);
 	req->device = btd_device_ref(device);
 	adapter_get_address(adapter, &src);
-- 
1.7.5.4

