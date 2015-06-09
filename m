Return-Path: <cyrus@holtmann.org>
From: Arron Wang <arron.wang@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arron Wang <arron.wang@intel.com>
Subject: [PATCH v3 2/2] Bluetooth: Move SCO support under BT_BREDR config option
Date: Tue,  9 Jun 2015 17:47:23 +0800
Message-Id: <1433843243-11668-2-git-send-email-arron.wang@intel.com>
In-Reply-To: <1433843243-11668-1-git-send-email-arron.wang@intel.com>
References: <1433843243-11668-1-git-send-email-arron.wang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

SCO/eSCO link is supported by BR/EDR controller, it is
suitable to move them under BT_BREDR config option

Signed-off-by: Arron Wang <arron.wang@intel.com>
---
 include/net/bluetooth/bluetooth.h |   11 +++++++++++
 include/net/bluetooth/hci_core.h  |   12 ++++++++++++
 net/bluetooth/Makefile            |    3 ++-
 3 files changed, 25 insertions(+), 1 deletion(-)

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
index eb34737..fe4edc7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -532,8 +532,20 @@ int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int l2cap_disconn_ind(struct hci_conn *hcon);
 void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags);
 
+#if IS_ENABLED(CONFIG_BT_BREDR)
 int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags);
 void sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb);
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
 
-- 
1.7.9.5

