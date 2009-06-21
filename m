Return-Path: <cyrus@holtmann.org>
Subject: Re: regression introduced on v2.6.30-rc1
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <2d5a2c100906210930q394fcf77hcd2bf39c26ae74f8@mail.gmail.com>
References: <2d5a2c100906090617m167d3815pae998d06bdbd6646@mail.gmail.com>
	 <2d5a2c100906210708x1816e5d9hb9a80c82d76da6dd@mail.gmail.com>
	 <1245595707.15367.66.camel@violet>
	 <2d5a2c100906210930q394fcf77hcd2bf39c26ae74f8@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 21 Jun 2009 18:58:49 +0200
Message-Id: <1245603529.15367.68.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> > so does this fixes it:
> >
> > diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> > index 374536e..266c3b7 100644
> > --- a/net/bluetooth/rfcomm/core.c
> > +++ b/net/bluetooth/rfcomm/core.c
> > @@ -1772,8 +1772,7 @@ static inline void rfcomm_process_dlcs(struct
> > rfcomm_sessi
> >                        rfcomm_dlc_clear_timer(d);
> >                        if (!d->out)
> >                                rfcomm_send_dm(s, d->dlci);
> > -                       else
> > -                               d->state = BT_CLOSED;
> > +                       d->state = BT_CLOSED;
> >                        __rfcomm_dlc_close(d, ECONNREFUSED);
> >                        continue;
> >                }
> >
> 
> Not really, rfcomm_dlc is being closed and freed properly, BT_CONNECT2
> or BT_CLOSED doesn't make much difference to __rfcomm_dlc_close as
> they both trigger default case. As I said the code works fine with
> stacks that cope with DM response, when it doesn't you have to
> manually trigger rfcomm_session_put to take care of the reference
> created on rfcomm_accept_connection.

did you actually test this change? And understand it?

Regards

Marcel


