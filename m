Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2] Bluetooth: Power the device up after a rfkill unblock
Date: Mon, 14 Jan 2013 11:20:27 -0300
Message-Id: <1358173227-5384-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With the HCI_SETUP patches, this is all that is needed to make the
case when a adapter is added with Bluetooth blocked in rfkill to work.

When rfkill is unblocked, the device will be powered on if the device
is in HCI_SETUP state, meaning that it was never properly initialized.
If the device is not used by userspace, the HCI_AUTO_OFF flag will
take care of powering it off.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---

Samuel on IRC caused me to remember this. Thanks :-)


 net/bluetooth/hci_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 596660d..9796c0a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1124,8 +1124,11 @@ static int hci_rfkill_set_block(void *data, bool blocked)
 
 	BT_DBG("%p name %s blocked %d", hdev, hdev->name, blocked);
 
-	if (!blocked)
+	if (!blocked) {
+		if (test_bit(HCI_SETUP, &hdev->dev_flags))
+			schedule_work(&hdev->power_on);
 		return 0;
+	}
 
 	hci_dev_do_close(hdev);
 
-- 
1.8.1

