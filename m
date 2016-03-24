Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Patrik Flykt <patrik.flykt@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] bluetooth: Allow setting BT_SECURITY_FIPS with setsockopt
Date: Thu, 24 Mar 2016 16:04:15 +0200
Message-Id: <1458828255-21202-1-git-send-email-patrik.flykt@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Update the security level check to allow setting BT_SECURITY_FIPS for
an L2CAP socket.

Signed-off-by: Patrik Flykt <patrik.flykt@linux.intel.com>
---

This seems to have been forgotten when FIPS was introduced?

     Patrik


 net/bluetooth/l2cap_sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index e4cae72..388ee8b 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -778,7 +778,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 		}
 
 		if (sec.level < BT_SECURITY_LOW ||
-		    sec.level > BT_SECURITY_HIGH) {
+		    sec.level > BT_SECURITY_FIPS) {
 			err = -EINVAL;
 			break;
 		}
-- 
2.1.4

