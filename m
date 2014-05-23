Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Clearly distinguish mgmt LTK type from authenticated property
Date: Fri, 23 May 2014 13:19:53 +0300
Message-Id: <1400840393-21232-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

On the mgmt level we have a key type parameter which currently accepts
two possible values: 0x00 for unauthenticated and 0x01 for
authenticated. However, in the internal struct smp_ltk representation we
have an explicit "authenticated" boolean value.

To make this distinction clear, add defines for the possible mgmt values
and do conversion to and from the internal authenticated value.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/mgmt.h |  3 +++
 net/bluetooth/mgmt.c         | 19 ++++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 226ae03cafe7..bcffc9ae0c89 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -181,6 +181,9 @@ struct mgmt_cp_load_link_keys {
 } __packed;
 #define MGMT_LOAD_LINK_KEYS_SIZE	3
 
+#define MGMT_LTK_UNAUTHENTICATED	0x00
+#define MGMT_LTK_AUTHENTICATED		0x01
+
 struct mgmt_ltk_info {
 	struct mgmt_addr_info addr;
 	__u8	type;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f8ca69dd1984..5e9c21a5525f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4534,7 +4534,7 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 
 	for (i = 0; i < key_count; i++) {
 		struct mgmt_ltk_info *key = &cp->keys[i];
-		u8 type, addr_type;
+		u8 type, addr_type, authenticated;
 
 		if (key->addr.type == BDADDR_LE_PUBLIC)
 			addr_type = ADDR_LE_DEV_PUBLIC;
@@ -4546,8 +4546,13 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 		else
 			type = HCI_SMP_LTK_SLAVE;
 
+		if (key->type == MGMT_LTK_UNAUTHENTICATED)
+			authenticated = 0x00;
+		else
+			authenticated = 0x01;
+
 		hci_add_ltk(hdev, &key->addr.bdaddr, addr_type, type,
-			    key->type, key->val, key->enc_size, key->ediv,
+			    authenticated, key->val, key->enc_size, key->ediv,
 			    key->rand);
 	}
 
@@ -5222,6 +5227,14 @@ void mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 	mgmt_event(MGMT_EV_NEW_LINK_KEY, hdev, &ev, sizeof(ev), NULL);
 }
 
+static u8 mgmt_ltk_type(struct smp_ltk *ltk)
+{
+	if (ltk->authenticated)
+		return MGMT_LTK_AUTHENTICATED;
+
+	return MGMT_LTK_UNAUTHENTICATED;
+}
+
 void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent)
 {
 	struct mgmt_ev_new_long_term_key ev;
@@ -5247,7 +5260,7 @@ void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent)
 
 	bacpy(&ev.key.addr.bdaddr, &key->bdaddr);
 	ev.key.addr.type = link_to_bdaddr(LE_LINK, key->bdaddr_type);
-	ev.key.type = key->authenticated;
+	ev.key.type = mgmt_ltk_type(key);
 	ev.key.enc_size = key->enc_size;
 	ev.key.ediv = key->ediv;
 	ev.key.rand = key->rand;
-- 
1.9.3

