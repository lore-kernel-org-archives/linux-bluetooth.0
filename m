Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/15] Bluetooth: Merge device class into the EIR data in mgmt_ev_device_found
Date: Wed, 18 Jan 2012 20:51:49 +0200
Message-Id: <1326912717-6347-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
References: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There's no need to have a separate device class field since the same
information can be encoded into the EIR data.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |   11 +++++++++++
 include/net/bluetooth/mgmt.h     |    1 -
 net/bluetooth/mgmt.c             |   20 +++++++++++++-------
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 393bb73..02aa0f9 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -893,6 +893,17 @@ static inline bool eir_has_data_type(u8 *data, size_t data_len, u8 type)
 	return false;
 }
 
+static inline u16 eir_append_data(u8 *eir, u16 eir_len, u8 type, u8 *data,
+								u16 data_len)
+{
+	eir[eir_len++] = sizeof(type) + data_len;
+	eir[eir_len++] = type;
+	memcpy(&eir[eir_len], data, data_len);
+	eir_len += data_len;
+
+	return eir_len;
+}
+
 int hci_register_cb(struct hci_cb *hcb);
 int hci_unregister_cb(struct hci_cb *hcb);
 
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 4f166c8..bdace52 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -365,7 +365,6 @@ struct mgmt_ev_auth_failed {
 #define MGMT_EV_DEVICE_FOUND		0x0011
 struct mgmt_ev_device_found {
 	struct mgmt_addr_info addr;
-	__u8 dev_class[3];
 	__s8 rssi;
 	__u8 confirm_name;
 	__le16 eir_len;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b7e7fdf..bec64c9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2786,23 +2786,29 @@ int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 {
 	char buf[512];
 	struct mgmt_ev_device_found *ev = (void *) buf;
-	size_t ev_size = sizeof(*ev) + eir_len;
+	size_t ev_size;
 
-	if (ev_size > sizeof(buf))
+	/* Leave 5 bytes for a potential CoD field */
+	if (sizeof(*ev) + eir_len + 5 > sizeof(buf))
 		return -EINVAL;
 
+	memset(buf, 0, sizeof(buf));
+
 	bacpy(&ev->addr.bdaddr, bdaddr);
 	ev->addr.type = link_to_mgmt(link_type, addr_type);
 	ev->rssi = rssi;
 	ev->confirm_name = cfm_name;
 
-	if (eir_len > 0) {
-		put_unaligned_le16(eir_len, &ev->eir_len);
+	if (eir_len > 0)
 		memcpy(ev->eir, eir, eir_len);
-	}
 
-	if (dev_class)
-		memcpy(ev->dev_class, dev_class, sizeof(ev->dev_class));
+	if (dev_class && !eir_has_data_type(ev->eir, eir_len, EIR_CLASS_OF_DEV))
+		eir_len = eir_append_data(ev->eir, eir_len, EIR_CLASS_OF_DEV,
+								dev_class, 3);
+
+	put_unaligned_le16(eir_len, &ev->eir_len);
+
+	ev_size = sizeof(*ev) + eir_len;
 
 	return mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev, ev_size, NULL);
 }
-- 
1.7.8.3

