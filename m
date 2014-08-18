Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/8] Bluetooth: Use hci_disconnect() for mgmt_disconnect_device()
Date: Mon, 18 Aug 2014 20:33:33 +0300
Message-Id: <1408383214-16366-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1408383214-16366-1-git-send-email-johan.hedberg@gmail.com>
References: <1408383214-16366-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There's no reason to custom build the HCI_Disconnect command in the
Disconnect Device mgmt command handler. This patch updates the code to
use hci_disconnect() instead.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d8c66663ade8..ab9521ae3c63 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2788,7 +2788,6 @@ static int disconnect(struct sock *sk, struct hci_dev *hdev, void *data,
 {
 	struct mgmt_cp_disconnect *cp = data;
 	struct mgmt_rp_disconnect rp;
-	struct hci_cp_disconnect dc;
 	struct pending_cmd *cmd;
 	struct hci_conn *conn;
 	int err;
@@ -2836,10 +2835,7 @@ static int disconnect(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
-	dc.handle = cpu_to_le16(conn->handle);
-	dc.reason = HCI_ERROR_REMOTE_USER_TERM;
-
-	err = hci_send_cmd(hdev, HCI_OP_DISCONNECT, sizeof(dc), &dc);
+	err = hci_disconnect(conn, HCI_ERROR_REMOTE_USER_TERM);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 
-- 
1.9.3

