Return-Path: <cyrus@holtmann.org>
Date: Mon, 10 Oct 2011 11:02:21 +0300
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 1/5] Bluetooth: EWS: extended window size option support
Message-ID: <20111010080218.GA13464@aemeltch-MOBL1>
References: <1316180379-31607-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1316180379-31607-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20111006180514.GF5652@joana>
 <20111007103303.GA30817@aemeltch-MOBL1>
 <20111007202637.GC4108@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111007202637.GC4108@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Fri, Oct 07, 2011 at 05:26:38PM -0300, Gustavo Padovan wrote:
> > > > Adds support for EWS option. Code partly based on Qualcomm and Atheros
> > > > patches sent upstream a year ago.
> > > > 
> > > > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > > > ---
> > > >  include/net/bluetooth/l2cap.h |   11 ++++++--
> > > >  net/bluetooth/l2cap_core.c    |   53 +++++++++++++++++++++++++++++++++++++---
> > > >  net/bluetooth/l2cap_sock.c    |   10 ++++----
> > > >  3 files changed, 62 insertions(+), 12 deletions(-)
> > > > 
> > > > diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> > > > index 1f26a39..92eac16 100644
> > > > --- a/include/net/bluetooth/l2cap.h
> > > > +++ b/include/net/bluetooth/l2cap.h
> > > > @@ -31,7 +31,7 @@
> > > >  #define L2CAP_DEFAULT_MTU		672
> > > >  #define L2CAP_DEFAULT_MIN_MTU		48
> > > >  #define L2CAP_DEFAULT_FLUSH_TO		0xffff
> > > > -#define L2CAP_DEFAULT_TX_WINDOW		63
> > > > +#define L2CAP_DEFAULT_MAX_TX_WINDOW	63
> > > 
> > > Just keep this macro as is.
> > > 
> > > >  #define L2CAP_DEFAULT_MAX_TX		3
> > > >  #define L2CAP_DEFAULT_RETRANS_TO	2000    /* 2 seconds */
> > > >  #define L2CAP_DEFAULT_MONITOR_TO	12000   /* 12 seconds */
> > > > @@ -42,6 +42,8 @@
> > > >  #define L2CAP_DEFAULT_SDU_ARRIVAL_TIME	0xFFFFFFFF
> > > >  #define L2CAP_DEFAULT_ACCESS_LATENCY	0xFFFFFFFF
> > > >  
> > > > +#define L2CAP_DEFAULT_MAX_EXT_WINDOW	0x3FFF
> > > > +
> > > 
> > > and remove MAX from this one.
> > > 
> > > >  #define L2CAP_CONN_TIMEOUT	(40000) /* 40 seconds */
> > > >  #define L2CAP_INFO_TIMEOUT	(4000)  /*  4 seconds */
> > > >  
> > > > @@ -240,6 +242,7 @@ struct l2cap_conf_opt {
> > > >  #define L2CAP_CONF_RFC		0x04
> > > >  #define L2CAP_CONF_FCS		0x05
> > > >  #define L2CAP_CONF_EFS		0x06
> > > > +#define L2CAP_CONF_EWS		0x07
> > > >  
> > > >  #define L2CAP_CONF_MAX_SIZE	22
> > > >  
> > > > @@ -357,7 +360,7 @@ struct l2cap_chan {
> > > >  
> > > >  	__u8		fcs;
> > > >  
> > > > -	__u8		tx_win;
> > > > +	__u16		tx_win;
> > > >  	__u8		max_tx;
> > > >  	__u16		retrans_timeout;
> > > >  	__u16		monitor_timeout;
> > > > @@ -381,7 +384,7 @@ struct l2cap_chan {
> > > >  	struct sk_buff	*sdu;
> > > >  	struct sk_buff	*sdu_last_frag;
> > > >  
> > > > -	__u8		remote_tx_win;
> > > > +	__u16		remote_tx_win;
> > > >  	__u8		remote_max_tx;
> > > >  	__u16		remote_mps;
> > > >  
> > > > @@ -488,6 +491,7 @@ enum {
> > > >  	CONF_STATE2_DEVICE,
> > > >  	CONF_LOCAL_PEND,
> > > >  	CONF_REMOTE_PEND,
> > > > +	CONF_EWS_RECV,
> > > >  };
> > > >  
> > > >  #define L2CAP_CONF_MAX_CONF_REQ 2
> > > > @@ -508,6 +512,7 @@ enum {
> > > >  /* Definitions for flags in l2cap_chan */
> > > >  enum {
> > > >  	FLAG_EFS_ENABLE,
> > > > +	FLAG_EXT_CTRL,
> > > >  };
> > > >  
> > > >  #define __set_chan_timer(c, t) l2cap_set_timer(c, &c->chan_timer, (t))
> > > > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > > > index 7aad856..69e974a 100644
> > > > --- a/net/bluetooth/l2cap_core.c
> > > > +++ b/net/bluetooth/l2cap_core.c
> > > > @@ -1906,6 +1906,22 @@ static inline bool __l2cap_efs_supported(struct l2cap_chan *chan)
> > > >  	return enable_hs && chan->conn->feat_mask & L2CAP_FEAT_EXT_FLOW;
> > > >  }
> > > >  
> > > > +static inline bool __l2cap_ews_supported(struct l2cap_chan *chan)
> > > > +{
> > > > +	return enable_hs && chan->conn->feat_mask & L2CAP_FEAT_EXT_WINDOW;
> > > > +}
> > > > +
> > > > +static inline void l2cap_txwin_setup(struct l2cap_chan *chan)
> > > > +{
> > > > +	if (chan->tx_win > L2CAP_DEFAULT_MAX_TX_WINDOW &&
> > > > +						__l2cap_ews_supported(chan))
> > > > +		/* use extended control field */
> > > > +		set_bit(FLAG_EXT_CTRL, &chan->flags);
> > > > +	else
> > > > +		chan->tx_win = min_t(u16, chan->tx_win,
> > > > +						L2CAP_DEFAULT_MAX_TX_WINDOW);
> > > > +}
> > > > +
> > > >  static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data)
> > > >  {
> > > >  	struct l2cap_conf_req *req = data;
> > > > @@ -1957,7 +1973,6 @@ done:
> > > >  
> > > >  	case L2CAP_MODE_ERTM:
> > > >  		rfc.mode            = L2CAP_MODE_ERTM;
> > > > -		rfc.txwin_size      = chan->tx_win;
> > > >  		rfc.max_transmit    = chan->max_tx;
> > > >  		rfc.retrans_timeout = 0;
> > > >  		rfc.monitor_timeout = 0;
> > > > @@ -1965,6 +1980,11 @@ done:
> > > >  		if (L2CAP_DEFAULT_MAX_PDU_SIZE > chan->conn->mtu - 10)
> > > >  			rfc.max_pdu_size = cpu_to_le16(chan->conn->mtu - 10);
> > > >  
> > > > +		l2cap_txwin_setup(chan);
> > > > +
> > > > +		rfc.txwin_size = min_t(u16, chan->tx_win,
> > > > +						L2CAP_DEFAULT_MAX_TX_WINDOW);
> > > 
> > > rfc.txwin_size is exactly chan->tx_win.
> > 
> > chan->tx_win might be bigger then L2CAP_DEFAULT_MAX_TX_WINDOW since we
> > allow to set bigger value via socket (see below).
> > 
> > Current idea is to allow user to set txwin < EXT_WINDOW and if ews_supported
> > and txwin > TX_WINDOW then we enable extended control field.
> 
> Yes, but look:
> 
> 
> +static inline void l2cap_txwin_setup(struct l2cap_chan *chan)
> +{
> +       if (chan->tx_win > L2CAP_DEFAULT_MAX_TX_WINDOW &&
> +                                               __l2cap_ews_supported(chan))
> +               /* use extended control field */
> +               set_bit(FLAG_EXT_CTRL, &chan->flags);
> +       else
> +               chan->tx_win = min_t(u16, chan->tx_win,
> +                                               L2CAP_DEFAULT_MAX_TX_WINDOW);
> +}
> 
> In l2cap_txwin_setup() chan->tx_win is already set to the value we want so
> call the same min_t after it seems rather pointless. Just remove it and do a
> direct assignment.

If tx_win > L2CAP_DEFAULT_MAX_TX_WINDOW (63) && ews_supported then tx_win might
be up to L2CAP_DEFAULT_EXT_WINDOW (0x3fff)

Where:
#define L2CAP_DEFAULT_TX_WINDOW        63
#define L2CAP_DEFAULT_EXT_WINDOW       0x3FFF

We cannot assign to TxWindow from RETRANSMISSION AND FLOW CONTROL OPTION
which shall be: "The range is 1 to 63 for Enhanced Retransmission mode."

BLUETOOTH SPECIFICATION Version 4.0 [Vol 3] page 87 of 656

Best regards 
Andrei Emeltchenko 
