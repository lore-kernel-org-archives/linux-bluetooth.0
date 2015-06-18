Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v8 06/20] Bluetooth: mgmt: multi adv for get_current_adv_instance()
Date: Thu, 18 Jun 2015 03:16:39 +0200
Message-Id: <1434590213-26599-7-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434590213-26599-1-git-send-email-fgrandel@gmail.com>
References: <1434590213-26599-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434166873-21595-1-git-send-email-fgrandel@gmail.com>
References: <1434166873-21595-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Replaces the hard coded instance identifier in
get_current_adv_instance() with the actual current instance identifier
so that this method is prepared to work with more than one advertising
instance.

Signed-off-by: Florian Grandel <fgrandel@gmail.com>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 49356c7..55b9153 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -841,7 +841,7 @@ static u8 get_current_adv_instance(struct hci_dev *hdev)
 	 */
 	if (hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) &&
 	    !hci_dev_test_flag(hdev, HCI_ADVERTISING))
-		return 0x01;
+		return hdev->cur_adv_instance;
 
 	return 0x00;
 }
-- 
1.9.1

