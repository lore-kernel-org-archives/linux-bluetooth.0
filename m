Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 1/2] TODO: Add entry for runtime selection of drivers
Date: Tue, 13 Nov 2012 11:49:45 -0400
Message-Id: <1352821786-20230-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow to drop usage of symlinks to C files, which require
messing with CPPFLAGS so headers can be found by the preprocessor.

It also allows for easier testing, because it is not necessary to
rebuild BlueZ to test different drivers.
---
 TODO |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/TODO b/TODO
index ca14955..4f58423 100644
--- a/TODO
+++ b/TODO
@@ -36,6 +36,15 @@ General
   Priority: Low
   Complexity: C1
 
+- Remove usage of symlinks for drivers, such as profiles/input/suspend.c and
+  profiles/sap/sap.c. Instead, select drivers at runtime by using config
+  options or probing for running D-Bus services (using e.g.
+  g_dbus_add_service_watch()). Idea first mentioned on
+  http://thread.gmane.org/gmane.linux.bluez.kernel/30175/focus=30190.
+
+  Priority: Low
+  Complexity: C2
+
 BlueZ 5
 =======
 
-- 
1.7.9.5

