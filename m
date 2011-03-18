Return-Path: <cyrus@holtmann.org>
From: luiz.dentz@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Add action commands support to TODO
Date: Fri, 18 Mar 2011 13:52:46 -0300
Message-Id: <1300467167-32442-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

---
 TODO |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)
 create mode 100644 TODO

diff --git a/TODO b/TODO
new file mode 100644
index 0000000..d2bbd1a
--- /dev/null
+++ b/TODO
@@ -0,0 +1,26 @@
+Background
+==========
+
+- Priority scale: High, Medium and Low
+
+- Complexity scale: C1, C2, C4 and C8.  The complexity scale is exponential,
+  with complexity 1 being the lowest complexity.  Complexity is a function
+  of both task 'complexity' and task 'scope'.
+
+  The general rule of thumb is that a complexity 1 task should take 1-2 weeks
+  for a person very familiar with BlueZ codebase.  Higher complexity tasks
+  require more time and have higher uncertainty.
+
+  Higher complexity tasks should be refined into several lower complexity tasks
+  once the task is better understood.
+
+General
+==========
+
+- OBEX Actions are used to perform actions not primarily defined as OBEX
+  commands. This actions include, for example, moving, copying and setting the
+  permissions of objects. OBEX actions would be very useful when implementing
+  virtual filesystems over OBEX.
+
+  Priority: Medium
+  Complexity: C2
-- 
1.7.1

