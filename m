Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: Report invalid RSSI for service discovery and background scan
Date: Fri,  5 Dec 2014 13:03:35 +0100
Message-Id: <1417781015-32911-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When using Start Service Discovery and when background scanning is used
to report devices, the RSSI is reported or the value 127 is provided in
case RSSI in unavailable.

For Start Discovery the value 0 is reported to keep backwards
compatibility with the existing users.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  3 +++
 net/bluetooth/mgmt.c             | 12 ++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f07b1450b3c2..3c7827005c25 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -75,6 +75,7 @@ struct discovery_state {
 	u32			last_adv_flags;
 	u8			last_adv_data[HCI_MAX_AD_LENGTH];
 	u8			last_adv_data_len;
+	bool			report_invalid_rssi;
 	s8			rssi;
 	u16			uuid_count;
 	u8			(*uuids)[16];
@@ -506,11 +507,13 @@ static inline void discovery_init(struct hci_dev *hdev)
 	INIT_LIST_HEAD(&hdev->discovery.all);
 	INIT_LIST_HEAD(&hdev->discovery.unknown);
 	INIT_LIST_HEAD(&hdev->discovery.resolve);
+	hdev->discovery.report_invalid_rssi = true;
 	hdev->discovery.rssi = HCI_RSSI_INVALID;
 }
 
 static inline void hci_discovery_filter_clear(struct hci_dev *hdev)
 {
+	hdev->discovery.report_invalid_rssi = true;
 	hdev->discovery.rssi = HCI_RSSI_INVALID;
 	hdev->discovery.uuid_count = 0;
 	kfree(hdev->discovery.uuids);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3ca2818d1c8b..a91e484886fe 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3912,6 +3912,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 	hci_discovery_filter_clear(hdev);
 
 	hdev->discovery.type = cp->type;
+	hdev->discovery.report_invalid_rssi = false;
 
 	hci_req_init(&req, hdev);
 
@@ -7022,8 +7023,15 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 
 	memset(buf, 0, sizeof(buf));
 
-	/* Reset invalid RSSI to 0 to keep backwards API compliance */
-	if (rssi == HCI_RSSI_INVALID)
+	/* In case of device discovery with BR/EDR devices (pre 1.2), the
+	 * RSSI value was reported as 0 when not available. This behavior
+	 * is kept when using device discovery. This is required for full
+	 * backwards compatibility with the API.
+	 *
+	 * However when using service discovery, the value 127 will be
+	 * returned when the RSSI is not available.
+	 */
+	if (rssi == HCI_RSSI_INVALID && !hdev->discovery.report_invalid_rssi)
 		rssi = 0;
 
 	bacpy(&ev->addr.bdaddr, bdaddr);
-- 
1.9.3

