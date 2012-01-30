Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1327936146-13897-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1327936146-13897-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1327936146-13897-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Mon, 30 Jan 2012 15:25:38 -0200
Message-ID: <CAA37ikYB3DsumfGOyz+SjAtO1mhOJ-kZPaANv7Lf=4JoGGrKjg@mail.gmail.com>
Subject: Re: [RFCv0 3/5] Bluetooth: Helper functions for locking change
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Jan 30, 2012 at 1:09 PM, Emeltchenko Andrei
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

No commit message? In my opinion all commits should have a commit
message and even more in this patch set that deals with locking in
L2CAP core.

> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   23 ++++++++++++++++++++++-
>  1 files changed, 22 insertions(+), 1 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 9a23b19..a7e5a55 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -241,7 +241,7 @@ static char *state_to_string(int state)
>        return "invalid state";
>  }
>
> -static void l2cap_state_change(struct l2cap_chan *chan, int state)
> +static void __l2cap_state_change(struct l2cap_chan *chan, int state)
>  {
>        BT_DBG("%p %s -> %s", chan, state_to_string(chan->state),
>                                                state_to_string(state));
> @@ -250,6 +250,27 @@ static void l2cap_state_change(struct l2cap_chan *chan, int state)
>        chan->ops->state_change(chan->data, state);
>  }
>
> +static void l2cap_state_change(struct l2cap_chan *chan, int state)
> +{
> +       lock_sock(chan->sk);
> +       __l2cap_state_change(chan, state);
> +       release_sock(chan->sk);
> +}

Introducing this change now before the others in patch 5 will actually
change how l2cap_state_change works. Won't that cause any problems?

> +static inline void __l2cap_set_sock_err(struct sock *sk, int err)
> +{
> +       sk->sk_err = err;
> +}
> +
> +static inline void l2cap_set_sock_err(struct l2cap_chan *chan, int err)
> +{
> +       struct sock *sk = chan->sk;
> +
> +       lock_sock(sk);
> +       __l2cap_set_sock_err(sk, err);
> +       release_sock(sk);
> +}

This helper is different because it didn't exist before so I can say
we shall have no problems with it.

>  static void l2cap_chan_timeout(struct work_struct *work)
>  {
>        struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
> --
> 1.7.4.1

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
