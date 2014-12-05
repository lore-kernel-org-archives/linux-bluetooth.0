Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: Fix discovery filter when no RSSI is available
Date: Fri,  5 Dec 2014 13:03:34 +0100
Message-Id: <1417781015-32911-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When no RSSI value is available then make sure that the result is
filtered out when the RSSI threshold filter is active.

This means that all Bluetooth 1.1 or earlier devices will not
report any results when using a RSSI threshold filter.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c | 5 +++--
 net/bluetooth/mgmt.c      | 9 ++++++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f4e2a61bb6aa..527dfdc9d8c8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2043,13 +2043,14 @@ static void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		data.pscan_mode		= info->pscan_mode;
 		memcpy(data.dev_class, info->dev_class, 3);
 		data.clock_offset	= info->clock_offset;
-		data.rssi		= 0x00;
+		data.rssi		= HCI_RSSI_INVALID;
 		data.ssp_mode		= 0x00;
 
 		flags = hci_inquiry_cache_update(hdev, &data, false);
 
 		mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
-				  info->dev_class, 0, flags, NULL, 0, NULL, 0);
+				  info->dev_class, HCI_RSSI_INVALID,
+				  flags, NULL, 0, NULL, 0);
 	}
 
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 326609fa3bda..3ca2818d1c8b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7006,9 +7006,12 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	 * if such a RSSI threshold is specified. If a RSSI threshold has
 	 * been specified, then all results with a RSSI smaller than the
 	 * RSSI threshold will be dropped.
+	 *
+	 * For BR/EDR devices (pre 1.2) providing no RSSI during inquiry,
+	 * the results are also dropped.
 	 */
 	if (hdev->discovery.rssi != HCI_RSSI_INVALID &&
-	    rssi < hdev->discovery.rssi)
+	    (rssi < hdev->discovery.rssi || rssi == HCI_RSSI_INVALID))
 		return;
 
 	/* Make sure that the buffer is big enough. The 5 extra bytes
@@ -7019,6 +7022,10 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 
 	memset(buf, 0, sizeof(buf));
 
+	/* Reset invalid RSSI to 0 to keep backwards API compliance */
+	if (rssi == HCI_RSSI_INVALID)
+		rssi = 0;
+
 	bacpy(&ev->addr.bdaddr, bdaddr);
 	ev->addr.type = link_to_bdaddr(link_type, addr_type);
 	ev->rssi = rssi;
-- 
1.9.3

