Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Change page scan interval in fast connectable mode
Date: Thu, 28 Jun 2012 13:44:30 +0300
Message-Id: <1340880270-15407-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch is based on a user space (hciops) patch which never made it
upstream but does make sense to include in the mgmt part of the kernel.

(User space) commit message from Dmitriy Paliy:
"
Page scan interval in fast connectable mode is changed from 22.5 msec to
160 msec to perform less aggressive page scanning. This is done
accordingly to controller vendor recommendation.

Primary concern is that current parameters 22.5 interval, 11.25 window,
and interleaved scanning occupy whole radio bandwidth. Changing interval
to 160 msec should be sufficient for both speeding up connection
establishment and leaving space for other activities, like inquiry scan,
e.g.
"

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e83368f..5657ecc 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2607,8 +2607,8 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 	if (cp->val) {
 		type = PAGE_SCAN_TYPE_INTERLACED;
 
-		/* 22.5 msec page scan interval */
-		acp.interval = __constant_cpu_to_le16(0x0024);
+		/* 160 msec page scan interval */
+		acp.interval = __constant_cpu_to_le16(0x0100);
 	} else {
 		type = PAGE_SCAN_TYPE_STANDARD;	/* default */
 
-- 
1.7.10.4

