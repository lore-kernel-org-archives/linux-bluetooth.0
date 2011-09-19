Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 11/14] Bluetooth: Report LE devices
Date: Mon, 19 Sep 2011 18:35:33 -0300
Message-Id: <1316468136-12472-12-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1316468136-12472-1-git-send-email-andre.guedes@openbossa.org>
References: <1316468136-12472-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Devices found during LE scan should be reported to userspace through
mgmt_device_found events.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f097649..166f8fa 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2830,6 +2830,7 @@ static inline void hci_le_adv_report_evt(struct hci_dev *hdev,
 {
 	struct hci_ev_le_advertising_info *ev;
 	u8 num_reports;
+	s8 rssi;
 
 	num_reports = skb->data[0];
 	ev = (void *) &skb->data[1];
@@ -2838,9 +2839,18 @@ static inline void hci_le_adv_report_evt(struct hci_dev *hdev,
 
 	hci_add_adv_entry(hdev, ev);
 
+	rssi = ev->data[ev->length];
+	mgmt_device_found(hdev->id, &ev->bdaddr, NULL, rssi, ev->data,
+								ev->length);
+
 	while (--num_reports) {
 		ev = (void *) (ev->data + ev->length + 1);
+
 		hci_add_adv_entry(hdev, ev);
+
+		rssi = ev->data[ev->length];
+		mgmt_device_found(hdev->id, &ev->bdaddr, NULL, rssi, ev->data,
+								ev->length);
 	}
 
 	hci_dev_unlock(hdev);
-- 
1.7.5.2

