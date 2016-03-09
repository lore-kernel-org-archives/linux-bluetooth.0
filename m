Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Increment management interface revision
Date: Wed,  9 Mar 2016 17:52:24 +0200
Message-Id: <1457538744-3445-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Increment the mgmt revision due to the recently added limited
privacy mode.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 2ca355519d79..c856fb65812c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -38,7 +38,7 @@
 #include "mgmt_util.h"
 
 #define MGMT_VERSION	1
-#define MGMT_REVISION	11
+#define MGMT_REVISION	12
 
 static const u16 mgmt_commands[] = {
 	MGMT_OP_READ_INDEX_LIST,
-- 
2.5.0

