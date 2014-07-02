Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 02/10] Bluetooth: Add specific connection parameter clear functions
Date: Wed,  2 Jul 2014 17:37:26 +0300
Message-Id: <1404311854-12233-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404311854-12233-1-git-send-email-johan.hedberg@gmail.com>
References: <1404311854-12233-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

In some circumstances we'll need to either clear only the enabled
parameters or only the disabled ones. This patch adds convenience
functions for this purpose.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_core.c         | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 091934bcfd84..2091e0013b8c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -862,6 +862,8 @@ int hci_conn_params_set(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 			u8 auto_connect);
 void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type);
 void hci_conn_params_clear_all(struct hci_dev *hdev);
+void hci_conn_params_clear_disabled(struct hci_dev *hdev);
+void hci_conn_params_clear_enabled(struct hci_dev *hdev);
 
 struct bdaddr_list *hci_pend_le_conn_lookup(struct hci_dev *hdev,
 					    bdaddr_t *addr, u8 addr_type);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e6e169007fd2..7e46a7c6092f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3580,6 +3580,38 @@ void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
 }
 
 /* This function requires the caller holds hdev->lock */
+void hci_conn_params_clear_disabled(struct hci_dev *hdev)
+{
+	struct hci_conn_params *params, *tmp;
+
+	list_for_each_entry_safe(params, tmp, &hdev->le_conn_params, list) {
+		if (params->auto_connect != HCI_AUTO_CONN_DISABLED)
+			continue;
+		list_del(&params->list);
+		kfree(params);
+	}
+
+	BT_DBG("All LE disabled connection parameters were removed");
+}
+
+/* This function requires the caller holds hdev->lock */
+void hci_conn_params_clear_enabled(struct hci_dev *hdev)
+{
+	struct hci_conn_params *params, *tmp;
+
+	list_for_each_entry_safe(params, tmp, &hdev->le_conn_params, list) {
+		if (params->auto_connect == HCI_AUTO_CONN_DISABLED)
+			continue;
+		list_del(&params->list);
+		kfree(params);
+	}
+
+	hci_pend_le_conns_clear(hdev);
+
+	BT_DBG("All enabled LE connection parameters were removed");
+}
+
+/* This function requires the caller holds hdev->lock */
 void hci_conn_params_clear_all(struct hci_dev *hdev)
 {
 	struct hci_conn_params *params, *tmp;
-- 
1.9.3

