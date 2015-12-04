Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] btproxy: Simplify Bluetooth proxy
Date: Fri,  4 Dec 2015 14:45:45 +0200
Message-Id: <1449233145-16062-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

At the moment every time we use btproxy we have to down Bluetooth
device. This is very unhandy especially when connection to proxy ends
and other connections always fail. Add HCIDEVDOWN ioctl before binding
to user channel.
---
 tools/btproxy.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/btproxy.c b/tools/btproxy.c
index ee4dadd..02ae53d 100644
--- a/tools/btproxy.c
+++ b/tools/btproxy.c
@@ -39,6 +39,7 @@
 #include <termios.h>
 #include <sys/stat.h>
 #include <sys/socket.h>
+#include <sys/ioctl.h>
 #include <sys/un.h>
 
 #include <netdb.h>
@@ -50,6 +51,8 @@
 #include "monitor/bt.h"
 #include "h5.h"
 
+#define HCIDEVDOWN	_IOW('H', 202, int)
+
 #define HCI_BREDR	0x00
 #define HCI_AMP		0x01
 
@@ -576,6 +579,12 @@ static int open_channel(uint16_t index)
 		return -1;
 	}
 
+	if (ioctl(fd, HCIDEVDOWN, hci_index) < 0) {
+		close(fd);
+		perror("Failed to down hci device");
+		return -1;
+	}
+
 	memset(&addr, 0, sizeof(addr));
 	addr.hci_family = AF_BLUETOOTH;
 	addr.hci_dev = index;
-- 
2.5.0

