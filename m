Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@nokia.com>
Subject: [PATCH 2/3] Add initial definitions for Bluetooth Management API
Date: Mon, 20 Sep 2010 14:07:45 +0300
Message-Id: <1284980866-3974-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1284980866-3974-1-git-send-email-johan.hedberg@gmail.com>
References: <1284980866-3974-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

---
 lib/hci.h |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/lib/hci.h b/lib/hci.h
index 512dab9..1ac153f 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -2232,6 +2232,24 @@ typedef struct {
 
 #endif /* _NO_HCI_DEFS */
 
+struct hci_mgmt_hdr {
+	uint16_t opcode;
+	uint16_t len;
+} __packed;
+#define HCI_MGMT_HDR_SIZE	4
+
+#define HCI_MGMT_OP_READ_VERSION	0x0001
+#define HCI_MGMT_OP_READ_FEATURES	0x0002
+#define HCI_MGMT_OP_READ_INDEX_LIST	0x0003
+#define HCI_MGMT_OP_READ_INFO		0x0004
+#define HCI_MGMT_OP_READ_STATISTICS	0x0005
+#define HCI_MGMT_OP_READ_MODE		0x0006
+#define HCI_MGMT_OP_WRITE_MODE		0x0007
+
+#define HCI_MGMT_EV_CMD_COMPLETE	0x0001
+#define HCI_MGMT_EV_CMD_STATUS		0x0002
+#define HCI_MGMT_EV_CONTROLLER_ERROR	0x0003
+
 /* HCI Socket options */
 #define HCI_DATA_DIR	1
 #define HCI_FILTER	2
@@ -2244,9 +2262,12 @@ typedef struct {
 struct sockaddr_hci {
 	sa_family_t	hci_family;
 	unsigned short	hci_dev;
+	unsigned short  hci_channel;
 };
 #define HCI_DEV_NONE	0xffff
 
+#define HCI_CHANNEL_CONTROL 1
+
 struct hci_filter {
 	uint32_t type_mask;
 	uint32_t event_mask[2];
-- 
1.7.0.4

