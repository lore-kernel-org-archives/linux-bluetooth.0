Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Jul 2012 14:10:00 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv1 1/2] Bluetooth: Add refcnt to l2cap_conn
Message-ID: <20120725110958.GD2056@aemeltch-MOBL1>
References: <1340978315-4700-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1342181266-26323-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1342181266-26323-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120724232617.GM20029@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120724232617.GM20029@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, Jul 24, 2012 at 08:26:18PM -0300, Gustavo Padovan wrote:
...
> > +static int l2cap_conn_put(struct l2cap_conn *conn)
> > +{
> > +	/* conn might be NULL, was checked before in l2cap_conn_del */
> > +	if (!conn) {
> > +		BT_DBG("conn == NULL");
> > +		return 1;
> 
> 1? What does that mean?

this would mean that conn == NULL but I will make this function void.

> > +	}
> > +
> > +	BT_DBG("conn %p orig refcnt %d", conn,
> > +	       atomic_read(&conn->kref.refcount));
> > +
> > +	return kref_put(&conn->kref, &l2cap_conn_destroy);
> > +}
> > +
> > +void l2cap_conn_set_timer(struct l2cap_conn *conn, struct delayed_work *work,
> > +			  long timeout)
> > +{
> > +	BT_DBG("conn %p timeout %ld", conn, timeout);
> > +
> > +	/* If delayed work cancelled do not hold(conn)
> > +	   since it is already done with previous set_timer */
> > +	if (!cancel_delayed_work(work))
> > +		l2cap_conn_get(conn);
> > +
> > +	schedule_delayed_work(work, timeout);
> > +}
> > +
> > +bool l2cap_conn_clear_timer(struct l2cap_conn *conn, struct delayed_work *work)
> > +{
> > +	bool ret;
> > +
> > +	BT_DBG("conn %p", conn);
> > +
> > +	/* put(conn) if delayed work cancelled otherwise it
> > +	   is done in delayed work function */
> > +	ret = cancel_delayed_work(work);
> > +	if (ret)
> > +		l2cap_conn_put(conn);
> > +
> > +	return ret;
> > +}
> >  
> >  /* ---- L2CAP channels ---- */
> >  
> > @@ -976,7 +1038,8 @@ static void l2cap_do_start(struct l2cap_chan *chan)
> >  		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_SENT;
> >  		conn->info_ident = l2cap_get_ident(conn);
> >  
> > -		schedule_delayed_work(&conn->info_timer, L2CAP_INFO_TIMEOUT);
> > +		l2cap_conn_set_timer(conn, &conn->info_timer,
> > +				     L2CAP_INFO_TIMEOUT);
> >  
> >  		l2cap_send_cmd(conn, conn->info_ident,
> >  					L2CAP_INFO_REQ, sizeof(req), &req);
> > @@ -1258,12 +1321,14 @@ static void l2cap_conn_unreliable(struct l2cap_conn *conn, int err)
> >  static void l2cap_info_timeout(struct work_struct *work)
> >  {
> >  	struct l2cap_conn *conn = container_of(work, struct l2cap_conn,
> > -							info_timer.work);
> > +					       info_timer.work);
> >  
> >  	conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_DONE;
> >  	conn->info_ident = 0;
> >  
> >  	l2cap_conn_start(conn);
> > +
> > +	l2cap_conn_put(conn);
> >  }
> >  
> >  static void l2cap_conn_del(struct hci_conn *hcon, int err)
> > @@ -1297,13 +1362,8 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
> >  
> >  	hci_chan_del(conn->hchan);
> >  
> > -	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
> > -		cancel_delayed_work_sync(&conn->info_timer);
> > -
> > -	if (test_and_clear_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags)) {
> > -		cancel_delayed_work_sync(&conn->security_timer);
> > +	if (test_and_clear_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags))
> 
> So where are you cleaning these timers? I don't see it. You are change the
> code flow here.

Yes this change code flow. Those would be handled gracefully with refcounting.

