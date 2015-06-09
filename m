Return-Path: <cyrus@holtmann.org>
From: Arron Wang <arron.wang@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arron Wang <arron.wang@intel.com>
Subject: [PATCH] Bluetooth: Add BT_HS config option
Date: Tue,  9 Jun 2015 17:49:59 +0800
Message-Id: <1433843399-11729-1-git-send-email-arron.wang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Move A2MP Module under BT_HS config option and allow
the user have flexible option to choose the feature only
they need

Signed-off-by: Arron Wang <arron.wang@intel.com>
---
 net/bluetooth/Kconfig  |    5 +++++
 net/bluetooth/Makefile |    3 ++-
 net/bluetooth/a2mp.h   |   32 ++++++++++++++++++++++++++++++++
 net/bluetooth/amp.h    |   48 ++++++++++++++++++++++++++++++++++++++++++++----
 4 files changed, 83 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index b8c794b..a4d83f9 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -45,6 +45,11 @@ config BT_BREDR
 	depends on BT
 	default y
 
+config BT_HS
+	bool "Bluetooth High Speed (AMP) features"
+	depends on BT_BREDR
+	default y
+
 source "net/bluetooth/rfcomm/Kconfig"
 
 source "net/bluetooth/bnep/Kconfig"
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
index 296f665..6343fd0 100644
--- a/net/bluetooth/a2mp.h
+++ b/net/bluetooth/a2mp.h
@@ -130,6 +130,8 @@ struct a2mp_physlink_rsp {
 #define A2MP_STATUS_SECURITY_VIOLATION		0x06
 
 struct amp_mgr *amp_mgr_get(struct amp_mgr *mgr);
+
+#if IS_ENABLED(CONFIG_BT_HS)
 int amp_mgr_put(struct amp_mgr *mgr);
 struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
 				       struct sk_buff *skb);
@@ -137,6 +139,36 @@ void a2mp_discover_amp(struct l2cap_chan *chan);
 void a2mp_send_getinfo_rsp(struct hci_dev *hdev);
 void a2mp_send_getampassoc_rsp(struct hci_dev *hdev, u8 status);
 void a2mp_send_create_phy_link_req(struct hci_dev *hdev, u8 status);
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
+
+static inline void a2mp_send_getinfo_rsp(struct hci_dev *hdev)
+{
+}
+
+static inline void a2mp_send_getampassoc_rsp(struct hci_dev *hdev, u8 status)
+{
+}
+
+static inline void a2mp_send_create_phy_link_req(struct hci_dev *hdev,
+						 u8 status)
+{
+}
+#endif
+
 void a2mp_send_create_phy_link_rsp(struct hci_dev *hdev, u8 status);
 
 #endif /* __A2MP_H */
diff --git a/net/bluetooth/amp.h b/net/bluetooth/amp.h
index 7ea3db7..de63335 100644
--- a/net/bluetooth/amp.h
+++ b/net/bluetooth/amp.h
@@ -36,19 +36,59 @@ struct hci_conn *phylink_add(struct hci_dev *hdev, struct amp_mgr *mgr,
 int phylink_gen_key(struct hci_conn *hcon, u8 *data, u8 *len, u8 *type);
 
 void amp_read_loc_info(struct hci_dev *hdev, struct amp_mgr *mgr);
-void amp_read_loc_assoc_frag(struct hci_dev *hdev, u8 phy_handle);
 void amp_read_loc_assoc(struct hci_dev *hdev, struct amp_mgr *mgr);
-void amp_read_loc_assoc_final_data(struct hci_dev *hdev,
-				   struct hci_conn *hcon);
 void amp_create_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
 			struct hci_conn *hcon);
 void amp_accept_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
 			struct hci_conn *hcon);
+
+#if IS_ENABLED(CONFIG_BT_HS)
+void amp_read_loc_assoc_frag(struct hci_dev *hdev, u8 phy_handle);
+void amp_read_loc_assoc_final_data(struct hci_dev *hdev,
+				   struct hci_conn *hcon);
+void amp_create_logical_link(struct l2cap_chan *chan);
+void amp_disconnect_logical_link(struct hci_chan *hchan);
 void amp_write_remote_assoc(struct hci_dev *hdev, u8 handle);
 void amp_write_rem_assoc_continue(struct hci_dev *hdev, u8 handle);
 void amp_physical_cfm(struct hci_conn *bredr_hcon, struct hci_conn *hs_hcon);
+void amp_destroy_logical_link(struct hci_chan *hchan, u8 reason);
+#else
+static inline void amp_read_loc_assoc_frag(struct hci_dev *hdev, u8 phy_handle)
+{
+}
+
+static inline void amp_read_loc_assoc_final_data(struct hci_dev *hdev,
+						 struct hci_conn *hcon)
+{
+}
+
+static inline void amp_create_logical_link(struct l2cap_chan *chan)
+{
+}
+
+static inline void amp_disconnect_logical_link(struct hci_chan *hchan)
+{
+}
+
+static inline void amp_write_remote_assoc(struct hci_dev *hdev, u8 handle)
+{
+}
+
+static inline void amp_write_rem_assoc_continue(struct hci_dev *hdev, u8 handle)
+{
+}
+
+static inline void amp_physical_cfm(struct hci_conn *bredr_hcon,
+				    struct hci_conn *hs_hcon)
+{
+}
+
+static inline void amp_destroy_logical_link(struct hci_chan *hchan, u8 reason)
+{
+}
+#endif
+
 void amp_create_logical_link(struct l2cap_chan *chan);
 void amp_disconnect_logical_link(struct hci_chan *hchan);
-void amp_destroy_logical_link(struct hci_chan *hchan, u8 reason);
 
 #endif /* __AMP_H */
-- 
1.7.9.5

