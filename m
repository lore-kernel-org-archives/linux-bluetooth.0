Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Change interleaved discovery behavior
Date: Fri, 24 Feb 2012 11:41:04 -0300
Message-Id: <1330094465-4625-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to last discussion on IRC, if an interleaved discovery is
issued, but the device is not dual mode, we should return error
instead of performing a regular BR/EDR or LE-only discovery.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/mgmt.c |   29 +++++------------------------
 1 file changed, 5 insertions(+), 24 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 07e31f7..8a36e68 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2539,29 +2539,6 @@ unlock:
 	return err;
 }
 
-static int discovery(struct hci_dev *hdev)
-{
-	int err;
-
-	if (lmp_host_le_capable(hdev)) {
-		if (lmp_bredr_capable(hdev)) {
-			err = hci_le_scan(hdev, LE_SCAN_TYPE,
-						LE_SCAN_INT, LE_SCAN_WIN,
-						LE_SCAN_TIMEOUT_BREDR_LE);
-		} else {
-			hdev->discovery.type = DISCOV_TYPE_LE;
-			err = hci_le_scan(hdev, LE_SCAN_TYPE,
-						LE_SCAN_INT, LE_SCAN_WIN,
-						LE_SCAN_TIMEOUT_LE_ONLY);
-		}
-	} else {
-		hdev->discovery.type = DISCOV_TYPE_BREDR;
-		err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR);
-	}
-
-	return err;
-}
-
 int mgmt_interleaved_discovery(struct hci_dev *hdev)
 {
 	int err;
@@ -2631,7 +2608,11 @@ static int start_discovery(struct sock *sk, u16 index,
 		break;
 
 	case DISCOV_TYPE_INTERLEAVED:
-		err = discovery(hdev);
+		if (lmp_host_le_capable(hdev) && lmp_bredr_capable(hdev))
+			err = hci_le_scan(hdev, LE_SCAN_TYPE, LE_SCAN_INT,
+					LE_SCAN_WIN, LE_SCAN_TIMEOUT_BREDR_LE);
+		else
+			err = -ENOTSUPP;
 		break;
 
 	default:
-- 
1.7.9.2

