Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] Bluetooth: Allow discovery during advertising
Date: Tue, 15 Apr 2014 21:04:11 +0200
Message-Id: <1397588651-13459-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch it is possible to start scan when device does
advertising.

Most of chips do support such state combination, so there is no reason
for blocking it here.
If chip does not support this, kernel should get command status event
with command disallowed status which should not make any problems.

Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
---
 net/bluetooth/mgmt.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 54abbce..57cef73 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3474,13 +3474,6 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 			goto failed;
 		}
 
-		if (test_bit(HCI_ADVERTISING, &hdev->dev_flags)) {
-			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
-					 MGMT_STATUS_REJECTED);
-			mgmt_pending_remove(cmd);
-			goto failed;
-		}
-
 		/* If controller is scanning, it means the background scanning
 		 * is running. Thus, we should temporarily stop it in order to
 		 * set the discovery scanning parameters.
-- 
1.8.4

