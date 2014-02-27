Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] Bluetooth: Fix response on confirm_name
Date: Thu, 27 Feb 2014 15:48:07 +0100
Message-ID: <1393512487-25667-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to mgmt-api.txt, in case of confirm name command,
cmd_complete should be always use as a response. Not command status
as it is now for failures.
Using command complete on failure is actually better as client might
be interested in device address for which confirm name failed.

Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
---
 net/bluetooth/mgmt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4c4912e..d3611dc 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3627,15 +3627,15 @@ static int confirm_name(struct sock *sk, struct hci_dev *hdev, void *data,
 	hci_dev_lock(hdev);
 
 	if (!hci_discovery_active(hdev)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_CONFIRM_NAME,
-				 MGMT_STATUS_FAILED);
+		err = cmd_complete(sk, hdev->id, MGMT_OP_CONFIRM_NAME,
+			MGMT_STATUS_FAILED, &cp->addr, sizeof(cp->addr));
 		goto failed;
 	}
 
 	e = hci_inquiry_cache_lookup_unknown(hdev, &cp->addr.bdaddr);
 	if (!e) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_CONFIRM_NAME,
-				 MGMT_STATUS_INVALID_PARAMS);
+		err = cmd_complete(sk, hdev->id, MGMT_OP_CONFIRM_NAME,
+		 MGMT_STATUS_INVALID_PARAMS, &cp->addr, sizeof(cp->addr));
 		goto failed;
 	}
 
-- 
1.8.4

