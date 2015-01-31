Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/2] Bluetooth: Fix OOB data present value for BR/EDR Secure Connections
Date: Fri, 30 Jan 2015 23:20:56 -0800
Message-Id: <1422688856-28619-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When BR/EDR Secure Connections has been enabled, the OOB data present
value can take 2 additional values. The host has to clearly provide
details about if P-192 OOB data, P-256 OOB data or a combination of
P-192 and P-256 OOB data is present.

In case BR/EDR Secure Connections is not enabled or not supported,
then check that P-192 OOB data is actually present and return the
correct value based on that.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 055625b7368f..26a737c835bb 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3881,8 +3881,25 @@ static u8 bredr_oob_data_present(struct hci_conn *conn)
 	     !memcmp(data->hash256, ZERO_KEY, 16)))
 		return 0x00;
 
-	if (conn->out || test_bit(HCI_CONN_REMOTE_OOB, &conn->flags))
+	if (conn->out || test_bit(HCI_CONN_REMOTE_OOB, &conn->flags)) {
+		/* When Secure Connections has been enabled, then just
+		 * return the present value stored with the OOB data. It
+		 * will contain the right information about which data
+		 * is present.
+		 */
+		if (bredr_sc_enabled(hdev))
+			return data->present;
+
+		/* When Secure Connections is not enabled or actually
+		 * not supported by the hardware, then check that if
+		 * P-192 data values are present.
+		 */
+		if (!memcmp(data->rand256, ZERO_KEY, 16) ||
+		    !memcmp(data->hash256, ZERO_KEY, 16))
+			return 0x00;
+
 		return 0x01;
+	}
 
 	return 0x00;
 }
-- 
2.1.0

