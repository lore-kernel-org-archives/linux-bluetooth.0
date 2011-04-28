Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Apr 2011 02:13:02 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Bluetooth: Remove l2cap_sk_list
Message-ID: <20110428051302.GD2214@joana>
References: <1303940957-22694-1-git-send-email-padovan@profusion.mobi>
 <1303940957-22694-2-git-send-email-padovan@profusion.mobi>
 <1303940957-22694-3-git-send-email-padovan@profusion.mobi>
 <BANLkTimYW2ZweS5GSnVQ6nn_WTs9+b0RcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <BANLkTimYW2ZweS5GSnVQ6nn_WTs9+b0RcA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Anderson Lizardo <anderson.lizardo@openbossa.org> [2011-04-27 19:19:35 -0400]:

> Hi Gustavo,
> 
> On Wed, Apr 27, 2011 at 5:49 PM, Gustavo F. Padovan
> <padovan@profusion.mobi> wrote:
> > @@ -883,33 +891,34 @@ static inline void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *ch
> >  /* Find socket with psm and source bdaddr.
> >  * Returns closest match.
> >  */
> > -static struct sock *l2cap_get_sock_by_psm(int state, __le16 psm, bdaddr_t *src)
> > +static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm, bdaddr_t *src)
> >  {
> > -       struct sock *sk = NULL, *sk1 = NULL;
> > -       struct hlist_node *node;
> > +       struct l2cap_chan *c, *c1 = NULL;
> >
> > -       read_lock(&l2cap_sk_list.lock);
> > +       read_lock(&chan_list_lock);
> >
> > -       sk_for_each(sk, node, &l2cap_sk_list.head) {
> > -               struct l2cap_chan *chan = l2cap_pi(sk)->chan;
> > +       list_for_each_entry(c, &chan_list, global_l) {
> > +               struct sock *sk = c->sk;
> >
> >                if (state && sk->sk_state != state)
> >                        continue;
> >
> > -               if (chan->psm == psm) {
> > +               if (c->psm == psm) {
> >                        /* Exact match. */
> > -                       if (!bacmp(&bt_sk(sk)->src, src))
> > -                               break;
> > +                       if (!bacmp(&bt_sk(sk)->src, src)) {
> > +                               read_unlock_bh(&chan_list_lock);
> > +                               return c;
> 
> What about this instead of the above:
> 
> c1 = c;
> break;
> 
> This avoids a duplicated read_unlock_bh() and keeps a single exit
> point for the function.

I still prefer my version. ;)

-- 
Gustavo F. Padovan
http://profusion.mobi
