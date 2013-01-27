Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2 v2] Bluetooth: Increment Management interface revision
Date: Sun, 27 Jan 2013 08:32:01 -0600
Message-Id: <1359297121-9022-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1359297121-9022-1-git-send-email-johan.hedberg@gmail.com>
References: <1359297121-9022-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch increments the management interface revision due to the
various fixes, improvements and other changes that have gone in lately.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ae7585d..3bd4c41 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -35,7 +35,7 @@
 bool enable_hs;
 
 #define MGMT_VERSION	1
-#define MGMT_REVISION	2
+#define MGMT_REVISION	3
 
 static const u16 mgmt_commands[] = {
 	MGMT_OP_READ_INDEX_LIST,
-- 
1.7.10.4