> >  		smp_chan_destroy(conn);
> > -	}
> >  
> >  	hcon->l2cap_data = NULL;
> >  	kfree(conn);
> > @@ -1312,14 +1372,11 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
> >  static void security_timeout(struct work_struct *work)
> >  {
> >  	struct l2cap_conn *conn = container_of(work, struct l2cap_conn,
> > -						security_timer.work);
> > +					       security_timer.work);
> >  
> >  	BT_DBG("conn %p", conn);
> >  
> > -	if (test_and_clear_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags)) {
> > -		smp_chan_destroy(conn);
> > -		l2cap_conn_del(conn->hcon, ETIMEDOUT);
> > -	}
> > +	l2cap_conn_put(conn);
> 
> You are loosing the error code here (and in some other places in the this
> patch). We need to carry the error code so we can do proper error report in
> teardown()

Maybe we need to set error code somewhere here.

> >  }
> >  
> >  static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
> > @@ -1361,6 +1418,8 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
> >  
> >  	INIT_LIST_HEAD(&conn->chan_l);
> >  
> > +	kref_init(&conn->kref);
> > +`
> >  	if (hcon->type == LE_LINK)
> >  		INIT_DELAYED_WORK(&conn->security_timer, security_timeout);
> >  	else
> > @@ -3318,8 +3377,8 @@ static inline int l2cap_command_rej(struct l2cap_conn *conn, struct l2cap_cmd_hd
> >  		return 0;
> >  
> >  	if ((conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT) &&
> > -					cmd->ident == conn->info_ident) {
> > -		cancel_delayed_work(&conn->info_timer);
> > +	    cmd->ident == conn->info_ident) {
> > +		l2cap_conn_clear_timer(conn, &conn->info_timer);
> >  
> >  		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_DONE;
> >  		conn->info_ident = 0;
> > @@ -3433,10 +3492,11 @@ sendresp:
> >  		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_SENT;
> >  		conn->info_ident = l2cap_get_ident(conn);
> >  
> > -		schedule_delayed_work(&conn->info_timer, L2CAP_INFO_TIMEOUT);
> > +		l2cap_conn_set_timer(conn, &conn->info_timer,
> > +				     L2CAP_INFO_TIMEOUT);
> >  
> >  		l2cap_send_cmd(conn, conn->info_ident,
> > -					L2CAP_INFO_REQ, sizeof(info), &info);
> > +			       L2CAP_INFO_REQ, sizeof(info), &info);
> >  	}
> >  
> >  	if (chan && !test_bit(CONF_REQ_SENT, &chan->conf_state) &&
> > @@ -3889,7 +3949,7 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn, struct l2cap_cm
> >  			conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE)
> >  		return 0;
> >  
> > -	cancel_delayed_work(&conn->info_timer);
> > +	l2cap_conn_clear_timer(conn, &conn->info_timer);
> >  
> >  	if (result != L2CAP_IR_SUCCESS) {
> >  		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_DONE;
> > @@ -5277,8 +5337,10 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
> >  		break;
> >  
> >  	case L2CAP_CID_SMP:
> > -		if (smp_sig_channel(conn, skb))
> > -			l2cap_conn_del(conn->hcon, EACCES);
> > +		if (smp_sig_channel(conn, skb)) {
> > +			l2cap_conn_clear_timer(conn, &conn->security_timer);
> > +			l2cap_conn_put(conn);
> > +		}
> >  		break;
> >  
> >  	default:
> > @@ -5330,8 +5392,14 @@ int l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
> >  		conn = l2cap_conn_add(hcon, status);
> >  		if (conn)
> >  			l2cap_conn_ready(conn);
> > -	} else
> > -		l2cap_conn_del(hcon, bt_to_errno(status));
> > +	} else {
> > +		conn = hcon->l2cap_data;
> > +
> > +		if (hcon->type == LE_LINK)
> > +			l2cap_conn_clear_timer(conn, &conn->security_timer);
> 
> Can you explain why this change is here?

IIRC this the result of changing l2cap_conn_del -> l2cap_conn_put

Best regards 
Andrei Emeltchenko 
