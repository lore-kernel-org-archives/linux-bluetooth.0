Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/9] Bluetooth: Remove special handling of ATT in l2cap_security_cfm()
Date: Thu,  7 Aug 2014 22:56:45 +0300
Message-Id: <1407441410-13312-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1407441410-13312-1-git-send-email-johan.hedberg@gmail.com>
References: <1407441410-13312-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

With the update to sk->resume() and __l2cap_no_conn_pending() we
no-longer need to have special handling of ATT channels in the
l2cap_security_cfm() function. The chan->sec_level update when
encryption has been enabled is safe to do for any kind of channel, and
the loop takes later care of calling chan->ready() or chan->resume() if
necessary.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a0a910eb897b..54cbfcd4da44 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7341,15 +7341,8 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 			continue;
 		}
 
-		if (chan->scid == L2CAP_CID_ATT) {
-			if (!status && encrypt) {
-				chan->sec_level = hcon->sec_level;
-				l2cap_chan_ready(chan);
-			}
-
-			l2cap_chan_unlock(chan);
-			continue;
-		}
+		if (!status && encrypt)
+			chan->sec_level = hcon->sec_level;
 
 		if (!__l2cap_no_conn_pending(chan)) {
 			l2cap_chan_unlock(chan);
-- 
1.9.3

