Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Fix sending incorrect LE CoC PDU in BT_CONNECT2 state
Date: Mon, 10 Nov 2014 13:24:53 +0200
Message-Id: <1415618695-21363-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1415618695-21363-1-git-send-email-johan.hedberg@gmail.com>
References: <1415618695-21363-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

For LE CoC L2CAP servers we don't do security level elevation during the
BT_CONNECT2 state (instead LE CoC simply sends an immediate error
response if the security level isn't high enough). Therefore if we get a
security level change while an LE CoC channel is in the BT_CONNECT2
state we should simply do nothing.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index fc15174c612c..53af3d98a533 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7329,7 +7329,8 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 				l2cap_start_connection(chan);
 			else
 				__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
-		} else if (chan->state == BT_CONNECT2) {
+		} else if (chan->state == BT_CONNECT2 &&
+			   chan->mode != L2CAP_MODE_LE_FLOWCTL) {
 			struct l2cap_conn_rsp rsp;
 			__u16 res, stat;
 
-- 
2.1.0

