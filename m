Return-Path: <cyrus@holtmann.org>
From: Dan Tian <Dan.Tian@Atheros.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Haijun Liu <Haijun.Liu@Atheros.com>,
	Luis Rodriguez <Luis.Rodriguez@Atheros.com>
Date: Thu, 15 Jul 2010 15:37:32 +0800
Subject: [PATCH 1/3] Add BT3 AMP device support, by Atheros Linux BT3 team.
Message-ID: <CDAFEDABF718A54BABD0DA5476695307CE881EC1@SHEXMB-01.global.atheros.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From 40cbfbf5c1bc9109364970956d9b6f74f5846c70 Mon Sep 17 00:00:00 2001
From: Haijun.Liu <Haijun.Liu@Atheros.com>
Date: Wed, 14 Jul 2010 22:50:56 +0800
Subject: [PATCH 1/3] Add BT3 AMP device support, by Atheros Linux BT3 team.


Signed-off-by: Haijun.Liu <Haijun.Liu@Atheros.com>
---
 include/net/bluetooth/hci.h      |  342 +++++++++++++++++++-
 include/net/bluetooth/hci_core.h |  264 ++++++++++++++-
 net/bluetooth/cmtp/core.c        |    1 +
 net/bluetooth/hci_conn.c         |  201 +++++++++++-
 net/bluetooth/hci_core.c         |  349 ++++++++++++++++++--
 net/bluetooth/hci_event.c        |  698 +++++++++++++++++++++++++++++++++++++-
 6 files changed, 1822 insertions(+), 33 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index ca2518e..702cef5 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -30,6 +30,12 @@
 #define HCI_MAX_EVENT_SIZE     260
 #define HCI_MAX_FRAME_SIZE     (HCI_MAX_ACL_SIZE + 4)

+#define HCI_MAX_AMP_KEY_SIZE   32
+/* Max80211AMPASSOCLen p1763. */
+#define HCI_MAX_AMP_ASSOC_SIZE 672
+
+#define HCI_MAX_AMP_ASSOC_FRAGMENT     248
+
 /* HCI dev events */
 #define HCI_DEV_REG                    1
 #define HCI_DEV_UNREG                  2
