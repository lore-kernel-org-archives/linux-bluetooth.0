Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Add support for New Configuration Options management event
Date: Fri,  4 Jul 2014 19:06:23 +0200
Message-Id: <1404493583-56960-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When one or more of the missing configuration options change, then send
this even to all the other management interface clients.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/mgmt.h |  2 ++
 net/bluetooth/mgmt.c         | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index c7d537f1bd19..80606d2fe086 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -669,3 +669,5 @@ struct mgmt_ev_new_conn_param {
 #define MGMT_EV_UNCONF_INDEX_ADDED	0x001d
 
 #define MGMT_EV_UNCONF_INDEX_REMOVED	0x001e
+
+#define MGMT_EV_NEW_CONFIG_OPTIONS	0x001f
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4ef73523d95b..f514eb15e0fb 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -123,6 +123,7 @@ static const u16 mgmt_events[] = {
 	MGMT_EV_NEW_CONN_PARAM,
 	MGMT_EV_UNCONF_INDEX_ADDED,
 	MGMT_EV_UNCONF_INDEX_REMOVED,
+	MGMT_EV_NEW_CONFIG_OPTIONS,
 };
 
 #define CACHE_TIMEOUT	msecs_to_jiffies(2 * 1000)
@@ -500,6 +501,14 @@ static __le32 get_missing_options(struct hci_dev *hdev)
 	return cpu_to_le32(options);
 }
 
+static int new_options(struct hci_dev *hdev, struct sock *skip)
+{
+	__le32 options = get_missing_options(hdev);
+
+	return mgmt_event(MGMT_EV_NEW_CONFIG_OPTIONS, hdev, &options,
+			  sizeof(options), skip);
+}
+
 static int send_options_rsp(struct sock *sk, u16 opcode, struct hci_dev *hdev)
 {
 	__le32 options = get_missing_options(hdev);
@@ -5415,6 +5424,8 @@ static int set_external_config(struct sock *sk, struct hci_dev *hdev,
 	if (!changed)
 		goto unlock;
 
+	err = new_options(hdev, sk);
+
 	if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags) == is_configured(hdev)) {
 		mgmt_index_removed(hdev);
 		change_bit(HCI_UNCONFIGURED, &hdev->dev_flags);
-- 
1.9.3

