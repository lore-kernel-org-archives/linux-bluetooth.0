Return-Path: <cyrus@holtmann.org>
Date: Fri, 23 Jan 2009 10:41:49 +0100
From: Daniele Venzano <venza@brownhat.org>
To: Kernel Janitors <kernel-janitors@vger.kernel.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: [PATCH] Fix unused variable warning in rfcomm
Message-ID: <20090123094149.GA31218@milesteg.arr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

The following patch fixes a warning generated when compiling rfcomm.c
without CONFIG_BT_RFCOMM_DEBUG.
The warning was:
net/bluetooth/rfcomm/sock.c: In function ‘rfcomm_sock_ioctl’:
net/bluetooth/rfcomm/sock.c:795: warning: unused variable ‘sk’

Patch is against 2.6.28.1

Signed-off-by: Daniele Venzano <venza@brownhat.org>

--- a/net/bluetooth/rfcomm/sock.c	2009-01-23 10:30:34.000000000 +0100
+++ b/net/bluetooth/rfcomm/sock.c	2009-01-23 10:31:25.000000000 +0100
@@ -792,7 +792,9 @@ static int rfcomm_sock_getsockopt(struct
 
 static int rfcomm_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 {
+#ifdef CONFIG_BT_RFCOMM_DEBUG
 	struct sock *sk = sock->sk;
+#endif
 	int err;
 
 	BT_DBG("sk %p cmd %x arg %lx", sk, cmd, arg);
