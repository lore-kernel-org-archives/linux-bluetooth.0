Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] android/hid: Fix passing wrong adapter address to bt_io_listen
Date: Tue,  5 Nov 2013 15:12:20 +0200
Message-Id: <1383657140-10758-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/hid.c b/android/hid.c
index c0c9aeb..8f5ba88 100644
--- a/android/hid.c
+++ b/android/hid.c
@@ -749,7 +749,7 @@ bool bt_hid_register(GIOChannel *io, const bdaddr_t *addr)
 	notification_io = g_io_channel_ref(io);
 
 	ctrl_io = bt_io_listen(connect_cb, NULL, NULL, NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, &src,
+				BT_IO_OPT_SOURCE_BDADDR, src,
 				BT_IO_OPT_PSM, L2CAP_PSM_HIDP_CTRL,
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 				BT_IO_OPT_INVALID);
@@ -760,7 +760,7 @@ bool bt_hid_register(GIOChannel *io, const bdaddr_t *addr)
 	}
 
 	intr_io = bt_io_listen(connect_cb, NULL, NULL, NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, &src,
+				BT_IO_OPT_SOURCE_BDADDR, src,
 				BT_IO_OPT_PSM, L2CAP_PSM_HIDP_INTR,
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 				BT_IO_OPT_INVALID);
-- 
1.8.3.1

