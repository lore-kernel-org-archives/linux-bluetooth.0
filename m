Return-Path: <cyrus@holtmann.org>
From: Inga Stotland <ingas@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: rshaffer@codeaurora.org, johan.hedberg@gmail.com,
	marcel@holtmann.org, Inga Stotland <ingas@codeaurora.org>
Subject: [PATCH 2/3] Parse Command Complete events corresponding to AMP related HCI commands
Date: Wed, 18 Aug 2010 16:38:53 -0700
Message-Id: <1282174734-1314-3-git-send-email-ingas@codeaurora.org>
In-Reply-To: <1282174734-1314-1-git-send-email-ingas@codeaurora.org>
References: <1282174734-1314-1-git-send-email-ingas@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 parser/hci.c |   80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 80 insertions(+), 0 deletions(-)

diff --git a/parser/hci.c b/parser/hci.c
index b768a98..5de5128 100644
--- a/parser/hci.c
+++ b/parser/hci.c
@@ -2360,6 +2360,71 @@ static inline void read_clock_dump(int level, struct frame *frm)
 	}
 }
 
+static inline void read_local_amp_info_dump(int level, struct frame *frm)
+{
+	read_local_amp_info_rp *rp = frm->ptr;
+
+	p_indent(level, frm);
+	printf("status 0x%2.2x amp status 0x%2.2x\n",
+			rp->status, rp->amp_status);
+	if (rp->status > 0) {
+		p_indent(level, frm);
+		printf("Error: %s\n", status2str(rp->status));
+	} else {
+		p_indent(level, frm);
+		printf("total bandwidth %d, max guaranteed bandwidth %d\n",
+			btohl(rp->total_bandwidth),
+			btohl(rp->max_guaranteed_bandwidth));
+		p_indent(level, frm);
+		printf("min latency %d, max PDU %d, controller type 0x%2.2x\n",
+			btohl(rp->min_latency), btohl(rp->max_pdu_size),
+			rp->controller_type);
+		p_indent(level, frm);
+		printf("pal caps 0x%4.4x, max assoc len %d\n",
+			btohs(rp->pal_caps), btohs(rp->max_amp_assoc_length));
+		p_indent(level, frm);
+		printf("max flush timeout %d, best effort flush timeout %d\n",
+			btohl(rp->max_flush_timeout),
+			btohl(rp->best_effort_flush_timeout));
+	}
+}
+
+static inline void read_local_amp_assoc_dump(int level, struct frame *frm)
+{
+	read_local_amp_assoc_rp *rp = frm->ptr;
+	uint16_t len = btohs(rp->length);
+	int i;
+
+	p_indent(level, frm);
+	printf("status 0x%2.2x handle 0x%2.2x length %d\n",
+			rp->status, rp->handle, len);
+	if (rp->status > 0) {
+		p_indent(level, frm);
+		printf("Error: %s\n", status2str(rp->status));
+	} else {
+		for (i = 0; i < len; i++) {
+			if (!(i % 16)) {
+				printf("\n");
+				p_indent(level, frm);
+			}
+			printf("%2.2x ", rp->fragment[i]);
+		}
+		printf("\n");
+	}
+}
+
+static inline void write_remote_amp_assoc_dump(int level, struct frame *frm)
+{
+	write_remote_amp_assoc_rp *rp = frm->ptr;
+
+	p_indent(level, frm);
+	printf("status 0x%2.2x handle 0x%2.2x\n", rp->status, rp->handle);
+	if (rp->status > 0) {
+		p_indent(level, frm);
+		printf("Error: %s\n", status2str(rp->status));
+	}
+}
+
 static inline void cmd_complete_dump(int level, struct frame *frm)
 {
 	evt_cmd_complete *evt = frm->ptr;
@@ -2460,6 +2525,7 @@ static inline void cmd_complete_dump(int level, struct frame *frm)
 			return;
 		case OCF_READ_CONN_ACCEPT_TIMEOUT:
 		case OCF_READ_PAGE_TIMEOUT:
+		case OCF_READ_LOGICAL_LINK_ACCEPT_TIMEOUT:
 			read_page_timeout_dump(level, frm);
 			return;
 		case OCF_READ_PAGE_ACTIVITY:
@@ -2528,7 +2594,12 @@ static inline void cmd_complete_dump(int level, struct frame *frm)
 		case OCF_HOST_BUFFER_SIZE:
 		case OCF_REFRESH_ENCRYPTION_KEY:
 		case OCF_SEND_KEYPRESS_NOTIFY:
+		case OCF_WRITE_LOGICAL_LINK_ACCEPT_TIMEOUT:
+		case OCF_SET_EVENT_MASK_PAGE_2:
 		case OCF_WRITE_LOCATION_DATA:
+		case OCF_WRITE_FLOW_CONTROL_MODE:
+		case OCF_READ_BEST_EFFORT_FLUSH_TIMEOUT:
+		case OCF_WRITE_BEST_EFFORT_FLUSH_TIMEOUT:
 			status_response_dump(level, frm);
 			return;
 		}
@@ -2575,6 +2646,15 @@ static inline void cmd_complete_dump(int level, struct frame *frm)
 		case OCF_READ_CLOCK:
 			read_clock_dump(level, frm);
 			return;
+		case OCF_READ_LOCAL_AMP_INFO:
+			read_local_amp_info_dump(level, frm);
+			return;
+		case OCF_READ_LOCAL_AMP_ASSOC:
+			read_local_amp_assoc_dump(level, frm);
+			return;
+		case OCF_WRITE_REMOTE_AMP_ASSOC:
+			write_remote_amp_assoc_dump(level, frm);
+			return;
 		}
 		break;
 
-- 
1.7.2

-- 
Inga Stotland
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
