Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] Bluetooth: Fix reporting invalid RSSI for LE devices
Date: Thu, 22 Jan 2015 16:57:05 +0100
Message-Id: <1421942225-6787-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Start Discovery was reporting 0 RSSI for invalid RSSI only for
BR/EDR devices. LE devices were reported with RSSI 127.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/mgmt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f5c4d2e..a619d98 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7238,7 +7238,8 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	 * However when using service discovery, the value 127 will be
 	 * returned when the RSSI is not available.
 	 */
-	if (rssi == HCI_RSSI_INVALID && !hdev->discovery.report_invalid_rssi)
+	if (rssi == HCI_RSSI_INVALID && !hdev->discovery.report_invalid_rssi &&
+	    link_type == ACL_LINK)
 		rssi = 0;
 
 	bacpy(&ev->addr.bdaddr, bdaddr);
-- 
1.9.3

