Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1301697200-2446-8-git-send-email-padovan@profusion.mobi>
References: <1301697200-2446-1-git-send-email-padovan@profusion.mobi>
	<1301697200-2446-2-git-send-email-padovan@profusion.mobi>
	<1301697200-2446-3-git-send-email-padovan@profusion.mobi>
	<1301697200-2446-4-git-send-email-padovan@profusion.mobi>
	<1301697200-2446-5-git-send-email-padovan@profusion.mobi>
	<1301697200-2446-6-git-send-email-padovan@profusion.mobi>
	<1301697200-2446-7-git-send-email-padovan@profusion.mobi>
	<1301697200-2446-8-git-send-email-padovan@profusion.mobi>
Date: Mon, 4 Apr 2011 16:50:13 -0400
Message-ID: <BANLkTinLMLapNTfDD+URnAcb8GZZP4UyXQ@mail.gmail.com>
Subject: Re: [PATCH 07/15] Bluetooth: Move conn_state to struct l2cap_chan
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

(patch too big for me to review properly...)

On Fri, Apr 1, 2011 at 6:33 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
>  static void l2cap_retrans_timeout(unsigned long arg)
>  {
> -       struct sock *sk = (void *) arg;
> +       struct l2cap_chan *chan = (void *) arg;
> +       struct sock *sk = chan->sk;
>
>        BT_DBG("sk %p", sk);
>
> @@ -978,9 +983,9 @@ static void l2cap_retrans_timeout(unsigned long arg)
>        l2cap_pi(sk)->retry_count = 1;
>        __mod_monitor_timer();
>
> -       l2cap_pi(sk)->conn_state |= L2CAP_CONN_WAIT_F;
> +       chan->conn_state |= L2CAP_CONN_WAIT_F;

I suppose the above requires a lock ?

In general it seems that by creating the additional "l2cap_chan"
layer, all lock usages need to be reviewed (IMHO).

>
> -       l2cap_send_rr_or_rnr(l2cap_pi(sk), L2CAP_CTRL_POLL);
> +       l2cap_send_rr_or_rnr(chan, L2CAP_CTRL_POLL);
>        bh_unlock_sock(sk);
>  }
>

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
