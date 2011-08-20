Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 08/11] Bluetooth: Remove the link key if LE pairing fails
Date: Fri, 19 Aug 2011 21:08:12 -0300
Message-Id: <1313798895-8705-9-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1313798895-8705-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1313798895-8705-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If the pairing attempt fails, remove the link key.

In the case that the link key wasn't found by the remote device, force
pairing to happen again. This is the correct behaviour when one of the
devices "forgot" its keys.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_core.c         |   16 ++++++++++++++++
 net/bluetooth/l2cap_core.c       |    6 +++++-
 3 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 15ee163..ec3815a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -570,6 +570,7 @@ int hci_add_smp_enc_key(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 new_key,
 					u8 type, u8 pin_len, u8 tk[16],
 					u8 enc_size, u16 ediv, u8 rand[8]);
 int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
+int hci_remove_smp_key(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 
 int hci_remote_oob_data_clear(struct hci_dev *hdev);
 struct oob_data *hci_find_remote_oob_data(struct hci_dev *hdev,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f53ae60..7f6940b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1215,6 +1215,22 @@ int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 	return 0;
 }
 
+int hci_remove_smp_key(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
+{
+	struct smp_link_key *key;
+
+	key = hci_find_smp_key_type(hdev, bdaddr, type);
+	if (!key)
+		return -ENOENT;
+
+	BT_DBG("%s removing %s", hdev->name, batostr(bdaddr));
+
+	list_del(&key->list);
+	kfree(key);
+
+	return 0;
+}
+
 /* HCI command timer function */
 static void hci_cmd_timer(unsigned long arg)
 {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5b63381..6e930c4 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4037,9 +4037,13 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 
 	BT_DBG("conn %p", conn);
 
-	if (hcon->type == LE_LINK) {
+	if (hcon->type == LE_LINK && !status) {
 		smp_distribute_keys(conn, 0);
 		del_timer(&conn->security_timer);
+	} else if (hcon->type == LE_LINK && status == 0x06) {
+		hci_remove_smp_key(hcon->hdev, &hcon->dst, HCI_LK_SMP_LTK);
+		clear_bit(HCI_CONN_LE_SMP_PEND, &hcon->pend);
+		smp_conn_security(conn, hcon->pending_sec_level);
 	}
 
 	read_lock(&conn->chan_lock);
-- 
1.7.6

