Return-Path: <cyrus@holtmann.org>
Date: Mon, 27 Oct 2014 21:12:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: [PATCH] bluetooth: spelling fixes
Message-ID: <20141027211220.2cef5542@urahara>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

Fix spelling errors in comments.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

--- a/net/bluetooth/hci_core.c	2014-10-06 10:05:06.110702506 -0700
+++ b/net/bluetooth/hci_core.c	2014-10-27 20:38:05.303731745 -0700
@@ -4477,7 +4477,7 @@ int hci_req_run(struct hci_request *req,
 
 	BT_DBG("length %u", skb_queue_len(&req->cmd_q));
 
-	/* If an error occured during request building, remove all HCI
+	/* If an error occurred during request building, remove all HCI
 	 * commands queued on the HCI request queue.
 	 */
 	if (req->err) {
@@ -4546,7 +4546,7 @@ int hci_send_cmd(struct hci_dev *hdev, _
 		return -ENOMEM;
 	}
 
-	/* Stand-alone HCI commands must be flaged as
+	/* Stand-alone HCI commands must be flagged as
 	 * single-command requests.
 	 */
 	bt_cb(skb)->req.start = true;
@@ -4566,7 +4566,7 @@ void hci_req_add_ev(struct hci_request *
 
 	BT_DBG("%s opcode 0x%4.4x plen %d", hdev->name, opcode, plen);
 
-	/* If an error occured during request building, there is no point in
+	/* If an error occurred during request building, there is no point in
 	 * queueing the HCI command. We can simply return.
 	 */
 	if (req->err)
--- a/net/bluetooth/hci_event.c	2014-09-28 16:27:20.641506741 -0700
+++ b/net/bluetooth/hci_event.c	2014-10-27 20:37:29.615852803 -0700
@@ -1045,7 +1045,7 @@ static void hci_cc_le_set_adv_enable(str
 
 	hci_dev_lock(hdev);
 
-	/* If we're doing connection initation as peripheral. Set a
+	/* If we're doing connection initiation as peripheral. Set a
 	 * timeout in case something goes wrong.
 	 */
 	if (*sent) {
--- a/net/bluetooth/hci_sock.c	2014-07-31 11:26:45.986016732 -0700
+++ b/net/bluetooth/hci_sock.c	2014-10-27 20:37:15.439909336 -0700
@@ -987,7 +987,7 @@ static int hci_sock_sendmsg(struct kiocb
 			skb_queue_tail(&hdev->raw_q, skb);
 			queue_work(hdev->workqueue, &hdev->tx_work);
 		} else {
-			/* Stand-alone HCI commands must be flaged as
+			/* Stand-alone HCI commands must be flagged as
 			 * single-command requests.
 			 */
 			bt_cb(skb)->req.start = true;
--- a/net/bluetooth/l2cap_core.c	2014-10-06 10:05:06.110702506 -0700
+++ b/net/bluetooth/l2cap_core.c	2014-10-27 20:38:38.879642783 -0700
@@ -4084,7 +4084,7 @@ static inline int l2cap_config_req(struc
 		chan->num_conf_req++;
 	}
 
-	/* Got Conf Rsp PENDING from remote side and asume we sent
+	/* Got Conf Rsp PENDING from remote side and assume we sent
 	   Conf Rsp PENDING in the code above */
 	if (test_bit(CONF_REM_CONF_PEND, &chan->conf_state) &&
 	    test_bit(CONF_LOC_CONF_PEND, &chan->conf_state)) {
--- a/net/bluetooth/smp.c	2014-10-06 10:05:06.110702506 -0700
+++ b/net/bluetooth/smp.c	2014-10-27 20:37:03.367961578 -0700
@@ -970,7 +970,7 @@ static u8 smp_cmd_pairing_req(struct l2c
 	if (sec_level > conn->hcon->pending_sec_level)
 		conn->hcon->pending_sec_level = sec_level;
 
-	/* If we need MITM check that it can be acheived */
+	/* If we need MITM check that it can be achieved */
 	if (conn->hcon->pending_sec_level >= BT_SECURITY_HIGH) {
 		u8 method;
 
@@ -1028,7 +1028,7 @@ static u8 smp_cmd_pairing_rsp(struct l2c
 
 	auth = rsp->auth_req & AUTH_REQ_MASK;
 
-	/* If we need MITM check that it can be acheived */
+	/* If we need MITM check that it can be achieved */
 	if (conn->hcon->pending_sec_level >= BT_SECURITY_HIGH) {
 		u8 method;
 
