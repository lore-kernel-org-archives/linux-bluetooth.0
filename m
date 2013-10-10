Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix checking for HCI_SETUP flag when receiving mgmt commands
Date: Thu, 10 Oct 2013 18:06:04 +0200
Message-Id: <1381421164-30749-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When the HCI_SETUP flag is set the controller has not yet been announced
over mgmt and therefore doesn't exist from that perspective. If we
nevertheless get a mgmt command for it we should respond with the
appropriate INVALID_INDEX error.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e7ffd39..7d25d6d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3753,7 +3753,8 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 			goto done;
 		}
 
-		if (test_bit(HCI_USER_CHANNEL, &hdev->dev_flags)) {
+		if (test_bit(HCI_SETUP, &hdev->dev_flags) ||
+		    test_bit(HCI_USER_CHANNEL, &hdev->dev_flags)) {
 			err = cmd_status(sk, index, opcode,
 					 MGMT_STATUS_INVALID_INDEX);
 			goto done;
-- 
1.8.3.1

