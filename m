Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add HCI command structure for writing current IAC LAP
Date: Tue, 15 Oct 2013 08:34:15 -0700
Message-Id: <1381851255-34399-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch just adds the HCI command structure for configuring the
current IAC LAP setting. The length of the command is variable and
supports more than two IAC. However since there is only general
discoverable and limited discoverable modes, this can be limited
to two possible IACs.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index f4650a8..8b8c3e2 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -824,6 +824,12 @@ struct hci_rp_read_num_supported_iac {
 
 #define HCI_OP_READ_CURRENT_IAC_LAP	0x0c39
 
+#define HCI_OP_WRITE_CURRENT_IAC_LAP	0x0c3a
+struct hci_cp_write_current_iac_lap {
+	__u8	num_iac;
+	__u8	iac_lap[6];
+} __packed;
+
 #define HCI_OP_WRITE_INQUIRY_MODE	0x0c45
 
 #define HCI_MAX_EIR_LENGTH		240
-- 
1.8.3.1