@@ -152,6 +158,7 @@ enum {
 /* ACL flags */
 #define ACL_CONT               0x01
 #define ACL_START              0x02
+#define ACL_COMPLETE   0x03
 #define ACL_ACTIVE_BCAST       0x04
 #define ACL_PICO_BCAST         0x08

@@ -281,6 +288,11 @@ struct hci_cp_link_key_reply {
        __u8     link_key[16];
 } __attribute__ ((packed));

+struct hci_rp_link_key_reply {
+       __u8    status;
+       bdaddr_t        bdaddr;
+} __attribute__ ((packed));
+
 #define HCI_OP_LINK_KEY_NEG_REPLY      0x040c
 struct hci_cp_link_key_neg_reply {
        bdaddr_t bdaddr;
@@ -377,6 +389,75 @@ struct hci_cp_reject_sync_conn_req {
        __u8     reason;
 } __attribute__ ((packed));

+#define HCI_OP_CREATE_PHYSICAL_LINK    0x0435
+struct hci_cp_create_physical_link {
+       __u8    handle;
+       __u8    key_len;
+       __u8    key_type;
+       __u8    key[HCI_MAX_AMP_KEY_SIZE];
+} __attribute__ ((packed));
+
+#define HCI_OP_ACCEPT_PHYSICAL_LINK    0x0436
+struct hci_cp_accept_physical_link {
+       __u8    handle;
+       __u8    key_len;
+       __u8    key_type;
+       __u8    key[HCI_MAX_AMP_KEY_SIZE];
+} __attribute__ ((packed));
+
+#define HCI_OP_DISCONN_PHYSICAL_LINK   0x0437
+struct hci_cp_disconn_physical_link {
+       __u8    handle;
+       __u8    reason;
+} __attribute__ ((packed));
+
+struct hci_ext_flow_spec_le {
+       __u8    id;
+       __u8    service_type;
+       __le16  max_sdu_size;
+       __le32  sdu_inter_time;
+       __le32  access_latency;
+       __le32  flush_timeout;
+} __attribute__ ((packed));
+
+#define HCI_OP_CREATE_LOGICAL_LINK     0x0438
+struct hci_cp_create_logical_link {
+       __u8    handle;
+       struct hci_ext_flow_spec_le     tx_flow_spec;
+       struct hci_ext_flow_spec_le     rx_flow_spec;
+} __attribute__ ((packed));
+
+#define HCI_OP_ACCEPT_LOGICAL_LINK     0x0439
+struct hci_cp_accept_logical_link {
+       __u8    handle;
+       struct hci_ext_flow_spec_le     tx_flow_spec;
+       struct hci_ext_flow_spec_le     rx_flow_spec;
+} __attribute__ ((packed));
+
+#define HCI_OP_DISCONN_LOGICAL_LINK    0x043a
+struct hci_cp_disconn_logical_link {
+       __le16  handle;
+} __attribute__ ((packed));
+
+#define HCI_OP_LOGICAL_LINK_CANCEL     0x043b
+struct hci_cp_logical_link_cancel {
+       __u8    handle;
+       __u8    tx_flow_spec_id;
+} __attribute__ ((packed));
+
+struct hci_rp_logical_link_cancel {
+       __u8    status;
+       __u8    handle;
+       __u8    tx_flow_spec_id;
+} __attribute__ ((packed));
+
+#define HCI_OP_FLOW_SPEC_MODIFY                0x043c
+struct hci_cp_flow_spec_modify {
+       __le16  handle;
+       struct hci_ext_flow_spec_le     tx_flow_spec;
+       struct hci_ext_flow_spec_le     rx_flow_spec;
+} __attribute__ ((packed));
+
 #define HCI_OP_SNIFF_MODE              0x0803
 struct hci_cp_sniff_mode {
        __le16   handle;
@@ -489,7 +570,7 @@ struct hci_rp_read_local_name {

 #define HCI_OP_WRITE_PG_TIMEOUT                0x0c18

-#define HCI_OP_WRITE_SCAN_ENABLE       0x0c1a
+#define HCI_OP_WRITE_SCAN_ENABLE       0x0c1a
        #define SCAN_DISABLED           0x00
        #define SCAN_INQUIRY            0x01
        #define SCAN_PAGE               0x02
@@ -548,6 +629,107 @@ struct hci_cp_write_ssp_mode {
        __u8     mode;
 } __attribute__ ((packed));

+#define HCI_OP_READ_LOGICAL_LINK_ACCEPT_TIMEOUT        0x0c61
+struct hci_rp_read_logical_link_accept_timeout {
+       __u8    status;
+       __le16  timeout;
+} __attribute__ ((packed));
+
+#define HCI_OP_WRITE_LOGICAL_LINK_ACCEPT_TIMEOUT 0x0c62
+struct hci_cp_write_logical_link_accept_timeout {
+       __le16  timeout;
+} __attribute__ ((packed));
+
+struct hci_rp_write_logical_link_accept_timeout {
+       __u8    status;
+} __attribute__ ((packed));
+
+#define HCI_OP_SET_EVENT_MASK_PAGE2    0x0c63
+struct hci_cp_set_event_mask_page2 {
+       __u8    evt_mask_page2[8];
+} __attribute__ ((packed));
+
+struct hci_rp_set_event_mask_page2 {
+       __u8    status;
+} __attribute__ ((packed));
+
+struct location_data {
+       __u8    domain_aware;
+       __u8    domain;
+       __u8    domain_option;
+       __u8    option;
+} __attribute__ ((packed));
+
+#define HCI_OP_READ_LOCATION_DATA      0x0c64
+struct hci_rp_read_location_data {
+       __u8    status;
+       struct location_data location;
+} __attribute__ ((packed));
+
+#define HCI_OP_WRITE_LOCATION_DATA     0x0c65
+struct hci_cp_write_location_data {
+       struct location_data location;
+} __attribute__ ((packed));
+
+#define HCI_OP_READ_FLOW_CONTROL_MODE  0x0c66
+struct hci_rp_read_flow_control_mode {
+       __u8    status;
+       __u8    mode;
+} __attribute__ ((packed));
+
+#define HCI_OP_WRITE_FLOW_CONTROL_MODE 0x0c67
+struct hci_cp_write_flow_control_mode {
+       __u8    mode;
+} __attribute__ ((packed));
+
+struct hci_rp_write_flow_control_mode {
+       __u8    status;
+} __attribute__ ((packed));
+
+#define HCI_OP_READ_ETX_POWER_LEVEL    0x0c68
+struct hci_cp_etx_power_level {
+       __le16  handle;
+       __u8    type;
+} __attribute__ ((packed));
+
+struct hci_rp_etx_power_level {
+       __u8    status;
+       __le16  handle;
+       __u8    gfsk;
+       __u8    dqpsk;
+       __u8    eight_dpsk;
+} __attribute__ ((packed));
+
+#define HCI_OP_READ_BEST_EFFORT_FLUSH_TIMEOUT  0x0c69
+struct hci_cp_read_best_effort_flush_timeout {
+       __le16  handle;
+} __attribute__ ((packed));
+
+struct hci_rp_read_best_effort_flush_timeout {
+       __u8    status;
+       __le32  timeout;
+} __attribute__ ((packed));
+
+#define HCI_OP_WRITE_BEST_EFFORT_FlUSH_TIMEOUT 0x0c6a
+struct hci_cp_write_best_effort_flush_timeout {
+       __le16  handle;
+       __le32  timeout;
+} __attribute__ ((packed));
+
+struct hci_rp_write_best_effort_flush_timeout {
+       __u8    status;
+} __attribute__ ((packed));
+
+#define HCI_OP_SHORT_RANGE_MODE                0x0c6b
+struct hci_cp_short_range_mode {
+       __u8    handle;
+       __u8    mode;
+} __attribute__ ((packed));
+
+struct hci_rp_short_range_mode {
+       __u8    status;
+} __attribute__ ((packed));
+
 #define HCI_OP_READ_LOCAL_VERSION      0x1001
 struct hci_rp_read_local_version {
        __u8     status;
@@ -593,6 +775,67 @@ struct hci_rp_read_bd_addr {
        bdaddr_t bdaddr;
 } __attribute__ ((packed));

+#define HCI_OP_READ_DATA_BLOCK_SIZE    0x100a
+struct hci_rp_read_data_block_size {
+       __u8    status;
+       __le16  max_pkt_len;
+       __le16  max_blk_len;
+       __le16  num_blks;
+} __attribute__ ((packed));
+
+#define HCI_OP_READ_ENCRYPT_KEY_SIZE   0x1408
+struct hci_cp_read_encrypt_key_size {
+       __le16  handle;
+} __attribute__ ((packed));
+
+struct hci_rp_read_encrypt_key_size {
+       __u8    status;
+       __le16  handle;
+       __u8    key_size;
+} __attribute__ ((packed));
+
+#define HCI_OP_READ_LOCAL_AMP_INFO     0x1409
+struct hci_rp_read_local_amp_info {
+       __u8    status;
+       __u8    amp_status;
+       __le32  total_bandwidth;
+       __le32  max_guaranteed_bandwidth;
+       __le32  min_latency;
+       __le32  max_pdu_size;
+       __u8    controller_type;
+       __le16  pal_caps;
+       __le16  max_amp_assoc_len;
+       __le32  max_flush_timeout;
+       __le32  best_effort_flush_timeout;
+} __attribute__ ((packed));
+
+#define HCI_OP_READ_LOCAL_AMP_ASSOC    0x140a
+struct hci_cp_read_local_amp_assoc {
+       __u8    handle;
+       __le16  len_so_far;
+       __le16  max_remote_amp_assoc_len;
+} __attribute__ ((packed));
+
+struct hci_rp_read_local_amp_assoc {
+       __u8    status;
+       __u8    handle;
+       __le16  amp_assoc_remaining_len;
+       __u8    amp_assoc_fragment[HCI_MAX_AMP_ASSOC_FRAGMENT];
+} __attribute__ ((packed));
+
+#define HCI_OP_WRITE_REMOTE_AMP_ASSOC  0x140b
+struct hci_cp_write_remote_amp_assoc {
+       __u8    handle;
+       __le16  len_so_far;
+       __le16  amp_assoc_remaining_len;
+       __u8    amp_assoc_fragment[HCI_MAX_AMP_ASSOC_FRAGMENT];
+} __attribute__ ((packed));
+
+struct hci_rp_write_remote_amp_assoc {
+       __u8    status;
+       __u8    handle;
+} __attribute__ ((packed));
+
 /* ---- HCI Events ---- */
 #define HCI_EV_INQUIRY_COMPLETE                0x01

@@ -698,6 +941,11 @@ struct hci_ev_cmd_status {
        __le16   opcode;
 } __attribute__ ((packed));

+#define HCI_EV_FLUSH_OCCURRED          0x11
+struct hci_ev_flush_occurred {
+       __u16   handle;
+} __attribute__ ((packed));
+
 #define HCI_EV_ROLE_CHANGE             0x12
 struct hci_ev_role_change {
        __u8     status;
@@ -845,6 +1093,98 @@ struct hci_ev_remote_host_features {
        __u8     features[8];
 } __attribute__ ((packed));

+#define HCI_EV_PHYSICAL_LINK_COMPLETE  0x40
+struct hci_ev_physical_link_complete {
+       __u8    status;
+       __u8    handle;
+} __attribute__ ((packed));
+
+#define HCI_EV_CHANNEL_SELECTED                        0x41
+struct hci_ev_channel_selected {
+       __u8    handle;
+} __attribute__ ((packed));
+
+#define HCI_EV_DISCONN_PHYSICAL_LINK_COMPLETE  0x42
+struct hci_ev_disconn_physical_link_complete {
+       __u8    status;
+       __u8    handle;
+       __u8    reason;
+} __attribute__ ((packed));
+
+#define HCI_EV_PHYSICAL_LINK_LOSS_EARLY_WARNING        0x43
+struct hci_ev_physical_link_loss_early_warning {
+       __u8    handle;
+       __u8    reason;
+} __attribute__ ((packed));
+
+#define HCI_EV_PHYSICAL_LINK_RECOVERY          0x44
+struct hci_ev_physical_link_recovery {
+       __u8    status;
+} __attribute__ ((packed));
+
+#define HCI_EV_LOGICAL_LINK_COMPLETE           0x45
+struct hci_ev_logical_link_complete {
+       __u8    status;
+       __le16  logical_link_handle;
+       __u8    physical_link_handle;
+       __u8    tx_flow_spec_id;
+} __attribute__ ((packed));
+
+#define HCI_EV_DISCONN_LOGICAL_LINK_COMPLETE   0x46
+struct hci_ev_disconn_logical_link_complete {
+       __u8    status;
+       __le16  handle;
+       __u8    reason;
+} __attribute__ ((packed));
+
+#define HCI_EV_FLOW_SPEC_MODIFY_COMPLETE       0x47
+struct hci_ev_flow_spec_modify_complete {
+       __u8    status;
+       __le16  handle;
+} __attribute__ ((packed));
+
+#define HCI_EV_NUM_OF_COMPLETED_DATA_BLOCKS    0x48
+struct hci_ev_num_of_completed_data_blocks {
+       __le16  num_data_blocks;
+       __u8    num_handles;
+} __attribute__ ((packed));
+
+#define HCI_EV_SHORT_RANGE_MODE_CHANGE_COMPLETE        0x4c
+struct hci_ev_short_range_mode_change_complete {
+       __u8    status;
+       __u8    handle;
+       __u8    state;
+} __attribute__ ((packed));
+
+#define HCI_EV_AMP_STATUS_CHANGE               0x4d
+struct hci_ev_amp_status_change {
+       __u8    status;
+       __u8    amp_status;
+} __attribute__ ((packed));
+
+#define HCI_EV_AMP_START_TEST                  0x49
+struct hci_ev_amp_start_test {
+       __u8    status;
+       __u8    scenario;
+} __attribute__ ((packed));
+
+#define HCI_EV_AMP_TEST_END                    0x4a
+struct hci_ev_amp_test_end {
+       __u8    status;
+       __u8    scenario;
+} __attribute__ ((packed));
+
+#define HCI_EV_AMP_RECEIVER_REPORT             0x4b
+struct hci_ev_amp_receiver_report {
+       __u8    controller_type;
+       __u8    reason;
+       __u32   evt_type;
+       __le16  num_frames;
+       __le16  num_error_frames;
+       __u32   num_bits;
+       __u32   num_error_bits;
+} __attribute__ ((packed));
+
 /* Internal events generated by Bluetooth stack */
 #define HCI_EV_STACK_INTERNAL  0xfd
 struct hci_ev_stack_internal {
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 600372d..04267a9 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -67,6 +67,40 @@ struct bdaddr_list {
        bdaddr_t bdaddr;
 };

+struct amp_assoc {
+       __u16   len;
+       __u16   offset;
+       __u8    data[HCI_MAX_AMP_ASSOC_SIZE];
+};
+
+struct amp_info {
+       __u8    amp_status;
+       __le32  total_bandwidth;
+       __le32  max_guaranteed_bandwidth;
+       __le32  min_latency;
+       __le32  max_pdu_size;
+       __u8    ctrl_type;
+       __le16  pal_caps;
+       __le16  max_assoc_len;
+       __le32  max_flush_to;
+       __le32  best_effort_flush_to;
+};
+
+struct amp_link_key {
+       __u8    key_len;
+       __u8    key_type;
+       __u8    key[HCI_MAX_AMP_KEY_SIZE];
+};
+
+struct ext_flow_spec {
+       __u8    id;
+       __u8    service_type;
+       __u16   max_sdu_size;
+       __u32   sdu_inter_time;
+       __u32   access_latency;
+       __u32   flush_timeout;
+} __attribute__ ((packed));
+
 struct hci_dev {
        struct list_head list;
        spinlock_t      lock;
@@ -142,6 +176,7 @@ struct hci_dev {
        void                    *core_data;

        atomic_t                promisc;
+       void                    *amp_controller;

        struct dentry           *debugfs;

@@ -152,6 +187,11 @@ struct hci_dev {

        struct module           *owner;

+       struct amp_info         ctrl_info;
+       __u8                    ctrl_id;
+       struct amp_assoc        local_assoc;
+       struct list_head        phy_links;
+
        int (*open)(struct hci_dev *hdev);
        int (*close)(struct hci_dev *hdev);
        int (*flush)(struct hci_dev *hdev);
@@ -161,6 +201,27 @@ struct hci_dev {
        int (*ioctl)(struct hci_dev *hdev, unsigned int cmd, unsigned long arg);
 };

+enum {
+       HCI_AMP_ROLE_INITIATOR,
+       HCI_AMP_ROLE_RESPONDER
+};
+struct hci_phy_link {
+       struct list_head list;
+
+       __u8            handle;
+       __u16           state;
+       void            *l2cap_data;
+       __u8            amp_role;
+
+       void            *priv_data;
+       __u16   acl_link_state;
+       struct list_head                log_links;
+       struct hci_dev          *hdev;
+       /* remote amp assoc data. */
+       struct amp_assoc        remote_assoc;
+
+};
+
 struct hci_conn {
        struct list_head list;

@@ -187,6 +248,9 @@ struct hci_conn {
        __u16            disc_timeout;
        unsigned long    pend;

+       __u8            link_key[16];
+       __u8            key_type;
+
        unsigned int     sent;

        struct sk_buff_head data_q;
@@ -205,6 +269,11 @@ struct hci_conn {
        void            *sco_data;
        void            *priv;

+       __u8    amp_role;
+       /* id value in Tx_Flow_Spec to identify the logical link. */
+       __u8    tx_flow_spec_id;
+       struct hci_phy_link     *phylink;
+
        struct hci_conn *link;
 };

@@ -215,8 +284,8 @@ extern rwlock_t hci_dev_list_lock;
 extern rwlock_t hci_cb_list_lock;

 /* ----- Inquiry cache ----- */
-#define INQUIRY_CACHE_AGE_MAX   (HZ*30)   // 30 seconds
-#define INQUIRY_ENTRY_AGE_MAX   (HZ*60)   // 60 seconds
+#define INQUIRY_CACHE_AGE_MAX   (HZ*30)   /* 30 seconds        */
+#define INQUIRY_ENTRY_AGE_MAX   (HZ*60)   /* 60 seconds        */

 #define inquiry_cache_lock(c)          spin_lock(&c->lock)
 #define inquiry_cache_unlock(c)                spin_unlock(&c->lock)
@@ -287,6 +356,9 @@ static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hci_conn *c)
                h->sco_num--;
 }

+struct hci_conn *hci_loglink_lookup_handle
+(struct hci_dev *hdev, __u16 log_handle);
+
 static inline struct hci_conn *hci_conn_hash_lookup_handle(struct hci_dev *hdev,
                                        __u16 handle)
 {
@@ -294,10 +366,14 @@ static inline struct hci_conn *hci_conn_hash_lookup_handle(struct hci_dev *hdev,
        struct list_head *p;
        struct hci_conn  *c;

-       list_for_each(p, &h->list) {
-               c = list_entry(p, struct hci_conn, list);
-               if (c->handle == handle)
-                       return c;
+       if (hdev->dev_type == HCI_80211) {
+               return hci_loglink_lookup_handle(hdev, handle);
+       } else {
+               list_for_each(p, &h->list) {
+                       c = list_entry(p, struct hci_conn, list);
+                       if (c->handle == handle)
+                               return c;
+               }
        }
        return NULL;
 }
@@ -362,6 +438,7 @@ static inline void hci_conn_hold(struct hci_conn *conn)

 static inline void hci_conn_put(struct hci_conn *conn)
 {
+       BT_DBG("put conn:%p, refcnt:%d", conn, atomic_read(&conn->refcnt));
        if (atomic_dec_and_test(&conn->refcnt)) {
                unsigned long timeo;
                if (conn->type == ACL_LINK) {
@@ -469,6 +546,11 @@ struct hci_proto {
        int (*recv_acldata)     (struct hci_conn *conn, struct sk_buff *skb, __u16 flags);
        int (*recv_scodata)     (struct hci_conn *conn, struct sk_buff *skb);
        int (*security_cfm)     (struct hci_conn *conn, __u8 status, __u8 encrypt);
+
+       int (*loglink_create_cfm) (struct hci_conn *conn, __u8 status);
+       int (*loglink_accept_cfm) (struct hci_conn *conn, __u8 status);
+       int (*loglink_modify_cfm) (struct hci_conn *conn, __u8 status);
+       int (*loglink_put_cfm) (struct hci_conn *conn, __u8 status);
 };

 static inline int hci_proto_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 type)
@@ -561,6 +643,45 @@ static inline void hci_proto_encrypt_cfm(struct hci_conn *conn, __u8 status, __u
                hp->security_cfm(conn, status, encrypt);
 }

+static inline void hci_proto_loglink_create_cfm(struct hci_conn *conn,
+                                               __u8 status)
+{
+       register struct hci_proto *hp;
+
+       hp = hci_proto[HCI_PROTO_L2CAP];
+       if (hp && hp->loglink_create_cfm)
+               hp->loglink_create_cfm(conn, status);
+}
+
+static inline void hci_proto_loglink_accept_cfm(struct hci_conn *conn,
+                                               __u8 status)
+{
+       register struct hci_proto *hp;
+
+       hp = hci_proto[HCI_PROTO_L2CAP];
+       if (hp && hp->loglink_accept_cfm)
+               hp->loglink_accept_cfm(conn, status);
+}
+
+static inline void hci_proto_loglink_modify_cfm(struct hci_conn *conn,
+                                               __u8 status)
+{
+       register struct hci_proto *hp;
+
+       hp = hci_proto[HCI_PROTO_L2CAP];
+       if (hp && hp->loglink_modify_cfm)
+               hp->loglink_modify_cfm(conn, status);
+}
+
+static inline void hci_proto_loglink_put_cfm(struct hci_conn *conn, __u8 status)
+{
+       register struct hci_proto *hp;
+
+       hp = hci_proto[HCI_PROTO_L2CAP];
+       if (hp && hp->loglink_put_cfm)
+               hp->loglink_put_cfm(conn, status);
+}
+
 int hci_register_proto(struct hci_proto *hproto);
 int hci_unregister_proto(struct hci_proto *hproto);

@@ -573,6 +694,15 @@ struct hci_cb {
        void (*security_cfm)    (struct hci_conn *conn, __u8 status, __u8 encrypt);
        void (*key_change_cfm)  (struct hci_conn *conn, __u8 status);
        void (*role_switch_cfm) (struct hci_conn *conn, __u8 status, __u8 role);
+
+       /* ---- AMP HCI callbacks. ---- */
+       int (*create_physical_link_cfm) (struct hci_dev *hdev, __u8 handle,
+                                        __u8 status);
+       int (*put_physical_link_cfm) (struct hci_dev *hdev, __u8 handle,
+                                       __u8 status, __u8 reason);
+
+       int (*local_assoc_ind) (struct hci_dev *hdev, __u8 status);
+       int (*local_info_ind) (struct hci_dev *hdev, __u8 status);
 };

 static inline void hci_auth_cfm(struct hci_conn *conn, __u8 status)
@@ -640,6 +770,69 @@ static inline void hci_role_switch_cfm(struct hci_conn *conn, __u8 status, __u8
        read_unlock_bh(&hci_cb_list_lock);
 }

+static inline int hci_create_physical_link_cfm(struct hci_dev *hdev,
+                                               __u8 handle, __u8 status)
+{
+       struct list_head *p;
+
+       read_lock_bh(&hci_cb_list_lock);
+       list_for_each(p, &hci_cb_list) {
+               struct hci_cb *cb = list_entry(p, struct hci_cb, list);
+               if (cb->create_physical_link_cfm)
+                       cb->create_physical_link_cfm(hdev, handle, status);
+       }
+       read_unlock_bh(&hci_cb_list_lock);
+
+       return 0;
+}
+
+static inline int hci_put_physical_link_cfm(struct hci_dev *hdev, __u8 handle,
+                                               __u8 status, __u8 reason)
+{
+       struct list_head *p;
+
+       read_lock_bh(&hci_cb_list_lock);
+       list_for_each(p, &hci_cb_list) {
+               struct hci_cb *cb = list_entry(p, struct hci_cb, list);
+               if (cb->put_physical_link_cfm)
+                       cb->put_physical_link_cfm(hdev, handle, status, reason);
+       }
+       read_unlock_bh(&hci_cb_list_lock);
+
+       return 0;
+}
+
+static inline int hci_local_assoc_ind(struct hci_dev *hdev, __u8 status)
+{
+       struct list_head *p;
+
+       read_lock_bh(&hci_cb_list_lock);
+       list_for_each(p, &hci_cb_list) {
+               struct hci_cb *cb = list_entry(p, struct hci_cb, list);
+               if (cb->local_assoc_ind)
+                       cb->local_assoc_ind(hdev, status);
+       }
+       read_unlock_bh(&hci_cb_list_lock);
+
+       return 0;
+}
+
+static inline int hci_local_info_ind(struct hci_dev *hdev, __u8 status)
+{
+       struct list_head *p;
+
+       read_lock_bh(&hci_cb_list_lock);
+       list_for_each(p, &hci_cb_list) {
+               struct hci_cb *cb = list_entry(p, struct hci_cb, list);
+               if (cb->local_info_ind)
+                       cb->local_info_ind(hdev, status);
+       }
+       read_unlock_bh(&hci_cb_list_lock);
+
+       return 0;
+}
+
+
 int hci_register_cb(struct hci_cb *hcb);
 int hci_unregister_cb(struct hci_cb *hcb);

@@ -647,8 +840,8 @@ int hci_register_notifier(struct notifier_block *nb);
 int hci_unregister_notifier(struct notifier_block *nb);

 int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param);
-void hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags);
-void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);
+int hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags);
+int hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);

 void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);

@@ -686,4 +879,59 @@ struct hci_sec_filter {

 void hci_req_complete(struct hci_dev *hdev, int result);

+
+
+/* ------ AMP HCI interface for upper layer ----- */
+#define HCI_CREATE_PHYLINK_PEND        0x40
+
+static inline struct hci_phy_link
+*hci_phylink_lookup_handle(struct hci_dev *hdev, __u8 phy_handle)
+{
+       struct hci_phy_link *plink;
+       struct list_head *p;
+
+       list_for_each(p, &hdev->phy_links) {
+               plink = list_entry(p, struct hci_phy_link, list);
+               if (plink->handle == phy_handle)
+                       return plink;
+       }
+       return NULL;
+}
+
+static inline void hci_loglink_hold(struct hci_conn *conn)
+{
+       atomic_inc(&conn->refcnt);
+}
+
+int hci_loglink_del(struct hci_conn *conn);
+
+void hci_loglink_put(struct hci_conn *conn);
+
+struct hci_conn
+*hci_loglink_lookup_tx_flow_spec_id(struct hci_phy_link *plink, __u8 id);
+
+int hci_phylink_del(struct hci_phy_link *plink);
+
+struct hci_phy_link *hci_phylink_create(struct hci_dev *hdev, __u8 phy_handle,
+                                               struct amp_link_key *key,
+                                               __u8 *rem_assoc,
+                                               __u16 assoc_size,
+                                               void *priv_data);
+struct hci_phy_link *hci_phylink_accept(struct hci_dev *hdev, __u8 phy_handle,
+                                               struct amp_link_key *key,
+                                               __u8 *rem_assoc,
+                                               __u16 assoc_size,
+                                               void *priv_data);
+void hci_phylink_put(struct hci_phy_link *phy_link, __u8 reason);
+
+struct hci_conn *hci_loglink_create(void *handle, struct ext_flow_spec *tx,
+                                       struct ext_flow_spec *rx);
+struct hci_conn *hci_loglink_accept(void *handle, struct ext_flow_spec *tx,
+                                       struct ext_flow_spec *rx);
+void hci_loglink_modify(struct hci_conn *hconn, struct ext_flow_spec *tx,
+                                       struct ext_flow_spec *rx);
+void hci_loglink_put(struct hci_conn *hconn);
+void hci_read_local_amp_info(struct hci_dev *hdev);
+void hci_read_local_amp_assoc(struct hci_dev *hdev);
+
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/cmtp/core.c b/net/bluetooth/cmtp/core.c
index d4c6af0..51c4b5c 100644
--- a/net/bluetooth/cmtp/core.c
+++ b/net/bluetooth/cmtp/core.c
@@ -40,6 +40,7 @@
 #include <linux/isdn/capilli.h>

 #include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>

 #include "cmtp.h"
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index e9fef83..c7f9134 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -161,7 +161,7 @@ static void hci_conn_timeout(unsigned long arg)
        struct hci_dev *hdev = conn->hdev;
        __u8 reason;

-       BT_DBG("conn %p state %d", conn, conn->state);
+       BT_DBG("conn %p state %d, refcnt:%d", conn, conn->state, atomic_read(&conn->refcnt));

        if (atomic_read(&conn->refcnt))
                return;
@@ -203,6 +203,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
        BT_DBG("%s dst %s", hdev->name, batostr(dst));

        conn = kzalloc(sizeof(struct hci_conn), GFP_ATOMIC);
+       BT_DBG("kzalloc hci_conn:%p", conn);
        if (!conn)
                return NULL;

@@ -708,3 +709,201 @@ int hci_get_auth_info(struct hci_dev *hdev, void __user *arg)

        return copy_to_user(arg, &req, sizeof(req)) ? -EFAULT : 0;
 }
+
+struct hci_conn *hci_loglink_lookup_handle(struct hci_dev *hdev, __u16 log_handle)
+{
+
+       struct hci_conn *conn;
+       struct list_head *p;
+       struct list_head *p2;
+       struct hci_phy_link *plink;
+
+       list_for_each(p, &hdev->phy_links) {
+               plink = list_entry(p, struct hci_phy_link, list);
+               list_for_each(p2, &plink->log_links) {
+                       conn = list_entry(p2, struct hci_conn, list);
+                       if (conn->handle == log_handle)
+                               return conn;
+               }
+       }
+       return NULL;
+
+}
+
+struct hci_conn *hci_loglink_lookup_tx_flow_spec_id(struct hci_phy_link *plink, __u8 id)
+{
+       struct hci_conn *conn;
+       struct list_head *p;
+
+       list_for_each(p, &plink->log_links) {
+               conn = list_entry(p, struct hci_conn, list);
+               if (conn->tx_flow_spec_id == id)
+                       return conn;
+       }
+       return NULL;
+}
+
+static struct hci_conn *hci_loglink_add(struct hci_phy_link *plink, __u8 id, int type, __u8 role)
+{
+       struct hci_conn *conn;
+       struct hci_dev *hdev = plink->hdev;
+
+       BT_DBG("phylink:%p", plink);
+
+       conn = kzalloc(sizeof(struct hci_conn), GFP_ATOMIC);
+       BT_DBG("kzalloc conn:%p", conn);
+       if (!conn)
+               return NULL;
+
+       conn->hdev = hdev;
+       conn->phylink = plink;
+       conn->type = type;
+       conn->tx_flow_spec_id = id;
+       conn->state = BT_OPEN;
+       conn->amp_role = role;
+
+       skb_queue_head_init(&conn->data_q);
+
+       list_add(&conn->list, &plink->log_links);
+
+       return conn;
+
+}
+
+int hci_loglink_del(struct hci_conn *conn)
+{
+       struct hci_dev *hdev = conn->hdev;
+       /*struct hci_phy_link *plink = conn->phylink;*/
+
+       BT_DBG("%s conn:%p handle %d", hdev->name, conn, conn->handle);
+
+       skb_queue_purge(&conn->data_q);
+
+       /*hci_phylink_put(plink, 0x13);*/
+       list_del(&conn->list);
+       kfree(conn);
+       return 0;
+}
+
+static inline void hci_build_ext_flow_spec(struct hci_ext_flow_spec_le *to, struct ext_flow_spec *from)
+{
+       to->id = from->id;
+       to->service_type = from->service_type;
+       to->max_sdu_size = cpu_to_le16(from->max_sdu_size);
+       to->sdu_inter_time = cpu_to_le32(from->sdu_inter_time);
+       to->access_latency = cpu_to_le32(from->access_latency);
+       to->flush_timeout = cpu_to_le32(from->flush_timeout);
+}
+
+static void hci_loglink_connect(struct hci_conn *conn, __u8 phy_handle, __u8 amp_role,
+                               struct ext_flow_spec *tx, struct ext_flow_spec *rx)
+{
+       struct hci_dev *hdev = conn->hdev;
+       struct hci_cp_create_logical_link cp;
+
+       BT_DBG("%p", conn);
+
+       conn->state = BT_CONNECT;
+       conn->out = 1;
+
+       memset(&cp, 0, sizeof(cp));
+
+       cp.handle = phy_handle;
+       hci_build_ext_flow_spec(&cp.tx_flow_spec, tx);
+       hci_build_ext_flow_spec(&cp.rx_flow_spec, rx);
+       if (amp_role == HCI_AMP_ROLE_INITIATOR)
+               hci_send_cmd(hdev, HCI_OP_CREATE_LOGICAL_LINK, sizeof(cp), &cp);
+       else
+               hci_send_cmd(hdev, HCI_OP_ACCEPT_LOGICAL_LINK, sizeof(cp), &cp);
+}
+
+struct hci_conn *hci_loglink_create(void *handle, struct ext_flow_spec *tx, struct ext_flow_spec *rx)
+{
+       struct hci_phy_link *plink = (void *) handle;
+       struct hci_dev *hdev = plink->hdev;
+       struct hci_conn *conn;
+
+       BT_DBG("%s phylink:%p", hdev->name, plink);
+
+       /* acl link over BREDR is in BT_CONNECTED state. */
+       plink->acl_link_state = BT_CONNECTED;
+
+       conn = hci_loglink_add(plink, tx->id, ACL_LINK, HCI_AMP_ROLE_INITIATOR);
+       if (!conn)
+               return NULL;
+
+       hci_loglink_connect(conn, plink->handle, HCI_AMP_ROLE_INITIATOR, tx, rx);
+       return conn;
+}
+EXPORT_SYMBOL(hci_loglink_create);
+
+struct hci_conn *hci_loglink_accept(void *handle, struct ext_flow_spec *tx, struct ext_flow_spec *rx)
+{
+       struct hci_phy_link *plink = (void *) handle;
+       struct hci_dev *hdev = plink->hdev;
+       struct hci_conn *conn;
+
+       BT_DBG("%s phylink:%p", hdev->name, plink);
+
+       /* acl link over BREDR is in BT_CONNECTED state. */
+       plink->acl_link_state = BT_CONNECTED;
+
+       conn = hci_loglink_add(plink, tx->id, ACL_LINK, HCI_AMP_ROLE_RESPONDER);
+       if (!conn)
+               return NULL;
+
+       hci_loglink_connect(conn, plink->handle, HCI_AMP_ROLE_RESPONDER, tx, rx);
+       return conn;
+}
+EXPORT_SYMBOL(hci_loglink_accept);
+
+void hci_loglink_modify(struct hci_conn *hconn, struct ext_flow_spec *tx, struct ext_flow_spec *rx)
+{
+       struct hci_dev *hdev = hconn->hdev;
+       struct hci_cp_flow_spec_modify cp;
+
+       if (hconn->state != BT_CONNECTED)
+               return;
+
+       cp.handle = cpu_to_le16(hconn->handle);
+       hci_build_ext_flow_spec(&cp.tx_flow_spec, tx);
+       hci_build_ext_flow_spec(&cp.rx_flow_spec, rx);
+
+       hci_send_cmd(hdev, HCI_OP_FLOW_SPEC_MODIFY, sizeof(cp), &cp);
+}
+EXPORT_SYMBOL(hci_loglink_modify);
+
+void hci_loglink_put(struct hci_conn *conn)
+{
+       struct hci_dev *hdev = conn->hdev;
+       struct hci_conn *acl_link = conn->phylink->priv_data;
+
+       BT_DBG("%s conn:%p", hdev->name, conn);
+
+       if (!hci_loglink_lookup_tx_flow_spec_id(conn->phylink,  conn->tx_flow_spec_id))
+               return;
+
+       /* save the state of the acl connection over BREDR.*/
+       conn->phylink->acl_link_state = acl_link->state;
+
+       if (conn->state == BT_CONNECTED) {
+               struct hci_cp_disconn_logical_link cp;
+
+               cp.handle = cpu_to_le16(conn->handle);
+               hci_send_cmd(hdev, HCI_OP_DISCONN_LOGICAL_LINK, sizeof(cp), &cp);
+
+       } else if (conn->state == BT_CONNECT) {
+               struct hci_cp_logical_link_cancel cp;
+
+               cp.handle = conn->phylink->handle;
+               cp.tx_flow_spec_id = conn->tx_flow_spec_id;
+
+               hci_send_cmd(hdev, HCI_OP_LOGICAL_LINK_CANCEL, sizeof(cp), &cp);
+       } else {
+               hci_proto_loglink_put_cfm(conn, 0x13);
+               hci_loglink_del(conn);
+       }
+
+}
+EXPORT_SYMBOL(hci_loglink_put);
+
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index aeb2982..712af4b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -54,16 +54,23 @@ static void hci_cmd_task(unsigned long arg);
 static void hci_rx_task(unsigned long arg);
 static void hci_tx_task(unsigned long arg);
 static void hci_notify(struct hci_dev *hdev, int event);
+static inline void hci_amp_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb);

 static DEFINE_RWLOCK(hci_task_lock);

 /* HCI device list */
 LIST_HEAD(hci_dev_list);
+EXPORT_SYMBOL(hci_dev_list);
+
 DEFINE_RWLOCK(hci_dev_list_lock);
+EXPORT_SYMBOL(hci_dev_list_lock);

 /* HCI callback list */
 LIST_HEAD(hci_cb_list);
+EXPORT_SYMBOL(hci_cb_list);
+
 DEFINE_RWLOCK(hci_cb_list_lock);
+EXPORT_SYMBOL(hci_cb_list_lock);

 /* HCI protocols */
 #define HCI_MAX_PROTO  2
@@ -78,11 +85,13 @@ int hci_register_notifier(struct notifier_block *nb)
 {
        return atomic_notifier_chain_register(&hci_notifier, nb);
 }
+EXPORT_SYMBOL(hci_register_notifier);

 int hci_unregister_notifier(struct notifier_block *nb)
 {
        return atomic_notifier_chain_unregister(&hci_notifier, nb);
 }
+EXPORT_SYMBOL(hci_unregister_notifier);

 static void hci_notify(struct hci_dev *hdev, int event)
 {
@@ -215,6 +224,12 @@ static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
        /* Read Buffer Size (ACL mtu, max pkt, etc.) */
        hci_send_cmd(hdev, HCI_OP_READ_BUFFER_SIZE, 0, NULL);

+       /* 3.0+ HS Read Data Block Size */
+       hci_send_cmd(hdev, HCI_OP_READ_DATA_BLOCK_SIZE, 0, NULL);
+
+       /* 3.0+ HS Read Flow Control Mode */
+       hci_send_cmd(hdev, HCI_OP_READ_FLOW_CONTROL_MODE, 0, NULL);
+
 #if 0
        /* Host buffer size */
        {
@@ -227,17 +242,20 @@ static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
        }
 #endif

-       /* Read BD Address */
-       hci_send_cmd(hdev, HCI_OP_READ_BD_ADDR, 0, NULL);
+       /*BREDR */
+       if (hdev->dev_type == HCI_BREDR) {
+               /* Read BD Address */
+               hci_send_cmd(hdev, HCI_OP_READ_BD_ADDR, 0, NULL);

-       /* Read Class of Device */
-       hci_send_cmd(hdev, HCI_OP_READ_CLASS_OF_DEV, 0, NULL);
+               /* Read Class of Device */
+               hci_send_cmd(hdev, HCI_OP_READ_CLASS_OF_DEV, 0, NULL);

-       /* Read Local Name */
-       hci_send_cmd(hdev, HCI_OP_READ_LOCAL_NAME, 0, NULL);
+               /* Read Local Name */
+               hci_send_cmd(hdev, HCI_OP_READ_LOCAL_NAME, 0, NULL);

-       /* Read Voice Setting */
-       hci_send_cmd(hdev, HCI_OP_READ_VOICE_SETTING, 0, NULL);
+               /* Read Voice Setting */
+               hci_send_cmd(hdev, HCI_OP_READ_VOICE_SETTING, 0, NULL);
+       }

        /* Optional initialization */

@@ -493,8 +511,10 @@ int hci_dev_open(__u16 dev)
                set_bit(HCI_RAW, &hdev->flags);

        /* Treat all non BR/EDR controllers as raw devices for now */
+       /*
        if (hdev->dev_type != HCI_BREDR)
                set_bit(HCI_RAW, &hdev->flags);
+       */

        if (hdev->open(hdev)) {
                ret = -EIO;
@@ -505,7 +525,6 @@ int hci_dev_open(__u16 dev)
                atomic_set(&hdev->cmd_cnt, 1);
                set_bit(HCI_INIT, &hdev->flags);

-               //__hci_request(hdev, hci_reset_req, 0, HZ);
                ret = __hci_request(hdev, hci_init_req, 0,
                                        msecs_to_jiffies(HCI_INIT_TIMEOUT));

@@ -875,8 +894,8 @@ int hci_register_dev(struct hci_dev *hdev)
        struct list_head *head = &hci_dev_list, *p;
        int i, id = 0;

-       BT_DBG("%p name %s bus %d owner %p", hdev, hdev->name,
-                                               hdev->bus, hdev->owner);
+       BT_DBG("%p name %s bus %d owner %p dev_type %d", hdev, hdev->name,
+                                               hdev->bus, hdev->owner, hdev->dev_type);

        if (!hdev->open || !hdev->close || !hdev->destruct)
                return -EINVAL;
@@ -906,7 +925,7 @@ int hci_register_dev(struct hci_dev *hdev)
        hdev->sniff_max_interval = 800;
        hdev->sniff_min_interval = 80;

-       tasklet_init(&hdev->cmd_task, hci_cmd_task,(unsigned long) hdev);
+       tasklet_init(&hdev->cmd_task, hci_cmd_task, (unsigned long) hdev);
        tasklet_init(&hdev->rx_task, hci_rx_task, (unsigned long) hdev);
        tasklet_init(&hdev->tx_task, hci_tx_task, (unsigned long) hdev);

@@ -925,6 +944,7 @@ int hci_register_dev(struct hci_dev *hdev)
        hci_conn_hash_init(hdev);

        INIT_LIST_HEAD(&hdev->blacklist.list);
+       INIT_LIST_HEAD(&hdev->phy_links);

        memset(&hdev->stat, 0, sizeof(struct hci_dev_stats));

@@ -1277,7 +1297,7 @@ static void hci_add_acl_hdr(struct sk_buff *skb, __u16 handle, __u16 flags)
        hdr->dlen   = cpu_to_le16(len);
 }

-void hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags)
+int hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags)
 {
        struct hci_dev *hdev = conn->hdev;
        struct sk_buff *list;
@@ -1286,7 +1306,12 @@ void hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags)

        skb->dev = (void *) hdev;
        bt_cb(skb)->pkt_type = HCI_ACLDATA_PKT;
-       hci_add_acl_hdr(skb, conn->handle, flags | ACL_START);
+
+       if (hdev->dev_type == HCI_80211) {
+               BT_DBG("conn->handle:0x%x  pkt_len:%d", conn->handle, skb->len);
+               hci_add_acl_hdr(skb, conn->handle, flags | ACL_COMPLETE);
+       } else
+               hci_add_acl_hdr(skb, conn->handle, flags | ACL_START);

        if (!(list = skb_shinfo(skb)->frag_list)) {
                /* Non fragmented */
@@ -1308,7 +1333,10 @@ void hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags)

                        skb->dev = (void *) hdev;
                        bt_cb(skb)->pkt_type = HCI_ACLDATA_PKT;
-                       hci_add_acl_hdr(skb, conn->handle, flags | ACL_CONT);
+                       if (hdev->dev_type == HCI_80211)
+                               hci_add_acl_hdr(skb, conn->handle, flags | ACL_COMPLETE);
+                       else
+                               hci_add_acl_hdr(skb, conn->handle, flags | ACL_CONT);

                        BT_DBG("%s frag %p len %d", hdev->name, skb, skb->len);

@@ -1319,17 +1347,24 @@ void hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags)
        }

        tasklet_schedule(&hdev->tx_task);
+
+       return 0;
 }
 EXPORT_SYMBOL(hci_send_acl);

 /* Send SCO data */
-void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb)
+int hci_send_sco(struct hci_conn *conn, struct sk_buff *skb)
 {
        struct hci_dev *hdev = conn->hdev;
        struct hci_sco_hdr hdr;

        BT_DBG("%s len %d", hdev->name, skb->len);

+       if (skb->len > hdev->sco_mtu) {
+               kfree_skb(skb);
+               return -EINVAL;
+       }
+
        hdr.handle = cpu_to_le16(conn->handle);
        hdr.dlen   = skb->len;

@@ -1342,6 +1377,8 @@ void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb)

        skb_queue_tail(&conn->data_q, skb);
        tasklet_schedule(&hdev->tx_task);
+
+       return 0;
 }
 EXPORT_SYMBOL(hci_send_sco);

@@ -1435,6 +1472,77 @@ static inline void hci_sched_acl(struct hci_dev *hdev)
        }
 }

