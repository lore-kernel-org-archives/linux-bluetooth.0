Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ] mgmtops: Fix endianness conversion
Date: Fri,  1 Jun 2012 15:08:24 -0400
Message-Id: <1338577704-9431-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Flags field has 32-bit size.
---
 plugins/mgmtops.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 22fa329..cedfbd4 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1550,7 +1550,7 @@ static void mgmt_device_found(int sk, uint16_t index, void *buf, size_t len)
 	else
 		eir = ev->eir;
 
-	flags = btohs(ev->flags);
+	flags = btohl(ev->flags);
 
 	ba2str(&ev->addr.bdaddr, addr);
 	DBG("hci%u addr %s, rssi %d flags 0x%04x eir_len %u",
-- 
1.7.10.2

