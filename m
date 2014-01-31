Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Add management setting for use of debug keys
Date: Fri, 31 Jan 2014 11:55:21 -0800
Message-Id: <1391198123-55506-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the controller has been enabled to allow usage of debug keys, then
clearly identify that in the current settings information.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/mgmt.h |  1 +
 net/bluetooth/mgmt.c         | 12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index e19049fb6c46..f87f5d784c3b 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -95,6 +95,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_LE			0x00000200
 #define MGMT_SETTING_ADVERTISING	0x00000400
 #define MGMT_SETTING_SECURE_CONN	0x00000800
+#define MGMT_SETTING_DEBUG_KEYS		0x00001000
 
 #define MGMT_OP_READ_INFO		0x0004
 #define MGMT_READ_INFO_SIZE		0
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 111b1296a2b8..91ffecd1727e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -364,6 +364,7 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 
 	settings |= MGMT_SETTING_POWERED;
 	settings |= MGMT_SETTING_PAIRABLE;
+	settings |= MGMT_SETTING_DEBUG_KEYS;
 
 	if (lmp_bredr_capable(hdev)) {
 		settings |= MGMT_SETTING_CONNECTABLE;
@@ -431,6 +432,9 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (test_bit(HCI_SC_ENABLED, &hdev->dev_flags))
 		settings |= MGMT_SETTING_SECURE_CONN;
 
+	if (test_bit(HCI_DEBUG_KEYS, &hdev->dev_flags))
+		settings |= MGMT_SETTING_DEBUG_KEYS;
+
 	return settings;
 }
 
@@ -2207,6 +2211,7 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 {
 	struct mgmt_cp_load_link_keys *cp = data;
 	u16 key_count, expected_len;
+	bool changed;
 	int i;
 
 	BT_DBG("request for %s", hdev->name);
@@ -2246,9 +2251,12 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 	hci_link_keys_clear(hdev);
 
 	if (cp->debug_keys)
-		set_bit(HCI_DEBUG_KEYS, &hdev->dev_flags);
+		changed = !test_and_set_bit(HCI_DEBUG_KEYS, &hdev->dev_flags);
 	else
-		clear_bit(HCI_DEBUG_KEYS, &hdev->dev_flags);
+		changed = test_and_clear_bit(HCI_DEBUG_KEYS, &hdev->dev_flags);
+
+	if (changed)
+		new_settings(hdev, NULL);
 
 	for (i = 0; i < key_count; i++) {
 		struct mgmt_link_key_info *key = &cp->keys[i];
-- 
1.8.5.3

