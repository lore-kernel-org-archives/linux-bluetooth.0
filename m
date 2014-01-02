Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <szymon.janc@tieto.com>, <johan.hedberg@gmail.com>,
	<luiz.dentz@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] shared: Fix build issue for Android
Date: Thu, 2 Jan 2014 23:31:32 +0100
Message-ID: <1388701892-13966-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

target thumb C: bluetoothd-snoop <=
external/bluetooth/bluez/android/../src/shared/btsnoop.c
external/bluetooth/bluez/android/../src/shared/btsnoop.c: In function
'btsnoop_create':
external/bluetooth/bluez/android/../src/shared/btsnoop.c:126:6: error:
'S_IRUSR' undeclared (first use in this function)
external/bluetooth/bluez/android/../src/shared/btsnoop.c:126:6: note:
each undeclared identifier is reported only once for each function it
appears in
external/bluetooth/bluez/android/../src/shared/btsnoop.c:126:16: error:
'S_IWUSR' undeclared (first use in this function)
external/bluetooth/bluez/android/../src/shared/btsnoop.c:126:26: error:
'S_IRGRP' undeclared (first use in this function)
external/bluetooth/bluez/android/../src/shared/btsnoop.c:126:36: error:
'S_IROTH' undeclared (first use in this function)

---
 src/shared/btsnoop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/shared/btsnoop.c b/src/shared/btsnoop.c
index 58c9f1d..61f7bfc 100644
--- a/src/shared/btsnoop.c
+++ b/src/shared/btsnoop.c
@@ -30,6 +30,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <arpa/inet.h>
+#include <sys/stat.h>
 
 #include "btsnoop.h"
 
-- 
1.8.4

