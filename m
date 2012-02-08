Return-Path: <cyrus@holtmann.org>
Date: Wed, 8 Feb 2012 15:59:11 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Fix l2cap_tx_window_full
Message-ID: <20120208135910.GF5917@aemeltch-MOBL1>
References: <1328708855-3010-1-git-send-email-luiz.dentz@gmail.com>
 <CAA37ikZCMxST2rLb3B2NmnC+h+cstPtTWEz3TUsRGgAMOSDRpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAA37ikZCMxST2rLb3B2NmnC+h+cstPtTWEz3TUsRGgAMOSDRpA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

On Wed, Feb 08, 2012 at 11:54:54AM -0200, Ulisses Furquim wrote:
> Hi Luiz,
> 
> On Wed, Feb 8, 2012 at 11:47 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > l2cap_tx_window_full is not checking the window limit properly, first it
> > computes based on sequence numbers which doesn't take into account the
> > ReqSeq and always assume 64 not the real window size.
> >
> > To fix this now it just checks if the number of unacked frames is >= of
> > tx window which is much simpler.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > Add debug
> >
> >  include/net/bluetooth/l2cap.h |   10 +++-------
> >  1 files changed, 3 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> > index 42fdbb8..bcfddb2 100644
> > --- a/include/net/bluetooth/l2cap.h
> > +++ b/include/net/bluetooth/l2cap.h
> > @@ -661,14 +661,10 @@ static inline __u16 __next_seq(struct l2cap_chan *chan, __u16 seq)
> >
> >  static inline int l2cap_tx_window_full(struct l2cap_chan *ch)
> >  {
> > -       int sub;
> > +       BT_DBG("chan %p unacked %d tx_win %d", ch, ch->unacked_frames,
> > +                                                       ch->remote_tx_win);
> >
> > -       sub = (ch->next_tx_seq - ch->expected_ack_seq) % 64;
> > -
> > -       if (sub < 0)
> > -               sub += 64;
> > -
> > -       return sub == ch->remote_tx_win;
> > +       return ch->unacked_frames >= ch->remote_tx_win;
> >  }
> >
> >  static inline __u16 __get_reqseq(struct l2cap_chan *chan, __u32 ctrl)
> > --
> > 1.7.7.6
> 
> Looks good to me.

Same here, I am wondering why it was done in a such complex way? Maybe
there is some logic behind?

Best regards 
Andrei Emeltchenko 

