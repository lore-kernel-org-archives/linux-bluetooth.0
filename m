Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Check for force_lesc_support when enabling SMP over BR/EDR
Date: Sat,  6 Dec 2014 00:35:45 +0100
Message-Id: <1417822545-92322-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The SMP over BR/EDR support for cross-transport pairing should also be
enabled when the debugfs setting force_lesc_support has been enabled.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a8da7ea9c2c0..cc518eb48dc8 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6967,8 +6967,9 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
 	    test_bit(HCI_HS_ENABLED, &hcon->hdev->dev_flags))
 		conn->local_fixed_chan |= L2CAP_FC_A2MP;
 
-	if (bredr_sc_enabled(hcon->hdev) &&
-	    test_bit(HCI_LE_ENABLED, &hcon->hdev->dev_flags))
+	if (test_bit(HCI_LE_ENABLED, &hcon->hdev->dev_flags) &&
+	    (bredr_sc_enabled(hcon->hdev) ||
+	     test_bit(HCI_FORCE_LESC, &hcon->hdev->dbg_flags)))
 		conn->local_fixed_chan |= L2CAP_FC_SMP_BREDR;
 
 	mutex_init(&conn->ident_lock);
-- 
1.9.3

