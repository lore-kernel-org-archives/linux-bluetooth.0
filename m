Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120222132153.GH24328@aemeltch-MOBL1>
References: <1329907389-31173-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<CAA37ikarEd1wVZZoxH_Cy=jJfQ9is-cY+9y0U7eMWZH+1qxQsg@mail.gmail.com>
	<20120222132153.GH24328@aemeltch-MOBL1>
Date: Wed, 22 Feb 2012 11:53:05 -0200
Message-ID: <CAA37ika=CUtJh=VY4mYmDRQgo4nGf2dL6wJLg9rN+ndbjfLY=w@mail.gmail.com>
Subject: Re: [PATCHv2 0/3] Bluetooth: Change socket lock to l2cap_chan lock
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	Ulisses Furquim <ulisses@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Feb 22, 2012 at 11:21 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> Hi Ulisses,
>
> On Wed, Feb 22, 2012 at 10:30:40AM -0200, Ulisses Furquim wrote:
>> Hi Andrei,
>>
>> On Wed, Feb 22, 2012 at 8:43 AM, Andrei Emeltchenko
>> <Andrei.Emeltchenko.news@gmail.com> wrote:
>> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>> >
>> > Changing socket lock to L2CAP chan lock in L2CAP code. Needed for implementing
>> > protocols above L2CAP without creating sockets.
>> >
>> > Changes:
>> >        * PATCHv2: Rebase remaining parts against latest tree and merge all
>> >        patches dealing with converting sk lock to chan lock together following
>> >        recommendation from Ulisses and Gustavo.
>> >        * PATCHv1: Added extra line (per Gustavo comment)
>> >        * RFCv6: Same code but patches 2,3 and 4 from RFCv5 are merged together
>> >        following recommendations from review.
>> >        * RFCv5: Fixed locking bug in l2cap_data_channel, added locks in
>> >        l2cap_sock_shutdown function, fixed several styles issues.
>> >        * RFCv4: Better split patches so they looks more clear and obvious,
>> >        taking coments about naming change and delete unused vars. See diff change
>> >        from the previous version below:
>> >        * RFCv3: Split the big patch to several small (I believe logical) chunks,
>> >        remove unneded locks from cleanup_listen, use the same arguments for
>> >        locked/unlocked socket error functions.
>> >        * RFCv2: Convert l2cap channel list back to mutex from RCU list.
>> >
>> > Andrei Emeltchenko (3):
>> >  Bluetooth: Add unlocked __l2cap_chan_add function
>> >  Bluetooth: Change sk lock to chan lock in L2CAP core
>> >  Bluetooth: Remove socket lock check
>> >
>> >  net/bluetooth/l2cap_core.c |  173 +++++++++++++++++++++++++++-----------------
>> >  net/bluetooth/l2cap_sock.c |   28 +++++--
>> >  2 files changed, 125 insertions(+), 76 deletions(-)
>>
>> I'm mostly ok with the patches. However, have you seen my questions on
>> reply to PATCHv1 08/14? Please, check that. Thanks.
>
> Sorry missed those comments.
>
> In a case of:
> <------8<---------------------------------------------------------------------
> |  > @@ -440,10 +444,12 @@ void l2cap_chan_close(struct l2cap_chan *chan, int
> |  > reason)
> |  >
> |  >        switch (chan->state) {
> |  >        case BT_LISTEN:
> |  > +               lock_sock(sk);
> |  >                l2cap_chan_cleanup_listen(sk);
> |  >
> |  >                __l2cap_state_change(chan, BT_CLOSED);
> |  >                sock_set_flag(sk, SOCK_ZAPPED);
> |  > +               release_sock(sk);
> |  >                break;
> |  >
> |  >        case BT_CONNECTED:
> |
> |  Do we need to lock sock around l2cap_chan_cleanup_listen() as well?
> |  l2cap_chan_close() will call l2cap_chan_del() which now does
> |  lock_sock/release_sock, right?
> <------8<---------------------------------------------------------------------
>
> Those are different socks. We take parent sk lock here.

Hmm, ok, I missed that.

> concerning:
>
> <------8<------------------------------------------------------------------
> |  > @@ -714,6 +722,7 @@ static inline int l2cap_mode_supported(__u8 mode,
> |  > __u32 feat_mask)
> |  >
> |  >  static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct
> |  >  l2cap_chan *chan, int err)
> |  >  {
> |  > +       struct sock *sk = chan->sk;
> |  >        struct l2cap_disconn_req req;
> |  >
> |  >        if (!conn)
> |  > @@ -730,8 +739,10 @@ static void l2cap_send_disconn_req(struct
> |  > l2cap_conn *conn, struct l2cap_chan *c
> |  >        l2cap_send_cmd(conn, l2cap_get_ident(conn),
> |  >                        L2CAP_DISCONN_REQ, sizeof(req), &req);
> |  >
> |  > +       lock_sock(sk);
> |  >        __l2cap_state_change(chan, BT_DISCONN);
> |  >        __l2cap_chan_set_err(chan, err);
> |  > +       release_sock(sk);
> |  >  }
> |  >
> |  >  /* ---- L2CAP connections ---- */
> |
> |  It seems we didn't have any locking around these before. Why? Do we
> |  really need it now?
> <------8<------------------------------------------------------------------
>
> The locks were in the functions invoking l2cap_send_disconn_req.

Ok.

> Otherwise would following changes be OK?

Sure, I'm ok with them if you only squashed them and added these tiny
changes below.

Reviewed-by: Ulisses Furquim <ulisses@profusion.mobi>

Regards,

-- Ulisses

> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 60d3276..56a85c0 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -363,8 +363,6 @@ void l2cap_chan_add(struct l2cap_conn *conn, struct
> l2cap_chan *chan)
>        mutex_unlock(&conn->chan_lock);
>  }
>
> -/* Delete channel.
> - * Must be called on the locked socket. */
>  static void l2cap_chan_del(struct l2cap_chan *chan, int err)
>  {
>        struct sock *sk = chan->sk;
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index ae15d7a..efe391e 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -812,6 +812,7 @@ static int l2cap_sock_shutdown(struct socket *sock,
> int how)
>
>        if (conn)
>                mutex_lock(&conn->chan_lock);
> +
>        l2cap_chan_lock(chan);
>        lock_sock(sk);
>
> @@ -835,6 +836,7 @@ static int l2cap_sock_shutdown(struct socket *sock,
> int how)
>
>        release_sock(sk);
>        l2cap_chan_unlock(chan);
> +
>        if (conn)
>                mutex_unlock(&conn->chan_lock);
>
>
> Best regards
> Andrei Emeltchenko

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
