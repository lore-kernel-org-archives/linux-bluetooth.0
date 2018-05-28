Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH BlueZ] test: Switch to Python3
Date: Mon, 28 May 2018 13:16:05 +0200
Message-Id: <1527506165-8177-1-git-send-email-krzk@kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Python2 will be maintained till end of 2019.  Switch to Python3 by
replacing iteritems() with items() to fix error when runnig test-nap:

	AttributeError: 'dbus.Dictionary' object has no attribute 'iteritems'
---
 test/bluezutils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/bluezutils.py b/test/bluezutils.py
index de08cbdcb712..afbadfecd214 100644
--- a/test/bluezutils.py
+++ b/test/bluezutils.py
@@ -15,7 +15,7 @@ def find_adapter(pattern=None):
 
 def find_adapter_in_objects(objects, pattern=None):
 	bus = dbus.SystemBus()
-	for path, ifaces in objects.iteritems():
+	for path, ifaces in objects.items():
 		adapter = ifaces.get(ADAPTER_INTERFACE)
 		if adapter is None:
 			continue
-- 
2.7.4

