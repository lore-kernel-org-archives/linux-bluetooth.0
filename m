Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] monitor: Fix out of the tree build
Date: Thu, 21 Dec 2017 12:05:06 -0200
Message-Id: <20171221140506.21741-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When building outside the tree including uuid.h may not be found:

../monitor/packet.c:52:18: fatal error: uuid.h: No such file or directory
---
 monitor/packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index bd28ec4a5..b800a2d75 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -39,6 +39,7 @@
 #include <sys/socket.h>
 
 #include "lib/bluetooth.h"
+#include "lib/uuid.h"
 #include "lib/hci.h"
 #include "lib/hci_lib.h"
 
@@ -49,7 +50,6 @@
 #include "ll.h"
 #include "hwdb.h"
 #include "keys.h"
-#include "uuid.h"
 #include "l2cap.h"
 #include "control.h"
 #include "vendor.h"
-- 
2.13.6

