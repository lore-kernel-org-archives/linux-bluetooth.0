Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Oct 2010 18:16:52 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@linux-foundation.org>, Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH -next] bluetooth: fix hidp kconfig dependency warning
Message-Id: <20101013181652.7ddf481e.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix kconfig dependency warning to satisfy dependencies:

warning: (BT_HIDP && NET && BT && BT_L2CAP && INPUT || USB_HID && HID_SUPPORT && USB && INPUT) selects HID which has unmet direct dependencies (HID_SUPPORT && INPUT)

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 net/bluetooth/hidp/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20101013.orig/net/bluetooth/hidp/Kconfig
+++ linux-next-20101013/net/bluetooth/hidp/Kconfig
@@ -1,6 +1,6 @@
 config BT_HIDP
 	tristate "HIDP protocol support"
-	depends on BT && BT_L2CAP && INPUT
+	depends on BT && BT_L2CAP && INPUT && HID_SUPPORT
 	select HID
 	help
 	  HIDP (Human Interface Device Protocol) is a transport layer
