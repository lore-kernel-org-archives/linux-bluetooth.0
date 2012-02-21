Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/9] Bluetooth: mgmt: Add convenience function for sending New Settings
Date: Tue, 21 Feb 2012 18:00:01 +0200
Message-Id: <1329840005-4977-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1329840005-4977-1-git-send-email-johan.hedberg@gmail.com>
References: <1329840005-4977-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The New Settings event needs to be sent from quite many places so it
makes sense to have a convenience function for it to simplify the code.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   96 +++++++++++++++++++++++---------------------------
 1 files changed, 44 insertions(+), 52 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 629bed1..74b6db1 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -788,6 +788,42 @@ failed:
 	return err;
 }
 
+static int mgmt_event(u16 event, struct hci_dev *hdev, void *data,
+					u16 data_len, struct sock *skip_sk)
+{
+	struct sk_buff *skb;
+	struct mgmt_hdr *hdr;
+
+	skb = alloc_skb(sizeof(*hdr) + data_len, GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
+
+	hdr = (void *) skb_put(skb, sizeof(*hdr));
+	hdr->opcode = cpu_to_le16(event);
+	if (hdev)
+		hdr->index = cpu_to_le16(hdev->id);
+	else
+		hdr->index = cpu_to_le16(MGMT_INDEX_NONE);
+	hdr->len = cpu_to_le16(data_len);
+
+	if (data)
+		memcpy(skb_put(skb, data_len), data, data_len);
+
+	hci_send_to_control(skb, skip_sk);
+	kfree_skb(skb);
+
+	return 0;
+}
+
+static int new_settings(struct hci_dev *hdev, struct sock *skip)
+{
+	__le32 ev;
+
+	ev = cpu_to_le32(get_current_settings(hdev));
+
+	return mgmt_event(MGMT_EV_NEW_SETTINGS, hdev, &ev, sizeof(ev), skip);
+}
+
 static int set_discoverable(struct sock *sk, u16 index, void *data, u16 len)
 {
 	struct mgmt_cp_set_discoverable *cp = data;
@@ -933,38 +969,10 @@ failed:
 	return err;
 }
 
-static int mgmt_event(u16 event, struct hci_dev *hdev, void *data,
-					u16 data_len, struct sock *skip_sk)
-{
-	struct sk_buff *skb;
-	struct mgmt_hdr *hdr;
-
-	skb = alloc_skb(sizeof(*hdr) + data_len, GFP_ATOMIC);
-	if (!skb)
-		return -ENOMEM;
-
-	hdr = (void *) skb_put(skb, sizeof(*hdr));
-	hdr->opcode = cpu_to_le16(event);
-	if (hdev)
-		hdr->index = cpu_to_le16(hdev->id);
-	else
-		hdr->index = cpu_to_le16(MGMT_INDEX_NONE);
-	hdr->len = cpu_to_le16(data_len);
-
-	if (data)
-		memcpy(skb_put(skb, data_len), data, data_len);
-
-	hci_send_to_control(skb, skip_sk);
-	kfree_skb(skb);
-
-	return 0;
-}
-
 static int set_pairable(struct sock *sk, u16 index, void *data, u16 len)
 {
 	struct mgmt_mode *cp = data;
 	struct hci_dev *hdev;
-	__le32 ev;
 	int err;
 
 	BT_DBG("request for hci%u", index);
@@ -989,9 +997,7 @@ static int set_pairable(struct sock *sk, u16 index, void *data, u16 len)
 	if (err < 0)
 		goto failed;
 
-	ev = cpu_to_le32(get_current_settings(hdev));
-
-	err = mgmt_event(MGMT_EV_NEW_SETTINGS, hdev, &ev, sizeof(ev), sk);
+	err = new_settings(hdev, sk);
 
 failed:
 	hci_dev_unlock(hdev);
@@ -2877,7 +2883,6 @@ static void settings_rsp(struct pending_cmd *cmd, void *data)
 int mgmt_powered(struct hci_dev *hdev, u8 powered)
 {
 	struct cmd_lookup match = { NULL, hdev };
-	__le32 ev;
 	int err;
 
 	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
@@ -2900,10 +2905,7 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
 		mgmt_pending_foreach(0, hdev, cmd_status_rsp, &status);
 	}
 
-	ev = cpu_to_le32(get_current_settings(hdev));
-
-	err = mgmt_event(MGMT_EV_NEW_SETTINGS, hdev, &ev, sizeof(ev),
-								match.sk);
+	err = new_settings(hdev, match.sk);
 
 	if (match.sk)
 		sock_put(match.sk);
@@ -2927,11 +2929,8 @@ int mgmt_discoverable(struct hci_dev *hdev, u8 discoverable)
 			changed = true;
 	}
 
-	if (changed) {
-		__le32 ev = cpu_to_le32(get_current_settings(hdev));
-		err = mgmt_event(MGMT_EV_NEW_SETTINGS, hdev, &ev, sizeof(ev),
-								match.sk);
-	}
+	if (changed)
+		err = new_settings(hdev, match.sk);
 
 	if (match.sk)
 		sock_put(match.sk);
@@ -2956,11 +2955,8 @@ int mgmt_connectable(struct hci_dev *hdev, u8 connectable)
 			changed = true;
 	}
 
-	if (changed) {
-		__le32 ev = cpu_to_le32(get_current_settings(hdev));
-		err = mgmt_event(MGMT_EV_NEW_SETTINGS, hdev, &ev, sizeof(ev),
-								match.sk);
-	}
+	if (changed)
+		err = new_settings(hdev, match.sk);
 
 	if (match.sk)
 		sock_put(match.sk);
@@ -3295,7 +3291,6 @@ int mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 int mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status)
 {
 	struct cmd_lookup match = { NULL, hdev };
-	__le32 ev;
 	int err;
 
 	if (status) {
@@ -3308,8 +3303,7 @@ int mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status)
 	mgmt_pending_foreach(MGMT_OP_SET_LINK_SECURITY, hdev, settings_rsp,
 								&match);
 
-	ev = cpu_to_le32(get_current_settings(hdev));
-	err = mgmt_event(MGMT_EV_NEW_SETTINGS, hdev, &ev, sizeof(ev), match.sk);
+	err = new_settings(hdev, match.sk);
 
 	if (match.sk)
 		sock_put(match.sk);
@@ -3332,7 +3326,6 @@ static int clear_eir(struct hci_dev *hdev)
 int mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 status)
 {
 	struct cmd_lookup match = { NULL, hdev };
-	__le32 ev;
 	int err;
 
 	if (status) {
@@ -3344,8 +3337,7 @@ int mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 status)
 
 	mgmt_pending_foreach(MGMT_OP_SET_SSP, hdev, settings_rsp, &match);
 
-	ev = cpu_to_le32(get_current_settings(hdev));
-	err = mgmt_event(MGMT_EV_NEW_SETTINGS, hdev, &ev, sizeof(ev), match.sk);
+	err = new_settings(hdev, match.sk);
 
 	if (match.sk) {
 		sock_put(match.sk);
-- 
1.7.9

