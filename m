Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Update management interface revision
Date: Thu,  6 Sep 2012 18:39:27 +0300
Message-Id: <1346945967-19424-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1346945967-19424-1-git-send-email-johan.hedberg@gmail.com>
References: <1346945967-19424-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

For each kernel release where commands or events are added to the
management interface, the revision field should be increment by one.

The increment should only happen once per kernel release and not
for every command/event that gets added. The revision value is for
informational purposes only, but this simple policy would make any
future debugging a lot simple.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 8e1ab59..8934343 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -35,7 +35,7 @@
 bool enable_hs;
 
 #define MGMT_VERSION	1
-#define MGMT_REVISION	1
+#define MGMT_REVISION	2
 
 static const u16 mgmt_commands[] = {
 	MGMT_OP_READ_INDEX_LIST,
-- 
1.7.10.4

