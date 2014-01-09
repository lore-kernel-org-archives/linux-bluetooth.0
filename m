Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/10] Bluetooth: Add flags and setting for Secure Connections support
Date: Thu,  9 Jan 2014 12:56:27 -0800
Message-Id: <1389300990-20255-7-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The MGMT_SETTING_SECURE_CONN setting is used to track the support and
status for Secure Connections from the management interface. For HCI
based tracking HCI_SC_ENABLED flag is used.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h  | 1 +
 include/net/bluetooth/mgmt.h | 1 +
 net/bluetooth/mgmt.c         | 7 +++++++
 3 files changed, 9 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 238a5f3a0661..d38202500206 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -122,6 +122,7 @@ enum {
 
 	HCI_LE_SCAN,
 	HCI_SSP_ENABLED,
+	HCI_SC_ENABLED,
 	HCI_HS_ENABLED,
 	HCI_LE_ENABLED,
 	HCI_ADVERTISING,
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 518c5c84e39a..4ec17dec62e0 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -94,6 +94,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_HS			0x00000100
 #define MGMT_SETTING_LE			0x00000200
 #define MGMT_SETTING_ADVERTISING	0x00000400
+#define MGMT_SETTING_SECURE_CONN	0x00000800
 
 #define MGMT_OP_READ_INFO		0x0004
 #define MGMT_READ_INFO_SIZE		0
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a03ca3ca91bf..b00fa0253cba 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -79,6 +79,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_SET_BREDR,
 	MGMT_OP_SET_STATIC_ADDRESS,
 	MGMT_OP_SET_SCAN_PARAMS,
+	MGMT_OP_SET_SECURE_CONN,
 };
 
 static const u16 mgmt_events[] = {
@@ -376,6 +377,9 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 			settings |= MGMT_SETTING_SSP;
 			settings |= MGMT_SETTING_HS;
 		}
+
+		if (lmp_sc_capable(hdev))
+			settings |= MGMT_SETTING_SECURE_CONN;
 	}
 
 	if (lmp_le_capable(hdev)) {
@@ -423,6 +427,9 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags))
 		settings |= MGMT_SETTING_ADVERTISING;
 
+	if (test_bit(HCI_SC_ENABLED, &hdev->dev_flags))
+		settings |= MGMT_SETTING_SECURE_CONN;
+
 	return settings;
 }
 
-- 
1.8.4.2

