Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH BlueZ v2] test: Switch to Python3
Date: Mon, 28 May 2018 13:37:08 +0200
Message-Id: <1527507428-5257-1-git-send-email-krzk@kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Python2 will be maintained till end of 2019.  Switch to Python3 by
replacing iteritems() with items() to fix error when runnig test-nap:

	AttributeError: 'dbus.Dictionary' object has no attribute 'iteritems'

---

Changes since v1:
1. Fix also find_device_in_objects().
---
 test/bluezutils.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/bluezutils.py b/test/bluezutils.py
index de08cbdcb712..cd8964082450 100644
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
@@ -35,7 +35,7 @@ def find_device_in_objects(objects, device_address, adapter_pattern=None):
 	if adapter_pattern:
 		adapter = find_adapter_in_objects(objects, adapter_pattern)
 		path_prefix = adapter.object_path
-	for path, ifaces in objects.iteritems():
+	for path, ifaces in objects.items():
 		device = ifaces.get(DEVICE_INTERFACE)
 		if device is None:
 			continue
-- 
2.7.4

