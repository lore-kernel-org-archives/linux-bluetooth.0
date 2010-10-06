Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1286390535-27462-7-git-send-email-ville.tervo@nokia.com>
References: <1286390535-27462-1-git-send-email-ville.tervo@nokia.com>
	<1286390535-27462-7-git-send-email-ville.tervo@nokia.com>
Date: Wed, 6 Oct 2010 16:49:14 -0400
Message-ID: <AANLkTinfWn12Tg4Q8GxXr=C+7u4rN0hX9m-BBj_PbTn9@mail.gmail.com>
Subject: Re: [PATCH 6/7] Bluetooth: Add server socket support for LE connection
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Oct 6, 2010 at 2:42 PM, Ville Tervo <ville.tervo@nokia.com> wrote:
>                if (conn->hcon->type == LE_LINK) {
> -                       l2cap_sock_clear_timer(sk);
> -                       sk->sk_state = BT_CONNECTED;
> -                       sk->sk_state_change(sk);
> +                               l2cap_sock_clear_timer(sk);
> +                               sk->sk_state = BT_CONNECTED;
> +                               sk->sk_state_change(sk);
>                }
>
>                if (sk->sk_type != SOCK_SEQPACKET &&

Unrelated indentation above.

> @@ -1029,13 +1077,13 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int al
>        len = min_t(unsigned int, sizeof(la), alen);
>        memcpy(&la, addr, len);
>
> -+      if (la.l2_cid && la.l2_psm)
> +       if (la.l2_cid && la.l2_psm)
>                return -EINVAL;
>
>        lock_sock(sk);
>
>        if ((sk->sk_type == SOCK_SEQPACKET || sk->sk_type == SOCK_STREAM)
> -                       && !(la.l2_psm || la.la_cid)) {
> +                       && !(la.l2_psm || la.l2_cid)) {
>                err = -EINVAL;
>                goto done;
>        }

These typos were introduced in a previous patch. You should fix there instead.

-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
