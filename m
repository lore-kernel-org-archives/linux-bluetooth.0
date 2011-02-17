Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 09/10] Bluetooth: Fix code style issues, make checkpatch less noisy about hci_event.c
Date: Thu, 17 Feb 2011 14:16:40 +0100
Message-ID: <1297948601-12723-10-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1297948601-12723-1-git-send-email-szymon.janc@tieto.com>
References: <1297948601-12723-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/hci_event.c |  136 +++++++++++++++++++++++++++++---------------
 1 files changed, 89 insertions(+), 47 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b39c9bb..9fa91c8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -77,7 +77,8 @@ static void hci_cc_exit_periodic_inq(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_conn_check_pending(hdev);
 }
 
-static void hci_cc_remote_name_req_cancel(struct hci_dev *hdev, struct sk_buff *skb)
+static void hci_cc_remote_name_req_cancel(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	BT_DBG("%s", hdev->name);
 }
@@ -148,7 +149,8 @@ static void hci_cc_write_link_policy(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_unlock(hdev);
 }
 
-static void hci_cc_read_def_link_policy(struct hci_dev *hdev, struct sk_buff *skb)
+static void hci_cc_read_def_link_policy(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	struct hci_rp_read_def_link_policy *rp = (void *) skb->data;
 
@@ -160,7 +162,8 @@ static void hci_cc_read_def_link_policy(struct hci_dev *hdev, struct sk_buff *sk
 	hdev->link_policy = __le16_to_cpu(rp->policy);
 }
 
-static void hci_cc_write_def_link_policy(struct hci_dev *hdev, struct sk_buff *skb)
+static void hci_cc_write_def_link_policy(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
 	void *sent;
@@ -355,7 +358,8 @@ static void hci_cc_read_voice_setting(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 }
 
-static void hci_cc_write_voice_setting(struct hci_dev *hdev, struct sk_buff *skb)
+static void hci_cc_write_voice_setting(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
 	__u16 setting;
@@ -574,7 +578,8 @@ static void hci_setup_link_policy(struct hci_dev *hdev)
 					sizeof(link_policy), &link_policy);
 }
 
-static void hci_cc_read_local_commands(struct hci_dev *hdev, struct sk_buff *skb)
+static void hci_cc_read_local_commands(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	struct hci_rp_read_local_commands *rp = (void *) skb->data;
 
@@ -592,7 +597,8 @@ done:
 	hci_req_complete(hdev, HCI_OP_READ_LOCAL_COMMANDS, rp->status);
 }
 
-static void hci_cc_read_local_features(struct hci_dev *hdev, struct sk_buff *skb)
+static void hci_cc_read_local_features(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	struct hci_rp_read_local_features *rp = (void *) skb->data;
 
@@ -1174,7 +1180,8 @@ static void hci_cs_le_create_conn(struct hci_dev *hdev, __u8 status)
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_inquiry_complete_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
 
@@ -1187,7 +1194,8 @@ static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff
 	hci_conn_check_pending(hdev);
 }
 
-static inline void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_inquiry_result_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	struct inquiry_data data;
 	struct inquiry_info *info = (void *) (skb->data + 1);
@@ -1216,7 +1224,8 @@ static inline void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_conn_complete_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	struct hci_ev_conn_complete *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -1294,7 +1303,8 @@ unlock:
 	hci_conn_check_pending(hdev);
 }
 
-static inline void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_conn_request_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	struct hci_ev_conn_request *ev = (void *) skb->data;
 	int mask = hdev->link_mode;
@@ -1304,7 +1314,8 @@ static inline void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *sk
 
 	mask |= hci_proto_connect_ind(hdev, &ev->bdaddr, ev->link_type);
 
-	if ((mask & HCI_LM_ACCEPT) && !hci_blacklist_lookup(hdev, &ev->bdaddr)) {
+	if ((mask & HCI_LM_ACCEPT) &&
+			!hci_blacklist_lookup(hdev, &ev->bdaddr)) {
 		/* Connection accepted */
 		struct inquiry_entry *ie;
 		struct hci_conn *conn;
@@ -1315,7 +1326,8 @@ static inline void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *sk
 		if (ie)
 			memcpy(ie->data.dev_class, ev->dev_class, 3);
 
-		conn = hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);
+		conn = hci_conn_hash_lookup_ba(hdev, ev->link_type,
+								&ev->bdaddr);
 		if (!conn) {
 			conn = hci_conn_add(hdev, ev->link_type, &ev->bdaddr);
 			if (!conn) {
@@ -1367,7 +1379,8 @@ static inline void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *sk
 	}
 }
 
-static inline void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_disconn_complete_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	struct hci_ev_disconn_complete *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -1397,7 +1410,8 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_auth_complete_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	struct hci_ev_auth_complete *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -1454,7 +1468,8 @@ static inline void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_remote_name_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_remote_name_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	struct hci_ev_remote_name *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -1475,7 +1490,8 @@ static inline void hci_remote_name_evt(struct hci_dev *hdev, struct sk_buff *skb
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_encrypt_change_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	struct hci_ev_encrypt_change *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -1510,7 +1526,8 @@ static inline void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_change_link_key_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_change_link_key_complete_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	struct hci_ev_change_link_key_complete *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -1532,7 +1549,8 @@ static inline void hci_change_link_key_complete_evt(struct hci_dev *hdev, struct
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_remote_features_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_remote_features_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	struct hci_ev_remote_features *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -1578,17 +1596,20 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_remote_version_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_remote_version_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	BT_DBG("%s", hdev->name);
 }
 
-static inline void hci_qos_setup_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_qos_setup_complete_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	BT_DBG("%s", hdev->name);
 }
 
-static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_cmd_complete_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	struct hci_ev_cmd_complete *ev = (void *) skb->data;
 	__u16 opcode;
@@ -1835,7 +1856,8 @@ static inline void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 }
 
