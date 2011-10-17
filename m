Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 3/3] Bluetooth: EFS: implement L2CAP config pending state
Date: Mon, 17 Oct 2011 14:35:32 +0300
Message-Id: <1318851332-23700-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1318851332-23700-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1318851332-23700-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add L2CAP Config Pending state for EFS. Currently after receiving
Config Response Pending respond with Config Response Success.

...
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
> ACL data: handle 1 flags 0x02 dlen 45
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 33
      RFC 0x03 (Enhanced Retransmission, TxWin 63, MaxTx 3, RTo 0, MTo 0, MPS 1009)
      EFS (Id 0x01, SerType Best Effort, MaxSDU 0xffff, SDUitime 0xffffffff,
          AccLat 0xffffffff, FlushTO 0x0000ffff)
< ACL data: handle 1 flags 0x00 dlen 45
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 33
      RFC 0x03 (Enhanced Retransmission, TxWin 63, MaxTx 3, RTo 0, MTo 0, MPS 498)
      EFS (Id 0x01, SerType Best Effort, MaxSDU 0xffff, SDUitime 0xffffffff,
          AccLat 0xffffffff, FlushTO 0x0000ffff)
< ACL data: handle 1 flags 0x00 dlen 47
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 4 clen 33
      Pending
      MTU 672
      RFC 0x03 (Enhanced Retransmission, TxWin 63, MaxTx 3, RTo 2000, MTo 12000, MPS 498)
      EFS (Id 0x01, SerType Best Effort, MaxSDU 0xffff, SDUitime 0xffffffff,
          AccLat 0xffffffff, FlushTO 0x0000ffff)
> ACL data: handle 1 flags 0x02 dlen 47
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 4 clen 33
      Pending
      MTU 672
      RFC 0x03 (Enhanced Retransmission, TxWin 63, MaxTx 3, RTo 2000, MTo 12000, MPS 498)
      EFS (Id 0x01, SerType Best Effort, MaxSDU 0xffff, SDUitime 0xffffffff,
          AccLat 0xffffffff, FlushTO 0x0000ffff)
> ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 1 flags 0x00 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 1 flags 0x00 dlen 510
    L2CAP(d): cid 0x0040 len 506 ext_ctrl 0x00010000 fcs 0xebe0 [psm 4113]
      I-frame: Start (len 672) TxSeq 0 ReqSeq 0
...

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    3 ++
 net/bluetooth/l2cap_core.c    |   47 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 49 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 5a0fdc1..f478301 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -253,6 +253,7 @@ struct l2cap_conf_rsp {
 #define L2CAP_CONF_UNACCEPT	0x0001
 #define L2CAP_CONF_REJECT	0x0002
 #define L2CAP_CONF_UNKNOWN	0x0003
+#define L2CAP_CONF_PENDING	0x0004
 #define L2CAP_CONF_EFS_REJECT	0x0005
 
 struct l2cap_conf_opt {
@@ -528,6 +529,8 @@ enum {
 	CONF_NO_FCS_RECV,
 	CONF_STATE2_DEVICE,
 	CONF_EWS_RECV,
+	CONF_LOC_CONF_PEND,
+	CONF_REM_CONF_PEND,
 };
 
 #define L2CAP_CONF_MAX_CONF_REQ 2
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9bc34e4..81f6e81 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2239,6 +2239,11 @@ done:
 				l2cap_add_conf_opt(&ptr, L2CAP_CONF_EFS,
 								sizeof(efs),
 							(unsigned long) &efs);
+			} else {
+				/* Send PENDING Conf Rsp and mark state
+				   local PENDING */
+				result = L2CAP_CONF_PENDING;
+				set_bit(CONF_LOC_CONF_PEND, &chan->conf_state);
 			}
 		}
 
@@ -2393,7 +2398,7 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len, voi
 
 	chan->mode = rfc.mode;
 
-	if (*result == L2CAP_CONF_SUCCESS) {
+	if (*result == L2CAP_CONF_SUCCESS || *result == L2CAP_CONF_PENDING) {
 		switch (rfc.mode) {
 		case L2CAP_MODE_ERTM:
 			chan->retrans_timeout = le16_to_cpu(rfc.retrans_timeout);
@@ -2819,6 +2824,21 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		chan->num_conf_req++;
 	}
 
+	/* Got Conf Rsp PENDING from remote side and asume we sent
+	   Conf Rsp PENDING in the code above */
+	if (test_bit(CONF_REM_CONF_PEND, &chan->conf_state) &&
+			test_bit(CONF_LOC_CONF_PEND, &chan->conf_state)) {
+
+		/* check compatibility */
+
+		clear_bit(CONF_LOC_CONF_PEND, &chan->conf_state);
+		set_bit(CONF_OUTPUT_DONE, &chan->conf_state);
+
+		l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP,
+				l2cap_build_conf_rsp(chan, rsp,
+					L2CAP_CONF_SUCCESS, 0x0000), rsp);
+	}
+
 unlock:
 	bh_unlock_sock(sk);
 	return 0;
@@ -2848,8 +2868,33 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	switch (result) {
 	case L2CAP_CONF_SUCCESS:
 		l2cap_conf_rfc_get(chan, rsp->data, len);
+		clear_bit(CONF_REM_CONF_PEND, &chan->conf_state);
 		break;
 
+	case L2CAP_CONF_PENDING:
+		set_bit(CONF_REM_CONF_PEND, &chan->conf_state);
+
+		if (test_bit(CONF_LOC_CONF_PEND, &chan->conf_state)) {
+			char buf[64];
+
+			len = l2cap_parse_conf_rsp(chan, rsp->data, len,
+								buf, &result);
+			if (len < 0) {
+				l2cap_send_disconn_req(conn, chan, ECONNRESET);
+				goto done;
+			}
+
+			/* check compatibility */
+
+			clear_bit(CONF_LOC_CONF_PEND, &chan->conf_state);
+			set_bit(CONF_OUTPUT_DONE, &chan->conf_state);
+
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

