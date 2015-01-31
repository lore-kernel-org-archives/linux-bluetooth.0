Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix OOB data present for BR/EDR Secure Connections Only mode
Date: Sat, 31 Jan 2015 13:20:27 -0800
Message-Id: <1422739227-15093-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When using Secure Connections Only mode, then only P-256 OOB data is
valid and should be provided. In case userspace provides P-192 and P-256
OOB data, then the P-192 values will be set to zero. However the present
value of the IO capability exchange still mentioned that both values
would be available. Fix this by telling the controller clearly that only
the P-256 OOB data is present.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index af181f455f6f..1305a22c53b3 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3871,24 +3871,28 @@ static u8 bredr_oob_data_present(struct hci_conn *conn)
 	if (!data)
 		return 0x00;
 
-	/* When Secure Connections Only mode is enabled, then the P-256
-	 * values are required. If they are not available, then do not
-	 * declare that OOB data is present.
-	 */
-	if (bredr_sc_enabled(hdev) &&
-	    test_bit(HCI_SC_ONLY, &hdev->dev_flags) &&
-	    (!memcmp(data->rand256, ZERO_KEY, 16) ||
-	     !memcmp(data->hash256, ZERO_KEY, 16)))
-		return 0x00;
-
 	if (conn->out || test_bit(HCI_CONN_REMOTE_OOB, &conn->flags)) {
-		/* When Secure Connections has been enabled, then just
-		 * return the present value stored with the OOB data. It
-		 * will contain the right information about which data
-		 * is present.
-		 */
-		if (bredr_sc_enabled(hdev))
-			return data->present;
+		if (bredr_sc_enabled(hdev)) {
+			/* When Secure Connections is enabled, then just
+			 * return the present value stored with the OOB
+			 * data. The stored value contains the right present
+			 * information. However it can only be trusted when
+			 * not in Secure Connection Only mode.
+			 */
+			if (!test_bit(HCI_SC_ONLY, &hdev->dev_flags))
+				return data->present;
+
+			/* When Secure Connections Only mode is enabled, then
+			 * the P-256 values are required. If they are not
+			 * available, then do not declare that OOB data is
+			 * present.
+			 */
+			if (!memcmp(data->rand256, ZERO_KEY, 16) ||
+			    !memcmp(data->hash256, ZERO_KEY, 16))
+				return 0x00;
+
+			return 0x02;
+		}
 
 		/* When Secure Connections is not enabled or actually
 		 * not supported by the hardware, then check that if
-- 
2.1.0

