Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Rename HCI_LE_PERIPHERAL to HCI_ADVERTISING
Date: Sat,  5 Oct 2013 12:01:04 +0200
Message-Id: <1380967266-28782-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1380967266-28782-1-git-send-email-johan.hedberg@gmail.com>
References: <1380967266-28782-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This flag is used to indicate whether we want to have advertising
enabled or not, so give it a more suitable name.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h |  2 +-
 net/bluetooth/hci_conn.c    |  2 +-
 net/bluetooth/hci_core.c    |  2 +-
 net/bluetooth/hci_event.c   |  6 +++---
 net/bluetooth/mgmt.c        | 18 +++++++++---------
 5 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index b90eec5..e8bba05 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -118,7 +118,7 @@ enum {
 	HCI_SSP_ENABLED,
 	HCI_HS_ENABLED,
 	HCI_LE_ENABLED,
-	HCI_LE_PERIPHERAL,
+	HCI_ADVERTISING,
 	HCI_CONNECTABLE,
 	HCI_DISCOVERABLE,
 	HCI_LINK_SECURITY,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 08e601c..8b0d08f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -546,7 +546,7 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 {
 	struct hci_conn *conn;
 
-	if (test_bit(HCI_LE_PERIPHERAL, &hdev->flags))
+	if (test_bit(HCI_ADVERTISING, &hdev->flags))
 		return ERR_PTR(-ENOTSUPP);
 
 	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 82dbdc6..aa63ebb 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1105,7 +1105,7 @@ static u8 create_ad(struct hci_dev *hdev, u8 *ptr)
 	u8 ad_len = 0, flags = 0;
 	size_t name_len;
 
-	if (test_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags))
+	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags))
 		flags |= LE_AD_GENERAL;
 
 	if (test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4785ab0..e1ad858 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -918,9 +918,9 @@ static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (!status) {
 		if (*sent)
-			set_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags);
+			set_bit(HCI_ADVERTISING, &hdev->dev_flags);
 		else
-			clear_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags);
+			clear_bit(HCI_ADVERTISING, &hdev->dev_flags);
 	}
 
 	if (!test_bit(HCI_INIT, &hdev->flags)) {
@@ -1005,7 +1005,7 @@ static void hci_cc_write_le_host_supported(struct hci_dev *hdev,
 		} else {
 			hdev->features[1][0] &= ~LMP_HOST_LE;
 			clear_bit(HCI_LE_ENABLED, &hdev->dev_flags);
-			clear_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags);
+			clear_bit(HCI_ADVERTISING, &hdev->dev_flags);
 		}
 
 		if (sent->simul)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 16125ff9..7e43d37 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -425,7 +425,7 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (test_bit(HCI_HS_ENABLED, &hdev->dev_flags))
 		settings |= MGMT_SETTING_HS;
 
-	if (test_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags))
+	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags))
 		settings |= MGMT_SETTING_ADVERTISING;
 
 	return settings;
@@ -1463,8 +1463,8 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 			changed = true;
 		}
 
-		if (!val && test_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags)) {
-			clear_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags);
+		if (!val && test_bit(HCI_ADVERTISING, &hdev->dev_flags)) {
+			clear_bit(HCI_ADVERTISING, &hdev->dev_flags);
 			changed = true;
 		}
 
@@ -1500,7 +1500,7 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	hci_req_init(&req, hdev);
 
-	if (test_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags) && !val)
+	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags) && !val)
 		hci_req_add(&req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(val), &val);
 
 	hci_req_add(&req, HCI_OP_WRITE_LE_HOST_SUPPORTED, sizeof(hci_cp),
@@ -2888,7 +2888,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 			goto failed;
 		}
 
-		if (test_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags)) {
+		if (test_bit(HCI_ADVERTISING, &hdev->dev_flags)) {
 			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
 					 MGMT_STATUS_REJECTED);
 			mgmt_pending_remove(cmd);
@@ -3236,13 +3236,13 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data, u1
 	hci_dev_lock(hdev);
 
 	val = !!cp->val;
-	enabled = test_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags);
+	enabled = test_bit(HCI_ADVERTISING, &hdev->dev_flags);
 
 	if (!hdev_is_powered(hdev) || val == enabled) {
 		bool changed = false;
 
-		if (val != test_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags)) {
-			change_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags);
+		if (val != test_bit(HCI_ADVERTISING, &hdev->dev_flags)) {
+			change_bit(HCI_ADVERTISING, &hdev->dev_flags);
 			changed = true;
 		}
 
@@ -3851,7 +3851,7 @@ static int powered_update_hci(struct hci_dev *hdev)
 				    &hdev->static_addr);
 	}
 
-	if (test_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags)) {
+	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags)) {
 		u8 adv = 0x01;
 
 		hci_req_add(&req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(adv), &adv);
-- 
1.8.3.1

