Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 1/5] Bluetooth: Add BT_WARN and bt_dev_warn logging macros
Date: Tue, 15 Sep 2015 10:31:04 +0200
Message-Id: <1442305868-6203-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1442305868-6203-1-git-send-email-frederic.danis@linux.intel.com>
References: <1442305868-6203-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add warning logging macros to bluetooth subsystem logs.

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 include/net/bluetooth/bluetooth.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index fcf2ae7..27a3f16 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -125,11 +125,14 @@ __printf(1, 2)
 void bt_err(const char *fmt, ...);
 
 #define BT_INFO(fmt, ...)	bt_info(fmt "\n", ##__VA_ARGS__)
+#define BT_WARN(fmt, ...)	pr_warn(fmt "\n", ##__VA_ARGS__)
 #define BT_ERR(fmt, ...)	bt_err(fmt "\n", ##__VA_ARGS__)
 #define BT_DBG(fmt, ...)	pr_debug(fmt "\n", ##__VA_ARGS__)
 
 #define bt_dev_info(hdev, fmt, ...)				\
 	BT_INFO("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
+#define bt_dev_warn(hdev, fmt, ...)				\
+	BT_WARN("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
 #define bt_dev_err(hdev, fmt, ...)				\
 	BT_ERR("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
 #define bt_dev_dbg(hdev, fmt, ...)				\
-- 
1.9.1

