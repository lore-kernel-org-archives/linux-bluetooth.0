Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 1/6] Bluetooth: Remove most of the inline usage
Date: Wed, 23 May 2012 04:04:18 -0300
Message-Id: <1337756663-19805-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Only obvious cases were left as inline, mostly oneline functions.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/bnep/core.c   |    4 +-
 net/bluetooth/bnep/netdev.c |    6 +-
 net/bluetooth/hci_core.c    |   33 +++++-----
 net/bluetooth/hci_event.c   |  144 ++++++++++++++++++-------------------------
 net/bluetooth/hci_sock.c    |    6 +-
 net/bluetooth/hidp/core.c   |    4 +-
 net/bluetooth/mgmt.c        |    2 +-
 net/bluetooth/rfcomm/core.c |   18 +++---
 net/bluetooth/rfcomm/tty.c  |    4 +-
 net/bluetooth/sco.c         |    9 +--
 10 files changed, 104 insertions(+), 126 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 4fab436..4fcb798 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -306,7 +306,7 @@ static u8 __bnep_rx_hlen[] = {
 	ETH_ALEN + 2  /* BNEP_COMPRESSED_DST_ONLY */
 };
 
-static inline int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
+static int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
 {
 	struct net_device *dev = s->dev;
 	struct sk_buff *nskb;
@@ -404,7 +404,7 @@ static u8 __bnep_tx_types[] = {
 	BNEP_COMPRESSED
 };
 
-static inline int bnep_tx_frame(struct bnep_session *s, struct sk_buff *skb)
+static int bnep_tx_frame(struct bnep_session *s, struct sk_buff *skb)
 {
 	struct ethhdr *eh = (void *) skb->data;
 	struct socket *sock = s->sock;
diff --git a/net/bluetooth/bnep/netdev.c b/net/bluetooth/bnep/netdev.c
index bc40864..46c9ece 100644
--- a/net/bluetooth/bnep/netdev.c
+++ b/net/bluetooth/bnep/netdev.c
@@ -128,7 +128,7 @@ static void bnep_net_timeout(struct net_device *dev)
 }
 
 #ifdef CONFIG_BT_BNEP_MC_FILTER
-static inline int bnep_net_mc_filter(struct sk_buff *skb, struct bnep_session *s)
+static int bnep_net_mc_filter(struct sk_buff *skb, struct bnep_session *s)
 {
 	struct ethhdr *eh = (void *) skb->data;
 
@@ -140,7 +140,7 @@ static inline int bnep_net_mc_filter(struct sk_buff *skb, struct bnep_session *s
 
 #ifdef CONFIG_BT_BNEP_PROTO_FILTER
 /* Determine ether protocol. Based on eth_type_trans. */
-static inline u16 bnep_net_eth_proto(struct sk_buff *skb)
+static u16 bnep_net_eth_proto(struct sk_buff *skb)
 {
 	struct ethhdr *eh = (void *) skb->data;
 	u16 proto = ntohs(eh->h_proto);
@@ -154,7 +154,7 @@ static inline u16 bnep_net_eth_proto(struct sk_buff *skb)
 	return ETH_P_802_2;
 }
 
-static inline int bnep_net_proto_filter(struct sk_buff *skb, struct bnep_session *s)
+static int bnep_net_proto_filter(struct sk_buff *skb, struct bnep_session *s)
 {
 	u16 proto = bnep_net_eth_proto(skb);
 	struct bnep_proto_filter *f = s->proto_filter;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d0a960d..7ea8302 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -167,8 +167,9 @@ static int __hci_request(struct hci_dev *hdev,
 	return err;
 }
 
-static inline int hci_request(struct hci_dev *hdev, void (*req)(struct hci_dev *hdev, unsigned long opt),
-					unsigned long opt, __u32 timeout)
+static int hci_request(struct hci_dev *hdev,
+		       void (*req)(struct hci_dev *hdev, unsigned long opt),
+		       unsigned long opt, __u32 timeout)
 {
 	int ret;
 
@@ -2245,8 +2246,8 @@ EXPORT_SYMBOL(hci_send_sco);
 /* ---- HCI TX task (outgoing data) ---- */
 
 /* HCI Connection scheduler */
-static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type,
-					    int *quote)
+static struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type,
+				     int *quote)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn *conn = NULL, *c;
@@ -2305,7 +2306,7 @@ static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type,
 	return conn;
 }
 
-static inline void hci_link_tx_to(struct hci_dev *hdev, __u8 type)
+static void hci_link_tx_to(struct hci_dev *hdev, __u8 type)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn *c;
@@ -2326,8 +2327,8 @@ static inline void hci_link_tx_to(struct hci_dev *hdev, __u8 type)
 	rcu_read_unlock();
 }
 
-static inline struct hci_chan *hci_chan_sent(struct hci_dev *hdev, __u8 type,
-					     int *quote)
+static struct hci_chan *hci_chan_sent(struct hci_dev *hdev, __u8 type,
+				      int *quote)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_chan *chan = NULL;
@@ -2461,7 +2462,7 @@ static inline int __get_blocks(struct hci_dev *hdev, struct sk_buff *skb)
 	return DIV_ROUND_UP(skb->len - HCI_ACL_HDR_SIZE, hdev->block_len);
 }
 
