Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix rejecting SMP security request in slave role
Date: Tue,  5 Nov 2013 11:30:39 +0200
Message-Id: <1383643839-2788-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The SMP security request is for a slave role device to request the
master role device to initiate a pairing request. If we receive this
command while we're in the slave role we should reject it appropriately.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 85a2796cac61..4b07acb8293c 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -742,6 +742,9 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	BT_DBG("conn %p", conn);
 
+	if (!(conn->hcon->link_mode & HCI_LM_MASTER))
+		return SMP_CMD_NOTSUPP;
+
 	hcon->pending_sec_level = authreq_to_seclevel(rp->auth_req);
 
 	if (smp_ltk_encrypt(conn, hcon->pending_sec_level))
-- 
1.8.3.1

