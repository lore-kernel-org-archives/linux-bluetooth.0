Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1328797057-26331-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328797057-26331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1328797057-26331-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Thu, 9 Feb 2012 16:33:58 -0200
Message-ID: <CAA37ikYz2gBS+ZO7cRbin4NmdWFHNNZCV6zizxUNREHJC8vNdA@mail.gmail.com>
Subject: Re: [RFCv3 03/16] Bluetooth: Do not use sk lock in get_chan functions
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Feb 9, 2012 at 12:17 PM, Emeltchenko Andrei
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> When needed we take explicit lock.
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index ae08944..dcf4792 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -105,9 +105,8 @@ static struct l2cap_chan *l2cap_get_chan_by_scid(struct l2cap_conn *conn, u16 ci
>
>        mutex_lock(&conn->chan_lock);
>        c = __l2cap_get_chan_by_scid(conn, cid);
> -       if (c)
> -               lock_sock(c->sk);
>        mutex_unlock(&conn->chan_lock);
> +
>        return c;
>  }
>
> @@ -128,9 +127,8 @@ static inline struct l2cap_chan *l2cap_get_chan_by_ident(struct l2cap_conn *conn
>
>        mutex_lock(&conn->chan_lock);
>        c = __l2cap_get_chan_by_ident(conn, ident);
> -       if (c)
> -               lock_sock(c->sk);
>        mutex_unlock(&conn->chan_lock);
> +
>        return c;
>  }
>
> --
> 1.7.8.3

This isn't what I said, maybe I wasn't clear enough, sorry. I said to
change the usage from the locked versions to unlocked ones and in the
same patch add the explicit locking of chan_lock. This will be better
to read and maintain specially since we're adding more locks in all
these paths now. Then later if we don't use the locked versions
anymore we can just remove them. Ok?

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
