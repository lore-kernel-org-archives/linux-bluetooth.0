Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: Remove unused member from cmd_lookup struct
Date: Fri, 17 Feb 2012 01:22:55 +0200
Message-Id: <1329434578-5928-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The val member of cmd_lookup isn't used anywhere so it can be removed.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 066d338..5520858 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2561,7 +2561,6 @@ int mgmt_index_removed(struct hci_dev *hdev)
 }
 
 struct cmd_lookup {
-	u8 val;
 	struct sock *sk;
 	struct hci_dev *hdev;
 };
@@ -2584,7 +2583,7 @@ static void settings_rsp(struct pending_cmd *cmd, void *data)
 
 int mgmt_powered(struct hci_dev *hdev, u8 powered)
 {
-	struct cmd_lookup match = { powered, NULL, hdev };
+	struct cmd_lookup match = { NULL, hdev };
 	__le32 ev;
 	int ret;
 
@@ -2608,7 +2607,7 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
 
 int mgmt_discoverable(struct hci_dev *hdev, u8 discoverable)
 {
-	struct cmd_lookup match = { discoverable, NULL, hdev };
+	struct cmd_lookup match = { NULL, hdev };
 	__le32 ev;
 	int ret;
 
@@ -2627,7 +2626,7 @@ int mgmt_discoverable(struct hci_dev *hdev, u8 discoverable)
 int mgmt_connectable(struct hci_dev *hdev, u8 connectable)
 {
 	__le32 ev;
-	struct cmd_lookup match = { connectable, NULL, hdev };
+	struct cmd_lookup match = { NULL, hdev };
 	int ret;
 
 	mgmt_pending_foreach(MGMT_OP_SET_CONNECTABLE, hdev, settings_rsp,
-- 
1.7.9

