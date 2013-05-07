Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2] Bluetooth: Fix not sending link key negative reply
Date: Tue,  7 May 2013 13:51:55 +0300
Message-Id: <1367923915-6421-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <20130507060630.GA3766@x220.ger.corp.intel.com>
References: <20130507060630.GA3766@x220.ger.corp.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

If Link Keys are not loaded during initialization with
MGMT_OP_LOAD_LINK_KEYS command then pairing always fails
since HCI_LINK_KEYS is not set. Check instead for HCI_MGMT
flag.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
*v2 modified patch following Johan's comments

 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index db58e72..e547cfd 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2611,7 +2611,7 @@ static void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s", hdev->name);
 
-	if (!test_bit(HCI_LINK_KEYS, &hdev->dev_flags))
+	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
 		return;
 
 	hci_dev_lock(hdev);
-- 
1.8.1.2

