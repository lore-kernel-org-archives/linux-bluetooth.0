Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Avoid hard-coded IO capability values in SMP
Date: Wed, 10 Sep 2014 17:58:54 -0700
Message-Id: <1410397134-31492-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This is a trivial change to use a proper define for the NoInputNoOutput
IO capability instead of hard-coded values.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 3700dd8d9d0b..51fc7db2d84e 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -959,7 +959,7 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	memcpy(&smp->preq[1], req, sizeof(*req));
 	skb_pull(skb, sizeof(*req));
 
-	if (conn->hcon->io_capability == 0x03)
+	if (conn->hcon->io_capability == HCI_IO_NO_INPUT_OUTPUT)
 		sec_level = BT_SECURITY_MEDIUM;
 	else
 		sec_level = authreq_to_seclevel(auth);
@@ -1169,7 +1169,7 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	auth = rp->auth_req & AUTH_REQ_MASK;
 
-	if (hcon->io_capability == 0x03)
+	if (hcon->io_capability == HCI_IO_NO_INPUT_OUTPUT)
 		sec_level = BT_SECURITY_MEDIUM;
 	else
 		sec_level = authreq_to_seclevel(auth);
-- 
1.9.3

