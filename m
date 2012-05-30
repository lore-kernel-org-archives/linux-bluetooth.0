Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Change default MTU for L2CAP ATT channel
Date: Wed, 30 May 2012 15:08:47 -0300
Message-Id: <1338401329-31429-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch changes the default MTU value for L2CAP ATT fixed channel
to L2CAP_DEFAULT_MTU (672 octets).

Differently from others L2CAP channels, in L2CAP ATT fixed channel
there is no MTU negotiation. The MTU value for that channel is up to
the L2CAP implementation. The only restriction in L2CAP spec is the
MTU value must not be less than 23 octets.

At ATT protocol level (on top of L2CAP), we have the ATT_MTU which
defines the maximum size of any ATT message sent between client and
server. GATT profile defines ATT_MTU default value to 23 octets. If
a GATT based profile wants to use ATT_MTU greater than 23 octets
(e.g. HID over GATT profile), it should negotiate a new value by
executing the GATT Exchange MTU sub-procedure.

Thus, in order to support any value of ATT_MTU negotiated at ATT
protocol level, our L2CAP implementation should have L2CAP ATT
fixed channel MTU equal or greater than ATT_MAX_MTU (512 octets).

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/l2cap_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 953ac53..9f513b1 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -449,7 +449,7 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 	case L2CAP_CHAN_CONN_ORIENTED:
 		if (conn->hcon->type == LE_LINK) {
 			/* LE connection */
-			chan->omtu = L2CAP_LE_DEFAULT_MTU;
+			chan->omtu = L2CAP_DEFAULT_MTU;
 			chan->scid = L2CAP_CID_LE_DATA;
 			chan->dcid = L2CAP_CID_LE_DATA;
 		} else {
-- 
1.7.10.2

