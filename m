Return-Path: <cyrus@holtmann.org>
From: Ville Tervo <ville.tervo@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ville Tervo <ville.tervo@nokia.com>
Subject: [PATCH] Add LE connection creation dumping
Date: Fri, 16 Jul 2010 12:31:07 +0300
Message-Id: <1279272667-16949-1-git-send-email-ville.tervo@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 parser/hci.c |  138 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 135 insertions(+), 3 deletions(-)

diff --git a/parser/hci.c b/parser/hci.c
index a3f001b..6ced0ee 100644
--- a/parser/hci.c
+++ b/parser/hci.c
@@ -50,7 +50,7 @@ static inline uint16_t get_manufacturer(void)
 	return (manufacturer == DEFAULT_COMPID ? parser.defcompid : manufacturer);
 }
 
-#define EVENT_NUM 61
+#define EVENT_NUM 76
 static char *event_str[EVENT_NUM + 1] = {
 	"Unknown",
 	"Inquiry Complete",
@@ -114,6 +114,31 @@ static char *event_str[EVENT_NUM + 1] = {
 	"User Passkey Notification",
 	"Keypress Notification",
 	"Remote Host Supported Features Notification",
+	"LE Meta Event",
+	"Physical Link Complete",
+	"Channel Selected",
+	"Disconnection Physical Link Complete",
+	"Physical Link Loss Early Warning",
+	"Physical Link Recovery",
+	"Logical Link Complete",
+	"Disconnection Logical Link Complete",
+	"Flow Spec Modify Complete",
+	"Number Of Completed Data Blocks",
+	"AMP Start Test",
+	"AMP Test End",
+	"AMP Receiver Report",
+	"Short Range Mode Change Complete",
+	"AMP Status Change",
+};
+
+#define LE_EV_NUM 5
+static char *ev_le_meta_str[LE_EV_NUM + 1] = {
+	"Unknown",
+	"LE Connection Complete",
+	"LE Advertising Report",
+	"LE Connection Update Complete",
+	"LE Read Remote Used Features Complete",
+	"LE Long Term Key Request",
 };
 
 #define CMD_LINKCTL_NUM 52
@@ -195,7 +220,7 @@ static char *cmd_linkpol_str[CMD_LINKPOL_NUM + 1] = {
 	"Sniff Subrating",
 };
 
-#define CMD_HOSTCTL_NUM 95
+#define CMD_HOSTCTL_NUM 109
 static char *cmd_hostctl_str[CMD_HOSTCTL_NUM + 1] = {
 	"Unknown",
 	"Set Event Mask",
@@ -292,8 +317,21 @@ static char *cmd_hostctl_str[CMD_HOSTCTL_NUM + 1] = {
 	"Unknown",
 	"Unknown",
 	"Unknown",
-	"Enhanced Flush"
+	"Enhanced Flush",
 	"Unknown",
+	"Read Logical Link Accept Timeout",
+	"Write Logical Link Accept Timeout",
+	"Set Event Mask Page 2",
+	"Read Location Data",
+	"Write Location Data",
+	"Read Flow Control Mode",
+	"Write Flow Control Mode",
+	"Read Enhanced Transmit Power Level",
+	"Read Best Effort Flush Timeout",
+	"Write Best Effort Flush Timeout",
+	"Short Range Mode",
+	"Read LE Host Supported",
+	"Write LE Host Supported",
 };
 
 #define CMD_INFO_NUM 9
@@ -331,6 +369,42 @@ static char *cmd_testing_str[CMD_TESTING_NUM + 1] = {
 	"Unknown",
 };
 
+#define CMD_LE_NUM 30
+static char *cmd_le_str[CMD_LE_NUM + 1] = {
+	"Unknown",
+	"LE Set Event Mask",
+	"LE Read Buffer Size",
+	"LE Read Local Supported Features",
+	"Unknown",
+	"LE Set Random Address",
+	"LE Set Advertising Parameters",
+	"LE Read Advertising Channel Tx Power",
+	"LE Set Advertising Data",
+	"LE Set Scan Response Data",
+	"LE Set Advertise Enable",
+	"LE Set Scan Parameters",
+	"LE Set Scan Enable",
+	"LE Create Connection",
+	"LE Create Connection Cancel",
+	"LE Read White List Size",
+	"LE Clear White List",
+	"LE Add Device To White List",
+	"LE Remove Device From White List",
+	"LE Connection Update",
+	"LE Set Host Channel Classification"
+	"LE Read Channel Map",
+	"LE Read Remote Used Features",
+	"LE Encrypt",
+	"LE Rand",
+	"LE Start Encryption",
+	"LE Long Term Key Request Reply",
+	"LE Long Term Key Request Negative Reply",
+	"LE Read Supported States",
+	"LE Receiver Test",
+	"LE Transmitter Test",
+	"LE Test End",
+};
+
 #define ERROR_CODE_NUM 56
 static char *error_code_str[ERROR_CODE_NUM + 1] = {
 	"Success",
@@ -453,6 +527,13 @@ static char *opcode2str(uint16_t opcode)
 			cmd = "Unknown";
 		break;
 
+	case OGF_LE_CTL:
+		if (ocf <= CMD_LE_NUM)
+			cmd = cmd_le_str[ocf];
+		else
+			cmd = "Unknown";
+		break;
+
 	case OGF_VENDOR_CMD:
 		cmd = "Vendor";
 		break;
@@ -1333,6 +1414,16 @@ static inline void num_comp_pkts_dump(int level, struct frame *frm)
 	}
 }
 
+static inline void le_create_connection_dump(int level, struct frame *frm)
+{
+	char addr[18];
+	le_create_connection_cp *cp = frm->ptr;
+
+	p_indent(level, frm);
+	p_ba2str(&cp->peer_bdaddr, addr);
+	printf("bdaddr %s type %d \n", addr, cp->peer_bdaddr_type);
+}
+
 static inline void command_dump(int level, struct frame *frm)
 {
 	hci_command_hdr *hdr = frm->ptr;
@@ -1608,6 +1699,14 @@ static inline void command_dump(int level, struct frame *frm)
 			return;
 		}
 		break;
+
+	case OGF_LE_CTL:
+		switch (ocf) {
+		case OCF_LE_CREATE_CONN:
+			le_create_connection_dump(level + 1, frm);
+			return;
+		}
+		break;
 	}
 
 	raw_dump(level, frm);
