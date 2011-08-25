Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [PATCH v2 12/13] Bluetooth: mgmt: Add support for removing SMP keys
Date: Thu, 25 Aug 2011 20:02:38 -0300
Message-Id: <1314313359-12652-13-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1314313359-12652-1-git-send-email-vcgomes@gmail.com>
References: <1314313359-12652-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The mgmt command to remove keys is used for removing associations
with a remote device, so it makes sense to also use the same
command to remove SMP keys.

Signed-off-by: Vinicius Costa Gomes <vcgomes@gmail.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_core.c         |   17 +++++++++++++++++
 net/bluetooth/mgmt.c             |    6 ++++++
 3 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b6f1865..4b836d2 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -586,6 +586,7 @@ int hci_add_smp_enc_key(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 new_key,
 					u8 type, u8 pin_len, u8 tk[16],
 					u8 enc_size, u16 ediv, u8 rand[8]);
 int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
+int hci_remove_smp_keys(struct hci_dev *hdev, bdaddr_t *bdaddr);
 
 int hci_remote_oob_data_clear(struct hci_dev *hdev);
 struct oob_data *hci_find_remote_oob_data(struct hci_dev *hdev,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a0f7862..2d13762 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1215,6 +1215,23 @@ int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 	return 0;
 }
 
+int hci_remove_smp_keys(struct hci_dev *hdev, bdaddr_t *bdaddr)
+{
+	struct smp_link_key *k, *tmp;
+
+	list_for_each_entry_safe(k, tmp, &hdev->smp_keys, list) {
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
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 44f2d05..89152be 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -973,6 +973,12 @@ static int remove_key(struct sock *sk, u16 index, unsigned char *data, u16 len)
 
 	hci_dev_lock_bh(hdev);
 
+	err = hci_remove_smp_keys(hdev, &cp->bdaddr);
+	if (err < 0) {
+		err = cmd_status(sk, index, MGMT_OP_REMOVE_KEY, -err);
+		goto unlock;
+	}
+
 	err = hci_remove_link_key(hdev, &cp->bdaddr);
 	if (err < 0) {
 		err = cmd_status(sk, index, MGMT_OP_REMOVE_KEY, -err);
-- 
1.7.6

