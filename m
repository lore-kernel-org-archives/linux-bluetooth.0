Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Don't use remote address type to decide IRK persistency
Date: Mon, 12 Oct 2015 13:36:19 +0200
Message-Id: <1444649779-29859-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There are LE devices on the market that start off by announcing their
public address and then once paired switch to using private address.
To be interoperable with such devices we should simply trust the fact
that we're receiving an IRK from them to indicate that they may use
private addresses in the future. Instead, simply tie the persistency
to the bonding/no-bonding information the same way as for LTKs and
CSRKs.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/mgmt.c             | 18 ++----------------
 net/bluetooth/smp.c              | 33 +++++++++++++++++----------------
 3 files changed, 20 insertions(+), 33 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f28470e59682..989c72aabc45 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1458,7 +1458,7 @@ void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 void mgmt_discovering(struct hci_dev *hdev, u8 discovering);
 bool mgmt_powering_down(struct hci_dev *hdev);
 void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent);
-void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk);
+void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk, bool persistent);
 void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk,
 		   bool persistent);
 void mgmt_new_conn_param(struct hci_dev *hdev, bdaddr_t *bdaddr,
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ccaf5a436d8f..9f9a70f0c981 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7857,27 +7857,13 @@ void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent)
 	mgmt_event(MGMT_EV_NEW_LONG_TERM_KEY, hdev, &ev, sizeof(ev), NULL);
 }
 
-void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk)
+void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk, bool persistent)
 {
 	struct mgmt_ev_new_irk ev;
 
 	memset(&ev, 0, sizeof(ev));
 
-	/* For identity resolving keys from devices that are already
-	 * using a public address or static random address, do not
-	 * ask for storing this key. The identity resolving key really
-	 * is only mandatory for devices using resolvable random
-	 * addresses.
-	 *
-	 * Storing all identity resolving keys has the downside that
-	 * they will be also loaded on next boot of they system. More
-	 * identity resolving keys, means more time during scanning is
-	 * needed to actually resolve these addresses.
-	 */
-	if (bacmp(&irk->rpa, BDADDR_ANY))
-		ev.store_hint = 0x01;
-	else
-		ev.store_hint = 0x00;
+	ev.store_hint = persistent;
 
 	bacpy(&ev.rpa, &irk->rpa);
 	bacpy(&ev.irk.addr.bdaddr, &irk->bdaddr);
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 25644e1bc479..229d88eebf4e 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1046,8 +1046,24 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 	struct smp_cmd_pairing *rsp = (void *) &smp->prsp[1];
 	bool persistent;
 
+	if (hcon->type == ACL_LINK) {
+		if (hcon->key_type == HCI_LK_DEBUG_COMBINATION)
+			persistent = false;
+		else
+			persistent = !test_bit(HCI_CONN_FLUSH_KEY,
+					       &hcon->flags);
+	} else {
+		/* The LTKs, IRKs and CSRKs should be persistent only if
+		 * both sides had the bonding bit set in their
+		 * authentication requests.
+		 */
+		persistent = !!((req->auth_req & rsp->auth_req) &
+				SMP_AUTH_BONDING);
+	}
+
 	if (smp->remote_irk) {
-		mgmt_new_irk(hdev, smp->remote_irk);
+		mgmt_new_irk(hdev, smp->remote_irk, persistent);
+
 		/* Now that user space can be considered to know the
 		 * identity address track the connection based on it
 		 * from now on (assuming this is an LE link).
@@ -1075,21 +1091,6 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 		}
 	}
 
-	if (hcon->type == ACL_LINK) {
-		if (hcon->key_type == HCI_LK_DEBUG_COMBINATION)
-			persistent = false;
-		else
-			persistent = !test_bit(HCI_CONN_FLUSH_KEY,
-					       &hcon->flags);
-	} else {
-		/* The LTKs and CSRKs should be persistent only if both sides
-		 * had the bonding bit set in their authentication requests.
-		 */
-		persistent = !!((req->auth_req & rsp->auth_req) &
-				SMP_AUTH_BONDING);
-	}
-
-
 	if (smp->csrk) {
 		smp->csrk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->csrk->bdaddr, &hcon->dst);
-- 
2.4.3

