Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Fix line splitting of mgmt_device_found parameters
Date: Tue, 25 Mar 2014 12:06:19 +0200
Message-Id: <1395741979-23319-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1395741979-23319-1-git-send-email-johan.hedberg@gmail.com>
References: <1395741979-23319-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The line was incorrectly split between the variable type and its name.
This patch fixes the issue.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 4 ++--
 net/bluetooth/mgmt.c             | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 59b112397d39..0ba7617ceb27 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1268,8 +1268,8 @@ void mgmt_read_local_oob_data_complete(struct hci_dev *hdev, u8 *hash192,
 				       u8 *randomizer192, u8 *hash256,
 				       u8 *randomizer256, u8 status);
 void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-		       u8 addr_type, u8 *dev_class, s8 rssi, u8 cfm_name, u8
-		       ssp, u8 *eir, u16 eir_len, u8 *scan_rsp,
+		       u8 addr_type, u8 *dev_class, s8 rssi, u8 cfm_name,
+		       u8 ssp, u8 *eir, u16 eir_len, u8 *scan_rsp,
 		       u8 scan_rsp_len);
 void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		      u8 addr_type, s8 rssi, u8 *name, u8 name_len);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a0ef5c076880..37706e89af50 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5668,8 +5668,8 @@ void mgmt_read_local_oob_data_complete(struct hci_dev *hdev, u8 *hash192,
 }
 
 void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-		       u8 addr_type, u8 *dev_class, s8 rssi, u8 cfm_name, u8
-		       ssp, u8 *eir, u16 eir_len, u8 *scan_rsp,
+		       u8 addr_type, u8 *dev_class, s8 rssi, u8 cfm_name,
+		       u8 ssp, u8 *eir, u16 eir_len, u8 *scan_rsp,
 		       u8 scan_rsp_len)
 {
 	char buf[512];
-- 
1.8.5.3

