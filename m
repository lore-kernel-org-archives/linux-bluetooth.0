Return-Path: <netdev-owner@vger.kernel.org>
Date: Fri, 30 Mar 2018 16:05:06 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] Bluetooth: Mark expected switch fall-throughs
Message-ID: <20180330210506.GA20604@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/bluetooth/mgmt.c        | 1 +
 net/bluetooth/rfcomm/sock.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6e9fc86..8a80d48 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4801,6 +4801,7 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 		case MGMT_LTK_P256_DEBUG:
 			authenticated = 0x00;
 			type = SMP_LTK_P256_DEBUG;
+			/* fall through */
 		default:
 			continue;
 		}
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 93a3b21..d606e92 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -221,6 +221,7 @@ static void __rfcomm_sock_close(struct sock *sk)
 	case BT_CONFIG:
 	case BT_CONNECTED:
 		rfcomm_dlc_close(d, 0);
+		/* fall through */
 
 	default:
 		sock_set_flag(sk, SOCK_ZAPPED);
-- 
2.7.4
