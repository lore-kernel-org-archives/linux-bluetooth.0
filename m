Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 2/7] Bluetooth: Add new structures for handling SMP Long Term Keys
Date: Thu,  2 Feb 2012 21:08:00 -0300
Message-Id: <1328227685-27245-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1328227685-27245-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1328227685-27245-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This includes a new list for storing the keys and a new structure used
to represent each key.

Some notes: authenticated is used to identify that the key may be used
to setup a HIGH security link. As the same list is used to store both
the STK's and the LTK's the type field is used so we can separate
between those two types of keys and if the key should be used when
in the master or slave role.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h      |    5 +++++
 include/net/bluetooth/hci_core.h |   16 ++++++++++++++++
 net/bluetooth/hci_core.c         |   31 +++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index cb9097a..83f045a 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -274,6 +274,11 @@ enum {
 #define HCI_LK_SMP_LTK			0x81
 #define HCI_LK_SMP_IRK			0x82
 #define HCI_LK_SMP_CSRK			0x83
+/* The spec doesn't define types for SMP keys, the _MASTER suffix is implied */
+#define HCI_SMP_STK			0x80
+#define HCI_SMP_STK_SLAVE		0x81
+#define HCI_SMP_LTK			0x82
+#define HCI_SMP_LTK_SLAVE		0x83
 
 /* ---- HCI Error Codes ---- */
 #define HCI_ERROR_AUTH_FAILURE		0x05
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 896d9e4..c998176 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -88,6 +88,18 @@ struct bt_uuid {
 	u8 svc_hint;
 };
 
+struct smp_ltk {
+	struct list_head list;
+	bdaddr_t bdaddr;
+	u8 bdaddr_type;
+	u8 authenticated;
+	u8 type;
+	u8 enc_size;
+	__le16 ediv;
+	u8 rand[8];
+	u8 val[16];
+} __packed;
+
 struct key_master_id {
 	__le16 ediv;
 	u8 rand[8];
@@ -239,6 +251,8 @@ struct hci_dev {
 
 	struct list_head	link_keys;
 
+	struct list_head	long_term_keys;
+
 	struct list_head	remote_oob_data;
 
 	struct list_head	adv_entries;
@@ -647,8 +661,10 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 struct link_key *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8]);
 struct link_key *hci_find_link_key_type(struct hci_dev *hdev,
 					bdaddr_t *bdaddr, u8 type);
+int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int hci_add_ltk(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
 			u8 key_size, __le16 ediv, u8 rand[8], u8 ltk[16]);
+int hci_smp_ltks_clear(struct hci_dev *hdev);
 int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
 
 int hci_remote_oob_data_clear(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 45e2d2a..a28e637 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1163,6 +1163,18 @@ int hci_link_keys_clear(struct hci_dev *hdev)
 	return 0;
 }
 
+int hci_smp_ltks_clear(struct hci_dev *hdev)
+{
+	struct smp_ltk *k, *tmp;
+
+	list_for_each_entry_safe(k, tmp, &hdev->long_term_keys, list) {
+		list_del(&k->list);
+		kfree(k);
+	}
+
+	return 0;
+}
+
 struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 {
 	struct link_key *k;
@@ -1355,6 +1367,23 @@ int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 	return 0;
 }
 
+int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr)
+{
+	struct smp_ltk *k, *tmp;
+
+	list_for_each_entry_safe(k, tmp, &hdev->long_term_keys, list) {
+		if (bacmp(bdaddr, &k->bdaddr))
+			continue;
+
+		BT_DBG("%s removing %s", hdev->name, batostr(bdaddr));
+
+		list_del(&k->list);
+		kfree(k);
+	}
+
+	return 0;
+}
+
 /* HCI command timer function */
 static void hci_cmd_timer(unsigned long arg)
 {
@@ -1638,6 +1667,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	INIT_LIST_HEAD(&hdev->uuids);
 
 	INIT_LIST_HEAD(&hdev->link_keys);
+	INIT_LIST_HEAD(&hdev->long_term_keys);
 
 	INIT_LIST_HEAD(&hdev->remote_oob_data);
 
@@ -1739,6 +1769,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	hci_blacklist_clear(hdev);
 	hci_uuids_clear(hdev);
 	hci_link_keys_clear(hdev);
+	hci_smp_ltks_clear(hdev);
 	hci_remote_oob_data_clear(hdev);
 	hci_adv_entries_clear(hdev);
 	hci_dev_unlock(hdev);
-- 
1.7.8.1

