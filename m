Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/7] Bluetooth: Add extra discovery fields for storing filter information
Date: Fri,  5 Dec 2014 10:55:55 +0100
Message-Id: <1417773359-122811-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jakub Pawlowski <jpawlowski@google.com>

With the upcoming addition of support for Start Service Discovery, the
discovery handling needs to filter on RSSI and UUID values. For that
they need to be stored in the discovery handling. This patch adds the
appropiate fields and also make sure they are reset when discovery
has been stopped.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  4 ++++
 net/bluetooth/hci_core.c         | 14 ++++++++++++++
 net/bluetooth/mgmt.c             |  2 ++
 3 files changed, 20 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1dae7001fc31..83ca58b9f4c1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -75,6 +75,9 @@ struct discovery_state {
 	u32			last_adv_flags;
 	u8			last_adv_data[HCI_MAX_AD_LENGTH];
 	u8			last_adv_data_len;
+	s8			rssi;
+	u16			uuid_count;
+	u8			(*uuids)[16];
 };
 
 struct hci_conn_hash {
@@ -503,6 +506,7 @@ static inline void discovery_init(struct hci_dev *hdev)
 	INIT_LIST_HEAD(&hdev->discovery.all);
 	INIT_LIST_HEAD(&hdev->discovery.unknown);
 	INIT_LIST_HEAD(&hdev->discovery.resolve);
+	hdev->discovery.rssi = HCI_RSSI_INVALID;
 }
 
 bool hci_discovery_active(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f0018562b028..42f86dc3fb40 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2052,6 +2052,20 @@ void hci_discovery_set_state(struct hci_dev *hdev, int state)
 	case DISCOVERY_STOPPED:
 		hci_update_background_scan(hdev);
 
+		/* Reset RSSI and UUID filters to ensure Start Discovery
+		 * and Start Service Discovery operate properly no matter
+		 * which one started the previous discovery.
+		 *
+		 * While the Start Discovery and Start Service Discovery
+		 * operations will set proper values for RSSI and UUID
+		 * count, it is important to actually free the allocated
+		 * list of UUIDs here.
+		 */
+		hdev->discovery.rssi = HCI_RSSI_INVALID;
+		hdev->discovery.uuid_count = 0;
+		kfree(hdev->discovery.uuids);
+		hdev->discovery.uuids = NULL;
+
 		if (old_state != DISCOVERY_STARTING)
 			mgmt_discovering(hdev, 0);
 		break;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 415ba4179326..b6a0f3e6b719 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3867,6 +3867,8 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 	}
 
 	hdev->discovery.type = cp->type;
+	hdev->discovery.rssi = HCI_RSSI_INVALID;
+	hdev->discovery.uuid_count = 0;
 
 	hci_req_init(&req, hdev);
 
-- 
1.9.3

