Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC PATCH v0 3/6] Bluetooth: Add helper function to prepare the EIR
 packet from list
Date: Thu, 24 Jan 2013 11:27:56 +0530
Message-id: <1359007079-11724-4-git-send-email-s.syam@samsung.com>
In-reply-to: <1359007079-11724-1-git-send-email-s.syam@samsung.com>
References: <1359007079-11724-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function is used to prepare the final eir data from the
various list. It returns the updated pointer to the buffer.

Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
Tested-by: Chan-yeol Park <chanyeol.park@samsung.com>
---
 net/bluetooth/mgmt.c |   79 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0f32986..d2569f8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -41,6 +41,11 @@ bool enable_hs;
 #define EIR_TYPE_UUID32 2
 #define EIR_TYPE_UUID128 3
 
+/* UUID128 type */
+typedef struct {
+	u8 data[16];
+} u128;
+
 static const u16 mgmt_commands[] = {
 	MGMT_OP_READ_INDEX_LIST,
 	MGMT_OP_READ_INFO,
@@ -478,6 +483,80 @@ static u16 get_uuid16(u8 *uuid128)
 	return (u16) val;
 }
 
+static u8 *prepare_eir_from_list(u8 *list, u8 *ptr, u16 type, bool truncated)
+{
+	int i;
+	if (type == EIR_TYPE_UUID16) {
+		u8 *length = ptr;
+		u16 *uuid16_list = (u16 *) list;
+
+		/* EIR Data type */
+		ptr[1] = truncated ? EIR_UUID16_SOME : EIR_UUID16_ALL;
+
+		ptr += 2;
+		for (i = 0; uuid16_list[i] != 0; i++) {
+			*ptr++ = (uuid16_list[i] & 0x00ff);
+			*ptr++ = (uuid16_list[i] & 0xff00) >> 8;
+		}
+
+		/* EIR Data length */
+		*length = (i * sizeof(u16)) + 1;
+		return ptr;
+	}
+
+	if (type == EIR_TYPE_UUID32) {
+		u8 *length = ptr;
+		u32 *uuid32_list = (u32 *) list;
+
+		/* EIR Data type */
+		ptr[1] = truncated ? EIR_UUID32_SOME : EIR_UUID32_ALL;
+
+		ptr += 2;
+
+		for (i = 0; uuid32_list[i] != 0; i++) {
+			*ptr++ = (uuid32_list[i] & 0x000000ff);
+			*ptr++ = (uuid32_list[i] & 0x0000ff00) >> 8;
+			*ptr++ = (uuid32_list[i] & 0x00ff0000) >> 16;
+			*ptr++ = (uuid32_list[i] & 0xff000000) >> 24;
+		}
+
+		/* EIR Data length */
+		*length = (i * sizeof(u32)) + 1;
+
+		return ptr;
+	}
+
+	if (type == EIR_TYPE_UUID128) {
+
+		u8 *length = ptr;
+		u128 *uuid128_list = (u128 *) list;
+		u128 u;
+
+		memset(u.data, 0, sizeof(u128));
+		/* EIR Data type */
+		ptr[1] = truncated ? EIR_UUID128_SOME : EIR_UUID128_ALL;
+
+		ptr += 2;
+
+		i = 0;
+		while (memcmp(uuid128_list[i].data, u.data, sizeof(u128))) {
+
+			memcpy(ptr, uuid128_list[i].data, sizeof(u128));
+
+			ptr += sizeof(u128);
+			i++;
+		}
+
+		/* EIR Data length */
+		*length = (i * sizeof(u128)) + 1;
+
+		return ptr;
+
+	}
+
+	return ptr;
+}
+
 static void create_eir(struct hci_dev *hdev, u8 *data)
 {
 	u8 *ptr = data;
-- 
1.7.9.5

