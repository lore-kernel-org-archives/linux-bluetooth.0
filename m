Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/8] Bluetooth: Fix mgmt_unpair_device command status
Date: Thu,  9 Feb 2012 17:23:49 +0200
Message-Id: <1328801030-24274-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1328801030-24274-1-git-send-email-johan.hedberg@gmail.com>
References: <1328801030-24274-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The default response status to unpair_device should be set as 0 instead
of a generic failure value. When disconnection is not needed (i.e. we
can reply imediately) we should return success and not failure.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5459198..0cf0f4d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1097,7 +1097,6 @@ static int unpair_device(struct sock *sk, u16 index, void *data, u16 len)
 	memset(&rp, 0, sizeof(rp));
 	bacpy(&rp.addr.bdaddr, &cp->addr.bdaddr);
 	rp.addr.type = cp->addr.type;
-	rp.status = MGMT_STATUS_FAILED;
 
 	if (cp->addr.type == MGMT_ADDR_BREDR)
 		err = hci_remove_link_key(hdev, &cp->addr.bdaddr);
-- 
1.7.9

