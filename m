Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH v2 BlueZ] monitor: Fix endianness conversion
Date: Mon, 30 Jul 2012 14:15:42 -0400
Message-Id: <1343672142-18834-1-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1343672005-18528-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1343672005-18528-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Flags field has 32-bit size. Same issue was fixed for mgmtops in
1801a4d45d74c29cebacaab79a07e9961300be41.
---

Fix subject: mgmtops -> monitor

 monitor/control.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/control.c b/monitor/control.c
index 159ba9d..54b249d 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -210,7 +210,7 @@ static void mgmt_device_connected(uint16_t len, const void *buf)
 		return;
 	}
 
-	flags = btohs(ev->flags);
+	flags = btohl(ev->flags);
 	ba2str(&ev->addr.bdaddr, str);
 
 	printf("@ Device Connected: %s (%d) flags 0x%4.4x\n",
-- 
1.7.9.5

