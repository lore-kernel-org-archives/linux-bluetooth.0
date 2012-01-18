Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/15] Bluetooth: Add eir_len parameter to mgmt_ev_device_found
Date: Wed, 18 Jan 2012 20:51:45 +0200
Message-Id: <1326912717-6347-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
References: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch add a two byte eir_len parameter mgmt_ev_device_found. Since
it's unlikely that the data will in the short term be much bigger than
conventional EIR lengths just use a small stack based buffer for now to
avoid dynamic memory allocation & freeing.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    2 +-
 include/net/bluetooth/mgmt.h     |    3 ++-
 net/bluetooth/mgmt.c             |   28 +++++++++++++++-------------
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f3fbfd6..33dff8e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -925,7 +925,7 @@ int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
 						u8 *randomizer, u8 status);
 int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 					u8 addr_type, u8 *dev_class, s8 rssi,
-					u8 cfm_name, u8 *eir, u8 eir_len);
+					u8 cfm_name, u8 *eir, u16 eir_len);
 int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *name);
 int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status);
 int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index d1d13dc..4f166c8 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -368,7 +368,8 @@ struct mgmt_ev_device_found {
 	__u8 dev_class[3];
 	__s8 rssi;
 	__u8 confirm_name;
-	__u8 eir[HCI_MAX_EIR_LENGTH];
+	__le16 eir_len;
+	__u8 eir[0];
 } __packed;
 
 #define MGMT_EV_REMOTE_NAME		0x0012
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c8042c6..b7e7fdf 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2782,27 +2782,29 @@ int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
 
 int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 				u8 addr_type, u8 *dev_class, s8 rssi,
-				u8 cfm_name, u8 *eir, u8 eir_len)
+				u8 cfm_name, u8 *eir, u16 eir_len)
 {
-	struct mgmt_ev_device_found ev;
+	char buf[512];
+	struct mgmt_ev_device_found *ev = (void *) buf;
+	size_t ev_size = sizeof(*ev) + eir_len;
 
-	if (eir_len > sizeof(ev.eir))
+	if (ev_size > sizeof(buf))
 		return -EINVAL;
 
-	memset(&ev, 0, sizeof(ev));
+	bacpy(&ev->addr.bdaddr, bdaddr);
+	ev->addr.type = link_to_mgmt(link_type, addr_type);
+	ev->rssi = rssi;
+	ev->confirm_name = cfm_name;
 
-	bacpy(&ev.addr.bdaddr, bdaddr);
-	ev.addr.type = link_to_mgmt(link_type, addr_type);
-	ev.rssi = rssi;
-	ev.confirm_name = cfm_name;
-
-	if (eir)
-		memcpy(ev.eir, eir, eir_len);
+	if (eir_len > 0) {
+		put_unaligned_le16(eir_len, &ev->eir_len);
+		memcpy(ev->eir, eir, eir_len);
+	}
 
 	if (dev_class)
-		memcpy(ev.dev_class, dev_class, sizeof(ev.dev_class));
+		memcpy(ev->dev_class, dev_class, sizeof(ev->dev_class));
 
-	return mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, &ev, sizeof(ev), NULL);
+	return mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev, ev_size, NULL);
 }
 
 int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *name)
-- 
1.7.8.3

