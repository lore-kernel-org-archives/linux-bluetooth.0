Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/9] Bluetooth: Fix updating settings when there are no HCI commands to send
Date: Sat, 19 Oct 2013 23:38:19 +0300
Message-Id: <1382215103-6968-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1382215103-6968-1-git-send-email-johan.hedberg@gmail.com>
References: <1382215103-6968-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

It is possible that the Set Connectable management command doesn't cause
any HCI commands to send (such as when BR/EDR is disabled). We can't
just send a response to user space in this case but must also update the
necessary device flags and settings. This patch fixes the issue by using
the recently introduced set_connectable_update_settings function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b74a157..51d0446 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1483,8 +1483,8 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 	if (err < 0) {
 		mgmt_pending_remove(cmd);
 		if (err == -ENODATA)
-			err = send_settings_rsp(sk, MGMT_OP_SET_CONNECTABLE,
-						hdev);
+			err = set_connectable_update_settings(hdev, sk,
+							      cp->val);
 		goto failed;
 	}
 
-- 
1.8.3.1

