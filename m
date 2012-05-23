Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH trivial 2/4] Bluetooth: Define L2CAP conf continuation flag
Date: Wed, 23 May 2012 11:31:21 +0300
Message-Id: <1337761883-3190-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1337761883-3190-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1337761883-3190-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Define Continuation flag which the only flag used from Flags field
in L2CAP Configuration Request and Response.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    3 +++
 net/bluetooth/l2cap_core.c    |   10 +++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 7bc4019..8980cbf 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -271,6 +271,9 @@ struct l2cap_conf_rsp {
 #define L2CAP_CONF_PENDING	0x0004
 #define L2CAP_CONF_EFS_REJECT	0x0005
 
+/* configuration req/rsp continuation flag */
+#define L2CAP_CONF_FLAG_CONTINUATION	0
+
 struct l2cap_conf_opt {
 	__u8       type;
 	__u8       len;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b644f40..75a8b66 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2963,7 +2963,7 @@ done:
 	}
 
 	req->dcid  = cpu_to_le16(chan->dcid);
-	req->flags = cpu_to_le16(0);
+	req->flags = __constant_cpu_to_le16(0);
 
 	return ptr - data;
 }
@@ -3183,7 +3183,7 @@ done:
 	}
 	rsp->scid   = cpu_to_le16(chan->dcid);
 	rsp->result = cpu_to_le16(result);
-	rsp->flags  = cpu_to_le16(0x0000);
+	rsp->flags  = __constant_cpu_to_le16(0);
 
 	return ptr - data;
 }
@@ -3282,7 +3282,7 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len, voi
 	}
 
 	req->dcid   = cpu_to_le16(chan->dcid);
-	req->flags  = cpu_to_le16(0x0000);
+	req->flags  = __constant_cpu_to_le16(0);
 
 	return ptr - data;
 }
@@ -3637,7 +3637,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	memcpy(chan->conf_req + chan->conf_len, req->data, len);
 	chan->conf_len += len;
 
-	if (flags & 0x0001) {
+	if (flags & BIT(L2CAP_CONF_FLAG_CONTINUATION)) {
 		/* Incomplete config. Send empty response. */
 		l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP,
 				l2cap_build_conf_rsp(chan, rsp,
@@ -3788,7 +3788,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		goto done;
 	}
 
-	if (flags & 0x01)
+	if (flags & BIT(L2CAP_CONF_FLAG_CONTINUATION))
 		goto done;
 
 	set_bit(CONF_INPUT_DONE, &chan->conf_state);
-- 
1.7.9.5

