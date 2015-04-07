Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] core: Mention defaults for ReconnectUUIDs
Date: Tue,  7 Apr 2015 10:27:03 +0300
Message-Id: <1428391624-25864-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This documents the defaults used for ReconnectUUIDs.
---
 src/main.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/main.conf b/src/main.conf
index 884f68d..2e696ff 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -73,4 +73,4 @@
 # timeout). The policy plugin should contain a sane set of values by
 # default, but this list can be overridden here. By setting the list to
 # empty the reconnection feature gets disabled.
-#ReconnectUUIDs=
+#ReconnectUUIDs=00001112-0000-1000-8000-00805f9b34fb, 0000111f-0000-1000-8000-00805f9b34fb, 0000110a-0000-1000-8000-00805f9b34fb
-- 
2.1.0

