Return-Path: <cyrus@holtmann.org>
From: Inga Stotland <ingas@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: rshaffer@codeaurora.org, johan.hedberg@gmail.com,
	marcel@holtmann.org, Inga Stotland <ingas@codeaurora.org>
Subject: [PATCH 1/3] Add parsing of AMP related HCI commands
Date: Wed, 18 Aug 2010 16:38:52 -0700
Message-Id: <1282174734-1314-2-git-send-email-ingas@codeaurora.org>
In-Reply-To: <1282174734-1314-1-git-send-email-ingas@codeaurora.org>
References: <1282174734-1314-1-git-send-email-ingas@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 parser/hci.c |   64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/parser/hci.c b/parser/hci.c
index b9e8d28..b768a98 100644
--- a/parser/hci.c
+++ b/parser/hci.c
@@ -141,7 +141,7 @@ static char *ev_le_meta_str[LE_EV_NUM + 1] = {
 	"LE Long Term Key Request",
 };
 
-#define CMD_LINKCTL_NUM 52
+#define CMD_LINKCTL_NUM 60
 static char *cmd_linkctl_str[CMD_LINKCTL_NUM + 1] = {
 	"Unknown",
 	"Inquiry",
@@ -196,6 +196,14 @@ static char *cmd_linkctl_str[CMD_LINKCTL_NUM + 1] = {
 	"Unknown",
 	"Remote OOB Data Request Negative Reply",
 	"IO Capability Request Negative Reply",
+	"Create Physical Link",
+	"Accept Physical Link",
+	"Disconnect Physical Link",
+	"Create Logical Link",
+	"Accept Logical Link",
+	"Disconnect Logical Link",
+	"Logical Link Cancel",
+	"Flow Spec Modify",
 };
 
 #define CMD_LINKPOL_NUM 17
@@ -348,7 +356,7 @@ static char *cmd_info_str[CMD_INFO_NUM + 1] = {
 	"Read BD ADDR",
 };
 
-#define CMD_STATUS_NUM 7
+#define CMD_STATUS_NUM 11
 static char *cmd_status_str[CMD_STATUS_NUM + 1] = {
 	"Unknown",
 	"Read Failed Contact Counter",
@@ -358,6 +366,10 @@ static char *cmd_status_str[CMD_STATUS_NUM + 1] = {
 	"Read RSSI",
 	"Read AFH Channel Map",
 	"Read Clock",
+	"Read Encryption Key Size",
+	"Read Local AMP Info",
+	"Read Local AMP ASSOC",
+	"Write Remote AMP ASSOC"
 };
 
 #define CMD_TESTING_NUM 4
@@ -1003,6 +1015,39 @@ static inline void setup_sync_conn_dump(int level, struct frame *frm)
 		btohs(cp->pkt_type));
 }
 
+static inline void create_physical_link_dump(int level, struct frame *frm)
+{
+	create_physical_link_cp *cp = frm->ptr;
+	int i;
+
+	p_indent(level, frm);
+
+	printf("handle %d key length %d key type %d\n",
+		cp->handle, cp->key_length, cp->key_type);
+	printf("key ");
+
+	for (i = 0; i < cp->key_length && cp->key_length < 32; i++)
+		printf("%2.2x", cp->key[i]);
+	printf("\n");
+}
+
+static inline void create_logical_link_dump(int level, struct frame *frm)
+{
+	create_logical_link_cp *cp = frm->ptr;
+	int i;
+
+	p_indent(level, frm);
+
+	printf("handle %d\n", cp->handle);
+	printf("tx_flow ");
+	for (i = 0; i < 16; i++)
+		printf("%2.2x", cp->tx_flow[i]);
+	printf("\nrx_flow ");
+	for (i = 0; i < 16; i++)
+		printf("%2.2x", cp->rx_flow[i]);
+	printf("\n");
+}
+
 static inline void hold_mode_dump(int level, struct frame *frm)
 {
 	hold_mode_cp *cp = frm->ptr;
@@ -1523,6 +1568,7 @@ static inline void command_dump(int level, struct frame *frm)
 		case OCF_READ_REMOTE_VERSION:
 		case OCF_READ_CLOCK_OFFSET:
 		case OCF_READ_LMP_HANDLE:
+		case OCF_DISCONNECT_LOGICAL_LINK:
 			generic_command_dump(level + 1, frm);
 			return;
 		case OCF_MASTER_LINK_KEY:
@@ -1537,6 +1583,14 @@ static inline void command_dump(int level, struct frame *frm)
 		case OCF_SETUP_SYNC_CONN:
 			setup_sync_conn_dump(level + 1, frm);
 			return;
+		case OCF_CREATE_PHYSICAL_LINK:
+		case OCF_ACCEPT_PHYSICAL_LINK:
+			create_physical_link_dump(level + 1, frm);
+			return;
+		case OCF_CREATE_LOGICAL_LINK:
+		case OCF_ACCEPT_LOGICAL_LINK:
+			create_logical_link_dump(level + 1, frm);
+			return;
 		}
 		break;
 
