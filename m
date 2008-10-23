Return-Path: <cyrus@holtmann.org>
Date: Fri, 24 Oct 2008 03:46:39 +0400
From: Alexander Beregalov <a.beregalov@gmail.com>
To: marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Subject: [PATCH] rfcomm/sock.c: fix warning unused variable
Message-ID: <20081023234639.GC14519@orion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

rfcomm/sock.c:795: warning: unused variable 'sk'

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---

 net/bluetooth/rfcomm/sock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 8a972b6..f35e5de 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -792,7 +792,6 @@ static int rfcomm_sock_getsockopt(struct socket *sock, int level, int optname, c
 
 static int rfcomm_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 {
-	struct sock *sk = sock->sk;
 	int err;
 
 	BT_DBG("sk %p cmd %x arg %lx", sk, cmd, arg);
@@ -801,6 +800,7 @@ static int rfcomm_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned lon
 
 	if (err == -ENOIOCTLCMD) {
 #ifdef CONFIG_BT_RFCOMM_TTY
+		struct sock *sk = sock->sk;
 		lock_sock(sk);
 		err = rfcomm_dev_ioctl(sk, cmd, (void __user *) arg);
 		release_sock(sk);
