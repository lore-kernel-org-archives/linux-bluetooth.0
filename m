Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	gustavo@padovan.org
Cc: sunnyk@codeaurora.org,
	marcel@holtmann.org,
	Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Subject: [PATCH 02/19] Bluetooth: Add L2CAP create channel request handling
Date: Mon, 15 Oct 2012 08:33:51 -0700
Message-Id: <1350315248-7690-3-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1350315248-7690-1-git-send-email-mathewm@codeaurora.org>
References: <1350315248-7690-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

The L2CAP create channel request is very similar to an L2CAP connect
request, but it has an additional parameter for the controller ID.  If
the controller id is 0, the channel is set up on the BR/EDR controller
(just like a connect request).  Using a valid high speed controller ID
will cause the channel to be initially created on that high speed
controller.  While the L2CAP data will be initially routed over the
AMP controller, the L2CAP fixed signaling channel only uses BR/EDR.

When a create channel request is received for a high speed controller,
a pending response is always sent first.  After the high speed
physical and logical links are complete a success response will be
sent.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_core.c | 62 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f8d78f5..73ce337 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3400,8 +3400,9 @@ static inline int l2cap_command_rej(struct l2cap_conn *conn,
 	return 0;
 }
 
-static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
-			  u8 *data, u8 rsp_code, u8 amp_id)
+static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
+					struct l2cap_cmd_hdr *cmd,
+					u8 *data, u8 rsp_code, u8 amp_id)
 {
 	struct l2cap_conn_req *req = (struct l2cap_conn_req *) data;
 	struct l2cap_conn_rsp rsp;
@@ -3452,6 +3453,7 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 	bacpy(&bt_sk(sk)->dst, conn->dst);
 	chan->psm  = psm;
 	chan->dcid = scid;
+	chan->local_amp_id = amp_id;
 
 	__l2cap_chan_add(conn, chan);
 
@@ -3469,8 +3471,16 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 				status = L2CAP_CS_AUTHOR_PEND;
 				chan->ops->defer(chan);
 			} else {
-				__l2cap_state_change(chan, BT_CONFIG);
-				result = L2CAP_CR_SUCCESS;
+				/* Force pending result for AMP controllers.
+				 * The connection will succeed after the
+				 * physical link is up. */
+				if (amp_id) {
+					__l2cap_state_change(chan, BT_CONNECT2);
+					result = L2CAP_CR_PEND;
+				} else {
+					__l2cap_state_change(chan, BT_CONFIG);
+					result = L2CAP_CR_SUCCESS;
+				}
 				status = L2CAP_CS_NO_INFO;
 			}
 		} else {
@@ -3516,6 +3526,8 @@ sendresp:
 			       l2cap_build_conf_req(chan, buf), buf);
 		chan->num_conf_req++;
 	}
+
+	return chan;
 }
 
 static int l2cap_connect_req(struct l2cap_conn *conn,
@@ -4028,12 +4040,12 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn,
 	return 0;
 }
 
-static inline int l2cap_create_channel_req(struct l2cap_conn *conn,
-					   struct l2cap_cmd_hdr *cmd,
-					   u16 cmd_len, void *data)
+static int l2cap_create_channel_req(struct l2cap_conn *conn,
+				    struct l2cap_cmd_hdr *cmd,
+				    u16 cmd_len, void *data)
 {
 	struct l2cap_create_chan_req *req = data;
-	struct l2cap_create_chan_rsp rsp;
+	struct l2cap_chan *chan;
 	u16 psm, scid;
 
 	if (cmd_len != sizeof(*req))
@@ -4047,14 +4059,34 @@ static inline int l2cap_create_channel_req(struct l2cap_conn *conn,
 
 	BT_DBG("psm 0x%2.2x, scid 0x%4.4x, amp_id %d", psm, scid, req->amp_id);
 
-	/* Placeholder: Always reject */
-	rsp.dcid = 0;
-	rsp.scid = cpu_to_le16(scid);
-	rsp.result = __constant_cpu_to_le16(L2CAP_CR_NO_MEM);
-	rsp.status = __constant_cpu_to_le16(L2CAP_CS_NO_INFO);
+	if (req->amp_id) {
+		struct hci_dev *hdev;
 
-	l2cap_send_cmd(conn, cmd->ident, L2CAP_CREATE_CHAN_RSP,
-		       sizeof(rsp), &rsp);
+		/* Validate AMP controller id */
+		hdev = hci_dev_get(req->amp_id);
+		if (!hdev || hdev->dev_type != HCI_AMP ||
+		    !test_bit(HCI_UP, &hdev->flags)) {
+			struct l2cap_create_chan_rsp rsp;
+
+			rsp.dcid = 0;
+			rsp.scid = cpu_to_le16(scid);
+			rsp.result = __constant_cpu_to_le16(L2CAP_CR_BAD_AMP);
+			rsp.status = __constant_cpu_to_le16(L2CAP_CS_NO_INFO);
+
+			l2cap_send_cmd(conn, cmd->ident, L2CAP_CREATE_CHAN_RSP,
+				       sizeof(rsp), &rsp);
+
+			if (hdev)
+				hci_dev_put(hdev);
+
+			return 0;
+		}
+
+		hci_dev_put(hdev);
+	}
+
+	chan = l2cap_connect(conn, cmd, data, L2CAP_CREATE_CHAN_RSP,
+			     req->amp_id);
 
 	return 0;
 }
-- 
1.7.12.3

--
Mat Martineau

Employee of Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
