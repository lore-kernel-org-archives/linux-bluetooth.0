Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix getting SCO socket options in deferred state
Date: Thu,  8 Aug 2013 14:53:56 +0300
Message-Id: <1375962836-3050-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When a socket is in deferred state there does actually exist an
underlying connection even though the connection state is not yet
BT_CONNECTED. In the deferred state it should therefore be allowed to
get socket options that usually depend on a connection, such as
SCO_OPTIONS and SCO_CONNINFO.

This patch fixes the behavior of some user space code that behaves as
follows without it:

$ sudo tools/btiotest -i 00:1B:DC:xx:xx:xx -d -s
accept=2 reject=-1 discon=-1 defer=1 sec=0 update_sec=0 prio=0 voice=0x0000
Listening for SCO connections
bt_io_get(OPT_DEST): getsockopt(SCO_OPTIONS): Transport endpoint is not connected (107)
Accepting connection
Successfully connected to 60:D8:19:xx:xx:xx. handle=43, class=000000

The conditions that the patch updates the if-statements to is taken from
similar code in l2cap_sock.c which correctly handles the deferred state.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/sco.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 1170b6e..96bd388 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -806,7 +806,9 @@ static int sco_sock_getsockopt_old(struct socket *sock, int optname, char __user
 
 	switch (optname) {
 	case SCO_OPTIONS:
-		if (sk->sk_state != BT_CONNECTED) {
+		if (sk->sk_state != BT_CONNECTED &&
+		    !(sk->sk_state == BT_CONNECT2 &&
+		      test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags))) {
 			err = -ENOTCONN;
 			break;
 		}
@@ -822,7 +824,9 @@ static int sco_sock_getsockopt_old(struct socket *sock, int optname, char __user
 		break;
 
 	case SCO_CONNINFO:
-		if (sk->sk_state != BT_CONNECTED) {
+		if (sk->sk_state != BT_CONNECTED &&
+		    !(sk->sk_state == BT_CONNECT2 &&
+		      test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags))) {
 			err = -ENOTCONN;
 			break;
 		}
-- 
1.8.3.1

