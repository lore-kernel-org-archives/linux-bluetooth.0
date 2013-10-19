Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/9] Bluetooth: Move mgmt_pending_find to avoid forward declarations
Date: Sat, 19 Oct 2013 23:38:20 +0300
Message-Id: <1382215103-6968-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1382215103-6968-1-git-send-email-johan.hedberg@gmail.com>
References: <1382215103-6968-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We will soon need this function for updating the advertising data, so
move it higher up in mgmt.c to avoid a forward declaration.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 51d0446..20f6309 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -536,6 +536,18 @@ static u8 *create_uuid128_list(struct hci_dev *hdev, u8 *data, ptrdiff_t len)
 	return ptr;
 }
 
+static struct pending_cmd *mgmt_pending_find(u16 opcode, struct hci_dev *hdev)
+{
+	struct pending_cmd *cmd;
+
+	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
+		if (cmd->opcode == opcode)
+			return cmd;
+	}
+
+	return NULL;
+}
+
 static u8 create_scan_rsp_data(struct hci_dev *hdev, u8 *ptr)
 {
 	u8 ad_len = 0;
@@ -886,18 +898,6 @@ static void mgmt_pending_foreach(u16 opcode, struct hci_dev *hdev,
 	}
 }
 
-static struct pending_cmd *mgmt_pending_find(u16 opcode, struct hci_dev *hdev)
-{
-	struct pending_cmd *cmd;
-
-	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
-		if (cmd->opcode == opcode)
-			return cmd;
-	}
-
-	return NULL;
-}
-
 static void mgmt_pending_remove(struct pending_cmd *cmd)
 {
 	list_del(&cmd->list);
-- 
1.8.3.1

