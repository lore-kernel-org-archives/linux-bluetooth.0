Return-Path: <cyrus@holtmann.org>
Date: Mon, 13 Feb 2012 16:49:13 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Ulisses Furquim <ulisses@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv4 02/16] Bluetooth: Revert to mutexes from RCU list
Message-ID: <20120213144911.GC19288@aemeltch-MOBL1>
References: <1328882113-19810-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1328882113-19810-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CAA37ikZ7Ph3D_fBMLFQ_rh2JDJY2LXPzKWkLcQEsXutcj1idxA@mail.gmail.com>
 <20120213085841.GB21179@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120213085841.GB21179@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

On Mon, Feb 13, 2012 at 10:58:43AM +0200, Emeltchenko Andrei wrote:
> Hi Ulisses,
> 
> On Fri, Feb 10, 2012 at 04:24:57PM -0200, Ulisses Furquim wrote:
> > Hi Andrei,
> > 
> > On Fri, Feb 10, 2012 at 11:54 AM, Emeltchenko Andrei
> > <Andrei.Emeltchenko.news@gmail.com> wrote:
> > > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > >
> > > Usage of RCU list looks not reasonalbe for a number of reasons:
> > > our code sleep and we have to use socket spinlocks, some parts
> > > of code are updaters thus we need to use mutexes anyway.
> > >
> > > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > No need to lock and unlock conn->chan_lock in l2cap_disconnect_rsp()?
> > This change from RCU to mutexes really should be just one commit IMO.
> 
> I try to add chunks which are not in different patches but then this patch
> would several hundreds lines long. If this OK I just merge them.

I've picked chunks which might come after this patch that are dealing with
locking conn->chan_lock. Please check it below. Do you think it needs to
be merged with "RCU remove" patch?

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c0a35c5..356ce6e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -240,11 +240,13 @@ static void l2cap_chan_timeout(struct work_struct
*work)
 {
 	struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
 							chan_timer.work);
+	struct l2cap_conn *conn = chan->conn;
 	struct sock *sk = chan->sk;
 	int reason;
 
 	BT_DBG("chan %p state %d", chan, chan->state);
 
+	mutex_lock(&conn->chan_lock);
 	lock_sock(sk);
 
 	if (chan->state == BT_CONNECTED || chan->state == BT_CONFIG)
@@ -258,6 +260,7 @@ static void l2cap_chan_timeout(struct work_struct
*work)
 	l2cap_chan_close(chan, reason);
 
 	release_sock(sk);
+	mutex_unlock(&conn->chan_lock);
 
 	chan->ops->close(chan->data);
 	l2cap_chan_put(chan);
@@ -2619,6 +2622,7 @@ static inline int l2cap_connect_req(struct
l2cap_conn *conn, struct l2cap_cmd_hd
 
 	parent = pchan->sk;
 
+	mutex_lock(&conn->chan_lock);
 	lock_sock(parent);
 
 	/* Check if the ACL is secure enough (if not SDP) */
@@ -2692,6 +2696,7 @@ static inline int l2cap_connect_req(struct
l2cap_conn *conn, struct l2cap_cmd_hd
 
 response:
 	release_sock(parent);
+	mutex_unlock(&conn->chan_lock);
 
 sendresp:
 	rsp.scid   = cpu_to_le16(scid);
@@ -2733,6 +2738,7 @@ static inline int l2cap_connect_rsp(struct
l2cap_conn *conn, struct l2cap_cmd_hd
 	struct l2cap_chan *chan;
 	struct sock *sk;
 	u8 req[128];
+	int err;
 
 	scid   = __le16_to_cpu(rsp->scid);
 	dcid   = __le16_to_cpu(rsp->dcid);
@@ -2742,16 +2748,24 @@ static inline int l2cap_connect_rsp(struct
l2cap_conn *conn, struct l2cap_cmd_hd
 	BT_DBG("dcid 0x%4.4x scid 0x%4.4x result 0x%2.2x status 0x%2.2x",
 						dcid, scid, result,
status);
 
+	mutex_lock(&conn->chan_lock);
+
 	if (scid) {
-		chan = l2cap_get_chan_by_scid(conn, scid);
-		if (!chan)
-			return -EFAULT;
+		chan = __l2cap_get_chan_by_scid(conn, scid);
+		if (!chan) {
+			err = -EFAULT;
+			goto unlock;
+		}
 	} else {
-		chan = l2cap_get_chan_by_ident(conn, cmd->ident);
-		if (!chan)
-			return -EFAULT;
+		chan = __l2cap_get_chan_by_ident(conn, cmd->ident);
+		if (!chan) {
+			err = -EFAULT;
+			goto unlock;
+		}
 	}
 
+	err = 0;
+
 	sk = chan->sk;
 
 	switch (result) {
@@ -2779,7 +2793,10 @@ static inline int l2cap_connect_rsp(struct
l2cap_conn *conn, struct l2cap_cmd_hd
 	}
 
 	release_sock(sk);
-	return 0;
+unlock:
+	mutex_unlock(&conn->chan_lock);
+
+	return err;
 }
 
 static inline void set_default_fcs(struct l2cap_chan *chan)
@@ -3025,9 +3042,13 @@ static inline int l2cap_disconnect_req(struct
l2cap_conn *conn, struct l2cap_cmd
 
 	BT_DBG("scid 0x%4.4x dcid 0x%4.4x", scid, dcid);
 
-	chan = l2cap_get_chan_by_scid(conn, dcid);
-	if (!chan)
+	mutex_lock(&conn->chan_lock);
+
+	chan = __l2cap_get_chan_by_scid(conn, dcid);
+	if (!chan) {
+		mutex_unlock(&conn->chan_lock);
 		return 0;
+	}
 
 	sk = chan->sk;
 
@@ -3039,6 +3060,7 @@ static inline int l2cap_disconnect_req(struct
l2cap_conn *conn, struct l2cap_cmd
 
 	l2cap_chan_del(chan, ECONNRESET);
 	release_sock(sk);
+	mutex_unlock(&conn->chan_lock);
 
 	chan->ops->close(chan->data);
 	return 0;
@@ -3056,14 +3078,19 @@ static inline int l2cap_disconnect_rsp(struct
l2cap_conn *conn, struct l2cap_cmd
 
 	BT_DBG("dcid 0x%4.4x scid 0x%4.4x", dcid, scid);
 
-	chan = l2cap_get_chan_by_scid(conn, scid);
-	if (!chan)
+	mutex_lock(&conn->chan_lock);
+
+	chan = __l2cap_get_chan_by_scid(conn, scid);
+	if (!chan) {
+		mutex_unlock(&conn->chan_lock);
 		return 0;
+	}
 
 	sk = chan->sk;
 
 	l2cap_chan_del(chan, 0);
 	release_sock(sk);
+	mutex_unlock(&conn->chan_lock);
 
 	chan->ops->close(chan->data);
 	return 0;
-- 
1.7.8.3


Best regards 
Andrei Emeltchenko 
