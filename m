Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/9] Bluetooth: Move Extended Inquiry Response defines to hci.h
Date: Thu,  5 Jan 2012 17:16:16 +0200
Message-Id: <1325776582-10314-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1325776582-10314-1-git-send-email-johan.hedberg@gmail.com>
References: <1325776582-10314-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The EIR defines are needed also outside of mgmt.c (e.g. in hci_event.c
to check if EIR data has the complete name) so it's better to have them
in a single public place, i.e. hci.h.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h |   13 +++++++++++++
 net/bluetooth/mgmt.c        |   12 ------------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5b2fed5..ce5133b 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -284,6 +284,19 @@ enum {
 #define HCI_FLOW_CTL_MODE_PACKET_BASED	0x00
 #define HCI_FLOW_CTL_MODE_BLOCK_BASED	0x01
 
+/* Extended Inquiry Response field types */
+#define EIR_FLAGS		0x01 /* flags */
+#define EIR_UUID16_SOME		0x02 /* 16-bit UUID, more available */
+#define EIR_UUID16_ALL		0x03 /* 16-bit UUID, all listed */
+#define EIR_UUID32_SOME		0x04 /* 32-bit UUID, more available */
+#define EIR_UUID32_ALL		0x05 /* 32-bit UUID, all listed */
+#define EIR_UUID128_SOME	0x06 /* 128-bit UUID, more available */
+#define EIR_UUID128_ALL		0x07 /* 128-bit UUID, all listed */
+#define EIR_NAME_SHORT		0x08 /* shortened local name */
+#define EIR_NAME_COMPLETE	0x09 /* complete local name */
+#define EIR_TX_POWER		0x0A /* transmit power level */
+#define EIR_DEVICE_ID		0x10 /* device ID */
+
 /* -----  HCI Commands ---- */
 #define HCI_OP_NOP			0x0000
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index bc8e59d..851cb19 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -303,18 +303,6 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	return settings;
 }
 
-#define EIR_FLAGS		0x01 /* flags */
-#define EIR_UUID16_SOME		0x02 /* 16-bit UUID, more available */
-#define EIR_UUID16_ALL		0x03 /* 16-bit UUID, all listed */
-#define EIR_UUID32_SOME		0x04 /* 32-bit UUID, more available */
-#define EIR_UUID32_ALL		0x05 /* 32-bit UUID, all listed */
-#define EIR_UUID128_SOME	0x06 /* 128-bit UUID, more available */
-#define EIR_UUID128_ALL		0x07 /* 128-bit UUID, all listed */
-#define EIR_NAME_SHORT		0x08 /* shortened local name */
-#define EIR_NAME_COMPLETE	0x09 /* complete local name */
-#define EIR_TX_POWER		0x0A /* transmit power level */
-#define EIR_DEVICE_ID		0x10 /* device ID */
-
 #define PNP_INFO_SVCLASS_ID		0x1200
 
 static u8 bluetooth_base_uuid[] = {
-- 
1.7.7.3

