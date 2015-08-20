Return-Path: <cyrus@holtmann.org>
From: Nicholas Krause <xerofoify@gmail.com>
To: marcel@holtmann.org
Cc: gustavo@padovan.org,
	johan.hedberg@gmail.com,
	davem@davemloft.net,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bluetooth:Fix error handling in the function le_conn_timeout
Date: Thu, 20 Aug 2015 10:17:34 -0400
Message-Id: <1440080254-17521-1-git-send-email-xerofoify@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes error handling in the function le_conn_timeout by
checking if the internal call to the function hci_send_cmd
has failed by returning a error and if so return immediately
to this function's caller as we cannot continue this function's
work after this failed function call.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 net/bluetooth/hci_conn.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 2c48bf0..2d37437 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -420,8 +420,9 @@ static void le_conn_timeout(struct work_struct *work)
 	 */
 	if (conn->role == HCI_ROLE_SLAVE) {
 		u8 enable = 0x00;
-		hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable),
-			     &enable);
+		if (hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable),
+				 &enable))
+			return;
 		hci_le_conn_failed(conn, HCI_ERROR_ADVERTISING_TIMEOUT);
 		return;
 	}
-- 
2.1.4
