Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH v2 3/5] android: Remove not needed adapter parameter from bt_adapter_ready
Date: Thu, 24 Oct 2013 11:54:22 +0200
Message-ID: <1382608464-10389-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382608464-10389-1-git-send-email-szymon.janc@tieto.com>
References: <1382608464-10389-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@gmail.com>

There is no need to pass adapter pointer in bt_adapter_ready callback
as there is only one present.
---
 android/adapter.c | 6 +++---
 android/adapter.h | 4 +---
 android/main.c    | 2 +-
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index 79cfcfd..aee9cf4 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -201,11 +201,11 @@ static void load_link_keys_complete(uint8_t status, uint16_t length,
 	DBG("status %u", status);
 
 	default_adapter = adapter;
-	adapter->ready(adapter, 0);
+	adapter->ready(0);
 	return;
 
 failed:
-	adapter->ready(NULL, err);
+	adapter->ready(err);
 }
 
 static void load_link_keys(struct bt_adapter *adapter, GSList *keys)
@@ -274,7 +274,7 @@ static void read_info_complete(uint8_t status, uint16_t length, const void *para
 	return;
 
 failed:
-	adapter->ready(NULL, err);
+	adapter->ready(err);
 }
 
 void bt_adapter_init(uint16_t index, struct mgmt *mgmt_if,
diff --git a/android/adapter.h b/android/adapter.h
index 236f10a..2afc67a 100644
--- a/android/adapter.h
+++ b/android/adapter.h
@@ -28,9 +28,7 @@
 
 #include "lib/bluetooth.h"
 
-struct bt_adapter;
-
-typedef void (*bt_adapter_ready)(struct bt_adapter *adapter, int err);
+typedef void (*bt_adapter_ready)(int err);
 
 void bt_adapter_init(uint16_t index, struct mgmt *mgmt_if,
 							bt_adapter_ready cb);
diff --git a/android/main.c b/android/main.c
index 740b532..50b5901 100644
--- a/android/main.c
+++ b/android/main.c
@@ -392,7 +392,7 @@ static GOptionEntry options[] = {
 	{ NULL }
 };
 
-static void adapter_ready(struct bt_adapter *adapter, int err)
+static void adapter_ready(int err)
 {
 	if (err) {
 		error("Adapter initialization failed: %s", strerror(err));
-- 
1.8.4

