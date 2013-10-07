Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/9] Bluetooth: Make mgmt_device_disconnected() return void
Date: Sun,  6 Oct 2013 23:55:50 -0700
Message-Id: <1381128953-32080-6-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The return value of mgmt_device_disconnected() function is not used
and so just change it to return void.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  4 ++--
 net/bluetooth/mgmt.c             | 10 +++-------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4856944..2b0bc31 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1104,8 +1104,8 @@ int mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 void mgmt_device_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 			   u8 addr_type, u32 flags, u8 *name, u8 name_len,
 			   u8 *dev_class);
-int mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
-			     u8 link_type, u8 addr_type, u8 reason);
+void mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
+			      u8 link_type, u8 addr_type, u8 reason);
 void mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			    u8 link_type, u8 addr_type, u8 status);
 void mgmt_connect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9029e67..b9cd582 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4118,12 +4118,11 @@ static void unpair_device_rsp(struct pending_cmd *cmd, void *data)
 	mgmt_pending_remove(cmd);
 }
 
-int mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
-			     u8 link_type, u8 addr_type, u8 reason)
+void mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
+			      u8 link_type, u8 addr_type, u8 reason)
 {
 	struct mgmt_ev_device_disconnected ev;
 	struct sock *sk = NULL;
-	int err;
 
 	mgmt_pending_foreach(MGMT_OP_DISCONNECT, hdev, disconnect_rsp, &sk);
 
@@ -4131,16 +4130,13 @@ int mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	ev.addr.type = link_to_bdaddr(link_type, addr_type);
 	ev.reason = reason;
 
-	err = mgmt_event(MGMT_EV_DEVICE_DISCONNECTED, hdev, &ev, sizeof(ev),
-			 sk);
+	mgmt_event(MGMT_EV_DEVICE_DISCONNECTED, hdev, &ev, sizeof(ev), sk);
 
 	if (sk)
 		sock_put(sk);
 
 	mgmt_pending_foreach(MGMT_OP_UNPAIR_DEVICE, hdev, unpair_device_rsp,
 			     hdev);
-
-	return err;
 }
 
 void mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,
-- 
1.8.3.1

