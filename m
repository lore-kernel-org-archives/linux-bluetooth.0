Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/8] Bluetooth: Fix missing command complete event for mgmt_confirm_name
Date: Wed,  9 Jan 2013 15:29:33 +0200
Message-Id: <1357738180-4128-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1357738180-4128-1-git-send-email-johan.hedberg@gmail.com>
References: <1357738180-4128-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

All management commands are expected to indicate successful completion
through a command complete event however the confirm name command was
missing it. This patch add the sending of the missing event.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f559b96..3bcb63e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2510,7 +2510,8 @@ static int confirm_name(struct sock *sk, struct hci_dev *hdev, void *data,
 		hci_inquiry_cache_update_resolve(hdev, e);
 	}
 
-	err = 0;
+	err = cmd_complete(sk, hdev->id, MGMT_OP_CONFIRM_NAME, 0, &cp->addr,
+			   sizeof(cp->addr));
 
 failed:
 	hci_dev_unlock(hdev);
-- 
1.7.10.4

