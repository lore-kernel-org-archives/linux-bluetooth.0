Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [RFC v3 2/6] Bluetooth: Add definitions for MGMT_OP_START_SERVICE_DISCOVERY
Date: Thu,  4 Dec 2014 12:22:48 -0800
Message-Id: <1417724573-28561-2-git-send-email-jpawlowski@google.com>
In-Reply-To: <1417724573-28561-1-git-send-email-jpawlowski@google.com>
References: <1417724573-28561-1-git-send-email-jpawlowski@google.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the opcode and structure for Start Service Discovery
operation.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/mgmt.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 9b382ea..95c34d5 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -498,6 +498,15 @@ struct mgmt_cp_set_public_address {
 } __packed;
 #define MGMT_SET_PUBLIC_ADDRESS_SIZE	6
 
+#define MGMT_OP_START_SERVICE_DISCOVERY	0x003A
+struct mgmt_cp_start_service_discovery {
+	__u8 type;
+	__s8 rssi;
+	__le16 uuid_count;
+	__u8 uuids[0][16];
+} __packed;
+#define MGMT_START_SERVICE_DISCOVERY_SIZE 4
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
-- 
2.2.0.rc0.207.ga3a616c
