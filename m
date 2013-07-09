Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] core: Use proper header for S_IRUSR/S_IWUSR
Date: Tue, 9 Jul 2013 09:40:00 +0200
Message-ID: <1373355600-12674-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to open() manual one should include <sys/stat.h>.
This fix build with bionic library:

target thumb C: libbluetoothd <= external/bluetooth/bluez/src/attrib-server.c
external/bluetooth/bluez/src/attrib-server.c: In function 'write_value':
external/bluetooth/bluez/src/attrib-server.c:922:26: error: 'S_IRUSR'
	 undeclared (first use in this function)
external/bluetooth/bluez/src/attrib-server.c:922:26: note: each undeclared
	identifier is reported only once for each function it appears in
external/bluetooth/bluez/src/attrib-server.c:922:36: error: 'S_IWUSR'
	undeclared (first use in this function)
---
 src/attrib-server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index e5e3030..93f03b3 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -32,7 +32,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <glib.h>
-#include <sys/file.h>
+#include <sys/stat.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
-- 
1.8.3.2

