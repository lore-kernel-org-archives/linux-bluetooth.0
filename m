Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/7] Bluetooth: Fix hci_le_conn_complete_evt
Date: Fri, 27 Jul 2012 15:10:11 -0300
Message-Id: <1343412616-25641-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1343412616-25641-1-git-send-email-andre.guedes@openbossa.org>
References: <1343412616-25641-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We need to check the 'Role' parameter from the LE Connection
Complete Event in order to properly set 'out' and 'link_mode'
fields from hci_conn structure.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci.h | 2 ++
 net/bluetooth/hci_event.c   | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 7f19556..23cf413 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1304,6 +1304,8 @@ struct hci_ev_num_comp_blocks {
 } __packed;
 
 /* Low energy meta events */
+#define LE_CONN_ROLE_MASTER	0x00
+
 #define HCI_EV_LE_CONN_COMPLETE		0x01
 struct hci_ev_le_conn_complete {
 	__u8     status;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e89d7f2..8b13ccc 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3368,6 +3368,11 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		}
 
 		conn->dst_type = ev->bdaddr_type;
+
+		if (ev->role == LE_CONN_ROLE_MASTER) {
+			conn->out = true;
+			conn->link_mode |= HCI_LM_MASTER;
+		}
 	}
 
 	if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
-- 
1.7.11.2

