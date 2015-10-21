Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/13] Bluetooth: Remove redundant (and possibly wrong) flag clearing
Date: Wed, 21 Oct 2015 18:03:07 +0300
Message-Id: <1445439791-2151-10-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1445439791-2151-1-git-send-email-johan.hedberg@gmail.com>
References: <1445439791-2151-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There's no need to clear the HCI_CONN_ENCRYPT_PEND flag in
smp_failure. In fact, this may cause the encryption tracking to get
out of sync as this has nothing to do with HCI activity.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 229d88eebf4e..94f9c4ca68f1 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -811,7 +811,6 @@ static void smp_failure(struct l2cap_conn *conn, u8 reason)
 		smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(reason),
 			     &reason);
 
-	clear_bit(HCI_CONN_ENCRYPT_PEND, &hcon->flags);
 	mgmt_auth_failed(hcon, HCI_ERROR_AUTH_FAILURE);
 
 	if (chan->data)
-- 
2.5.0

