Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 1/5] Bluetooth: Add BT_WARN and bt_dev_warn logging macros
Date: Wed, 23 Sep 2015 18:18:07 +0200
Message-Id: <1443025091-1864-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1443025091-1864-1-git-send-email-frederic.danis@linux.intel.com>
References: <1443025091-1864-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add warning logging macros to bluetooth subsystem logs.

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 include/net/bluetooth/bluetooth.h |  5 +++++
 net/bluetooth/lib.c               | 16 ++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index f5ade85..c4defef 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -122,11 +122,14 @@ struct bt_voice {
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
 __printf(1, 2)
+void bt_warn(const char *fmt, ...);
+__printf(1, 2)
 void bt_err(const char *fmt, ...);
 __printf(1, 2)
 void bt_err_ratelimited(const char *fmt, ...);
 
 #define BT_INFO(fmt, ...)	bt_info(fmt "\n", ##__VA_ARGS__)
+#define BT_WARN(fmt, ...)	bt_warn(fmt "\n", ##__VA_ARGS__)
 #define BT_ERR(fmt, ...)	bt_err(fmt "\n", ##__VA_ARGS__)
 #define BT_DBG(fmt, ...)	pr_debug(fmt "\n", ##__VA_ARGS__)
 
@@ -134,6 +137,8 @@ void bt_err_ratelimited(const char *fmt, ...);
 
 #define bt_dev_info(hdev, fmt, ...)				\
 	BT_INFO("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
+#define bt_dev_warn(hdev, fmt, ...)				\
+	BT_WARN("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
 #define bt_dev_err(hdev, fmt, ...)				\
 	BT_ERR("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
 #define bt_dev_dbg(hdev, fmt, ...)				\
diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
index 8b4cdce..aa4cf64 100644
--- a/net/bluetooth/lib.c
+++ b/net/bluetooth/lib.c
@@ -151,6 +151,22 @@ void bt_info(const char *format, ...)
 }
 EXPORT_SYMBOL(bt_info);
 
+void bt_warn(const char *format, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, format);
+
+	vaf.fmt = format;
+	vaf.va = &args;
+
+	pr_warn("%pV", &vaf);
+
+	va_end(args);
+}
+EXPORT_SYMBOL(bt_warn);
+
 void bt_err(const char *format, ...)
 {
 	struct va_format vaf;
-- 
1.9.1

