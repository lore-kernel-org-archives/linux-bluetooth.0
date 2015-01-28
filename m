Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Check for P-256 OOB values in Secure Connections Only mode
Date: Tue, 27 Jan 2015 16:04:33 -0800
Message-Id: <1422403473-3542-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If Secure Connections Only mode has been enabled, the it is important
to check that OOB data for P-256 values is provided. In case it is not,
then tell the remote side that no OOB data is present.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8ed8516b18c7..00c160634e7b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -36,6 +36,9 @@
 #include "amp.h"
 #include "smp.h"
 
+#define ZERO_KEY "\x00\x00\x00\x00\x00\x00\x00\x00" \
+		 "\x00\x00\x00\x00\x00\x00\x00\x00"
+
 /* Handle HCI Event packets */
 
 static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
@@ -3864,6 +3867,16 @@ static u8 bredr_oob_data_present(struct hci_conn *conn)
 	if (!data)
 		return 0x00;
 
+	/* When Secure Connections Only mode is enabled, then the P-256
+	 * values are required. If they are not available, then do not
+	 * declare that OOB data is present.
+	 */
+	if (bredr_sc_enabled(hdev) &&
+	    test_bit(HCI_SC_ONLY, &hdev->dev_flags) &&
+	    (!memcmp(data->rand256, ZERO_KEY, 16) ||
+	     !memcmp(data->hash256, ZERO_KEY, 16)))
+		return 0x00;
+
 	if (conn->out || test_bit(HCI_CONN_REMOTE_OOB, &conn->flags))
 		return 0x01;
 
-- 
2.1.0

