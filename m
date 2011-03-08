Return-Path: <cyrus@holtmann.org>
From: "Ferraton, Jean RegisX" <jean.regisx.ferraton@intel.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>,
	"xiaosuo@gmail.com" <xiaosuo@gmail.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Date: Tue, 8 Mar 2011 10:10:10 +0000
Subject: [PATCH] Fix "possible circular locking dependency" in rfcomm
Message-ID: <6E42A1B4DD2F7B4D80A1F26BB498BF9F8C9F86D162@irsmsx501.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Changes in sock.c in function __rfcomm_sock_close, to release sock before c=
alling rfcomm_dlc_close to avoid possible deadlock when calling rfcomm_lock=
 (in rfcomm_dlc_close).

Signed-off-by: Jean Regis Ferraton <jrferraton@gmail.com>

---
 net/bluetooth/rfcomm/sock.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 66cc1f0..3b5ec09 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -234,7 +234,10 @@ static void __rfcomm_sock_close(struct sock *sk)
 	case BT_CONNECT2:
 	case BT_CONFIG:
 	case BT_CONNECTED:
+		/* release_sock to avoid deadlock when calling rfcomm_lock() */
+		release_sock(sk);
 		rfcomm_dlc_close(d, 0);
+		lock_sock(sk);
=20
 	default:
 		sock_set_flag(sk, SOCK_ZAPPED);
--=20
1.6.2.5

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris,=20
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
