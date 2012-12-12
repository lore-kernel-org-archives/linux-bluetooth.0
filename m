Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1355285624-25811-4-git-send-email-gustavo@padovan.org>
References: <1355285624-25811-1-git-send-email-gustavo@padovan.org>
	<1355285624-25811-4-git-send-email-gustavo@padovan.org>
Date: Wed, 12 Dec 2012 09:25:37 -0400
Message-ID: <CAJdJm_O=vhQ3fBDtbUS_UZ2uKATEBZjZ1LQfzQYyz2koMjv+pg@mail.gmail.com>
Subject: Re: [RFC 03/16] Bluetooth: extend state_change() call to report
 errors too
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Padovan,

On Wed, Dec 12, 2012 at 12:13 AM, Gustavo Padovan <gustavo@padovan.org> wrote:
> @@ -230,9 +230,7 @@ static void l2cap_state_change(struct l2cap_chan *chan, int state)
>
>  static inline void __l2cap_chan_set_err(struct l2cap_chan *chan, int err)
>  {
> -       struct sock *sk = chan->sk;
> -
> -       sk->sk_err = err;
> +       chan->ops->state_change(chan, chan->state, 0);

Shouldn't it be "chan->ops->state_change(chan, chan->state, err);" here?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
