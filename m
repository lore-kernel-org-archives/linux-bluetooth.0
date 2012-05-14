Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v0] Bluetooth: mgmt: Add device disconnect reason
Date: Mon, 14 May 2012 17:34:59 +0200
Message-Id: <1337009699-19831-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

MGMT_EV_DEVICE_DISCONNECTED should expose the disconnection reason to
userland.

Signed-off-by: Mikel Astiz <mikel.astiz@bmw-carit.de>
---
 include/net/bluetooth/hci_core.h |    2 +-
 include/net/bluetooth/mgmt.h     |    4 ++++
 net/bluetooth/hci_event.c        |    2 +-
 net/bluetooth/mgmt.c             |    9 +++++----
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b60d2c8..4c7252c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -974,7 +974,7 @@ int mgmt_device_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 			  u8 addr_type, u32 flags, u8 *name, u8 name_len,
 			  u8 *dev_class);
 int mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
-			     u8 link_type, u8 addr_type);
+			     u8 link_type, u8 addr_type, u8 reason);
 int mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			   u8 link_type, u8 addr_type, u8 status);
 int mgmt_connect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 23fd054..5845af9 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -406,6 +406,10 @@ struct mgmt_ev_device_connected {
 } __packed;
 
 #define MGMT_EV_DEVICE_DISCONNECTED	0x000C
+struct mgmt_ev_device_disconnected {
+	struct mgmt_addr_info addr;
+	__u8	reason;
+} __packed;
 
 #define MGMT_EV_CONNECT_FAILED		0x000D
 struct mgmt_ev_connect_failed {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d81262a..e33dbeb 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1920,7 +1920,7 @@ static inline void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff
 						conn->dst_type, ev->status);
 		else
 			mgmt_device_disconnected(hdev, &conn->dst, conn->type,
-						 conn->dst_type);
+						 conn->dst_type, ev->reason);
 	}
 
 	if (ev->status == 0) {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 25d2207..89af7c6 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3047,16 +3047,17 @@ static void unpair_device_rsp(struct pending_cmd *cmd, void *data)
 }
 
 int mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
-			     u8 link_type, u8 addr_type)
+			     u8 link_type, u8 addr_type, u8 reason)
 {
-	struct mgmt_addr_info ev;
+	struct mgmt_ev_device_disconnected ev;
 	struct sock *sk = NULL;
 	int err;
 
 	mgmt_pending_foreach(MGMT_OP_DISCONNECT, hdev, disconnect_rsp, &sk);
 
-	bacpy(&ev.bdaddr, bdaddr);
-	ev.type = link_to_bdaddr(link_type, addr_type);
+	bacpy(&ev.addr.bdaddr, bdaddr);
+	ev.addr.type = link_to_bdaddr(link_type, addr_type);
+	ev.reason = reason;
 
 	err = mgmt_event(MGMT_EV_DEVICE_DISCONNECTED, hdev, &ev, sizeof(ev),
 			 sk);
-- 
1.7.7.6

