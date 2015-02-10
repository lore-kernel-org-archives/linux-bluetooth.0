Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] TODO: Add tasks for GATT client examples
Date: Tue, 10 Feb 2015 17:06:56 +0200
Message-Id: <1423580817-16986-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 TODO | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/TODO b/TODO
index ca3779b..62b33a0 100644
--- a/TODO
+++ b/TODO
@@ -113,6 +113,16 @@ ATT/GATT (new shared stack)
   Priority: High
   Complexity: C4
 
+- Write an example using client D-Bus API using C.
+
+  Priority: High
+  Complexity: C2
+
+- Write an example using client D-Bus API using python.
+
+  Priority: High
+  Complexity: C2
+
 - Define packed structs for ATT protocol PDUs in shared/att-types to improve
   readability. We should probably do this once there are extensive unit tests
   for gatt-client/gatt-server so that we don't accidentally break working code.
-- 
2.1.0

