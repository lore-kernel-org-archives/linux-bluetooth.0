Return-Path: <cyrus@holtmann.org>
Date: Mon, 3 Feb 2014 11:42:47 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] avrcp: Fix wrong pointer check
Message-ID: <20140203094246.GF2930@aemeltch-MOBL1>
References: <1391157222-24504-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CABBYNZ+-mc_u+ihj_FB5e89TNmBgZvyWxW4vwMCuFDh1_TjCJg@mail.gmail.com>
 <20140203074920.GA2930@aemeltch-MOBL1>
 <CABBYNZ+VPAkfgUNRu6GC9DhkP=KXpTzBC03OVW8nNC_55uaMfg@mail.gmail.com>
 <20140203093651.GE2930@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140203093651.GE2930@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Feb 03, 2014 at 11:36:52AM +0200, Andrei Emeltchenko wrote:
> On Mon, Feb 03, 2014 at 01:20:11AM -0800, Luiz Augusto von Dentz wrote:
> > Hi Andrei,
> > 
> > On Sun, Feb 2, 2014 at 11:51 PM, Andrei Emeltchenko
> > <Andrei.Emeltchenko.news@gmail.com> wrote:
> > > Hi Luiz,
> > >
> > > On Sun, Feb 02, 2014 at 08:03:34AM -0800, Luiz Augusto von Dentz wrote:
> > >> Hi Andrei,
> > >>
> > >> On Fri, Jan 31, 2014 at 12:33 AM, Andrei Emeltchenko
> > >> <Andrei.Emeltchenko.news@gmail.com> wrote:
> > >> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > >> >
> > >> > There is wrong assumption that handler might be NULL while it is a
> > >> > pointer to a struct table so check instead for struct members. This
> > >> > fixes accessing wrong memory.
> > >> > ---
> > >> >  profiles/audio/avrcp.c | 4 ++--
> > >> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >> >
> > >> > diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> > >> > index df88138..5030ce1 100644
> > >> > --- a/profiles/audio/avrcp.c
> > >> > +++ b/profiles/audio/avrcp.c
> > >> > @@ -1673,7 +1673,7 @@ static size_t handle_vendordep_pdu(struct avctp *conn, uint8_t transaction,
> > >> >                         break;
> > >> >         }
> > >> >
> > >> > -       if (!handler || handler->code != *code) {
> > >> > +       if (!handler->code || handler->code != *code) {
> > >>
> > >> The code checks if  session->control_handlers is initialized and Im
> > >> not sure what is the invalid memory access you are talking about since
> > >> handle->code is no a pointer, I do agree that we should probably drop
> > >> the second check for the handler in the lines bellow.
> > >
> > > handler is a pointer, and it points to
> > >
> > > static const struct control_pdu_handler control_handlers[]
> > > table with the last element:
> > >
> > > ...
> > >                 { },
> > > };
> > > ...
> > >
> > > So checking for !handler is pointless.
> > 
> > Right, because checking for pointer is pointless, yes Im being
> > sarcastic here... Now lets be clear, you are changing a check of a
> > pointer to a value and claiming it fixes invalid accesses which does
> > not make any sense, what could make sense is to check if
> > handler->pdu_id == pdu->pdu_id since that what we check when we lookup
> > for a handle.
> 
> No, we break if handler->pdu_id == pdu->pdu_id one line above ;)

Sorry this was wrong. So my idea is to check that we are not at the end of
the table. In this case every element of a struct is zero, so it does not
matter which one to check.

Best regards 
Andrei Emeltchenko 

