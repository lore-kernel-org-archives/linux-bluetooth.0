Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 03/12] Bluetooth: Return correct L2CAP response type
Date: Wed, 31 Oct 2012 15:46:28 +0200
Message-Id: <1351691197-8394-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1351691197-8394-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350493622.26318.114.camel@aeonflux>
 <1351691197-8394-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Return L2CAP_CREATE_CHAN_RSP for Create Channel Request and
L2CAP_CONN_RSP for Create Connection Request.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_core.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 4ef85d2..d51741f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3478,12 +3478,21 @@ void __l2cap_connect_rsp_defer(struct l2cap_chan *chan)
 	struct l2cap_conn_rsp rsp;
 	struct l2cap_conn *conn = chan->conn;
 	u8 buf[128];
+	u8 rsp_code;
 
 	rsp.scid   = cpu_to_le16(chan->dcid);
 	rsp.dcid   = cpu_to_le16(chan->scid);
 	rsp.result = __constant_cpu_to_le16(L2CAP_CR_SUCCESS);
 	rsp.status = __constant_cpu_to_le16(L2CAP_CS_NO_INFO);
-	l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_RSP, sizeof(rsp), &rsp);
+
+	if (chan->hs_hcon)
+		rsp_code = L2CAP_CREATE_CHAN_RSP;
+	else
+		rsp_code = L2CAP_CONN_RSP;
+
+	BT_DBG("chan %p rsp_code %u", chan, rsp_code);
+
+	l2cap_send_cmd(conn, chan->ident, rsp_code, sizeof(rsp), &rsp);
 
 	if (test_and_set_bit(CONF_REQ_SENT, &chan->conf_state))
 		return;
-- 
1.7.9.5

