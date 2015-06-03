Return-Path: <cyrus@holtmann.org>
From: Arron Wang <arron.wang@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arron Wang <arron.wang@intel.com>
Subject: [PATCHv2] Bluetooth: Move SCO support under BT_BREDR config option
Date: Wed,  3 Jun 2015 17:35:30 +0800
Message-Id: <1433324130-3771-1-git-send-email-arron.wang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

SCO/eSCO link is supported by BR/EDR controller, it is
suitable to move them under BT_BREDR config option

Signed-off-by: Arron Wang <arron.wang@intel.com>
---
 include/net/bluetooth/bluetooth.h |   11 +++++++++++
 include/net/bluetooth/hci_core.h  |   14 +++++++++++++-
 net/bluetooth/Makefile            |    3 ++-
 net/bluetooth/sco.c               |    5 ++---
 4 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 7dba805..38d8a34 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -365,8 +365,19 @@ extern struct dentry *bt_debugfs;
 int l2cap_init(void);
 void l2cap_exit(void);
 
+#if IS_ENABLED(CONFIG_BT_BREDR)
 int sco_init(void);
 void sco_exit(void);
+#else
+static inline int sco_init(void)
+{
+	return 0;
+}
+
+static inline void sco_exit(void)
+{
+}
+#endif
 
 int mgmt_init(void);
 void mgmt_exit(void);
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a056c2b..387bbc3 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -532,8 +532,20 @@ int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int l2cap_disconn_ind(struct hci_conn *hcon);
 int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags);
 
+#if IS_ENABLED(CONFIG_BT_BREDR)
 int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags);
-int sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb);
+void sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb);
+#else
+static inline int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
+				  __u8 *flags)
+{
+	return 0;
+}
+
+static inline void sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb)
+{
+}
+#endif
 
 /* ----- Inquiry cache ----- */
 #define INQUIRY_CACHE_AGE_MAX   (HZ*30)   /* 30 seconds */
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index 9a8ea23..29c12ae 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -12,9 +12,10 @@ obj-$(CONFIG_BT_6LOWPAN) += bluetooth_6lowpan.o
 bluetooth_6lowpan-y := 6lowpan.o
 
 bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
-	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o sco.o lib.o \
+	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o lib.o \
 	a2mp.o amp.o ecc.o hci_request.o mgmt_util.o
 
+bluetooth-$(CONFIG_BT_BREDR) += sco.o
 bluetooth-$(CONFIG_BT_DEBUGFS) += hci_debugfs.o
 bluetooth-$(CONFIG_BT_SELFTEST) += selftest.o
 
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

