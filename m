Return-Path: <cyrus@holtmann.org>
From: Inga Stotland <ingas@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: rshaffer@codeaurora.org, johan.hedberg@gmail.com,
	marcel@holtmann.org, Inga Stotland <ingas@codeaurora.org>
Subject: [PATCH 1/4] Constants for L2CAP and AMP extensions
Date: Fri, 30 Jul 2010 11:30:23 -0700
Message-Id: <1280514626-22559-2-git-send-email-ingas@codeaurora.org>
In-Reply-To: <1280514626-22559-1-git-send-email-ingas@codeaurora.org>
References: <1280514626-22559-1-git-send-email-ingas@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/l2cap.h |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/lib/l2cap.h b/lib/l2cap.h
index e59cfdd..2f1084c 100644
--- a/lib/l2cap.h
+++ b/lib/l2cap.h
@@ -35,6 +35,8 @@ extern "C" {
 /* L2CAP defaults */
 #define L2CAP_DEFAULT_MTU	672
 #define L2CAP_DEFAULT_FLUSH_TO	0xFFFF
+#define L2CAP_DEFAULT_TX_WINDOW	63
+#define L2CAP_DEFAULT_MAX_TX	3
 
 /* L2CAP socket address */
 struct sockaddr_l2 {
@@ -44,6 +46,12 @@ struct sockaddr_l2 {
 	unsigned short	l2_cid;
 };
 
+/* L2CAP fixed channel CIDs */
+#define L2CAP_SIGNAL_CHAN_CID		0x0001
+#define L2CAP_CONNECTIONLESS_CID	0x0002
+#define L2CAP_AMP_MGR_CID		0x0003
+#define L2CAP_AMP_TEST_CID		0x003F
+
 /* L2CAP socket options */
 #define L2CAP_OPTIONS	0x01
 struct l2cap_options {
@@ -69,6 +77,12 @@ struct l2cap_conninfo {
 #define L2CAP_LM_TRUSTED	0x0008
 #define L2CAP_LM_RELIABLE	0x0010
 #define L2CAP_LM_SECURE		0x0020
+#define L2CAP_LM_FLUSHABLE	0x0040
+
+#define L2CAP_AMP	0x04
+#define L2CAP_AMP_REQUIRE_BR_EDR	0x01
+#define L2CAP_AMP_PREFER_AMP		0x02
+#define L2CAP_AMP_PREFER_BR_EDR	0x03
 
 /* L2CAP command codes */
 #define L2CAP_COMMAND_REJ	0x01
-- 
1.7.2

--
Inga Stotland
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
