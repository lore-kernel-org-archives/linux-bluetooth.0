Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Track number of added devices with HCI_AUTO_CONN_REPORT
Date: Wed,  2 Jul 2014 22:42:00 +0300
Message-Id: <1404330122-18770-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

To be able to make the right choice of whether to start passive scanning
or to send out a mgmt_device_found event we need to know if there are
any devices in the le_conn_params list with the auto_connect value set
to HCI_AUTO_CONN_REPORT. This patch adds a counter for this kind of
devices.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 92f1bad6e22d..b5f4405b41c2 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -312,6 +312,7 @@ struct hci_dev {
 	struct list_head	le_white_list;
 	struct list_head	le_conn_params;
 	struct list_head	pend_le_conns;
+	unsigned int		pend_le_reports;
 
 	struct hci_dev_stats	stat;
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index df25a8329ecc..8e0061f72dd1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3545,20 +3545,28 @@ int hci_conn_params_set(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 	if (!params)
 		return -EIO;
 
-	params->auto_connect = auto_connect;
+	if (params->auto_connect == HCI_AUTO_CONN_REPORT &&
+	    auto_connect != HCI_AUTO_CONN_REPORT)
+		hdev->pend_le_reports--;
 
 	switch (auto_connect) {
 	case HCI_AUTO_CONN_DISABLED:
-	case HCI_AUTO_CONN_REPORT:
 	case HCI_AUTO_CONN_LINK_LOSS:
 		hci_pend_le_conn_del(hdev, addr, addr_type);
 		break;
+	case HCI_AUTO_CONN_REPORT:
+		if (params->auto_connect != HCI_AUTO_CONN_REPORT)
+			hdev->pend_le_reports++;
+		hci_pend_le_conn_del(hdev, addr, addr_type);
+		break;
 	case HCI_AUTO_CONN_ALWAYS:
 		if (!is_connected(hdev, addr, addr_type))
 			hci_pend_le_conn_add(hdev, addr, addr_type);
 		break;
 	}
 
+	params->auto_connect = auto_connect;
+
 	BT_DBG("addr %pMR (type %u) auto_connect %u", addr, addr_type,
 	       auto_connect);
 
@@ -3574,6 +3582,9 @@ void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
 	if (!params)
 		return;
 
+	if (params->auto_connect == HCI_AUTO_CONN_REPORT)
+		hdev->pend_le_reports--;
+
 	hci_pend_le_conn_del(hdev, addr, addr_type);
 
 	list_del(&params->list);
@@ -3605,6 +3616,8 @@ void hci_conn_params_clear_enabled(struct hci_dev *hdev)
 	list_for_each_entry_safe(params, tmp, &hdev->le_conn_params, list) {
 		if (params->auto_connect == HCI_AUTO_CONN_DISABLED)
 			continue;
+		if (params->auto_connect == HCI_AUTO_CONN_REPORT)
+			hdev->pend_le_reports--;
 		list_del(&params->list);
 		kfree(params);
 	}
-- 
1.9.3

