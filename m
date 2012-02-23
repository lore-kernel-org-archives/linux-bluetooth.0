Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Check capabilities in BR/EDR and LE-Only discovery
Date: Thu, 23 Feb 2012 18:09:27 -0300
Message-Id: <1330031367-10614-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch add an extra check for BR/EDR and LE-Only discovery.
This way, we are able to return error immediately if the discovery
type requested is not supported by the device.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/mgmt.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 93f2c13..de40918 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2552,12 +2552,18 @@ static int start_discovery(struct sock *sk, u16 index,
 
 	switch (hdev->discovery.type) {
 	case DISCOV_TYPE_BREDR:
-		err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR);
+		if (lmp_bredr_capable(hdev))
+			err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR);
+		else
+			err = -ENOTSUPP;
 		break;
 
 	case DISCOV_TYPE_LE:
-		err = hci_le_scan(hdev, LE_SCAN_TYPE, LE_SCAN_INT,
+		if (lmp_host_le_capable(hdev))
+			err = hci_le_scan(hdev, LE_SCAN_TYPE, LE_SCAN_INT,
 					LE_SCAN_WIN, LE_SCAN_TIMEOUT_LE_ONLY);
+		else
+			err = -ENOTSUPP;
 		break;
 
 	case DISCOV_TYPE_INTERLEAVED:
-- 
1.7.9.2