@@ -2995,6 +3094,36 @@ static inline void remote_host_features_notify_dump(int level, struct frame *frm
 	printf("\n");
 }
 
+static inline void evt_le_conn_complete_dump(int level, struct frame *frm)
+{
+	evt_le_connection_complete *evt = frm->ptr;
+
+	p_indent(level, frm);
+	printf("status 0x%2.2x handle %d\n", evt->status, btohs(evt->handle));
+}
+
+static inline void le_meta_ev_dump(int level, struct frame *frm)
+{
+	evt_le_meta_event *mevt = frm->ptr;
+	uint8_t subevent;
+
+	subevent = mevt->subevent;
+
+	frm->ptr += EVT_LE_META_EVENT_SIZE;
+	frm->len -= EVT_LE_META_EVENT_SIZE;
+
+	p_indent(level, frm);
+	printf("%s\n", ev_le_meta_str[subevent]);
+
+	switch (mevt->subevent) {
+	case EVT_LE_CONN_COMPLETE:
+		evt_le_conn_complete_dump(level + 1, frm);
+		break;
+	default:
+		raw_dump(level, frm);
+	}
+}
+
 static inline void event_dump(int level, struct frame *frm)
 {
 	hci_event_hdr *hdr = frm->ptr;
@@ -3198,6 +3327,9 @@ static inline void event_dump(int level, struct frame *frm)
 	case EVT_REMOTE_HOST_FEATURES_NOTIFY:
 		remote_host_features_notify_dump(level + 1, frm);
 		break;
+	case EVT_LE_META_EVENT:
+		le_meta_ev_dump(level + 1, frm);
+		break;
 	default:
 		raw_dump(level, frm);
 		break;
-- 
1.7.0.1

