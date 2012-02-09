Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1328797057-26331-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328797057-26331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1328797057-26331-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Thu, 9 Feb 2012 15:54:56 -0200
Message-ID: <CAA37ikYZFA6-vDX-ub-5jif7wf=7pvvw5S_Vcjwu8OKKu6UMFA@mail.gmail.com>
Subject: Re: [RFCv3 07/16] Bluetooth: Add unlocked __l2cap_chan_add function
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
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index e6515b3..21f9f5d 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -324,7 +324,7 @@ void l2cap_chan_destroy(struct l2cap_chan *chan)
>        l2cap_chan_put(chan);
>  }
>
> -static void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
> +void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
>  {
>        BT_DBG("conn %p, psm 0x%2.2x, dcid 0x%4.4x", conn,
>                        chan->psm, chan->dcid);
> @@ -370,8 +370,13 @@ static void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
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
>
> --
> 1.7.8.3

As far as I see we don't need the locked version of l2cap_chan_add().
What I said in my previous review was to remove the lock and unlock
around the list_add() and add the prefix __ to l2cap_chan_add() then
use it like that. You'll see that all places where you have
l2cap_chan_add() you have already grabbed chan_lock. Ok? Adding the
locked version and not using it afterwards makes no sense at all.
Another thing is that this change to l2cap_chan_add() really belongs
to patch number 2 in your series.

Best regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
