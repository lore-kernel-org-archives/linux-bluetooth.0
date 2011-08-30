Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Aug 2011 16:57:52 +0300
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 6/7] Bluetooth: add EFS option in l2cap conf req
Message-ID: <20110830135751.GF15216@aemeltch-MOBL1>
References: <1313653502-6303-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1313653502-6303-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20110824213324.GK2662@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110824213324.GK2662@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, Aug 24, 2011 at 06:33:24PM -0300, Gustavo Padovan wrote:
> * Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-08-18 10:45:01 +0300]:
> 
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > Adds extended flowspec option when building l2cap config request
> > Based upon haijun.liu <haijun.liu@atheros.com> series of patches
> > (sent Sun, 22 Aug 2010)
> > ---
> >  include/net/bluetooth/l2cap.h |    2 +
> >  net/bluetooth/l2cap_core.c    |   79 ++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 80 insertions(+), 1 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> > index d2154e0..2350057 100644
> > --- a/include/net/bluetooth/l2cap.h
> > +++ b/include/net/bluetooth/l2cap.h
> > @@ -446,6 +446,8 @@ struct l2cap_conn {
> >  	__u32		rx_len;
> >  	__u8		tx_ident;
> >  
> > +	__u8		flowspec_ident;
> > +
> >  	__u8		disc_reason;
> >  
> >  	__u8		preq[7]; /* SMP Pairing Request */
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index f64c9cb..f3663ac 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -541,6 +541,26 @@ static u8 l2cap_get_ident(struct l2cap_conn *conn)
> >  	return id;
> >  }
> >  
> > +static inline u8 l2cap_flowspec_ident(struct l2cap_conn *conn)
> > +{
> > +	u8 id;
> > +
> > +	/* Get next available ident for the flow spec of guaranteed channel.
> > +	 *    2 - 255 are used.
> > +	 */
> > +
> > +	spin_lock_bh(&conn->lock);
> > +
> > +	if (++conn->flowspec_ident > 256)
> > +		conn->flowspec_ident = 2;
> > +
> > +	id = conn->flowspec_ident;
> > +
> > +	spin_unlock_bh(&conn->lock);
> > +
> > +	return id;
> > +}
> > +
> >  static void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len, void *data)
> >  {
> >  	struct sk_buff *skb = l2cap_build_cmd(conn, code, ident, len, data);
> > @@ -1900,6 +1920,7 @@ static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data)
> >  {
> >  	struct l2cap_conf_req *req = data;
> >  	struct l2cap_conf_rfc rfc = { .mode = chan->mode };
> > +	struct l2cap_conf_efs efs = { .service_type = L2CAP_SERVTYPE_BESTEFFORT };
> >  	void *ptr = req->data;
> >  
> >  	BT_DBG("chan %p", chan);
> > @@ -1913,7 +1934,20 @@ static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data)
> >  		if (test_bit(CONF_STATE2_DEVICE, &chan->conf_state))
> >  			break;
> >  
> > -		/* fall through */
> > +		if (__l2cap_efs_supported(chan)) {
> > +			chan->ext_flowspec_enable = 1;
> > +
> > +			chan->local_stype = L2CAP_SERVTYPE_BESTEFFORT;
> > +			chan->local_msdu = L2CAP_DEFAULT_MAX_SDU_SIZE;
> > +			chan->local_sdu_itime = L2CAP_DEFAULT_SDU_ARRIVAL_TIME;
> > +			chan->local_acc_lat = L2CAP_DEFAULT_ACCESS_LATENCY;
> > +			chan->local_flush_to = L2CAP_DEFAULT_FLUSH_TO;
> > +		}
> > +
> > +		if (!l2cap_mode_supported(chan->mode, chan->conn->feat_mask))
> > +			l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
> > +		break;
> 
> Could you tell me what this l2cap_send_disconn_req is doing here? it wasn't in
> the original code.

Removed. The chunk was in the Atheros code.

Best regards 
Andrei Emeltchenko 