+static inline struct hci_conn *hci_amp_low_sent(struct hci_dev *hdev, __u8 type, int *quote)
+{
+
+       struct hci_conn *conn = NULL;
+       struct list_head *p;
+       struct list_head *p2;
+       struct hci_phy_link *plink;
+       int num = 0, min = ~0;
+
+       list_for_each(p, &hdev->phy_links) {
+               plink = list_entry(p, struct hci_phy_link, list);
+               list_for_each(p2, &plink->log_links) {
+                       struct hci_conn *c;
+                       c = list_entry(p2, struct hci_conn, list);
+
+                       if (c->type != type || skb_queue_empty(&c->data_q))
+                               continue;
+
+                       if (c->state != BT_CONNECTED && c->state != BT_CONFIG)
+                               continue;
+
+                       num++;
+
+                       if (c->sent < min) {
+                               min = c->sent;
+                               conn = c;
+                       }
+               }
+       }
+
+       if (conn) {
+               int cnt = (type == ACL_LINK ? hdev->acl_cnt : hdev->sco_cnt);
+               int q = cnt / num;
+               *quote = q ? q : 1;
+       } else
+               *quote = 0;
+
+       BT_DBG("conn %p quote %d", conn, *quote);
+       return conn;
+}
+
+
+static inline void hci_amp_sched_acl(struct hci_dev *hdev)
+{
+       struct hci_conn *conn;
+       struct sk_buff *skb;
+       int quote;
+
+       BT_DBG("%s", hdev->name);
+
+       if (!test_bit(HCI_RAW, &hdev->flags)) {
+               /* ACL tx timeout must be longer than maximum
+                * link supervision timeout (40.9 seconds) */
+               if (!hdev->acl_cnt && time_after(jiffies, hdev->acl_last_tx + HZ * 45)) {
+                       BT_ERR("%s acl tx timeout", hdev->name);
+                       /*TODO: disconnect logical link connection here. */
+                       /* hci_acl_tx_to(hdev); */
+               }
+       }
+
+       while (hdev->acl_cnt && (conn = hci_amp_low_sent(hdev, ACL_LINK, &quote))) {
+               while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
+                       hci_send_frame(skb);
+                       hdev->acl_last_tx = jiffies;
+
+                       hdev->acl_cnt--;
+                       conn->sent++;
+               }
+       }
+}
+
 /* Schedule SCO */
 static inline void hci_sched_sco(struct hci_dev *hdev)
 {
@@ -1487,12 +1595,15 @@ static void hci_tx_task(unsigned long arg)

        /* Schedule queues and send stuff to HCI driver */

-       hci_sched_acl(hdev);
-
-       hci_sched_sco(hdev);
+       if (hdev->dev_type == HCI_80211) {
+               hci_amp_sched_acl(hdev);
+       } else {
+               hci_sched_acl(hdev);

-       hci_sched_esco(hdev);
+               hci_sched_sco(hdev);

+               hci_sched_esco(hdev);
+       }
        /* Send next queued raw (unknown type) packet */
        while ((skb = skb_dequeue(&hdev->raw_q)))
                hci_send_frame(skb);
@@ -1614,12 +1725,19 @@ static void hci_rx_task(unsigned long arg)

                case HCI_ACLDATA_PKT:
                        BT_DBG("%s ACL data packet", hdev->name);
-                       hci_acldata_packet(hdev, skb);
+                       if (hdev->dev_type == HCI_80211)
+                               hci_amp_acldata_packet(hdev, skb);
+                       else
+                               hci_acldata_packet(hdev, skb);
+
                        break;

                case HCI_SCODATA_PKT:
                        BT_DBG("%s SCO data packet", hdev->name);
-                       hci_scodata_packet(hdev, skb);
+                       if (hdev->dev_type == HCI_80211)
+                               kfree_skb(skb);
+                       else
+                               hci_scodata_packet(hdev, skb);
                        break;

                default:
@@ -1639,6 +1757,10 @@ static void hci_cmd_task(unsigned long arg)
        BT_DBG("%s cmd %d", hdev->name, atomic_read(&hdev->cmd_cnt));

        if (!atomic_read(&hdev->cmd_cnt) && time_after(jiffies, hdev->cmd_last_tx + HZ)) {
+               if (hdev->sent_cmd) {
+                       struct hci_command_hdr *hdr = (void *) hdev->sent_cmd;
+                       BT_ERR("cmd opcode: 0x%04x", hdr->opcode);
+               }
                BT_ERR("%s command tx timeout", hdev->name);
                atomic_set(&hdev->cmd_cnt, 1);
        }
@@ -1657,3 +1779,186 @@ static void hci_cmd_task(unsigned long arg)
                }
        }
 }
