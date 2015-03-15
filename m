Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 04/14] Bluetooth: Add support for extended index management events
Date: Sat, 14 Mar 2015 19:27:56 -0700
Message-Id: <1426386486-15962-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This introduces support for using Extended Index Added and Extended
Index Removed events. These events contain the controller type and
also the hardware bus information from the driver.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h  |  1 +
 include/net/bluetooth/mgmt.h |  9 +++++++++
 net/bluetooth/mgmt.c         | 28 ++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 0995ec755959..b8318711135a 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -183,6 +183,7 @@ enum {
 enum {
 	HCI_MGMT_INDEX_EVENTS,
 	HCI_MGMT_UNCONF_INDEX_EVENTS,
+	HCI_MGMT_EXT_INDEX_EVENTS,
 };
 
 /*
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 5bf6af9cee78..8562f9ecf230 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -692,3 +692,12 @@ struct mgmt_ev_new_conn_param {
 #define MGMT_EV_UNCONF_INDEX_REMOVED	0x001e
 
 #define MGMT_EV_NEW_CONFIG_OPTIONS	0x001f
+
+struct mgmt_ev_ext_index {
+	__u8 type;
+	__u8 bus;
+} __packed;
+
+#define MGMT_EV_EXT_INDEX_ADDED		0x0020
+
+#define MGMT_EV_EXT_INDEX_REMOVED	0x0021
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6b58c13b2b51..56f49e9c4189 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -128,6 +128,8 @@ static const u16 mgmt_events[] = {
 	MGMT_EV_UNCONF_INDEX_ADDED,
 	MGMT_EV_UNCONF_INDEX_REMOVED,
 	MGMT_EV_NEW_CONFIG_OPTIONS,
+	MGMT_EV_EXT_INDEX_ADDED,
+	MGMT_EV_EXT_INDEX_REMOVED,
 };
 
 #define CACHE_TIMEOUT	msecs_to_jiffies(2 * 1000)
@@ -6370,6 +6372,7 @@ done:
 
 void mgmt_index_added(struct hci_dev *hdev)
 {
+	struct mgmt_ev_ext_index ev;
 
 	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
 		return;
@@ -6379,16 +6382,29 @@ void mgmt_index_added(struct hci_dev *hdev)
 		if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED)) {
 			mgmt_index_event(MGMT_EV_UNCONF_INDEX_ADDED, hdev,
 					 NULL, 0, HCI_MGMT_UNCONF_INDEX_EVENTS);
+			ev.type = 0x01;
 		} else {
 			mgmt_index_event(MGMT_EV_INDEX_ADDED, hdev, NULL, 0,
 					 HCI_MGMT_INDEX_EVENTS);
+			ev.type = 0x00;
 		}
 		break;
+	case HCI_AMP:
+		ev.type = 0x02;
+		break;
+	default:
+		return;
 	}
+
+	ev.bus = hdev->bus;
+
+	mgmt_index_event(MGMT_EV_EXT_INDEX_ADDED, hdev, &ev, sizeof(ev),
+			 HCI_MGMT_EXT_INDEX_EVENTS);
 }
 
 void mgmt_index_removed(struct hci_dev *hdev)
 {
+	struct mgmt_ev_ext_index ev;
 	u8 status = MGMT_STATUS_INVALID_INDEX;
 
 	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
@@ -6401,12 +6417,24 @@ void mgmt_index_removed(struct hci_dev *hdev)
 		if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED)) {
 			mgmt_index_event(MGMT_EV_UNCONF_INDEX_REMOVED, hdev,
 					 NULL, 0, HCI_MGMT_UNCONF_INDEX_EVENTS);
+			ev.type = 0x01;
 		} else {
 			mgmt_index_event(MGMT_EV_INDEX_REMOVED, hdev, NULL, 0,
 					 HCI_MGMT_INDEX_EVENTS);
+			ev.type = 0x00;
 		}
 		break;
+	case HCI_AMP:
+		ev.type = 0x02;
+		break;
+	default:
+		return;
 	}
+
+	ev.bus = hdev->bus;
+
+	mgmt_index_event(MGMT_EV_EXT_INDEX_REMOVED, hdev, &ev, sizeof(ev),
+			 HCI_MGMT_EXT_INDEX_EVENTS);
 }
 
 /* This function requires the caller holds hdev->lock */
-- 
2.1.0

