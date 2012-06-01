Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove magic disconnect reason
Date: Fri,  1 Jun 2012 16:18:25 +0300
Message-Id: <1338556705-6763-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ffcb04b..165d6c3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2434,7 +2434,7 @@ static void hci_link_tx_to(struct hci_dev *hdev, __u8 type)
 		if (c->type == type && c->sent) {
 			BT_ERR("%s killing stalled connection %s",
 			       hdev->name, batostr(&c->dst));
-			hci_acl_disconn(c, 0x13);
+			hci_acl_disconn(c, HCI_ERROR_REMOTE_USER_TERM);
 		}
 	}
 
-- 
1.7.9.5

