Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	marcel@holtmann.org
Cc: pkrystad@codeaurora.org
Subject: [PATCHv2] Bluetooth: Send a configuration request after security confirmation
Date: Tue, 22 May 2012 13:55:45 -0700
Message-Id: <1337720145-8019-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Sometimes an ACL link must be raised to a higher security level after
an L2CAP connection is requested, but before a connection response is
sent.  In this case, a connection response sent by L2CAP was not
immediately followed by a configuration request.  Other code paths do
send this configuration request right away.  It was possible for the
connection to time out while L2CAP waited for the remote device (like
PTS) to trigger the configuration process.

This change immediately sends a configuration request after a connect
response rather than waiting for a configuration request from the
remote device.  It fixes connection stalls in a variety of PTS test
cases.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b644f40..14c27f4 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5519,6 +5519,17 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 			rsp.status = cpu_to_le16(stat);
 			l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_RSP,
 							sizeof(rsp), &rsp);
+
+			if (!test_bit(CONF_REQ_SENT, &chan->conf_state) &&
+			    res == L2CAP_CR_SUCCESS) {
+				char buf[128];
+				set_bit(CONF_REQ_SENT, &chan->conf_state);
+				l2cap_send_cmd(conn, l2cap_get_ident(conn),
+					       L2CAP_CONF_REQ,
+					       l2cap_build_conf_req(chan, buf),
+					       buf);
+				chan->num_conf_req++;
+			}
 		}
 
 		l2cap_chan_unlock(chan);
-- 
1.7.10

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
