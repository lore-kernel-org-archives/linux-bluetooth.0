Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1327500571-29794-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1327500571-29794-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Thu, 26 Jan 2012 01:04:06 -0200
Message-ID: <CAA37ikbfBGGbYfyL1HkL=LGZ4Xyghns699W0eAHKWeuV_7Zw-Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Change chan_ready param from sk to chan
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Jan 25, 2012 at 12:09 PM, Emeltchenko Andrei
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Change is needed to remove dependency on sk when possible
> before introducing l2cap channel lock.

What's the overall idea? We used to rely on sk lock for mutual
exclusion, right? (please correct me if I'm wrong) I'm seeing some
patches from you to change from sk to chan but introducing another
lock might shake things a bit so that's why I'm asking for the big
picture, if you have thought this through already.

Thanks,

-- Ulisses

> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 69e8490..c330cdc 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -907,9 +907,9 @@ clean:
>        release_sock(parent);
>  }
>
> -static void l2cap_chan_ready(struct sock *sk)
> +static void l2cap_chan_ready(struct l2cap_chan *chan)
>  {
> -       struct l2cap_chan *chan = l2cap_pi(sk)->chan;
> +       struct sock *sk = chan->sk;
>        struct sock *parent = bt_sk(sk)->parent;
>
>        BT_DBG("sk %p, parent %p", sk, parent);
> @@ -945,7 +945,7 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
>
>                if (conn->hcon->type == LE_LINK) {
>                        if (smp_conn_security(conn, chan->sec_level))
> -                               l2cap_chan_ready(sk);
> +                               l2cap_chan_ready(chan);
>
>                } else if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
>                        __clear_chan_timer(chan);
> @@ -2874,7 +2874,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
>                if (chan->mode == L2CAP_MODE_ERTM)
>                        l2cap_ertm_init(chan);
>
> -               l2cap_chan_ready(sk);
> +               l2cap_chan_ready(chan);
>                goto unlock;
>        }
>
> @@ -3005,7 +3005,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
>                if (chan->mode ==  L2CAP_MODE_ERTM)
>                        l2cap_ertm_init(chan);
>
> -               l2cap_chan_ready(sk);
> +               l2cap_chan_ready(chan);
>        }
>
>  done:
> @@ -4524,7 +4524,7 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
>                if (chan->scid == L2CAP_CID_LE_DATA) {
>                        if (!status && encrypt) {
>                                chan->sec_level = hcon->sec_level;
> -                               l2cap_chan_ready(sk);
> +                               l2cap_chan_ready(chan);
>                        }
>
>                        bh_unlock_sock(sk);
> --
> 1.7.4.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
