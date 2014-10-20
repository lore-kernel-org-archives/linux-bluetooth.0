Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 8/8] TODO: Update shared/gatt-server items.
Date: Mon, 20 Oct 2014 14:01:01 -0700
Message-Id: <1413838861-29956-9-git-send-email-armansito@chromium.org>
In-Reply-To: <1413838861-29956-1-git-send-email-armansito@chromium.org>
References: <1413838861-29956-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

shared/gatt-server has been introduced, so removed that item. Added new
items for remaining tasks.
---
 TODO | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/TODO b/TODO
index efaec11..b09b047 100644
--- a/TODO
+++ b/TODO
@@ -149,12 +149,43 @@ ATT/GATT (new shared stack)
   Priority: Medium
   Complexity: C2
 
-- Introduce shared/gatt-server, which combined with shared/gatt-db, can be used
-  as a GATT server implementation.
+- Implement GATT read and write procedures for shared/gatt-server. These map to
+  the following ATT protocol operations:
+
+      Read Request
+      Read Blob Request
+      Write Command
+      Write Request
+      Prepare Write Request
+      Execute Write Request
+
+  Priority: Medium
+  Complexity: C2
+
+- Implement server-initiated ATT protocol operations for shared/gatt-server:
+
+      Handle Value Notification
+      Handle Value Indication
 
   Priority: Medium
   Complexity: C2
 
+- Provide a tool for shared/gatt-server. This tool should demonstrate how a
+  shared/gatt-db can be used together with a shared/gatt-server to implement the
+  GATT server role. This should be written in a way so that it can be easily
+  used in conjunction with a remote instance of tools/btgatt-client (i.e. it
+  should listen for incoming connections, have similar verbose output, etc.)
+
+  Priority: Medium
+  Complexity: C2
+
+- Implement other low-priority ATT protocol operations for shared/gatt-server:
+
+      Read Multiple Request
+
+  Priority: Low
+  Complexity: C1
+
 - Implement the server portion of doc/gatt-api.txt using shared/gatt-server once
   it exists.
 
-- 
2.1.0.rc2.206.gedb03e5

