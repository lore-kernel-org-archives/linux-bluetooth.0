Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/4] android: Add shortcommings section to README
Date: Fri, 20 Dec 2013 19:30:10 +0100
Message-Id: <1387564210-6102-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1387564210-6102-1-git-send-email-szymon.janc@tieto.com>
References: <1387564210-6102-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This sections lists unimplemented methods, callbacks or properties
with few words of comments why feature is missing.
---
 android/README | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/android/README b/android/README
index 68c3e9f..6d0e242 100644
--- a/android/README
+++ b/android/README
@@ -91,3 +91,40 @@ use provided android/system-emulator, which takes care of launching daemon
 automatically on HAL library initialization. To deinitialize HAL library and
 stop daemon type 'bluetooth cleanup'. Type 'help' for more information. Tab
 completion is also supported.
+
+===========================
+Implementation shortcomings
+===========================
+
+It is possible that some of HAL functionality is missing implementation due to
+reasons like feature feasibility or necessity for latest Android Framework.
+This sections provides list of such deficiencies. Note that HAL library is
+always expected to fully implement HAL API so missing implementation might
+happen only in daemon.
+
+HAL Bluetooth
+=============
+methods:
+dut_mode_send                      never called from Android Framework
+le_test_mode                       never called from Android Framework
+get_remote_service_record          never called from Android Framework
+
+callbacks:
+dut_mode_recv_cb
+le_test_mode_cb
+
+properties:
+BT_PROPERTY_SERVICE_RECORD         not supported for adapter and device, for
+                                   device this property is to be returned as
+                                   response to get_remote_service_record,
+                                   not sure what to return on get_property
+                                   calls (records of all services?)
+
+BT_PROPERTY_REMOTE_VERSION_INFO    information required by this property (LMP
+                                   information) are not accessible from mgmt
+                                   interface, also marking this property as
+                                   settable is probably a typo in HAL header
+
+Socket HAL
+==========
+Support only for BTSOCK_RFCOMM socket type.
-- 
1.8.3.2

