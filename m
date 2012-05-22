Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 May 2012 11:12:07 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, pkrystad@codeaurora.org
Subject: Re: [PATCHv1 16/17] Bluetooth: A2MP: Handling fixed channels
Message-ID: <20120522081205.GB15818@aemeltch-MOBL1>
References: <1337351150-20526-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1337351150-20526-17-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <alpine.DEB.2.02.1205211438590.2239@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1205211438590.2239@mathewm-linux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

Thanks for review,

On Mon, May 21, 2012 at 03:28:57PM -0700, Mat Martineau wrote:
> >@@ -480,7 +487,7 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
> >{
> >	struct sock *sk = chan->sk;
> >	struct l2cap_conn *conn = chan->conn;
> >-	struct sock *parent = bt_sk(sk)->parent;
> >+	struct sock *parent;
> >
> >	__clear_chan_timer(chan);
> >
> >@@ -496,6 +503,9 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
> >		hci_conn_put(conn->hcon);
> >	}
> >
> >+	if (chan->chan_type == L2CAP_CHAN_CONN_FIX_A2MP)
> >+		goto clean;
> >+
> 
> Since this has more to do with socketless channels than A2MP, it
> might be better to do something more generic here like add a
> callback to l2cap_ops so this socket code can be removed from
> l2cap_core rather than worked around.

This can be done. What would be good function name? l2cap_chan_del_cb,
l2cap_chan_unlink ?

The downside is that the code will be used only once ...

> 
> >	lock_sock(sk);
> >
> >	__l2cap_state_change(chan, BT_CLOSED);
> >@@ -504,6 +514,7 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
> >	if (err)
> >		__l2cap_chan_set_err(chan, err);
> >
> >+	parent = bt_sk(sk)->parent;
> >	if (parent) {
> >		bt_accept_unlink(sk);
> >		parent->sk_data_ready(parent, 0);
> >@@ -515,6 +526,7 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
> >	if (test_bit(CONF_NOT_COMPLETE, &chan->conf_state))
> >		return;
> >
> >+clean:
> >	skb_queue_purge(&chan->tx_q);
> >
> >	if (chan->mode == L2CAP_MODE_ERTM) {
> >@@ -992,6 +1004,9 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *c
> >	if (!conn)
> >		return;
> >
> >+	if (chan->chan_type == L2CAP_CHAN_CONN_FIX_A2MP)
> >+		return;
> >+
> 
> There are places in the ERTM state machine that call
> l2cap_send_disconn_req() to tear down an unrecoverable ERTM
> connection.  If the connection remained up, I'm not sure how ERTM
> will behave.

I can rework this part so that in a case of fixed channel we do not send
Disc Req and do not lock sk. So this would adds clearing timers and then
return.

> I don't know that the spec is very clear about what to do when ERTM
> must disconnect the channel, but the channel is fixed.

I think we shall do nothing.

> I think it would be best to tell the owner of the channel (A2MP in
> this case) that the channel has been disconnected using the
> state_change l2cap op, even if no disconnect request is sent to the
> remote device.  This way a new A2MP fixed channel can be started up
> so there is some chance that the two sides of the A2MP ERTM
> connection can sync up again.

I can add state_change and the code would look like:

static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct
l2cap_chan *chan, int err)
{
	struct sock *sk = chan->sk;
	struct l2cap_disconn_req req;

	if (!conn)
		return;

	if (chan->mode == L2CAP_MODE_ERTM) {
		__clear_retrans_timer(chan);
		__clear_monitor_timer(chan);
		__clear_ack_timer(chan);
	}

	if (chan->chan_type == L2CAP_CHAN_CONN_FIX_A2MP) {
		__l2cap_state_change(chan, BT_DISCONN);
		return;
	}

	req.dcid = cpu_to_le16(chan->dcid);
	req.scid = cpu_to_le16(chan->scid);
	l2cap_send_cmd(conn, l2cap_get_ident(conn),
			L2CAP_DISCONN_REQ, sizeof(req), &req);

	lock_sock(sk);
	__l2cap_state_change(chan, BT_DISCONN);
	__l2cap_chan_set_err(chan, err);
	release_sock(sk);
}

Then function might be renamed to l2cap_disconnect_chan()

> >	if (chan->mode == L2CAP_MODE_ERTM) {
> >		__clear_retrans_timer(chan);
> >		__clear_monitor_timer(chan);
> >@@ -1201,6 +1216,11 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
> >
> >		l2cap_chan_lock(chan);
> >
> >+		if (chan->chan_type == L2CAP_CHAN_CONN_FIX_A2MP) {
> >+			l2cap_chan_unlock(chan);
> >+			continue;
> >+		}
> >+
> 
> This bypasses the socket code in that loop, but also means the state
> change is not sent to the AMP manager.  

Yes, but state is already BT_CONNECTED for fixed channel so it does not
need to change.

> Is there a way to fix up the
> state change code in l2cap_ops so the socket code can be removed
> from l2cap_conn_ready and other socketless L2CAP channels will also
> work without special case code?

If we would invoke sk->sk_state_change(sk) each time we call state_change
it would be easily done. Otherwise we might need special ops for
sk_state_change.


> >		if (conn->hcon->type == LE_LINK) {
> >			if (smp_conn_security(conn, chan->sec_level))
> >				l2cap_chan_ready(chan);
> >@@ -1581,7 +1601,8 @@ static void l2cap_monitor_timeout(struct work_struct *work)
> >	l2cap_chan_lock(chan);
> >
> >	if (chan->retry_count >= chan->remote_max_tx) {
> >-		l2cap_send_disconn_req(chan->conn, chan, ECONNABORTED);
> >+		if (chan->chan_type != L2CAP_CHAN_CONN_FIX_A2MP)
> >+			l2cap_send_disconn_req(chan->conn, chan, ECONNABORTED);
> 
> The spec defines the MaxTransmit value as 0xff for the A2MP channel,
> not 0x00 (for infinite retries).  There is therefore an expectation
> that the ERTM connection will reset after too many retries - and I
> don't think it is ok to skip the disconnect here.

I will delete this chunk at all since we already check for fixed channel
in l2cap_send_disconn_req

Best regards 
Andrei Emeltchenko 

