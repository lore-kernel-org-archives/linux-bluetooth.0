Return-Path: <cyrus@holtmann.org>
From: "Gregory M. Turner" <gmt@be-evil.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	"Gregory M. Turner" <gmt@be-evil.net>
Subject: [PATCH v2(sorta) 1/2] bluetooth: Add BT_{INFO,ERR,DBG}_RATELIMITED
Date: Mon, 23 Feb 2015 22:25:40 -0800
Message-Id: <1424759141-17889-2-git-send-email-gmt@be-evil.net>
In-Reply-To: <1424759141-17889-1-git-send-email-gmt@be-evil.net>
References: <1424759141-17889-1-git-send-email-gmt@be-evil.net>
List-ID: <linux-bluetooth.vger.kernel.org>

Add ratelimited versions of the BT_{INFO,ERR,DBG} printk macros.

The assymetry with the existing _INFO and _ERR macros is because,
afaics, those are special-cased as an object-file-size optimization.
Duplicating that for the _RATELIMITED versions would clearly be a
deoptimization until they got a few more consumers (currently only a
single consumer is planned).

Signed-off-by: Gregory M. Turner <gmt@be-evil.net>
---
 include/net/bluetooth/bluetooth.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index e00455a..ec321f9 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -124,9 +124,12 @@ void bt_info(const char *fmt, ...);
 __printf(1, 2)
 void bt_err(const char *fmt, ...);
 
-#define BT_INFO(fmt, ...)	bt_info(fmt "\n", ##__VA_ARGS__)
-#define BT_ERR(fmt, ...)	bt_err(fmt "\n", ##__VA_ARGS__)
-#define BT_DBG(fmt, ...)	pr_debug(fmt "\n", ##__VA_ARGS__)
+#define BT_INFO(fmt, ...)		bt_info(fmt "\n", ##__VA_ARGS__)
+#define BT_INFO_RATELIMITED(fmt, ...)	pr_info_ratelimited(fmt "\n", ##__VA_ARGS__)
+#define BT_ERR(fmt, ...)		bt_err(fmt "\n", ##__VA_ARGS__)
+#define BT_ERR_RATELIMITED(fmt, ...)	pr_err_ratelimited(fmt "\n", ##__VA_ARGS__)
+#define BT_DBG(fmt, ...)		pr_debug(fmt "\n", ##__VA_ARGS__)
+#define BT_DBG_RATELIMITED(fmt, ...)	pr_debug_ratelimited(fmt "\n", ##__VA_ARGS__)
 
 /* Connection and socket states */
 enum {
-- 
2.3.0
