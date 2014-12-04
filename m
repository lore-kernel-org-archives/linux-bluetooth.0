Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [RFC v3 6/6] Bluetooth: Add service discovery filtering
Date: Thu,  4 Dec 2014 12:22:53 -0800
Message-Id: <1417724573-28561-7-git-send-email-jpawlowski@google.com>
In-Reply-To: <1417724573-28561-1-git-send-email-jpawlowski@google.com>
References: <1417724573-28561-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for LE packet filtering when service discovery
is running.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/mgmt.c             | 92 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ef57213..1e9e88e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -508,6 +508,7 @@ int sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb);
 /* ----- Inquiry cache ----- */
 #define INQUIRY_CACHE_AGE_MAX   (HZ*30)   /* 30 seconds */
 #define INQUIRY_ENTRY_AGE_MAX   (HZ*60)   /* 60 seconds */
+#define DISCOV_LE_RESTART_DELAY		200	/* msec */
 
 static inline void discovery_init(struct hci_dev *hdev)
 {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b0363851..66bff27 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6908,6 +6908,83 @@ void mgmt_read_local_oob_data_complete(struct hci_dev *hdev, u8 *hash192,
 	mgmt_pending_remove(cmd);
 }
 
+/* this is reversed hex representation of bluetooth base uuid. We need it for
+ * service uuid parsing in eir.
+ */
+static const u8 reverse_base_uuid[] = {
+			0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
+			0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static bool cmp_filter_uuids(struct hci_dev *hdev, u8 uuid[16])
+{
+	int i;
+
+	for (i = 0; i < hdev->discovery.uuid_count; i++)
+		if (memcmp(hdev->discovery.uuids[i], uuid, 16) != 0)
+			return true;
+
+	return false;
+}
+
+static bool find_service_discov_match(struct hci_dev *hdev, u8 *eir, u8 eir_len)
+{
+	size_t offset;
+	u8 uuid[16];
+	int i;
+
+	offset = 0;
+	while (offset < eir_len) {
+		uint8_t field_len = eir[0];
+
+		/* Check for the end of EIR */
+		if (field_len == 0)
+			break;
+
+		if (offset + field_len > eir_len)
+			return -EINVAL;
+
+		switch (eir[1]) {
+		case EIR_UUID16_ALL:
+		case EIR_UUID16_SOME:
+			for (i = 0; i + 3 <= field_len; i += 2) {
+				memcpy(uuid, reverse_base_uuid, 16);
+				memcpy(uuid + 12, eir + i + 2, 2);
+				if (cmp_filter_uuids(hdev, uuid))
+					return true;
+			}
+			break;
+		case EIR_UUID32_ALL:
+		case EIR_UUID32_SOME:
+			for (i = 0; i + 5 <= field_len; i += 4) {
+				memcpy(uuid, reverse_base_uuid, 16);
+				memcpy(uuid + 12, eir + i + 2, 4);
+				if (cmp_filter_uuids(hdev, uuid))
+					return true;
+			}
+			break;
+		case EIR_UUID128_ALL:
+		case EIR_UUID128_SOME:
+			for (i = 0; i + 17 <= field_len; i += 16) {
+				memcpy(uuid, eir + i + 2, 16);
+				if (cmp_filter_uuids(hdev, uuid))
+					return true;
+			}
+			break;
+		}
+
+		offset += field_len + 1;
+		eir += field_len + 1;
+	}
+	return false;
+}
+
+static void restart_le_scan(struct hci_dev *hdev)
+{
+	queue_delayed_work(hdev->workqueue, &hdev->le_scan_restart,
+			   msecs_to_jiffies(DISCOV_LE_RESTART_DELAY));
+}
+
 void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		       u8 addr_type, u8 *dev_class, s8 rssi, u32 flags,
 		       u8 *eir, u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len)
@@ -6953,7 +7030,20 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	ev->eir_len = cpu_to_le16(eir_len + scan_rsp_len);
 	ev_size = sizeof(*ev) + eir_len + scan_rsp_len;
 
-	mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev, ev_size, NULL);
+	if (hdev->discovery.rssi == 127 && hdev->discovery.uuid_count == 0) {
+		mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev, ev_size, NULL);
+		return;
+	}
+
+	if (!find_service_discov_match(hdev, eir, eir_len))
+		return;
+
+	if (test_bit(HCI_LE_SCAN, &hdev->dev_flags))
+		restart_le_scan(hdev);
+
+	if (rssi >= hdev->discovery.rssi)
+		mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev,
+			   ev_size, NULL);
 }
 
 void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-- 
2.2.0.rc0.207.ga3a616c

