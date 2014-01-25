Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Fix BT_SECURITY socket option for fixed channels (ATT)
Date: Sat, 25 Jan 2014 17:10:07 -0500
Message-Id: <1390687809-14408-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The BT_SECURITY option should also be allowed for fixed channels, so
punch the appropriate hole for it when checking for the channel type.
The main user of fixed CID user space sockets is right now ATT (which is
broken without this patch).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_sock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 3f8e2a223474..588d43b1c18e 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -513,6 +513,7 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 	switch (optname) {
 	case BT_SECURITY:
 		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED &&
+		    chan->chan_type != L2CAP_CHAN_FIXED &&
 		    chan->chan_type != L2CAP_CHAN_RAW) {
 			err = -EINVAL;
 			break;
@@ -769,6 +770,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 	switch (optname) {
 	case BT_SECURITY:
 		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED &&
+		    chan->chan_type != L2CAP_CHAN_FIXED &&
 		    chan->chan_type != L2CAP_CHAN_RAW) {
 			err = -EINVAL;
 			break;
-- 
1.8.5.3

