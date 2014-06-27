Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/6] Bluetooth: Fix missing check for SMP session in smp_user_confirm_reply
Date: Fri, 27 Jun 2014 14:23:06 +0300
Message-Id: <1403868187-19396-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1403868187-19396-1-git-send-email-johan.hedberg@gmail.com>
References: <1403868187-19396-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The smp_user_confirm_reply() function is called whenever user space
sends a user confirmation reply mgmt command. In case of a misbehaving
user space, or if the SMP session was removed by the time the command
comes it is important that we return an appropriate error and do not try
to access the non-existent SMP context. This patch adds the appropriate
check for the HCI_CONN_LE_SMP_PEND flag before proceeding further.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 2566a3e43bb5..641ce8b69d2a 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -638,7 +638,7 @@ int smp_user_confirm_reply(struct hci_conn *hcon, u16 mgmt_op, __le32 passkey)
 
 	BT_DBG("");
 
-	if (!conn)
+	if (!conn || !test_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags))
 		return -ENOTCONN;
 
 	smp = conn->smp_chan;
-- 
1.9.3

