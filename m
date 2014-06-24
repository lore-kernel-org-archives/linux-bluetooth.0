Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/6] Bluetooth: Rename HCI_DEBUG_KEYS to HCI_KEEP_DEBUG_KEYS
Date: Tue, 24 Jun 2014 13:15:50 +0300
Message-Id: <1403604953-19539-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1403604953-19539-1-git-send-email-johan.hedberg@gmail.com>
References: <1403604953-19539-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We're planning to add a flag to actively use debug keys in addition to
simply just accepting them, which makes the current generically named
DEBUG_KEYS flag a bit confusing. Since the flag in practice affects
whether the kernel keeps debug keys around or not rename it to
HCI_KEEP_DEBUG_KEYS.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h |  2 +-
 net/bluetooth/hci_event.c   |  2 +-
 net/bluetooth/mgmt.c        | 14 +++++++++-----
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 6b8371d73d3d..ffb489e3946d 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -124,7 +124,7 @@ enum {
 	HCI_MGMT,
 	HCI_PAIRABLE,
 	HCI_SERVICE_CACHE,
-	HCI_DEBUG_KEYS,
+	HCI_KEEP_DEBUG_KEYS,
 	HCI_UNREGISTER,
 	HCI_USER_CHANNEL,
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 47bd48a597bd..b0fdeec2f2ca 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3066,7 +3066,7 @@ static void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	BT_DBG("%s found key type %u for %pMR", hdev->name, key->type,
 	       &ev->bdaddr);
 
-	if (!test_bit(HCI_DEBUG_KEYS, &hdev->dev_flags) &&
+	if (!test_bit(HCI_KEEP_DEBUG_KEYS, &hdev->dev_flags) &&
 	    key->type == HCI_LK_DEBUG_COMBINATION) {
 		BT_DBG("%s ignoring debug key", hdev->name);
 		goto not_found;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index bb5b04191253..634b44ddc9f9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -440,7 +440,7 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (test_bit(HCI_SC_ENABLED, &hdev->dev_flags))
 		settings |= MGMT_SETTING_SECURE_CONN;
 
-	if (test_bit(HCI_DEBUG_KEYS, &hdev->dev_flags))
+	if (test_bit(HCI_KEEP_DEBUG_KEYS, &hdev->dev_flags))
 		settings |= MGMT_SETTING_DEBUG_KEYS;
 
 	if (test_bit(HCI_PRIVACY, &hdev->dev_flags))
@@ -2414,9 +2414,11 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 	hci_link_keys_clear(hdev);
 
 	if (cp->debug_keys)
-		changed = !test_and_set_bit(HCI_DEBUG_KEYS, &hdev->dev_flags);
+		changed = !test_and_set_bit(HCI_KEEP_DEBUG_KEYS,
+					    &hdev->dev_flags);
 	else
-		changed = test_and_clear_bit(HCI_DEBUG_KEYS, &hdev->dev_flags);
+		changed = test_and_clear_bit(HCI_KEEP_DEBUG_KEYS,
+					     &hdev->dev_flags);
 
 	if (changed)
 		new_settings(hdev, NULL);
@@ -4349,9 +4351,11 @@ static int set_debug_keys(struct sock *sk, struct hci_dev *hdev,
 	hci_dev_lock(hdev);
 
 	if (cp->val)
-		changed = !test_and_set_bit(HCI_DEBUG_KEYS, &hdev->dev_flags);
+		changed = !test_and_set_bit(HCI_KEEP_DEBUG_KEYS,
+					    &hdev->dev_flags);
 	else
-		changed = test_and_clear_bit(HCI_DEBUG_KEYS, &hdev->dev_flags);
+		changed = test_and_clear_bit(HCI_KEEP_DEBUG_KEYS,
+					     &hdev->dev_flags);
 
 	err = send_settings_rsp(sk, MGMT_OP_SET_DEBUG_KEYS, hdev);
 	if (err < 0)
-- 
1.9.3

