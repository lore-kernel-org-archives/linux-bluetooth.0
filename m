Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 1/2] test: Add missing import in cyclingspeed
Date: Wed, 19 Mar 2014 12:34:32 +0100
Message-ID: <1395228873-32719-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/test-cyclingspeed | 1 +
 1 file changed, 1 insertion(+)

diff --git a/test/test-cyclingspeed b/test/test-cyclingspeed
index d49041f..4b8d841 100755
--- a/test/test-cyclingspeed
+++ b/test/test-cyclingspeed
@@ -15,6 +15,7 @@ try:
   from gi.repository import GObject
 except ImportError:
   import gobject as GObject
+import bluezutils
 
 BUS_NAME = 'org.bluez'
 CYCLINGSPEED_MANAGER_INTERFACE = 'org.bluez.CyclingSpeedManager1'
-- 
1.9.0

