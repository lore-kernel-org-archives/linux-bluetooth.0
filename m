Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 May 2012 11:18:23 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org, mathewm@codeaurora.org
Subject: Re: [RFC] Bluetooth: Adds unlink to chan ops
Message-ID: <20120524081821.GD24715@aemeltch-MOBL1>
References: <1337760349-301-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120523203120.GA21117@joana>
 <CAA37ikaPnF3h_D9DPV3+u6qH93e1MY6zoWDuuqesJjcaeCBi0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAA37ikaPnF3h_D9DPV3+u6qH93e1MY6zoWDuuqesJjcaeCBi0w@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo and Ulisses,

On Wed, May 23, 2012 at 07:03:21PM -0300, Ulisses Furquim wrote:
> Hi Gustavo,
> 
> On Wed, May 23, 2012 at 5:31 PM, Gustavo Padovan <gustavo@padovan.org> wrote:
> > Hi Andrei,
> >
> > * Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-05-23 11:05:49 +0300]:
> >
> >> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >>
> >> This helps to separate socket and socketless code. Now socket related
> >> operations moved to l2cap_sock in unlink callback for channels with sk.
> >>
> >> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >> Reported-by: Mat Martineau <mathewm@codeaurora.org>
> >> ---
> >>  include/net/bluetooth/l2cap.h |    1 +
> >>  net/bluetooth/l2cap_core.c    |   20 ++------------------
> >>  net/bluetooth/l2cap_sock.c    |   25 +++++++++++++++++++++++++
> >>  3 files changed, 28 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> >> index 69ef077..7ed13e7 100644
> >> --- a/include/net/bluetooth/l2cap.h
> >> +++ b/include/net/bluetooth/l2cap.h
> >> @@ -532,6 +532,7 @@ struct l2cap_ops {
> >>       void                    (*state_change) (void *data, int state);
> >>       struct sk_buff          *(*alloc_skb) (struct l2cap_chan *chan,
> >>                                              unsigned long len, int nb);
> >> +     void                    (*unlink) (struct l2cap_chan *chan, int err);
> >>  };
> >>
> >>  struct l2cap_conn {
> >> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> >> index c64da38..d2b16b5 100644
> >> --- a/net/bluetooth/l2cap_core.c
> >> +++ b/net/bluetooth/l2cap_core.c
> >> @@ -520,9 +520,7 @@ void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
> >>
> >>  static void l2cap_chan_del(struct l2cap_chan *chan, int err)
> >>  {
> >> -     struct sock *sk = chan->sk;
> >>       struct l2cap_conn *conn = chan->conn;
> >> -     struct sock *parent;
> >>
> >>       __clear_chan_timer(chan);
> >>
> >> @@ -541,22 +539,8 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
> >>       if (chan->chan_type == L2CAP_CHAN_CONN_FIX_A2MP)
> >>               goto clean;
> >>
> >> -     lock_sock(sk);
> >> -
> >> -     __l2cap_state_change(chan, BT_CLOSED);
> >> -     sock_set_flag(sk, SOCK_ZAPPED);
> >> -
> >> -     if (err)
> >> -             __l2cap_chan_set_err(chan, err);
> >> -
> >> -     parent = bt_sk(sk)->parent;
> >> -     if (parent) {
> >> -             bt_accept_unlink(sk);
> >> -             parent->sk_data_ready(parent, 0);
> >> -     } else
> >> -             sk->sk_state_change(sk);
> >> -
> >> -     release_sock(sk);
> >> +     if (chan->ops->unlink)
> >> +             chan->ops->unlink(chan, err);
> >>
> >>       if (test_bit(CONF_NOT_COMPLETE, &chan->conf_state))
> >>               return;
> >> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> >> index 3bb1611..d6f481b 100644
> >> --- a/net/bluetooth/l2cap_sock.c
> >> +++ b/net/bluetooth/l2cap_sock.c
> >> @@ -955,6 +955,30 @@ static struct sk_buff *l2cap_sock_alloc_skb_cb(struct l2cap_chan *chan,
> >>       return skb;
> >>  }
> >>
> >> +static void l2cap_sock_unlink_cb(struct l2cap_chan *chan, int err)
> >> +{
> >> +     struct sock *sk = chan->sk;
> >> +     struct sock *parent = bt_sk(sk)->parent;
> >> +
> >> +     lock_sock(sk);
> >> +
> >> +     chan->state = BT_CLOSED;
> >> +     sk->sk_state = BT_CLOSED;
> >> +     sock_set_flag(sk, SOCK_ZAPPED);
> >
> > I think we can improve this code and call it everytime we need to set
> > SOCK_ZAPPED. We just need a bit more of logic here.
> 
> We might, if it's not a big of a change. Otherwise I think this kind
> of change needs to be incremental.

I agree with Ulisses that it shall be incremental since it is not
straightforward. I am thinking that  sock_set_flag(sk, SOCK_ZAPPED) might
be put before switch in l2cap_chan_close and maybe further. Then we need
to think about how to make it working for socketless chans...

Best regards 
Andrei Emeltchenko 

