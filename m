Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Rename pairable mgmt setting to bondable
Date: Wed, 30 Jul 2014 09:22:23 +0300
Message-Id: <1406701344-23842-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1406701344-23842-1-git-send-email-johan.hedberg@gmail.com>
References: <1406701344-23842-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This setting maps to the HCI_BONDABLE flag which tracks whether we're
bondable or not. Therefore, rename the mgmt setting and respective
command accordingly.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/mgmt.h |  4 ++--
 net/bluetooth/mgmt.c         | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 623d5203c592..414cd2f9a437 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -87,7 +87,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_CONNECTABLE	0x00000002
 #define MGMT_SETTING_FAST_CONNECTABLE	0x00000004
 #define MGMT_SETTING_DISCOVERABLE	0x00000008
-#define MGMT_SETTING_PAIRABLE		0x00000010
+#define MGMT_SETTING_BONDABLE		0x00000010
 #define MGMT_SETTING_LINK_SECURITY	0x00000020
 #define MGMT_SETTING_SSP		0x00000040
 #define MGMT_SETTING_BREDR		0x00000080
@@ -131,7 +131,7 @@ struct mgmt_cp_set_discoverable {
 
 #define MGMT_OP_SET_FAST_CONNECTABLE	0x0008
 
-#define MGMT_OP_SET_PAIRABLE		0x0009
+#define MGMT_OP_SET_BONDABLE		0x0009
 
 #define MGMT_OP_SET_LINK_SECURITY	0x000A
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index edb1a62054c9..b8554d429d88 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -44,7 +44,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_SET_DISCOVERABLE,
 	MGMT_OP_SET_CONNECTABLE,
 	MGMT_OP_SET_FAST_CONNECTABLE,
-	MGMT_OP_SET_PAIRABLE,
+	MGMT_OP_SET_BONDABLE,
 	MGMT_OP_SET_LINK_SECURITY,
 	MGMT_OP_SET_SSP,
 	MGMT_OP_SET_HS,
@@ -553,7 +553,7 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 	u32 settings = 0;
 
 	settings |= MGMT_SETTING_POWERED;
-	settings |= MGMT_SETTING_PAIRABLE;
+	settings |= MGMT_SETTING_BONDABLE;
 	settings |= MGMT_SETTING_DEBUG_KEYS;
 	settings |= MGMT_SETTING_CONNECTABLE;
 	settings |= MGMT_SETTING_DISCOVERABLE;
@@ -604,7 +604,7 @@ static u32 get_current_settings(struct hci_dev *hdev)
 		settings |= MGMT_SETTING_DISCOVERABLE;
 
 	if (test_bit(HCI_BONDABLE, &hdev->dev_flags))
-		settings |= MGMT_SETTING_PAIRABLE;
+		settings |= MGMT_SETTING_BONDABLE;
 
 	if (test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
 		settings |= MGMT_SETTING_BREDR;
@@ -1930,7 +1930,7 @@ failed:
 	return err;
 }
 
-static int set_pairable(struct sock *sk, struct hci_dev *hdev, void *data,
+static int set_bondable(struct sock *sk, struct hci_dev *hdev, void *data,
 			u16 len)
 {
 	struct mgmt_mode *cp = data;
@@ -1940,7 +1940,7 @@ static int set_pairable(struct sock *sk, struct hci_dev *hdev, void *data,
 	BT_DBG("request for %s", hdev->name);
 
 	if (cp->val != 0x00 && cp->val != 0x01)
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_PAIRABLE,
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_BONDABLE,
 				  MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
@@ -1950,7 +1950,7 @@ static int set_pairable(struct sock *sk, struct hci_dev *hdev, void *data,
 	else
 		changed = test_and_clear_bit(HCI_BONDABLE, &hdev->dev_flags);
 
-	err = send_settings_rsp(sk, MGMT_OP_SET_PAIRABLE, hdev);
+	err = send_settings_rsp(sk, MGMT_OP_SET_BONDABLE, hdev);
 	if (err < 0)
 		goto unlock;
 
@@ -5679,7 +5679,7 @@ static const struct mgmt_handler {
 	{ set_discoverable,       false, MGMT_SET_DISCOVERABLE_SIZE },
 	{ set_connectable,        false, MGMT_SETTING_SIZE },
 	{ set_fast_connectable,   false, MGMT_SETTING_SIZE },
-	{ set_pairable,           false, MGMT_SETTING_SIZE },
+	{ set_bondable,           false, MGMT_SETTING_SIZE },
 	{ set_link_security,      false, MGMT_SETTING_SIZE },
 	{ set_ssp,                false, MGMT_SETTING_SIZE },
 	{ set_hs,                 false, MGMT_SETTING_SIZE },
-- 
1.9.3

