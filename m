Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: Fix not sending link key negative reply
Date: Mon,  6 May 2013 16:50:35 +0300
Message-Id: <1367848235-19452-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

If Link Keys are not loaded then HCI_LINK_KEYS is not set
and for HCI Event "Link Key Request" reply is not sent.
--
send as RFC since I did not get why we need this flag really.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_event.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index db58e72..e7de1df 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2611,11 +2611,11 @@ static void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s", hdev->name);
 
-	if (!test_bit(HCI_LINK_KEYS, &hdev->dev_flags))
-		return;
-
 	hci_dev_lock(hdev);
 
+	if (!test_bit(HCI_LINK_KEYS, &hdev->dev_flags))
+		goto not_found;
+
 	key = hci_find_link_key(hdev, &ev->bdaddr);
 	if (!key) {
 		BT_DBG("%s link key not found for %pMR", hdev->name,
-- 
1.8.1.2

