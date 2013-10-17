Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ] core: Fix missing adapter address type
Date: Thu, 17 Oct 2013 09:53:37 -0300
Message-Id: <1382014417-23930-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes an invalid argument error when connecting to LE
devices. Bind and connect address type must match.
---
 src/device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/device.c b/src/device.c
index 457ab64..3dd3584 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3446,6 +3446,7 @@ static int device_browse_primary(struct btd_device *device, DBusMessage *msg)
 				attcb, NULL, NULL,
 				BT_IO_OPT_SOURCE_BDADDR,
 				adapter_get_address(adapter),
+				BT_IO_OPT_SOURCE_TYPE, BDADDR_LE_PUBLIC,
 				BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
 				BT_IO_OPT_DEST_TYPE, device->bdaddr_type,
 				BT_IO_OPT_CID, ATT_CID,
-- 
1.8.3.1

