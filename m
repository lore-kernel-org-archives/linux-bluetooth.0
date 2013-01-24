Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC PATCH v0 2/6] Bluetooth: Add helper function to get the uuid type
Date: Thu, 24 Jan 2013 11:27:55 +0530
Message-id: <1359007079-11724-3-git-send-email-s.syam@samsung.com>
In-reply-to: <1359007079-11724-1-git-send-email-s.syam@samsung.com>
References: <1359007079-11724-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function will return the particular uuid type

Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
Tested-by: Chan-yeol Park <chanyeol.park@samsung.com>
---
 net/bluetooth/mgmt.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4fd45a3..0f32986 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -37,6 +37,10 @@ bool enable_hs;
 #define MGMT_VERSION	1
 #define MGMT_REVISION	2
 
+#define EIR_TYPE_UUID16 1
+#define EIR_TYPE_UUID32 2
+#define EIR_TYPE_UUID128 3
+
 static const u16 mgmt_commands[] = {
 	MGMT_OP_READ_INDEX_LIST,
 	MGMT_OP_READ_INFO,
@@ -440,6 +444,23 @@ static u8 bluetooth_base_uuid[] = {
 			0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 };
 
+static int get_uuid_type(u8 *uuid128)
+{
+	u32 val;
+	int i;
+
+	for (i = 0; i < 12; i++) {
+		if (bluetooth_base_uuid[i] != uuid128[i])
+			return EIR_TYPE_UUID128;
+	}
+
+	val = get_unaligned_le32(&uuid128[12]);
+	if (val > 0xffff)
+		return EIR_TYPE_UUID32;
+	else
+		return EIR_TYPE_UUID16;
+}
+
 static u16 get_uuid16(u8 *uuid128)
 {
 	u32 val;
-- 
1.7.9.5

