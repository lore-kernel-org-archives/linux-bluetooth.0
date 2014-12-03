Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 29/49] Bluetooth: Fix BR/EDR Link Key type when derived through LE SC
Date: Wed,  3 Dec 2014 17:02:23 +0200
Message-Id: <1417618963-18010-30-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We need to set the correct Link Key type based on the properties of the
LE SC pairing that it was derived from. If debug keys were used the type
should be a debug key, and the authenticated vs unauthenticated
information should be set on what kind of security level was reached.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c |  4 ++++
 net/bluetooth/smp.c      | 27 ++++++++++++++++++++++++---
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6c3220e9484f..2fa9f2b2bee3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3160,6 +3160,10 @@ static bool hci_persistent_key(struct hci_dev *hdev, struct hci_conn *conn,
 	if (!conn)
 		return true;
 
+	/* BR/EDR key derived using SC from an LE link */
+	if (conn->type == LE_LINK)
+		return true;
+
 	/* Neither local nor remote side had no-bonding as requirement */
 	if (conn->auth_type > 0x01 && conn->remote_auth > 0x01)
 		return true;
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 7fdeca7edb7c..861d2cf3ccc9 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -965,9 +965,30 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 	}
 
 	if (smp->link_key) {
-		hci_add_link_key(hdev, smp->conn->hcon, &hcon->dst,
-				 smp->link_key, HCI_LK_AUTH_COMBINATION_P256,
-				 0, NULL);
+		struct link_key *key;
+		u8 type;
+
+		if (test_bit(SMP_FLAG_DEBUG_KEY, &smp->flags))
+			type = HCI_LK_DEBUG_COMBINATION;
+		else if (hcon->sec_level == BT_SECURITY_FIPS)
+			type = HCI_LK_AUTH_COMBINATION_P256;
+		else
+			type = HCI_LK_UNAUTH_COMBINATION_P256;
+
+		key = hci_add_link_key(hdev, smp->conn->hcon, &hcon->dst,
+				       smp->link_key, type, 0, &persistent);
+		if (key) {
+			mgmt_new_link_key(hdev, key, persistent);
+
+			/* Don't keep debug keys around if the relevant
+			 * flag is not set.
+			 */
+			if (!test_bit(HCI_KEEP_DEBUG_KEYS, &hdev->dev_flags) &&
+			    key->type == HCI_LK_DEBUG_COMBINATION) {
+				list_del_rcu(&key->list);
+				kfree_rcu(key, rcu);
+			}
+		}
 	}
 }
 
-- 
2.1.0

