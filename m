Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/7] Bluetooth: Add definitions for MGMT_OP_START_SERVICE_DISCOVERY
Date: Fri,  5 Dec 2014 10:55:54 +0100
Message-Id: <1417773359-122811-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jakub Pawlowski <jpawlowski@google.com>

This patch adds the opcode and structure for Start Service Discovery
operation.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/mgmt.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 9b382ea34fd9..95c34d5180fa 100644
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
1.9.3

