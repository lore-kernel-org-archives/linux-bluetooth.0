Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Aug 2011 15:28:07 +0300
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 4/7] Bluetooth: parse EFS in l2cap config request
Message-ID: <20110830122805.GC15216@aemeltch-MOBL1>
References: <1313653502-6303-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1313653502-6303-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20110824211359.GH2662@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110824211359.GH2662@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, Aug 24, 2011 at 06:13:59PM -0300, Gustavo Padovan wrote:
> Hi Andrei,
> 
> * Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-08-18 10:44:59 +0300]:
> 
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > Add parsing extended flowspec option in L2cap config request
> > Based upon haijun.liu <haijun.liu@atheros.com> series of patches
> > (sent Sun, 22 Aug 2010)
> > ---
> >  net/bluetooth/l2cap_core.c |   70 ++++++++++++++++++++++++++++++++++++++++++-
> >  1 files changed, 68 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 4167cb0..5378bc6 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -1890,6 +1890,12 @@ static inline __u8 l2cap_select_mode(__u8 mode, __u16 remote_feat_mask)
> >  	}
> >  }
> >  
> > +static inline bool __l2cap_efs_supported(struct l2cap_chan *chan)
> > +{
> > +	return !disable_flowspec &&
> > +			chan->conn->feat_mask & L2CAP_FEAT_EXT_FLOW;
> > +}
> > +
> >  static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data)
> >  {
> >  	struct l2cap_conf_req *req = data;
> > @@ -1996,6 +2002,8 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data)
> >  	int type, hint, olen;
> >  	unsigned long val;
> >  	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_BASIC };
> > +	struct l2cap_conf_efs efs = { .service_type = L2CAP_SERVTYPE_BESTEFFORT };
> > +	u8 ext_flowspec_enable = 0;
> 
> 	u8 remote_efs is better and shorter name.

OK

> 
> >  	u16 mtu = L2CAP_DEFAULT_MTU;
> >  	u16 result = L2CAP_CONF_SUCCESS;
> >  
> > @@ -2030,6 +2038,12 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data)
> >  
> >  			break;
> >  
> > +		case L2CAP_CONF_EFS:
> > +			ext_flowspec_enable = 1;
> > +			if (olen == sizeof(efs))
> > +				memcpy(&efs, (void *) val, olen);
> > +			break;
> > +
> >  		default:
> >  			if (hint)
> >  				break;
> > @@ -2052,7 +2066,17 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data)
> >  			break;
> >  		}
> >  
> > -		if (chan->mode != rfc.mode)
> > +		if (ext_flowspec_enable && __l2cap_efs_supported(chan)) {
> > +			chan->ext_flowspec_enable = 1;
> > +
> > +			chan->local_stype = L2CAP_SERVTYPE_BESTEFFORT;
> > +			chan->local_msdu = L2CAP_DEFAULT_MAX_SDU_SIZE;
> > +			chan->local_sdu_itime = L2CAP_DEFAULT_SDU_ARRIVAL_TIME;
> > +			chan->local_acc_lat = L2CAP_DEFAULT_ACCESS_LATENCY;
> > +			chan->local_flush_to = L2CAP_DEFAULT_FLUSH_TO;
> > +		}
> > +
> 
> parse_conf_req isn't the best place to initialize channel data. Do in at
> channel initializions procedure.

OK, I will move initialization to chan_add but in this case those
parameters will always initialize without checking that other side
supports EFS. 

> 
> > +		if (!l2cap_mode_supported(chan->mode, chan->conn->feat_mask))
> >  			return -ECONNREFUSED;
> >  
> >  		break;
> > @@ -2070,8 +2094,34 @@ done:
> >  					sizeof(rfc), (unsigned long) &rfc);
> >  	}
> >  
> > +	/*
> > +	   Add the ext flow spec and ext win size option parameters check here.
> > +	 */
> > +	if (result == L2CAP_CONF_SUCCESS && ext_flowspec_enable) {
> > +		if (!chan->ext_flowspec_enable) {
> > +			/* remote efs support , local efs not supported */
> > +
> > +			result = L2CAP_CONF_REJECT;
> > +			return -ECONNREFUSED;
> > +		} else if (chan->local_stype != L2CAP_SERVTYPE_NOTRAFIC &&
> > +				efs.service_type != L2CAP_SERVTYPE_NOTRAFIC &&
> > +				efs.service_type != chan->local_stype) {
> 
> No need for else, just "if". And what do you want to check for here.

it checks that service type is the same for sent and receiving Conf Req.

> 
> >  
> > -	if (result == L2CAP_CONF_SUCCESS) {
> > +			result = L2CAP_CONF_UNACCEPT;
> > +
> > +			if (chan->num_conf_req >= 1)
> > +				return -ECONNREFUSED;
> > +
> > +			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EFS,
> > +					sizeof(efs), (unsigned long) &efs);
> > +
> > +		} else {
> > +			result = L2CAP_CONF_PENDING;
> > +			set_bit(CONF_LOCAL_PEND, &chan->conf_state);
> > +		}
> > +	}
> > +
> > +	if (result == L2CAP_CONF_SUCCESS || result == L2CAP_CONF_PENDING) {
> >  		/* Configure output options and let the other side know
> >  		 * which ones we don't like. */
> 
> If the result is pending do we need to send configurations like RFC again?
> what does the spec says about it?

As I understood if we do not make allowed modification (in rare cases) we
do not need to send EFS again.

Best regards 
Andrei Emeltchenko 