+
+static struct hci_phy_link *hci_phylink_add(struct hci_dev *hdev, __u8 phy_handle, __u8 amp_role,
+                                                        __u8 *rem_assoc, __u16 assoc_size)
+{
+       struct hci_phy_link *plink;
+
+       BT_DBG("%s handle:%d", hdev->name, phy_handle);
+
+       plink = kzalloc(sizeof(struct hci_phy_link), GFP_ATOMIC);
+       if (!plink)
+               return NULL;
+
+       plink->handle = phy_handle;
+       plink->hdev = hdev;
+       plink->remote_assoc.offset = 0;
+       plink->amp_role = amp_role;
+       if (assoc_size > HCI_MAX_AMP_ASSOC_SIZE)
+               plink->remote_assoc.len = HCI_MAX_AMP_ASSOC_SIZE;
+       else
+               plink->remote_assoc.len = assoc_size;
+
+       BT_DBG("plink->remote_assoc.len:%d", plink->remote_assoc.len);
+       memcpy(plink->remote_assoc.data, rem_assoc, plink->remote_assoc.len);
+       INIT_LIST_HEAD(&plink->log_links);
+
+       plink->state = BT_OPEN;
+
+       list_add(&plink->list, &hdev->phy_links);
+
+       return plink;
+
+}
+
+int hci_phylink_del(struct hci_phy_link *plink)
+{
+       BT_DBG("del phylink:%p", plink);
+       list_del(&plink->list);
+       kfree(plink);
+       return 0;
+}
+
+static inline void hci_amp_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
+{
+       struct hci_acl_hdr *hdr = (void *) skb->data;
+       struct hci_phy_link *plink;
+       __u16 handle, flags;
+
+       skb_pull(skb, HCI_ACL_HDR_SIZE);
+
+       handle = __le16_to_cpu(hdr->handle);
+       flags  = hci_flags(handle);
+       handle = hci_handle(handle);
+
+       BT_DBG("%s len %d handle 0x%x flags 0x%x", hdev->name, skb->len, handle, flags);
+
+       hdev->stat.acl_rx++;
+
+       hci_dev_lock(hdev);
+       plink = hci_phylink_lookup_handle(hdev, handle);
+       hci_dev_unlock(hdev);
+
+       if (plink && plink->priv_data) {
+               register struct hci_proto *hp;
+
+               /* Send to upper protocol */
+               hp = hci_proto[HCI_PROTO_L2CAP];
+               if (hp && hp->recv_acldata
+                       && plink->acl_link_state == BT_CONNECTED) {
+                       hp->recv_acldata(plink->priv_data, skb, flags);
+                       return;
+               }
+       } else {
+               BT_ERR("%s ACL packet for unknown connection handle %d",
+                       hdev->name, handle);
+       }
+
+       kfree_skb(skb);
+}
+
+/* ------ AMP HCI interface for upper layer ----- */
+struct hci_phy_link *hci_phylink_create(struct hci_dev *hdev, __u8 phy_handle,
+                               struct amp_link_key *key, __u8 *rem_assoc, __u16 assoc_size, void* priv_data)
+{
+       struct hci_phy_link *plink;
+
+       BT_DBG("%s handle:%d, key_len:%d assoc_size:%d", hdev->name, phy_handle, key->key_len, assoc_size);
+
+       if (!test_bit(HCI_UP, &hdev->flags))
+               return NULL;
+
+       hci_dev_lock(hdev);
+       plink = hci_phylink_lookup_handle(hdev, phy_handle);
+       if (!plink) {
+               plink = hci_phylink_add(hdev, phy_handle, HCI_AMP_ROLE_INITIATOR, rem_assoc, assoc_size);
+               if (!plink) {
+                       hci_dev_unlock(hdev);
+                       return NULL;
+               }
+       }
+       plink->priv_data = priv_data;
+       hci_dev_unlock(hdev);
+
+       if (plink->state == BT_OPEN || plink->state == BT_CLOSED) {
+               struct hci_cp_create_physical_link cp;
+
+               plink->state = BT_CONNECT;
+               cp.handle = phy_handle;
+               cp.key_type = key->key_type;
+
+               cp.key_len = key->key_len > HCI_MAX_AMP_KEY_SIZE ? \
+                            HCI_MAX_AMP_KEY_SIZE : key->key_len;
+
+               BT_DBG("cp.key_len %d, cp.handle %d", cp.key_len, cp.handle);
+               memcpy(cp.key, key->key, cp.key_len);
+               hci_send_cmd(hdev, HCI_OP_CREATE_PHYSICAL_LINK, sizeof(cp), &cp);
+       }
+       BT_DBG("end");
+       return plink;
+
+}
+EXPORT_SYMBOL(hci_phylink_create);
+
+struct hci_phy_link *hci_phylink_accept(struct hci_dev *hdev, __u8 phy_handle,
+                                       struct amp_link_key *key, __u8 *rem_assoc, __u16 assoc_size, void* priv_data)
+{
+       struct hci_phy_link *plink;
+
+       BT_DBG("%s handle:%d, key_len:%d assoc_size:%d", hdev->name, phy_handle, key->key_len, assoc_size);
+
+       hci_dev_lock(hdev);
+       plink = hci_phylink_lookup_handle(hdev, phy_handle);
+       if (!plink) {
+               plink = hci_phylink_add(hdev, phy_handle, HCI_AMP_ROLE_RESPONDER, rem_assoc, assoc_size);
+               if (!plink) {
+                       hci_dev_unlock(hdev);
+                       return NULL;
+               }
+       }
+       plink->priv_data = priv_data;
+       hci_dev_unlock(hdev);
+
+       if (plink->state == BT_OPEN || plink->state == BT_CLOSED) {
+               struct hci_cp_accept_physical_link cp;
+
+               plink->state = BT_CONNECT;
+               cp.handle = phy_handle;
+               cp.key_type = key->key_type;
+               cp.key_len = key->key_len > HCI_MAX_AMP_KEY_SIZE ? HCI_MAX_AMP_KEY_SIZE : key->key_len;
+               BT_DBG("cp.key_len %d, cp.handle %d", cp.key_len, cp.handle);
+               memcpy(cp.key, key->key, cp.key_len);
+               hci_send_cmd(hdev, HCI_OP_ACCEPT_PHYSICAL_LINK, sizeof(cp), &cp);
+       }
+       BT_DBG("end");
+       return plink;
+}
+
+EXPORT_SYMBOL(hci_phylink_accept);
+
+void hci_phylink_put(struct hci_phy_link *phy_link, __u8 reason)
+{
+       struct hci_cp_disconn_physical_link cp;
+
+       BT_DBG("put physical link:%p", phy_link);
+
+       phy_link->state = BT_DISCONN;
+
+       cp.handle = phy_link->handle;
+       cp.reason = reason;
+       hci_send_cmd(phy_link->hdev, HCI_OP_DISCONN_PHYSICAL_LINK, sizeof(cp), &cp);
+
+}
+EXPORT_SYMBOL(hci_phylink_put);
+
+void hci_read_local_amp_info(struct hci_dev *hdev)
+{
+       BT_DBG("%s", hdev->name);
+
+       hci_send_cmd(hdev, HCI_OP_READ_LOCAL_AMP_INFO, 0, NULL);
+}
+EXPORT_SYMBOL(hci_read_local_amp_info);
+
+
+
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a969800..080f979 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -182,7 +182,17 @@ static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
        __u8 status = *((__u8 *) skb->data);

        BT_DBG("%s status 0x%x", hdev->name, status);
