Return-Path: <cyrus@holtmann.org>
From: Arron Wang <arron.wang@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arron Wang <arron.wang@intel.com>
Subject: [PATCH v3 1/2] Bluetooth: Make l2cap_recv_acldata() and sco_recv_scodata() return void
Date: Tue,  9 Jun 2015 17:47:22 +0800
Message-Id: <1433843243-11668-1-git-send-email-arron.wang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The return value of l2cap_recv_acldata() and sco_recv_scodata()
are not used, then change it to return void

Signed-off-by: Arron Wang <arron.wang@intel.com>
---
 include/net/bluetooth/hci_core.h |    4 ++--
 net/bluetooth/l2cap_core.c       |    5 ++---
 net/bluetooth/sco.c              |    5 ++---
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a056c2b..eb34737 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -530,10 +530,10 @@ extern struct mutex hci_cb_list_lock;
 /* ----- HCI interface to upper protocols ----- */
 int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int l2cap_disconn_ind(struct hci_conn *hcon);
-int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags);
+void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags);
 
 int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags);
-int sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb);
+void sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb);
 
 /* ----- Inquiry cache ----- */
 #define INQUIRY_CACHE_AGE_MAX   (HZ*30)   /* 30 seconds */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index dad4197..07bd316 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7442,7 +7442,7 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 	mutex_unlock(&conn->chan_lock);
 }
 
-int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
+void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
 	struct l2cap_hdr *hdr;
@@ -7485,7 +7485,7 @@ int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 		if (len == skb->len) {
 			/* Complete frame received */
 			l2cap_recv_frame(conn, skb);
-			return 0;
+			return;
 		}
 
 		BT_DBG("Start: total len %d, frag len %d", len, skb->len);
@@ -7544,7 +7544,6 @@ int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 
 drop:
 	kfree_skb(skb);
-	return 0;
 }
 
 static struct hci_cb l2cap_cb = {
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 4322c83..f348383 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1110,7 +1110,7 @@ static void sco_disconn_cfm(struct hci_conn *hcon, __u8 reason)
 	sco_conn_del(hcon, bt_to_errno(reason));
 }
 
-int sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb)
+void sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb)
 {
 	struct sco_conn *conn = hcon->sco_data;
 
@@ -1121,12 +1121,11 @@ int sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb)
 
 	if (skb->len) {
 		sco_recv_frame(conn, skb);
-		return 0;
+		return;
 	}
 
 drop:
 	kfree_skb(skb);
-	return 0;
 }
 
 static struct hci_cb sco_cb = {
-- 
1.7.9.5

