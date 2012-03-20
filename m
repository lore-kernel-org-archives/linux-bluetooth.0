Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1332247868-32396-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1332247868-32396-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Tue, 20 Mar 2012 16:56:11 -0300
Message-ID: <CAA37ikb1wi8F8EZ8FU3wYyq_DDgcWMbePp0tkkkXD=hgpmU5mw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Simplify L2CAP timer logic
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Mar 20, 2012 at 9:51 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Simplify L2CAP timers logic. Previous logic was hard to understand.
> Now we always hold(chan) when setting up timer and put(chan) only
> if work pending and we successfully cancel delayed work.
>
> If delayed work is executing it will put(chan) itself.

The description is a lot better, thanks. However, I don't see why this
change is an improvement. The old code could be hard to read but then
we need probably some comments to clarify it, just that IMHO. If you
are solving a real bug I'd very much like to see an oops with a stack
trace or a very good description or test case.

> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/l2cap.h |   27 ++++++++++++++-------------
>  1 files changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 9b242c6..e4b2fe7 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -621,29 +621,30 @@ static inline void l2cap_chan_unlock(struct l2cap_chan *chan)
>        mutex_unlock(&chan->lock);
>  }
>
> -static inline void l2cap_set_timer(struct l2cap_chan *chan,
> -                                       struct delayed_work *work, long timeout)
> -{
> -       BT_DBG("chan %p state %s timeout %ld", chan,
> -                                       state_to_string(chan->state), timeout);
> -
> -       if (!cancel_delayed_work(work))
> -               l2cap_chan_hold(chan);
> -       schedule_delayed_work(work, timeout);
> -}

Here the old code just checked if we could cancel the delayed work. If
it returns 0 it means the work wasn't pending at all and then we need
to hold(chan). If it was pending somehow we don't need to hold(chan)
once again.

>  static inline bool l2cap_clear_timer(struct l2cap_chan *chan,
> -                                       struct delayed_work *work)
> +                                    struct delayed_work *work)
>  {
>        bool ret;
>
> -       ret = cancel_delayed_work(work);
> +       ret = (delayed_work_pending(work) && cancel_delayed_work(work));
>        if (ret)
>                l2cap_chan_put(chan);
>
>        return ret;
>  }

The semantic here is the same as the old code, if I'm not missing
anything. If we had a pending work and we could cancel it then we
put(chan). Otherwise either the work wasn't pending and we don't need
to put(chan) or the work was running and it'll put(chan) itself later.
Moreover, just like Mat said we might be introducing a race here, we'd
better check that.

> +static inline void l2cap_set_timer(struct l2cap_chan *chan,
> +                                  struct delayed_work *work, long timeout)
> +{
> +       BT_DBG("chan %p state %s timeout %ld", chan,
> +              state_to_string(chan->state), timeout);
> +
> +       l2cap_clear_timer(chan, work);
> +
> +       l2cap_chan_hold(chan);
> +       schedule_delayed_work(work, timeout);
> +}
> +
>  #define __set_chan_timer(c, t) l2cap_set_timer(c, &c->chan_timer, (t))
>  #define __clear_chan_timer(c) l2cap_clear_timer(c, &c->chan_timer)
>  #define __set_retrans_timer(c) l2cap_set_timer(c, &c->retrans_timer, \
> --
> 1.7.9.1

These are just my thoughts but I don't have the final word if we merge
this code or not. I just think we need to discuss more this kind of
change or even document better why we are changing or solving a bug.
In particular, code that is core to the stack needs more discussion
and care as it may impact several things we don't anticipate when
making a change.

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
