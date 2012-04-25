Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 3/7] Add address type for BLE bt_io_connect calls
Date: Tue, 24 Apr 2012 22:42:27 -0300
Message-Id: <1335318151-21063-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1335318151-21063-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1335318151-21063-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the address type option in bt_io_connect calls for BLE
devices. BR/EDR is the default value, and it is not mandatory to inform
it. For BLE devices, it is necessary to inform if the type is public or
random.
---
 src/device.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/src/device.c b/src/device.c
index ea6fec2..1ea4854 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2001,6 +2001,7 @@ static gboolean att_connect(gpointer user_data)
 					attcb, NULL, &gerr,
 					BT_IO_OPT_SOURCE_BDADDR, &sba,
 					BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
+					BT_IO_OPT_DEST_TYPE, device->type,
 					BT_IO_OPT_CID, ATT_CID,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 					BT_IO_OPT_INVALID);
@@ -2086,6 +2087,7 @@ int device_browse_primary(struct btd_device *device, DBusConnection *conn,
 				attcb, NULL, NULL,
 				BT_IO_OPT_SOURCE_BDADDR, &src,
 				BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
+				BT_IO_OPT_DEST_TYPE, device->type,
 				BT_IO_OPT_CID, ATT_CID,
 				BT_IO_OPT_SEC_LEVEL, sec_level,
 				BT_IO_OPT_INVALID);
@@ -2488,7 +2490,8 @@ DBusMessage *device_create_bonding(struct btd_device *device,
 		device->att_io = bt_io_connect(BT_IO_L2CAP, att_connect_cb,
 					attcb, NULL, &gerr,
 					BT_IO_OPT_SOURCE_BDADDR, &sba,
-					BT_IO_OPT_DEST_BDADDR,&device->bdaddr,
+					BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
+					BT_IO_OPT_DEST_TYPE, device->type,
 					BT_IO_OPT_CID, ATT_CID,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 					BT_IO_OPT_INVALID);
-- 
1.7.8.5

