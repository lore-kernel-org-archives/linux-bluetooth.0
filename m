Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>, johan.hedberg@gmail.com
Subject: [PATCH BlueZ] test: Fix syntax in bluezutils.py
Date: Thu,  6 Dec 2012 17:13:00 -0300
Message-Id: <1354824780-21903-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Frédéric Danis <frederic.danis@linux.intel.com>

Traceback (most recent call last):
  File "./simple-agent", line 12, in <module>
    import bluezutils
  File "/home/fdanis/src/bluez/test/bluezutils.py", line 22
    if not pattern or pattern == adapter["Address"] or
                                                     ^
SyntaxError: invalid syntax
---
 test/bluezutils.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/bluezutils.py b/test/bluezutils.py
index d0c4773..de08cbd 100644
--- a/test/bluezutils.py
+++ b/test/bluezutils.py
@@ -19,8 +19,8 @@ def find_adapter_in_objects(objects, pattern=None):
 		adapter = ifaces.get(ADAPTER_INTERFACE)
 		if adapter is None:
 			continue
-		if not pattern or pattern == adapter["Address"] or
-							path.endswith(pattern)):
+		if not pattern or pattern == adapter["Address"] or \
+							path.endswith(pattern):
 			obj = bus.get_object(SERVICE_NAME, path)
 			return dbus.Interface(obj, ADAPTER_INTERFACE)
 	raise Exception("Bluetooth adapter not found")
-- 
1.8.0.1

