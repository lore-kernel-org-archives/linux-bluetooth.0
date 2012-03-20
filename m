Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1331814621-13905-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1331814621-13905-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1331814621-13905-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Tue, 20 Mar 2012 09:21:56 -0300
Message-ID: <CAA37ikYrU460dm9qD+2hYMrdqNO6J=i++EgR8gX9-Rux+SwMhw@mail.gmail.com>
Subject: Re: [RFCv4 06/30] Bluetooth: Timers fixes
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Mar 15, 2012 at 9:29 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
>
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/l2cap.h |   25 +++++++++++++------------
>  1 files changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index d9c668c..1a5c9e6 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -624,29 +624,30 @@ static inline void l2cap_chan_unlock(struct
> l2cap_chan *chan)
>        mutex_unlock(&chan->lock);
>  }
>
> -static inline void l2cap_set_timer(struct l2cap_chan *chan,
> -                                       struct delayed_work *work, long
> timeout)
> -{
> -       BT_DBG("chan %p state %s timeout %ld", chan,
> -                                       state_to_string(chan->state),
> timeout);
> -
> -       if (!cancel_delayed_work(work))
> -               l2cap_chan_hold(chan);
> -       schedule_delayed_work(work, timeout);
> -}
> -
>  static inline bool l2cap_clear_timer(struct l2cap_chan *chan,
>                                        struct delayed_work *work)
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
>
> +static inline void l2cap_set_timer(struct l2cap_chan *chan,
> +                                       struct delayed_work *work, long
> timeout)
> +{
> +       BT_DBG("chan %p state %s timeout %ld", chan,
> +                                       state_to_string(chan->state),
> timeout);
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

What are you fixing here? Care to explain and send an example? This
needs to be clear in the commit message so we don't have more
confusion with timer handling as we had this code for quite some time.

Regards,

--
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
