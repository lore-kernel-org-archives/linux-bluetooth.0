Return-Path: <cyrus@holtmann.org>
Message-id: <1CB3935841BA480496A5362DA4A45798@sisodomain.com>
From: Syam Sidhardhan <s.syam@samsung.com>
To: Syam Sidhardhan <s.syam@samsung.com>,
	linux-bluetooth@vger.kernel.org
Cc: jaganath.k@samsung.com
References: <1343413282-8901-1-git-send-email-s.syam@samsung.com>
Subject: Re: [PATCH] Bluetooth: Use kref for l2cap channel reference counting
Date: Mon, 13 Aug 2012 20:05:51 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

----- Original Message ----- 
From: "Syam Sidhardhan" <s.syam@samsung.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: <jaganath.k@samsung.com>; "Syam Sidhardhan" <s.syam@samsung.com>
Sent: Friday, July 27, 2012 11:51 PM
Subject: [PATCH] Bluetooth: Use kref for l2cap channel reference counting


> This patch changes the struct l2cap_chan and associated code to use
> kref api for object refcounting and freeing.
>
> Suggested-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
> ---
> include/net/bluetooth/l2cap.h |    3 +--
> net/bluetooth/l2cap_core.c    |   15 ++++++++-------
> 2 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index d206296..7ed8e35 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -433,11 +433,10 @@ struct l2cap_chan {
>  struct sock *sk;
>
>  struct l2cap_conn *conn;
> + struct kref kref;
>
>  __u8 state;
>
> - atomic_t refcnt;
> -
>  __le16 psm;
>  __u16 dcid;
>  __u16 scid;
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 6dde7c5..bedc960 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -406,7 +406,7 @@ struct l2cap_chan *l2cap_chan_create(void)
>
>  chan->state = BT_OPEN;
>
> - atomic_set(&chan->refcnt, 1);
> + kref_init(&chan->kref);
>
>  /* This flag is cleared in l2cap_chan_ready() */
>  set_bit(CONF_NOT_COMPLETE, &chan->conf_state);
> @@ -416,8 +416,10 @@ struct l2cap_chan *l2cap_chan_create(void)
>  return chan;
> }
>
> -static void l2cap_chan_destroy(struct l2cap_chan *chan)
> +static void l2cap_chan_destroy(struct kref *kref)
> {
> + struct l2cap_chan *chan = container_of(kref, struct l2cap_chan, kref);
> +
>  BT_DBG("chan %p", chan);
>
>  write_lock(&chan_list_lock);
> @@ -429,17 +431,16 @@ static void l2cap_chan_destroy(struct l2cap_chan 
> *chan)
>
> void l2cap_chan_hold(struct l2cap_chan *c)
> {
> - BT_DBG("chan %p orig refcnt %d", c, atomic_read(&c->refcnt));
> + BT_DBG("chan %p orig refcnt %d", c, atomic_read(&c->kref.refcount));
>
> - atomic_inc(&c->refcnt);
> + kref_get(&c->kref);
> }
>
> void l2cap_chan_put(struct l2cap_chan *c)
> {
> - BT_DBG("chan %p orig refcnt %d", c, atomic_read(&c->refcnt));
> + BT_DBG("chan %p orig refcnt %d", c, atomic_read(&c->kref.refcount));
>
> - if (atomic_dec_and_test(&c->refcnt))
> - l2cap_chan_destroy(c);
> + kref_put(&c->kref, l2cap_chan_destroy);
> }
>
> void l2cap_chan_set_defaults(struct l2cap_chan *chan)
> -- 

ping

Regards,
Syam

