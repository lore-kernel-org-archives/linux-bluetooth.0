Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ] Use medium security level when reconnecting
Date: Tue, 20 Sep 2011 11:18:49 -0300
Message-Id: <1316528329-8149-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For GATT based profiles encryption is mandatory. Proximity Monitor
shall support LE Security Mode 1 and Security Level 2. Over basic rate,
switch the security level to medium for testing purpose only.
---
 src/device.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index 4d6aa98..33ea20f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1746,7 +1746,7 @@ static gboolean att_auto_connect(gpointer user_data)
 					BT_IO_OPT_SOURCE_BDADDR, &sba,
 					BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
 					BT_IO_OPT_PSM, ATT_PSM,
-					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 					BT_IO_OPT_INVALID);
 	} else {
 		io = bt_io_connect(BT_IO_L2CAP, att_connect_cb,
@@ -1754,7 +1754,7 @@ static gboolean att_auto_connect(gpointer user_data)
 					BT_IO_OPT_SOURCE_BDADDR, &sba,
 					BT_IO_OPT_DEST_BDADDR, &device->bdaddr,
 					BT_IO_OPT_CID, ATT_CID,
-					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 					BT_IO_OPT_INVALID);
 	}
 
-- 
1.7.6.1

