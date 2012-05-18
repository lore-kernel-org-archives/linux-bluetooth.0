Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Define L2CAP conf continuation flag
Date: Fri, 18 May 2012 17:20:06 +0300
Message-Id: <1337350806-20326-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1337350806-20326-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1337350806-20326-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Define Continuation flag which the only flag used from Flags field
in L2CAP Configuration Request and Response.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    4 ++++
 net/bluetooth/l2cap_core.c    |   12 ++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 452fcc4..8fdfaca 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -271,6 +271,10 @@ struct l2cap_conf_rsp {
 #define L2CAP_CONF_PENDING	0x0004
 #define L2CAP_CONF_EFS_REJECT	0x0005
 
+/* conf req/rsp continuation flag */
+#define L2CAP_CONF_FLAG_CONT_CLEARED	0
+#define L2CAP_CONF_FLAG_CONT_SET	1
+
 struct l2cap_conf_opt {
 	__u8       type;
 	__u8       len;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d9f215f..65e56d5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2544,7 +2544,7 @@ done:
 	}
 
 	req->dcid  = cpu_to_le16(chan->dcid);
-	req->flags = cpu_to_le16(0);
+	req->flags = cpu_to_le16(L2CAP_CONF_FLAG_CONT_CLEARED);
 
 	return ptr - data;
 }
@@ -2764,7 +2764,7 @@ done:
 	}
 	rsp->scid   = cpu_to_le16(chan->dcid);
 	rsp->result = cpu_to_le16(result);
-	rsp->flags  = cpu_to_le16(0x0000);
+	rsp->flags  = cpu_to_le16(L2CAP_CONF_FLAG_CONT_CLEARED);
 
 	return ptr - data;
 }
@@ -2863,7 +2863,7 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len, voi
 	}
 
 	req->dcid   = cpu_to_le16(chan->dcid);
-	req->flags  = cpu_to_le16(0x0000);
+	req->flags  = cpu_to_le16(L2CAP_CONF_FLAG_CONT_CLEARED);
 
 	return ptr - data;
 }
@@ -3218,11 +3218,11 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	memcpy(chan->conf_req + chan->conf_len, req->data, len);
 	chan->conf_len += len;
 
-	if (flags & 0x0001) {
+	if (flags & L2CAP_CONF_FLAG_CONT_SET) {
 		/* Incomplete config. Send empty response. */
 		l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP,
 				l2cap_build_conf_rsp(chan, rsp,
-					L2CAP_CONF_SUCCESS, 0x0001), rsp);
+					L2CAP_CONF_SUCCESS, flags), rsp);
 		goto unlock;
 	}
 
@@ -3369,7 +3369,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		goto done;
 	}
 
-	if (flags & 0x01)
+	if (flags & L2CAP_CONF_FLAG_CONT_SET)
 		goto done;
 
 	set_bit(CONF_INPUT_DONE, &chan->conf_state);
-- 
1.7.9.5

