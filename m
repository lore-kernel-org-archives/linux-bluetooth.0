Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH RFC BlueZ 11/16] Phone Alert: add method for reading Alert Status
Date: Mon, 26 Sep 2011 15:13:37 -0400
Message-Id: <1317064422-1654-12-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1317064422-1654-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1317064422-1654-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

---
 test/phone-agent.py |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/test/phone-agent.py b/test/phone-agent.py
index 2d9cf2d..927fdb1 100755
--- a/test/phone-agent.py
+++ b/test/phone-agent.py
@@ -8,10 +8,13 @@ import gobject
 StateIncoming = 0
 StateEnded = 6
 
+ALERT_RINGER_STATE = 1 << 0
+
 on_call = False
 saved_ringer_setting = None
 ringer_setting = None
 silent_mode = False
+alert_status = 0x00
 
 def set_ringer(value):
     global ringer_setting
@@ -21,6 +24,14 @@ def set_ringer(value):
 def get_ringer():
     return profiled.get_value("", "ringing.alert.type", dbus_interface="com.nokia.profiled")
 
+def set_alert_status():
+    global ringer_setting, alert_status, on_call
+
+    if on_call and ringer_setting != "Silent":
+        alert_status |= ALERT_RINGER_STATE
+    else:
+        alert_status &= ~ALERT_RINGER_STATE
+
 def silence_ringer():
     print "silence_ringer()"
     global saved_ringer_setting, ringer_setting
@@ -119,6 +130,15 @@ class PhoneAgent(dbus.service.Object):
         global ringer_setting
         return ringer_setting
 
+    @dbus.service.method("org.bluez.PhoneAgent",
+            in_signature="", out_signature="y")
+    def GetAlertStatus(self):
+        print "GetAlertStatus()"
+
+        global alert_status
+        return alert_status
+
+
 if __name__ == "__main__":
     dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
 
@@ -139,6 +159,8 @@ if __name__ == "__main__":
             dbus_interface="com.nokia.profiled")
     ringer_setting = get_ringer()
 
+    set_alert_status()
+
     phone = dbus.Interface(system_bus.get_object("org.bluez",
             "/test/phonealert"), "org.bluez.PhoneAlert")
 
-- 
1.7.0.4

