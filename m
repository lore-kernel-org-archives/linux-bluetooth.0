Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Make LTK and CSRK only persisent when bonding
Date: Sun,  9 Mar 2014 15:00:53 -0700
Message-Id: <1394402453-59133-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case the pairable option has been disabled, the pairing procedure
does not create keys for bonding. This means that these generated keys
should not be stored persistently.

For LTK and CSRK this is important to tell userspace to not store these
new keys. They will be available for the lifetime of the device, but
after the next power cycle they should not be used anymore.

Make sure that the SMP pairing procedures rememberes the authentication
request information for bonding and if both sides request bonding, then
inform userspace to actually store the keys persistently.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  5 +++--
 net/bluetooth/mgmt.c             |  9 +++++----
 net/bluetooth/smp.c              | 15 +++++++++++----
 net/bluetooth/smp.h              |  1 +
 4 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e869884fbfa9..b8cc39a4a9a5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1270,9 +1270,10 @@ void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 void mgmt_discovering(struct hci_dev *hdev, u8 discovering);
 int mgmt_device_blocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 int mgmt_device_unblocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
-void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key);
+void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent);
 void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk);
-void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk);
+void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk,
+		   bool persistent);
 void mgmt_reenable_advertising(struct hci_dev *hdev);
 void mgmt_smp_complete(struct hci_conn *conn, bool complete);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9c7788914b4e..fbcf9d4f130b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5005,7 +5005,7 @@ void mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 	mgmt_event(MGMT_EV_NEW_LINK_KEY, hdev, &ev, sizeof(ev), NULL);
 }
 
-void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key)
+void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent)
 {
 	struct mgmt_ev_new_long_term_key ev;
 
@@ -5026,7 +5026,7 @@ void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key)
 	    (key->bdaddr.b[5] & 0xc0) != 0xc0)
 		ev.store_hint = 0x00;
 	else
-		ev.store_hint = 0x01;
+		ev.store_hint = persistent;
 
 	bacpy(&ev.key.addr.bdaddr, &key->bdaddr);
 	ev.key.addr.type = link_to_bdaddr(LE_LINK, key->bdaddr_type);
@@ -5073,7 +5073,8 @@ void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk)
 	mgmt_event(MGMT_EV_NEW_IRK, hdev, &ev, sizeof(ev), NULL);
 }
 
-void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk)
+void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk,
+		   bool persistent)
 {
 	struct mgmt_ev_new_csrk ev;
 
@@ -5092,7 +5093,7 @@ void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk)
 	    (csrk->bdaddr.b[5] & 0xc0) != 0xc0)
 		ev.store_hint = 0x00;
 	else
-		ev.store_hint = 0x01;
+		ev.store_hint = persistent;
 
 	bacpy(&ev.key.addr.bdaddr, &csrk->bdaddr);
 	ev.key.addr.type = link_to_bdaddr(LE_LINK, csrk->bdaddr_type);
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index fc652592daf6..1a6a24fc1bb3 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -716,6 +716,8 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (ret)
 		return SMP_UNSPECIFIED;
 
+	smp->auth_req = auth;
+
 	return 0;
 }
 
@@ -758,6 +760,8 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (ret)
 		return SMP_UNSPECIFIED;
 
+	smp->auth_req = auth;
+
 	set_bit(SMP_FLAG_CFM_PENDING, &smp->smp_flags);
 
 	/* Can't compose response until we have been confirmed */
@@ -1209,32 +1213,35 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 	struct smp_chan *smp = conn->smp_chan;
 	struct hci_conn *hcon = conn->hcon;
 	struct hci_dev *hdev = hcon->hdev;
+	bool persistent;
 
 	if (smp->remote_irk)
 		mgmt_new_irk(hdev, smp->remote_irk);
 
+	persistent = !!(smp->auth_req & SMP_AUTH_BONDING);
+
 	if (smp->csrk) {
 		smp->csrk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->csrk->bdaddr, &hcon->dst);
-		mgmt_new_csrk(hdev, smp->csrk);
+		mgmt_new_csrk(hdev, smp->csrk, persistent);
 	}
 
 	if (smp->slave_csrk) {
 		smp->slave_csrk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->slave_csrk->bdaddr, &hcon->dst);
-		mgmt_new_csrk(hdev, smp->slave_csrk);
+		mgmt_new_csrk(hdev, smp->slave_csrk, persistent);
 	}
 
 	if (smp->ltk) {
 		smp->ltk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->ltk->bdaddr, &hcon->dst);
-		mgmt_new_ltk(hdev, smp->ltk);
+		mgmt_new_ltk(hdev, smp->ltk, persistent);
 	}
 
 	if (smp->slave_ltk) {
 		smp->slave_ltk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->slave_ltk->bdaddr, &hcon->dst);
-		mgmt_new_ltk(hdev, smp->slave_ltk);
+		mgmt_new_ltk(hdev, smp->slave_ltk, persistent);
 	}
 }
 
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index f223b9d38b61..b7c6f903e895 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -131,6 +131,7 @@ struct smp_chan {
 	u8		rrnd[16]; /* SMP Pairing Random (remote) */
 	u8		pcnf[16]; /* SMP Pairing Confirm */
 	u8		tk[16]; /* SMP Temporary Key */
+	u8		auth_req;
 	u8		enc_key_size;
 	u8		remote_key_dist;
 	bdaddr_t	id_addr;
-- 
1.8.5.3

