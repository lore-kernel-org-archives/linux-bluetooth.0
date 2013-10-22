Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add function name to debug prints
Date: Tue, 22 Oct 2013 10:09:11 +0300
Message-Id: <1382425751-9018-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
Hi,

the debug prints are quite useless without the function name.
Without this patch one sees lot of "hci0" lines which is not
very helpful.

Cheers,
Jukka

 include/net/bluetooth/bluetooth.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index bf2ddff..0b1eacd 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -122,7 +122,7 @@ int bt_err(const char *fmt, ...);
 
 #define BT_INFO(fmt, ...)	bt_info(fmt "\n", ##__VA_ARGS__)
 #define BT_ERR(fmt, ...)	bt_err(fmt "\n", ##__VA_ARGS__)
-#define BT_DBG(fmt, ...)	pr_debug(fmt "\n", ##__VA_ARGS__)
+#define BT_DBG(fmt, ...)	pr_debug("%s():" fmt "\n", __FUNCTION__, ##__VA_ARGS__)
 
 /* Connection and socket states */
 enum {
-- 
1.7.11.7

