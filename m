Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1327936146-13897-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1327936146-13897-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1327936146-13897-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Mon, 30 Jan 2012 15:18:02 -0200
Message-ID: <CAA37ikZLekboRPQdD-8ABPe9N900zxPks7xT8B8OdN++CHH_EA@mail.gmail.com>
Subject: Re: [RFCv0 2/5] Bluetooth: Add l2cap_chan_lock
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
>
> Channel lock will be used to lock L2CAP channels which are locked
> currently by socket locks.
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/l2cap.h |   11 +++++++++++
>  net/bluetooth/l2cap_core.c    |    2 ++
>  2 files changed, 13 insertions(+), 0 deletions(-)
>
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index e7a8cc7..e81f235 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -497,6 +497,7 @@ struct l2cap_chan {
>
>        void            *data;
>        struct l2cap_ops *ops;
> +       struct mutex            lock;
>  };
>
>  struct l2cap_ops {
> @@ -609,6 +610,16 @@ static inline void l2cap_chan_put(struct l2cap_chan *c)
>                kfree(c);
>  }
>
> +static inline void l2cap_chan_lock(struct l2cap_chan *chan)
> +{
> +       mutex_lock(&chan->lock);
> +}
> +
> +static inline void l2cap_chan_unlock(struct l2cap_chan *chan)
> +{
> +       mutex_unlock(&chan->lock);
> +}
> +
>  static inline void l2cap_set_timer(struct l2cap_chan *chan,
>                                        struct delayed_work *work, long timeout)
>  {
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index f54768e..9a23b19 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -285,6 +285,8 @@ struct l2cap_chan *l2cap_chan_create(struct sock *sk)
>        if (!chan)
>                return NULL;
>
> +       mutex_init(&chan->lock);
> +
>        chan->sk = sk;
>
>        write_lock(&chan_list_lock);

This one looks good to me.

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
