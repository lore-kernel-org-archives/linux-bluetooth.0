Return-Path: <cyrus@holtmann.org>
From: Inga Stotland <ingas@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: rshaffer@codeaurora.org, johan.hedberg@gmail.com,
	marcel@holtmann.org, Inga Stotland <ingas@codeaurora.org>
Subject: [PATCH 1/2] HCI commands related to AMP functionality
Date: Tue, 10 Aug 2010 17:12:55 -0700
Message-Id: <1281485576-32715-2-git-send-email-ingas@codeaurora.org>
In-Reply-To: <1281485576-32715-1-git-send-email-ingas@codeaurora.org>
References: <1281485576-32715-1-git-send-email-ingas@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added constructs for the following HCI commands:
CREATE_PHYSICAL_LINK, ACCEPT_PHYSICAL_LINK, DISCONNECT_PHYSICAL_LINK,
CREATE_LOGICAL_LINK, ACCEPT_LOGICAL_LINK, DISCONNECT_LOGICAL_LINK,
LOGICAL_LINK_CANCEL, FLOW_SPEC_MODIFY,
READ_LOGICAL_LINK_ACCEPT_TIMEOUT, WRITE_LOGICAL_LINK_ACCEPT_TIMEOUT,
SET_EVENT_MASK_PAGE_2, READ_LOCATION_DATA, WRITE_LOCATION_DATA,
READ_FLOW_CONTROL_MODE, WRITE_FLOW_CONTROL_MODE,
READ_ENHANCED_TRANSMIT_POWER_LEVEL, READ_BEST_EFFORT_FLUSH_TIMEOUT,
WRITE_BEST_EFFORT_FLUSH_TIMEOUT, READ_LOCAL_AMP_INFO,
READ_LOCAL_AMP_ASSOC, WRITE_REMOTE_AMP_ASSOC
---
 lib/hci.h |  145 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 145 insertions(+), 0 deletions(-)

diff --git a/lib/hci.h b/lib/hci.h
index f31918d..ae7b6da 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -528,6 +528,55 @@ typedef struct {
 } __attribute__ ((packed)) io_capability_neg_reply_cp;
 #define IO_CAPABILITY_NEG_REPLY_CP_SIZE 7
 
+#define OCF_CREATE_PHYSICAL_LINK		0x0035
+typedef struct {
+	uint8_t		handle;
+	uint8_t		key_length;
+	uint8_t		key_type;
+	uint8_t		key[32];
+} __attribute__ ((packed)) create_physical_link_cp;
+#define CREATE_PHYSICAL_LINK_CP_SIZE 35
+
+#define OCF_ACCEPT_PHYSICAL_LINK		0x0036
+
+#define OCF_DISCONNECT_PHYSICAL_LINK		0x0037
+typedef struct {
+	uint8_t		handle;
+	uint8_t		reason;
+} __attribute__ ((packed)) disconnect_physical_link_cp;
+#define DISCONNECT_PHYSICAL_LINK_CP_SIZE 2
+
+#define OCF_CREATE_LOGICAL_LINK		0x0038
+typedef struct {
+	uint8_t		handle;
+	uint8_t		tx_flow[16];
+	uint8_t		rx_flow[16];
+} __attribute__ ((packed)) create_logical_link_cp;
+#define CREATE_LOGICAL_LINK_CP_SIZE 33
+
+#define OCF_ACCEPT_LOGICAL_LINK		0x0039
+
+#define OCF_DISCONNECT_LOGICAL_LINK		0x003A
+typedef struct {
+	uint16_t	handle;
+} __attribute__ ((packed)) disconnect_logical_link_cp;
+#define DISCONNECT_LOGICAL_LINK_CP_SIZE 2
+
+#define OCF_LOGICAL_LINK_CANCEL		0x003B
+typedef struct {
+	uint8_t		handle;
+	uint8_t		tx_flow_id;
+} __attribute__ ((packed)) cancel_logical_link_cp;
+#define LOGICAL_LINK_CANCEL_CP_SIZE 2
+typedef struct {
+	uint8_t		status;
+	uint8_t		handle;
+	uint8_t		tx_flow_id;
+} __attribute__ ((packed)) cancel_logical_link_rp;
+#define LOGICAL_LINK_CANCEL_RP_SIZE 3
+
+#define OCF_FLOW_SPEC_MODIFY		0x003C
+
 /* Link Policy */
 #define OGF_LINK_POLICY		0x02
 
@@ -1123,6 +1172,57 @@ typedef struct {
 } __attribute__ ((packed)) send_keypress_notify_rp;
 #define SEND_KEYPRESS_NOTIFY_RP_SIZE 1
 
