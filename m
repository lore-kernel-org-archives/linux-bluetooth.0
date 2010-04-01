Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi
Subject: [PATCH 31/34] Bluetooth: Make hci_send_sco() void
Date: Thu,  1 Apr 2010 17:23:49 -0300
Message-Id: <1270153432-6477-32-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1270153432-6477-31-git-send-email-padovan@profusion.mobi>
References: <1270153432-6477-1-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-2-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-3-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-4-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-5-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-6-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-7-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-8-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-9-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-10-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-11-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-12-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-13-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-14-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-15-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-16-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-17-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-18-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-19-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-20-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-21-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-22-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-23-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-24-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-25-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-26-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-27-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-28-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-29-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-30-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-31-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

It also removes an unneeded check for the MTU. The is done before on
sco_send_frame()

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 include/net/bluetooth/hci_core.h |    2 +-
 net/bluetooth/hci_core.c         |    9 +--------
 net/bluetooth/sco.c              |    3 +--
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 21ff787..4511df2 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -637,7 +637,7 @@ int hci_unregister_notifier(struct notifier_block *nb);
 
 int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param);
 void hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags);
-int hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);
+void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);
 
 void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index cc8074b..904f1e8 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1308,18 +1308,13 @@ void hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags)
 EXPORT_SYMBOL(hci_send_acl);
 
 /* Send SCO data */
-int hci_send_sco(struct hci_conn *conn, struct sk_buff *skb)
+void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_sco_hdr hdr;
 
 	BT_DBG("%s len %d", hdev->name, skb->len);
 
-	if (skb->len > hdev->sco_mtu) {
-		kfree_skb(skb);
-		return -EINVAL;
-	}
-
 	hdr.handle = cpu_to_le16(conn->handle);
 	hdr.dlen   = skb->len;
 
@@ -1332,8 +1327,6 @@ int hci_send_sco(struct hci_conn *conn, struct sk_buff *skb)
 
 	skb_queue_tail(&conn->data_q, skb);
 	tasklet_schedule(&hdev->tx_task);
-
-	return 0;
 }
 EXPORT_SYMBOL(hci_send_sco);
 
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index e5b16b7..50a9af8 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -249,8 +249,7 @@ static inline int sco_send_frame(struct sock *sk, struct msghdr *msg, int len)
 		goto fail;
 	}
 
-	if ((err = hci_send_sco(conn->hcon, skb)) < 0)
-		return err;
+	hci_send_sco(conn->hcon, skb);
 
 	return count;
 
-- 
1.6.4.4
