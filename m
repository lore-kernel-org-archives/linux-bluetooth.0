Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 2/2] Bluetooth: Power the device up after a rfkill unblock
Date: Wed, 22 Aug 2012 16:33:30 -0300
Message-Id: <1345664010-30471-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1345664010-30471-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1345664010-30471-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With the HCI_SETUP patches, this is all that is needed to make the
case when a adapter is added with Bluetooth blocked in rfkill to work.

When rfkill is unblocked, the device will be powered on, and if not
needed it will be automatically powered off.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/hci_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index fa974a1..395dcc6 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1061,8 +1061,10 @@ static int hci_rfkill_set_block(void *data, bool blocked)
 
 	BT_DBG("%p name %s blocked %d", hdev, hdev->name, blocked);
 
-	if (!blocked)
+	if (!blocked) {
+		schedule_work(&hdev->power_on);
 		return 0;
+	}
 
 	hci_dev_do_close(hdev);
 
-- 
1.7.11.4

