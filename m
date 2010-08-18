Return-Path: <cyrus@holtmann.org>
From: Inga Stotland <ingas@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: rshaffer@codeaurora.org,
	johan.hedberg@gmail.com,
	marcel@holtmann.org,
	Inga Stotland <ingas@codeaurora.org>
Subject: [PATCH 3/3] Parsing of AMP specific HCI events
Date: Wed, 18 Aug 2010 16:38:54 -0700
Message-Id: <1282174734-1314-4-git-send-email-ingas@codeaurora.org>
In-Reply-To: <1282174734-1314-1-git-send-email-ingas@codeaurora.org>
References: <1282174734-1314-1-git-send-email-ingas@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

---
 parser/hci.c |   94 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 94 insertions(+), 0 deletions(-)

diff --git a/parser/hci.c b/parser/hci.c
index 5de5128..250ba58 100644
--- a/parser/hci.c
+++ b/parser/hci.c
@@ -3265,6 +3265,80 @@ static inline void le_meta_ev_dump(int level, struct frame *frm)
 	}
 }
 
+static inline void phys_link_complete_dump(int level, struct frame *frm)
+{
+	evt_physical_link_complete *evt = frm->ptr;
+
+	p_indent(level, frm);
+	printf("status 0x%2.2x handle %d\n", evt->status, evt->handle);
+
+	if (evt->status > 0) {
+		p_indent(level, frm);
+		printf("Error: %s\n", status2str(evt->status));
+	}
+}
+
+static inline void disconn_phys_link_complete_dump(int level, struct frame *frm)
+{
+	evt_disconn_physical_link_complete *evt = frm->ptr;
+
+	p_indent(level, frm);
+	printf("status 0x%2.2x handle %d reason 0x%2.2x\n",
+				evt->status, evt->handle, evt->reason);
+
+	if (evt->status > 0) {
+		p_indent(level, frm);
+		printf("Error: %s\n", status2str(evt->status));
+	} else if (evt->reason > 0) {
+		p_indent(level, frm);
+		printf("Reason: %s\n", status2str(evt->reason));
+	}
+}
+
+static inline void phys_link_loss_warning_dump(int level, struct frame *frm)
+{
+	evt_physical_link_loss_warning *evt = frm->ptr;
+
+	p_indent(level, frm);
+	printf("handle %d reason 0x%2.2x\n", evt->handle, evt->reason);
+}
+
+static inline void phys_link_handle_dump(int level, struct frame *frm)
+{
+	evt_physical_link_recovery *evt = frm->ptr;
+
+	p_indent(level, frm);
+	printf("handle %d\n", evt->handle);
+}
+
+static inline void logical_link_complete_dump(int level, struct frame *frm)
+{
+	evt_logical_link_complete *evt = frm->ptr;
+
+	p_indent(level, frm);
+	printf("status 0x%2.2x log_handle %d handle %d tx_flow_id %d\n",
+			evt->status, btohs(evt->log_handle), evt->handle,
+			evt->tx_flow_id);
+
+	if (evt->status > 0) {
+		p_indent(level, frm);
+		printf("Error: %s\n", status2str(evt->status));
+	}
+}
+
+static inline void flow_spec_modify_dump(int level, struct frame *frm)
+{
+	evt_flow_spec_modify_complete *evt = frm->ptr;
+
+	p_indent(level, frm);
+	printf("status 0x%2.2x handle %d\n", evt->status, btohs(evt->handle));
+
+	if (evt->status > 0) {
+		p_indent(level, frm);
+		printf("Error: %s\n", status2str(evt->status));
+	}
+}
+
 static inline void event_dump(int level, struct frame *frm)
 {
 	hci_event_hdr *hdr = frm->ptr;
@@ -3361,6 +3435,7 @@ static inline void event_dump(int level, struct frame *frm)
 		conn_request_dump(level + 1, frm);
 		break;
 	case EVT_DISCONN_COMPLETE:
+	case EVT_DISCONNECT_LOGICAL_LINK_COMPLETE:
 		disconn_complete_dump(level + 1, frm);
 		break;
 	case EVT_AUTH_COMPLETE:
@@ -3471,6 +3546,25 @@ static inline void event_dump(int level, struct frame *frm)
 	case EVT_LE_META_EVENT:
 		le_meta_ev_dump(level + 1, frm);
 		break;
+	case EVT_PHYSICAL_LINK_COMPLETE:
+		phys_link_complete_dump(level + 1, frm);
+		break;
+	case EVT_DISCONNECT_PHYSICAL_LINK_COMPLETE:
+		disconn_phys_link_complete_dump(level + 1, frm);
+		break;
+	case EVT_PHYSICAL_LINK_LOSS_EARLY_WARNING:
+		phys_link_loss_warning_dump(level + 1, frm);
+		break;
+	case EVT_PHYSICAL_LINK_RECOVERY:
+	case EVT_CHANNEL_SELECTED:
+		phys_link_handle_dump(level + 1, frm);
+		break;
+	case EVT_LOGICAL_LINK_COMPLETE:
+		logical_link_complete_dump(level + 1, frm);
+		break;
+	case EVT_FLOW_SPEC_MODIFY_COMPLETE:
+		flow_spec_modify_dump(level + 1, frm);
+		break;
 	default:
 		raw_dump(level, frm);
 		break;
-- 
1.7.2

-- 
Inga Stotland
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
