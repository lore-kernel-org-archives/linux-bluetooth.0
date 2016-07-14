Return-Path: <amadeusz.slawinski@tieto.com>
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeusz.slawinski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Gustavo Padovan <gustavo@padovan.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeusz.slawinski@tieto.com>
Subject: [PATCH] Bluetooth: Fix l2cap_sock_setsockopt() with optname BT_RCVMTU
Date: Thu, 14 Jul 2016 10:50:23 +0200
Message-Id: <1468486223-10140-1-git-send-email-amadeusz.slawinski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

When we retrieve imtu value from userspace we should use 16 bit pointer
cast instead of 32 as it's defined that way in headers. Fixes setsockopt
calls on big-endian platforms.

Signed-off-by: Amadeusz Sławiński <amadeusz.slawinski@tieto.com>
---
 net/bluetooth/l2cap_sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 388ee8b..1842141 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -927,7 +927,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (get_user(opt, (u32 __user *) optval)) {
+		if (get_user(opt, (u16 __user *) optval)) {
 			err = -EFAULT;
 			break;
 		}
-- 
1.9.1
