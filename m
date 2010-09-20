Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: haijun liu <liuhaijun.er@gmail.com>
Date: Mon, 20 Sep 2010 09:33:31 +0800
Message-ID: <AANLkTimQtkORjmsiO3wPULRErNXORBtHATbBvdCEsY27@mail.gmail.com>
Subject: [PATCH 2/2] Bluetooth: Update conf_state before send config_req out.
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: "dantian.ip" <dantian.ip@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Update conf_state with L2CAP_CONF_REQ_SENT before send config_req out.


Signed-off-by: Haijun.Liu <Haijun.Liu@Atheros.com>
---
 net/bluetooth/l2cap.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 076d1af..9d1225d 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3164,6 +3164,7 @@ static inline int l2cap_config_req(struct
l2cap_conn *conn, struct l2cap_cmd_hdr
 		u8 buf[64];
+		l2cap_pi(sk)->conf_state |= L2CAP_CONF_REQ_SENT;
 		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
 					l2cap_build_conf_req(sk, buf), buf);
 		l2cap_pi(sk)->num_conf_req++;
 	}

-- 
1.6.3.3


-- 
Haijun Liu
