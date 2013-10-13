Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Remove pointless bdaddr_to_le() helper function
Date: Sun, 13 Oct 2013 03:57:38 -0700
Message-Id: <1381661859-32200-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The bdaddr_to_le() function tries to convert the internal address
type to one that matches the HCI address type for LE. It does not
handle any address types not used by LE and in the end just make
the code a lot harder to read.

So instead of just hiding behind a magic function, just convert
the internal address type where it needs to be converted. And it
turns out that these are only two cases anyway. One when creating
new LE connections and the other when loading the long term keys.
In both cases this makes it more clear on what it going on.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  2 --
 net/bluetooth/hci_conn.c         |  5 ++++-
 net/bluetooth/hci_core.c         | 12 ------------
 net/bluetooth/mgmt.c             | 10 +++++++---
 4 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6900454..7889495 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1187,8 +1187,6 @@ void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max,
 void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
 							__u8 ltk[16]);
 
-u8 bdaddr_to_le(u8 bdaddr_type);
-
 #define SCO_AIRMODE_MASK       0x0003
 #define SCO_AIRMODE_CVSD       0x0000
 #define SCO_AIRMODE_TRANSP     0x0003
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index c52bfb7..bb32f48 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -622,7 +622,10 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	if (!conn)
 		return ERR_PTR(-ENOMEM);
 
-	conn->dst_type = bdaddr_to_le(dst_type);
+	if (dst_type == BDADDR_LE_PUBLIC)
+		conn->dst_type = ADDR_LE_DEV_PUBLIC;
+	else
+		conn->dst_type = ADDR_LE_DEV_RANDOM;
 	conn->state = BT_CONNECT;
 	conn->out = true;
 	conn->link_mode |= HCI_LM_MASTER;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 082f396..0e05ede 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3695,15 +3695,3 @@ static void hci_cmd_work(struct work_struct *work)
 		}
 	}
 }
-
-u8 bdaddr_to_le(u8 bdaddr_type)
-{
-	switch (bdaddr_type) {
-	case BDADDR_LE_PUBLIC:
-		return ADDR_LE_DEV_PUBLIC;
-
-	default:
-		/* Fallback to LE Random address type */
-		return ADDR_LE_DEV_RANDOM;
-	}
-}
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 338878c..020f95b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3678,15 +3678,19 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 
 	for (i = 0; i < key_count; i++) {
 		struct mgmt_ltk_info *key = &cp->keys[i];
-		u8 type;
+		u8 type, addr_type;
+
+		if (key->addr.type == BDADDR_LE_PUBLIC)
+			addr_type = ADDR_LE_DEV_PUBLIC;
+		else
+			addr_type = ADDR_LE_DEV_RANDOM;
 
 		if (key->master)
 			type = HCI_SMP_LTK;
 		else
 			type = HCI_SMP_LTK_SLAVE;
 
-		hci_add_ltk(hdev, &key->addr.bdaddr,
-			    bdaddr_to_le(key->addr.type),
+		hci_add_ltk(hdev, &key->addr.bdaddr, addr_type,
 			    type, 0, key->authenticated, key->val,
 			    key->enc_size, key->ediv, key->rand);
 	}
-- 
1.8.3.1

