Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1278969545-26864-1-git-send-email-gustavo@padovan.org>
References: <1278969545-26864-1-git-send-email-gustavo@padovan.org>
Date: Tue, 13 Jul 2010 14:26:31 -0300
Message-ID: <AANLkTiltwpMN2U3tVry3I-77HDl5-KYsPZHmFqeD58Nl@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: Add Fixed Channels support to bind
	syscall.
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtman.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jul 12, 2010 at 6:19 PM, Gustavo F. Padovan <gustavo@padovan.org> wrote:
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index 449cbdd..39f047b 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -726,7 +726,7 @@ static inline void l2cap_chan_add(struct l2cap_conn *conn, struct sock *sk, stru
>  }
>
>  /* ---- Socket interface ---- */
> -static struct sock *__l2cap_get_sock_by_addr(__le16 psm, bdaddr_t *src)
> +static struct sock *__l2cap_sock_by_psm_addr(__le16 psm, bdaddr_t *src)
>  {
>        struct sock *sk;
>        struct hlist_node *node;
> @@ -738,6 +738,16 @@ found:
>        return sk;
>  }
>
> +static struct sock *__l2cap_sock_by_cid_addr(__le16 cid, bdaddr_t *src)
> +{
> +       struct sock *sk;
> +       struct hlist_node *node;
> +       sk_for_each(sk, node, &l2cap_sk_list.head)
> +               if (l2cap_pi(sk)->scid == cid && !bacmp(&bt_sk(sk)->src, src))
> +                       return sk;
> +       return NULL;
> +}
> +

If sk->sport is always filled with either cid or psm , why not have
just a single "__l2cap_sock_addr"  function ?

Regads,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
