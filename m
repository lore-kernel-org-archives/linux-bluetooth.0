Return-Path: <cyrus@holtmann.org>
From: Peter Krystad <pkrystad@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: pkrystad@quicinc.com, Peter Krystad <pkrystad@codeaurora.org>
Subject: [PATCHv4 1/1] Add L2CAP Create/Move Channel and A2MP definitions
Date: Mon, 12 Dec 2011 21:57:16 -0800
Message-Id: <1323755836-15357-2-git-send-email-pkrystad@codeaurora.org>
In-Reply-To: <1323755836-15357-1-git-send-email-pkrystad@codeaurora.org>
References: <1323755836-15357-1-git-send-email-pkrystad@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/bluetooth.h |    5 ++
 lib/l2cap.h     |  158 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 163 insertions(+), 0 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 5bd4f03..ce49d6c 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -76,6 +76,11 @@ struct bt_security {
 #define BT_FLUSHABLE_OFF	0
 #define BT_FLUSHABLE_ON		1
 
+#define BT_CHANNEL_POLICY 	10
+#define BT_CHANNEL_POLICY_BREDR_ONLY		0
+#define BT_CHANNEL_POLICY_BREDR_PREFERRED	1
+#define BT_CHANNEL_POLICY_AMP_PREFERRED		2
+
 /* Connection and socket states */
 enum {
 	BT_CONNECTED = 1, /* Equal to TCP_ESTABLISHED to make net code happy */
diff --git a/lib/l2cap.h b/lib/l2cap.h
index 68593d3..7605219 100644
--- a/lib/l2cap.h
+++ b/lib/l2cap.h
@@ -82,6 +82,12 @@ struct l2cap_conninfo {
 #define L2CAP_ECHO_RSP		0x09
 #define L2CAP_INFO_REQ		0x0a
 #define L2CAP_INFO_RSP		0x0b
+#define L2CAP_CREATE_REQ	0x0c
+#define L2CAP_CREATE_RSP	0x0d
+#define L2CAP_MOVE_REQ		0x0e
+#define L2CAP_MOVE_RSP		0x0f
+#define L2CAP_MOVE_CFM		0x10
+#define L2CAP_MOVE_CFM_RSP	0x11
 
 /* L2CAP extended feature mask */
 #define L2CAP_FEAT_FLOWCTL	0x00000001
@@ -226,6 +232,158 @@ typedef struct {
 #define L2CAP_IR_SUCCESS	0x0000
 #define L2CAP_IR_NOTSUPP	0x0001
 
+typedef struct {
+	uint16_t	psm;
+	uint16_t	scid;
+	uint8_t		id;
+} __attribute__ ((packed)) l2cap_create_req;
+#define L2CAP_CREATE_REQ_SIZE 5
+
+typedef struct {
+	uint16_t	dcid;
+	uint16_t	scid;
+	uint16_t	result;
+	uint16_t	status;
+} __attribute__ ((packed)) l2cap_create_rsp;
+#define L2CAP_CREATE_RSP_SIZE 8
+
+typedef struct {
+	uint16_t	icid;
+	uint8_t		id;
+} __attribute__ ((packed)) l2cap_move_req;
+#define L2CAP_MOVE_REQ_SIZE 3
+
+typedef struct {
+	uint16_t	icid;
+	uint16_t	result;
+} __attribute__ ((packed)) l2cap_move_rsp;
+#define L2CAP_MOVE_RSP_SIZE 4
+
+typedef struct {
+	uint16_t	icid;
+	uint16_t	result;
+} __attribute__ ((packed)) l2cap_move_cfm;
+#define L2CAP_MOVE_CFM_SIZE 4
+
+typedef struct {
+	uint16_t	icid;
+} __attribute__ ((packed)) l2cap_move_cfm_rsp;
+#define L2CAP_MOVE_CFM_RSP_SIZE 2
+
+/* A2MP Protocol */
+
+/* A2MP command codes */
+
+#define A2MP_COMMAND_REJ	0x01
+#define A2MP_DISCOVER_REQ	0x02
+#define A2MP_DISCOVER_RSP	0x03
+#define A2MP_CHANGE_NOTIFY	0x04
+#define A2MP_CHANGE_RSP		0x05
+#define A2MP_INFO_REQ		0x06
+#define A2MP_INFO_RSP		0x07
+#define A2MP_ASSOC_REQ		0x08
+#define A2MP_ASSOC_RSP		0x09
+#define A2MP_CREATE_REQ		0x0a
+#define A2MP_CREATE_RSP		0x0b
+#define A2MP_DISCONN_REQ	0x0c
+#define A2MP_DISCONN_RSP	0x0d
+
+struct a2mp_hdr {
+	uint8_t		code;
+	uint8_t		ident;
+	uint16_t	len;
+} __attribute__ ((packed));
+#define A2MP_HDR_SIZE 4
+
+struct a2mp_command_rej {
+	uint16_t	reason;
+} __attribute__ ((packed));
+
+struct a2mp_discover_req {
+	uint16_t	mtu;
+	uint16_t	mask;
+} __attribute__ ((packed));
+
+struct a2mp_ctrl {
+	uint8_t		id;
+	uint8_t		type;
+	uint8_t		status;
+} __attribute__ ((packed));
+
+struct a2mp_discover_rsp {
+	uint16_t	mtu;
+	uint16_t	mask;
+	struct a2mp_ctrl ctrl_list[0];
+} __attribute__ ((packed));
+
+struct a2mp_info_req {
+	uint8_t		id;
+} __attribute__ ((packed));
+
+struct a2mp_info_rsp {
+	uint8_t		id;
+	uint8_t		status;
+	uint32_t	total_bw;
+	uint32_t	max_bw;
+	uint32_t	min_latency;
+	uint16_t	pal_caps;
+	uint16_t	assoc_size;
+} __attribute__ ((packed));
+
+struct a2mp_assoc_req {
+	uint8_t		id;
+} __attribute__ ((packed));
+
+struct a2mp_assoc_rsp {
+	uint8_t		id;
+	uint8_t		status;
+	uint8_t		assoc_data[0];
+} __attribute__ ((packed));
+
+struct a2mp_create_req {
+	uint8_t		local_id;
+	uint8_t		remote_id;
+	uint8_t		assoc_data[0];
+} __attribute__ ((packed));
+
+struct a2mp_create_rsp {
+	uint8_t		local_id;
+	uint8_t		remote_id;
+	uint8_t		status;
+} __attribute__ ((packed));
+
+struct a2mp_disconn_req {
+	uint8_t		local_id;
+	uint8_t		remote_id;
+} __attribute__ ((packed));
+
+struct a2mp_disconn_rsp {
+	uint8_t		local_id;
+	uint8_t		remote_id;
+	uint8_t		status;
+} __attribute__ ((packed));
+
+#define A2MP_COMMAND_NOT_RECOGNIZED 0x0000
+
+/* AMP controller status */
+#define AMP_CTRL_POWERED_DOWN		0x00
+#define AMP_CTRL_BLUETOOTH_ONLY		0x01
+#define AMP_CTRL_NO_CAPACITY		0x02
+#define AMP_CTRL_LOW_CAPACITY		0x03
+#define AMP_CTRL_MEDIUM_CAPACITY	0x04
+#define AMP_CTRL_HIGH_CAPACITY		0x05
+#define AMP_CTRL_FULL_CAPACITY		0x06
+
+/* A2MP response status */
+#define A2MP_STATUS_SUCCESS				0x00
+#define A2MP_STATUS_INVALID_CTRL_ID			0x01
+#define A2MP_STATUS_UNABLE_START_LINK_CREATION		0x02
+#define A2MP_STATUS_NO_PHYSICAL_LINK_EXISTS		0x02
+#define A2MP_STATUS_COLLISION_OCCURED			0x03
+#define A2MP_STATUS_DISCONN_REQ_RECVD			0x04
+#define A2MP_STATUS_PHYS_LINK_EXISTS			0x05
+#define A2MP_STATUS_SECURITY_VIOLATION			0x06
+
 #ifdef __cplusplus
 }
 #endif
-- 
1.7.4.1

--
Peter Krystad
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
