Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 12/12] TODO: Update GAttrib related items.
Date: Mon, 17 Nov 2014 11:22:18 -0800
Message-Id: <1416252138-17477-13-git-send-email-armansito@chromium.org>
In-Reply-To: <1416252138-17477-1-git-send-email-armansito@chromium.org>
References: <1416252138-17477-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Updated TODOs related to the daemon transition from attrib/ to
shared/gatt.
---
 TODO | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/TODO b/TODO
index fec0fa2..2019e3c 100644
--- a/TODO
+++ b/TODO
@@ -141,16 +141,16 @@ ATT/GATT (new shared stack)
   Priority: Low
   Complexity: C4
 
-- Move all daemon plugins and profiles that are GATT based to use
-  shared/gatt-client instead of attrib/*. This is a complicated task that
-  potentially needs a new plugin/profile probing interface and a lot of
-  rewriting that can cause regressions in existing functionality. The biggest
-  challenge here is that an instance of bt_att (shared/att) and GAttrib
-  (attrib/gattrib) cannot coexist on the same file descriptor, since they will
-  cause ATT protocol violations by breaking the sequential request-response
-  structure. A special shared/gatt-client-gattrib implementation may be
-  necessary to move each profile/plugin to the new API before actually switching
-  to the shared/att based implementation.
+- Convert all GATT client-role based profiles to use shared/gatt-client. These
+  profiles are:
+
+    cyclingspeed
+    deviceinfo
+    heartrate
+    input/hog
+    proximity (also has a server component)
+    scanparam
+    thermometer
 
   Priority: Medium
   Complexity: C4
@@ -183,6 +183,11 @@ ATT/GATT (new shared stack)
   Priority: Low
   Complexity: C1
 
+- Replace attrib-server with shared/gatt-db and shared/gatt-server.
+
+  Priority: Medium
+  Complexity: C2
+
 - Implement the server portion of doc/gatt-api.txt using shared/gatt-server once
   it exists.
 
-- 
2.1.0.rc2.206.gedb03e5

