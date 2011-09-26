Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [PATCH RFC BlueZ 15/16] Phone Alert: Remove MuteOnce operation from phone-agent
Date: Mon, 26 Sep 2011 15:13:41 -0400
Message-Id: <1317064422-1654-16-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1317064422-1654-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1317064422-1654-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

---
 test/phone-agent.py |   22 ----------------------
 1 files changed, 0 insertions(+), 22 deletions(-)

diff --git a/test/phone-agent.py b/test/phone-agent.py
index 04a742b..372f832 100755
--- a/test/phone-agent.py
+++ b/test/phone-agent.py
@@ -86,28 +86,6 @@ def profile_changed(*args, **kwargs):
 class PhoneAgent(dbus.service.Object):
     @dbus.service.method("org.bluez.PhoneAgent",
             in_signature="", out_signature="")
-    def MuteOnce(self):
-        print "MuteOnce()"
-
-        global silent_mode
-        if silent_mode:
-            print "In Silent mode"
-            return
-
-        global on_call
-        if not on_call:
-            print "No active call"
-            return
-
-        global ringer_setting
-        if ringer_setting == "Silent":
-            print "Ringer already silent"
-            return
-
-        silence_ringer()
-
-    @dbus.service.method("org.bluez.PhoneAgent",
-            in_signature="", out_signature="")
     def SetSilentMode(self):
         print "SetSilentMode()"
 
-- 
1.7.0.4

