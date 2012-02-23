Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: mgmt: Fix return value of add/remove_uuid
Date: Thu, 23 Feb 2012 16:03:01 +0200
Message-Id: <1330005781-8185-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1330005781-8185-1-git-send-email-johan.hedberg@gmail.com>
References: <1330005781-8185-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The Add/Remove UUID commands should return the device class instead of
an empty parameter list.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4e48894..000abc0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1367,7 +1367,7 @@ static int add_uuid(struct sock *sk, u16 index, void *data, u16 len)
 	if (err < 0)
 		goto failed;
 
-	err = cmd_complete(sk, index, MGMT_OP_ADD_UUID, 0, NULL, 0);
+	err = cmd_complete(sk, index, MGMT_OP_ADD_UUID, 0, hdev->dev_class, 3);
 
 failed:
 	hci_dev_unlock(hdev);
@@ -1428,7 +1428,8 @@ static int remove_uuid(struct sock *sk, u16 index, void *data, u16 len)
 	if (err < 0)
 		goto unlock;
 
-	err = cmd_complete(sk, index, MGMT_OP_REMOVE_UUID, 0, NULL, 0);
+	err = cmd_complete(sk, index, MGMT_OP_REMOVE_UUID, 0,
+							hdev->dev_class, 3);
 
 unlock:
 	hci_dev_unlock(hdev);
-- 
1.7.9

