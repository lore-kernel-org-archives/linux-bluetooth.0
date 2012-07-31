Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] btmgmt: Fix endianness conversion
Date: Tue, 31 Jul 2012 09:58:01 -0400
Message-Id: <1343743081-25474-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Flags field has 32-bit size. Same issue was fixed for mgmtops in
1801a4d45d74c29cebacaab79a07e9961300be41.
---
 tools/btmgmt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index b2d6c3c..c6d48d3 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -461,7 +461,7 @@ static int mgmt_device_found(int mgmt_sk, uint16_t index,
 		return -EINVAL;
 	}
 
-	flags = btohs(ev->flags);
+	flags = btohl(ev->flags);
 
 	eir_len = bt_get_le16(&ev->eir_len);
 	if (len != sizeof(*ev) + eir_len) {
-- 
1.7.9.5

