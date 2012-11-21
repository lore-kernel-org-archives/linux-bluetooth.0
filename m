Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ] TODO: Add entry about built-in profiles connection management by core
Date: Wed, 21 Nov 2012 17:12:42 +0200
Message-Id: <1353510762-28123-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 TODO | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/TODO b/TODO
index 9f6655e..9c0b751 100644
--- a/TODO
+++ b/TODO
@@ -42,6 +42,15 @@ General
   g_dbus_add_service_watch()). Idea first mentioned on
   http://thread.gmane.org/gmane.linux.bluez.kernel/30175/focus=30190.
 
+- Reuse connection handling code of src/profile.c also for built-in profiles
+  so plugins would only need to register their btd_profile and the core takes
+  care of the rest including listen to the right channel and manages the sdp
+  record. Once btd_profile manages the connection it can also notify about
+  their state, this probably remove the need of having callbacks to
+  .connect/.disconnect since their state can be tracked, it also enables any
+  plugin to track any profile state change which can be useful for e.g.
+  a connection policy plugin in case one is needed.
+
   Priority: Low
   Complexity: C2
 
-- 
1.7.11.7

