Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix passkey endianess in user_confirm and notify_passkey
Date: Thu, 20 Mar 2014 08:18:14 +0200
Message-Id: <1395296294-8686-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The passkey_notify and user_confirm functions in mgmt.c were expecting
different endianess for the passkey, leading to a big endian bug and
sparse warning in recently added SMP code. This patch converts both
functions to expect host endianess and do the conversion to little
endian only when assigning to the mgmt event struct.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 2 +-
 net/bluetooth/hci_event.c        | 4 ++--
 net/bluetooth/mgmt.c             | 4 ++--
 net/bluetooth/smp.c              | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b8cc39a4a9a5..afbea388eda1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1236,7 +1236,7 @@ void mgmt_pin_code_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 void mgmt_pin_code_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				      u8 status);
 int mgmt_user_confirm_request(struct hci_dev *hdev, bdaddr_t *bdaddr,
-			      u8 link_type, u8 addr_type, __le32 value,
+			      u8 link_type, u8 addr_type, u32 value,
 			      u8 confirm_hint);
 int mgmt_user_confirm_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				     u8 link_type, u8 addr_type, u8 status);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a6a3d32553c5..1e386edc338f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3459,8 +3459,8 @@ static void hci_user_confirm_request_evt(struct hci_dev *hdev,
 	}
 
 confirm:
-	mgmt_user_confirm_request(hdev, &ev->bdaddr, ACL_LINK, 0, ev->passkey,
-				  confirm_hint);
+	mgmt_user_confirm_request(hdev, &ev->bdaddr, ACL_LINK, 0,
+				  le32_to_cpu(ev->passkey), confirm_hint);
 
 unlock:
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 96670f581bb0..739887c6b286 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5338,7 +5338,7 @@ void mgmt_pin_code_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 }
 
 int mgmt_user_confirm_request(struct hci_dev *hdev, bdaddr_t *bdaddr,
-			      u8 link_type, u8 addr_type, __le32 value,
+			      u8 link_type, u8 addr_type, u32 value,
 			      u8 confirm_hint)
 {
 	struct mgmt_ev_user_confirm_request ev;
@@ -5348,7 +5348,7 @@ int mgmt_user_confirm_request(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	bacpy(&ev.addr.bdaddr, bdaddr);
 	ev.addr.type = link_to_bdaddr(link_type, addr_type);
 	ev.confirm_hint = confirm_hint;
-	ev.value = value;
+	ev.value = cpu_to_le32(value);
 
 	return mgmt_event(MGMT_EV_USER_CONFIRM_REQUEST, hdev, &ev, sizeof(ev),
 			  NULL);
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 2a7ee7f6cd8b..13919ff82e05 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -425,7 +425,7 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 	else
 		ret = mgmt_user_passkey_notify(hcon->hdev, &hcon->dst,
 						hcon->type, hcon->dst_type,
-						cpu_to_le32(passkey), 0);
+						passkey, 0);
 
 	hci_dev_unlock(hcon->hdev);
 
-- 
1.8.5.3

