Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/6] Bluetooth: Report LE devices
Date: Fri, 11 Nov 2011 19:50:23 -0300
Message-Id: <1321051824-5216-6-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1321051824-5216-1-git-send-email-andre.guedes@openbossa.org>
References: <1321051824-5216-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Devices found during LE scan should be reported to userspace through
mgmt_device_found events.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6d60fec..dcbbffe 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2909,6 +2909,7 @@ static inline void hci_le_adv_report_evt(struct hci_dev *hdev,
 {
 	u8 num_reports = skb->data[0];
 	void *ptr = &skb->data[1];
+	s8 rssi;
 
 	hci_dev_lock(hdev);
 
@@ -2917,6 +2918,10 @@ static inline void hci_le_adv_report_evt(struct hci_dev *hdev,
 
 		hci_add_adv_entry(hdev, ev);
 
+		rssi = ev->data[ev->length];
+		mgmt_device_found(hdev, &ev->bdaddr, LE_LINK, ev->bdaddr_type,
+					NULL, rssi, ev->data, ev->length);
+
 		ptr += sizeof(*ev) + ev->length + 1;
 	}
 
-- 
1.7.7.1