-
+/*
+       if (hdev->dev_type = HCI_80211) {
+               if (test_and_clear_bit(HCI_INIT, &hdev->flags)) {
+                       if (!status) {
+                               hci_dev_hold(hdev);
+                               set_bit(HCI_UP, &hdev->flags);
+                               hci_notify(hdev, HCI_DEV_UP);
+                       }
+               }
+       }
+*/
        hci_req_complete(hdev, status);
 }

@@ -814,6 +824,550 @@ static void hci_cs_exit_sniff_mode(struct hci_dev *hdev, __u8 status)
        hci_dev_unlock(hdev);
 }

+static void hci_cc_link_key_reply(struct hci_dev *hdev, struct sk_buff *skb)
+{
+       struct hci_rp_link_key_reply *rp = (void *) skb->data;
+
+       BT_DBG("%s status 0x%x", hdev->name, rp->status);
+
+       if (!rp->status) {
+               struct hci_conn *conn;
+               struct hci_cp_link_key_reply *cp = hci_sent_cmd_data(hdev, HCI_OP_LINK_KEY_REPLY);
+
+               if (!cp)
+                       return;
+
+               hci_dev_lock(hdev);
+
+               conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->bdaddr);
+               if (conn) {
+                       hci_conn_hold(conn);
+                       memcpy(conn->link_key, cp->link_key, 16);
+                       conn->key_type =  0x04;
+
+                       hci_conn_put(conn);
+               }
+               hci_dev_unlock(hdev);
+       }
+}
+
+static void hci_write_rmt_assoc(struct hci_dev *hdev, struct hci_phy_link *plink)
+{
+       __u16 len;
+       __u16 remain;
+       struct hci_cp_write_remote_amp_assoc cp;
+       struct amp_assoc *rmt_assoc = &plink->remote_assoc;
+
+       remain = rmt_assoc->len - rmt_assoc->offset;
+       len = min_t(__u16, remain, HCI_MAX_AMP_ASSOC_FRAGMENT);
+
+       cp.handle = plink->handle;
+       cp.amp_assoc_remaining_len = cpu_to_le16(remain);
+       cp.len_so_far = cpu_to_le16(rmt_assoc->offset);
+       memcpy(cp.amp_assoc_fragment, rmt_assoc->data + rmt_assoc->offset, len);
+       rmt_assoc->offset += len;
+       hci_send_cmd(hdev, HCI_OP_WRITE_REMOTE_AMP_ASSOC, sizeof(cp) - HCI_MAX_AMP_ASSOC_FRAGMENT + len, &cp);
+}
+
+static void hci_cc_read_data_block_size(struct hci_dev *hdev, struct sk_buff *skb)
+{
+       struct hci_rp_read_data_block_size *rp = (void *)skb->data;
+       u16 num_blks;
+       u16 blk_size;
+       u16 max_pkt_len;
+
+       BT_DBG("%s status:0x%x", hdev->name, rp->status);
+       if (rp->status)
+               return;
+
+       hci_dev_lock(hdev);
+       num_blks = __le16_to_cpu(rp->num_blks);
+       blk_size = __le16_to_cpu(rp->max_blk_len);
+       max_pkt_len = __le16_to_cpu(rp->max_pkt_len);
+
+       hdev->acl_mtu = max_pkt_len;
+       hdev->acl_pkts = (num_blks * blk_size) / max_pkt_len;
+       hdev->acl_cnt = hdev->acl_pkts;
+       BT_ERR("%s acl mtu %d:%d", hdev->name, hdev->acl_mtu, hdev->acl_pkts);
+       BT_ERR("num_blks %d blk_size %d max_pkt_len %d", num_blks, blk_size, max_pkt_len);
+
+       hci_dev_unlock(hdev);
+
+}
+
+static void hci_cc_read_flow_control_mode(struct hci_dev *hdev, struct sk_buff *skb)
+{
+       struct hci_rp_read_flow_control_mode *rp = (void *)skb->data;
+
+       BT_DBG("%s status:0x%x", hdev->name, rp->status);
+}
+
+static void hci_cc_write_remote_amp_assoc(struct hci_dev *hdev, struct sk_buff *skb)
+{
+       struct hci_rp_write_remote_amp_assoc *rp = (void *)skb->data;
+       struct hci_phy_link *plink;
+
+       BT_DBG("%s status 0x%x", hdev->name, rp->status);
+
+       if (rp->status)
+               return;
+
+       hci_dev_lock(hdev);
+
+       plink = hci_phylink_lookup_handle(hdev, rp->handle);
+       if (plink) {
+               if (plink->remote_assoc.offset < plink->remote_assoc.len)
+                       hci_write_rmt_assoc(hdev, plink);
+               else if (plink->amp_role == HCI_AMP_ROLE_RESPONDER)
+                       hci_create_physical_link_cfm(hdev, rp->handle, HCI_CREATE_PHYLINK_PEND);
+       }
+       hci_dev_unlock(hdev);
+
+}
+
+static void hci_read_loc_assoc(struct hci_dev *hdev, __u8 phy_handle)
+{
+       struct hci_cp_read_local_amp_assoc cp;
+       struct amp_assoc *loc_assoc = &hdev->local_assoc;
+
+       cp.handle = phy_handle;
+       /*TODO: shall set this parameter to the "AMP_ASSOC_Size"
+       value returned from the remote device in the AMP Get Info Response, use A2MP MTU here right now. */
+       cp.max_remote_amp_assoc_len = cpu_to_le16(670);
+       cp.len_so_far = cpu_to_le16(loc_assoc->offset);
+       hci_send_cmd(hdev, HCI_OP_READ_LOCAL_AMP_ASSOC, sizeof(cp), &cp);
+}
+
+static void hci_cc_read_local_amp_assoc(struct hci_dev *hdev, struct sk_buff *skb)
+{
+       struct hci_rp_read_local_amp_assoc *rp = (void *)skb->data;
+       struct amp_assoc *loc_assoc = &hdev->local_assoc;
+       __u16 remain;
+       BT_DBG("%s status 0x%x", hdev->name, rp->status);
+
+       hci_dev_lock(hdev);
+
+       if (!rp->status) {
+               remain = __le16_to_cpu(rp->amp_assoc_remaining_len);
+               if (remain > HCI_MAX_AMP_ASSOC_FRAGMENT) {
+                       memcpy(loc_assoc->data + loc_assoc->offset, rp->amp_assoc_fragment, HCI_MAX_AMP_ASSOC_FRAGMENT);
+                       loc_assoc->offset += HCI_MAX_AMP_ASSOC_FRAGMENT;
+                       hci_read_loc_assoc(hdev, rp->handle);
+               } else {
+                       memcpy(loc_assoc->data + loc_assoc->offset, rp->amp_assoc_fragment, remain);
+                       loc_assoc->len = loc_assoc->offset + remain;
+                       loc_assoc->offset = 0;
+                       if (rp->handle == 0)
+                               hci_local_assoc_ind(hdev, rp->status);
+                       else
+                               hci_create_physical_link_cfm(hdev, rp->handle, HCI_CREATE_PHYLINK_PEND);
+               }
+       }
+
+       hci_dev_unlock(hdev);
+}
+
+static void hci_cc_read_local_amp_info(struct hci_dev *hdev, struct sk_buff *skb)
+{
+       struct hci_rp_read_local_amp_info *rp = (void *)skb->data;
+
+       BT_DBG("%s status:%d", hdev->name, rp->status);
+
+       hci_dev_lock(hdev);
+
+       if (!rp->status) {
+               hdev->ctrl_info.amp_status = rp->amp_status;
+               hdev->ctrl_info.total_bandwidth = __le32_to_cpu(rp->total_bandwidth);
+               hdev->ctrl_info.max_guaranteed_bandwidth = __le32_to_cpu(rp->max_guaranteed_bandwidth);
+               hdev->ctrl_info.min_latency = __le32_to_cpu(rp->min_latency);
+               hdev->ctrl_info.max_pdu_size = __le32_to_cpu(rp->max_pdu_size);
+               hdev->ctrl_info.ctrl_type = rp->controller_type;
+               hdev->ctrl_info.pal_caps = __le16_to_cpu(rp->pal_caps);
+               hdev->ctrl_info.max_assoc_len = __le16_to_cpu(rp->max_amp_assoc_len);
+               hdev->ctrl_info.max_flush_to = __le32_to_cpu(rp->max_flush_timeout);
+               hdev->ctrl_info.best_effort_flush_to = __le32_to_cpu(rp->best_effort_flush_timeout);
+       }
+       hci_local_info_ind(hdev, rp->status);
+
+       hci_dev_unlock(hdev);
+
+}
+
+void hci_read_local_amp_assoc(struct hci_dev *hdev)
+{
+       if (!test_bit(HCI_UP, &hdev->flags))
+               return;
+
+       hdev->local_assoc.len = 0;
+       hdev->local_assoc.offset = 0;
+       hci_read_loc_assoc(hdev, 0x00);
+}
+EXPORT_SYMBOL(hci_read_local_amp_assoc);
+
+static void hci_phylink_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+       struct hci_ev_physical_link_complete *ev = (void *)skb->data;
+
+       BT_DBG("%s status:%d handle:%d", hdev->name, ev->status, ev->handle);
+
+       hci_dev_lock(hdev);
+
+
+       if (!ev->status) {
+               struct hci_phy_link *plink = hci_phylink_lookup_handle(hdev, ev->handle);
+               if (plink)
+                       plink->state = BT_CONNECTED;
+       }
+
+       hci_create_physical_link_cfm(hdev, ev->handle, ev->status);
+
+       hci_dev_unlock(hdev);
+}
+
+static void hci_disconn_phylink_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+       struct hci_ev_disconn_physical_link_complete *ev = (void *)skb->data;
+       struct hci_phy_link *plink;
+
+       BT_DBG("%s status %d", hdev->name, ev->status);
+
+       hci_dev_lock(hdev);
+
+       plink = hci_phylink_lookup_handle(hdev, ev->handle);
+       if (plink) {
+               plink->state = BT_CLOSED;
+               hci_put_physical_link_cfm(hdev, ev->handle, ev->status, ev->reason);
+               hci_phylink_del(plink);
+       }
+       hci_dev_unlock(hdev);
+}
+
+static void hci_cs_create_phylink(struct hci_dev *hdev, __u8 status)
+{
+       struct hci_cp_create_physical_link *cp;
+       struct hci_phy_link *plink;
+
+       BT_DBG("%s status 0x%x", hdev->name, status);
+
+       cp = hci_sent_cmd_data(hdev, HCI_OP_CREATE_PHYSICAL_LINK);
+       if (!cp)
+               return;
+
+       hci_dev_lock(hdev);
+
+       plink = hci_phylink_lookup_handle(hdev, cp->handle);
+       if (plink) {
+               if (!status) {
+                       plink->remote_assoc.offset = 0;
+                       hci_write_rmt_assoc(hdev, plink);
+               } else {
+                       hci_create_physical_link_cfm(hdev, plink->handle, status);
+                       hci_phylink_del(plink);
+               }
+       }
+
+       hci_dev_unlock(hdev);
+}
+
+static void hci_cs_accept_phylink(struct hci_dev *hdev, __u8 status)
+{
+       struct hci_cp_accept_physical_link *cp;
+       struct hci_phy_link *plink;
+
+       BT_DBG("%s status 0x%x", hdev->name, status);
+
+       cp = hci_sent_cmd_data(hdev, HCI_OP_ACCEPT_PHYSICAL_LINK);
+       if (!cp)
+               return;
+
+       hci_dev_lock(hdev);
+
+       plink = hci_phylink_lookup_handle(hdev, cp->handle);
+
+       if (status) {
+               hci_create_physical_link_cfm(hdev, cp->handle, status);
+               if (plink)
+                       hci_phylink_del(plink);
+       } else {
+               if (plink) {
+                       plink->remote_assoc.offset = 0;
+                       hci_write_rmt_assoc(hdev, plink);
+               }
+       }
+
+       hci_dev_unlock(hdev);
+}
+
+static void hci_cs_disconn_phylink(struct hci_dev *hdev, __u8 status)
+{
+       struct hci_cp_disconn_physical_link *cp;
+
+       BT_DBG("%s status %d", hdev->name, status);
+
+       cp = hci_sent_cmd_data(hdev, HCI_OP_DISCONN_PHYSICAL_LINK);
+       if (!cp)
+               return;
+
+       hci_dev_lock(hdev);
+
+       if (status) {
+               struct hci_phy_link *plink;
+
+               hci_put_physical_link_cfm(hdev, cp->handle, status, cp->reason);
+               plink = hci_phylink_lookup_handle(hdev, cp->handle);
+               if (plink)
+                       hci_phylink_del(plink);
+       }
+
+       hci_dev_unlock(hdev);
+}
+
+static void hci_loglink_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+       struct hci_ev_logical_link_complete *ev = (void *)skb->data;
+       struct hci_phy_link *plink;
+       struct hci_conn *conn;
+
+       BT_DBG("%s status:%d", hdev->name, ev->status);
+       hci_dev_lock(hdev);
+
+       plink = hci_phylink_lookup_handle(hdev, ev->physical_link_handle);
+       if (plink) {
+               conn = hci_loglink_lookup_tx_flow_spec_id(plink, ev->tx_flow_spec_id);
+               if (conn) {
+                       if (!ev->status) {
+                               conn->state = BT_CONNECTED;
+                               conn->handle = ev->logical_link_handle;
+                       }
+                       if (conn->amp_role == HCI_AMP_ROLE_INITIATOR)
+                               hci_proto_loglink_create_cfm(conn, ev->status);
+                       else
+                               hci_proto_loglink_accept_cfm(conn, ev->status);
+               }
+       }
+       hci_dev_unlock(hdev);
+}
+
+static void hci_cs_create_loglink(struct hci_dev *hdev, __u8 status)
+{
+       struct hci_cp_create_logical_link *cp;
+
+       BT_DBG("%s status %d", hdev->name, status);
+
+       cp = hci_sent_cmd_data(hdev, HCI_OP_CREATE_LOGICAL_LINK);
+       if (!cp)
+               return;
+
+       hci_dev_lock(hdev);
+
+       if (status) {
+               struct hci_phy_link *plink;
+               struct hci_conn *conn;
+               plink = hci_phylink_lookup_handle(hdev, cp->handle);
+               if (plink) {
+                       conn = hci_loglink_lookup_tx_flow_spec_id(plink, cp->tx_flow_spec.id);
+                       if (conn) {
+                               hci_proto_loglink_create_cfm(conn, status);
+                               hci_loglink_del(conn);
+                       }
+               }
+       }
+
+       hci_dev_unlock(hdev);
+
+}
+
+static void hci_cs_accept_loglink(struct hci_dev *hdev, __u8 status)
+{
+       struct hci_cp_accept_logical_link *cp;
+
+       BT_DBG("%s status %d", hdev->name, status);
+
+       cp = hci_sent_cmd_data(hdev, HCI_OP_ACCEPT_LOGICAL_LINK);
+       if (!cp)
+               return;
+
+       hci_dev_lock(hdev);
+
+       if (status) {
+               struct hci_phy_link *plink;
+               struct hci_conn *conn;
+               plink = hci_phylink_lookup_handle(hdev, cp->handle);
+               if (plink) {
+                       conn = hci_loglink_lookup_tx_flow_spec_id(plink, cp->tx_flow_spec.id);
+                       if (conn) {
+                               hci_proto_loglink_create_cfm(conn, status);
+                               hci_loglink_del(conn);
+                       }
+               }
+       }
+
+       hci_dev_unlock(hdev);
+
+}
+
+static void hci_cs_disconn_loglink(struct hci_dev *hdev, __u8 status)
+{
+       struct hci_cp_disconn_logical_link *cp;
+
+       BT_DBG("%s status %d", hdev->name, status);
+
+       cp = hci_sent_cmd_data(hdev, HCI_OP_DISCONN_LOGICAL_LINK);
+       if (!cp)
+               return;
+
+       hci_dev_lock(hdev);
+       if (status) {
+               struct hci_conn *conn;
+               __u16 handle = __le16_to_cpu(cp->handle);
+               conn = hci_loglink_lookup_handle(hdev, handle);
+               if (conn) {
+                       if (conn->phylink->acl_link_state == BT_CONNECTED)
+                               hci_proto_loglink_put_cfm(conn, status);
+
+                       hci_loglink_del(conn);
+               }
+       }
+       hci_dev_unlock(hdev);
+}
+
+static void hci_loglink_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+       struct hci_ev_disconn_logical_link_complete *ev = (void *)skb->data;
+       struct hci_conn *conn;
+       __u16 handle;
+
+       BT_DBG("%s status %d", hdev->name, ev->status);
+
+       hci_dev_lock(hdev);
+
+       handle = __le16_to_cpu(ev->handle);
+       conn = hci_loglink_lookup_handle(hdev, handle);
+       if (conn) {
+               if (!ev->status)
+                       conn->state = BT_CLOSED;
+
+               if (conn->phylink->acl_link_state == BT_CONNECTED)
+                       hci_proto_loglink_put_cfm(conn, ev->status);
+
+               hci_loglink_del(conn);
+       }
+
+       hci_dev_unlock(hdev);
+
+}
+
+static void hci_cc_cancel_loglink(struct hci_dev *hdev, struct sk_buff *skb)
+{
+       struct hci_rp_logical_link_cancel *rp = (void *)skb->data;
+       struct hci_phy_link *plink;
+       struct hci_conn *conn;
+
+       BT_DBG("%s status %d", hdev->name,  rp->status);
+
+       hci_dev_lock(hdev);
+
+       plink = hci_phylink_lookup_handle(hdev, rp->handle);
+       if (plink) {
+               conn = hci_loglink_lookup_tx_flow_spec_id(plink, rp->tx_flow_spec_id);
+               if (conn) {
+                       if (!rp->status)
+                               conn->state = BT_CLOSED;
+
+                       if (conn->phylink->acl_link_state == BT_CONNECTED)
+                               hci_proto_loglink_put_cfm(conn, rp->status);
+
+                       hci_loglink_del(conn);
+               }
+       }
+
+       hci_dev_unlock(hdev);
+}
+
+static void hci_cs_flow_spec_modify(struct hci_dev *hdev, __u8 status)
+{
+       struct hci_cp_flow_spec_modify *cp;
+       struct hci_conn *conn;
+       __u16 handle;
+
+       BT_DBG("%s status %d", hdev->name, status);
+
+       cp = hci_sent_cmd_data(hdev, HCI_OP_FLOW_SPEC_MODIFY);
+       if (!cp)
+               return;
+
+       hci_dev_lock(hdev);
+
+       handle = __le16_to_cpu(cp->handle);
+       if (status) {
+               conn = hci_loglink_lookup_handle(hdev, handle);
+               if (conn) {
+                       hci_proto_loglink_modify_cfm(conn, status);
+               }
+       }
+
+       hci_dev_unlock(hdev);
+}
+
+static void hci_flow_spec_modify_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+       struct hci_ev_flow_spec_modify_complete *ev = (void *)skb->data;
+       struct hci_conn *conn;
+
+       conn = hci_loglink_lookup_handle(hdev, ev->handle);
+       if (conn)
+               hci_proto_loglink_modify_cfm(conn, ev->status);
+}
+
+static void hci_amp_status_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+       struct hci_ev_amp_status_change *ev = (void *)skb->data;
+       /* TODO: report amp status change event to amp mgr. */
+       (void) ev->status;
+       (void) ev->amp_status;
+       BT_ERR("%s status %d amp status %d", hdev->name, ev->status, ev->amp_status);
+}
+
+static void hci_num_comp_data_blocks_evt(struct hci_dev *hdev, struct sk_buff * skb)
+{
+       struct hci_ev_num_of_completed_data_blocks *ev = (void *)skb->data;
+       __le16 *ptr;
+       int i;
+
+       skb_pull(skb, sizeof(*ev));
+
+       BT_DBG("%s num_hnld %d", hdev->name, ev->num_handles);
+
+       if (skb->len < ev->num_handles * 6) {
+               BT_ERR("%s bad parameters", hdev->name);
+               return;
+       }
+
+       tasklet_disable(&hdev->tx_task);
+
+       for (i = 0, ptr = (__le16 *) skb->data; i < ev->num_handles; i++) {
+               struct hci_conn *conn;
+               __u16 handle, pkt_cnt, blk_cnt;
+
+               handle = get_unaligned_le16(ptr++);
+               pkt_cnt = get_unaligned_le16(ptr++);
+               blk_cnt = get_unaligned_le16(ptr++);
+               conn = hci_conn_hash_lookup_handle(hdev, handle);
+
+               BT_DBG("handle: 0x%x, conn:%p pkt_cnt:%d, blk_cnt:%d", handle,  conn, pkt_cnt, blk_cnt);
+               if (conn) {
+                       conn->sent -= pkt_cnt;
+                       hdev->acl_cnt += pkt_cnt;
+                       if (hdev->acl_cnt > hdev->acl_pkts)
+                               hdev->acl_cnt = hdev->acl_pkts;
+               }
+       }
+
+       tasklet_schedule(&hdev->tx_task);
+       tasklet_enable(&hdev->tx_task);
+
+}
+
 static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
        __u8 status = *((__u8 *) skb->data);
