Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1329821707-11817-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1329821707-11817-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1329821707-11817-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Tue, 21 Feb 2012 14:57:40 -0200
Message-ID: <CAA37ika4n-LMri4Nu5cko735RpPn0xjTmOLw6mXKCShg6FExhA@mail.gmail.com>
Subject: Re: [PATCHv1 05/14] Bluetooth: Add socket error function
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Feb 21, 2012 at 8:54 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Use locked and unlocked versions to help removing socket
> locks from l2cap core functions.
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   30 +++++++++++++++++++++---------
>  1 files changed, 21 insertions(+), 9 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 4638dbb..c0640b7 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -217,6 +217,22 @@ static void l2cap_state_change(struct l2cap_chan *chan, int state)
>        release_sock(sk);
>  }
>
> +static inline void __l2cap_chan_set_err(struct l2cap_chan *chan, int err)
> +{
> +       struct sock *sk = chan->sk;
> +
> +       sk->sk_err = err;
> +}
> +
> +static inline void l2cap_chan_set_err(struct l2cap_chan *chan, int err)
> +{
> +       struct sock *sk = chan->sk;
> +
> +       lock_sock(sk);
> +       __l2cap_chan_set_err(chan, err);
> +       release_sock(sk);
> +}
> +

I don't remember now, but if we don't even use the locked version,
please remove it. Overall it looks good.

Reviewed-by: Ulisses Furquim <ulisses@profusion.mobi>

<snip>

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
