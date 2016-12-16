Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 1/3] Bluetooth: L2CAP: Use l2cap_request_info whenever requesting info
Date: Fri, 16 Dec 2016 14:19:27 +0200
Message-Id: <20161216121929.26476-2-luiz.dentz@gmail.com>
In-Reply-To: <20161216121929.26476-1-luiz.dentz@gmail.com>
References: <20161216121929.26476-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This reduces duplicated code and also ensures L2CAP_INFO_REQ is no sent
twice as l2cap_request_info checks if L2CAP_INFO_FEAT_MASK_REQ_SENT has
been set.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 577f1c0..7718e4a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3872,18 +3872,8 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 	rsp.status = cpu_to_le16(status);
 	l2cap_send_cmd(conn, cmd->ident, rsp_code, sizeof(rsp), &rsp);
 
-	if (result == L2CAP_CR_PEND && status == L2CAP_CS_NO_INFO) {
-		struct l2cap_info_req info;
-		info.type = cpu_to_le16(L2CAP_IT_FEAT_MASK);
-
-		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_SENT;
-		conn->info_ident = l2cap_get_ident(conn);
-
-		schedule_delayed_work(&conn->info_timer, L2CAP_INFO_TIMEOUT);
-
-		l2cap_send_cmd(conn, conn->info_ident, L2CAP_INFO_REQ,
-			       sizeof(info), &info);
-	}
+	if (result == L2CAP_CR_PEND && status == L2CAP_CS_NO_INFO)
+		l2cap_request_info(conn);
 
 	if (chan && !test_bit(CONF_REQ_SENT, &chan->conf_state) &&
 	    result == L2CAP_CR_SUCCESS) {
-- 
2.9.3

