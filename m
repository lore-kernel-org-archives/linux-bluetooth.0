Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix check for connected state when pairing
Date: Wed, 30 Jul 2014 08:35:48 +0300
Message-Id: <1406698548-14240-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Both BT_CONNECTED and BT_CONFIG state mean that we have a baseband link
available. We should therefore check for either of these when pairing
and deciding whether to call hci_conn_security() directly.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5d18efcb8467..0b15b7618beb 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3213,7 +3213,7 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	conn->io_capability = cp->io_cap;
 	cmd->user_data = conn;
 
-	if (conn->state == BT_CONNECTED &&
+	if ((conn->state == BT_CONNECTED || conn->state == BT_CONFIG) &&
 	    hci_conn_security(conn, sec_level, auth_type, true))
 		pairing_complete(cmd, 0);
 
-- 
1.9.3

