Return-Path: <cyrus@holtmann.org>
From: =?utf-8?q?Erik=20Andr=C3=A9n?= <erik.andren@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?utf-8?q?Erik=20Andr=C3=A9n?= <erik.andren@gmail.com>
Subject: [PATCH 3/3] Checkpatch.pl: Fixup hci_event.c
Date: Mon,  9 Mar 2009 20:55:29 +0100
Message-Id: <1236628529-23819-4-git-send-email-erik.andren@gmail.com>
In-Reply-To: <1236628529-23819-3-git-send-email-erik.andren@gmail.com>
References: <1>
 <1236628529-23819-1-git-send-email-erik.andren@gmail.com>
 <1236628529-23819-2-git-send-email-erik.andren@gmail.com>
 <1236628529-23819-3-git-send-email-erik.andren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Erik Andrén <erik.andren@gmail.com>
---
 net/bluetooth/hci_event.c |  172 +++++++++++++++++++++++++++++----------------
 1 files changed, 111 insertions(+), 61 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5553424..25f8fa4 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -36,10 +36,10 @@
 #include <linux/skbuff.h>
 #include <linux/interrupt.h>
 #include <linux/notifier.h>
+#include <linux/uaccess.h>
 #include <net/sock.h>
 
 #include <asm/system.h>
-#include <asm/uaccess.h>
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -77,12 +77,14 @@ static void hci_cc_exit_periodic_inq(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_conn_check_pending(hdev);
 }
 
-static void hci_cc_remote_name_req_cancel(struct hci_dev *hdev, struct sk_buff *skb)
+static void hci_cc_remote_name_req_cancel(struct hci_dev *hdev,
+					  struct sk_buff *skb)
 {
 	BT_DBG("%s", hdev->name);
 }
 
