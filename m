Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/5] android: Update Android system headers to 5.1 API
Date: Wed, 11 Mar 2015 15:41:20 +0100
Message-Id: <1426084883-10291-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1426084883-10291-1-git-send-email-szymon.janc@tieto.com>
References: <1426084883-10291-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Android headers are used for Linux host build.
---
 android/Makefile.am               | 2 +-
 android/hardware/bt_gatt_server.h | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/android/Makefile.am b/android/Makefile.am
index 676daab..7eb6440 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -1,6 +1,6 @@
 if ANDROID
 
-AM_CFLAGS += -DANDROID_VERSION=0x050000
+AM_CFLAGS += -DANDROID_VERSION=0x050100
 
 android_plugindir = $(abs_top_srcdir)/android/.libs
 
diff --git a/android/hardware/bt_gatt_server.h b/android/hardware/bt_gatt_server.h
index 2b1de27..0d6cc1e 100644
--- a/android/hardware/bt_gatt_server.h
+++ b/android/hardware/bt_gatt_server.h
@@ -117,6 +117,9 @@ typedef void (*indication_sent_callback)(int conn_id, int status);
  */
 typedef void (*congestion_callback)(int conn_id, bool congested);
 
+/** Callback invoked when the MTU for a given connection changes */
+typedef void (*mtu_changed_callback)(int conn_id, int mtu);
+
 typedef struct {
     register_server_callback        register_server_cb;
     connection_callback             connection_cb;
@@ -133,6 +136,7 @@ typedef struct {
     response_confirmation_callback  response_confirmation_cb;
     indication_sent_callback        indication_sent_cb;
     congestion_callback             congestion_cb;
+    mtu_changed_callback            mtu_changed_cb;
 } btgatt_server_callbacks_t;
 
 /** Represents the standard BT-GATT server interface. */
-- 
1.9.3

