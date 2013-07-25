Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] test: Fix ProximityMonitor1 interface name typo in test-proximity
Date: Thu, 25 Jul 2013 15:23:43 -0400
Message-Id: <1374780223-21677-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/test-proximity |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/test-proximity b/test/test-proximity
index 6b9b2b8..2f47824 100755
--- a/test/test-proximity
+++ b/test/test-proximity
@@ -15,7 +15,7 @@ from optparse import OptionParser, make_option
 import bluezutils
 
 BUS_NAME = 'org.bluez'
-PROXIMITY_MONITOR_INTERFACE = 'org.bluez.ProxymityMonitor1'
+PROXIMITY_MONITOR_INTERFACE = 'org.bluez.ProximityMonitor1'
 
 def properties_changed(interface, changed, invalidated):
 	if interface != PROXIMITY_MONITOR_INTERFACE:
-- 
1.7.9.5

