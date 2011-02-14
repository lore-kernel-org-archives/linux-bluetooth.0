Return-Path: <cyrus@holtmann.org>
Sender: Vasiliy Kulikov <segooon@gmail.com>
From: Vasiliy Kulikov <segoon@openwall.com>
To: linux-kernel@vger.kernel.org
Cc: security@kernel.org,
	Marcel Holtmann <marcel@holtmann.org> ,
	"Gustavo F. Padovan" <padovan@profusion.mobi> ,
	"David S. Miller" <davem@davemloft.net> ,
	Tejun Heo <tj@kernel.org> ,
	linux-bluetooth@vger.kernel.org ,
	netdev@vger.kernel.org
Subject: [PATCH] bluetooth: bnep: fix buffer overflow
Date: Mon, 14 Feb 2011 13:54:31 +0300
Message-Id: <1297680871-11617-1-git-send-email-segoon@openwall.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Struct ca is copied from userspace.  It is not checked whether the "device"
field is NULL terminated.  This potentially leads to BUG() inside of
alloc_netdev_mqs() and/or information leak by creating a device with a name
made of contents of kernel stack.

Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
---
 Compile tested.

 net/bluetooth/bnep/sock.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/bnep/sock.c b/net/bluetooth/bnep/sock.c
index 2862f53..30faaf1 100644
--- a/net/bluetooth/bnep/sock.c
+++ b/net/bluetooth/bnep/sock.c
@@ -88,6 +88,7 @@ static int bnep_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long
 			sockfd_put(nsock);
 			return -EBADFD;
 		}
+		ca.device[sizeof(ca.device)-1] = 0;
 
 		err = bnep_add_connection(&ca, nsock);
 		if (!err) {
-- 
1.7.0.4
