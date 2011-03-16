Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: Fix missing hci_dev_lock_bh in user_confirm_reply
Date: Wed, 16 Mar 2011 14:29:34 +0200
Message-Id: <1300278577-23068-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

The code was correctly calling _unlock at the end of the function but
there was no actual _lock call anywhere.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 net/bluetooth/mgmt.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0054c74..4476d8e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1230,6 +1230,8 @@ static int user_confirm_reply(struct sock *sk, u16 index, unsigned char *data,
 	if (!hdev)
 		return cmd_status(sk, index, mgmt_op, ENODEV);
 
+	hci_dev_lock_bh(hdev);
+
 	if (!test_bit(HCI_UP, &hdev->flags)) {
 		err = cmd_status(sk, index, mgmt_op, ENETDOWN);
 		goto failed;
-- 
1.7.4.1

