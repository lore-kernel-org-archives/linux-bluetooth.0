Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>,
        Marko Kiiskila <marko@runtime.io>
Subject: [PATCH] Bluetooth: Fix user channel for 32bit userspace on 64bit kernel
Date: Mon, 24 Apr 2017 18:25:04 -0700
Message-Id: <20170425012504.30505-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Running 32bit userspace on 64bit kernel results in MSG_CMSG_COMPAT being
defined as 0x80000000. This results in sendmsg failure if used from 32bit
userspace running on 64bit kernel. Fix this by accounting for MSG_CMSG_COMPAT
in flags check in hci_sock_sendmsg.

Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
Signed-off-by: Marko Kiiskila <marko@runtime.io>
---
 net/bluetooth/hci_sock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index f64d656..e9d3e1b 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1680,7 +1680,8 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (msg->msg_flags & MSG_OOB)
 		return -EOPNOTSUPP;
 
-	if (msg->msg_flags & ~(MSG_DONTWAIT|MSG_NOSIGNAL|MSG_ERRQUEUE))
+	if (msg->msg_flags &
+		~(MSG_DONTWAIT|MSG_NOSIGNAL|MSG_ERRQUEUE|MSG_CMSG_COMPAT))
 		return -EINVAL;
 
 	if (len < 4 || len > HCI_MAX_FRAME_SIZE)
-- 
2.9.3