-static inline void __check_timeout(struct hci_dev *hdev, unsigned int cnt)
+static void __check_timeout(struct hci_dev *hdev, unsigned int cnt)
 {
 	if (!test_bit(HCI_RAW, &hdev->flags)) {
 		/* ACL tx timeout must be longer than maximum
@@ -2472,7 +2473,7 @@ static inline void __check_timeout(struct hci_dev *hdev, unsigned int cnt)
 	}
 }
 
-static inline void hci_sched_acl_pkt(struct hci_dev *hdev)
+static void hci_sched_acl_pkt(struct hci_dev *hdev)
 {
 	unsigned int cnt = hdev->acl_cnt;
 	struct hci_chan *chan;
@@ -2510,7 +2511,7 @@ static inline void hci_sched_acl_pkt(struct hci_dev *hdev)
 		hci_prio_recalculate(hdev, ACL_LINK);
 }
 
-static inline void hci_sched_acl_blk(struct hci_dev *hdev)
+static void hci_sched_acl_blk(struct hci_dev *hdev)
 {
 	unsigned int cnt = hdev->block_cnt;
 	struct hci_chan *chan;
@@ -2556,7 +2557,7 @@ static inline void hci_sched_acl_blk(struct hci_dev *hdev)
 		hci_prio_recalculate(hdev, ACL_LINK);
 }
 
-static inline void hci_sched_acl(struct hci_dev *hdev)
+static void hci_sched_acl(struct hci_dev *hdev)
 {
 	BT_DBG("%s", hdev->name);
 
@@ -2575,7 +2576,7 @@ static inline void hci_sched_acl(struct hci_dev *hdev)
 }
 
 /* Schedule SCO */
-static inline void hci_sched_sco(struct hci_dev *hdev)
+static void hci_sched_sco(struct hci_dev *hdev)
 {
 	struct hci_conn *conn;
 	struct sk_buff *skb;
@@ -2598,7 +2599,7 @@ static inline void hci_sched_sco(struct hci_dev *hdev)
 	}
 }
 
-static inline void hci_sched_esco(struct hci_dev *hdev)
+static void hci_sched_esco(struct hci_dev *hdev)
 {
 	struct hci_conn *conn;
 	struct sk_buff *skb;
@@ -2621,7 +2622,7 @@ static inline void hci_sched_esco(struct hci_dev *hdev)
 	}
 }
 
-static inline void hci_sched_le(struct hci_dev *hdev)
+static void hci_sched_le(struct hci_dev *hdev)
 {
 	struct hci_chan *chan;
 	struct sk_buff *skb;
@@ -2698,7 +2699,7 @@ static void hci_tx_work(struct work_struct *work)
 /* ----- HCI RX task (incoming data processing) ----- */
 
 /* ACL data packet */
-static inline void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
+static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_acl_hdr *hdr = (void *) skb->data;
 	struct hci_conn *conn;
@@ -2742,7 +2743,7 @@ static inline void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 }
 
 /* SCO data packet */
-static inline void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
+static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_sco_hdr *hdr = (void *) skb->data;
 	struct hci_conn *conn;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6c2d7cc..c8ef6d8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1157,8 +1157,8 @@ static void hci_cc_le_ltk_neg_reply(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_req_complete(hdev, HCI_OP_LE_LTK_NEG_REPLY, rp->status);
 }
 
