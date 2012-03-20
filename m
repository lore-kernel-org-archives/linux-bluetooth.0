Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1331814621-13905-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1331814621-13905-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1331814621-13905-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Tue, 20 Mar 2012 09:22:46 -0300
Message-ID: <CAA37ikb7ayXRER=JRZqA+gyj56-L1SA1g8FoOsdSEuLHcykcbg@mail.gmail.com>
Subject: Re: [RFCv4 05/30] Bluetooth: Lock sk only if exist
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Mar 15, 2012 at 9:29 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 779f819..e8855cc 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -212,9 +212,13 @@ static inline void l2cap_state_change(struct l2cap_chan *chan, int state, int er
>  {
>        struct sock *sk = chan->sk;
>
> -       lock_sock(sk);
> +       if (sk)
> +               lock_sock(sk);
> +
>        __l2cap_state_change(chan, state, err);
> -       release_sock(sk);
> +
> +       if (sk)
> +               release_sock(sk);
>  }
>
>  void __l2cap_chan_set_err(struct l2cap_chan *chan, int err)
> --
> 1.7.9.1

Well, this doesn't look good, does it? Wouldn't make sense to call
__l2cap_state_change() where we know sk doesn't exist and
l2cap_state_change() in the others? After all the separation between
chan and sk is something we need to have as much clear as possible
from now on, right?

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
