Return-Path: <cyrus@holtmann.org>
Sender: Vasiliy Kulikov <segooon@gmail.com>
From: Vasiliy Kulikov <segoon@openwall.com>
To: linux-kernel@vger.kernel.org
Cc: security@kernel.org,
	Marcel Holtmann <marcel@holtmann.org> ,
	"Gustavo F. Padovan" <padovan@profusion.mobi> ,
	"David S. Miller" <davem@davemloft.net> ,
	linux-bluetooth@vger.kernel.org ,
	netdev@vger.kernel.org
Subject: [PATCH] bluetooth: l2cap: fix 1 byte infoleak to userspace
Date: Thu, 10 Feb 2011 20:59:42 +0300
Message-Id: <1297360783-21452-1-git-send-email-segoon@openwall.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Structure l2cap_options has one padding byte between max_tx and
txwin_size fields.  This byte in "opts" is copied to userspace
uninitialized.

Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
---
 Compile tested only.

 net/bluetooth/l2cap_sock.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index adf4169..21f5385 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -392,6 +392,7 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname, char __us
 
 	switch (optname) {
 	case L2CAP_OPTIONS:
+		memset(&opts, 0, sizeof(opts));
 		opts.imtu     = l2cap_pi(sk)->imtu;
 		opts.omtu     = l2cap_pi(sk)->omtu;
 		opts.flush_to = l2cap_pi(sk)->flush_to;
-- 
1.7.0.4