-static inline void hci_cc_write_le_host_supported(struct hci_dev *hdev,
-						  struct sk_buff *skb)
+static void hci_cc_write_le_host_supported(struct hci_dev *hdev,
+					   struct sk_buff *skb)
 {
 	struct hci_cp_write_le_host_supported *sent;
 	__u8 status = *((__u8 *) skb->data);
@@ -1183,7 +1183,7 @@ static inline void hci_cc_write_le_host_supported(struct hci_dev *hdev,
 	hci_req_complete(hdev, HCI_OP_WRITE_LE_HOST_SUPPORTED, status);
 }
 
-static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
+static void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 {
 	BT_DBG("%s status 0x%x", hdev->name, status);
 
@@ -1204,7 +1204,7 @@ static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
+static void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
 {
 	struct hci_cp_create_conn *cp;
 	struct hci_conn *conn;
@@ -1351,7 +1351,7 @@ static int hci_outgoing_auth_needed(struct hci_dev *hdev,
 	return 1;
 }
 
-static inline int hci_resolve_name(struct hci_dev *hdev,
+static int hci_resolve_name(struct hci_dev *hdev,
 				   struct inquiry_entry *e)
 {
 	struct hci_cp_remote_name_req cp;
@@ -1668,8 +1668,7 @@ static void hci_cs_le_start_enc(struct hci_dev *hdev, u8 status)
 	BT_DBG("%s status 0x%x", hdev->name, status);
 }
 
-static inline void hci_inquiry_complete_evt(struct hci_dev *hdev,
-					    struct sk_buff *skb)
+static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
 	struct discovery_state *discov = &hdev->discovery;
@@ -1709,8 +1708,7 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_inquiry_result_evt(struct hci_dev *hdev,
-					  struct sk_buff *skb)
+static void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct inquiry_data data;
 	struct inquiry_info *info = (void *) (skb->data + 1);
@@ -1747,8 +1745,7 @@ static inline void hci_inquiry_result_evt(struct hci_dev *hdev,
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_conn_complete_evt(struct hci_dev *hdev,
-					 struct sk_buff *skb)
+static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_conn_complete *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -1826,8 +1823,7 @@ unlock:
 	hci_conn_check_pending(hdev);
 }
 
-static inline void hci_conn_request_evt(struct hci_dev *hdev,
-					struct sk_buff *skb)
+static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_conn_request *ev = (void *) skb->data;
 	int mask = hdev->link_mode;
@@ -1901,8 +1897,7 @@ static inline void hci_conn_request_evt(struct hci_dev *hdev,
 	}
 }
 
-static inline void hci_disconn_complete_evt(struct hci_dev *hdev,
-					    struct sk_buff *skb)
+static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_disconn_complete *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -1939,8 +1934,7 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_auth_complete_evt(struct hci_dev *hdev,
-					 struct sk_buff *skb)
+static void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_auth_complete *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -2006,7 +2000,7 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_remote_name_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static void hci_remote_name_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_remote_name *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -2045,8 +2039,7 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_encrypt_change_evt(struct hci_dev *hdev,
-					  struct sk_buff *skb)
+static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_encrypt_change *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -2089,8 +2082,8 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_change_link_key_complete_evt(struct hci_dev *hdev,
-						    struct sk_buff *skb)
+static void hci_change_link_key_complete_evt(struct hci_dev *hdev,
+					     struct sk_buff *skb)
 {
 	struct hci_ev_change_link_key_complete *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -2112,8 +2105,8 @@ static inline void hci_change_link_key_complete_evt(struct hci_dev *hdev,
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_remote_features_evt(struct hci_dev *hdev,
-					   struct sk_buff *skb)
+static void hci_remote_features_evt(struct hci_dev *hdev,
+				    struct sk_buff *skb)
 {
 	struct hci_ev_remote_features *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -2162,20 +2155,18 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_remote_version_evt(struct hci_dev *hdev,
-					  struct sk_buff *skb)
+static void hci_remote_version_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	BT_DBG("%s", hdev->name);
 }
 
-static inline void hci_qos_setup_complete_evt(struct hci_dev *hdev,
-					      struct sk_buff *skb)
+static void hci_qos_setup_complete_evt(struct hci_dev *hdev,
+				       struct sk_buff *skb)
 {
 	BT_DBG("%s", hdev->name);
 }
 
-static inline void hci_cmd_complete_evt(struct hci_dev *hdev,
-					struct sk_buff *skb)
+static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_cmd_complete *ev = (void *) skb->data;
 	__u16 opcode;
@@ -2396,7 +2387,7 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev,
 	}
 }
 
-static inline void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_cmd_status *ev = (void *) skb->data;
 	__u16 opcode;
@@ -2477,8 +2468,7 @@ static inline void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 }
 
-static inline void hci_role_change_evt(struct hci_dev *hdev,
-				       struct sk_buff *skb)
+static void hci_role_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_role_change *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -2504,8 +2494,7 @@ static inline void hci_role_change_evt(struct hci_dev *hdev,
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev,
-					 struct sk_buff *skb)
+static void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_num_comp_pkts *ev = (void *) skb->data;
 	int i;
@@ -2571,8 +2560,7 @@ static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev,
 	queue_work(hdev->workqueue, &hdev->tx_work);
 }
 
-static inline void hci_num_comp_blocks_evt(struct hci_dev *hdev,
-					   struct sk_buff *skb)
+static void hci_num_comp_blocks_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_num_comp_blocks *ev = (void *) skb->data;
 	int i;
@@ -2621,8 +2609,7 @@ static inline void hci_num_comp_blocks_evt(struct hci_dev *hdev,
 	queue_work(hdev->workqueue, &hdev->tx_work);
 }
 
-static inline void hci_mode_change_evt(struct hci_dev *hdev,
-				       struct sk_buff *skb)
+static void hci_mode_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_mode_change *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -2650,8 +2637,7 @@ static inline void hci_mode_change_evt(struct hci_dev *hdev,
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_pin_code_request_evt(struct hci_dev *hdev,
-					    struct sk_buff *skb)
+static void hci_pin_code_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_pin_code_req *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -2688,8 +2674,7 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_link_key_request_evt(struct hci_dev *hdev,
-					    struct sk_buff *skb)
+static void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_link_key_req *ev = (void *) skb->data;
 	struct hci_cp_link_key_reply cp;
@@ -2752,8 +2737,7 @@ not_found:
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_link_key_notify_evt(struct hci_dev *hdev,
-					   struct sk_buff *skb)
+static void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_link_key_notify *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -2782,8 +2766,7 @@ static inline void hci_link_key_notify_evt(struct hci_dev *hdev,
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_clock_offset_evt(struct hci_dev *hdev,
-					struct sk_buff *skb)
+static void hci_clock_offset_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_clock_offset *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -2806,8 +2789,7 @@ static inline void hci_clock_offset_evt(struct hci_dev *hdev,
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_pkt_type_change_evt(struct hci_dev *hdev,
-					   struct sk_buff *skb)
+static void hci_pkt_type_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_pkt_type_change *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -2823,8 +2805,7 @@ static inline void hci_pkt_type_change_evt(struct hci_dev *hdev,
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_pscan_rep_mode_evt(struct hci_dev *hdev,
-					  struct sk_buff *skb)
+static void hci_pscan_rep_mode_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_pscan_rep_mode *ev = (void *) skb->data;
 	struct inquiry_entry *ie;
@@ -2842,8 +2823,8 @@ static inline void hci_pscan_rep_mode_evt(struct hci_dev *hdev,
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
-						    struct sk_buff *skb)
+static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
+					     struct sk_buff *skb)
 {
 	struct inquiry_data data;
 	int num_rsp = *((__u8 *) skb->data);
@@ -2902,8 +2883,8 @@ static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_remote_ext_features_evt(struct hci_dev *hdev,
-					       struct sk_buff *skb)
+static void hci_remote_ext_features_evt(struct hci_dev *hdev,
+					struct sk_buff *skb)
 {
 	struct hci_ev_remote_ext_features *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -2951,8 +2932,8 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_sync_conn_complete_evt(struct hci_dev *hdev,
-					      struct sk_buff *skb)
+static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
+				       struct sk_buff *skb)
 {
 	struct hci_ev_sync_conn_complete *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -3007,22 +2988,20 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_sync_conn_changed_evt(struct hci_dev *hdev,
-					     struct sk_buff *skb)
+static void hci_sync_conn_changed_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	BT_DBG("%s", hdev->name);
 }
 
-static inline void hci_sniff_subrate_evt(struct hci_dev *hdev,
-					 struct sk_buff *skb)
+static void hci_sniff_subrate_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_sniff_subrate *ev = (void *) skb->data;
 
 	BT_DBG("%s status %d", hdev->name, ev->status);
 }
 
-static inline void hci_extended_inquiry_result_evt(struct hci_dev *hdev,
-						   struct sk_buff *skb)
+static void hci_extended_inquiry_result_evt(struct hci_dev *hdev,
+					    struct sk_buff *skb)
 {
 	struct inquiry_data data;
 	struct extended_inquiry_info *info = (void *) (skb->data + 1);
@@ -3069,7 +3048,7 @@ static inline void hci_extended_inquiry_result_evt(struct hci_dev *hdev,
 	hci_dev_unlock(hdev);
 }
 
-static inline u8 hci_get_auth_req(struct hci_conn *conn)
+static u8 hci_get_auth_req(struct hci_conn *conn)
 {
 	/* If remote requests dedicated bonding follow that lead */
 	if (conn->remote_auth == 0x02 || conn->remote_auth == 0x03) {
@@ -3088,8 +3067,7 @@ static inline u8 hci_get_auth_req(struct hci_conn *conn)
 	return conn->auth_type;
 }
 
-static inline void hci_io_capa_request_evt(struct hci_dev *hdev,
-					   struct sk_buff *skb)
+static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_io_capa_request *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -3141,8 +3119,7 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_io_capa_reply_evt(struct hci_dev *hdev,
-					 struct sk_buff *skb)
+static void hci_io_capa_reply_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_io_capa_reply *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -3164,8 +3141,8 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_user_confirm_request_evt(struct hci_dev *hdev,
-						struct sk_buff *skb)
+static void hci_user_confirm_request_evt(struct hci_dev *hdev,
+					 struct sk_buff *skb)
 {
 	struct hci_ev_user_confirm_req *ev = (void *) skb->data;
 	int loc_mitm, rem_mitm, confirm_hint = 0;
@@ -3232,8 +3209,8 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_user_passkey_request_evt(struct hci_dev *hdev,
-						struct sk_buff *skb)
+static void hci_user_passkey_request_evt(struct hci_dev *hdev,
+					 struct sk_buff *skb)
 {
 	struct hci_ev_user_passkey_req *ev = (void *) skb->data;
 
@@ -3247,8 +3224,8 @@ static inline void hci_user_passkey_request_evt(struct hci_dev *hdev,
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_simple_pair_complete_evt(struct hci_dev *hdev,
-						struct sk_buff *skb)
+static void hci_simple_pair_complete_evt(struct hci_dev *hdev,
+					 struct sk_buff *skb)
 {
 	struct hci_ev_simple_pair_complete *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -3276,8 +3253,8 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_remote_host_features_evt(struct hci_dev *hdev,
-						struct sk_buff *skb)
+static void hci_remote_host_features_evt(struct hci_dev *hdev,
+					 struct sk_buff *skb)
 {
 	struct hci_ev_remote_host_features *ev = (void *) skb->data;
 	struct inquiry_entry *ie;
@@ -3293,8 +3270,8 @@ static inline void hci_remote_host_features_evt(struct hci_dev *hdev,
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_remote_oob_data_request_evt(struct hci_dev *hdev,
-						   struct sk_buff *skb)
+static void hci_remote_oob_data_request_evt(struct hci_dev *hdev,
+					    struct sk_buff *skb)
 {
 	struct hci_ev_remote_oob_data_request *ev = (void *) skb->data;
 	struct oob_data *data;
@@ -3328,8 +3305,7 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_le_conn_complete_evt(struct hci_dev *hdev,
-					    struct sk_buff *skb)
+static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_le_conn_complete *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -3376,8 +3352,7 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_le_adv_report_evt(struct hci_dev *hdev,
-					 struct sk_buff *skb)
+static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	u8 num_reports = skb->data[0];
 	void *ptr = &skb->data[1];
@@ -3398,8 +3373,7 @@ static inline void hci_le_adv_report_evt(struct hci_dev *hdev,
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_le_ltk_request_evt(struct hci_dev *hdev,
-					  struct sk_buff *skb)
+static void hci_le_ltk_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_le_ltk_req *ev = (void *) skb->data;
 	struct hci_cp_le_ltk_reply cp;
@@ -3442,7 +3416,7 @@ not_found:
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_le_meta *le_ev = (void *) skb->data;
 
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index bdf51d1..89767ad 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -496,7 +496,8 @@ static int hci_sock_blacklist_del(struct hci_dev *hdev, void __user *arg)
 }
 
 /* Ioctls that require bound socket */
-static inline int hci_sock_bound_ioctl(struct sock *sk, unsigned int cmd, unsigned long arg)
+static int hci_sock_bound_ioctl(struct sock *sk, unsigned int cmd,
+				unsigned long arg)
 {
 	struct hci_dev *hdev = hci_pi(sk)->hdev;
 
@@ -712,7 +713,8 @@ static int hci_sock_getname(struct socket *sock, struct sockaddr *addr, int *add
 	return 0;
 }
 
-static inline void hci_sock_cmsg(struct sock *sk, struct msghdr *msg, struct sk_buff *skb)
+static void hci_sock_cmsg(struct sock *sk, struct msghdr *msg,
+			  struct sk_buff *skb)
 {
 	__u32 mask = hci_pi(sk)->cmsg_mask;
 
diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index d478be1..4c51e96 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -268,7 +268,7 @@ static int __hidp_send_ctrl_message(struct hidp_session *session,
 	return 0;
 }
 
-static inline int hidp_send_ctrl_message(struct hidp_session *session,
+static int hidp_send_ctrl_message(struct hidp_session *session,
 			unsigned char hdr, unsigned char *data, int size)
 {
 	int err;
@@ -471,7 +471,7 @@ static void hidp_set_timer(struct hidp_session *session)
 		mod_timer(&session->timer, jiffies + HZ * session->idle_to);
 }
 
-static inline void hidp_del_timer(struct hidp_session *session)
+static void hidp_del_timer(struct hidp_session *session)
 {
 	if (session->idle_to > 0)
 		del_timer(&session->timer);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6a7e926..18a2142 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1821,7 +1821,7 @@ static int set_io_capability(struct sock *sk, struct hci_dev *hdev, void *data,
 			    0);
 }
 
-static inline struct pending_cmd *find_pairing(struct hci_conn *conn)
+static struct pending_cmd *find_pairing(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct pending_cmd *cmd;
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 8a60238..585d391 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -115,14 +115,14 @@ static void rfcomm_session_del(struct rfcomm_session *s);
 #define __get_rpn_stop_bits(line) (((line) >> 2) & 0x1)
 #define __get_rpn_parity(line)    (((line) >> 3) & 0x7)
 
-static inline void rfcomm_schedule(void)
+static void rfcomm_schedule(void)
 {
 	if (!rfcomm_thread)
 		return;
 	wake_up_process(rfcomm_thread);
 }
 
-static inline void rfcomm_session_put(struct rfcomm_session *s)
+static void rfcomm_session_put(struct rfcomm_session *s)
 {
 	if (atomic_dec_and_test(&s->refcnt))
 		rfcomm_session_del(s);
@@ -227,7 +227,7 @@ static int rfcomm_l2sock_create(struct socket **sock)
 	return err;
 }
 
-static inline int rfcomm_check_security(struct rfcomm_dlc *d)
+static int rfcomm_check_security(struct rfcomm_dlc *d)
 {
 	struct sock *sk = d->session->sock->sk;
 	struct l2cap_conn *conn = l2cap_pi(sk)->chan->conn;
@@ -1750,7 +1750,7 @@ static void rfcomm_process_connect(struct rfcomm_session *s)
 /* Send data queued for the DLC.
  * Return number of frames left in the queue.
  */
-static inline int rfcomm_process_tx(struct rfcomm_dlc *d)
+static int rfcomm_process_tx(struct rfcomm_dlc *d)
 {
 	struct sk_buff *skb;
 	int err;
@@ -1798,7 +1798,7 @@ static inline int rfcomm_process_tx(struct rfcomm_dlc *d)
 	return skb_queue_len(&d->tx_queue);
 }
 
-static inline void rfcomm_process_dlcs(struct rfcomm_session *s)
+static void rfcomm_process_dlcs(struct rfcomm_session *s)
 {
 	struct rfcomm_dlc *d;
 	struct list_head *p, *n;
@@ -1858,7 +1858,7 @@ static inline void rfcomm_process_dlcs(struct rfcomm_session *s)
 	}
 }
 
-static inline void rfcomm_process_rx(struct rfcomm_session *s)
+static void rfcomm_process_rx(struct rfcomm_session *s)
 {
 	struct socket *sock = s->sock;
 	struct sock *sk = sock->sk;
@@ -1883,7 +1883,7 @@ static inline void rfcomm_process_rx(struct rfcomm_session *s)
 	}
 }
 
-static inline void rfcomm_accept_connection(struct rfcomm_session *s)
+static void rfcomm_accept_connection(struct rfcomm_session *s)
 {
 	struct socket *sock = s->sock, *nsock;
 	int err;
@@ -1917,7 +1917,7 @@ static inline void rfcomm_accept_connection(struct rfcomm_session *s)
 		sock_release(nsock);
 }
 
-static inline void rfcomm_check_connection(struct rfcomm_session *s)
+static void rfcomm_check_connection(struct rfcomm_session *s)
 {
 	struct sock *sk = s->sock->sk;
 
@@ -1941,7 +1941,7 @@ static inline void rfcomm_check_connection(struct rfcomm_session *s)
 	}
 }
 
-static inline void rfcomm_process_sessions(void)
+static void rfcomm_process_sessions(void)
 {
 	struct list_head *p, *n;
 
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 4bf54b3..c91e233 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -142,7 +142,7 @@ static struct rfcomm_dev *__rfcomm_dev_get(int id)
 	return NULL;
 }
 
-static inline struct rfcomm_dev *rfcomm_dev_get(int id)
+static struct rfcomm_dev *rfcomm_dev_get(int id)
 {
 	struct rfcomm_dev *dev;
 
@@ -351,7 +351,7 @@ static void rfcomm_wfree(struct sk_buff *skb)
 	rfcomm_dev_put(dev);
 }
 
-static inline void rfcomm_set_owner_w(struct sk_buff *skb, struct rfcomm_dev *dev)
+static void rfcomm_set_owner_w(struct sk_buff *skb, struct rfcomm_dev *dev)
 {
 	rfcomm_dev_hold(dev);
 	atomic_add(skb->truesize, &dev->wmem_alloc);
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 78473ff..824ae2f 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -123,7 +123,7 @@ static struct sco_conn *sco_conn_add(struct hci_conn *hcon)
 	return conn;
 }
 
-static inline struct sock *sco_chan_get(struct sco_conn *conn)
+static struct sock *sco_chan_get(struct sco_conn *conn)
 {
 	struct sock *sk = NULL;
 	sco_conn_lock(conn);
@@ -157,7 +157,8 @@ static int sco_conn_del(struct hci_conn *hcon, int err)
 	return 0;
 }
 
-static inline int sco_chan_add(struct sco_conn *conn, struct sock *sk, struct sock *parent)
+static int sco_chan_add(struct sco_conn *conn, struct sock *sk,
+			struct sock *parent)
 {
 	int err = 0;
 
@@ -228,7 +229,7 @@ done:
 	return err;
 }
 
-static inline int sco_send_frame(struct sock *sk, struct msghdr *msg, int len)
+static int sco_send_frame(struct sock *sk, struct msghdr *msg, int len)
 {
 	struct sco_conn *conn = sco_pi(sk)->conn;
 	struct sk_buff *skb;
@@ -254,7 +255,7 @@ static inline int sco_send_frame(struct sock *sk, struct msghdr *msg, int len)
 	return len;
 }
 
-static inline void sco_recv_frame(struct sco_conn *conn, struct sk_buff *skb)
+static void sco_recv_frame(struct sco_conn *conn, struct sk_buff *skb)
 {
 	struct sock *sk = sco_chan_get(conn);
 
-- 
1.7.10.1