@@ -1190,6 +1744,32 @@ static inline void hci_remote_features_evt(struct hci_dev *hdev, struct sk_buff
        hci_dev_unlock(hdev);
 }

+
+static inline void hci_flush_occurred_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+       struct hci_ev_flush_occurred *ev = (void *) skb->data;
+       __u16 handle = __le16_to_cpu(ev->handle);
+
+       BT_DBG("%s handle 0x%x", hdev->name, handle);
+       BT_ERR("%s handle 0x%x", hdev->name, handle);
+
+       if (hdev->dev_type == HCI_80211) {
+               struct hci_conn *conn;
+
+               conn = hci_loglink_lookup_handle(hdev, handle);
+
+               if (!conn)
+                       return;
+
+               tasklet_disable(&hdev->tx_task);
+
+               hdev->acl_cnt = 0;
+
+               tasklet_schedule(&hdev->tx_task);
+               tasklet_enable(&hdev->tx_task);
+       }
+}
+
 static inline void hci_remote_version_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
        BT_DBG("%s", hdev->name);
@@ -1218,6 +1798,10 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
                hci_cc_exit_periodic_inq(hdev, skb);
                break;

+       case HCI_OP_LINK_KEY_REPLY:
+               hci_cc_link_key_reply(hdev, skb);
+               break;
+
        case HCI_OP_REMOTE_NAME_REQ_CANCEL:
                hci_cc_remote_name_req_cancel(hdev, skb);
                break;
