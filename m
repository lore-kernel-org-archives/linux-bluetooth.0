Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [PATCH] core: Fix wrong expectations for the return of recv()
Date: Wed, 10 Aug 2016 19:14:28 -0300
Message-Id: <20160810221428.23951-1-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since commit b5f34f9420b50 "Bluetooth: Fix bt_sock_recvmsg return value"
in the kernel, Bluetooth sockets of type SOCK_SEQPACKET, when read()
will return the size of the packet received, which can be larger than
the the buffer passed by user space.

In this case the problem was causing a disconnection soon after
the reception of an SDP request.

Reported by: Alban Browaeys <prahal@yahoo.com>
---
 src/sdpd-server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/sdpd-server.c b/src/sdpd-server.c
index c863508..b8190da 100644
--- a/src/sdpd-server.c
+++ b/src/sdpd-server.c
@@ -164,7 +164,7 @@ static gboolean io_session_event(GIOChannel *chan, GIOCondition cond, gpointer d
 	}
 
 	len = recv(sk, &hdr, sizeof(sdp_pdu_hdr_t), MSG_PEEK);
-	if (len != sizeof(sdp_pdu_hdr_t)) {
+	if (len < sizeof(sdp_pdu_hdr_t)) {
 		sdp_svcdb_collect_all(sk);
 		return FALSE;
 	}
-- 
2.9.2

