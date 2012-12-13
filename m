Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] Bluetooth: mgmt: Avoid using magic number in status code
Date: Thu, 13 Dec 2012 15:11:21 +0100
Message-ID: <1355407881-22110-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1355407881-22110-1-git-send-email-szymon.janc@tieto.com>
References: <1355407881-22110-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use MGMT_STATUS_SUCCESS for success return code.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/mgmt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 65f9a2d..8752c55 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2257,7 +2257,7 @@ static int add_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 	if (err < 0)
 		status = MGMT_STATUS_FAILED;
 	else
-		status = 0;
+		status = MGMT_STATUS_SUCCESS;
 
 	err = cmd_complete(sk, hdev->id, MGMT_OP_ADD_REMOTE_OOB_DATA, status,
 			   &cp->addr, sizeof(cp->addr));
@@ -2281,7 +2281,7 @@ static int remove_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 	if (err < 0)
 		status = MGMT_STATUS_INVALID_PARAMS;
 	else
-		status = 0;
+		status = MGMT_STATUS_SUCCESS;
 
 	err = cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_REMOTE_OOB_DATA,
 			   status, &cp->addr, sizeof(cp->addr));
@@ -2513,7 +2513,7 @@ static int block_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	if (err < 0)
 		status = MGMT_STATUS_FAILED;
 	else
-		status = 0;
+		status = MGMT_STATUS_SUCCESS;
 
 	err = cmd_complete(sk, hdev->id, MGMT_OP_BLOCK_DEVICE, status,
 			   &cp->addr, sizeof(cp->addr));
@@ -2538,7 +2538,7 @@ static int unblock_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	if (err < 0)
 		status = MGMT_STATUS_INVALID_PARAMS;
 	else
-		status = 0;
+		status = MGMT_STATUS_SUCCESS;
 
 	err = cmd_complete(sk, hdev->id, MGMT_OP_UNBLOCK_DEVICE, status,
 			   &cp->addr, sizeof(cp->addr));
-- 
1.8.0

