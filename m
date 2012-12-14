Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 06/13] alert: Append version to Alert interfaces
Date: Fri, 14 Dec 2012 11:13:00 +0200
Message-Id: <1355476387-2165-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355476387-2165-1-git-send-email-luiz.dentz@gmail.com>
References: <1355476387-2165-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 doc/alert-api.txt       | 4 ++--
 profiles/alert/server.c | 4 ++--
 src/bluetooth.conf      | 2 +-
 test/test-alert         | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/doc/alert-api.txt b/doc/alert-api.txt
index bcaaaf3..65c065e 100644
--- a/doc/alert-api.txt
+++ b/doc/alert-api.txt
@@ -19,7 +19,7 @@ Alert hierarchy
 ===============
 
 Service		org.bluez
-Interface	org.bluez.Alert
+Interface	org.bluez.Alert1
 Object path	/org/bluez
 
 Methods		void RegisterAlert(string category, object agent)
@@ -79,7 +79,7 @@ Alert Agent hierarchy
 =====================
 
 Service		org.bluez
-Interface	org.bluez.AlertAgent
+Interface	org.bluez.AlertAgent1
 Object path	freely definable
 
 Methods		void MuteOnce()
diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index 20eb5fc..2e8c452 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -63,8 +63,8 @@
 #define SUPP_UNREAD_ALERT_CAT_CHR_UUID	0x2A48
 
 #define ALERT_OBJECT_PATH		"/org/bluez"
-#define ALERT_INTERFACE			"org.bluez.Alert"
-#define ALERT_AGENT_INTERFACE		"org.bluez.AlertAgent"
+#define ALERT_INTERFACE			"org.bluez.Alert1"
+#define ALERT_AGENT_INTERFACE		"org.bluez.AlertAgent1"
 
 /* Maximum length for "Text String Information" */
 #define NEW_ALERT_MAX_INFO_SIZE		18
diff --git a/src/bluetooth.conf b/src/bluetooth.conf
index 5750f49..0e45935 100644
--- a/src/bluetooth.conf
+++ b/src/bluetooth.conf
@@ -16,7 +16,7 @@
     <allow send_interface="org.bluez.MediaPlayer1"/>
     <allow send_interface="org.bluez.Watcher"/>
     <allow send_interface="org.bluez.ThermometerWatcher1"/>
-    <allow send_interface="org.bluez.AlertAgent"/>
+    <allow send_interface="org.bluez.AlertAgent1"/>
     <allow send_interface="org.bluez.Profile1"/>
     <allow send_interface="org.bluez.HeartRateWatcher1"/>
     <allow send_interface="org.bluez.CyclingSpeedWatcher1"/>
diff --git a/test/test-alert b/test/test-alert
index 1e241a3..066e537 100755
--- a/test/test-alert
+++ b/test/test-alert
@@ -9,8 +9,8 @@ import sys
 import os
 
 BUS_NAME = 'org.bluez'
-ALERT_INTERFACE = 'org.bluez.Alert'
-ALERT_AGENT_INTERFACE = 'org.bluez.AlertAgent'
+ALERT_INTERFACE = 'org.bluez.Alert1'
+ALERT_AGENT_INTERFACE = 'org.bluez.AlertAgent1'
 BLUEZ_OBJECT_PATH = '/org/bluez'
 TEST_OBJECT_PATH = '/org/bluez/test'
 
-- 
1.7.11.7

