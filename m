Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1328792777-25914-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328792777-25914-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Fri, 10 Feb 2012 16:33:51 -0200
Message-ID: <CAA37ikbgSAYWuft+Yu=+PfBirsnHWidkqQemWTCJ3Y8hoz92Jg@mail.gmail.com>
Subject: Re: [RFCv0] Bluetooth: Remove extra chan_put
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Feb 9, 2012 at 11:06 AM, Emeltchenko Andrei
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Removing l2cap_chan_put since in this function we use l2cap_chan_close
> and ops->close which use l2cap_chan_put.
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
> I am not sure that I have checked all possible cases, so I am sending
> this as RFC.
>
>  net/bluetooth/l2cap_core.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index f1a6b3c..7db6d7f 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -274,7 +274,6 @@ static void l2cap_chan_timeout(struct work_struct *work)
>        release_sock(sk);
>
>        chan->ops->close(chan->data);
> -       l2cap_chan_put(chan);
>  }
>
>  struct l2cap_chan *l2cap_chan_create(struct sock *sk)
> --
> 1.7.8.3

While I think you maybe right, please add BT_DBG() to l2cap_chan_hold
and l2cap_chan_put and check that. If so, put that information also in
your patch, please.

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
