Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Sun, 18 Dec 2011 22:22:35 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Mat Martineau <mathewm@codeaurora.org>, linux-bluetooth@vger.kernel.org,
	pkrystad@codeaurora.org
Subject: Re: [PATCHv2] Bluetooth: Prevent uninitialized data access in L2CAP
 configuration
Message-ID: <20111219002234.GM2621@joana>
References: <1323393801-17493-1-git-send-email-mathewm@codeaurora.org>
 <1323417975.1965.51.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323417975.1965.51.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Marcel Holtmann <marcel@holtmann.org> [2011-12-09 10:06:15 +0200]:

> Hi Mat,
> 
> > When configuring an ERTM or streaming mode connection, remote devices
> > are expected to send an RFC option in a successful config response.  A
> > misbehaving remote device might not send an RFC option, and the L2CAP
> > code should not access uninitialized data in this case.
> > 
> > Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> > ---
> >  net/bluetooth/l2cap_core.c |   11 ++++++++++-
> >  1 files changed, 10 insertions(+), 1 deletions(-)
> > 
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 5ea94a1..45dd423 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -2152,7 +2152,7 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len, voi
> >  	void *ptr = req->data;
> >  	int type, olen;
> >  	unsigned long val;
> > -	struct l2cap_conf_rfc rfc;
> > +	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_BASIC };
> >  
> >  	BT_DBG("chan %p, rsp %p, len %d, req %p", chan, rsp, len, data);
> >  
> > @@ -2271,6 +2271,15 @@ static void l2cap_conf_rfc_get(struct l2cap_chan *chan, void *rsp, int len)
> >  		}
> >  	}
> >  
> > +	/* Use sane default values in case a misbehaving remote device
> > +	 * did not send an RFC option.
> > +	 */
> > +	BT_ERR("Expected RFC option was not found, using defaults");
> > +	rfc.mode = chan->mode;
> > +	rfc.retrans_timeout = cpu_to_le16(L2CAP_DEFAULT_RETRANS_TO);
> > +	rfc.monitor_timeout = cpu_to_le16(L2CAP_DEFAULT_MONITOR_TO);
> > +	rfc.max_pdu_size = cpu_to_le16(chan->imtu);
> 
> I would actually put the BT_ERR afterwards the assignments separated
> with an extra empty line, but that is just to make it a bit easier on
> the eyes.

I applied this one with this change.

	Gustavo
