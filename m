Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ] TODO: Added more GATT related items
Date: Wed, 18 Feb 2015 10:25:57 -0800
Message-Id: <1424283957-25931-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added TODO items for reworking all GATT-based plugins and removing
src/attrib-server.c.
---
 TODO | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/TODO b/TODO
index db80b95..dce17f3 100644
--- a/TODO
+++ b/TODO
@@ -141,14 +141,37 @@ ATT/GATT (new shared stack)
   Priority: Medium
   Complexity: C4
 
-- Move all daemon plugins and profiles that are GATT based to use
-  shared/gatt-client instead of attrib/*. This is a complicated task that
-  potentially needs a new plugin/profile probing interface and a lot of
-  rewriting that can cause regressions in existing functionality.
+- Rewrite the core daemon plugins and profiles that are GATT based to use
+  shared/gatt instead of attrib/*. These are:
+
+     gatt-example
+     deviceinfo
+     input/hog
+     scanparam
+
+  Priority: Medium
+  Complexity: C2
+
+- Move non-core daemon plugins out of bluetoothd and into external apps, as all
+  such profiles can be written over the new D-Bus API. These are:
+
+     alert
+     cyclingspeed
+     heartrate
+     proximity
+     thermometer
+     time
+
+  At least for heartrate, provide an example in C and in Python.
 
   Priority: Medium
   Complexity: C4
 
+- Remove src/attrib-server, once nothing depends on it.
+
+  Priority: Medium
+  Complexity: C2
+
 - Introduce a way for shared/gatt-server to check security permissions on the
   current connection through bt_att.
 
-- 
2.2.0.rc0.207.ga3a616c

