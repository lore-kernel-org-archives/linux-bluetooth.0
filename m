Return-Path: <cyrus@holtmann.org>
From: Inga Stotland <ingas@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: rshaffer@codeaurora.org, johan.hedberg@gmail.com,
	marcel@holtmann.org, Inga Stotland <ingas@codeaurora.org>
Subject: [PATCH 2/2] HCI events related to AMP functionality
Date: Tue, 10 Aug 2010 17:12:56 -0700
Message-Id: <1281485576-32715-3-git-send-email-ingas@codeaurora.org>
In-Reply-To: <1281485576-32715-1-git-send-email-ingas@codeaurora.org>
References: <1281485576-32715-1-git-send-email-ingas@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added constructs for the following HCI events:
PHYSICAL_LINK_COMPLETE, EVT_CHANNEL_SELECTED,
EVT_DISCONNECT_PHYSICAL_LINK_COMPLETE,
EVT_PHYSICAL_LINK_LOSS_EARLY_WARNING, EVT_PHYSICAL_LINK_RECOVERY,
EVT_LOGICAL_LINK_COMPLETE, EVT_DISCONNECT_LOGICAL_LINK_COMPLETE,
EVT_FLOW_SPEC_MODIFY_COMPLETE, EVT_NUMBER_COMPLETED_BLOCKS,
EVT_AMP_STATUS_CHANGE
---
 lib/hci.h |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/lib/hci.h b/lib/hci.h
index ae7b6da..8f35422 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -2108,6 +2108,63 @@ typedef struct {
 } __attribute__ ((packed)) evt_le_long_term_key_request;
 #define EVT_LE_LTK_REQUEST_SIZE 12
 
+#define EVT_PHYSICAL_LINK_COMPLETE		0x40
+typedef struct {
+	uint8_t		status;
+	uint8_t		handle;
+} __attribute__ ((packed)) evt_physical_link_complete;
+#define EVT_PHYSICAL_LINK_COMPLETE_SIZE 2
+
+#define EVT_CHANNEL_SELECTED		0x41
+
+#define EVT_DISCONNECT_PHYSICAL_LINK_COMPLETE	0x42
+typedef struct {
+	uint8_t		status;
+	uint8_t		handle;
+	uint8_t		reason;
+} __attribute__ ((packed)) evt_disconn_physical_link_complete;
+#define EVT_DISCONNECT_PHYSICAL_LINK_COMPLETE_SIZE 3
+
+#define EVT_PHYSICAL_LINK_LOSS_EARLY_WARNING	0x43
+typedef struct {
+	uint8_t		handle;
+	uint8_t		reason;
+} __attribute__ ((packed)) evt_physical_link_loss_warning;
+#define EVT_PHYSICAL_LINK_LOSS_WARNING_SIZE 2
+
+#define EVT_PHYSICAL_LINK_RECOVERY		0x44
+typedef struct {
+	uint8_t		handle;
+} __attribute__ ((packed)) evt_physical_link_recovery;
+#define EVT_PHYSICAL_LINK_RECOVERY_SIZE 1
+
+#define EVT_LOGICAL_LINK_COMPLETE		0x45
+typedef struct {
+	uint8_t		status;
+	uint16_t	log_handle;
+	uint8_t		handle;
+	uint8_t		tx_flow_id;
+} __attribute__ ((packed)) evt_logical_link_complete;
+#define EVT_LOGICAL_LINK_COMPLETE_SIZE 5
+
+#define EVT_DISCONNECT_LOGICAL_LINK_COMPLETE	0x46
+
+#define EVT_FLOW_SPEC_MODIFY_COMPLETE		0x47
+typedef struct {
+	uint8_t		status;
+	uint16_t	handle;
+} __attribute__ ((packed)) evt_flow_spec_modify_complete;
+#define EVT_FLOW_SPEC_MODIFY_COMPLETE_SIZE 3
+
+#define EVT_NUMBER_COMPLETED_BLOCKS		0x48
+
+#define EVT_AMP_STATUS_CHANGE			0x4D
+typedef struct {
+	uint8_t		status;
+	uint8_t		amp_status;
+} __attribute__ ((packed)) evt_amp_status_change;
+#define EVT_AMP_STATUS_CHANGE_SIZE 2
+
 #define EVT_TESTING			0xFE
 
 #define EVT_VENDOR			0xFF
-- 
1.7.2

-- 
Inga Stotland
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
