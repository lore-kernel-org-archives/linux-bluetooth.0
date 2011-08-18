Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 7/7] Bluetooth: EFS: parse l2cap config rsp pending
Date: Thu, 18 Aug 2011 10:45:02 +0300
Message-Id: <1313653502-6303-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1313653502-6303-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1313653502-6303-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add parsing for L2CAP pending response for EFS. Currently
respond with success when we receive both configuration responses
pending.
---
 net/bluetooth/l2cap_core.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f3663ac..de9995d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2765,6 +2765,15 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		chan->num_conf_req++;
 	}
 
+	if (test_bit(CONF_REMOTE_PEND, &chan->conf_state)) {
+		/* check compatibility */
+		clear_bit(CONF_LOCAL_PEND, &chan->conf_state);
+		set_bit(CONF_OUTPUT_DONE, &chan->conf_state);
+		l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP,
+				l2cap_build_conf_rsp(chan, rsp,
+					L2CAP_CONF_SUCCESS, 0x0000), rsp);
+	}
+
 unlock:
 	bh_unlock_sock(sk);
 	return 0;
@@ -2794,8 +2803,31 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	switch (result) {
 	case L2CAP_CONF_SUCCESS:
 		l2cap_conf_rfc_get(chan, rsp->data, len);
+		clear_bit(CONF_REMOTE_PEND, &chan->conf_state);
 		break;
 
+	case L2CAP_CONF_PENDING:
+		set_bit(CONF_REMOTE_PEND, &chan->conf_state);
+
+		if (test_bit(CONF_LOCAL_PEND, &chan->conf_state)) {
+			char buf[64];
+
+			len = l2cap_parse_conf_rsp(chan, rsp->data, len,
+					buf, &result);
+			if (len < 0) {
+				l2cap_send_disconn_req(conn, chan, ECONNRESET);
+				goto done;
+			}
+
+			/* check compatibility */
+			clear_bit(CONF_LOCAL_PEND, &chan->conf_state);
+			set_bit(CONF_OUTPUT_DONE, &chan->conf_state);
+			l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP,
+					l2cap_build_conf_rsp(chan, buf,
+						L2CAP_CONF_SUCCESS, 0x0000), buf);
+		}
+		goto done;
+
 	case L2CAP_CONF_UNACCEPT:
 		if (chan->num_conf_rsp <= L2CAP_CONF_MAX_CONF_RSP) {
 			char req[64];
-- 
1.7.4.1

