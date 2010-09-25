Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
Subject: [PATCH 2/6] Bluetooth: fix MTU L2CAP configuration parameter
Date: Fri, 24 Sep 2010 22:01:40 -0300
Message-Id: <1285376504-3541-3-git-send-email-gustavo@padovan.org>
In-Reply-To: <1285376504-3541-2-git-send-email-gustavo@padovan.org>
References: <1285376504-3541-1-git-send-email-gustavo@padovan.org>
 <1285376504-3541-2-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

When receiving L2CAP negative configuration response with respect
to MTU parameter we modify wrong field. MTU here means proposed
value of MTU that the remote device intends to transmit. So for local
L2CAP socket it is pi->imtu.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
Acked-by: Ville Tervo <ville.tervo@nokia.com>
Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index c784703..9fad312 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -2771,10 +2771,10 @@ static int l2cap_parse_conf_rsp(struct sock *sk, void *rsp, int len, void *data,
 		case L2CAP_CONF_MTU:
 			if (val < L2CAP_DEFAULT_MIN_MTU) {
 				*result = L2CAP_CONF_UNACCEPT;
-				pi->omtu = L2CAP_DEFAULT_MIN_MTU;
+				pi->imtu = L2CAP_DEFAULT_MIN_MTU;
 			} else
-				pi->omtu = val;
-			l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2, pi->omtu);
+				pi->imtu = val;
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2, pi->imtu);
 			break;
 
 		case L2CAP_CONF_FLUSH_TO:
-- 
1.7.2.2

