Return-Path: <cyrus@holtmann.org>
From: Vishal Agarwal <vishal.agarwal@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: <vishal.agarwal@stericsson.com>
Subject: [PATCH] Bluetooth: Fix sending HCI_Disconnect only after connection
Date: Mon, 11 Jun 2012 11:49:44 +0530
Message-ID: <1339395584-3223-1-git-send-email-vishal.agarwal@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HCI_Disconnet should only be sent after connection is established.
If connection is not yet established and hci_disconnect is called
then disconnection complete will be received with a handle which
does not exist and hence this event will be ignored.
But as mgmt.c will not receive this event, its variable for pending
command is not cleared.This will result in future Disconnect commands
for that BD Address to be blocked with error busy.

Signed-off-by: Vishal Agarwal <vishal.agarwal@stericsson.com>
---
 net/bluetooth/mgmt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 958f764..3a857bf 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1598,7 +1598,7 @@ static int disconnect(struct sock *sk, struct hci_dev *hdev, void *data,
 	else
 		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->addr.bdaddr);
 
-	if (!conn) {
+	if (!conn || conn->state == BT_OPEN || conn->state == BT_CLOSED) {
 		err = cmd_status(sk, hdev->id, MGMT_OP_DISCONNECT,
 				 MGMT_STATUS_NOT_CONNECTED);
 		goto failed;
-- 
1.7.0.4

