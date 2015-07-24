Return-Path: <cyrus@holtmann.org>
From: Arron Wang <arron.wang@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arron Wang <arron.wang@intel.com>
Subject: [PATCH 1/2] Bluetooth: Add BT_HS config option
Date: Fri, 24 Jul 2015 17:12:55 +0800
Message-Id: <1437729175-16824-1-git-send-email-arron.wang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Move A2MP Module under BT_HS config option and allow
the user have flexible option to choose the feature only
they need

a2mp_discover_amp() & a2mp_channel_create() are a2mp module
entry point for master and slave, and this is dynamic
invoked depends on the userspace or remote request, then
we defined their implementation depends on BT_HS config

Signed-off-by: Arron Wang <arron.wang@intel.com>
---
 net/bluetooth/Kconfig  |    5 +++++
 net/bluetooth/Makefile |    3 ++-
 net/bluetooth/a2mp.h   |   19 +++++++++++++++++++
 net/bluetooth/amp.h    |   14 ++++++++++++++
 4 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index b8c794b..95d1a66 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -53,6 +53,11 @@ source "net/bluetooth/cmtp/Kconfig"
 
 source "net/bluetooth/hidp/Kconfig"
 
+config BT_HS
+	bool "Bluetooth High Speed (HS) features"
+	depends on BT_BREDR
+	default y
+
 config BT_LE
 	bool "Bluetooth Low Energy (LE) features"
 	depends on BT
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index 29c12ae..2b15ae8 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -13,9 +13,10 @@ bluetooth_6lowpan-y := 6lowpan.o
 
 bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
 	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o lib.o \
-	a2mp.o amp.o ecc.o hci_request.o mgmt_util.o
+	ecc.o hci_request.o mgmt_util.o
 
 bluetooth-$(CONFIG_BT_BREDR) += sco.o
+bluetooth-$(CONFIG_BT_HS) += a2mp.o amp.o
 bluetooth-$(CONFIG_BT_DEBUGFS) += hci_debugfs.o
 bluetooth-$(CONFIG_BT_SELFTEST) += selftest.o
 
diff --git a/net/bluetooth/a2mp.h b/net/bluetooth/a2mp.h
index 296f665..a4ff3ea 100644
--- a/net/bluetooth/a2mp.h
+++ b/net/bluetooth/a2mp.h
@@ -130,10 +130,29 @@ struct a2mp_physlink_rsp {
 #define A2MP_STATUS_SECURITY_VIOLATION		0x06
 
 struct amp_mgr *amp_mgr_get(struct amp_mgr *mgr);
+
+#if IS_ENABLED(CONFIG_BT_HS)
 int amp_mgr_put(struct amp_mgr *mgr);
 struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
 				       struct sk_buff *skb);
 void a2mp_discover_amp(struct l2cap_chan *chan);
+#else
+static inline int amp_mgr_put(struct amp_mgr *mgr)
+{
+	return 0;
+}
+
+static inline struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
+						     struct sk_buff *skb)
+{
+	return NULL;
+}
+
+static inline void a2mp_discover_amp(struct l2cap_chan *chan)
+{
+}
+#endif
+
 void a2mp_send_getinfo_rsp(struct hci_dev *hdev);
 void a2mp_send_getampassoc_rsp(struct hci_dev *hdev, u8 status);
 void a2mp_send_create_phy_link_req(struct hci_dev *hdev, u8 status);
diff --git a/net/bluetooth/amp.h b/net/bluetooth/amp.h
index 7ea3db7..8848f81 100644
--- a/net/bluetooth/amp.h
+++ b/net/bluetooth/amp.h
@@ -44,6 +44,20 @@ void amp_create_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
 			struct hci_conn *hcon);
 void amp_accept_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
 			struct hci_conn *hcon);
+
+#if IS_ENABLED(CONFIG_BT_HS)
+void amp_create_logical_link(struct l2cap_chan *chan);
+void amp_disconnect_logical_link(struct hci_chan *hchan);
+#else
+static inline void amp_create_logical_link(struct l2cap_chan *chan)
+{
+}
+
+static inline void amp_disconnect_logical_link(struct hci_chan *hchan)
+{
+}
+#endif
+
 void amp_write_remote_assoc(struct hci_dev *hdev, u8 handle);
 void amp_write_rem_assoc_continue(struct hci_dev *hdev, u8 handle);
 void amp_physical_cfm(struct hci_conn *bredr_hcon, struct hci_conn *hs_hcon);
-- 
1.7.9.5

