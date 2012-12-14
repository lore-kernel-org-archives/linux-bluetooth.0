Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
Subject: [PATCH 08/12] Bluetooth: Enable on-the-fly update of broadcast data
Date: Fri, 14 Dec 2012 14:51:34 -0400
Message-Id: <1355511098-10190-9-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1355511098-10190-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1355511098-10190-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>

The broadcast data can be updated with no need to re-enable broadcaster
mode.

Signed-off-by: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
---
 net/bluetooth/mgmt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 608e81af..e910b11 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2738,6 +2738,9 @@ static int set_controller_data(struct sock *sk, struct hci_dev *hdev,
 
 	hci_broadcast_data_add(hdev, cp->flags, cp->type, cp->length, cp->data);
 
+	if (test_bit(HCI_BROADCASTER, &hdev->dev_flags))
+		__hci_update_ad(hdev);
+
 	hci_dev_unlock(hdev);
 
 	return cmd_complete(sk, hdev->id, MGMT_OP_SET_CONTROLLER_DATA, 0, NULL,
@@ -2748,6 +2751,7 @@ static int unset_controller_data(struct sock *sk, struct hci_dev *hdev,
 				 void *data, u16 len)
 {
 	struct mgmt_cp_unset_controller_data *cp = data;
+	int removed;
 
 	BT_DBG("%s type:0x%02x", hdev->name, cp->type);
 
@@ -2759,7 +2763,10 @@ static int unset_controller_data(struct sock *sk, struct hci_dev *hdev,
 				  MGMT_STATUS_NOT_POWERED);
 	}
 
-	hci_broadcast_data_remove(hdev, cp->type);
+	removed = hci_broadcast_data_remove(hdev, cp->type);
+
+	if (removed && test_bit(HCI_BROADCASTER, &hdev->dev_flags))
+		__hci_update_ad(hdev);
 
 	hci_dev_unlock(hdev);
 
-- 
1.8.0.2

