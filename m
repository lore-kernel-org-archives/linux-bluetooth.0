Return-Path: <cyrus@holtmann.org>
Date: Wed, 22 Feb 2012 11:25:18 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv1 06/14] Bluetooth: Add unlocked __l2cap_chan_add function
Message-ID: <20120222092516.GE24328@aemeltch-MOBL1>
References: <1329821707-11817-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1329821707-11817-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CAA37ikZ6tnfQpqmc8kEXygDbPByC4DmTuQKGw8z+ki=A-83Vow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAA37ikZ6tnfQpqmc8kEXygDbPByC4DmTuQKGw8z+ki=A-83Vow@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

On Tue, Feb 21, 2012 at 03:01:55PM -0200, Ulisses Furquim wrote:
> Hi Andrei,
> 
> On Tue, Feb 21, 2012 at 8:54 AM, Andrei Emeltchenko
> <Andrei.Emeltchenko.news@gmail.com> wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >
> >
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> >  net/bluetooth/l2cap_core.c |    9 +++++++--
> >  1 files changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index c0640b7..0e4f4cb 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -300,7 +300,7 @@ void l2cap_chan_destroy(struct l2cap_chan *chan)
> >        l2cap_chan_put(chan);
> >  }
> >
> > -static void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
> > +void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
> >  {
> >        BT_DBG("conn %p, psm 0x%2.2x, dcid 0x%4.4x", conn,
> >                        chan->psm, chan->dcid);
> > @@ -346,8 +346,13 @@ static void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
> >
> >        l2cap_chan_hold(chan);
> >
> > -       mutex_lock(&conn->chan_lock);
> >        list_add(&chan->list, &conn->chan_l);
> > +}
> > +
> > +void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
> > +{
> > +       mutex_lock(&conn->chan_lock);
> > +       __l2cap_chan_add(conn, chan);
> >        mutex_unlock(&conn->chan_lock);
> >  }
> 
> Same comment applies here. If we don't use the locked version, don't
> bother adding it.

It is used for example in the code below:

   1    470  net/bluetooth/a2mp.c <<open_a2mp_chan>>
             l2cap_chan_add(conn, chan);
   2    917  net/bluetooth/l2cap_core.c <<l2cap_le_conn_ready>>
             l2cap_chan_add(conn, chan);
   3   1258  net/bluetooth/l2cap_core.c <<l2cap_chan_connect>>
             l2cap_chan_add(conn, chan);

Best regards 
Andrei Emeltchenko 

