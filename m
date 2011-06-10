Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC 12/16] Bluetooth: Report LE devices
Date: Fri, 10 Jun 2011 16:36:09 -0300
Message-Id: <1307734573-1630-13-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1307734573-1630-1-git-send-email-andre.guedes@openbossa.org>
References: <1307734573-1630-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Devices found during LE scan should be reported to userspace through
mgmt_device_found events.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 9d6fdbb..fa6e6f7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2733,6 +2733,7 @@ static inline void hci_le_adv_report_evt(struct hci_dev *hdev,
 {
 	struct hci_ev_le_advertising_info *ev;
 	u8 num_reports;
+	s8 rssi;
 
 	num_reports = skb->data[0];
 	ev = (void *) &skb->data[1];
@@ -2741,9 +2742,18 @@ static inline void hci_le_adv_report_evt(struct hci_dev *hdev,
 
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
1.7.4.1

