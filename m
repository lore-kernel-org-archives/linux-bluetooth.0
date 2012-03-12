Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Handle EIR tags for Device ID
Date: Sun, 11 Mar 2012 19:32:12 -0700
Message-Id: <1331519532-26505-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Device ID information can be provided via Extended Inquiry Data
as well. If a valid source is present, then include it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |    4 ++++
 net/bluetooth/mgmt.c             |   13 +++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0db4f80..b7106f9 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -159,6 +159,10 @@ struct hci_dev {
 	__u16		voice_setting;
 	__u8		io_capability;
 	__s8		inq_tx_power;
+	__u16		devid_source;
+	__u16		devid_vendor;
+	__u16		devid_product;
+	__u16		devid_version;
 
 	__u16		pkt_type;
 	__u16		esco_type;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 32f6e29..6fb1418 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -488,6 +488,19 @@ static void create_eir(struct hci_dev *hdev, u8 *data)
 		ptr += 3;
 	}
 
+	if (hdev->devid_source > 0) {
+		ptr[0] = 9;
+		ptr[1] = EIR_DEVICE_ID;
+
+		put_unaligned_le16(hdev->devid_source, ptr + 2);
+		put_unaligned_le16(hdev->devid_vendor, ptr + 4);
+		put_unaligned_le16(hdev->devid_product, ptr + 6);
+		put_unaligned_le16(hdev->devid_version, ptr + 8);
+
+		eir_len += 10;
+		ptr += 10;
+	}
+
 	memset(uuid16_list, 0, sizeof(uuid16_list));
 
 	/* Group all UUID16 types */
-- 
1.7.7.6

