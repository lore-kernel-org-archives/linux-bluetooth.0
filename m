Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 1/6] Bluetooth: LE scan should send Discovering events
Date: Fri,  3 Feb 2012 17:47:57 -0300
Message-Id: <1328302082-17405-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Send MGMT Discovering events once LE scan starts/stops so the
userspace can track when local adapters are discovering LE devices.

This way, we also keep the same behavior of inquiry which sends MGMT
Discovering events once inquiry starts/stops even if it is triggered
by an external tool (e.g. hcitool).

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_core.c         |    2 ++
 net/bluetooth/hci_event.c        |    5 +++++
 3 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9751da7..bf2ef56 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -61,6 +61,7 @@ struct discovery_state {
 		DISCOVERY_STOPPED,
 		DISCOVERY_STARTING,
 		DISCOVERY_INQUIRY,
+		DISCOVERY_LE_SCAN,
 		DISCOVERY_RESOLVING,
 		DISCOVERY_STOPPING,
 	} state;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8bffd3e..1705d93 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -361,6 +361,7 @@ bool hci_discovery_active(struct hci_dev *hdev)
 	struct discovery_state *discov = &hdev->discovery;
 
 	if (discov->state == DISCOVERY_INQUIRY ||
+					discov->state == DISCOVERY_LE_SCAN ||
 					discov->state == DISCOVERY_RESOLVING)
 		return true;
 
@@ -381,6 +382,7 @@ void hci_discovery_set_state(struct hci_dev *hdev, int state)
 	case DISCOVERY_STARTING:
 		break;
 	case DISCOVERY_INQUIRY:
+	case DISCOVERY_LE_SCAN:
 		mgmt_discovering(hdev, 1);
 		break;
 	case DISCOVERY_RESOLVING:
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 23dbb31..8971c18 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1056,12 +1056,17 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 
 		hci_dev_lock(hdev);
 		hci_adv_entries_clear(hdev);
+		hci_discovery_set_state(hdev, DISCOVERY_LE_SCAN);
 		hci_dev_unlock(hdev);
 		break;
 
 	case LE_SCANNING_DISABLED:
 		clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
 
+		hci_dev_lock(hdev);
+		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+		hci_dev_unlock(hdev);
+
 		schedule_delayed_work(&hdev->adv_work, ADV_CLEAR_TIMEOUT);
 		break;
 
-- 
1.7.9

