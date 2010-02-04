Return-Path: <cyrus@holtmann.org>
From: Nick Pelly <npelly@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Nick Pelly <npelly@google.com>
Subject: [PATCH] Bluetooth: Do not call rfcomm_session_put() due to RFCOMM UA on closed socket.
Date: Wed,  3 Feb 2010 16:18:36 -0800
Message-Id: <1265242716-68978-1-git-send-email-npelly@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Processing a RFCOMM UA frame when the socket is closed and we were not the
RFCOMM initiator would cause rfcomm_session_put() to be called twice during
rfcomm_process_rx(). This would cause a kernel panic in rfcomm_session_close.

This could be easily reproduced during disconnect with devices such as
Motorola H270 that send RFCOMM UA followed quickly by L2CAP disconnect request.
This hcidump for this looks like:

2009-09-21 17:22:37.788895 < ACL data: handle 1 flags 0x02 dlen 8
   L2CAP(d): cid 0x0041 len 4 [psm 3]
     RFCOMM(s): DISC: cr 0 dlci 20 pf 1 ilen 0 fcs 0x7d
2009-09-21 17:22:37.906204 > HCI Event: Number of Completed Packets (0x13)
plen 5
   handle 1 packets 1
2009-09-21 17:22:37.933090 > ACL data: handle 1 flags 0x02 dlen 8
   L2CAP(d): cid 0x0040 len 4 [psm 3]
     RFCOMM(s): UA: cr 0 dlci 20 pf 1 ilen 0 fcs 0x57
2009-09-21 17:22:38.636764 < ACL data: handle 1 flags 0x02 dlen 8
   L2CAP(d): cid 0x0041 len 4 [psm 3]
     RFCOMM(s): DISC: cr 0 dlci 0 pf 1 ilen 0 fcs 0x9c
2009-09-21 17:22:38.744125 > HCI Event: Number of Completed Packets (0x13)
plen 5
   handle 1 packets 1
2009-09-21 17:22:38.763687 > ACL data: handle 1 flags 0x02 dlen 8
   L2CAP(d): cid 0x0040 len 4 [psm 3]
     RFCOMM(s): UA: cr 0 dlci 0 pf 1 ilen 0 fcs 0xb6
2009-09-21 17:22:38.783554 > ACL data: handle 1 flags 0x02 dlen 12
   L2CAP(s): Disconn req: dcid 0x0040 scid 0x0041

Avoid calling rfcomm_session_put() twice by skipping this call
in rfcomm_recv_ua() if the socket is closed.

Signed-off-by: Nick Pelly <npelly@google.com>
---
 net/bluetooth/rfcomm/core.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 25692bc..950d95c 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1148,7 +1148,11 @@ static int rfcomm_recv_ua(struct rfcomm_session *s, u8 dlci)
 			break;
 
 		case BT_DISCONN:
-			rfcomm_session_put(s);
+			/* When socket is closed and we are not RFCOMM
+			 * initiator rfcomm_process_rx already calls
+			 * rfcomm_session_put() */
+			if (s->sock->sk->sk_state != BT_CLOSED)
+				rfcomm_session_put(s);
 			break;
 		}
 	}
-- 
1.6.5.3

