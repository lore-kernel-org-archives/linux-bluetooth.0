Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/6] Bluetooth: Move New LTK store hint evaluation into mgmt_new_ltk
Date: Wed, 19 Feb 2014 14:57:45 +0200
Message-Id: <1392814668-4830-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1392814668-4830-1-git-send-email-johan.hedberg@gmail.com>
References: <1392814668-4830-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

It's simpler (one less if-statement) to just evaluate the appropriate
value for store_hint in the mgmt_new_ltk function than to pass a boolean
parameter to the function. Furthermore, this simplifies moving the mgmt
event emission out from hci_add_ltk in subsequent patches.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 2 +-
 net/bluetooth/hci_core.c         | 8 +-------
 net/bluetooth/mgmt.c             | 9 +++++++--
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5366dc9e25eb..8ca95e5e3765 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1211,7 +1211,7 @@ void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 void mgmt_discovering(struct hci_dev *hdev, u8 discovering);
 int mgmt_device_blocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 int mgmt_device_unblocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
-void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, u8 persistent);
+void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key);
 void mgmt_reenable_advertising(struct hci_dev *hdev);
 void mgmt_smp_complete(struct hci_conn *conn, bool complete);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e23c718d668b..60c875267c19 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2768,7 +2768,6 @@ struct smp_ltk *hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 {
 	struct smp_ltk *key, *old_key;
 	bool master = ltk_type_master(type);
-	u8 persistent;
 
 	old_key = hci_find_ltk_by_addr(hdev, bdaddr, addr_type, master);
 	if (old_key)
@@ -2792,13 +2791,8 @@ struct smp_ltk *hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	if (!new_key)
 		return key;
 
-	if (addr_type == ADDR_LE_DEV_RANDOM && (bdaddr->b[5] & 0xc0) != 0xc0)
-		persistent = 0;
-	else
-		persistent = 1;
-
 	if (type == HCI_SMP_LTK || type == HCI_SMP_LTK_SLAVE)
-		mgmt_new_ltk(hdev, key, persistent);
+		mgmt_new_ltk(hdev, key);
 
 	return key;
 }
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 747cb9bbc331..ad51da1b6dc2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4765,13 +4765,18 @@ void mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 	mgmt_event(MGMT_EV_NEW_LINK_KEY, hdev, &ev, sizeof(ev), NULL);
 }
 
-void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, u8 persistent)
+void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key)
 {
 	struct mgmt_ev_new_long_term_key ev;
 
 	memset(&ev, 0, sizeof(ev));
 
-	ev.store_hint = persistent;
+	if (key->bdaddr_type == ADDR_LE_DEV_RANDOM &&
+	    (key->bdaddr.b[5] & 0xc0) != 0xc0)
+		ev.store_hint = 0x00;
+	else
+		ev.store_hint = 0x01;
+
 	bacpy(&ev.key.addr.bdaddr, &key->bdaddr);
 	ev.key.addr.type = link_to_bdaddr(LE_LINK, key->bdaddr_type);
 	ev.key.type = key->authenticated;
-- 
1.8.5.3

