Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: haijun liu <liuhaijun.er@gmail.com>
Date: Mon, 20 Sep 2010 09:26:14 +0800
Message-ID: <AANLkTim_N7sA6NqmNqWsrW2dQmnwkm-NSGuFz191SQCT@mail.gmail.com>
Subject: [PATCH 1/2] Bluetooth: Remove duplicate code.
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: "dantian.ip" <dantian.ip@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove duplicate code, it's already in l2cap_send_disconn_req().


Signed-off-by: Haijun.Liu <Haijun.Liu@Atheros.com>
---
 net/bluetooth/l2cap.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 725744b..076d1af 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3222,7 +3222,6 @@ static inline int l2cap_config_rsp(struct
l2cap_conn *conn, struct l2cap_cmd_hdr
 		}

 	default:
-		sk->sk_err = ECONNRESET;
 		l2cap_sock_set_timer(sk, HZ * 5);
 		l2cap_send_disconn_req(conn, sk, ECONNRESET);
 		goto done;
-- 
1.6.3.3


-- 
Haijun Liu
