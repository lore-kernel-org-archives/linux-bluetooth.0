Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v6 12/14] Bluetooth: Auto connection and power on
Date: Thu, 30 Jan 2014 18:22:15 -0300
Message-Id: <1391116937-28217-13-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1391116937-28217-1-git-send-email-andre.guedes@openbossa.org>
References: <1391116937-28217-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When hdev is closed (e.g. Mgmt power off command, RFKILL or controller
is reset), the ongoing active connections are silently dropped by the
controller (no Disconnection Complete Event is sent to host). For that
reason, the devices that require HCI_AUTO_CONN_ALWAYS are not added to
hdev->pend_le_conns list and they won't auto connect.

So to fix this issue, during hdev closing, we remove all pending LE
connections. After adapter is powered on, we add a pending LE connection
for each HCI_AUTO_CONN_ALWAYS address.

This way, the auto connection mechanism works propely after a power
off and power on sequence as well as RFKILL block/unblock.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_core.c |  1 +
 net/bluetooth/mgmt.c     | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index cc9053d..9dba381 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2100,6 +2100,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	hci_dev_lock(hdev);
 	hci_inquiry_cache_flush(hdev);
 	hci_conn_hash_flush(hdev);
+	hci_pend_le_conns_clear(hdev);
 	hci_dev_unlock(hdev);
 
 	hci_notify(hdev, HCI_DEV_DOWN);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 8026e5f..31acc44 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4358,6 +4358,17 @@ void mgmt_index_removed(struct hci_dev *hdev)
 	mgmt_event(MGMT_EV_INDEX_REMOVED, hdev, NULL, 0, NULL);
 }
 
+/* This function requires the caller holds hdev->lock */
+static void restart_le_auto_conns(struct hci_dev *hdev)
+{
+	struct hci_conn_params *p;
+
+	list_for_each_entry(p, &hdev->le_conn_params, list) {
+		if (p->auto_connect == HCI_AUTO_CONN_ALWAYS)
+			hci_pend_le_conn_add(hdev, &p->addr, p->addr_type);
+	}
+}
+
 static void powered_complete(struct hci_dev *hdev, u8 status)
 {
 	struct cmd_lookup match = { NULL, hdev };
@@ -4366,6 +4377,8 @@ static void powered_complete(struct hci_dev *hdev, u8 status)
 
 	hci_dev_lock(hdev);
 
+	restart_le_auto_conns(hdev);
+
 	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
 
 	new_settings(hdev, match.sk);
-- 
1.8.5.3

