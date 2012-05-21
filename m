Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 3/3] Bluetooth: Preserve flags values
Date: Mon, 21 May 2012 15:11:00 +0300
Message-Id: <1337602260-30458-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1337602260-30458-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1337350806-20326-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1337602260-30458-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Previous callers of l2cap_build_conf_rsp in l2cap_config_req use
flags instead of continuation flag hardcoded value. It does not change
logic and preserve future possible flags.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 944c139..cb817a0 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3660,7 +3660,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		/* Incomplete config. Send empty response. */
 		l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP,
 				l2cap_build_conf_rsp(chan, rsp,
-					L2CAP_CONF_SUCCESS, 0x0001), rsp);
+					L2CAP_CONF_SUCCESS, flags), rsp);
 		goto unlock;
 	}
 
@@ -3716,7 +3716,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 
 		l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP,
 					l2cap_build_conf_rsp(chan, rsp,
-					L2CAP_CONF_SUCCESS, 0x0000), rsp);
+					L2CAP_CONF_SUCCESS, flags), rsp);
 	}
 
 unlock:
-- 
1.7.9.5

