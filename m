Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <ext.szymon.janc@tieto.com>
Subject: [PATCH v2 1/2] Bluetooth: Add BT_ERR_RATELIMITED
Date: Wed, 16 Sep 2015 20:21:53 +0200
Message-Id: <1442427714-27726-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <ext.szymon.janc@tieto.com>

This patch adds ratelimited version of the BT_ERR macro.

Signed-off-by: Szymon Janc <ext.szymon.janc@tieto.com>
---
 include/net/bluetooth/bluetooth.h |  4 ++++
 net/bluetooth/lib.c               | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index fcf2ae7..f5ade85 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -123,11 +123,15 @@ __printf(1, 2)
 void bt_info(const char *fmt, ...);
 __printf(1, 2)
 void bt_err(const char *fmt, ...);
+__printf(1, 2)
+void bt_err_ratelimited(const char *fmt, ...);
 
 #define BT_INFO(fmt, ...)	bt_info(fmt "\n", ##__VA_ARGS__)
 #define BT_ERR(fmt, ...)	bt_err(fmt "\n", ##__VA_ARGS__)
 #define BT_DBG(fmt, ...)	pr_debug(fmt "\n", ##__VA_ARGS__)
 
+#define BT_ERR_RATELIMITED(fmt, ...) bt_err_ratelimited(fmt "\n", ##__VA_ARGS__)
+
 #define bt_dev_info(hdev, fmt, ...)				\
 	BT_INFO("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
 #define bt_dev_err(hdev, fmt, ...)				\
diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
index b36bc04..8b4cdce 100644
--- a/net/bluetooth/lib.c
+++ b/net/bluetooth/lib.c
@@ -166,3 +166,19 @@ void bt_err(const char *format, ...)
 	va_end(args);
 }
 EXPORT_SYMBOL(bt_err);
+
+void bt_err_ratelimited(const char *format, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, format);
+
+	vaf.fmt = format;
+	vaf.va = &args;
+
+	pr_err_ratelimited("%pV", &vaf);
+
+	va_end(args);
+}
+EXPORT_SYMBOL(bt_err_ratelimited);
-- 
2.5.0

