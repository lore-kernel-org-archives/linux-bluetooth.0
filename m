Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Use hci_conn_num() for checking number of LE connections
Date: Thu, 10 Oct 2013 09:47:54 -0700
Message-Id: <1381423675-2207-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When checking for the current number of LE connections, use
hci_conn_num() function instead of a full blown lookup within
the connection hash or direct access of the counters.

In the case of re-enabling advertising, it is more useful to
check for any connection attempt or existing connection.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 2793bfe..9a069b5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3286,7 +3286,7 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 	 * necessary).
 	 */
 	if (!hdev_is_powered(hdev) || val == enabled ||
-	    hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECTED)) {
+	    hci_conn_num(hdev, LE_LINK) > 0) {
 		bool changed = false;
 
 		if (val != test_bit(HCI_ADVERTISING, &hdev->dev_flags)) {
@@ -4683,7 +4683,7 @@ void mgmt_reenable_advertising(struct hci_dev *hdev)
 {
 	struct hci_request req;
 
-	if (hdev->conn_hash.le_num)
+	if (hci_conn_num(hdev, LE_LINK) > 0)
 		return;
 
 	if (!test_bit(HCI_ADVERTISING, &hdev->dev_flags))
-- 
1.8.3.1

