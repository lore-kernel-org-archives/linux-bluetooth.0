Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120220165334.GB28852@joana>
References: <1329747685-4163-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1329747685-4163-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<20120220165334.GB28852@joana>
Date: Mon, 20 Feb 2012 15:57:52 -0300
Message-ID: <CAA37ikZSwSLhDhs69UdDB38RBu3s2F8XmWAUB1vwS7A95xDBtw@mail.gmail.com>
Subject: Re: [RFCv6 02/14] Bluetooth: Revert to mutexes from RCU list
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Mon, Feb 20, 2012 at 3:33 PM, Gustavo Padovan <padovan@profusion.mobi> wrote:
>
> Hi Andrei,
>
> * Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2012-02-20 16:21:13 +0200]:
>
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >
> > Usage of RCU list looks not reasonalbe for a number of reasons:
> > our code sleep and we have to use socket spinlocks, some parts
> > of code are updaters thus we need to use mutexes anyway.
> >
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> >  net/bluetooth/l2cap_core.c |  165 ++++++++++++++++++++++++++------------------
> >  net/bluetooth/l2cap_sock.c |   10 +++
> >  2 files changed, 108 insertions(+), 67 deletions(-)add an extra blank line here please.

<snip>

> > +unlock:
> > +     mutex_unlock(&conn->chan_lock);
> > +
> > +     return err;
> >  }
> >
> >  static inline void set_default_fcs(struct l2cap_chan *chan)
> > @@ -2793,6 +2804,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
> >               return -ENOENT;
> >
> >       sk = chan->sk;
> > +     lock_sock(sk);
> >
> >       if (chan->state != BT_CONFIG && chan->state != BT_CONNECT2) {
> >               struct l2cap_cmd_rej_cid rej;
> > @@ -2905,6 +2917,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
> >               return 0;
> >
> >       sk = chan->sk;
> > +     lock_sock(sk);
> >
> >       switch (result) {
> >       case L2CAP_CONF_SUCCESS:
> > @@ -3006,11 +3019,16 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
> >
> >       BT_DBG("scid 0x%4.4x dcid 0x%4.4x", scid, dcid);
> >
> > -     chan = l2cap_get_chan_by_scid(conn, dcid);
> > -     if (!chan)
> > +     mutex_lock(&conn->chan_lock);
> > +
> > +     chan = __l2cap_get_chan_by_scid(conn, dcid);
> > +     if (!chan) {
> > +             mutex_unlock(&conn->chan_lock);
> >               return 0;
>
> Seems to me we can use l2cap_get_chan_by_scid() here.

It's better if we don't as we'll call l2cap_chan_del() which might
remove chan from conn->chan_l that's protected by conn->chan_lock.
Let's leave it as he sent.

> > +     }
> >
> >       sk = chan->sk;
> > +     lock_sock(sk);
> >
> >       rsp.dcid = cpu_to_le16(chan->scid);
> >       rsp.scid = cpu_to_le16(chan->dcid);
> > @@ -3022,6 +3040,9 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
> >       release_sock(sk);
> >
> >       chan->ops->close(chan->data);
> > +
> > +     mutex_unlock(&conn->chan_lock);
> > +
> >       return 0;
> >  }
> >
> > @@ -3037,16 +3058,24 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn, struct l2cap_cmd
> >
> >       BT_DBG("dcid 0x%4.4x scid 0x%4.4x", dcid, scid);
> >
> > -     chan = l2cap_get_chan_by_scid(conn, scid);
> > -     if (!chan)
> > +     mutex_lock(&conn->chan_lock);
> > +
> > +     chan = __l2cap_get_chan_by_scid(conn, scid);
> > +     if (!chan) {
> > +             mutex_unlock(&conn->chan_lock);
> >               return 0;
>
> Same here.

Same comment above applies here.

Apart from the extra new line that Padovan asked I'm ok with this commit.

Reviewed-by: Ulisses Furquim <ulisses@profusion.mobi>

Regards,

--
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
