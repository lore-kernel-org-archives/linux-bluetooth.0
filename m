Return-Path: <cyrus@holtmann.org>
From: "Mutharaju, Prasanna (P.)" <mkarthi3@visteon.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>, "gustavo@padovan.org"
	<gustavo@padovan.org>, "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] bluetooth: btuart_cs: remove obsolete header
Date: Wed, 30 Sep 2015 12:27:46 +0000
Message-ID: <20150930122722.GA5186@jci-VirtualBox>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

From: Prasanna Karthik <mkarthi3@visteon.com>

Use <linux/io.h> instead of <asm/io.h>, fixes checkpatch
Warning;

Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
---
 drivers/bluetooth/btuart_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btuart_cs.c b/drivers/bluetooth/btuart_cs.c
index abb4d21..bc73557 100644
--- a/drivers/bluetooth/btuart_cs.c
+++ b/drivers/bluetooth/btuart_cs.c
@@ -38,7 +38,7 @@
 #include <linux/serial.h>
 #include <linux/serial_reg.h>
 #include <linux/bitops.h>
-#include <asm/io.h>
+#include <linux/io.h>
=20
 #include <pcmcia/cistpl.h>
 #include <pcmcia/ciscode.h>
--=20
1.9.1
