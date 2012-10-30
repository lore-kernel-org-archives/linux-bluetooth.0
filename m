Return-Path: <cyrus@holtmann.org>
Message-ID: <1351619299.1828.10.camel@aeonflux>
Subject: Re: [RFCv2 03/12] Bluetooth: Return correct L2CAP response type
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 30 Oct 2012 10:48:19 -0700
In-Reply-To: <20121030171611.GA28901@aemeltch-MOBL1>
References: <1350493622.26318.114.camel@aeonflux>
	 <1351612384-12392-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1351612384-12392-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1351615743.1828.4.camel@aeonflux> <20121030171611.GA28901@aemeltch-MOBL1>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> > > Return L2CAP_CREATE_CHAN_RSP for Create Channel Request and
> > > L2CAP_CONN_RSP for Create Connection Request.
> > > 
> > > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > > ---
> > >  net/bluetooth/l2cap_core.c |   11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > > index 4ef85d2..d51741f 100644
> > > --- a/net/bluetooth/l2cap_core.c
> > > +++ b/net/bluetooth/l2cap_core.c
> > > @@ -3478,12 +3478,21 @@ void __l2cap_connect_rsp_defer(struct l2cap_chan *chan)
> > >  	struct l2cap_conn_rsp rsp;
> > >  	struct l2cap_conn *conn = chan->conn;
> > >  	u8 buf[128];
> > > +	u8 rsp_code;
> > >  
> > >  	rsp.scid   = cpu_to_le16(chan->dcid);
> > >  	rsp.dcid   = cpu_to_le16(chan->scid);
> > >  	rsp.result = __constant_cpu_to_le16(L2CAP_CR_SUCCESS);
> > >  	rsp.status = __constant_cpu_to_le16(L2CAP_CS_NO_INFO);
> > > -	l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_RSP, sizeof(rsp), &rsp);
> > > +
> > > +	if (chan->hs_hcon)
> > > +		rsp_code = L2CAP_CREATE_CHAN_RSP;
> > > +	else
> > > +		rsp_code = L2CAP_CONN_RSP;
> > > +
> > > +	BT_DBG("chan %p rsp_code %u", chan, rsp_code);
> > > +
> > > +	l2cap_send_cmd(conn, chan->ident, rsp_code, sizeof(rsp), &rsp);
> > 
> > looks a bit hackish to me, but seems to work since both responses are
> > essentially identical. Separate functions might be better, but that can
> > be also fixed later on.
> 
> I have continued to use method proposed by Mat. Do you think it shall be
> changed?

I think at some point we should change this. However for now I am
actually fine keeping this in favor of making progress. You do need to
get back at some point and do some cleanups. Just make a note of it.

Regards

Marcel