@@ -1581,6 +1635,7 @@ static inline void command_dump(int level, struct frame *frm)
 		case OCF_CREATE_NEW_UNIT_KEY:
 			return;
 		case OCF_SET_EVENT_MASK:
+		case OCF_SET_EVENT_MASK_PAGE_2:
 			set_event_mask_dump(level + 1, frm);
 			return;
 		case OCF_SET_EVENT_FLT:
@@ -1613,6 +1668,7 @@ static inline void command_dump(int level, struct frame *frm)
 		case OCF_SET_CONTROLLER_TO_HOST_FC:
 			write_scan_enable_dump(level + 1, frm);
 			return;
+		case OCF_WRITE_LOGICAL_LINK_ACCEPT_TIMEOUT:
 		case OCF_WRITE_CONN_ACCEPT_TIMEOUT:
 		case OCF_WRITE_PAGE_TIMEOUT:
 			write_page_timeout_dump(level + 1, frm);
@@ -1644,6 +1700,7 @@ static inline void command_dump(int level, struct frame *frm)
 		case OCF_FLUSH:
 		case OCF_READ_LINK_SUPERVISION_TIMEOUT:
 		case OCF_REFRESH_ENCRYPTION_KEY:
+		case OCF_READ_BEST_EFFORT_FLUSH_TIMEOUT:
 			generic_command_dump(level + 1, frm);
 			return;
 		case OCF_WRITE_LINK_SUPERVISION_TIMEOUT:
@@ -1653,6 +1710,7 @@ static inline void command_dump(int level, struct frame *frm)
 			write_ext_inquiry_response_dump(level + 1, frm);
 			return;
 		case OCF_WRITE_SIMPLE_PAIRING_MODE:
+		case OCF_WRITE_FLOW_CONTROL_MODE:
 			generic_write_mode_dump(level + 1, frm);
 			return;
 		case OCF_WRITE_INQUIRY_TRANSMIT_POWER_LEVEL:
@@ -2435,6 +2493,7 @@ static inline void cmd_complete_dump(int level, struct frame *frm)
 			read_local_oob_data_dump(level, frm);
 			return;
 		case OCF_READ_SIMPLE_PAIRING_MODE:
+		case OCF_READ_FLOW_CONTROL_MODE:
 			status_mode_dump(level, frm);
 			return;
 		case OCF_FLUSH:
@@ -2469,6 +2528,7 @@ static inline void cmd_complete_dump(int level, struct frame *frm)
 		case OCF_HOST_BUFFER_SIZE:
 		case OCF_REFRESH_ENCRYPTION_KEY:
 		case OCF_SEND_KEYPRESS_NOTIFY:
+		case OCF_WRITE_LOCATION_DATA:
 			status_response_dump(level, frm);
 			return;
 		}
-- 
1.7.2

-- 
Inga Stotland
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
