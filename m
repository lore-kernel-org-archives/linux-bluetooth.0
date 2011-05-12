Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1305178350-7568-1-git-send-email-padovan@profusion.mobi>
References: <1305178350-7568-1-git-send-email-padovan@profusion.mobi>
Date: Thu, 12 May 2011 11:55:42 -0400
Message-ID: <BANLkTinnOesA2YFfgoi8YuWFa3o+jaADeQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] Bluetooth: Create __l2cap_chan_close()
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Padovan,

On Thu, May 12, 2011 at 1:32 AM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> +void __l2cap_chan_close(struct l2cap_chan *chan, int reason)
> +{
> +       struct l2cap_conn *conn = chan->conn;
> +       struct sock *sk = chan->sk;
> +
> +       BT_DBG("chan %p state %d socket %p", chan, sk->sk_state, sk->sk_socket);
> +
> +       switch (sk->sk_state) {
> +       case BT_LISTEN:
> +               l2cap_chan_cleanup_listen(chan->sk);

Cosmetic: you can use just "sk" above.

> +               break;
> +

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
