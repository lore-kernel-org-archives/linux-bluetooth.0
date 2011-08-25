Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 05/13] Bluetooth: Add support for cleaning the SMP key list
Date: Thu, 25 Aug 2011 20:02:31 -0300
Message-Id: <1314313359-12652-6-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1314313359-12652-1-git-send-email-vcgomes@gmail.com>
References: <1314313359-12652-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_core.c         |   14 ++++++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8ae02c7..4da0f16 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -593,6 +593,7 @@ int hci_link_keys_clear(struct hci_dev *hdev);
 struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 			bdaddr_t *bdaddr, u8 *val, u8 type, u8 pin_len);
+int hci_smp_keys_clear(struct hci_dev *hdev);
 struct link_key *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8]);
 struct link_key *hci_find_link_key_type(struct hci_dev *hdev,
 					bdaddr_t *bdaddr, u8 type);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0f1d2d8..6f05cc5 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1005,6 +1005,18 @@ int hci_link_keys_clear(struct hci_dev *hdev)
 	return 0;
 }
 
+int hci_smp_keys_clear(struct hci_dev *hdev)
+{
+	struct smp_link_key *k, *tmp;
+
+	list_for_each_entry_safe(k, tmp, &hdev->smp_keys, list) {
+		list_del(&k->list);
+		kfree(k);
+	}
+
+	return 0;
+}
+
 struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 {
 	struct list_head *p;
@@ -1486,6 +1498,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	INIT_LIST_HEAD(&hdev->uuids);
 
 	INIT_LIST_HEAD(&hdev->link_keys);
+	INIT_LIST_HEAD(&hdev->smp_keys);
 
 	INIT_LIST_HEAD(&hdev->remote_oob_data);
 
@@ -1573,6 +1586,7 @@ int hci_unregister_dev(struct hci_dev *hdev)
 	hci_blacklist_clear(hdev);
 	hci_uuids_clear(hdev);
 	hci_link_keys_clear(hdev);
+	hci_smp_keys_clear(hdev);
 	hci_remote_oob_data_clear(hdev);
 	hci_adv_entries_clear(hdev);
 	hci_dev_unlock_bh(hdev);
-- 
1.7.6