@@ -1314,6 +1898,31 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
                hci_cc_read_bd_addr(hdev, skb);
                break;

+       case HCI_OP_READ_DATA_BLOCK_SIZE:
+               hci_cc_read_data_block_size(hdev, skb);
+               break;
+
+       case HCI_OP_READ_FLOW_CONTROL_MODE:
+               hci_cc_read_flow_control_mode(hdev, skb);
+               break;
+
+       case HCI_OP_WRITE_REMOTE_AMP_ASSOC:
+               hci_cc_write_remote_amp_assoc(hdev, skb);
+               break;
+
+       case HCI_OP_READ_LOCAL_AMP_INFO:
+               hci_cc_read_local_amp_info(hdev, skb);
+               break;
+
+       case HCI_OP_READ_LOCAL_AMP_ASSOC:
+               hci_cc_read_local_amp_assoc(hdev, skb);
+               break;
+
+       case HCI_OP_LOGICAL_LINK_CANCEL:
+               hci_cc_cancel_loglink(hdev, skb);
+               break;
+
+
        default:
                BT_DBG("%s opcode 0x%x", hdev->name, opcode);
                break;
@@ -1380,6 +1989,34 @@ static inline void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
                hci_cs_exit_sniff_mode(hdev, ev->status);
                break;

+       case HCI_OP_CREATE_PHYSICAL_LINK:
+               hci_cs_create_phylink(hdev, ev->status);
+               break;
+
+       case HCI_OP_ACCEPT_PHYSICAL_LINK:
+               hci_cs_accept_phylink(hdev, ev->status);
+               break;
+
+       case HCI_OP_DISCONN_PHYSICAL_LINK:
+               hci_cs_disconn_phylink(hdev, ev->status);
+               break;
+
+       case HCI_OP_CREATE_LOGICAL_LINK:
+               hci_cs_create_loglink(hdev, ev->status);
+               break;
+
+       case HCI_OP_ACCEPT_LOGICAL_LINK:
+               hci_cs_accept_loglink(hdev, ev->status);
+               break;
+
+       case HCI_OP_DISCONN_LOGICAL_LINK:
+               hci_cs_disconn_loglink(hdev, ev->status);
+               break;
+
+       case HCI_OP_FLOW_SPEC_MODIFY:
+               hci_cs_flow_spec_modify(hdev, ev->status);
+               break;
+
        default:
                BT_DBG("%s opcode 0x%x", hdev->name, opcode);
                break;
