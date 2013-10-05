Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/10] Bluetooth: Use explicit AMP controller id value for BR/EDR
Date: Sat,  5 Oct 2013 11:47:44 -0700
Message-Id: <1380998869-64411-5-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The special AMP controller id 0 is reserved for the BR/EDR controller
that has the main link. It is a fixed value and so use a constant for
this throughout the code to make it more visible when the handling is
for the BR/EDR channel or when it is for the AMP channel.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h |  2 +-
 net/bluetooth/a2mp.c        |  4 ++--
 net/bluetooth/l2cap_core.c  | 28 ++++++++++++++--------------
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 8e3076e..393eabc 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -64,7 +64,7 @@
 #define HCI_AMP		0x01
 
 /* First BR/EDR Controller shall have ID = 0 */
-#define HCI_BREDR_ID	0
+#define AMP_ID_BREDR	0x00
 
 /* AMP controller types */
 #define AMP_TYPE_BREDR	0x00
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index b2ef3d3..6d62d31 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -77,7 +77,7 @@ u8 __next_ident(struct amp_mgr *mgr)
 
 static inline void __a2mp_cl_bredr(struct a2mp_cl *cl)
 {
-	cl->id = 0;
+	cl->id = AMP_ID_BREDR;
 	cl->type = AMP_TYPE_BREDR;
 	cl->status = 1;
 }
@@ -216,7 +216,7 @@ static int a2mp_discover_rsp(struct amp_mgr *mgr, struct sk_buff *skb,
 		BT_DBG("Remote AMP id %d type %d status %d", cl->id, cl->type,
 		       cl->status);
 
-		if (cl->id != HCI_BREDR_ID && cl->type == HCI_AMP) {
+		if (cl->id != AMP_ID_BREDR && cl->type == HCI_AMP) {
 			struct a2mp_info_req req;
 
 			found = true;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 02dba4e..b0208e2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3046,8 +3046,8 @@ int l2cap_ertm_init(struct l2cap_chan *chan)
 
 	skb_queue_head_init(&chan->tx_q);
 
-	chan->local_amp_id = 0;
-	chan->move_id = 0;
+	chan->local_amp_id = AMP_ID_BREDR;
+	chan->move_id = AMP_ID_BREDR;
 	chan->move_state = L2CAP_MOVE_STABLE;
 	chan->move_role = L2CAP_MOVE_ROLE_NONE;
 
@@ -3100,7 +3100,7 @@ static inline bool __l2cap_efs_supported(struct l2cap_conn *conn)
 static void __l2cap_set_ertm_timeouts(struct l2cap_chan *chan,
 				      struct l2cap_conf_rfc *rfc)
 {
-	if (chan->local_amp_id && chan->hs_hcon) {
+	if (chan->local_amp_id != AMP_ID_BREDR && chan->hs_hcon) {
 		u64 ertm_to = chan->hs_hcon->hdev->amp_be_flush_to;
 
 		/* Class 1 devices have must have ERTM timeouts
@@ -3791,12 +3791,12 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 				 * The connection will succeed after the
 				 * physical link is up.
 				 */
-				if (amp_id) {
-					__l2cap_state_change(chan, BT_CONNECT2);
-					result = L2CAP_CR_PEND;
-				} else {
+				if (amp_id == AMP_ID_BREDR) {
 					__l2cap_state_change(chan, BT_CONFIG);
 					result = L2CAP_CR_SUCCESS;
+				} else {
+					__l2cap_state_change(chan, BT_CONNECT2);
+					result = L2CAP_CR_PEND;
 				}
 				status = L2CAP_CS_NO_INFO;
 			}
@@ -4423,7 +4423,7 @@ static int l2cap_create_channel_req(struct l2cap_conn *conn,
 	BT_DBG("psm 0x%2.2x, scid 0x%4.4x, amp_id %d", psm, scid, req->amp_id);
 
 	/* For controller id 0 make BR/EDR connection */
-	if (req->amp_id == HCI_BREDR_ID) {
+	if (req->amp_id == AMP_ID_BREDR) {
 		l2cap_connect(conn, cmd, data, L2CAP_CREATE_CHAN_RSP,
 			      req->amp_id);
 		return 0;
@@ -4658,7 +4658,7 @@ void l2cap_logical_cfm(struct l2cap_chan *chan, struct hci_chan *hchan,
 
 	if (chan->state != BT_CONNECTED) {
 		/* Ignore logical link if channel is on BR/EDR */
-		if (chan->local_amp_id)
+		if (chan->local_amp_id != AMP_ID_BREDR)
 			l2cap_logical_finish_create(chan, hchan);
 	} else {
 		l2cap_logical_finish_move(chan, hchan);
@@ -4669,7 +4669,7 @@ void l2cap_move_start(struct l2cap_chan *chan)
 {
 	BT_DBG("chan %p", chan);
 
-	if (chan->local_amp_id == HCI_BREDR_ID) {
+	if (chan->local_amp_id == AMP_ID_BREDR) {
 		if (chan->chan_policy != BT_CHANNEL_POLICY_AMP_PREFERRED)
 			return;
 		chan->move_role = L2CAP_MOVE_ROLE_INITIATOR;
@@ -4868,7 +4868,7 @@ static inline int l2cap_move_channel_req(struct l2cap_conn *conn,
 		goto send_move_response;
 	}
 
-	if (req->dest_amp_id) {
+	if (req->dest_amp_id != AMP_ID_BREDR) {
 		struct hci_dev *hdev;
 		hdev = hci_dev_get(req->dest_amp_id);
 		if (!hdev || hdev->dev_type != HCI_AMP ||
@@ -4898,7 +4898,7 @@ static inline int l2cap_move_channel_req(struct l2cap_conn *conn,
 	chan->move_id = req->dest_amp_id;
 	icid = chan->dcid;
 
-	if (!req->dest_amp_id) {
+	if (req->dest_amp_id == AMP_ID_BREDR) {
 		/* Moving to BR/EDR */
 		if (test_bit(CONN_LOCAL_BUSY, &chan->conn_state)) {
 			chan->move_state = L2CAP_MOVE_WAIT_LOCAL_BUSY;
@@ -5090,7 +5090,7 @@ static int l2cap_move_channel_confirm(struct l2cap_conn *conn,
 	if (chan->move_state == L2CAP_MOVE_WAIT_CONFIRM) {
 		if (result == L2CAP_MC_CONFIRMED) {
 			chan->local_amp_id = chan->move_id;
-			if (!chan->local_amp_id)
+			if (chan->local_amp_id == AMP_ID_BREDR)
 				__release_logical_link(chan);
 		} else {
 			chan->move_id = chan->local_amp_id;
@@ -5130,7 +5130,7 @@ static inline int l2cap_move_channel_confirm_rsp(struct l2cap_conn *conn,
 	if (chan->move_state == L2CAP_MOVE_WAIT_CONFIRM_RSP) {
 		chan->local_amp_id = chan->move_id;
 
-		if (!chan->local_amp_id && chan->hs_hchan)
+		if (chan->local_amp_id == AMP_ID_BREDR && chan->hs_hchan)
 			__release_logical_link(chan);
 
 		l2cap_move_done(chan);
-- 
1.8.3.1

