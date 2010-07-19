Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH] Bluetooth: Use __packed annotation
Date: Mon, 19 Jul 2010 02:00:13 -0300
Message-Id: <1279515613-710-1-git-send-email-gustavo@padovan.org>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

To make net/ and include/net/ code consistent use __packed instead of
__attribute__ ((packed)). Bluetooth subsystem was one of the last net
subsys still using __attribute__ ((packed)).

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/bluetooth.h |    2 +-
 include/net/bluetooth/hci.h       |  184 ++++++++++++++++++------------------
 include/net/bluetooth/l2cap.h     |   26 +++---
 include/net/bluetooth/rfcomm.h    |   14 ++--
 4 files changed, 113 insertions(+), 113 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index d6b150c..27a902d 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -84,7 +84,7 @@ enum {
 /* BD Address */
 typedef struct {
 	__u8 b[6];
-} __attribute__((packed)) bdaddr_t;
+} __packed bdaddr_t;
 
 #define BDADDR_ANY   (&(bdaddr_t) {{0, 0, 0, 0, 0, 0}})
 #define BDADDR_LOCAL (&(bdaddr_t) {{0, 0, 0, 0xff, 0xff, 0xff}})
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index ca2518e..bcbdd6d 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -230,7 +230,7 @@ struct hci_cp_inquiry {
 	__u8     lap[3];
 	__u8     length;
 	__u8     num_rsp;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_INQUIRY_CANCEL		0x0402
 
@@ -244,81 +244,81 @@ struct hci_cp_create_conn {
 	__u8     pscan_mode;
 	__le16   clock_offset;
 	__u8     role_switch;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_DISCONNECT		0x0406
 struct hci_cp_disconnect {
 	__le16   handle;
 	__u8     reason;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_ADD_SCO			0x0407
 struct hci_cp_add_sco {
 	__le16   handle;
 	__le16   pkt_type;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_CREATE_CONN_CANCEL	0x0408
 struct hci_cp_create_conn_cancel {
 	bdaddr_t bdaddr;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_ACCEPT_CONN_REQ		0x0409
 struct hci_cp_accept_conn_req {
 	bdaddr_t bdaddr;
 	__u8     role;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_REJECT_CONN_REQ		0x040a
 struct hci_cp_reject_conn_req {
 	bdaddr_t bdaddr;
 	__u8     reason;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_LINK_KEY_REPLY		0x040b
 struct hci_cp_link_key_reply {
 	bdaddr_t bdaddr;
 	__u8     link_key[16];
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_LINK_KEY_NEG_REPLY	0x040c
 struct hci_cp_link_key_neg_reply {
 	bdaddr_t bdaddr;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_PIN_CODE_REPLY		0x040d
 struct hci_cp_pin_code_reply {
 	bdaddr_t bdaddr;
 	__u8     pin_len;
 	__u8     pin_code[16];
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_PIN_CODE_NEG_REPLY	0x040e
 struct hci_cp_pin_code_neg_reply {
 	bdaddr_t bdaddr;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_CHANGE_CONN_PTYPE	0x040f
 struct hci_cp_change_conn_ptype {
 	__le16   handle;
 	__le16   pkt_type;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_AUTH_REQUESTED		0x0411
 struct hci_cp_auth_requested {
 	__le16   handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_SET_CONN_ENCRYPT		0x0413
 struct hci_cp_set_conn_encrypt {
 	__le16   handle;
 	__u8     encrypt;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_CHANGE_CONN_LINK_KEY	0x0415
 struct hci_cp_change_conn_link_key {
 	__le16   handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_REMOTE_NAME_REQ		0x0419
 struct hci_cp_remote_name_req {
@@ -326,28 +326,28 @@ struct hci_cp_remote_name_req {
 	__u8     pscan_rep_mode;
 	__u8     pscan_mode;
 	__le16   clock_offset;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_REMOTE_NAME_REQ_CANCEL	0x041a
 struct hci_cp_remote_name_req_cancel {
 	bdaddr_t bdaddr;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_READ_REMOTE_FEATURES	0x041b
 struct hci_cp_read_remote_features {
 	__le16   handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_READ_REMOTE_EXT_FEATURES	0x041c
 struct hci_cp_read_remote_ext_features {
 	__le16   handle;
 	__u8     page;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_READ_REMOTE_VERSION	0x041d
 struct hci_cp_read_remote_version {
 	__le16   handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_SETUP_SYNC_CONN		0x0428
 struct hci_cp_setup_sync_conn {
@@ -358,7 +358,7 @@ struct hci_cp_setup_sync_conn {
 	__le16   voice_setting;
 	__u8     retrans_effort;
 	__le16   pkt_type;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_ACCEPT_SYNC_CONN_REQ	0x0429
 struct hci_cp_accept_sync_conn_req {
@@ -369,13 +369,13 @@ struct hci_cp_accept_sync_conn_req {
 	__le16   content_format;
 	__u8     retrans_effort;
 	__le16   pkt_type;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_REJECT_SYNC_CONN_REQ	0x042a
 struct hci_cp_reject_sync_conn_req {
 	bdaddr_t bdaddr;
 	__u8     reason;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_SNIFF_MODE		0x0803
 struct hci_cp_sniff_mode {
@@ -384,59 +384,59 @@ struct hci_cp_sniff_mode {
 	__le16   min_interval;
 	__le16   attempt;
 	__le16   timeout;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_EXIT_SNIFF_MODE		0x0804
 struct hci_cp_exit_sniff_mode {
 	__le16   handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_ROLE_DISCOVERY		0x0809
 struct hci_cp_role_discovery {
 	__le16   handle;
-} __attribute__ ((packed));
+} __packed;
 struct hci_rp_role_discovery {
 	__u8     status;
 	__le16   handle;
 	__u8     role;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_SWITCH_ROLE		0x080b
 struct hci_cp_switch_role {
 	bdaddr_t bdaddr;
 	__u8     role;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_READ_LINK_POLICY		0x080c
 struct hci_cp_read_link_policy {
 	__le16   handle;
-} __attribute__ ((packed));
+} __packed;
 struct hci_rp_read_link_policy {
 	__u8     status;
 	__le16   handle;
 	__le16   policy;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_WRITE_LINK_POLICY	0x080d
 struct hci_cp_write_link_policy {
 	__le16   handle;
 	__le16   policy;
-} __attribute__ ((packed));
+} __packed;
 struct hci_rp_write_link_policy {
 	__u8     status;
 	__le16   handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_READ_DEF_LINK_POLICY	0x080e
 struct hci_rp_read_def_link_policy {
 	__u8     status;
 	__le16   policy;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_WRITE_DEF_LINK_POLICY	0x080f
 struct hci_cp_write_def_link_policy {
 	__le16   policy;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_SNIFF_SUBRATE		0x0811
 struct hci_cp_sniff_subrate {
@@ -444,12 +444,12 @@ struct hci_cp_sniff_subrate {
 	__le16   max_latency;
 	__le16   min_remote_timeout;
 	__le16   min_local_timeout;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_SET_EVENT_MASK		0x0c01
 struct hci_cp_set_event_mask {
 	__u8     mask[8];
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_RESET			0x0c03
 
@@ -458,7 +458,7 @@ struct hci_cp_set_event_flt {
 	__u8     flt_type;
 	__u8     cond_type;
 	__u8     condition[0];
-} __attribute__ ((packed));
+} __packed;
 
 /* Filter types */
 #define HCI_FLT_CLEAR_ALL	0x00
@@ -477,13 +477,13 @@ struct hci_cp_set_event_flt {
 #define HCI_OP_WRITE_LOCAL_NAME		0x0c13
 struct hci_cp_write_local_name {
 	__u8     name[248];
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_READ_LOCAL_NAME		0x0c14
 struct hci_rp_read_local_name {
 	__u8     status;
 	__u8     name[248];
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_WRITE_CA_TIMEOUT		0x0c16
 
@@ -511,23 +511,23 @@ struct hci_rp_read_local_name {
 struct hci_rp_read_class_of_dev {
 	__u8     status;
 	__u8     dev_class[3];
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_WRITE_CLASS_OF_DEV	0x0c24
 struct hci_cp_write_class_of_dev {
 	__u8     dev_class[3];
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_READ_VOICE_SETTING	0x0c25
 struct hci_rp_read_voice_setting {
 	__u8     status;
 	__le16   voice_setting;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_WRITE_VOICE_SETTING	0x0c26
 struct hci_cp_write_voice_setting {
 	__le16   voice_setting;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_HOST_BUFFER_SIZE		0x0c33
 struct hci_cp_host_buffer_size {
@@ -535,18 +535,18 @@ struct hci_cp_host_buffer_size {
 	__u8     sco_mtu;
 	__le16   acl_max_pkt;
 	__le16   sco_max_pkt;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_READ_SSP_MODE		0x0c55
 struct hci_rp_read_ssp_mode {
 	__u8     status;
 	__u8     mode;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_WRITE_SSP_MODE		0x0c56
 struct hci_cp_write_ssp_mode {
 	__u8     mode;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_READ_LOCAL_VERSION	0x1001
 struct hci_rp_read_local_version {
@@ -556,19 +556,19 @@ struct hci_rp_read_local_version {
 	__u8     lmp_ver;
 	__le16   manufacturer;
 	__le16   lmp_subver;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_READ_LOCAL_COMMANDS	0x1002
 struct hci_rp_read_local_commands {
 	__u8     status;
 	__u8     commands[64];
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_READ_LOCAL_FEATURES	0x1003
 struct hci_rp_read_local_features {
 	__u8     status;
 	__u8     features[8];
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_READ_LOCAL_EXT_FEATURES	0x1004
 struct hci_rp_read_local_ext_features {
@@ -576,7 +576,7 @@ struct hci_rp_read_local_ext_features {
 	__u8     page;
 	__u8     max_page;
 	__u8     features[8];
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_READ_BUFFER_SIZE		0x1005
 struct hci_rp_read_buffer_size {
@@ -585,13 +585,13 @@ struct hci_rp_read_buffer_size {
 	__u8     sco_mtu;
 	__le16   acl_max_pkt;
 	__le16   sco_max_pkt;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_OP_READ_BD_ADDR		0x1009
 struct hci_rp_read_bd_addr {
 	__u8     status;
 	bdaddr_t bdaddr;
-} __attribute__ ((packed));
+} __packed;
 
 /* ---- HCI Events ---- */
 #define HCI_EV_INQUIRY_COMPLETE		0x01
@@ -604,7 +604,7 @@ struct inquiry_info {
 	__u8     pscan_mode;
 	__u8     dev_class[3];
 	__le16   clock_offset;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_EV_CONN_COMPLETE		0x03
 struct hci_ev_conn_complete {
@@ -613,54 +613,54 @@ struct hci_ev_conn_complete {
 	bdaddr_t bdaddr;
 	__u8     link_type;
 	__u8     encr_mode;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_EV_CONN_REQUEST		0x04
 struct hci_ev_conn_request {
 	bdaddr_t bdaddr;
 	__u8     dev_class[3];
 	__u8     link_type;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_EV_DISCONN_COMPLETE		0x05
 struct hci_ev_disconn_complete {
 	__u8     status;
 	__le16   handle;
 	__u8     reason;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_EV_AUTH_COMPLETE		0x06
 struct hci_ev_auth_complete {
 	__u8     status;
 	__le16   handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_EV_REMOTE_NAME		0x07
 struct hci_ev_remote_name {
 	__u8     status;
 	bdaddr_t bdaddr;
 	__u8     name[248];
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_EV_ENCRYPT_CHANGE		0x08
 struct hci_ev_encrypt_change {
 	__u8     status;
 	__le16   handle;
 	__u8     encrypt;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_EV_CHANGE_LINK_KEY_COMPLETE	0x09
 struct hci_ev_change_link_key_complete {
 	__u8     status;
 	__le16   handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_EV_REMOTE_FEATURES		0x0b
 struct hci_ev_remote_features {
 	__u8     status;
 	__le16   handle;
 	__u8     features[8];
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_EV_REMOTE_VERSION		0x0c
 struct hci_ev_remote_version {
@@ -669,7 +669,7 @@ struct hci_ev_remote_version {
 	__u8     lmp_ver;
 	__le16   manufacturer;
 	__le16   lmp_subver;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_EV_QOS_SETUP_COMPLETE	0x0d
 struct hci_qos {
@@ -678,38 +678,38 @@ struct hci_qos {
 	__u32    peak_bandwidth;
 	__u32    latency;
 	__u32    delay_variation;
-} __attribute__ ((packed));
+} __packed;
 struct hci_ev_qos_setup_complete {
 	__u8     status;
 	__le16   handle;
 	struct   hci_qos qos;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_EV_CMD_COMPLETE		0x0e
 struct hci_ev_cmd_complete {
 	__u8     ncmd;
 	__le16   opcode;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_EV_CMD_STATUS		0x0f
 struct hci_ev_cmd_status {
 	__u8     status;
 	__u8     ncmd;
 	__le16   opcode;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_EV_ROLE_CHANGE		0x12
 struct hci_ev_role_change {
 	__u8     status;
 	bdaddr_t bdaddr;
 	__u8     role;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_EV_NUM_COMP_PKTS		0x13
 struct hci_ev_num_comp_pkts {
 	__u8     num_hndl;
 	/* variable length part */
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_EV_MODE_CHANGE		0x14
 struct hci_ev_mode_change {
@@ -717,44 +717,44 @@ struct hci_ev_mode_change {
 	__le16   handle;
 	__u8     mode;
 	__le16   interval;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_EV_PIN_CODE_REQ		0x16
 struct hci_ev_pin_code_req {
 	bdaddr_t bdaddr;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_EV_LINK_KEY_REQ		0x17
 struct hci_ev_link_key_req {
 	bdaddr_t bdaddr;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_EV_LINK_KEY_NOTIFY		0x18
 struct hci_ev_link_key_notify {
 	bdaddr_t bdaddr;
 	__u8     link_key[16];
 	__u8     key_type;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_EV_CLOCK_OFFSET		0x1c
 struct hci_ev_clock_offset {
 	__u8     status;
 	__le16   handle;
 	__le16   clock_offset;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_EV_PKT_TYPE_CHANGE		0x1d
 struct hci_ev_pkt_type_change {
 	__u8     status;
 	__le16   handle;
 	__le16   pkt_type;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_EV_PSCAN_REP_MODE		0x20
 struct hci_ev_pscan_rep_mode {
 	bdaddr_t bdaddr;
 	__u8     pscan_rep_mode;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_EV_INQUIRY_RESULT_WITH_RSSI	0x22
 struct inquiry_info_with_rssi {
@@ -764,7 +764,7 @@ struct inquiry_info_with_rssi {
 	__u8     dev_class[3];
 	__le16   clock_offset;
 	__s8     rssi;
-} __attribute__ ((packed));
+} __packed;
 struct inquiry_info_with_rssi_and_pscan_mode {
 	bdaddr_t bdaddr;
 	__u8     pscan_rep_mode;
@@ -773,7 +773,7 @@ struct inquiry_info_with_rssi_and_pscan_mode {
 	__u8     dev_class[3];
 	__le16   clock_offset;
 	__s8     rssi;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_EV_REMOTE_EXT_FEATURES	0x23
 struct hci_ev_remote_ext_features {
@@ -782,7 +782,7 @@ struct hci_ev_remote_ext_features {
 	__u8     page;
 	__u8     max_page;
 	__u8     features[8];
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_EV_SYNC_CONN_COMPLETE	0x2c
 struct hci_ev_sync_conn_complete {
@@ -795,7 +795,7 @@ struct hci_ev_sync_conn_complete {
 	__le16   rx_pkt_len;
 	__le16   tx_pkt_len;
 	__u8     air_mode;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_EV_SYNC_CONN_CHANGED	0x2d
 struct hci_ev_sync_conn_changed {
@@ -805,7 +805,7 @@ struct hci_ev_sync_conn_changed {
 	__u8     retrans_window;
 	__le16   rx_pkt_len;
 	__le16   tx_pkt_len;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_EV_SNIFF_SUBRATE		0x2e
 struct hci_ev_sniff_subrate {
@@ -815,7 +815,7 @@ struct hci_ev_sniff_subrate {
 	__le16   max_rx_latency;
 	__le16   max_remote_timeout;
 	__le16   max_local_timeout;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_EV_EXTENDED_INQUIRY_RESULT	0x2f
 struct extended_inquiry_info {
@@ -826,37 +826,37 @@ struct extended_inquiry_info {
 	__le16   clock_offset;
 	__s8     rssi;
 	__u8     data[240];
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_EV_IO_CAPA_REQUEST		0x31
 struct hci_ev_io_capa_request {
 	bdaddr_t bdaddr;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_EV_SIMPLE_PAIR_COMPLETE	0x36
 struct hci_ev_simple_pair_complete {
 	__u8     status;
 	bdaddr_t bdaddr;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_EV_REMOTE_HOST_FEATURES	0x3d
 struct hci_ev_remote_host_features {
 	bdaddr_t bdaddr;
 	__u8     features[8];
-} __attribute__ ((packed));
+} __packed;
 
 /* Internal events generated by Bluetooth stack */
 #define HCI_EV_STACK_INTERNAL	0xfd
 struct hci_ev_stack_internal {
 	__u16    type;
 	__u8     data[0];
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_EV_SI_DEVICE	0x01
 struct hci_ev_si_device {
 	__u16    event;
 	__u16    dev_id;
-} __attribute__ ((packed));
+} __packed;
 
 #define HCI_EV_SI_SECURITY	0x02
 struct hci_ev_si_security {
@@ -864,7 +864,7 @@ struct hci_ev_si_security {
 	__u16    proto;
 	__u16    subproto;
 	__u8     incoming;
-} __attribute__ ((packed));
+} __packed;
 
 /* ---- HCI Packet structures ---- */
 #define HCI_COMMAND_HDR_SIZE 3
@@ -875,22 +875,22 @@ struct hci_ev_si_security {
 struct hci_command_hdr {
 	__le16	opcode;		/* OCF & OGF */
 	__u8 	plen;
-} __attribute__ ((packed));
+} __packed;
 
 struct hci_event_hdr {
 	__u8	evt;
 	__u8	plen;
-} __attribute__ ((packed));
+} __packed;
 
 struct hci_acl_hdr {
 	__le16	handle;		/* Handle & Flags(PB, BC) */
 	__le16	dlen;
-} __attribute__ ((packed));
+} __packed;
 
 struct hci_sco_hdr {
 	__le16	handle;
 	__u8	dlen;
-} __attribute__ ((packed));
+} __packed;
 
 #ifdef __KERNEL__
 #include <linux/skbuff.h>
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 4b86c78..636724b 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -131,31 +131,31 @@ struct l2cap_conninfo {
 struct l2cap_hdr {
 	__le16     len;
 	__le16     cid;
-} __attribute__ ((packed));
+} __packed;
 #define L2CAP_HDR_SIZE		4
 
 struct l2cap_cmd_hdr {
 	__u8       code;
 	__u8       ident;
 	__le16     len;
-} __attribute__ ((packed));
+} __packed;
 #define L2CAP_CMD_HDR_SIZE	4
 
 struct l2cap_cmd_rej {
 	__le16     reason;
-} __attribute__ ((packed));
+} __packed;
 
 struct l2cap_conn_req {
 	__le16     psm;
 	__le16     scid;
-} __attribute__ ((packed));
+} __packed;
 
 struct l2cap_conn_rsp {
 	__le16     dcid;
 	__le16     scid;
 	__le16     result;
 	__le16     status;
-} __attribute__ ((packed));
+} __packed;
 
 /* channel indentifier */
 #define L2CAP_CID_SIGNALING	0x0001
@@ -179,14 +179,14 @@ struct l2cap_conf_req {
 	__le16     dcid;
 	__le16     flags;
 	__u8       data[0];
-} __attribute__ ((packed));
+} __packed;
 
 struct l2cap_conf_rsp {
 	__le16     scid;
 	__le16     flags;
 	__le16     result;
 	__u8       data[0];
-} __attribute__ ((packed));
+} __packed;
 
 #define L2CAP_CONF_SUCCESS	0x0000
 #define L2CAP_CONF_UNACCEPT	0x0001
@@ -197,7 +197,7 @@ struct l2cap_conf_opt {
 	__u8       type;
 	__u8       len;
 	__u8       val[0];
-} __attribute__ ((packed));
+} __packed;
 #define L2CAP_CONF_OPT_SIZE	2
 
 #define L2CAP_CONF_HINT		0x80
@@ -218,7 +218,7 @@ struct l2cap_conf_rfc {
 	__le16     retrans_timeout;
 	__le16     monitor_timeout;
 	__le16     max_pdu_size;
-} __attribute__ ((packed));
+} __packed;
 
 #define L2CAP_MODE_BASIC	0x00
 #define L2CAP_MODE_RETRANS	0x01
@@ -229,22 +229,22 @@ struct l2cap_conf_rfc {
 struct l2cap_disconn_req {
 	__le16     dcid;
 	__le16     scid;
-} __attribute__ ((packed));
+} __packed;
 
 struct l2cap_disconn_rsp {
 	__le16     dcid;
 	__le16     scid;
-} __attribute__ ((packed));
+} __packed;
 
 struct l2cap_info_req {
 	__le16      type;
-} __attribute__ ((packed));
+} __packed;
 
 struct l2cap_info_rsp {
 	__le16      type;
 	__le16      result;
 	__u8        data[0];
-} __attribute__ ((packed));
+} __packed;
 
 /* info type */
 #define L2CAP_IT_CL_MTU     0x0001
diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index 921d7b3..a140847 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -106,19 +106,19 @@ struct rfcomm_hdr {
 	u8 addr;
 	u8 ctrl;
 	u8 len;    // Actual size can be 2 bytes
-} __attribute__ ((packed));
+} __packed;
 
 struct rfcomm_cmd {
 	u8 addr;
 	u8 ctrl;
 	u8 len;
 	u8 fcs;
-} __attribute__ ((packed));
+} __packed;
 
 struct rfcomm_mcc {
 	u8 type;
 	u8 len;
-} __attribute__ ((packed));
+} __packed;
 
 struct rfcomm_pn {
 	u8  dlci;
@@ -128,7 +128,7 @@ struct rfcomm_pn {
 	__le16 mtu;
 	u8  max_retrans;
 	u8  credits;
-} __attribute__ ((packed));
+} __packed;
 
 struct rfcomm_rpn {
 	u8  dlci;
@@ -138,17 +138,17 @@ struct rfcomm_rpn {
 	u8  xon_char;
 	u8  xoff_char;
 	__le16 param_mask;
-} __attribute__ ((packed));
+} __packed;
 
 struct rfcomm_rls {
 	u8  dlci;
 	u8  status;
-} __attribute__ ((packed));
+} __packed;
 
 struct rfcomm_msc {
 	u8  dlci;
 	u8  v24_sig;
-} __attribute__ ((packed));
+} __packed;
 
 /* ---- Core structures, flags etc ---- */
 
-- 
1.7.1.1
