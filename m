Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v11 10/15] Bluetooth: Auto connection and power on
Date: Mon, 24 Feb 2014 19:30:56 -0300
Message-Id: <1393281061-14320-11-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1393281061-14320-1-git-send-email-andre.guedes@openbossa.org>
References: <1393281061-14320-1-git-send-email-andre.guedes@openbossa.org>
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
index 831cca8..e78e48e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2266,6 +2266,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	hci_dev_lock(hdev);
 	hci_inquiry_cache_flush(hdev);
 	hci_conn_hash_flush(hdev);
+	hci_pend_le_conns_clear(hdev);
 	hci_dev_unlock(hdev);
 
 	hci_notify(hdev, HCI_DEV_DOWN);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7c8a611..a08c2bf 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4662,6 +4662,17 @@ void mgmt_index_removed(struct hci_dev *hdev)
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
@@ -4670,6 +4681,8 @@ static void powered_complete(struct hci_dev *hdev, u8 status)
 
 	hci_dev_lock(hdev);
 
+	restart_le_auto_conns(hdev);
+
 	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
 
 	new_settings(hdev, match.sk);
-- 
1.8.5.4

