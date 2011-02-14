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
Subject: [PATCH] bluethooth: sco: fix information leak to userspace
Date: Mon, 14 Feb 2011 13:54:26 +0300
Message-Id: <1297680867-11551-1-git-send-email-segoon@openwall.com>
List-ID: <linux-bluetooth.vger.kernel.org>

struct sco_conninfo has one padding byte in the end.  Local variable
cinfo of type sco_conninfo is copied to userspace with this uninizialized
one byte, leading to old stack contents leak.

Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
---
 Compile tested.

 net/bluetooth/sco.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 960c6d1..926ed39 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -703,6 +703,7 @@ static int sco_sock_getsockopt_old(struct socket *sock, int optname, char __user
 			break;
 		}
 
+		memset(&cinfo, 0, sizeof(cinfo));
 		cinfo.hci_handle = sco_pi(sk)->conn->hcon->handle;
 		memcpy(cinfo.dev_class, sco_pi(sk)->conn->hcon->dev_class, 3);
 
-- 
1.7.0.4
