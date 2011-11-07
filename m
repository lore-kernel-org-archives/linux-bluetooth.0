Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Fix mgmt response when HCI_Write_Scan_Enable fails
Date: Mon,  7 Nov 2011 22:16:03 +0200
Message-Id: <1320696964-3582-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1320696964-3582-1-git-send-email-johan.hedberg@gmail.com>
References: <1320696964-3582-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

A proper mgmt_command_status should be returned to user-space if either
discoverable or connectable enabling fails.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_event.c        |    9 ++++++---
 net/bluetooth/mgmt.c             |   13 +++++++++++++
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5803c1e..c233bce 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -911,6 +911,7 @@ int mgmt_index_removed(u16 index);
 int mgmt_powered(u16 index, u8 powered);
 int mgmt_discoverable(u16 index, u8 discoverable);
 int mgmt_connectable(u16 index, u8 connectable);
+int mgmt_write_scan_failed(u16 index, u8 scan, u8 status);
 int mgmt_new_key(u16 index, struct link_key *key, u8 persistent);
 int mgmt_connected(u16 index, bdaddr_t *bdaddr, u8 link_type);
 int mgmt_disconnected(u16 index, bdaddr_t *bdaddr);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index cf99265..176ceca 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -280,11 +280,14 @@ static void hci_cc_write_scan_enable(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!sent)
 		return;
 
-	if (status != 0)
-		goto done;
-
 	param = *((__u8 *) sent);
 
+	if (status != 0) {
+		mgmt_write_scan_failed(hdev->id, param, status);
+		hdev->discov_timeout = 0;
+		goto done;
+	}
+
 	old_pscan = test_and_clear_bit(HCI_PSCAN, &hdev->flags);
 	old_iscan = test_and_clear_bit(HCI_ISCAN, &hdev->flags);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 724d4fe..0cb023e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2056,6 +2056,19 @@ int mgmt_connectable(u16 index, u8 connectable)
 	return ret;
 }
 
+int mgmt_write_scan_failed(u16 index, u8 scan, u8 status)
+{
+	if (scan & SCAN_PAGE)
+		mgmt_pending_foreach(MGMT_OP_SET_CONNECTABLE, index,
+						cmd_status_rsp, &status);
+
+	if (scan & SCAN_INQUIRY)
+		mgmt_pending_foreach(MGMT_OP_SET_DISCOVERABLE, index,
+						cmd_status_rsp, &status);
+
+	return 0;
+}
+
 int mgmt_new_key(u16 index, struct link_key *key, u8 persistent)
 {
 	struct mgmt_ev_new_key ev;
-- 
1.7.7.1

