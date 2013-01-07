Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1356097469-24073-2-git-send-email-s.syam@samsung.com>
References: <1356097469-24073-1-git-send-email-s.syam@samsung.com>
	<1356097469-24073-2-git-send-email-s.syam@samsung.com>
Date: Tue, 8 Jan 2013 02:19:13 +0530
Message-ID: <CAFBvHie-XXKTh0ggsP522YkQ5y1s6wHcoLrxa2SnEL0FxDdyoQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: Fix ACL alive for long in case of non
 pariable devices
From: Syam Sidhardhan <syamsidhardh@gmail.com>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Dec 21, 2012 at 7:14 PM, Syam Sidhardhan <s.syam@samsung.com> wrote:
> For certain devices (ex: HID mouse), support for authentication,
> pairing and bonding is optional. For such devices, the ACL alive
> for too long after the l2cap disconnection.
>
> To avoid keep ACL alive for too long, set the ACL timeout back to
> HCI_DISCONN_TIMEOUT when l2cap is connected.
>
> commit id:a9ea3ed9b71cc3271dd59e76f65748adcaa76422 might have introduce
> this issue.
>
> Signed-off-by: Sang-Ki Park <sangki79.park@samsung.com>
> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
> ---
> I'm not sure whether we need hci_conn_hold() and hci_conn_put() across
> while updating the disc_timeout. In certain other places in the code
> it's done. Ex: hci_auth_complete_evt(), hci_link_key_notify_evt() etc.
> Here I took that as the reference.
>
>  net/bluetooth/l2cap_core.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 82a3bdc..7a544c2 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1360,7 +1360,6 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
>         sk = chan->sk;
>
>         hci_conn_hold(conn->hcon);
> -       conn->hcon->disc_timeout = HCI_DISCONN_TIMEOUT;
>
>         bacpy(&bt_sk(sk)->src, conn->src);
>         bacpy(&bt_sk(sk)->dst, conn->dst);
> @@ -1380,6 +1379,10 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
>
>         BT_DBG("conn %p", conn);
>
> +       hci_conn_hold(conn->hcon);
> +       conn->hcon->disc_timeout = HCI_DISCONN_TIMEOUT;
> +       hci_conn_put(conn->hcon);
> +
>         if (!hcon->out && hcon->type == LE_LINK)
>                 l2cap_le_conn_ready(conn);
>
> --
> 1.7.9.5
>

ping.

Thanks,
Syam.