-static inline void hci_role_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_role_change_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	struct hci_ev_role_change *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -1861,7 +1883,8 @@ static inline void hci_role_change_evt(struct hci_dev *hdev, struct sk_buff *skb
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	struct hci_ev_num_comp_pkts *ev = (void *) skb->data;
 	__le16 *ptr;
@@ -1916,7 +1939,8 @@ static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *s
 	tasklet_enable(&hdev->tx_task);
 }
 
-static inline void hci_mode_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_mode_change_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	struct hci_ev_mode_change *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -1944,7 +1968,8 @@ static inline void hci_mode_change_evt(struct hci_dev *hdev, struct sk_buff *skb
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_pin_code_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_pin_code_request_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	struct hci_ev_pin_code_req *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -1970,7 +1995,8 @@ static inline void hci_pin_code_request_evt(struct hci_dev *hdev, struct sk_buff
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_link_key_request_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	struct hci_ev_link_key_req *ev = (void *) skb->data;
 	struct hci_cp_link_key_reply cp;
@@ -2021,7 +2047,8 @@ not_found:
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_link_key_notify_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	struct hci_ev_link_key_notify *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -2046,7 +2073,8 @@ static inline void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_clock_offset_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_clock_offset_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	struct hci_ev_clock_offset *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -2069,7 +2097,8 @@ static inline void hci_clock_offset_evt(struct hci_dev *hdev, struct sk_buff *sk
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_pkt_type_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_pkt_type_change_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	struct hci_ev_pkt_type_change *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -2085,7 +2114,8 @@ static inline void hci_pkt_type_change_evt(struct hci_dev *hdev, struct sk_buff
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_pscan_rep_mode_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_pscan_rep_mode_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	struct hci_ev_pscan_rep_mode *ev = (void *) skb->data;
 	struct inquiry_entry *ie;
@@ -2103,7 +2133,8 @@ static inline void hci_pscan_rep_mode_evt(struct hci_dev *hdev, struct sk_buff *
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	struct inquiry_data data;
 	int num_rsp = *((__u8 *) skb->data);
@@ -2116,7 +2147,8 @@ static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct
 	hci_dev_lock(hdev);
 
 	if ((skb->len - 1) / num_rsp != sizeof(struct inquiry_info_with_rssi)) {
-		struct inquiry_info_with_rssi_and_pscan_mode *info = (void *) (skb->data + 1);
+		struct inquiry_info_with_rssi_and_pscan_mode *info;
+		info = (void *) (skb->data + 1);
 
 		for (; num_rsp; num_rsp--) {
 			bacpy(&data.bdaddr, &info->bdaddr);
@@ -2150,7 +2182,8 @@ static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_remote_ext_features_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_remote_ext_features_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	struct hci_ev_remote_ext_features *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -2194,7 +2227,8 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_sync_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_sync_conn_complete_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	struct hci_ev_sync_conn_complete *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -2249,19 +2283,22 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_sync_conn_changed_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_sync_conn_changed_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	BT_DBG("%s", hdev->name);
 }
 
-static inline void hci_sniff_subrate_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_sniff_subrate_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	struct hci_ev_sniff_subrate *ev = (void *) skb->data;
 
 	BT_DBG("%s status %d", hdev->name, ev->status);
 }
 
-static inline void hci_extended_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_extended_inquiry_result_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	struct inquiry_data data;
 	struct extended_inquiry_info *info = (void *) (skb->data + 1);
@@ -2276,12 +2313,12 @@ static inline void hci_extended_inquiry_result_evt(struct hci_dev *hdev, struct
 
 	for (; num_rsp; num_rsp--) {
 		bacpy(&data.bdaddr, &info->bdaddr);
-		data.pscan_rep_mode     = info->pscan_rep_mode;
-		data.pscan_period_mode  = info->pscan_period_mode;
-		data.pscan_mode         = 0x00;
+		data.pscan_rep_mode	= info->pscan_rep_mode;
+		data.pscan_period_mode	= info->pscan_period_mode;
+		data.pscan_mode		= 0x00;
 		memcpy(data.dev_class, info->dev_class, 3);
-		data.clock_offset       = info->clock_offset;
-		data.rssi               = info->rssi;
+		data.clock_offset	= info->clock_offset;
+		data.rssi		= info->rssi;
 		data.ssp_mode		= 0x01;
 		info++;
 		hci_inquiry_cache_update(hdev, &data);
@@ -2309,7 +2346,8 @@ static inline u8 hci_get_auth_req(struct hci_conn *conn)
 	return conn->auth_type;
 }
 
-static inline void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_io_capa_request_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	struct hci_ev_io_capa_request *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -2357,7 +2395,8 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_io_capa_reply_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_io_capa_reply_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	struct hci_ev_io_capa_reply *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -2380,7 +2419,8 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_simple_pair_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_simple_pair_complete_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	struct hci_ev_simple_pair_complete *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -2396,7 +2436,8 @@ static inline void hci_simple_pair_complete_evt(struct hci_dev *hdev, struct sk_
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_remote_host_features_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_remote_host_features_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	struct hci_ev_remote_host_features *ev = (void *) skb->data;
 	struct inquiry_entry *ie;
@@ -2443,7 +2484,8 @@ static inline void hci_remote_oob_data_request_evt(struct hci_dev *hdev,
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_le_conn_complete_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
 {
 	struct hci_ev_le_conn_complete *ev = (void *) skb->data;
 	struct hci_conn *conn;
-- 
1.7.0.4

