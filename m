Return-Path: <cyrus@holtmann.org>
Date: Wed, 22 Feb 2012 11:59:50 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv1 14/14] Bluetooth: Remove socket lock check
Message-ID: <20120222095949.GG24328@aemeltch-MOBL1>
References: <1329821707-11817-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1329821707-11817-15-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CAA37ikbScY7dz6iP9FL5-x1SiNWfNOKvsQ77U1VrvmMJFGDWFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAA37ikbScY7dz6iP9FL5-x1SiNWfNOKvsQ77U1VrvmMJFGDWFg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

On Tue, Feb 21, 2012 at 03:37:32PM -0200, Ulisses Furquim wrote:
> Hi Andrei,
> 
> On Tue, Feb 21, 2012 at 8:55 AM, Andrei Emeltchenko
> <Andrei.Emeltchenko.news@gmail.com> wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >
> > Simplify code so that we do not need to check whether socket is locked.
> >
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> >  net/bluetooth/l2cap_sock.c |    8 ++++----
> >  1 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> > index bbc1747..e2fc24b 100644
> > --- a/net/bluetooth/l2cap_sock.c
> > +++ b/net/bluetooth/l2cap_sock.c
> > @@ -125,15 +125,15 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int al
> >
> >        err = l2cap_chan_connect(chan, la.l2_psm, la.l2_cid, &la.l2_bdaddr);
> >        if (err)
> > -               goto done;
> > +               return err;
> >
> >        lock_sock(sk);
> >
> >        err = bt_sock_wait_state(sk, BT_CONNECTED,
> >                        sock_sndtimeo(sk, flags & O_NONBLOCK));
> > -done:
> > -       if (sock_owned_by_user(sk))
> > -               release_sock(sk);
> > +
> > +       release_sock(sk);
> > +
> >        return err;
> >  }
> 
> I don't remember your answer so again are sure about this? Why can we
> remove this now? (I may be missing something here).

l2cap_chan_connect used to return with locked socket and apparently we
were screwed up and did not know is socket locked or not. That's why we used
check to verify that socket was locked.

Best regards 
Andrei Emeltchenko 

