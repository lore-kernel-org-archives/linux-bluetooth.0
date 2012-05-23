Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 6/6] Bluetooth: Remove unneeded EXPORT_SYMBOL
Date: Wed, 23 May 2012 04:04:23 -0300
Message-Id: <1337756663-19805-6-git-send-email-gustavo@padovan.org>
In-Reply-To: <1337756663-19805-5-git-send-email-gustavo@padovan.org>
References: <1337756663-19805-1-git-send-email-gustavo@padovan.org>
 <1337756663-19805-2-git-send-email-gustavo@padovan.org>
 <1337756663-19805-3-git-send-email-gustavo@padovan.org>
 <1337756663-19805-4-git-send-email-gustavo@padovan.org>
 <1337756663-19805-5-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

After l2cap, sco and bluetooth modules merge some symbols doesn't need to
be exported anymore.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/hci_conn.c |    5 -----
 net/bluetooth/hci_core.c |    4 ----
 2 files changed, 9 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 6c03b25..5bff08a 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -188,7 +188,6 @@ void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max,
 
 	hci_send_cmd(hdev, HCI_OP_LE_CONN_UPDATE, sizeof(cp), &cp);
 }
-EXPORT_SYMBOL(hci_le_conn_update);
 
 void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
 		      __u8 ltk[16])
@@ -207,7 +206,6 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
 
 	hci_send_cmd(hdev, HCI_OP_LE_START_ENC, sizeof(cp), &cp);
 }
-EXPORT_SYMBOL(hci_le_start_enc);
 
 /* Device _must_ be locked */
 void hci_sco_setup(struct hci_conn *conn, __u8 status)
@@ -547,7 +545,6 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
 
 	return sco;
 }
-EXPORT_SYMBOL(hci_connect);
 
 /* Check link security requirement */
 int hci_conn_check_link_mode(struct hci_conn *conn)
@@ -559,7 +556,6 @@ int hci_conn_check_link_mode(struct hci_conn *conn)
 
 	return 1;
 }
-EXPORT_SYMBOL(hci_conn_check_link_mode);
 
 /* Authenticate remote device */
 static int hci_conn_auth(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
@@ -691,7 +687,6 @@ int hci_conn_change_link_key(struct hci_conn *conn)
 
 	return 0;
 }
-EXPORT_SYMBOL(hci_conn_change_link_key);
 
 /* Switch role */
 int hci_conn_switch_role(struct hci_conn *conn, __u8 role)
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ba77576..2647a3a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1227,7 +1227,6 @@ struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8])
 
 	return NULL;
 }
-EXPORT_SYMBOL(hci_find_ltk);
 
 struct smp_ltk *hci_find_ltk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				     u8 addr_type)
@@ -1241,7 +1240,6 @@ struct smp_ltk *hci_find_ltk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
 
 	return NULL;
 }
-EXPORT_SYMBOL(hci_find_ltk_by_addr);
 
 int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 		     bdaddr_t *bdaddr, u8 *val, u8 type, u8 pin_len)
@@ -2201,7 +2199,6 @@ void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags)
 
 	queue_work(hdev->workqueue, &hdev->tx_work);
 }
-EXPORT_SYMBOL(hci_send_acl);
 
 /* Send SCO data */
 void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb)
@@ -2224,7 +2221,6 @@ void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb)
 	skb_queue_tail(&conn->data_q, skb);
 	queue_work(hdev->workqueue, &hdev->tx_work);
 }
-EXPORT_SYMBOL(hci_send_sco);
 
 /* ---- HCI TX task (outgoing data) ---- */
 
-- 
1.7.10.1

