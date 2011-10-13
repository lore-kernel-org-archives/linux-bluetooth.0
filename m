Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 3/6] Bluetooth: EFS: add efs option in L2CAP conf req
Date: Thu, 13 Oct 2011 16:18:55 +0300
Message-Id: <1318511938-24311-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1318511938-24311-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1318511938-24311-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add Extended Flow Specification option when building L2CAP
Configuration Request. EFS is added if both the local and
remote L2CAP entities have indicated support for the
Extended Flow Specification for BR/EDR.

...
< ACL data: handle 1 flags 0x00 dlen 10
    L2CAP(s): Info req: type 2
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x01f8
        Enhanced Retransmission mode
        Streaming mode
        FCS Option
        Extended Flow Specification
        Fixed Channels
        Extended Window Size
...
< ACL data: handle 1 flags 0x00 dlen 45
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 33
      RFC 0x03 (Enhanced Retransmission, TxWin 63, MaxTx 3, RTo 0, MTo 0, MPS 498)
      EFS (Id 0x01, SerType Best Effort, MaxSDU 0xffff, SDUitime 0xffffffff,
          AccLat 0xffffffff, FlushTO 0x0000ffff)
...

Based upon haijun.liu <haijun.liu@atheros.com> series of patches
(sent Sun, 22 Aug 2010)

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   45 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a73f77e..f5c4bbb 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1884,6 +1884,37 @@ static void l2cap_add_conf_opt(void **ptr, u8 type, u8 len, unsigned long val)
 	*ptr += L2CAP_CONF_OPT_SIZE + len;
 }
 
+static void l2cap_add_opt_efs(void **ptr, struct l2cap_chan *chan)
+{
+	struct l2cap_conf_efs efs;
+
+	switch(chan->mode) {
+	case L2CAP_MODE_ERTM:
+		efs.id		= chan->local_id;
+		efs.stype	= chan->local_stype;
+		efs.msdu	= cpu_to_le16(chan->local_msdu);
+		efs.sdu_itime	= cpu_to_le32(chan->local_sdu_itime);
+		efs.acc_lat	= cpu_to_le32(L2CAP_DEFAULT_ACC_LAT);
+		efs.flush_to	= cpu_to_le32(L2CAP_DEFAULT_FLUSH_TO);
+		break;
+
+	case L2CAP_MODE_STREAMING:
+		efs.id		= 1;
+		efs.stype	= L2CAP_SERV_BESTEFFORT;
+		efs.msdu	= cpu_to_le16(chan->local_msdu);
+		efs.sdu_itime	= cpu_to_le32(chan->local_sdu_itime);
+		efs.acc_lat	= 0;
+		efs.flush_to	= 0;
+		break;
+
+	default:
+		return;
+	}
+
+	l2cap_add_conf_opt(ptr, L2CAP_CONF_EFS, sizeof(efs),
+							(unsigned long) &efs);
+}
+
 static void l2cap_ack_timeout(unsigned long arg)
 {
 	struct l2cap_chan *chan = (void *) arg;
@@ -1935,6 +1966,11 @@ static inline bool __l2cap_ews_supported(struct l2cap_chan *chan)
 	return enable_hs && chan->conn->feat_mask & L2CAP_FEAT_EXT_WINDOW;
 }
 
+static inline bool __l2cap_efs_supported(struct l2cap_chan *chan)
+{
+	return enable_hs && chan->conn->feat_mask & L2CAP_FEAT_EXT_FLOW;
+}
+
 static inline void l2cap_txwin_setup(struct l2cap_chan *chan)
 {
 	if (chan->tx_win > L2CAP_DEFAULT_TX_WINDOW &&
@@ -1967,6 +2003,9 @@ static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data)
 		if (test_bit(CONF_STATE2_DEVICE, &chan->conf_state))
 			break;
 
+		if (__l2cap_efs_supported(chan))
+			set_bit(FLAG_EFS_ENABLE, &chan->flags);
+
 		/* fall through */
 	default:
 		chan->mode = l2cap_select_mode(rfc.mode, chan->conn->feat_mask);
@@ -2014,6 +2053,9 @@ done:
 		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
 							(unsigned long) &rfc);
 
+		if (test_bit(FLAG_EFS_ENABLE, &chan->flags))
+			l2cap_add_opt_efs(&ptr, chan);
+
 		if (!(chan->conn->feat_mask & L2CAP_FEAT_FCS))
 			break;
 
@@ -2044,6 +2086,9 @@ done:
 		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
 							(unsigned long) &rfc);
 
+		if (test_bit(FLAG_EFS_ENABLE, &chan->flags))
+			l2cap_add_opt_efs(&ptr, chan);
+
 		if (!(chan->conn->feat_mask & L2CAP_FEAT_FCS))
 			break;
 
-- 
1.7.4.1

