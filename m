Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add 'Already Paired' error for Pair Device command
Date: Tue, 10 Mar 2015 22:34:40 +0200
Message-Id: <1426019680-28715-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

To make the behavior predictable when attempting to pair with a device
for which we already have a Link Key or Long Term Key, this patch adds a
new 'Already Paired' error which gets sent in such a scenario.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 ++
 include/net/bluetooth/mgmt.h     |  1 +
 net/bluetooth/hci_core.c         | 27 +++++++++++++++++++++++++++
 net/bluetooth/mgmt.c             |  7 +++++++
 4 files changed, 37 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index afc641c5e55c..5cc5a192359d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -967,6 +967,8 @@ struct smp_irk *hci_add_irk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 void hci_remove_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type);
 void hci_smp_irks_clear(struct hci_dev *hdev);
 
+bool hci_bdaddr_is_paired(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
+
 void hci_remote_oob_data_clear(struct hci_dev *hdev);
 struct oob_data *hci_find_remote_oob_data(struct hci_dev *hdev,
 					  bdaddr_t *bdaddr, u8 bdaddr_type);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 0c737e4b8f57..5bf6af9cee78 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -43,6 +43,7 @@
 #define MGMT_STATUS_CANCELLED		0x10
 #define MGMT_STATUS_INVALID_INDEX	0x11
 #define MGMT_STATUS_RFKILLED		0x12
+#define MGMT_STATUS_ALREADY_PAIRED	0x13
 
 struct mgmt_hdr {
 	__le16	opcode;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index bba4c344c6e0..a35d8441187a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2516,6 +2516,33 @@ void hci_remove_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type)
 	}
 }
 
+bool hci_bdaddr_is_paired(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
+{
+	struct smp_ltk *k;
+	u8 addr_type;
+
+	if (type == BDADDR_BREDR) {
+		if (hci_find_link_key(hdev, bdaddr))
+			return true;
+		return false;
+	}
+
+	/* Convert to HCI addr type which struct smp_ltk uses */
+	if (type == BDADDR_LE_PUBLIC)
+		addr_type = ADDR_LE_DEV_PUBLIC;
+	else
+		addr_type = ADDR_LE_DEV_RANDOM;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(k, &hdev->long_term_keys, list) {
+		if (k->bdaddr_type == addr_type && !bacmp(bdaddr, &k->bdaddr))
+			return true;
+	}
+	rcu_read_unlock();
+
+	return false;
+}
+
 /* HCI command timer function */
 static void hci_cmd_timeout(struct work_struct *work)
 {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 49b8e09ffe67..600636c00d34 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3245,6 +3245,13 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
+	if (hci_bdaddr_is_paired(hdev, &cp->addr.bdaddr, cp->addr.type)) {
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_PAIR_DEVICE,
+					MGMT_STATUS_ALREADY_PAIRED, &rp,
+					sizeof(rp));
+		goto unlock;
+	}
+
 	sec_level = BT_SECURITY_MEDIUM;
 	auth_type = HCI_AT_DEDICATED_BONDING;
 
-- 
2.1.0