-static void hci_cc_role_discovery(struct hci_dev *hdev, struct sk_buff *skb)
+static void hci_cc_role_discovery(struct hci_dev *hdev,
+				  struct sk_buff *skb)
 {
 	struct hci_rp_role_discovery *rp = (void *) skb->data;
 	struct hci_conn *conn;
@@ -148,7 +150,8 @@ static void hci_cc_write_link_policy(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_unlock(hdev);
 }
 
-static void hci_cc_read_def_link_policy(struct hci_dev *hdev, struct sk_buff *skb)
+static void hci_cc_read_def_link_policy(struct hci_dev *hdev,
+					struct sk_buff *skb)
 {
 	struct hci_rp_read_def_link_policy *rp = (void *) skb->data;
 
@@ -160,7 +163,8 @@ static void hci_cc_read_def_link_policy(struct hci_dev *hdev, struct sk_buff *sk
 	hdev->link_policy = __le16_to_cpu(rp->policy);
 }
 
-static void hci_cc_write_def_link_policy(struct hci_dev *hdev, struct sk_buff *skb)
+static void hci_cc_write_def_link_policy(struct hci_dev *hdev,
+					 struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
 	void *sent;
@@ -346,7 +350,8 @@ static void hci_cc_read_voice_setting(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 }
 
-static void hci_cc_write_voice_setting(struct hci_dev *hdev, struct sk_buff *skb)
+static void hci_cc_write_voice_setting(struct hci_dev *hdev,
+				       struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
 	__u16 setting;
@@ -433,7 +438,8 @@ static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
 					hdev->hci_ver, hdev->hci_rev);
 }
 
-static void hci_cc_read_local_commands(struct hci_dev *hdev, struct sk_buff *skb)
+static void hci_cc_read_local_commands(struct hci_dev *hdev,
+				       struct sk_buff *skb)
 {
 	struct hci_rp_read_local_commands *rp = (void *) skb->data;
 
@@ -445,7 +451,8 @@ static void hci_cc_read_local_commands(struct hci_dev *hdev, struct sk_buff *skb
 	memcpy(hdev->commands, rp->commands, sizeof(hdev->commands));
 }
 
-static void hci_cc_read_local_features(struct hci_dev *hdev, struct sk_buff *skb)
+static void hci_cc_read_local_features(struct hci_dev *hdev,
+				       struct sk_buff *skb)
 {
 	struct hci_rp_read_local_features *rp = (void *) skb->data;
 
@@ -613,11 +620,14 @@ static void hci_cs_add_sco(struct hci_dev *hdev, __u8 status)
 	hci_dev_lock(hdev);
 
 	acl = hci_conn_hash_lookup_handle(hdev, handle);
-	if (acl && (sco = acl->link)) {
-		sco->state = BT_CLOSED;
+	if (acl) {
+		sco = acl->link;
+		if (sco) {
+			sco->state = BT_CLOSED;
 
-		hci_proto_connect_cfm(sco, status);
-		hci_conn_del(sco);
+			hci_proto_connect_cfm(sco, status);
+			hci_conn_del(sco);
+		}
 	}
 
 	hci_dev_unlock(hdev);
@@ -758,11 +768,14 @@ static void hci_cs_setup_sync_conn(struct hci_dev *hdev, __u8 status)
 	hci_dev_lock(hdev);
 
 	acl = hci_conn_hash_lookup_handle(hdev, handle);
-	if (acl && (sco = acl->link)) {
-		sco->state = BT_CLOSED;
+	if (acl) {
+		sco = acl->link;
+		if (sco) {
+			sco->state = BT_CLOSED;
 
-		hci_proto_connect_cfm(sco, status);
-		hci_conn_del(sco);
+			hci_proto_connect_cfm(sco, status);
+			hci_conn_del(sco);
+		}
 	}
 
 	hci_dev_unlock(hdev);
@@ -814,7 +827,8 @@ static void hci_cs_exit_sniff_mode(struct hci_dev *hdev, __u8 status)
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_inquiry_complete_evt(struct hci_dev *hdev,
+					    struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
 
@@ -827,7 +841,8 @@ static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff
 	hci_conn_check_pending(hdev);
 }
 
-static inline void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_inquiry_result_evt(struct hci_dev *hdev,
+					  struct sk_buff *skb)
 {
 	struct inquiry_data data;
 	struct inquiry_info *info = (void *) (skb->data + 1);
@@ -856,7 +871,8 @@ static inline void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_conn_complete_evt(struct hci_dev *hdev,
+					 struct sk_buff *skb)
 {
 	struct hci_ev_conn_complete *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -932,7 +948,8 @@ unlock:
 	hci_conn_check_pending(hdev);
 }
 
-static inline void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_conn_request_evt(struct hci_dev *hdev,
+					struct sk_buff *skb)
 {
 	struct hci_ev_conn_request *ev = (void *) skb->data;
 	int mask = hdev->link_mode;
@@ -949,12 +966,15 @@ static inline void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *sk
 
 		hci_dev_lock(hdev);
 
-		if ((ie = hci_inquiry_cache_lookup(hdev, &ev->bdaddr)))
+		ie = hci_inquiry_cache_lookup(hdev, &ev->bdaddr);
+		if (ie)
 			memcpy(ie->data.dev_class, ev->dev_class, 3);
 
-		conn = hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);
+		conn = hci_conn_hash_lookup_ba(hdev,
+					       ev->link_type, &ev->bdaddr);
 		if (!conn) {
-			if (!(conn = hci_conn_add(hdev, ev->link_type, &ev->bdaddr))) {
+			conn = hci_conn_add(hdev, ev->link_type, &ev->bdaddr)
+			if (!conn) {
 				BT_ERR("No memmory for new connection");
 				hci_dev_unlock(hdev);
 				return;
@@ -1003,7 +1023,8 @@ static inline void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *sk
 	}
 }
 
-static inline void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_disconn_complete_evt(struct hci_dev *hdev,
+					    struct sk_buff *skb)
 {
 	struct hci_ev_disconn_complete *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -1026,7 +1047,8 @@ static inline void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_auth_complete_evt(struct hci_dev *hdev,
+					 struct sk_buff *skb)
 {
 	struct hci_ev_auth_complete *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -1075,14 +1097,16 @@ static inline void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_remote_name_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_remote_name_evt(struct hci_dev *hdev,
+				       struct sk_buff *skb)
 {
 	BT_DBG("%s", hdev->name);
 
 	hci_conn_check_pending(hdev);
 }
 
-static inline void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_encrypt_change_evt(struct hci_dev *hdev,
+					  struct sk_buff *skb)
 {
 	struct hci_ev_encrypt_change *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -1117,7 +1141,8 @@ static inline void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_change_link_key_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_change_link_key_complete_evt(struct hci_dev *hdev,
+						    struct sk_buff *skb)
 {
 	struct hci_ev_change_link_key_complete *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -1139,7 +1164,8 @@ static inline void hci_change_link_key_complete_evt(struct hci_dev *hdev, struct
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_remote_features_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_remote_features_evt(struct hci_dev *hdev,
+					   struct sk_buff *skb)
 {
 	struct hci_ev_remote_features *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -1173,17 +1199,20 @@ static inline void hci_remote_features_evt(struct hci_dev *hdev, struct sk_buff
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_remote_version_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_remote_version_evt(struct hci_dev *hdev,
+					  struct sk_buff *skb)
 {
 	BT_DBG("%s", hdev->name);
 }
 
-static inline void hci_qos_setup_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_qos_setup_complete_evt(struct hci_dev *hdev,
+					      struct sk_buff *skb)
 {
 	BT_DBG("%s", hdev->name);
 }
 
-static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_cmd_complete_evt(struct hci_dev *hdev,
+					struct sk_buff *skb)
 {
 	struct hci_ev_cmd_complete *ev = (void *) skb->data;
 	__u16 opcode;
@@ -1375,7 +1404,8 @@ static inline void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 }
 
-static inline void hci_role_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_role_change_evt(struct hci_dev *hdev,
+				       struct sk_buff *skb)
 {
 	struct hci_ev_role_change *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -1401,7 +1431,8 @@ static inline void hci_role_change_evt(struct hci_dev *hdev, struct sk_buff *skb
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev,
+					 struct sk_buff *skb)
 {
 	struct hci_ev_num_comp_pkts *ev = (void *) skb->data;
 	__le16 *ptr;
@@ -1430,10 +1461,12 @@ static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *s
 			conn->sent -= count;
 
 			if (conn->type == ACL_LINK) {
-				if ((hdev->acl_cnt += count) > hdev->acl_pkts)
+				hdev->acl_cnt += count;
+				if (hdev->acl_cnt > hdev->acl_pkts)
 					hdev->acl_cnt = hdev->acl_pkts;
 			} else {
-				if ((hdev->sco_cnt += count) > hdev->sco_pkts)
+				hdev->sco_cnt += count;
+				if (hdev->sco_cnt > hdev->sco_pkts)
 					hdev->sco_cnt = hdev->sco_pkts;
 			}
 		}
@@ -1444,7 +1477,8 @@ static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *s
 	tasklet_enable(&hdev->tx_task);
 }
 
-static inline void hci_mode_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_mode_change_evt(struct hci_dev *hdev,
+				       struct sk_buff *skb)
 {
 	struct hci_ev_mode_change *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -1469,22 +1503,26 @@ static inline void hci_mode_change_evt(struct hci_dev *hdev, struct sk_buff *skb
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_pin_code_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_pin_code_request_evt(struct hci_dev *hdev,
+					    struct sk_buff *skb)
 {
 	BT_DBG("%s", hdev->name);
 }
 
-static inline void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_link_key_request_evt(struct hci_dev *hdev,
+					    struct sk_buff *skb)
 {
 	BT_DBG("%s", hdev->name);
 }
 
-static inline void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_link_key_notify_evt(struct hci_dev *hdev,
+					   struct sk_buff *skb)
 {
 	BT_DBG("%s", hdev->name);
 }
 
-static inline void hci_clock_offset_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_clock_offset_evt(struct hci_dev *hdev,
+					struct sk_buff *skb)
 {
 	struct hci_ev_clock_offset *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -1496,8 +1534,8 @@ static inline void hci_clock_offset_evt(struct hci_dev *hdev, struct sk_buff *sk
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
 	if (conn && !ev->status) {
 		struct inquiry_entry *ie;
-
-		if ((ie = hci_inquiry_cache_lookup(hdev, &conn->dst))) {
+		ie = hci_inquiry_cache_lookup(hdev, &conn->dst);
+		if (ie) {
 			ie->data.clock_offset = ev->clock_offset;
 			ie->timestamp = jiffies;
 		}
@@ -1506,7 +1544,8 @@ static inline void hci_clock_offset_evt(struct hci_dev *hdev, struct sk_buff *sk
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_pkt_type_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_pkt_type_change_evt(struct hci_dev *hdev,
+					   struct sk_buff *skb)
 {
 	struct hci_ev_pkt_type_change *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -1522,7 +1561,8 @@ static inline void hci_pkt_type_change_evt(struct hci_dev *hdev, struct sk_buff
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_pscan_rep_mode_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_pscan_rep_mode_evt(struct hci_dev *hdev,
+					  struct sk_buff *skb)
 {
 	struct hci_ev_pscan_rep_mode *ev = (void *) skb->data;
 	struct inquiry_entry *ie;
@@ -1531,7 +1571,8 @@ static inline void hci_pscan_rep_mode_evt(struct hci_dev *hdev, struct sk_buff *
 
 	hci_dev_lock(hdev);
 
-	if ((ie = hci_inquiry_cache_lookup(hdev, &ev->bdaddr))) {
+	ie = hci_inquiry_cache_lookup(hdev, &ev->bdaddr);
+	if (ie) {
 		ie->data.pscan_rep_mode = ev->pscan_rep_mode;
 		ie->timestamp = jiffies;
 	}
@@ -1539,7 +1580,8 @@ static inline void hci_pscan_rep_mode_evt(struct hci_dev *hdev, struct sk_buff *
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
+						    struct sk_buff *skb)
 {
 	struct inquiry_data data;
 	int num_rsp = *((__u8 *) skb->data);
@@ -1552,7 +1594,8 @@ static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct
 	hci_dev_lock(hdev);
 
 	if ((skb->len - 1) / num_rsp != sizeof(struct inquiry_info_with_rssi)) {
-		struct inquiry_info_with_rssi_and_pscan_mode *info = (void *) (skb->data + 1);
+		struct inquiry_info_with_rssi_and_pscan_mode *info =
+				(void *) (skb->data + 1);
 
 		for (; num_rsp; num_rsp--) {
 			bacpy(&data.bdaddr, &info->bdaddr);
@@ -1586,7 +1629,8 @@ static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_remote_ext_features_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_remote_ext_features_evt(struct hci_dev *hdev,
+					       struct sk_buff *skb)
 {
 	struct hci_ev_remote_ext_features *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -1599,8 +1643,8 @@ static inline void hci_remote_ext_features_evt(struct hci_dev *hdev, struct sk_b
 	if (conn) {
 		if (!ev->status && ev->page == 0x01) {
 			struct inquiry_entry *ie;
-
-			if ((ie = hci_inquiry_cache_lookup(hdev, &conn->dst)))
+			ie = hci_inquiry_cache_lookup(hdev, &conn->dst);
+			if (ie)
 				ie->data.ssp_mode = (ev->features[0] & 0x01);
 
 			conn->ssp_mode = (ev->features[0] & 0x01);
@@ -1625,7 +1669,8 @@ static inline void hci_remote_ext_features_evt(struct hci_dev *hdev, struct sk_b
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_sync_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_sync_conn_complete_evt(struct hci_dev *hdev,
+					      struct sk_buff *skb)
 {
 	struct hci_ev_sync_conn_complete *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -1669,12 +1714,14 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_sync_conn_changed_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_sync_conn_changed_evt(struct hci_dev *hdev,
+					     struct sk_buff *skb)
 {
 	BT_DBG("%s", hdev->name);
 }
 
-static inline void hci_sniff_subrate_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_sniff_subrate_evt(struct hci_dev *hdev,
+					 struct sk_buff *skb)
 {
 	struct hci_ev_sniff_subrate *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -1684,13 +1731,12 @@ static inline void hci_sniff_subrate_evt(struct hci_dev *hdev, struct sk_buff *s
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
-	if (conn) {
-	}
 
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_extended_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_extended_inquiry_result_evt(struct hci_dev *hdev,
+						   struct sk_buff *skb)
 {
 	struct inquiry_data data;
 	struct extended_inquiry_info *info = (void *) (skb->data + 1);
@@ -1719,7 +1765,8 @@ static inline void hci_extended_inquiry_result_evt(struct hci_dev *hdev, struct
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_io_capa_request_evt(struct hci_dev *hdev,
+					   struct sk_buff *skb)
 {
 	struct hci_ev_io_capa_request *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -1735,7 +1782,8 @@ static inline void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_simple_pair_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_simple_pair_complete_evt(struct hci_dev *hdev,
+						struct sk_buff *skb)
 {
 	struct hci_ev_simple_pair_complete *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -1751,7 +1799,8 @@ static inline void hci_simple_pair_complete_evt(struct hci_dev *hdev, struct sk_
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_remote_host_features_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_remote_host_features_evt(struct hci_dev *hdev,
+						struct sk_buff *skb)
 {
 	struct hci_ev_remote_host_features *ev = (void *) skb->data;
 	struct inquiry_entry *ie;
@@ -1760,7 +1809,8 @@ static inline void hci_remote_host_features_evt(struct hci_dev *hdev, struct sk_
 
 	hci_dev_lock(hdev);
 
-	if ((ie = hci_inquiry_cache_lookup(hdev, &ev->bdaddr)))
+	ie = hci_inquiry_cache_lookup(hdev, &ev->bdaddr);
+	if (ie)
 		ie->data.ssp_mode = (ev->features[0] & 0x01);
 
 	hci_dev_unlock(hdev);
-- 
1.5.6.3

