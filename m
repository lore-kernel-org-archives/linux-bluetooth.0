Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: jiangbo.wu@intel.com
To: linux-bluetooth@vger.kernel.org
Cc: Jiangbo Wu <jiangbo.wu@intel.com>
Subject: [PATCH] Bluetooth: Add conn type to identify addr type with SMP over BR/EDR
Date: Fri, 14 Oct 2016 20:29:43 +0800
Message-Id: <1476448183-8630-1-git-send-email-jiangbo.wu@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jiangbo Wu <jiangbo.wu@intel.com>

SMP over BR/EDR distributes keys when encryption key changed. It should
use correct address type with link.

Signed-off-by: Jiangbo Wu <jiangbo.wu@intel.com>
---
 include/net/bluetooth/hci_core.h |  8 +++++---
 net/bluetooth/mgmt.c             | 14 ++++++++------
 net/bluetooth/smp.c              | 10 +++++-----
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f00bf66..caa8254 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1509,9 +1509,11 @@ void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		      u8 addr_type, s8 rssi, u8 *name, u8 name_len);
 void mgmt_discovering(struct hci_dev *hdev, u8 discovering);
 bool mgmt_powering_down(struct hci_dev *hdev);
-void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent);
-void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk, bool persistent);
-void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk,
+void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, u8 link_type,
+		  bool persistent);
+void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk, u8 link_type,
+		  bool persistent);
+void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk, u8 link_type,
 		   bool persistent);
 void mgmt_new_conn_param(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			 u8 bdaddr_type, u8 store_hint, u16 min_interval,
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 19b8a5e..2b12b72 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6757,7 +6757,8 @@ static u8 mgmt_ltk_type(struct smp_ltk *ltk)
 	return MGMT_LTK_UNAUTHENTICATED;
 }
 
-void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent)
+void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, u8 link_type,
+		  bool persistent)
 {
 	struct mgmt_ev_new_long_term_key ev;
 
@@ -6781,7 +6782,7 @@ void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent)
 		ev.store_hint = persistent;
 
 	bacpy(&ev.key.addr.bdaddr, &key->bdaddr);
-	ev.key.addr.type = link_to_bdaddr(LE_LINK, key->bdaddr_type);
+	ev.key.addr.type = link_to_bdaddr(link_type, key->bdaddr_type);
 	ev.key.type = mgmt_ltk_type(key);
 	ev.key.enc_size = key->enc_size;
 	ev.key.ediv = key->ediv;
@@ -6800,7 +6801,8 @@ void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent)
 	mgmt_event(MGMT_EV_NEW_LONG_TERM_KEY, hdev, &ev, sizeof(ev), NULL);
 }
 
-void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk, bool persistent)
+void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk, u8 link_type,
+		  bool persistent)
 {
 	struct mgmt_ev_new_irk ev;
 
@@ -6810,13 +6812,13 @@ void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk, bool persistent)
 
 	bacpy(&ev.rpa, &irk->rpa);
 	bacpy(&ev.irk.addr.bdaddr, &irk->bdaddr);
-	ev.irk.addr.type = link_to_bdaddr(LE_LINK, irk->addr_type);
+	ev.irk.addr.type = link_to_bdaddr(link_type, irk->addr_type);
 	memcpy(ev.irk.val, irk->val, sizeof(irk->val));
 
 	mgmt_event(MGMT_EV_NEW_IRK, hdev, &ev, sizeof(ev), NULL);
 }
 
-void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk,
+void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk, u8 link_type,
 		   bool persistent)
 {
 	struct mgmt_ev_new_csrk ev;
@@ -6839,7 +6841,7 @@ void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk,
 		ev.store_hint = persistent;
 
 	bacpy(&ev.key.addr.bdaddr, &csrk->bdaddr);
-	ev.key.addr.type = link_to_bdaddr(LE_LINK, csrk->bdaddr_type);
+	ev.key.addr.type = link_to_bdaddr(link_type, csrk->bdaddr_type);
 	ev.key.type = csrk->type;
 	memcpy(ev.key.val, csrk->val, sizeof(csrk->val));
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 43faf2a..58412d3 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1043,7 +1043,7 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 	}
 
 	if (smp->remote_irk) {
-		mgmt_new_irk(hdev, smp->remote_irk, persistent);
+		mgmt_new_irk(hdev, smp->remote_irk, hcon->type, persistent);
 
 		/* Now that user space can be considered to know the
 		 * identity address track the connection based on it
@@ -1059,25 +1059,25 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 	if (smp->csrk) {
 		smp->csrk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->csrk->bdaddr, &hcon->dst);
-		mgmt_new_csrk(hdev, smp->csrk, persistent);
+		mgmt_new_csrk(hdev, smp->csrk, hcon->type, persistent);
 	}
 
 	if (smp->slave_csrk) {
 		smp->slave_csrk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->slave_csrk->bdaddr, &hcon->dst);
-		mgmt_new_csrk(hdev, smp->slave_csrk, persistent);
+		mgmt_new_csrk(hdev, smp->slave_csrk, hcon->type, persistent);
 	}
 
 	if (smp->ltk) {
 		smp->ltk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->ltk->bdaddr, &hcon->dst);
-		mgmt_new_ltk(hdev, smp->ltk, persistent);
+		mgmt_new_ltk(hdev, smp->ltk, hcon->type, persistent);
 	}
 
 	if (smp->slave_ltk) {
 		smp->slave_ltk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->slave_ltk->bdaddr, &hcon->dst);
-		mgmt_new_ltk(hdev, smp->slave_ltk, persistent);
+		mgmt_new_ltk(hdev, smp->slave_ltk, hcon->type, persistent);
 	}
 
 	if (smp->link_key) {
-- 
1.9.1