+#define OCF_READ_LOGICAL_LINK_ACCEPT_TIMEOUT	 0x0061
+typedef struct {
+	uint8_t		status;
+	uint16_t	timeout;
+} __attribute__ ((packed)) read_log_link_accept_timeout_rp;
+#define READ_LOGICAL_LINK_ACCEPT_TIMEOUT_RP_SIZE 3
+
+#define OCF_WRITE_LOGICAL_LINK_ACCEPT_TIMEOUT	0x0062
+typedef struct {
+	uint16_t	timeout;
+} __attribute__ ((packed)) write_log_link_accept_timeout_cp;
+#define WRITE_LOGICAL_LINK_ACCEPT_TIMEOUT_CP_SIZE 2
+
+#define OCF_SET_EVENT_MASK_PAGE_2	0x0063
+
+#define OCF_READ_LOCATION_DATA		0x0064
+
+#define OCF_WRITE_LOCATION_DATA	0x0065
+
+#define OCF_READ_FLOW_CONTROL_MODE	0x0066
+
+#define OCF_WRITE_FLOW_CONTROL_MODE	0x0067
+
+#define OCF_READ_ENHANCED_TRANSMIT_POWER_LEVEL	0x0068
+typedef struct {
+	uint8_t		status;
+	uint16_t	handle;
+	int8_t		level_gfsk;
+	int8_t		level_dqpsk;
+	int8_t		level_8dpsk;
+} __attribute__ ((packed)) read_enhanced_transmit_power_level_rp;
+#define READ_ENHANCED_TRANSMIT_POWER_LEVEL_RP_SIZE 6
+
+#define OCF_READ_BEST_EFFORT_FLUSH_TIMEOUT	0x0069
+typedef struct {
+	uint8_t		status;
+	uint32_t	timeout;
+} __attribute__ ((packed)) read_best_effort_flush_timeout_rp;
+#define READ_BEST_EFFORT_FLUSH_TIMEOUT_RP_SIZE 5
+
+#define OCF_WRITE_BEST_EFFORT_FLUSH_TIMEOUT	0x006A
+typedef struct {
+	uint16_t	handle;
+	uint32_t	timeout;
+} __attribute__ ((packed)) write_best_effort_flush_timeout_cp;
+#define WRITE_BEST_EFFORT_FLUSH_TIMEOUT_CP_SIZE 6
+typedef struct {
+	uint8_t		status;
+} __attribute__ ((packed)) write_best_effort_flush_timeout_rp;
+#define WRITE_BEST_EFFORT_FLUSH_TIMEOUT_RP_SIZE 1
+
 /* Informational Parameters */
 #define OGF_INFO_PARAM		0x04
 
@@ -1240,6 +1340,51 @@ typedef struct {
 } __attribute__ ((packed)) read_clock_rp;
 #define READ_CLOCK_RP_SIZE 9
 
+#define OCF_READ_LOCAL_AMP_INFO	0x0009
+typedef struct {
+	uint8_t		status;
+	uint8_t		amp_status;
+	uint32_t	total_bandwidth;
+	uint32_t	max_guaranteed_bandwidth;
+	uint32_t	min_latency;
+	uint32_t	max_pdu_size;
+	uint8_t		controller_type;
+	uint16_t	pal_caps;
+	uint16_t	max_amp_assoc_length;
+	uint32_t	max_flush_timeout;
+	uint32_t	best_effort_flush_timeout;
+} __attribute__ ((packed)) read_local_amp_info_rp;
+#define READ_LOCAL_AMP_INFO_RP_SIZE 31
+
+#define OCF_READ_LOCAL_AMP_ASSOC	0x000A
+typedef struct {
+	uint8_t		handle;
+	uint16_t	length_so_far;
+	uint16_t	assoc_length;
+} __attribute__ ((packed)) read_local_amp_assoc_cp;
+#define READ_LOCAL_AMP_ASSOC_CP_SIZE 5
+typedef struct {
+	uint8_t		status;
+	uint8_t		handle;
+	uint16_t	length;
+	uint8_t		fragment[248];
+} __attribute__ ((packed)) read_local_amp_assoc_rp;
+#define READ_LOCAL_AMP_ASSOC_RP_SIZE 252
+
+#define OCF_WRITE_REMOTE_AMP_ASSOC	0x000B
+typedef struct {
+	uint8_t		handle;
+	uint16_t	length_so_far;
+	uint16_t	assoc_length;
+	uint8_t		fragment[248];
+} __attribute__ ((packed)) write_remote_amp_assoc_cp;
+#define WRITE_REMOTE_AMP_ASSOC_CP_SIZE 253
+typedef struct {
+	uint8_t		status;
+	uint8_t		handle;
+} __attribute__ ((packed)) write_remote_amp_assoc_rp;
+#define WRITE_REMOTE_AMP_ASSOC_RP_SIZE 2
+
 /* Testing commands */
 #define OGF_TESTING_CMD		0x3e
 
-- 
1.7.2

-- 
Inga Stotland
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
