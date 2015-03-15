Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix BR/EDR out-of-band pairing with only initiator data
Date: Sun, 15 Mar 2015 16:42:53 -0700
Message-Id: <1426462973-21366-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When only the pairing initiator is providing out-of-band data, then
the receiver side was ignoring the data. For some reason the code was
checking if the initiator has received out-of-band data and only then
also provide the required inidication that the acceptor actually has
the needed data available.

For BR/EDR out-of-band pairing it is enough if one side has received
out-of-band data. There are no extra checks needed here to make this
work smoothly. The only thing that is needed is to tell the controller
if data is present (and if it is P-192 or P-256 or both) and then let
the controller actually figure out the rest.

This means the check for outgoing connection or if the initiator has
indicated data are completely pointless and are in fact actually
causing harm. The check in question is this one:

   if (conn->out || test_bit(HCI_CONN_REMOTE_OOB, &conn->flags)) {

After just taking the conditional check out and always executing the
code for determining the type of out-of-band data, the pairing works
flawlessly and prodcudes authenticated link keys.

The patch itself looks more complicated due to the reformatting of the
indentation, but it essentially just a two-line change.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c | 54 ++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c7376cd42b1c..10d760c46df1 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3889,41 +3889,37 @@ static u8 bredr_oob_data_present(struct hci_conn *conn)
 	if (!data)
 		return 0x00;
 
-	if (conn->out || test_bit(HCI_CONN_REMOTE_OOB, &conn->flags)) {
-		if (bredr_sc_enabled(hdev)) {
-			/* When Secure Connections is enabled, then just
-			 * return the present value stored with the OOB
-			 * data. The stored value contains the right present
-			 * information. However it can only be trusted when
-			 * not in Secure Connection Only mode.
-			 */
-			if (!hci_dev_test_flag(hdev, HCI_SC_ONLY))
-				return data->present;
-
-			/* When Secure Connections Only mode is enabled, then
-			 * the P-256 values are required. If they are not
-			 * available, then do not declare that OOB data is
-			 * present.
-			 */
-			if (!memcmp(data->rand256, ZERO_KEY, 16) ||
-			    !memcmp(data->hash256, ZERO_KEY, 16))
-				return 0x00;
-
-			return 0x02;
-		}
+	if (bredr_sc_enabled(hdev)) {
+		/* When Secure Connections is enabled, then just
+		 * return the present value stored with the OOB
+		 * data. The stored value contains the right present
+		 * information. However it can only be trusted when
+		 * not in Secure Connection Only mode.
+		 */
+		if (!hci_dev_test_flag(hdev, HCI_SC_ONLY))
+			return data->present;
 
-		/* When Secure Connections is not enabled or actually
-		 * not supported by the hardware, then check that if
-		 * P-192 data values are present.
+		/* When Secure Connections Only mode is enabled, then
+		 * the P-256 values are required. If they are not
+		 * available, then do not declare that OOB data is
+		 * present.
 		 */
-		if (!memcmp(data->rand192, ZERO_KEY, 16) ||
-		    !memcmp(data->hash192, ZERO_KEY, 16))
+		if (!memcmp(data->rand256, ZERO_KEY, 16) ||
+		    !memcmp(data->hash256, ZERO_KEY, 16))
 			return 0x00;
 
-		return 0x01;
+		return 0x02;
 	}
 
-	return 0x00;
+	/* When Secure Connections is not enabled or actually
+	 * not supported by the hardware, then check that if
+	 * P-192 data values are present.
+	 */
+	if (!memcmp(data->rand192, ZERO_KEY, 16) ||
+	    !memcmp(data->hash192, ZERO_KEY, 16))
+		return 0x00;
+
+	return 0x01;
 }
 
 static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
-- 
2.1.0

