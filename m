Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Add proper defines for HCI connection role
Date: Wed, 16 Jul 2014 11:42:26 +0300
Message-Id: <1405500148-12370-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

All HCI commands and events, including LE ones, use 0x00 for master role
and 0x01 for slave role. It makes therefore sense to add generic defines
for these instead of the current LE_CONN_ROLE_MASTER. Having clean
defines will also make it possible to provide simpler internal APIs.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h | 6 +++---
 net/bluetooth/hci_event.c   | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 2fee852816ee..f0a3d8890760 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -401,6 +401,9 @@ enum {
 /* The core spec defines 127 as the "not available" value */
 #define HCI_TX_POWER_INVALID	127
 
+#define HCI_ROLE_MASTER		0x00
+#define HCI_ROLE_SLAVE		0x01
+
 /* Extended Inquiry Response field types */
 #define EIR_FLAGS		0x01 /* flags */
 #define EIR_UUID16_SOME		0x02 /* 16-bit UUID, more available */
@@ -1713,9 +1716,6 @@ struct hci_ev_sync_train_complete {
 
 #define HCI_EV_SLAVE_PAGE_RESP_TIMEOUT	0x54
 
-/* Low energy meta events */
-#define LE_CONN_ROLE_MASTER	0x00
-
 #define HCI_EV_LE_CONN_COMPLETE		0x01
 struct hci_ev_le_conn_complete {
 	__u8     status;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 68d335e193bf..13f83c48face 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4116,7 +4116,7 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 		conn->dst_type = ev->bdaddr_type;
 
-		if (ev->role == LE_CONN_ROLE_MASTER) {
+		if (ev->role == HCI_ROLE_MASTER) {
 			conn->out = true;
 			set_bit(HCI_CONN_MASTER, &conn->flags);
 		}
-- 
1.9.3

