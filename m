Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Use kzalloc instead of kmalloc for pending mgmt commands
Date: Sat, 28 Jun 2014 17:54:05 +0300
Message-Id: <1403967247-15728-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

By using kzalloc we ensure that there are no struct members, such as the
user_data pointer, left uninitialized.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d542f8af6a5d..03fa50d1ff05 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -984,7 +984,7 @@ static struct pending_cmd *mgmt_pending_add(struct sock *sk, u16 opcode,
 {
 	struct pending_cmd *cmd;
 
-	cmd = kmalloc(sizeof(*cmd), GFP_KERNEL);
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
 	if (!cmd)
 		return NULL;
 
-- 
1.9.3

