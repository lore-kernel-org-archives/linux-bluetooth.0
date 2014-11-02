Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Print error message for HCI_Hardware_Error event
Date: Sun,  2 Nov 2014 02:56:41 +0100
Message-Id: <1414893401-85774-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the HCI_Hardware_Error event is send by the controller or
injected by the driver, then at least print an error message.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h |  5 +++++
 net/bluetooth/hci_event.c   | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 6e8f24967308..ecfa306e1375 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1463,6 +1463,11 @@ struct hci_ev_cmd_status {
 	__le16   opcode;
 } __packed;
 
+#define HCI_EV_HARDWARE_ERROR		0x10
+struct hci_ev_hardware_error {
+	__u8     code;
+} __packed;
+
 #define HCI_EV_ROLE_CHANGE		0x12
 struct hci_ev_role_change {
 	__u8     status;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3dd2550b4c07..2f02ff0ed781 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2925,6 +2925,13 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 }
 
+static void hci_hardware_error_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_ev_hardware_error *ev = (void *) skb->data;
+
+	BT_ERR("%s hardware error 0x%2.2x", hdev->name, ev->code);
+}
+
 static void hci_role_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_role_change *ev = (void *) skb->data;
@@ -4746,6 +4753,10 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cmd_status_evt(hdev, skb);
 		break;
 
+	case HCI_EV_HARDWARE_ERROR:
+		hci_hardware_error_evt(hdev, skb);
+		break;
+
 	case HCI_EV_ROLE_CHANGE:
 		hci_role_change_evt(hdev, skb);
 		break;
-- 
1.9.3

