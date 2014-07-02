Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 04/10] Bluetooth: Remove only enabled entries with Remove Device command
Date: Wed,  2 Jul 2014 17:37:28 +0300
Message-Id: <1404311854-12233-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404311854-12233-1-git-send-email-johan.hedberg@gmail.com>
References: <1404311854-12233-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The Remove Device mgmt command is supposed to undo what the Add Device
command does. An entry added by Add Device cannot have the
HCI_AUTO_CONN_DISABLED auto_connect value, so we should treat this as an
invalid entry to remove. This patch adds the necessary pieces to the
Remove Device command handler so that it only removes entries which were
added by Add Device.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f7217f9eda03..574dd9f7c39e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5079,6 +5079,7 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 	hci_dev_lock(hdev);
 
 	if (bacmp(&cp->addr.bdaddr, BDADDR_ANY)) {
+		struct hci_conn_params *params;
 		u8 addr_type;
 
 		if (!bdaddr_type_is_le(cp->addr.type)) {
@@ -5093,7 +5094,25 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 		else
 			addr_type = ADDR_LE_DEV_RANDOM;
 
-		hci_conn_params_del(hdev, &cp->addr.bdaddr, addr_type);
+		params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr,
+						addr_type);
+		if (!params) {
+			err = cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_DEVICE,
+					   MGMT_STATUS_INVALID_PARAMS,
+					   &cp->addr, sizeof(cp->addr));
+			goto unlock;
+		}
+
+		if (params->auto_connect == HCI_AUTO_CONN_DISABLED) {
+			err = cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_DEVICE,
+					   MGMT_STATUS_INVALID_PARAMS,
+					   &cp->addr, sizeof(cp->addr));
+			goto unlock;
+		}
+
+		hci_pend_le_conn_del(hdev, &cp->addr.bdaddr, addr_type);
+		list_del(&params->list);
+		kfree(params);
 
 		device_removed(sk, hdev, &cp->addr.bdaddr, cp->addr.type);
 	} else {
@@ -5104,7 +5123,7 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 			goto unlock;
 		}
 
-		hci_conn_params_clear_all(hdev);
+		hci_conn_params_clear_enabled(hdev);
 	}
 
 	err = cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_DEVICE,
-- 
1.9.3

