Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Merge ADV_IND/ADV_SCAN_IND and SCAN_RSP together
Date: Tue, 25 Mar 2014 10:51:52 +0200
Message-Id: <1395737512-16757-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

To avoid too many events being sent to user space and to help parsing of
all available remote device data it makes sense for us to wait for the
scan response and send a single merged Device Found event to user space.

This patch adds a few new variables to hci_dev to track the last
received ADV_IND/ADV_SCAN_IND, i.e. those which will cause a SCAN_REQ to
be send in the case of active scanning. When the SCAN_RSP is received
the pending data is passed together with the SCAN_RSP to the
mgmt_device_found function which takes care of merging them into a
single Device Found event.

We also need a bit of extra logic to handle situations where we don't
receive a SCAN_RSP after caching some data. In such a scenario we simply
have to send out the pending data as it is and then operate on the new
report as if there was no pending data.

We also need to send out any pending data when scanning stops as
well as ensure that the storage is empty at the start of a new active
scanning session. These both cases are covered by the update to the
hci_cc_le_set_scan_enable function in this patch.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |   4 ++
 net/bluetooth/hci_event.c        | 103 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 105 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a1b8eab8a47d..59b112397d39 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -68,6 +68,10 @@ struct discovery_state {
 	struct list_head	unknown;	/* Name state not known */
 	struct list_head	resolve;	/* Name needs to be resolved */
 	__u32			timestamp;
+	bdaddr_t		last_adv_addr;
+	u8			last_adv_addr_type;
+	u8			last_adv_data[HCI_MAX_AD_LENGTH];
+	u8			last_adv_data_len;
 };
 
 struct hci_conn_hash {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 81e5236a0119..5816a13c5342 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1033,6 +1033,32 @@ static void hci_cc_le_set_scan_param(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_unlock(hdev);
 }
 
+static bool has_pending_adv_report(struct hci_dev *hdev)
+{
+	struct discovery_state *d = &hdev->discovery;
+
+	return bacmp(&d->last_adv_addr, BDADDR_ANY);
+}
+
+static void clear_pending_adv_report(struct hci_dev *hdev)
+{
+	struct discovery_state *d = &hdev->discovery;
+
+	bacpy(&d->last_adv_addr, BDADDR_ANY);
+	d->last_adv_data_len = 0;
+}
+
+static void store_pending_adv_report(struct hci_dev *hdev, bdaddr_t *bdaddr,
+				     u8 bdaddr_type, u8 *data, u8 len)
+{
+	struct discovery_state *d = &hdev->discovery;
+
+	bacpy(&d->last_adv_addr, bdaddr);
+	d->last_adv_addr_type = bdaddr_type;
+	memcpy(d->last_adv_data, data, len);
+	d->last_adv_data_len = len;
+}
+
 static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 				      struct sk_buff *skb)
 {
@@ -1051,9 +1077,24 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 	switch (cp->enable) {
 	case LE_SCAN_ENABLE:
 		set_bit(HCI_LE_SCAN, &hdev->dev_flags);
+		if (hdev->le_scan_type == LE_SCAN_ACTIVE)
+			clear_pending_adv_report(hdev);
 		break;
 
 	case LE_SCAN_DISABLE:
+		/* We do this here instead of when setting DISCOVERY_STOPPED
+		 * since the latter would potentially require waiting for
+		 * inquiry to stop too.
+		 */
+		if (has_pending_adv_report(hdev)) {
+			struct discovery_state *d = &hdev->discovery;
+
+			mgmt_device_found(hdev, &d->last_adv_addr, LE_LINK,
+					  d->last_adv_addr_type, NULL, 0, 0,
+					  1, d->last_adv_data,
+					  d->last_adv_data_len, NULL, 0);
+		}
+
 		/* Cancel this timer so that we don't try to disable scanning
 		 * when it's already disabled.
 		 */
@@ -3979,6 +4020,8 @@ static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
 static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 			       u8 bdaddr_type, s8 rssi, u8 *data, u8 len)
 {
+	struct discovery_state *d = &hdev->discovery;
+
 	/* Passive scanning shouldn't trigger any device found events */
 	if (hdev->le_scan_type == LE_SCAN_PASSIVE) {
 		if (type == LE_ADV_IND || type == LE_ADV_DIRECT_IND)
@@ -3986,8 +4029,64 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		return;
 	}
 
-	mgmt_device_found(hdev, bdaddr, LE_LINK, bdaddr_type, NULL, rssi, 0, 1,
-			  data, len, NULL, 0);
+	/* If there's nothing pending either store the data from this
+	 * event or send an immediate device found event if the data
+	 * should not be stored for later.
+	 */
+	if (!has_pending_adv_report(hdev)) {
+		/* If the report will trigger a SCAN_REQ store it for
+		 * later merging.
+		 */
+		if (type == LE_ADV_IND || type == LE_ADV_SCAN_IND) {
+			store_pending_adv_report(hdev, bdaddr, bdaddr_type,
+						 data, len);
+			return;
+		}
+
+		mgmt_device_found(hdev, bdaddr, LE_LINK, bdaddr_type, NULL,
+				  rssi, 0, 1, data, len, NULL, 0);
+		return;
+	}
+
+	/* If the pending data doesn't match this report or this isn't a
+	 * scan response (e.g. we got a duplicate ADV_IND) then force
+	 * sending of the pending data.
+	 */
+	if (type != LE_ADV_SCAN_RSP || bacmp(bdaddr, &d->last_adv_addr) ||
+	    bdaddr_type != d->last_adv_addr_type) {
+		/* Send out whatever is in the cache */
+		mgmt_device_found(hdev, &d->last_adv_addr, LE_LINK,
+				  d->last_adv_addr_type, NULL, 0, 0, 1,
+				  d->last_adv_data, d->last_adv_data_len,
+				  NULL, 0);
+
+		/* If the new report will trigger a SCAN_REQ store it for
+		 * later merging.
+		 */
+		if (type == LE_ADV_IND || type == LE_ADV_SCAN_IND) {
+			store_pending_adv_report(hdev, bdaddr, bdaddr_type,
+						 data, len);
+			return;
+		}
+
+		/* The advertising reports cannot be merged, so clear
+		 * the pending report and send out a device found event.
+		 */
+		clear_pending_adv_report(hdev);
+		mgmt_device_found(hdev, &d->last_adv_addr, LE_LINK,
+				  d->last_adv_addr_type, NULL, rssi, 0, 1,
+				  data, len, NULL, 0);
+		return;
+	}
+
+	/* If we get here we've got a pending ADV_IND or ADV_SCAN_IND and
+	 * the new event is a SCAN_RSP. We can therefore proceed with
+	 * sending a merged device found event.
+	 */
+	mgmt_device_found(hdev, &d->last_adv_addr, LE_LINK,
+			  d->last_adv_addr_type, NULL, rssi, 0, 1, data, len,
+			  d->last_adv_data, d->last_adv_data_len);
+	clear_pending_adv_report(hdev);
 }
 
 static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
-- 
1.8.5.3

