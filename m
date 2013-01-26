Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Increment Management interface revision
Date: Sat, 26 Jan 2013 16:33:50 -0600
Message-Id: <1359239630-3579-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1359239630-3579-1-git-send-email-johan.hedberg@gmail.com>
References: <1359239630-3579-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The fixing of several mgmt issues, such as the correct handling of 32
and 128 bit UUIDs means that it is now safe for user space to send such
commands. However, user space needs a way to detect that it is safe, so
increment the mgmt revision so that it can be checked against.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f6ef8ff..8e69d89 100644
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

