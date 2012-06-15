Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH] TODO: add BlueZ 5 tasks
Date: Fri, 15 Jun 2012 03:38:59 -0300
Message-Id: <1339742339-15816-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 TODO |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/TODO b/TODO
index 17e9848..355a344 100644
--- a/TODO
+++ b/TODO
@@ -30,6 +30,39 @@ General
   Priority: Low
   Complexity: C1
 
+
+BlueZ 5
+==========
+
+- Make mgmtops part of bluetooth core. mgmt will be the only way to communicate
+  with the kernel in BlueZ so a plugin is not needed anymore.
+
+  Priority: High
+  Complexity: C2
+
+- Move BlueZ to use standard DBus properties and object manager
+
+  Priority: High
+  Complexity: C2
+
+- Reorganize source tree according to RFC sent to linux-bluetooth (Subject:
+  [RFC] Reorganizing the BlueZ source tree)
+
+  Priority: High
+  Complexity: C1
+
+- Remove deprecated DBus signal from audio code. New ones need to be added to
+  replace the deprecated ones.
+
+  Priority: High
+  Complexity: C2
+
+- Remove deprecated code/DBus methods.
+
+  Priority: High
+  Complexity: C2
+
+
 Low Energy
 ==========
 
-- 
1.7.10.2

