Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Default to no security with L2CAP RAW sockets
Date: Mon,  6 Jan 2014 18:27:02 +0200
Message-Id: <1389025622-13891-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1389025622-13891-1-git-send-email-johan.hedberg@gmail.com>
References: <1389025622-13891-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

L2CAP RAW sockets can be used for things which do not involve
establishing actual connection oriented L2CAP channels. One example of
such usage is the l2ping tool. The default security level for L2CAP
sockets is LOW, which implies that for SSP based connection
authentication is still requested (although with no MITM requirement),
which is not what we want (or need) for things like l2ping. Therefore,
default to one lower level, i.e. BT_SECURITY_SDP, for L2CAP RAW sockets
in order not to trigger unwanted authentication requests.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_sock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index e7806e6d282c..20ef748b2906 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -147,6 +147,9 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 		    __le16_to_cpu(la.l2_psm) == L2CAP_PSM_RFCOMM)
 			chan->sec_level = BT_SECURITY_SDP;
 		break;
+	case L2CAP_CHAN_RAW:
+		chan->sec_level = BT_SECURITY_SDP;
+		break;
 	}
 
 	bacpy(&chan->src, &la.l2_bdaddr);
-- 
1.8.4.2

