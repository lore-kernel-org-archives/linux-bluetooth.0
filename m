Return-Path: <cyrus@holtmann.org>
From: "Peter Krystad" <pkrystad@codeaurora.org>
To: <linux-bluetooth@vger.kernel.org>, <johan.hedberg@gmail.com>
Subject: FW: [PATCH v3 bluez 1/2] Add L2CAP Create/Move Channel definitions
Date: Wed, 16 Nov 2011 20:24:50 -0800
Message-ID: <004f01cca4e0$da1c2950$8e547bf0$@org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/l2cap.h |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/lib/l2cap.h b/lib/l2cap.h
index 68593d3..6cacc98 100644
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
@@ -226,6 +232,44 @@ typedef struct {
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
 #ifdef __cplusplus
 }
 #endif
-- 
1.7.7

--
Peter Krystad
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

