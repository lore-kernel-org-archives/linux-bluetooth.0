Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 May 2012 15:10:19 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Define L2CAP conf continuation flag
Message-ID: <20120521121017.GA30424@aemeltch-MOBL1>
References: <1337350806-20326-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1337350806-20326-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1337360100.2058.12.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337360100.2058.12.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, May 18, 2012 at 09:55:00AM -0700, Marcel Holtmann wrote:
> > +/* conf req/rsp continuation flag */
> > +#define L2CAP_CONF_FLAG_CONT_CLEARED	0
> > +#define L2CAP_CONF_FLAG_CONT_SET	1
> > +
> 
> this is misleading. Even while the only defined flag is currently the
> continuation flag, it is clearly not limited to it.
> 
> I am fine with introducing L2CAP_CONF_FLAG_CONTINUATION

This looks good one.

> > -	req->flags = cpu_to_le16(0);
> > +	req->flags = cpu_to_le16(L2CAP_CONF_FLAG_CONT_CLEARED);
> 
> And as a side note, this should be __constant_cpu_to_le16(0).
>  
> > -	rsp->flags  = cpu_to_le16(0x0000);
> > +	rsp->flags  = cpu_to_le16(L2CAP_CONF_FLAG_CONT_CLEARED);
> 
> Same here, __constant_cpu_to_le16(0) is the right call.
>  
> > -	req->flags  = cpu_to_le16(0x0000);
> > +	req->flags  = cpu_to_le16(L2CAP_CONF_FLAG_CONT_CLEARED);
> 
> And here as well.
> 
> No idea on how we kept missing to change this all the time.

I will change this to the way you recommended.

> 
> >  
> >  	return ptr - data;
> >  }
> > @@ -3218,11 +3218,11 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
> >  	memcpy(chan->conf_req + chan->conf_len, req->data, len);
> >  	chan->conf_len += len;
> >  
> > -	if (flags & 0x0001) {
> > +	if (flags & L2CAP_CONF_FLAG_CONT_SET) {
> >  		/* Incomplete config. Send empty response. */
> >  		l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP,
> >  				l2cap_build_conf_rsp(chan, rsp,
> > -					L2CAP_CONF_SUCCESS, 0x0001), rsp);
> > +					L2CAP_CONF_SUCCESS, flags), rsp);
> 
> Here you are actually changing behavior. If flags ever has more than one
> option, you are returning the other flags as well.

I will create separate patch with this change. Currently there is only one
flag defined this is why I made such a simplifications in the patch. I
feel that using flags instead of 0x0001 looks more readable and shall be
the same.

Best regards 
Andrei Emeltchenko 
