Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/5] Bluetooth: Limit userspace exposure of stack internal events
Date: Sun,  4 Oct 2015 23:33:59 +0200
Message-Id: <1443994443-123453-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The stack internal events that are exposed to userspace should be
limited to HCI_DEV_REG, HCI_DEV_UNREG, HCI_DEV_UP and HCI_DEV_DOWN.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 150556345263..d9ad68448173 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -392,14 +392,12 @@ static void hci_si_event(struct hci_dev *hdev, int type, int dlen, void *data)
 
 void hci_sock_dev_event(struct hci_dev *hdev, int event)
 {
-	struct hci_ev_si_device ev;
-
 	BT_DBG("hdev %s event %d", hdev->name, event);
 
-	/* Send event to monitor */
 	if (atomic_read(&monitor_promisc)) {
 		struct sk_buff *skb;
 
+		/* Send event to monitor */
 		skb = create_monitor_event(hdev, event);
 		if (skb) {
 			hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
@@ -408,10 +406,14 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event)
 		}
 	}
 
-	/* Send event to sockets */
-	ev.event  = event;
-	ev.dev_id = hdev->id;
-	hci_si_event(NULL, HCI_EV_SI_DEVICE, sizeof(ev), &ev);
+	if (event <= HCI_DEV_DOWN) {
+		struct hci_ev_si_device ev;
+
+		/* Send event to sockets */
+		ev.event  = event;
+		ev.dev_id = hdev->id;
+		hci_si_event(NULL, HCI_EV_SI_DEVICE, sizeof(ev), &ev);
+	}
 
 	if (event == HCI_DEV_UNREG) {
 		struct sock *sk;
-- 
2.4.3

