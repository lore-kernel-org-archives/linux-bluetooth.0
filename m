Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Aug 2011 15:47:48 +0300
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 5/7] Bluetooth: parse EFS in l2cap config response
Message-ID: <20110830124746.GD15216@aemeltch-MOBL1>
References: <1313653502-6303-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1313653502-6303-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20110824211548.GI2662@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20110824211548.GI2662@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, Aug 24, 2011 at 06:15:48PM -0300, Gustavo Padovan wrote:
> Hi Andrei,
> 
> * Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-08-18 10:45:00 +0300]:
> 
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > Add parsing extended flowspec in l2cap config response
> > Based upon haijun.liu <haijun.liu@atheros.com> series of patches
> > (sent Sun, 22 Aug 2010)
> > ---
> >  net/bluetooth/l2cap_core.c |   28 +++++++++++++++++++++++++++-
> >  1 files changed, 27 insertions(+), 1 deletions(-)
> > 
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 5378bc6..f64c9cb 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -2213,6 +2213,7 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len, voi
> >  	int type, olen;
> >  	unsigned long val;
> >  	struct l2cap_conf_rfc rfc;
> > +	struct l2cap_conf_efs efs;
> >  
> >  	BT_DBG("chan %p, rsp %p, len %d, req %p", chan, rsp, len, data);
> >  
> > @@ -2248,6 +2249,19 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len, voi
> >  			l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
> >  					sizeof(rfc), (unsigned long) &rfc);
> >  			break;
> > +
> > +		case L2CAP_CONF_EFS:
> > +			if (olen == sizeof(efs))
> > +				memcpy(&efs, (void *)val, olen);
> > +
> > +			if (chan->local_stype != L2CAP_SERVTYPE_NOTRAFIC &&
> > +				efs.service_type != L2CAP_SERVTYPE_NOTRAFIC &&
> > +				efs.service_type != chan->local_stype)
> > +				return -ECONNREFUSED;
> > +
> > +			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EFS,
> > +					sizeof(efs), (unsigned long) &efs);
> > +			break;
> >  		}
> >  	}
> >  
> > @@ -2256,13 +2270,25 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len, voi
> >  
> >  	chan->mode = rfc.mode;
> >  
> > -	if (*result == L2CAP_CONF_SUCCESS) {
> > +	if (*result == L2CAP_CONF_SUCCESS || *result == L2CAP_CONF_PENDING) {
> >  		switch (rfc.mode) {
> >  		case L2CAP_MODE_ERTM:
> >  			chan->retrans_timeout = le16_to_cpu(rfc.retrans_timeout);
> >  			chan->monitor_timeout = le16_to_cpu(rfc.monitor_timeout);
> >  			chan->mps    = le16_to_cpu(rfc.max_pdu_size);
> > +			if (chan->ext_flowspec_enable) {
> > +				/* id, service type should not be changed */
> > +				chan->local_msdu =
> > +					le16_to_cpu(efs.max_sdu_size);
> > +				chan->local_sdu_itime =
> > +					le32_to_cpu(efs.sdu_inter_time);
> > +				chan->local_acc_lat =
> > +					le32_to_cpu(efs.access_latency);
> > +				chan->local_flush_to =
> > +					le32_to_cpu(efs.flush_timeout);
> > +			}
> 
> These should be the remote_ not the local_ values.

As I understood from the Spec:
<------8<-----------------------------------------------------------------------------
|  ...
|  If the service type is “Best Effort” then values for certain parameters may be
|  sent in a Configuration Response with result “Pending” to indicate the
|  maximum bandwidth the sender of the Configuration Response is capable to
|  receive.
|  ...
<------8<-----------------------------------------------------------------------------
BLUETOOTH SPECIFICATION Version 4.0 [Vol 3] page 124 of 656

I have interpreted it as local outgoing parameters.

Best regards 
Andrei Emeltchenko 
