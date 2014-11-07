Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 11/11] TODO: Update shared/gatt-server items.
Date: Fri,  7 Nov 2014 12:41:59 -0800
Message-Id: <1415392919-17572-12-git-send-email-armansito@chromium.org>
In-Reply-To: <1415392919-17572-1-git-send-email-armansito@chromium.org>
References: <1415392919-17572-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

shared/gatt-server has been introduced, so removed that item. Added new
items for remaining tasks.
---
 TODO | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/TODO b/TODO
index b5a9612..98f5885 100644
--- a/TODO
+++ b/TODO
@@ -155,12 +155,28 @@ ATT/GATT (new shared stack)
   Priority: Medium
   Complexity: C2
 
-- Introduce shared/gatt-server, which combined with shared/gatt-db, can be used
-  as a GATT server implementation.
+- Introduce a way for shared/gatt-server to check security permissions on the
+  current connection through bt_att.
 
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

