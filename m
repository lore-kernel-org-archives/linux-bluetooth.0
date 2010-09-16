Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 16 Sep 2010 16:26:25 +0800
Message-ID: <AANLkTi=JEhr6nO7WqBm2=bGrpCxuc6daG_hMGMd_-hxY@mail.gmail.com>
Subject: [PATCH] Bluetooth: Fix bug in l2cap_parse_conf_rsp()
From: haijun liu <liuhaijun.er@gmail.com>
To: linux-bluetooth@vger.kernel.org,
	"dantian.ip" <dantian.ip@gmail.com>,
	Mat Martineau <mathewm@codeaurora.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

 Acording bluetooth spec [Host Volume] chapter, section
 of "7.1.2 Response path", in l2cap_parse_conf_rsp(), MTU should be
 incoming mtu, not outgoing mtu.

Signed-off-by: Haijun.Liu <Haijun.Liu@Atheros.com>
---
 net/bluetooth/l2cap.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 23e487e..1797277 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -2771,10 +2771,10 @@ static int l2cap_parse_conf_rsp(struct sock
*sk, void *rsp, int len, void *data,
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
1.6.3.3
