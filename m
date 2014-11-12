Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove unnecessary hci_dev_lock/unlock in smp.c
Date: Wed, 12 Nov 2014 09:17:08 +0200
Message-Id: <1415776628-32562-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The mgmt_user_passkey_request and related functions do not do anything
else except read access to hdev->id. This member never changes after the
hdev creation so there is no need to acquire a lock to read it.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 5fbe91178d35..138279a75583 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -514,8 +514,6 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 		set_bit(SMP_FLAG_TK_VALID, &smp->flags);
 	}
 
-	hci_dev_lock(hcon->hdev);
-
 	if (method == REQ_PASSKEY)
 		ret = mgmt_user_passkey_request(hcon->hdev, &hcon->dst,
 						hcon->type, hcon->dst_type);
@@ -528,8 +526,6 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 						hcon->type, hcon->dst_type,
 						passkey, 0);
 
-	hci_dev_unlock(hcon->hdev);
-
 	return ret;
 }
 
-- 
2.1.0

