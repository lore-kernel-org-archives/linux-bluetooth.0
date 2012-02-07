Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <aguedespe@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: andre.guedes@openbossa.org
Subject: [PATCH 2/3] Bluetooth: Create thread-safe advertising cache functions
Date: Tue,  7 Feb 2012 01:29:56 -0300
Message-Id: <1328588997-25029-3-git-send-email-aguedespe@gmail.com>
In-Reply-To: <1328588997-25029-1-git-send-email-aguedespe@gmail.com>
References: <1328588997-25029-1-git-send-email-aguedespe@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch creates thread-safe versions of advertising cache add/
find/clear functions.

Signed-off-by: Andre Guedes <aguedespe@gmail.com>
---
 include/net/bluetooth/hci_core.h |    4 ++++
 net/bluetooth/hci_core.c         |   34 ++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a6fccca..ca52a88 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -677,6 +677,10 @@ int __hci_adv_entries_clear(struct hci_dev *hdev);
 struct adv_entry *__hci_find_adv_entry(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int __hci_add_adv_entry(struct hci_dev *hdev,
 					struct hci_ev_le_advertising_info *ev);
+int hci_adv_entries_clear(struct hci_dev *hdev);
+struct adv_entry *hci_find_adv_entry(struct hci_dev *hdev, bdaddr_t *bdaddr);
+int hci_add_adv_entry(struct hci_dev *hdev,
+					struct hci_ev_le_advertising_info *ev);
 
 void hci_del_off_timer(struct hci_dev *hdev);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 362b1ab..536248d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1603,6 +1603,40 @@ int __hci_add_adv_entry(struct hci_dev *hdev,
 	return 0;
 }
 
+struct adv_entry *hci_find_adv_entry(struct hci_dev *hdev, bdaddr_t *bdaddr)
+{
+	struct adv_entry *entry;
+
+	hci_dev_lock(hdev);
+	entry = __hci_find_adv_entry(hdev, bdaddr);
+	hci_dev_unlock(hdev);
+
+	return entry;
+}
+
+int hci_adv_entries_clear(struct hci_dev *hdev)
+{
+	int res;
+
+	hci_dev_lock(hdev);
+	res = __hci_adv_entries_clear(hdev);
+	hci_dev_unlock(hdev);
+
+	return res;
+}
+
+int hci_add_adv_entry(struct hci_dev *hdev,
+					struct hci_ev_le_advertising_info *ev)
+{
+	int res;
+
+	hci_dev_lock(hdev);
+	res = __hci_add_adv_entry(hdev, ev);
+	hci_dev_unlock(hdev);
+
+	return res;
+}
+
 static void le_scan_param_req(struct hci_dev *hdev, unsigned long opt)
 {
 	struct le_scan_params *param =  (struct le_scan_params *) opt;
-- 
1.7.9

