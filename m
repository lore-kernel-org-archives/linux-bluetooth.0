Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/6] Bluetooth: Add support for sending New IRK event
Date: Wed, 19 Feb 2014 14:57:48 +0200
Message-Id: <1392814668-4830-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1392814668-4830-1-git-send-email-johan.hedberg@gmail.com>
References: <1392814668-4830-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds the necessary helper function to send the New IRK mgmt
event and makes sure that the function is called at when SMP key
distribution has completed. The event is sent before the New LTK event
so user space knows which remote device to associate with the keys.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 include/net/bluetooth/mgmt.h     |  7 +++++++
 net/bluetooth/mgmt.c             | 15 +++++++++++++++
 net/bluetooth/smp.c              |  3 +++
 4 files changed, 26 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 59ae04c2684f..3be2905010cd 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1211,6 +1211,7 @@ void mgmt_discovering(struct hci_dev *hdev, u8 discovering);
 int mgmt_device_blocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 int mgmt_device_unblocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key);
+void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk);
 void mgmt_reenable_advertising(struct hci_dev *hdev);
 void mgmt_smp_complete(struct hci_conn *conn, bool complete);
 
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index e4fa13e559e2..2e46251e8aec 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -536,3 +536,10 @@ struct mgmt_ev_passkey_notify {
 	__le32	passkey;
 	__u8	entered;
 } __packed;
+
+#define MGMT_EV_NEW_IRK			0x0018
+struct mgmt_ev_new_irk {
+	__u8     store_hint;
+	bdaddr_t rpa;
+	struct mgmt_irk_info irk;
+} __packed;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index bcfc6da67a5c..1daa837da091 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4792,6 +4792,21 @@ void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key)
 	mgmt_event(MGMT_EV_NEW_LONG_TERM_KEY, hdev, &ev, sizeof(ev), NULL);
 }
 
+void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk)
+{
+	struct mgmt_ev_new_irk ev;
+
+	memset(&ev, 0, sizeof(ev));
+
+	ev.store_hint = 0x01;
+	bacpy(&ev.rpa, &irk->rpa);
+	bacpy(&ev.irk.addr.bdaddr, &irk->bdaddr);
+	ev.irk.addr.type = link_to_bdaddr(LE_LINK, irk->addr_type);
+	memcpy(ev.irk.val, irk->val, sizeof(irk->val));
+
+	mgmt_event(MGMT_EV_NEW_IRK, hdev, &ev, sizeof(ev), NULL);
+}
+
 static inline u16 eir_append_data(u8 *eir, u16 eir_len, u8 type, u8 *data,
 				  u8 data_len)
 {
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index f05c1b71d99a..e3794592fa66 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1112,6 +1112,9 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 	struct hci_conn *hcon = conn->hcon;
 	struct hci_dev *hdev = hcon->hdev;
 
+	if (smp->irk)
+		mgmt_new_irk(hdev, smp->remote_irk);
+
 	if (smp->ltk) {
 		smp->ltk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->ltk->bdaddr, &hcon->dst);
-- 
1.8.5.3

