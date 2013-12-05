Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 01/32] Bluetooth: Remove unnecessary braces from one-line if-statement
Date: Thu,  5 Dec 2013 15:10:59 +0200
Message-Id: <1386249090-10236-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
References: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch is just a trivial coding style fix to remove unnecessary
braces from a one-line if-statement.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 4af3821df880..70be2eb8ed03 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6612,11 +6612,10 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 		}
 
 		if (chan->state == BT_CONNECT) {
-			if (!status) {
+			if (!status)
 				l2cap_start_connection(chan);
-			} else {
+			else
 				__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
-			}
 		} else if (chan->state == BT_CONNECT2) {
 			struct l2cap_conn_rsp rsp;
 			__u16 res, stat;
-- 
1.8.4.2

