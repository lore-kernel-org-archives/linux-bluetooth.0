Return-Path: <cyrus@holtmann.org>
Date: Mon, 13 Jan 2014 12:55:53 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] avrcp: Remove dead code
Message-ID: <20140113105547.GC2656@aemeltch-MOBL1>
References: <1389365780-20136-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CABBYNZJfet_rQChugsSyv4ygBknj8Ao64kA532=sJHCz9nxPBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZJfet_rQChugsSyv4ygBknj8Ao64kA532=sJHCz9nxPBA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Jan 13, 2014 at 11:08:49AM +0200, Luiz Augusto von Dentz wrote:
> Hi Andrei,
> 
> On Fri, Jan 10, 2014 at 4:56 PM, Andrei Emeltchenko
> <Andrei.Emeltchenko.news@gmail.com> wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >
> > session->target cannot be NULL since it is already checked 11 lines
> > above:
> > ...
> >         if (session == NULL || session->target == NULL)
> >                 return -ENOTCONN;
> > ...
> > ---
> >  profiles/audio/avrcp.c | 24 ++++--------------------
> >  1 file changed, 4 insertions(+), 20 deletions(-)
> >
> > diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> > index 8d4309a..197959f 100644
> > --- a/profiles/audio/avrcp.c
> > +++ b/profiles/audio/avrcp.c
> > @@ -3722,30 +3722,14 @@ int avrcp_set_volume(struct btd_device *dev, uint8_t volume)
> >
> >         DBG("volume=%u", volume);
> >
> > -       if (session->target) {
> > -               pdu->pdu_id = AVRCP_SET_ABSOLUTE_VOLUME;
> > -               pdu->params[0] = volume;
> > -               pdu->params_len = htons(1);
> > +       pdu->pdu_id = AVRCP_SET_ABSOLUTE_VOLUME;
> > +       pdu->params[0] = volume;
> > +       pdu->params_len = htons(1);
> >
> > -               return avctp_send_vendordep_req(session->conn,
> > +       return avctp_send_vendordep_req(session->conn,
> >                                         AVC_CTYPE_CONTROL, AVC_SUBUNIT_PANEL,
> >                                         buf, sizeof(buf),
> >                                         avrcp_handle_set_volume, session);
> > -       } else if (session->registered_events &
> > -                                       (1 << AVRCP_EVENT_VOLUME_CHANGED)) {
> > -               uint8_t id = AVRCP_EVENT_VOLUME_CHANGED;
> > -               pdu->pdu_id = AVRCP_REGISTER_NOTIFICATION;
> > -               pdu->params[0] = AVRCP_EVENT_VOLUME_CHANGED;
> > -               pdu->params[1] = volume;
> > -               pdu->params_len = htons(2);
> > -
> > -               return avctp_send_vendordep(session->conn,
> > -                                       session->transaction_events[id],
> > -                                       AVC_CTYPE_CHANGED, AVC_SUBUNIT_PANEL,
> > -                                       buf, sizeof(buf));
> > -       }
> 
> The above code is necessary to notify volume changes when acting as
> controller (session->control is set), so your fix is not good either
> and we should depend on session->target on the first place because
> both session->control and session->target can be set.


So did you make a proper fix, since otherwise this is dead code?

Best regards 
Andrei Emeltchenko 