@@ -1522,7 +2159,11 @@ static inline void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff
        conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
        if (conn) {
                hci_conn_hold(conn);
+
                conn->disc_timeout = HCI_DISCONN_TIMEOUT;
+               memcpy(conn->link_key, ev->link_key, 16);
+               conn->key_type = ev->key_type;
+
                hci_conn_put(conn);
        }

@@ -1822,6 +2463,25 @@ static inline void hci_remote_host_features_evt(struct hci_dev *hdev, struct sk_
        hci_dev_unlock(hdev);
 }

+static inline void hci_channel_selected_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+       struct hci_ev_channel_selected *ev = (void *)skb->data;
+       struct hci_phy_link *plink;
+
+       BT_DBG("%s", hdev->name);
+
+       hci_dev_lock(hdev);
+       plink = hci_phylink_lookup_handle(hdev, ev->handle);
+       if (plink) {
+               hdev->local_assoc.len = 0;
+               hdev->local_assoc.offset = 0;
+
+               hci_read_loc_assoc(hdev, plink->handle);
+               plink->state = BT_CONNECT2;
+       }
+       hci_dev_unlock(hdev);
+}
+
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
        struct hci_event_hdr *hdr = (void *) skb->data;
@@ -1958,6 +2618,42 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
                hci_remote_host_features_evt(hdev, skb);
                break;

+       case HCI_EV_PHYSICAL_LINK_COMPLETE:
+               hci_phylink_complete_evt(hdev, skb);
+               break;
+
+       case HCI_EV_DISCONN_PHYSICAL_LINK_COMPLETE:
+               hci_disconn_phylink_complete_evt(hdev, skb);
+               break;
+
+       case HCI_EV_LOGICAL_LINK_COMPLETE:
+               hci_loglink_complete_evt(hdev, skb);
+               break;
+
+       case HCI_EV_DISCONN_LOGICAL_LINK_COMPLETE:
+               hci_loglink_disconn_complete_evt(hdev, skb);
+               break;
+
+       case HCI_EV_FLOW_SPEC_MODIFY_COMPLETE:
+               hci_flow_spec_modify_complete_evt(hdev, skb);
+               break;
+
+       case HCI_EV_AMP_STATUS_CHANGE:
+               hci_amp_status_change_evt(hdev, skb);
+               break;
+
+       case HCI_EV_NUM_OF_COMPLETED_DATA_BLOCKS:
+               hci_num_comp_data_blocks_evt(hdev, skb);
+               break;
+
+       case HCI_EV_CHANNEL_SELECTED:
+               hci_channel_selected_evt(hdev, skb);
+               break;
+
+       case HCI_EV_FLUSH_OCCURRED:
+               hci_flush_occurred_evt(hdev, skb);
+               break;
+
        default:
                BT_DBG("%s event 0x%x", hdev->name, event);
                break;
--
1.6.3.3

