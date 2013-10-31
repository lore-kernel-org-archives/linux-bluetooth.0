Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Store supported commands only during setup procedure
Date: Thu, 31 Oct 2013 04:54:33 -0700
Message-Id: <1383220473-33584-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The list of supported commands of a controller can not change during
its lifetime. So store the list just once during the setup procedure
and not every time the HCI command is executed.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d75d51ff4fdd..4d0f4018df18 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -486,7 +486,10 @@ static void hci_cc_read_local_commands(struct hci_dev *hdev,
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
-	if (!rp->status)
+	if (rp->status)
+		return;
+
+	if (test_bit(HCI_SETUP, &hdev->dev_flags))
 		memcpy(hdev->commands, rp->commands, sizeof(hdev->commands));
 }
 
-- 
1.8.3.1

