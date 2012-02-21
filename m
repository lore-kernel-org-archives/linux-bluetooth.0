Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1329821707-11817-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1329821707-11817-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1329821707-11817-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Tue, 21 Feb 2012 15:01:55 -0200
Message-ID: <CAA37ikZ6tnfQpqmc8kEXygDbPByC4DmTuQKGw8z+ki=A-83Vow@mail.gmail.com>
Subject: Re: [PATCHv1 06/14] Bluetooth: Add unlocked __l2cap_chan_add function
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
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index c0640b7..0e4f4cb 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -300,7 +300,7 @@ void l2cap_chan_destroy(struct l2cap_chan *chan)
>        l2cap_chan_put(chan);
>  }
>
> -static void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
> +void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
>  {
>        BT_DBG("conn %p, psm 0x%2.2x, dcid 0x%4.4x", conn,
>                        chan->psm, chan->dcid);
> @@ -346,8 +346,13 @@ static void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
>
>        l2cap_chan_hold(chan);
>
> -       mutex_lock(&conn->chan_lock);
>        list_add(&chan->list, &conn->chan_l);
> +}
> +
> +void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
> +{
> +       mutex_lock(&conn->chan_lock);
> +       __l2cap_chan_add(conn, chan);
>        mutex_unlock(&conn->chan_lock);
>  }

Same comment applies here. If we don't use the locked version, don't
bother adding it.

Reviewed-by: Ulisses Furquim <ulisses@profusion.mobi>

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
