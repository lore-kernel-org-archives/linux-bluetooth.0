Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Feb 2014 08:54:28 +0200
From: Andrei Emeltchenko <andrei.emeltchenko@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCHv2 2/6] android/avctp: Add UNIT INFO command request
Message-ID: <20140224065425.GA4133@aemeltch-MOBL1>
References: <1392996230-11789-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1392996230-11789-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CABBYNZL9G3odx=Dgo_R9e0M0N8ZwewLqx1PPnnCrxTz8NuXFxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZL9G3odx=Dgo_R9e0M0N8ZwewLqx1PPnnCrxTz8NuXFxw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Sun, Feb 23, 2014 at 01:57:05PM +0200, Luiz Augusto von Dentz wrote:
> Hi Andrei,
> 
> On Fri, Feb 21, 2014 at 5:23 PM, Andrei Emeltchenko
> <andrei.emeltchenko@gmail.com> wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >
> > ---
> >  android/avctp.c | 13 +++++++++++++
> >  android/avctp.h |  3 +++
> >  2 files changed, 16 insertions(+)
> >
> > diff --git a/android/avctp.c b/android/avctp.c
> > index 1e414d1..57a8c23 100644
> > --- a/android/avctp.c
> > +++ b/android/avctp.c
> > @@ -1266,6 +1266,19 @@ int avctp_send_vendordep_req(struct avctp *session, uint8_t code,
> >                                                 func, user_data);
> >  }
> >
> > +int avctp_send_unit_info_req(struct avctp *session, avctp_rsp_cb func,
> > +                                                               void *user_data)
> > +{
> > +       uint8_t operands[5];
> > +
> > +       memset(operands, 0xFF, sizeof(operands));
> > +
> > +       return avctp_send_req(session, AVC_CTYPE_STATUS,
> > +                               AVC_SUBUNIT_UNIT, AVC_OP_UNITINFO,
> > +                               operands, sizeof(operands),
> > +                               func, user_data);
> > +}
> > +
> >  unsigned int avctp_register_passthrough_handler(struct avctp *session,
> >                                                 avctp_passthrough_cb cb,
> >                                                 void *user_data)
> > diff --git a/android/avctp.h b/android/avctp.h
> > index dfa0ca6..7496e53 100644
> > --- a/android/avctp.h
> > +++ b/android/avctp.h
> > @@ -46,6 +46,7 @@
> >
> >  /* subunits of interest */
> >  #define AVC_SUBUNIT_PANEL              0x09
> > +#define AVC_SUBUNIT_UNIT               0x1f
> >
> >  /* operands in passthrough commands */
> >  #define AVC_SELECT                     0x00
> > @@ -170,3 +171,5 @@ int avctp_send_vendordep_req(struct avctp *session, uint8_t code,
> >  int avctp_send_browsing_req(struct avctp *session,
> >                                 uint8_t *operands, size_t operand_count,
> >                                 avctp_browsing_rsp_cb func, void *user_data);
> > +int avctp_send_unit_info_req(struct avctp *session, avctp_rsp_cb func,
> > +                                                       void *user_data);
> > --
> > 1.8.3.2
> 
> This probably needs to be internal and sent automatically once
> connected specially if it is for a mandatory test.

So what do you propose with this case? Make it private and send this
command in avrcp_new() ?

Best regards 
Andrei Emeltchenko 
