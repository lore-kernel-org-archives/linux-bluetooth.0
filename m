Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Fix check for direct advertising
Date: Tue, 28 Oct 2014 22:23:27 +0100
Message-Id: <1414531407-9785-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1414531407-9785-1-git-send-email-johan.hedberg@gmail.com>
References: <1414531407-9785-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

These days we allow simultaneous LE scanning and advertising. Checking
for whether advertising is enabled or not is therefore not a reliable
way to determine whether directed advertising was used to trigger the
connection creation. The appropriate place to check (instead of the hdev
context) is the connection role that's stored in the hci_conn. This
patch fixes such a check in le_conn_timeout() which could otherwise lead
to incorrect HCI commands being sent.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 74b8e2421e96..96887ae8375b 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -416,7 +416,7 @@ static void le_conn_timeout(struct work_struct *work)
 	 * happen with broken hardware or if low duty cycle was used
 	 * (which doesn't have a timeout of its own).
 	 */
-	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags)) {
+	if (conn->role == HCI_ROLE_SLAVE) {
 		u8 enable = 0x00;
 		hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable),
 			     &enable);
-- 
1.9.3

