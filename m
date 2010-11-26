Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1290784965-4508-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1290784965-4508-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1290784965-4508-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Fri, 26 Nov 2010 12:14:01 -0400
Message-ID: <AANLkTi=_a1omXZdLXg_eEqDD7c0h=f0FgnTnxn1DvGDQ@mail.gmail.com>
Subject: Re: [RFC 1/4] Bluetooth: clean up sco code
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Nov 26, 2010 at 11:22 AM, Emeltchenko Andrei
<Andrei.Emeltchenko.news@gmail.com> wrote:
> @@ -828,13 +831,14 @@ static void sco_chan_del(struct sock *sk, int err)
>
>  static void sco_conn_ready(struct sco_conn *conn)
>  {
> -       struct sock *parent, *sk;
> +       struct sock *parent;
> +       struct sock *sk = conn->sk;

I wonder if there is a problem with accessing conn->sk here outside
the lock protection?

>
>        BT_DBG("conn %p", conn);
>
>        sco_conn_lock(conn);
>
> -       if ((sk = conn->sk)) {
> +       if (sk) {
>                sco_sock_clear_timer(sk);
>                bh_lock_sock(sk);
>                sk->sk_state = BT_CONNECTED;

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
