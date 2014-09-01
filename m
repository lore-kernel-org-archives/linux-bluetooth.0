Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Add clarifying comment for LE CoC result value
Date: Mon,  1 Sep 2014 09:45:03 +0300
Message-Id: <1409553903-25260-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1409553903-25260-1-git-send-email-johan.hedberg@gmail.com>
References: <1409553903-25260-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The "pending" L2CAP response value is not defined for LE CoC. This patch
adds a clarifying comment to the code so that the reader will not think
there is a bug in trying to use this value for LE CoC.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 2d9a2b58d2c8..ab405f0e53cb 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5413,6 +5413,11 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 
 	if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
 		l2cap_state_change(chan, BT_CONNECT2);
+		/* The following result value is actually not defined
+		 * for LE CoC but we use it to let the function know
+		 * that it should bail out after doing its cleanup
+		 * instead of sending a response.
+		 */
 		result = L2CAP_CR_PEND;
 		chan->ops->defer(chan);
 	} else {
-- 
1.9.3

