Return-Path: <cyrus@holtmann.org>
From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
To: 
Cc: tedd.an@intel.com,
	marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH] Bluetooth: Skip the shutdown routine if the interface is not up
Date: Sun, 26 Apr 2015 20:51:50 +0200
Message-Id: <1430074310-3192-1-git-send-email-gabriele.mzt@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Most likely, the shutdown routine requires the interface to be up.
This is the case for BTUSB_INTEL: the routine tries to send a command
to the interface, but since this one is down, it fails and exits once
HCI_INIT_TIMEOUT has expired.

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 net/bluetooth/hci_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 476709b..4663c3d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1557,7 +1557,8 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 {
 	BT_DBG("%s %p", hdev->name, hdev);
 
-	if (!hci_dev_test_flag(hdev, HCI_UNREGISTER)) {
+	if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) &&
+	    test_bit(HCI_UP, &hdev->flags)) {
 		/* Execute vendor specific shutdown routine */
 		if (hdev->shutdown)
 			hdev->shutdown(hdev);
-- 
2.1.4
