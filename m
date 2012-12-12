Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1355285624-25811-5-git-send-email-gustavo@padovan.org>
References: <1355285624-25811-1-git-send-email-gustavo@padovan.org>
	<1355285624-25811-5-git-send-email-gustavo@padovan.org>
Date: Wed, 12 Dec 2012 09:40:06 -0400
Message-ID: <CAJdJm_PMBC8nivsJuYDp-wW5ei1WF7m3SJzh78RScUyQu5ApJQ@mail.gmail.com>
Subject: Re: [RFC 04/16] Bluetooth: add l2cap_state_change_and_error()
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, Dec 12, 2012 at 12:13 AM, Gustavo Padovan <gustavo@padovan.org> wrote:
> @@ -238,7 +244,7 @@ static inline void l2cap_chan_set_err(struct l2cap_chan *chan, int err)
>         struct sock *sk = chan->sk;
>
>         lock_sock(sk);
> -       __l2cap_chan_set_err(chan, err);
> +       chan->ops->state_change(chan, chan->state, 0);

Why "0" and not "err" ?

>         release_sock(sk);
>  }
>

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
